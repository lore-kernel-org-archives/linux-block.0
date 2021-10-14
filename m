Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE840C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0AF60F41
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 13:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNNS5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 09:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNNS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 09:18:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C06C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:16:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 188so3657854iou.12
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cm/qDfOLWGLKdt5GhysT2O5K8VEDAVLJJcQterR+bgk=;
        b=MwjQguEpsTyzxEfGocCu27iSq2Dzrnv+s0sGu2gGehIiquHRY6FkgPaCyE3kPazkRB
         GbC8cgISaG/Q4U9I5JEBC0OCAQZt30j2iKk17hFMxgEletIrWLsEMqPVzsH2mOgI0tjR
         QHJkJbOFB+6oCZ2CpSC6eQ9GWP+dF69ph/i1FN7X6H7LzGsrQgPt+niCUU+n5J7FXWhi
         sKdOhzLJV0TAfFsEbhCBBHyUOXlpGc4wYScxg78CCXPo43Hhvb1XRN9LuAY8+tI5G5WX
         Dl4KL1X2PUFigUR1ZFPx/c7aFr845L6rYjUr8SXRtgmA55QWXJr7J7TzXRHVSjZTCneM
         AaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cm/qDfOLWGLKdt5GhysT2O5K8VEDAVLJJcQterR+bgk=;
        b=1S7F0qXTNRGfO0J7JB3jIU3xlcda2Hwtewy78Wk5NYKxmmI/3DnofzJ7HJmYM1gI31
         1e6QvINmt3JaQhQXw+xL+4jebQvtxMZ6BEbJyMqRSqAi3jjCJofy+opwupE+Tlhr2AsU
         lWjIaLMND5VXkHB5OImxzsC2RIGOll4Ewi1aaW8c6vBxphv6zdPrZBLfYoDuAjJJhRI9
         niFKs31Mcn0qiAbf3mMRG0Hj6PDH1sMBKBKgMMEur6HhNI48ux3MZ8IZfsiyW5NdbTIj
         Wy+CroluB/9e5e6FmirVhAMPSxBn9gE9vjYlfKN4+va7tNxxynRC8t9YHBoJWtswpA+5
         t81w==
X-Gm-Message-State: AOAM533Y3U73WVB95lj9v8KFffMPkaW+sJoX6OYLgHxTQ2fwgbDMa1u2
        f9uhfHlKYrc0hGZIWHcPz+DuutkYdCL+2w==
X-Google-Smtp-Source: ABdhPJxMAZ3VKLid4nUcne4vD+QkJ0WtDN3GdctzK2b6kN74x2dTcCmwLeH3QfbZUjUEBCxvBGyVaQ==
X-Received: by 2002:a05:6602:27c5:: with SMTP id l5mr2395628ios.60.1634217411460;
        Thu, 14 Oct 2021 06:16:51 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id e10sm1222794ili.53.2021.10.14.06.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:16:50 -0700 (PDT)
Subject: Re: [PATCH] block: handle fast path of bio splitting inline
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <30045b11-0064-1849-5b10-f8fa05c6958d@kernel.dk>
 <YWfCY7LuCldVANXj@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87379eeb-679a-19a9-2b00-89ff64b34113@kernel.dk>
Date:   Thu, 14 Oct 2021 07:16:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfCY7LuCldVANXj@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:38 PM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 02:44:14PM -0600, Jens Axboe wrote:
>> The fast path is no splitting needed. Separate the handling into a
>> check part we can inline, and an out-of-line handling path if we do
>> need to split.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> What about something like this version instead?

A bit of a combo, I think this will do fine.


commit d997c5f4001031863de1c8c437bd2fcc6a4f79a2
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Oct 13 12:43:41 2021 -0600

    block: handle fast path of bio splitting inline
    
    The fast path is no splitting needed. Separate the handling into a
    check part we can inline, and an out-of-line handling path if we do
    need to split.
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4da2bf18fa4d..f390a8753268 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -324,6 +324,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 
 /**
  * __blk_queue_split - split a bio and submit the second half
+ * @q:       [in] request_queue new bio is being queued at
  * @bio:     [in, out] bio to be split
  * @nr_segs: [out] number of segments in the first bio
  *
@@ -334,9 +335,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
  * of the caller to ensure that q->bio_split is only released after processing
  * of the split bio has finished.
  */
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
+void __blk_queue_split(struct request_queue *q, struct bio **bio,
+		       unsigned int *nr_segs)
 {
-	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
 	struct bio *split = NULL;
 
 	switch (bio_op(*bio)) {
@@ -353,21 +354,6 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
 				nr_segs);
 		break;
 	default:
-		/*
-		 * All drivers must accept single-segments bios that are <=
-		 * PAGE_SIZE.  This is a quick and dirty check that relies on
-		 * the fact that bi_io_vec[0] is always valid if a bio has data.
-		 * The check might lead to occasional false negatives when bios
-		 * are cloned, but compared to the performance impact of cloned
-		 * bios themselves the loop below doesn't matter anyway.
-		 */
-		if (!q->limits.chunk_sectors &&
-		    (*bio)->bi_vcnt == 1 &&
-		    ((*bio)->bi_io_vec[0].bv_len +
-		     (*bio)->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
-			*nr_segs = 1;
-			break;
-		}
 		split = blk_bio_segment_split(q, *bio, &q->bio_split, nr_segs);
 		break;
 	}
@@ -397,9 +383,11 @@ void __blk_queue_split(struct bio **bio, unsigned int *nr_segs)
  */
 void blk_queue_split(struct bio **bio)
 {
+	struct request_queue *q = (*bio)->bi_bdev->bd_disk->queue;
 	unsigned int nr_segs;
 
-	__blk_queue_split(bio, &nr_segs);
+	if (blk_may_split(q, *bio))
+		__blk_queue_split(q, bio, &nr_segs);
 }
 EXPORT_SYMBOL(blk_queue_split);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index dd4121dcd3ce..0cca4b7a4d16 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2521,11 +2521,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
-	unsigned int nr_segs;
+	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
 	blk_queue_bounce(q, &bio);
-	__blk_queue_split(&bio, &nr_segs);
+	if (blk_may_split(q, bio))
+		__blk_queue_split(q, &bio, &nr_segs);
 
 	if (!bio_integrity_prep(bio))
 		goto queue_exit;
diff --git a/block/blk.h b/block/blk.h
index fa23338449ed..f6e61cebd6ae 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -264,7 +264,32 @@ ssize_t part_timeout_show(struct device *, struct device_attribute *, char *);
 ssize_t part_timeout_store(struct device *, struct device_attribute *,
 				const char *, size_t);
 
-void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
+static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
+{
+	switch (bio_op(bio)) {
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_WRITE_SAME:
+		return true; /* non-trivial splitting decisions */
+	default:
+		break;
+	}
+
+	/*
+	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
+	 * This is a quick and dirty check that relies on the fact that
+	 * bi_io_vec[0] is always valid if a bio has data.  The check might
+	 * lead to occasional false negatives when bios are cloned, but compared
+	 * to the performance impact of cloned bios themselves the loop below
+	 * doesn't matter anyway.
+	 */
+	return q->limits.chunk_sectors || bio->bi_vcnt != 1 ||
+		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+}
+
+void __blk_queue_split(struct request_queue *q, struct bio **bio,
+			unsigned int *nr_segs);
 int ll_back_merge_fn(struct request *req, struct bio *bio,
 		unsigned int nr_segs);
 bool blk_attempt_req_merge(struct request_queue *q, struct request *rq,

-- 
Jens Axboe

