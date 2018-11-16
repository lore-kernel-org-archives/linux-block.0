Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F3C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6862089D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fxBDooLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6862089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPSwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 13:52:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60840 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeKPSwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 13:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4flMnqPGx6Tvo003K9rXsg6gQstTEMmlHKR5PThPWwc=; b=fxBDooLrY1JH4+U7rp45yhcM9
        vFs/ZZ5v+Jx5Sw8L9gF4VQKBwZ4KX2XEFrOf30h722JoeWa7Qn01k6zs9GRvKe6UT5a3fLJjRbLrU
        vNWfkZihNZC6WI1HkMg4ZZKd46kAQMRi5vPrO1p4iqtqBKhmJGxXWbHbRvW8iRDpyQ+Lr8B4ZhpYR
        3BDFq4r7rNK7THRUdHqRbx7lXx6swBbl9BSULg1HEM0zpGV8lRTitbrUqjSRYd4jaCarTNPsBRiGP
        4uBhl1TjvrngSQpPnDnLNaylf5y7kvH+bG7vzXBw96YbdfwooEgPgr2uDePR+rTshO9WM03Davq8y
        og78ie4eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZh0-0005nF-5k; Fri, 16 Nov 2018 08:41:34 +0000
Date:   Fri, 16 Nov 2018 00:41:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 04/11] block: avoid ordered task state change for polled
 IO
Message-ID: <20181116084134.GF9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115195135.22812-5-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 15, 2018 at 12:51:28PM -0700, Jens Axboe wrote:
> Ensure that writes to the dio/bio waiter field are ordered
> correctly. With the smp_rmb() before the READ_ONCE() check,
> we should be able to use a more relaxed ordering for the
> task state setting. We don't need a heavier barrier on
> the wakeup side after writing the waiter field, since we
> either going to be in the task we care about, or go through
> wake_up_process() which implies a strong enough barrier.
> 
> For the core poll helper, the task state setting don't need
> to imply any atomics, as it's the current task itself that
> is being modified and we're not going to sleep.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq.c | 4 ++--
>  fs/block_dev.c | 9 +++++++--
>  fs/iomap.c     | 4 +++-
>  mm/page_io.c   | 4 +++-
>  4 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 32b246ed44c0..7fc4abb4cc36 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3331,12 +3331,12 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>  		ret = q->mq_ops->poll(hctx, rq->tag);
>  		if (ret > 0) {
>  			hctx->poll_success++;
> -			set_current_state(TASK_RUNNING);
> +			__set_current_state(TASK_RUNNING);
>  			return true;
>  		}
>  
>  		if (signal_pending_state(state, current))
> -			set_current_state(TASK_RUNNING);
> +			__set_current_state(TASK_RUNNING);
>  
>  		if (current->state == TASK_RUNNING)
>  			return true;
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index c039abfb2052..5b754f84c814 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -237,9 +237,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  
>  	qc = submit_bio(&bio);
>  	for (;;) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +		smp_rmb();
>  		if (!READ_ONCE(bio.bi_private))
>  			break;
> +
>  		if (!(iocb->ki_flags & IOCB_HIPRI) ||
>  		    !blk_poll(bdev_get_queue(bdev), qc))
>  			io_schedule();
> @@ -403,7 +406,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
>  		return -EIOCBQUEUED;
>  
>  	for (;;) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +		smp_rmb();
>  		if (!READ_ONCE(dio->waiter))
>  			break;
>  
> diff --git a/fs/iomap.c b/fs/iomap.c
> index f61d13dfdf09..3373ea4984d9 100644
> --- a/fs/iomap.c
> +++ b/fs/iomap.c
> @@ -1888,7 +1888,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			return -EIOCBQUEUED;
>  
>  		for (;;) {
> -			set_current_state(TASK_UNINTERRUPTIBLE);
> +			__set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +			smp_rmb();
>  			if (!READ_ONCE(dio->submit.waiter))
>  				break;
>  
> diff --git a/mm/page_io.c b/mm/page_io.c
> index d4d1c89bcddd..008f6d00c47c 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -405,7 +405,9 @@ int swap_readpage(struct page *page, bool synchronous)
>  	bio_get(bio);
>  	qc = submit_bio(bio);
>  	while (synchronous) {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
> +		__set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +		smp_rmb();
>  		if (!READ_ONCE(bio->bi_private))

I think any smp_rmb() should have a big fact comment explaining it.

Also to help stupid people like me that dont understand why we even
need it here  given the READ_ONCE below.
