Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584D4C433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279A661027
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 05:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhJNFUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJNFUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 01:20:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1EC061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 22:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lyHkdhixK7kwhDPDTW9KYPd7Ar3jcRfJrHwTlhLBtoM=; b=ols3MprT+UT5cI41Ec8xDf7MhZ
        3MPOYh2UU7Ca/VJYm+hkC02pnW4igcSTQqO1zMB8OsoqxJe5vwTv8NrI9Ht/LeJigxpdAokiQa2fl
        ITjfkAllhiC591ednMlgM8F6hTO77ci3D1OC6GoB2+XjJGpcjYHb31kJR8Yt2cLsLn8jbS6fnivzx
        szTMj69AJwv2/fEMLF5p2/07pfhnPTT8XBiIY3/ZHb1+yKke4QlNIdToditI/6HUP0O4wKrADO2Gs
        yghVykMt0PttOBdm7iXfHCmm4bcSxgKLCKLzsOfUuFz9h+OUZhxQ8lqAodkOO2OGVzTWzsyCMaaN3
        WN1G1lIg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mat7j-0083Cf-Ki; Thu, 14 Oct 2021 05:18:02 +0000
Date:   Thu, 14 Oct 2021 06:17:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: improve batched tag allocation
Message-ID: <YWe9e+4V5Cw325uA@infradead.org>
References: <20211012171525.665644-1-axboe@kernel.dk>
 <20211012171525.665644-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012171525.665644-3-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 11:15:25AM -0600, Jens Axboe wrote:
>  
> +unsigned long blk_mq_get_tags(struct blk_mq_alloc_data *data, int nr_tags,
> +			      unsigned int *offset)
> +{
> +	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
> +	struct sbitmap_queue *bt = &tags->bitmap_tags;
> +	unsigned long ret;
> +
> +	if (data->shallow_depth ||data->flags & BLK_MQ_REQ_RESERVED ||

Missing whitespace after the first ||.

> +	if (data->nr_tags > 1) {
> +		unsigned long tags;
> +		unsigned int tag_offset;
> +		int i, nr = 0;
> +
> +		tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +		if (unlikely(!tags)) {
> +			data->nr_tags = 1;
> +			goto retry;

Unless I'm missing something we don't want the retry case that maps
the contexts against and calls blk_mq_tag_busy again.

> +		}
> +		for (i = 0; tags; i++) {
> +			if (!(tags & (1UL << i)))
> +				continue;
> +			tag = tag_offset + i;
> +			tags &= ~(1UL << i);
> +			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
> +			rq->rq_next = *data->cached_rq;
> +			*data->cached_rq = rq;
> +		}
> +		data->nr_tags -= nr;

And keeping all this batch logic in a helper (even if inlined) would
simplify the code a lot.  Something like this untested patch:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5ac94149fb4be..608b270a7f6b8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -373,6 +373,38 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	return rq;
 }
 
+static inline struct request *
+__blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data,
+		u64 alloc_time_ns)
+{
+	unsigned int tag, tag_offset;
+	struct request *rq;
+	unsigned long tags;
+	int i, nr = 0;
+
+	tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
+	if (unlikely(!tags))
+		return NULL;
+
+	for (i = 0; tags; i++) {
+		if (!(tags & (1UL << i)))
+			continue;
+		tag = tag_offset + i;
+		tags &= ~(1UL << i);
+		rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+		rq->rq_next = *data->cached_rq;
+		*data->cached_rq = rq;
+	}
+	data->nr_tags -= nr;
+
+	if (!data->cached_rq)
+		return NULL;
+
+	rq = *data->cached_rq;
+	*data->cached_rq = rq->rq_next;
+	return rq;
+}
+
 static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 {
 	struct request_queue *q = data->q;
@@ -411,56 +443,32 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 	 * Try batched alloc if we want more than 1 tag.
 	 */
 	if (data->nr_tags > 1) {
-		unsigned long tags;
-		unsigned int tag_offset;
-		int i, nr = 0;
-
-		tags = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
-		if (unlikely(!tags)) {
-			data->nr_tags = 1;
-			goto retry;
-		}
-		for (i = 0; tags; i++) {
-			if (!(tags & (1UL << i)))
-				continue;
-			tag = tag_offset + i;
-			tags &= ~(1UL << i);
-			rq = blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
-			rq->rq_next = *data->cached_rq;
-			*data->cached_rq = rq;
-		}
-		data->nr_tags -= nr;
-	} else {
-		/*
-		 * Waiting allocations only fail because of an inactive hctx.
-		 * In that case just retry the hctx assignment and tag
-		 * allocation as CPU hotplug should have migrated us to an
-		 * online CPU by now.
-		 */
-		tag = blk_mq_get_tag(data);
-		if (tag == BLK_MQ_NO_TAG) {
-			if (data->flags & BLK_MQ_REQ_NOWAIT)
-				return NULL;
-			/*
-			 * Give up the CPU and sleep for a random short time to
-			 * ensure that thread using a realtime scheduling class
-			 * are migrated off the CPU, and thus off the hctx that
-			 * is going away.
-			 */
-			msleep(3);
-			goto retry;
-		}
-
-		return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
+		rq = __blk_mq_alloc_requests_batch(data, alloc_time_ns);
+		if (rq)
+			return rq;
+		data->nr_tags = 1;
 	}
 
-	if (data->cached_rq) {
-		rq = *data->cached_rq;
-		*data->cached_rq = rq->rq_next;
-		return rq;
+	/*
+	 * Waiting allocations only fail because of an inactive hctx.  In that
+	 * case just retry the hctx assignment and tag allocation as CPU hotplug
+	 * should have migrated us to an online CPU by now.
+	 */
+	tag = blk_mq_get_tag(data);
+	if (tag == BLK_MQ_NO_TAG) {
+		if (data->flags & BLK_MQ_REQ_NOWAIT)
+			return NULL;
+		/*
+		 * Give up the CPU and sleep for a random short time to
+		 * ensure that thread using a realtime scheduling class
+		 * are migrated off the CPU, and thus off the hctx that
+		 * is going away.
+		 */
+		msleep(3);
+		goto retry;
 	}
 
-	return NULL;
+	return blk_mq_rq_ctx_init(data, tag, alloc_time_ns);
 }
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
