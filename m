Return-Path: <SRS0=ptuj=WK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0FDC433FF
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BDC2083B
	for <linux-block@archiver.kernel.org>; Wed, 14 Aug 2019 10:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="jPSDMBQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNKcu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:32:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41663 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfHNKct (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Aug 2019 06:32:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id w5so6637180edl.8
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2019 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBtemWUHTumI2mqw+n8wmnycs/uDqcEImdqPTzrreFU=;
        b=jPSDMBQ8wHXd5nnN4pQRCcjuk/Tf/zo5Gq/c3IPIvlKqLypTaDE7O9pJQQMKJWpurY
         afliwfOG5B/FTYlhid2lB2X/kDJaCoth4ZBtiLABtPH++SFoldn4GxBJbI+MEXHxPAc/
         SQCH30Q3GypvPbDTOH9K4MsQ6jwaMfvSzn/U1VB0C5akRUnsXj7WygUAEL2CQAmlpRIr
         F+CrwVHJ5rcWnIuLAMqxIZJLGzOXzkFMIn65jl6GE/XaxCwLjlLOKLXZndW+zDgDvXDp
         mBddRPGyfXkHEKxdAds27IMGu+jCEUV69dn9UVjN8XbIvV+8YenKahu2JtCJBXiH2aPy
         /iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBtemWUHTumI2mqw+n8wmnycs/uDqcEImdqPTzrreFU=;
        b=CHnlpdjWm6TtVylTTxFY65pjIORGtG4Xd1YuRUadYmayYGY656uXMBeFO8ZEgoC7IS
         SKLMxsQflRQA/JkzRM63IcSfLAvp4gRUwdHalDGmx+LVPVMKo/G/vw/NiNom4QFu4f27
         pXK+miVGVP9xAABGmIb6GJGwlLz15J8jy3luCeNvQQ+pQU5Qsok2p8T70ny7vDGOCfrZ
         T1I8UmwX2ophMHbUQd8KmJmXVk9cPG8feiPYJA2Uz70YODTI7QpeZkDhjb5q1O0fKOcz
         DKthNrXlj+o3ls9mQHXhmD2Yt5/+8CpyPUGBI+63vVl6F+rZqC43n+LyINsSb4uP8hmw
         aUTQ==
X-Gm-Message-State: APjAAAUn0lbknJfrZfnVlADxvPh0Bpqxj+lVCmu982Vw/eTepY/NfzGB
        NKBE3xJHfbL+y+yBLb6FbzIQUg==
X-Google-Smtp-Source: APXvYqwRp6BkhAOiQNXuaWuzsnMLq7pbX/Yzz8215caYil9aHzMp2C3TXzlRapBe4QbVglgHlc04OQ==
X-Received: by 2002:a05:6402:789:: with SMTP id d9mr28725992edy.25.1565778767338;
        Wed, 14 Aug 2019 03:32:47 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a22sm17778362eje.61.2019.08.14.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 03:32:46 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@android.com,
        narayan@google.com, dariofreni@google.com, ioffe@google.com,
        jiyong@google.com, maco@google.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH] RFC: loop: Avoid calling blk_mq_freeze_queue() when possible.
Date:   Wed, 14 Aug 2019 12:32:44 +0200
Message-Id: <20190814103244.92518-1-maco@android.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since Android Q, the creation and configuration of loop devices is in
the critical path of device boot. We found that the configuration of
loop devices is pretty slow, because many ioctl()'s involve freezing the
block queue, which in turn needs to wait for an RCU grace period. On
Android devices we've observed up to 60ms for the creation and
configuration of a single loop device; as we anticipate creating many
more in the future, we'd like to avoid this delay.

This allows LOOP_SET_BLOCK_SIZE to be called before the loop device has
been bound; since the block queue is not running at that point, we can
avoid the expensive freezing of the queue.

On a recent x86, this patch yields the following results:

===
Call LOOP_SET_BLOCK_SIZE on /dev/loop0 before being bound
===
~# time ./set_block_size

real 0m0.002s
user 0m0.000s
sys  0m0.002s

===
Call LOOP_SET_BLOCK_SIZE on /dev/loop0 after being bound
===
~# losetup /dev/loop0 fs.img
~# time ./set_block_size

real 0m0.008s
user 0m0.000s
sys  0m0.002s

Over many runs, this is a 4x improvement.

This is RFC because technically it is a change in behavior; before,
calling LOOP_SET_BLOCK_SIZE on an unbound device would return ENXIO, and
userspace programs that left it in their code despite the returned
error, would now suddenly see the requested value effectuated. I'm not
sure whether this is acceptable.

An alternative might be a CONFIG option to set the default block size to
another value than 512. Another alternative I considered is allowing the
block device to be created with a "frozen" queue, where we can manually
unfreeze the queue when all the configuration is done. This would be a
much larger code change, though.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ab7ca5989097a..d4348a4fdd7a6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -214,7 +214,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 * LO_FLAGS_READ_ONLY, both are set from kernel, and losetup
 	 * will get updated by ioctl(LOOP_GET_STATUS)
 	 */
-	blk_mq_freeze_queue(lo->lo_queue);
+	if (lo->lo_state == Lo_bound)
+		blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
 	if (use_dio) {
 		blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, lo->lo_queue);
@@ -223,7 +224,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 	}
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (lo->lo_state == Lo_bound)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
 static int
@@ -621,6 +623,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 
 static inline void loop_update_dio(struct loop_device *lo)
 {
+	if (lo->lo_state != Lo_bound)
+		return;
 	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
 			lo->use_dio);
 }
@@ -1510,27 +1514,26 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
 	int err = 0;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
-
 	if (arg < 512 || arg > PAGE_SIZE || !is_power_of_2(arg))
 		return -EINVAL;
 
-	if (lo->lo_queue->limits.logical_block_size != arg) {
-		sync_blockdev(lo->lo_device);
-		kill_bdev(lo->lo_device);
-	}
+	if (lo->lo_state == Lo_bound) {
+		if (lo->lo_queue->limits.logical_block_size != arg) {
+			sync_blockdev(lo->lo_device);
+			kill_bdev(lo->lo_device);
+		}
 
-	blk_mq_freeze_queue(lo->lo_queue);
+		blk_mq_freeze_queue(lo->lo_queue);
 
-	/* kill_bdev should have truncated all the pages */
-	if (lo->lo_queue->limits.logical_block_size != arg &&
-			lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
+		/* kill_bdev should have truncated all the pages */
+		if (lo->lo_queue->limits.logical_block_size != arg &&
+				lo->lo_device->bd_inode->i_mapping->nrpages) {
+			err = -EAGAIN;
+			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+				__func__, lo->lo_number, lo->lo_file_name,
+				lo->lo_device->bd_inode->i_mapping->nrpages);
+			goto out_unfreeze;
+		}
 	}
 
 	blk_queue_logical_block_size(lo->lo_queue, arg);
@@ -1538,7 +1541,8 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
 out_unfreeze:
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (lo->lo_state == Lo_bound)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	return err;
 }
-- 
2.23.0.rc1.153.gdeed80330f-goog

