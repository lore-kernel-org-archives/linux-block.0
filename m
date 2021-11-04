Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A724EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8166F61157
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKDSsD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhKDSsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:48:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EFC061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:45:25 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id l7-20020a0568302b0700b0055ae988dcc8so6399721otv.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fqtw7P+qhEAcrNll74akIBFIwSmEmXlYYjOzNiasPkA=;
        b=p4Anr+gm4xojA3K/CpOFA6tk/TQQuHowBweECX2OvswffHldDDDFFPl0iaWbxHsaPH
         g7Up/yIRIyIomojVLgJpyNozAXNeYA4BfR5SyyuKjXInOtoDwgK2XdO3/IZgnTOACDtj
         8EccXRNpFkNdv2kt9j9yMiqeSomWUeWqMw5sFb4C6CApP5yvrjnSv60p+3g0X9z/xJgY
         jEnwY6vcRkkLx3RriTjDjys7cui5N0XmeGGp72CO8vSefWhOgIxTpQfBbONe2QcASTHe
         xwK6r0bvkNjB/lQGZSn8wwmOZkOzKT99aMI4CAyopFYHPzymy0MfneBQC3Zk6vFMiesz
         X+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fqtw7P+qhEAcrNll74akIBFIwSmEmXlYYjOzNiasPkA=;
        b=G63I2bYW+BkIGpxaQThYwDCnNWcKnGFQ8h1nnzKPBfW+VAfnXSJQYQOUch4vQYBclX
         6ZGM7AyWXxR+K5WZgTJKqMXAQ7tBh86BITUPIFAYTLHQUUxQgx0UZVKrcjjrX1tjGQss
         HOKkSTyIx84PWG+pe3Dhoc3ASF2Wz1J9OF4oFIVR1EOJmXv4vTaHjSyCo9x9f00yBaA8
         DM/Sko7VoPNNdVkrpoknopVzDZ+/P3bHhtl5nnWHHXExAx5rPJ8o53AqUsFEpS44Fomr
         e82uwP9VU4uFsN++gvsc5gvyjEJsAdLYSaHUJsisXlbyi6maAy4hW+EtRbWaqdqbd3Vs
         Vf7g==
X-Gm-Message-State: AOAM531JwV0a4RnY6BxahdKVGNunOKgw5SiacN/LB4aqjSKAnEUKIhhf
        P79Xd4m5xaExUgqFSkSBsQQyq9V55KZj6g==
X-Google-Smtp-Source: ABdhPJxPcjh4y0yfhnQ71I39bMRZqfO8P0aNCoLxhssLUtOQRr7C/6X+aRwsE/l10PxHNd1h9hkU+g==
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr24637200otq.259.1636051524096;
        Thu, 04 Nov 2021 11:45:24 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id y16sm1572602oto.36.2021.11.04.11.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:45:23 -0700 (PDT)
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk> <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
Message-ID: <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
Date:   Thu, 4 Nov 2021 12:45:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 12:40 PM, Jens Axboe wrote:
> On 11/4/21 12:39 PM, Christoph Hellwig wrote:
>> On Thu, Nov 04, 2021 at 12:37:25PM -0600, Jens Axboe wrote:
>>> On 11/4/21 12:36 PM, Christoph Hellwig wrote:
>>>>> +static inline bool blk_mq_queue_enter(struct request_queue *q, struct bio *bio)
>>>>> +{
>>>>> +	if (!blk_try_enter_queue(q, false) && bio_queue_enter(bio))
>>>>> +		return false;
>>>>> +	return true;
>>>>> +}
>>>>
>>>> Didn't we just agree on splitting bio_queue_enter into an inline helper
>>>> and an out of line slowpath instead?
>>>
>>> See cover letter, and I also added to the commit message of this one. I do
>>> think this approach is better, as bio_queue_enter() itself is just slow
>>> path and there's no point polluting the code with 90% of what's in there.
>>>
>>> Hence I kept it as-is.
>>
>> Well, let me reword this then:  why do you think the above is
>> blk-mq secific and should not be used by every other caller of
>> bio_queue_enter as well?  In other words, why not rename
>> bio_queue_enter __bio_queue_enter and make the above the public
>> bio_queue_enter interface then?
> 
> OK, that I can agree too. I'll respin it as such. Gets the job done as
> well.

Ala:


diff --git a/block/blk-core.c b/block/blk-core.c
index c2d267b6f910..0084067949d8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -386,30 +386,6 @@ void blk_cleanup_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_cleanup_queue);
 
-static bool blk_try_enter_queue(struct request_queue *q, bool pm)
-{
-	rcu_read_lock();
-	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
-		goto fail;
-
-	/*
-	 * The code that increments the pm_only counter must ensure that the
-	 * counter is globally visible before the queue is unfrozen.
-	 */
-	if (blk_queue_pm_only(q) &&
-	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
-		goto fail_put;
-
-	rcu_read_unlock();
-	return true;
-
-fail_put:
-	blk_queue_exit(q);
-fail:
-	rcu_read_unlock();
-	return false;
-}
-
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -442,10 +418,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	return 0;
 }
 
-static inline int bio_queue_enter(struct bio *bio)
+int __bio_queue_enter(struct request_queue *q, struct bio *bio)
 {
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-
 	while (!blk_try_enter_queue(q, false)) {
 		struct gendisk *disk = bio->bi_bdev->bd_disk;
 
diff --git a/block/blk.h b/block/blk.h
index 7afffd548daf..814d9632d43e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -55,6 +55,40 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
+int __bio_queue_enter(struct request_queue *q, struct bio *bio);
+
+static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
+{
+	rcu_read_lock();
+	if (!percpu_ref_tryget_live_rcu(&q->q_usage_counter))
+		goto fail;
+
+	/*
+	 * The code that increments the pm_only counter must ensure that the
+	 * counter is globally visible before the queue is unfrozen.
+	 */
+	if (blk_queue_pm_only(q) &&
+	    (!pm || queue_rpm_status(q) == RPM_SUSPENDED))
+		goto fail_put;
+
+	rcu_read_unlock();
+	return true;
+
+fail_put:
+	blk_queue_exit(q);
+fail:
+	rcu_read_unlock();
+	return false;
+}
+
+static inline int bio_queue_enter(struct bio *bio)
+{
+	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+
+	if (blk_try_enter_queue(q, false))
+		return 0;
+	return __bio_queue_enter(q, bio);
+}
 
 #define BIO_INLINE_VECS 4
 struct bio_vec *bvec_alloc(mempool_t *pool, unsigned short *nr_vecs,

-- 
Jens Axboe

