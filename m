Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39892C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 07:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2AD2173E
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 07:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cV3zT3cX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKZHVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 02:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgKZHVu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 02:21:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11EC0613D4
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 23:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=caEaqH8Clw+ryhvqDbTsLeVERTwXz5nVvGGteOKmoYg=; b=cV3zT3cXFQ2mL16GDdzAaIkabp
        fE2sZO+Vw7LXKME7iWSrS/1tu4n/znRt25KHDyt5kwm3tkuEVxGkrlcI8XlTBsmUfQikN0SlaCKIp
        XSPanP3BFs5stkm98G+HvEq1a4K7WEhJRmagdM3BSMtRY3eqjFCNCHmB+CEOQ6bzaeZelLIdQ0399
        +GHIaDsOHgMg/E27iqFdOu7wxSrviDax2yfib2w8vw93SoLYipFgVUu+F2HMV2sQxw8WzfLoVyS7p
        mgbkqhQeBMYXoXRfsGpau3YrObKHd+kRWYxABedNsbl6enwg17yhgZlAK1r5ICbsrbWoVgNqFpV0p
        mUKtCvhw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiBaz-0007tN-D3; Thu, 26 Nov 2020 07:21:37 +0000
Date:   Thu, 26 Nov 2020 07:21:37 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com, hch@infradead.org
Subject: Re: [PATCH v8] block: disable iopoll for split bio
Message-ID: <20201126072137.GB29730@infradead.org>
References: <20201126022837.15545-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126022837.15545-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 10:28:37AM +0800, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio and return BLK_QC_T_NONE in this case. The side effect is that
> non-HIPRI IO also returns BLK_QC_T_NONE now. It should be acceptable
> since the returned cookie is never used for non-HIPRI IO.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-merge.c | 8 ++++++++
>  block/blk-mq.c    | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..8a2f1fb7bb16 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,14 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	/*
> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
> +	 * big IO can be trival, disable iopoll when split needed.
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
> +
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..580fd570be23 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2157,6 +2157,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  	unsigned int nr_segs;
>  	blk_qc_t cookie;
>  	blk_status_t ret;
> +	bool hipri;
>  
>  	blk_queue_bounce(q, &bio);
>  	__blk_queue_split(&bio, &nr_segs);
> @@ -2173,6 +2174,8 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  
>  	rq_qos_throttle(q, bio);
>  
> +	hipri = bio->bi_opf & REQ_HIPRI;
> +
>  	data.cmd_flags = bio->bi_opf;
>  	rq = __blk_mq_alloc_request(&data);
>  	if (unlikely(!rq)) {
> @@ -2265,7 +2268,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> +	cookie = hipri ? cookie : BLK_QC_T_NONE;
>  	return cookie;

This looks functionally correct, but the expression above looks a little
strange.  I'd write:

	if (!hipri)
		return BLK_QC_T_NONE;
	return cookie;

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
