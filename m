Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FBC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AB261212
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 06:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJTGit (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 02:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGis (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:38:48 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C97DC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4fULMQm5oBsNFYsbMgwATKhitqWphk4ZiI8Z8spfLk8=; b=QvXnQO2nkO303EjTHrPil4/KrF
        SlDklO7CHYbS8YecFLLEJUXHJmnkkzMa0370emgGfW8qQSMRil03Uk5iNpYaS4qHkmQUuvG2WWlE/
        taZAWDnXCnofECsQQHCB/BCvcbVc/M2wx3UzEn/8I8P3EJ26xj6FOTj0bePDqnEgwVDpJLY0vvXsg
        PG1WHjjG6moLgp6y2u2YgxNjs8PtNvVtihDZL/NLxhlCiWx1RM0FsQOKTNV6Dca4gi2cobdRtrhGN
        gk91eb6XqnWzGAMUuOQjKzxvGdKzqmLibWNCBY3DqnSkbVgsUVYXBxaZ9byHwalqnW1sqns973Mjv
        HRNnJg3g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md5DG-003U4D-27; Wed, 20 Oct 2021 06:36:34 +0000
Date:   Tue, 19 Oct 2021 23:36:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/16] block: add single bio async direct IO helper
Message-ID: <YW+48urtsamKhEpz@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <c8d2d919894fd0112f21723a9cb50b6c7cbd9613.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d2d919894fd0112f21723a9cb50b6c7cbd9613.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:21PM +0100, Pavel Begunkov wrote:
> +	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
> +	dio = container_of(bio, struct blkdev_dio, bio);
> +	__bio_set_dev(bio, bdev);
> +	bio->bi_iter.bi_sector = pos >> 9;

SECTOR_SHIFT.

> +	bio->bi_write_hint = iocb->ki_hint;
> +	bio->bi_end_io = blkdev_bio_end_io_async;
> +	bio->bi_ioprio = iocb->ki_ioprio;
> +	dio->flags = 0;
> +	dio->iocb = iocb;
> +
> +	ret = bio_iov_iter_get_pages(bio, iter);
> +	if (unlikely(ret)) {
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +		return BLK_STS_IOERR;

This function does not return a blk_status_t, so this is wrong (and
sparse should have complained).  I also don't think the error path
here should go hrough the bio for error handling but just do a put and
return the error.

> +	if (iov_iter_rw(iter) == READ) {
> +		bio->bi_opf = REQ_OP_READ;
> +		if (iter_is_iovec(iter)) {
> +			dio->flags |= DIO_SHOULD_DIRTY;
> +			bio_set_pages_dirty(bio);
> +		}
> +	} else {
> +		bio->bi_opf = dio_bio_write_op(iocb);
> +		task_io_account_write(bio->bi_iter.bi_size);
> +	}
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		bio->bi_opf |= REQ_NOWAIT;

This code is entirely duplicated, pleae move it into an (inline) helper.

> +	/*
> +	 * Don't plug for HIPRI/polled IO, as those should go straight
> +	 * to issue
> +	 */

This comment seems misplaced as the function does not use plugging at
all.


