Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF2FC433DF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 08:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBF5206E2
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 08:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NmgPDPaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGGIqU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:46:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbgGGIqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 04:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594111579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X3/5qKEEIHenwqx1XIbYlB5tYhqdYlS0V/aQaqfa+0k=;
        b=NmgPDPaYPWbAfkJgGRKqh2npI8S3mOcTkPRRgKnXmn+vvwcSdYoj3E3MsR2TrKUgfCpF+4
        VO9z1YuAYiaCAWY7HS55LuKrv3NxPdZL/g2nWVf/EE+n/rr0nSws0z2QJfYUutigkHdLmN
        yWoM/2VaC8ix7x0ucAeS6fqoJTGf78A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-9c5N46fbP_Oxq5FHfheEUA-1; Tue, 07 Jul 2020 04:46:15 -0400
X-MC-Unique: 9c5N46fbP_Oxq5FHfheEUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453BC461;
        Tue,  7 Jul 2020 08:46:14 +0000 (UTC)
Received: from localhost (ovpn-12-188.pek2.redhat.com [10.72.12.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B1C160BF3;
        Tue,  7 Jul 2020 08:46:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] block: loop: delete partitions after clearing & changing fd
Date:   Tue,  7 Jul 2020 16:45:52 +0800
Message-Id: <20200707084552.3294693-3-ming.lei@redhat.com>
In-Reply-To: <20200707084552.3294693-1-ming.lei@redhat.com>
References: <20200707084552.3294693-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After clearing fd or changing fd, we have to delete old partitions,
otherwise they may become ghost partitions.

Fix this issue by clearing GENHD_FL_NO_PART_SCAN during calling
bdev_disk_changed() which won't drop old partitions if GENHD_FL_NO_PART_SCAN
isn't set.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0e08468b9ce0..cf71a1bbcd45 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -650,17 +650,26 @@ static inline void loop_update_dio(struct loop_device *lo)
 }
 
 static void loop_reread_partitions(struct loop_device *lo,
-				   struct block_device *bdev, bool locked)
+				   struct block_device *bdev, bool locked,
+				   bool force_scan)
 {
 	int rc;
+	bool no_scan;
 
-	if (locked) {
-		rc = bdev_disk_changed(bdev, false);
-	} else {
+	if (!locked)
 		mutex_lock(&bdev->bd_mutex);
-		rc = bdev_disk_changed(bdev, false);
+
+	no_scan = lo->lo_disk->flags & GENHD_FL_NO_PART_SCAN;
+	if (force_scan && no_scan)
+		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+
+	rc = bdev_disk_changed(bdev, false);
+
+	if (force_scan && no_scan)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+
+	if (!locked)
 		mutex_unlock(&bdev->bd_mutex);
-	}
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -758,7 +767,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	 */
 	fput(old_file);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, true);
 	return 0;
 
 out_err:
@@ -1183,7 +1192,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	bdgrab(bdev);
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, false);
 	if (claimed_bdev)
 		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
 	return 0;
@@ -1274,7 +1283,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		loop_reread_partitions(lo, bdev, release);
+		loop_reread_partitions(lo, bdev, release, true);
 	}
 
 	/*
@@ -1415,7 +1424,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan)
-		loop_reread_partitions(lo, bdev, false);
+		loop_reread_partitions(lo, bdev, false, false);
 
 	return err;
 }
-- 
2.25.2

