Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B794EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9791D61029
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJYHgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:36:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A57BC061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NzdNytW9iqcv2Sj2Afil631Tx8GEChhefrrKZPDSgjc=; b=j7DUKrRvDM8CSjV7umm65EJ5NP
        Kjos+aqMy0W5H8b33Q52EuLWB4a5HolMI4Vcl4YAJwpkJGpcgGbh19tQKepUInLwF39W9p6r63cv0
        6gEMSV39SLwZdwb3iMkR5GkyEGYQGQhcp5T0TBB8OiFeK1p7gGoR1RvCV8xLaipHurq4aytsqBqVq
        0DIPCGstaaAQZRCneAe7aFqZUGGiTqmJP7rN9jPewZCuAz1fCayhvhQJPhkbHgwnrFEAvfj1qqCLB
        Hnd7rS5Vgm8gEo7XhTnf+LBoLyeNwDvfn9soCqBDZfFwwUiHzWp1viMAAJR4L4BJMFJysTfhOan+Q
        k2DPKMLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meuUO-00Fds9-HZ; Mon, 25 Oct 2021 07:33:48 +0000
Date:   Mon, 25 Oct 2021 00:33:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/5] block: avoid extra iter advance with async iocb
Message-ID: <YXZd3ETk4P+OBWXD@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <aee615ac9cd6804c10c14938d011e0913f751960.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee615ac9cd6804c10c14938d011e0913f751960.1635006010.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 23, 2021 at 05:21:34PM +0100, Pavel Begunkov wrote:
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -352,11 +352,21 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  	bio->bi_end_io = blkdev_bio_end_io_async;
>  	bio->bi_ioprio = iocb->ki_ioprio;
>  
> -	ret = bio_iov_iter_get_pages(bio, iter);
> -	if (unlikely(ret)) {
> -		bio->bi_status = BLK_STS_IOERR;
> -		bio_endio(bio);
> -		return ret;
> +	if (!iov_iter_is_bvec(iter)) {
> +		ret = bio_iov_iter_get_pages(bio, iter);
> +		if (unlikely(ret)) {
> +			bio->bi_status = BLK_STS_IOERR;
> +			bio_endio(bio);
> +			return ret;
> +		}

Nit: I generally find it much nicer to read if simple if statements
don't use pointless negations.

> +	} else {
> +		/*
> +		 * Users don't rely on the iterator being in any particular
> +		 * state for async I/O returning -EIOCBQUEUED, hence we can
> +		 * avoid expensive iov_iter_advance(). Bypass
> +		 * bio_iov_iter_get_pages() and set the bvec directly.
> +		 */
> +		bio_iov_bvec_set(bio, iter);

So if this optimization is so useful, please also do it for
non-bvec iov_iters, which is what 99% of the applications actually
use.

