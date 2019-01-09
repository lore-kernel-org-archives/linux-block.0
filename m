Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B7DC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CCE20859
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 12:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfAIMQl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 07:16:41 -0500
Received: from verein.lst.de ([213.95.11.211]:41192 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfAIMQl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Jan 2019 07:16:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2404367358; Wed,  9 Jan 2019 13:16:39 +0100 (CET)
Date:   Wed, 9 Jan 2019 13:16:39 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Subject: Re: [PATCH 13/16] io_uring: add support for pre-mapped user IO
 buffers
Message-ID: <20190109121638.GE13779@lst.de>
References: <20190108165645.19311-1-axboe@kernel.dk> <20190108165645.19311-14-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-14-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int io_setup_rw(int rw, struct io_kiocb *kiocb,
> +		       const struct io_uring_iocb *iocb, struct iovec **iovec,
> +		       struct iov_iter *iter, bool kaddr)
>  {
>  	void __user *buf = (void __user *)(uintptr_t)iocb->addr;
>  	size_t ret;
>  
> -	ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
> +	if (!kaddr) {
> +		ret = import_single_range(rw, buf, iocb->len, *iovec, iter);
> +	} else {
> +		struct io_ring_ctx *ctx = kiocb->ki_ctx;
> +		struct io_mapped_ubuf *imu;
> +		size_t len = iocb->len;
> +		size_t offset;
> +		int index;
> +
> +		/* __io_submit_one() already validated the index */
> +		index = array_index_nospec(kiocb->ki_index,
> +						ctx->max_reqs);
> +		imu = &ctx->user_bufs[index];
> +		if ((unsigned long) iocb->addr < imu->ubuf ||
> +		    (unsigned long) iocb->addr + len > imu->ubuf + imu->len) {
> +			ret = -EFAULT;
> +			goto err;
> +		}
> +
> +		/*
> +		 * May not be a start of buffer, set size appropriately
> +		 * and advance us to the beginning.
> +		 */
> +		offset = (unsigned long) iocb->addr - imu->ubuf;
> +		iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs,
> +				offset + len);
> +		if (offset)
> +			iov_iter_advance(iter, offset);
> +		ret = 0;
> +

Please split this code in a separate helper.

>  	if (unlikely(!file->f_op->read_iter))
>  		goto out_fput;
>  
> -	ret = io_setup_rw(READ, iocb, &iovec, &iter);
> +	ret = io_setup_rw(READ, kiocb, iocb, &iovec, &iter, kaddr);

And I'd personally just call that helper here based on the opcode and
avoid magic bool arguments.

> +		down_write(&current->mm->mmap_sem);
> +		pret = get_user_pages(ubuf, nr_pages, 1, pages, NULL);
> +		up_write(&current->mm->mmap_sem);

This needs to be get_user_pages_longterm.

> +	 * We don't use the iovecs without fixed buffers being asked for.
> +	 * Error out if they don't match.
> +	 */
> +	if (!(p->flags & IORING_SETUP_FIXEDBUFS) && iovecs)
> +		return -EINVAL;

I don't think we need the IORING_SETUP_FIXEDBUFS flag at all, as a
non-zero iovecs pointer is enough of an indication.
