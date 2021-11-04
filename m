Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD3C433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 12:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0C961183
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 12:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKDMRL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhKDMRK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 08:17:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D9C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 05:14:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id q203so6468707iod.12
        for <linux-block@vger.kernel.org>; Thu, 04 Nov 2021 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ftvpd6eKU0adHjQ/KzBVfJsPzPindjIYiSM/ylE79KE=;
        b=IdClgNznYgZNFMKcWrBZ9saQL+XJvaevgbyivg32FF1aM22QEeH7uZc1ikjP8esCB5
         nO++3p0WaNIzEWFTF3/nNWwYB2GJtf9RRjIGY3Xyi697f9cPTuYwNwogDtcnvpTDj6Z6
         MCvRbZ1UKVe3PzARnIqtbhjUwG816YdwFU9sRm95dzD3rYzDXoj0t+jfGpbi6o96MCSi
         07wHRXjDl1kEo8so3r4f5O1at5ua3XEnJuH3b332fI4P3CJk5l8miAtq2jh6eiq9nyFX
         XWem9qsZV3ZewRLZYFmk70SZVX10jIcanjHQcvphrrd/1qq4qDslvVN4bJIjWF8LMBDD
         7HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ftvpd6eKU0adHjQ/KzBVfJsPzPindjIYiSM/ylE79KE=;
        b=MBqc4BwX8uAGC+PPkSwuKpOJ8yxj352mrlmbkkrLaOtSkcf1LwVEuopzTy6QdRpCvc
         Z4HFdCTVSmvYCcKbwGi7lk7d/GS3Zg9I3CmXKgbSQ7pUi2+ebDecmIhTrCV0TDQSLeoR
         Lj4Ra5wWinKmN9waCwkXbJvesyE4W4ndBSvWYkdrQBOJ/VPaSKXMb9na+3nfo4G+z326
         4iPqUQll5SZWY9AVn131Wb/qmd0Rw/u58Eh1Gq5X/UDh8KyPBxltENNk/Cq9G92i5zrA
         OJ9JIV/H+3RrkmKdYb4jecHemoHQUSptwHGArnsSopDtERzsSdnOrCmn376IGrF2m3FD
         4GMQ==
X-Gm-Message-State: AOAM533GlDzBx7uAHuhDRCU0RR+5S5ePHYyHCmlY6l2vVp/ZnHA+BA9G
        3Yh761FiRj0TlG3EmlzZ1jS/tE7kP3CqrA==
X-Google-Smtp-Source: ABdhPJzbD8XUaMCee4r87armMmI7YZWUSGwVsolXAkBNSQSIMjrozKNdSpb3o71EmL5J3HymVbwJiw==
X-Received: by 2002:a05:6638:2107:: with SMTP id n7mr3563700jaj.70.1636028071526;
        Thu, 04 Nov 2021 05:14:31 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t6sm2875962iov.39.2021.11.04.05.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 05:14:31 -0700 (PDT)
Subject: Re: [PATCH 3/4] block: move queue enter logic into
 blk_mq_submit_bio()
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-4-axboe@kernel.dk> <YYOjcuEExwJN1eiw@infradead.org>
 <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
Message-ID: <4d92696b-41a3-b0f3-90de-5b41555f011d@kernel.dk>
Date:   Thu, 4 Nov 2021 06:14:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ff6be121-5753-fe5f-90dc-8703da656d53@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/21 5:41 AM, Jens Axboe wrote:
>> This is broken, we really ant the submit checks under freeze
>> protection to make sure the parameters can't be changed underneath
>> us.
> 
> Which parameters are you worried about in submit_bio_checks()? I don't
> immediately see anything that would make me worry about it.

To player it safer, I would suggest we fold in something like the
below. That keeps the submit_checks() under the queue enter.


diff --git a/block/blk-core.c b/block/blk-core.c
index 2b12a427ffa6..18aab7f8469a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -746,7 +746,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 	return BLK_STS_OK;
 }
 
-static noinline_for_stack bool submit_bio_checks(struct bio *bio)
+noinline_for_stack bool submit_bio_checks(struct bio *bio)
 {
 	struct block_device *bdev = bio->bi_bdev;
 	struct request_queue *q = bdev_get_queue(bdev);
@@ -868,14 +868,13 @@ static void __submit_bio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 
-	if (!submit_bio_checks(bio) || !blk_crypto_bio_prep(&bio))
-		return;
 	if (!disk->fops->submit_bio) {
 		blk_mq_submit_bio(bio);
 	} else {
 		if (unlikely(bio_queue_enter(bio) != 0))
 			return;
-		disk->fops->submit_bio(bio);
+		if (submit_bio_checks(bio) && blk_crypto_bio_prep(&bio))
+			disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e92c36f2326a..2dab9bdcc51a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2526,6 +2526,9 @@ void blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
+	if (unlikely(!blk_crypto_bio_prep(&bio)))
+		return;
+
 	blk_queue_bounce(q, &bio);
 	if (blk_may_split(q, bio))
 		__blk_queue_split(q, &bio, &nr_segs);
@@ -2551,6 +2554,8 @@ void blk_mq_submit_bio(struct bio *bio)
 
 		if (unlikely(!blk_mq_queue_enter(q, bio)))
 			return;
+		if (unlikely(!submit_bio_checks(bio)))
+			goto put_exit;
 
 		rq_qos_throttle(q, bio);
 
diff --git a/block/blk.h b/block/blk.h
index f7371d3b1522..79c98ced59c8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -56,6 +56,7 @@ void blk_freeze_queue(struct request_queue *q);
 void __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 void blk_queue_start_drain(struct request_queue *q);
 int bio_queue_enter(struct bio *bio);
+bool submit_bio_checks(struct bio *bio);
 
 static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
 {

-- 
Jens Axboe

