Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7BCC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 15:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1404C218D0
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jR/OBsZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeLSPuN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:50:13 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:53592 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLSPuN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 10:50:13 -0500
Received: by mail-it1-f194.google.com with SMTP id g85so10331922ita.3
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 07:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fgd2e+v7ZltxFOSzZLc68HlVLrFcdb+9yJIbB8a5pe0=;
        b=jR/OBsZibwme1cRWuA+ByqfYr8cDD7YLYH8O+3pgl2+bOr00Gvewyfxjbk/bm5P40/
         pD+lKwKzgZrAobDGBSKho46YSwFXSJ/Ngy5GpJUYQkTI+iIpwlsh+VfCUzkB7/+H/RvM
         3FjlNsOYbd1Y4WOnGAt41k2gHpgGcLWIKEpw6k4YSZxlp4YVPY9G3XOMz2tYAjp4wSI+
         rzhj7P6qyuThlO10MzBkZpdp2hvyYuSI8Mnir9oWUP0y5aZRCssyCfn73sovx3gYRk8X
         rOfL/Bk75mc3tUb5/exmoRWTaFt87Mu0f29FXiNaQa235suj+L1b7wVHD5tzxAIer81D
         lm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fgd2e+v7ZltxFOSzZLc68HlVLrFcdb+9yJIbB8a5pe0=;
        b=LUV9jCbeTI9tzh0oUI8PZNMPRnYdk+9PrzOHp7ZHTlYCBjxfJgVGNpA7+zUYTrEN6x
         ajOR0oVH25aOAnYPhlfdgt7FKK52S9CmXP32G3gVp7nN7+PmlUH2O/G49KDqHF6xQqeT
         kE7Rloclfwz813usCQcVda1oYrVM/Q5ZTdsxkz4HhdLGfPnvC3hNJTygwjGa9zKX7PkW
         KOkTqX5CMUZNF1LGpwalyMl1MDolySDSpHY5QN6uhP+TcrmkkaYgTPEZY6iaHoqUZRyg
         aUvagwajQr86RBLYJqPFlBR368tyY3CGq6mKkQepala1J5hXJV9v5LpcAusJVWjcjA5P
         m2uw==
X-Gm-Message-State: AA+aEWZVWrJPxjbzkcPq/4O80hO41v2ddYAmnPbpgMFm7GsJEIOefrTd
        q8CAXTM8pcJ4tuqIGc4ooENuMzGrxsLgpg==
X-Google-Smtp-Source: AFSGD/VXPnNGVzMfu+n0WJLOyNm8yN81fxenl02smL49fa2wzRMXo7vTH0ae+0xC0x0zk7Ck5Hbk7w==
X-Received: by 2002:a24:45a1:: with SMTP id c33mr6890859itd.90.1545234611841;
        Wed, 19 Dec 2018 07:50:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q14sm5068001ior.69.2018.12.19.07.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:50:10 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>,
        Dennis Zhou <dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] dm: don't reuse bio for flushes
Message-ID: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
Date:   Wed, 19 Dec 2018 08:50:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

DM currently has a statically allocated bio that it uses to issue empty
flushes. It doesn't submit this bio, it just uses it for maintaining
state while setting up clones. Multiple users can access this bio at the
same time. This wasn't previously an issue, even if it was a bit iffy,
but with the blkg associations it can become one.

We setup the blkg association, then clone bio's and submit, then remove
the blkg assocation again. But since we can have multiple tasks doing
this at the same time, against multiple blkg's, then we can either lose
references to a blkg, or put it twice. The latter causes complaints on
the percpu ref being <= 0 when released, and can cause use-after-free as
well. Ming reports that xfstest generic/475 triggers this:

------------[ cut here ]------------
percpu ref (blkg_release) <= 0 (0) after switching to atomic
WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0

Switch to just using an on-stack bio for this, and get rid of the
embedded bio.

Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Only other use case like this I could find is raid5-cache, which
serializes access to its embedded bio (and actually submits it, too).
That one looks fine.

diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index 6fe883fac471..95c6d86ab5e8 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -106,9 +106,6 @@ struct mapped_device {
 
 	struct block_device *bdev;
 
-	/* zero-length flush that will be cloned and submitted to targets */
-	struct bio flush_bio;
-
 	struct dm_stats stats;
 
 	/* for blk-mq request-based DM support */
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dddbca63e140..f588a6a83d80 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1420,11 +1420,11 @@ static int __send_empty_flush(struct clone_info *ci)
 	struct dm_target *ti;
 
 	/*
-	 * Empty flush uses a statically initialized bio, &md->flush_bio, as
-	 * the base for cloning.  However, blkg association requires that a
-	 * bdev is associated with a gendisk, which doesn't happen until the
-	 * bdev is opened.  So, blkg association is done at issue time of the
-	 * flush rather than when the device is created in alloc_dev().
+	 * Empty flush uses a statically initialized bio, as the base for
+	 * cloning.  However, blkg association requires that a bdev is
+	 * associated with a gendisk, which doesn't happen until the bdev is
+	 * opened.  So, blkg association is done at issue time of the flush
+	 * rather than when the device is created in alloc_dev().
 	 */
 	bio_set_dev(ci->bio, ci->io->md->bdev);
 
@@ -1609,7 +1609,16 @@ static blk_qc_t __split_and_process_bio(struct mapped_device *md,
 	init_clone_info(&ci, md, map, bio);
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
-		ci.bio = &ci.io->md->flush_bio;
+		struct bio flush_bio;
+
+		/*
+		 * Use an on-stack bio for this, it's safe since we don't
+		 * need to reference it after submit. It's just used as
+		 * the basis for the clone(s).
+		 */
+		bio_init(&flush_bio, NULL, 0);
+		flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
+		ci.bio = &flush_bio;
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
 		/* dec_pending submits any data associated with flush */
@@ -1665,7 +1674,16 @@ static blk_qc_t __process_bio(struct mapped_device *md,
 	init_clone_info(&ci, md, map, bio);
 
 	if (bio->bi_opf & REQ_PREFLUSH) {
-		ci.bio = &ci.io->md->flush_bio;
+		struct bio flush_bio;
+
+		/*
+		 * Use an on-stack bio for this, it's safe since we don't
+		 * need to reference it after submit. It's just used as
+		 * the basis for the clone(s).
+		 */
+		bio_init(&flush_bio, NULL, 0);
+		flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
+		ci.bio = &flush_bio;
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
 		/* dec_pending submits any data associated with flush */
@@ -1949,9 +1967,6 @@ static struct mapped_device *alloc_dev(int minor)
 	if (!md->bdev)
 		goto bad;
 
-	bio_init(&md->flush_bio, NULL, 0);
-	md->flush_bio.bi_opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
-
 	dm_stats_init(&md->stats);
 
 	/* Populate the mapping, nobody knows we exist yet */

-- 
Jens Axboe

