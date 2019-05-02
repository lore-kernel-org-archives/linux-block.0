Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A2C43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C82B20652
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 17:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B8710WYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfEBRo2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 13:44:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfEBRoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 13:44:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id y13so1471493pfm.11
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uN5X8DUEMQPUBTVS1/pgtLkQocX9RzJ+FmBoMdljaw=;
        b=B8710WYZnaCMf4TZVtd6PCJnURCPKXx92qNHChx45j/qLHsi9vAPUtsK3W9179oP3E
         t666/VxF3lIq8OWdFeJkFc6WShlfeyi7OdcjJywwadlyK1KsRw9oMxXJcFwDW+PYxP6M
         oEohYkbxS/r/wfEi9jAKVFju4CbYsWmQMr9Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uN5X8DUEMQPUBTVS1/pgtLkQocX9RzJ+FmBoMdljaw=;
        b=ZrCyP44490GDotoo6+FhuQX1xjWBneRpPiTb9DXeLaycuStlO1z3idssAQF0QlxqJv
         IqESsHxLpLp+OnbpA6V59jEA51cTxeibknevDzShrS2MjC875nB5DtxGc5UhGn2mFtdo
         47hf0CHZImnGtcatxLuDnqZOkxz669TL5RI04eJhhhESGI7cAwV7awXr2ClKD4QN0pwB
         zC5//8WxKwEisVcBxB5O+FnSNH5NELRvLaSG+DRJ8naQ3qhQT+sEAxurXS6/9C//nvcL
         p9WrGYQwCPHYc8xSQTsAo0Jn4/orN+9brInC2qEp/evpLoF0gbJujaZS1byen3MICnnd
         GJiw==
X-Gm-Message-State: APjAAAV0mhyUFk9VBAj0NLYo/GfcUWQFRRBX7ZokO2SQ1yHYywMb6A7e
        LyUgEqRsFwTd4VjLtAwanfp1sQ==
X-Google-Smtp-Source: APXvYqz3MY9OMIuD+T0t4msuqTRgvVxefRUpziJVAJNiLJILsr2BmkxndT3cMrri8m2C+eL8ELrfaw==
X-Received: by 2002:a63:4548:: with SMTP id u8mr5203600pgk.435.1556819059317;
        Thu, 02 May 2019 10:44:19 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id w38sm48319600pgk.90.2019.05.02.10.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 10:44:18 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Martin K Petersen <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        Evan Green <evgreen@chromium.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] loop: Better discard support for block devices
Date:   Thu,  2 May 2019 10:44:09 -0700
Message-Id: <20190502174409.74623-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502174409.74623-1-evgreen@chromium.org>
References: <20190502174409.74623-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the backing device for a loop device is a block device,
then mirror the "write zeroes" capabilities of the underlying
block device into the loop device. Copy this capability into both
max_write_zeroes_sectors and max_discard_sectors of the loop device.

The reason for this is that REQ_OP_DISCARD on a loop device translates
into blkdev_issue_zeroout(), rather than blkdev_issue_discard(). This
presents a consistent interface for loop devices (that discarded data
is zeroed), regardless of the backing device type of the loop device.
There should be no behavior change for loop devices backed by regular
files.

While in there, differentiate between REQ_OP_DISCARD and
REQ_OP_WRITE_ZEROES, which are different for block devices,
but which the loop device had just been lumping together, since
they're largely the same for files.

This change fixes blktest block/003, and removes an extraneous
error print in block/013 when testing on a loop device backed
by a block device that does not support discard.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v4:
- Mirror blkdev's write_zeroes into loopdev's discard_sectors.

Changes in v3:
- Updated commit description

Changes in v2: None

 drivers/block/loop.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bbf21ebeccd3..ca6983a2c975 100644
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
@@ -854,6 +854,21 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	struct request_queue *backingq;
+
+	/*
+	 * If the backing device is a block device, mirror its zeroing
+	 * capability. REQ_OP_DISCARD translates to a zero-out even when backed
+	 * by block devices to keep consistent behavior with file-backed loop
+	 * devices.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		backingq = bdev_get_queue(inode->i_bdev);
+		blk_queue_max_discard_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
+
+		blk_queue_max_write_zeroes_sectors(q,
+			backingq->limits.max_write_zeroes_sectors);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -861,22 +876,24 @@ static void loop_config_discard(struct loop_device *lo)
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
+	if (q->limits.max_write_zeroes_sectors)
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.20.1

