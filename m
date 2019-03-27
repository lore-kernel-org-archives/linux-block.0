Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98109C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA1621738
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UuxxeyOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfC0W3E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:29:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37338 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbfC0W24 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 18:28:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id 8so10368602pfr.4
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYWuwfE/DeGo/A1CHMZZFvsRrpeE2/SycqG1x6uy3nw=;
        b=UuxxeyOmOFarpObTwkTeOFvi6Yr1E8o5qMwOWd7tt84GNSA08rUaTrCP4uGjLrAuPA
         N6GM4MD3hU1NczbHS0fklLSKVkUeOBFooMUJ1hIK38pP1pKiuWX9zzQhPjChhy+Xjvxr
         DeWixwsSy5NxR/T+ql2Ml7/4lgctS3M+H3irg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYWuwfE/DeGo/A1CHMZZFvsRrpeE2/SycqG1x6uy3nw=;
        b=nVbnFtMxR0rEJNFSvgRMqWNl2hzYCK4ogcYVAcdbHrvb7MC+ucQpodc1W9z5CdGC91
         chQoAbRq10/L6paJhrofWpq8BjktgWK6xllZHgieBVniMgiup5oWKKH7RN5mEUXHtfZJ
         npaEZ1M+PZ9QeB4mpSWA+/QC8rYC94icWOcmbORq1F3vkIKlqU/Bri0dbDt4Lm551S4L
         ANLM3jGbynq/EsCXtiO2t22Z0mJg2efUH42tM7W3hpcPL2DH3oyzdLLffwZginSBj5st
         lv6+gTqxUvQivvJEhSu+2/jBDiveupu3sH9mnnnaygN91tp3FXk4YSDMSrOR6uyRYSIn
         2lXw==
X-Gm-Message-State: APjAAAV3VRE13BPW2ut7B0rXIL9ODn+l6T8aTo7/HsVlbOnq+HkhGIWj
        HymTYIKar06i2TYgc0wazZglvQ==
X-Google-Smtp-Source: APXvYqxmqU8ek/cpCeFMpA9uEEBz/u+1kZBc6p+KdcKu3NW8LivYh8filJRJldSvP7R9v9RbLvblUg==
X-Received: by 2002:a62:59cb:: with SMTP id k72mr38709411pfj.111.1553725736019;
        Wed, 27 Mar 2019 15:28:56 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id p88sm36928347pfa.80.2019.03.27.15.28.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 15:28:55 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] loop: Better discard support for block devices
Date:   Wed, 27 Mar 2019 15:28:41 -0700
Message-Id: <20190327222841.38650-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190327222841.38650-1-evgreen@chromium.org>
References: <20190327222841.38650-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the backing device for a loop device is a block device,
then mirror the discard properties of the underlying block
device into the loop device. This new change only applies to
loop devices backed directly by a block device, not loop
devices backed by regular files.

While in there, differentiate between REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES, which are different for block devices,
but which the loop device had just been lumping together, since
they're largely the same for files.

This change fixes blktest block/003, and removes an extraneous
error print in block/013 when testing on a loop device backed
by a block device that does not support discard.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Updated commit description

Changes in v2: None

 drivers/block/loop.c | 61 +++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bbf21ebeccd3..e1edd004298a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -417,19 +417,14 @@ static int lo_read_transfer(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
+static int lo_discard(struct loop_device *lo, struct request *rq,
+		int mode, loff_t pos)
 {
-	/*
-	 * We use punch hole to reclaim the free space used by the
-	 * image a.k.a. discard. However we do not support discard if
-	 * encryption is enabled, because it may give an attacker
-	 * useful information.
-	 */
 	struct file *file = lo->lo_backing_file;
-	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	struct request_queue *q = lo->lo_queue;
 	int ret;
 
-	if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
+	if (!blk_queue_discard(q)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
@@ -599,8 +594,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_FLUSH:
 		return lo_req_flush(lo, rq);
 	case REQ_OP_DISCARD:
+		return lo_discard(lo, rq,
+			FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE_ZEROES:
-		return lo_discard(lo, rq, pos);
+		return lo_discard(lo, rq,
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE, pos);
+
 	case REQ_OP_WRITE:
 		if (lo->transfer)
 			return lo_write_transfer(lo, rq, pos);
@@ -854,6 +854,25 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	struct request_queue *backingq;
+
+	/*
+	 * If the backing device is a block device, mirror its discard
+	 * capabilities.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		backingq = bdev_get_queue(inode->i_bdev);
+		blk_queue_max_discard_sectors(q,
+			backingq->limits.max_discard_sectors);
+
+		blk_queue_max_write_zeroes_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
+		q->limits.discard_granularity =
+			backingq->limits.discard_granularity;
+
+		q->limits.discard_alignment =
+			backingq->limits.discard_alignment;
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -861,22 +880,24 @@ static void loop_config_discard(struct loop_device *lo)
 	 * encryption is enabled, because it may give an attacker
 	 * useful information.
 	 */
-	if ((!file->f_op->fallocate) ||
-	    lo->lo_encrypt_key_size) {
+	} else if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
 		q->limits.discard_granularity = 0;
 		q->limits.discard_alignment = 0;
 		blk_queue_max_discard_sectors(q, 0);
 		blk_queue_max_write_zeroes_sectors(q, 0);
-		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
-		return;
-	}
 
-	q->limits.discard_granularity = inode->i_sb->s_blocksize;
-	q->limits.discard_alignment = 0;
+	} else {
+		q->limits.discard_granularity = inode->i_sb->s_blocksize;
+		q->limits.discard_alignment = 0;
+
+		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
+		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+	}
 
-	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-	blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	if (q->limits.max_discard_sectors || q->limits.max_write_zeroes_sectors)
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.20.1

