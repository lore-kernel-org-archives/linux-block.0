Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232AAC56202
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6A92158C
	for <linux-block@archiver.kernel.org>; Wed, 25 Nov 2020 16:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSgo6bK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgKYQEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Nov 2020 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgKYQEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 11:04:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E058C0613D4
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2020 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjVoRvTYObKkVjOh7KyqJ7M7/euNZ7t5yhpdHO393RE=; b=XSgo6bK0O/6U3TZwHi77BQ1AHe
        ybxbmMMO6oc8ZEN6pxw+COJbGVl12wBBxoI9zHnG6Y1W9OI5Erp4s3frxCRpzhDpzYE2KTphzN2Hq
        +a+iFuqEyM6zfV1hVvUk/ME8HupjS5Qv6vC0Gh5YsgIkVjIjNn+lBETtECnXL3Mie4g1lF8Tb2MYn
        6hV0/dWhWJvuUurzzmbyJz+XJT944YD1uIWNpaIbeX3omTakB5btIyv9263QCNTz76h+S+momQP5B
        50UCnL8oxT1WPIpWVNirUF7cYcEzs27tyF1t9eRxma+Lm+D9MWV1LG+BcaaYshqeBqecBzvHinwak
        4MHvw+1A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khxHS-0000b6-6m; Wed, 25 Nov 2020 16:04:30 +0000
Date:   Wed, 25 Nov 2020 16:04:30 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, ming.lei@redhat.com, hch@infradead.org
Subject: Re: [PATCH v7] block: disable iopoll for split bio
Message-ID: <20201125160430.GA1761@infradead.org>
References: <20201125134335.63479-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125134335.63479-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Wed, Nov 25, 2020 at 09:43:35PM +0800, Jeffle Xu wrote:
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
>  block/blk-mq.c    | 6 +++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
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
> index 55bcee5dc032..4acd702575cd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2265,7 +2265,11 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> -	return cookie;
> +	if (bio->bi_opf & REQ_HIPRI)
> +		return cookie;
> +
> +	return BLK_QC_T_NONE;

This can cause a use after free if the I/O completed very quickly.  I
think we need to check the flag after the split, but before submitting
the request to the hardware.
