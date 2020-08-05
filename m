Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F6C433E0
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 03:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF720842
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 03:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMD9MfQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHEDvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:51:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726305AbgHEDvT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 23:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596599477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ySoQ5qJnA38SiPRsXu9olzx0oU4pP4Oj7en7ht6ixIo=;
        b=JMD9MfQ4ZtAJUDL0k6CWZ31kvbaYOAWDVpOWjuSTD/XpgKqUkp2SaE0MMPOTBuSuF4elum
        /1eTmRQ1tiuo+kplAzjqm5gGLH3DO++wbKmsVESqx/4bl1PZYtgOks5ELBWQohGzCyrk5f
        XJcvvE6L5SjNAAIfjFDoTqMA26VggB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-AfxsEk52MRC0yFJPlcppNQ-1; Tue, 04 Aug 2020 23:51:14 -0400
X-MC-Unique: AfxsEk52MRC0yFJPlcppNQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59CC2800461;
        Wed,  5 Aug 2020 03:51:12 +0000 (UTC)
Received: from localhost (ovpn-13-169.pek2.redhat.com [10.72.13.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA3775C1D2;
        Wed,  5 Aug 2020 03:51:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.com>,
        Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] block: loop: set discard granularity and alignment for block device backed loop
Date:   Wed,  5 Aug 2020 11:50:59 +0800
Message-Id: <20200805035059.1989050-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of block device backend, if the backend supports write zeros, the
loop device will set queue flag of QUEUE_FLAG_DISCARD. However,
limits.discard_granularity isn't setup, and this way is wrong,
see the following description in Documentation/ABI/testing/sysfs-block:

	A discard_granularity of 0 means that the device does not support
	discard functionality.

Especially 9b15d109a6b2 ("block: improve discard bio alignment in
__blkdev_issue_discard()") starts to take q->limits.discard_granularity
for computing max discard sectors. And zero discard granularity may cause
kernel oops, or fail discard request even though the loop queue claims
discard support via QUEUE_FLAG_DISCARD.

Fix the issue by setup discard granularity and alignment.

Fixes: c52abf563049 ("loop: Better discard support for block devices")
Cc: Coly Li <colyli@suse.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Xiao Ni <xni@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Evan Green <evgreen@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- mirror backing queue's discard_granularity to loop queue
	- set discard limit parameters explicitly when QUEUE_FLAG_DISCARD is
	set

 drivers/block/loop.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d18160146226..661c0814d63c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -878,6 +878,7 @@ static void loop_config_discard(struct loop_device *lo)
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct request_queue *q = lo->lo_queue;
+	u32 granularity, max_discard_sectors;
 
 	/*
 	 * If the backing device is a block device, mirror its zeroing
@@ -890,11 +891,10 @@ static void loop_config_discard(struct loop_device *lo)
 		struct request_queue *backingq;
 
 		backingq = bdev_get_queue(inode->i_bdev);
-		blk_queue_max_discard_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
 
-		blk_queue_max_write_zeroes_sectors(q,
-			backingq->limits.max_write_zeroes_sectors);
+		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
+		granularity = backingq->limits.discard_granularity ?:
+			queue_physical_block_size(backingq);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
@@ -903,23 +903,26 @@ static void loop_config_discard(struct loop_device *lo)
 	 * useful information.
 	 */
 	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
-		q->limits.discard_granularity = 0;
-		q->limits.discard_alignment = 0;
-		blk_queue_max_discard_sectors(q, 0);
-		blk_queue_max_write_zeroes_sectors(q, 0);
+		max_discard_sectors = 0;
+		granularity = 0;
 
 	} else {
-		q->limits.discard_granularity = inode->i_sb->s_blocksize;
-		q->limits.discard_alignment = 0;
-
-		blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
-		blk_queue_max_write_zeroes_sectors(q, UINT_MAX >> 9);
+		max_discard_sectors = UINT_MAX >> 9;
+		granularity = inode->i_sb->s_blocksize;
 	}
 
-	if (q->limits.max_write_zeroes_sectors)
+	if (max_discard_sectors) {
+		q->limits.discard_granularity = granularity;
+		blk_queue_max_discard_sectors(q, max_discard_sectors);
+		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
-	else
+	} else {
+		q->limits.discard_granularity = 0;
+		blk_queue_max_discard_sectors(q, 0);
+		blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, q);
+	}
+	q->limits.discard_alignment = 0;
 }
 
 static void loop_unprepare_queue(struct loop_device *lo)
-- 
2.25.2

