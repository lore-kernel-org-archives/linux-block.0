Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63724C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiGNSIC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiGNSIB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:01 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7417C68721
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:59 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id w185so2557913pfb.4
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXTMKIYVsK41jXBooLaWcI4td18LmwnUZV7rQjDrmLQ=;
        b=zud+Fw3bBnBlqsTGiEVrOOUCfPmdm0B28c4TX8p458EP0njj30NJU3vRtC2WcnUwPN
         Cfi4uUusZ3mIO/Qc9POS6ldrBsawsHSr8z6VLRux3kA+/TYUt/a9/V6B3LYy/x/HxZlj
         7pY5miLcu3QMM22Lck2FudwjNly2m30A1RZ/dcPtISoMnQEbfJBXttut75mCELNMDD+u
         Go0JxtO/+QBppXDtTUL1aG0FBAJXRbWu5pVHaRWTzQORTNgTUipv9VgIFFvS0Ue3alr9
         E3IhpkdA4Rg2ny8F8JYzZEcVlkjeCHuuu6jAZjoSdoOTyyCJQYFVKcr/dVpMLDnZ4mbJ
         okSQ==
X-Gm-Message-State: AJIora92RSvtsgohLRgHyBgLtjtt3wHHWDTEa/ldYDly6HzxfDMBTmXC
        Xzxhxl7I7WXLDJyo/32etpA=
X-Google-Smtp-Source: AGRyM1vB2beZAnb1TTgfT6cAEHNKPzGMHn7NqHHsIvWMrI2HHf3JivLl0XbtZ5+HRcMWQgSETeQDAA==
X-Received: by 2002:a63:1923:0:b0:419:b27c:7acf with SMTP id z35-20020a631923000000b00419b27c7acfmr3773964pgl.449.1657822078619;
        Thu, 14 Jul 2022 11:07:58 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH v3 14/63] block/drbd: Combine two drbd_submit_peer_request() arguments
Date:   Thu, 14 Jul 2022 11:06:40 -0700
Message-Id: <20220714180729.1065367-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine the drbd_submit_peer_request() 'op' and 'op_flags' arguments
into a single argument. This patch does not change any functionality.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_int.h      |  3 +--
 drivers/block/drbd/drbd_receiver.c | 15 +++++++--------
 drivers/block/drbd/drbd_worker.c   |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index ecb2ecd8d67d..f15f2f041596 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1547,8 +1547,7 @@ extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
 extern int drbd_submit_peer_request(struct drbd_device *,
-				    struct drbd_peer_request *, enum req_op,
-				    blk_opf_t, int);
+				    struct drbd_peer_request *, blk_opf_t, int);
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
 						     sector_t, unsigned int,
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index caf646dd91ba..af4c7d65490b 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1621,8 +1621,7 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
 /* TODO allocate from our own bio_set. */
 int drbd_submit_peer_request(struct drbd_device *device,
 			     struct drbd_peer_request *peer_req,
-			     const enum req_op op, const blk_opf_t op_flags,
-			     const int fault_type)
+			     const blk_opf_t opf, const int fault_type)
 {
 	struct bio *bios = NULL;
 	struct bio *bio;
@@ -1668,8 +1667,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * generated bio, but a bio allocated on behalf of the peer.
 	 */
 next_bio:
-	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, op | op_flags,
-			GFP_NOIO);
+	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, opf, GFP_NOIO);
 	/* > peer_req->i.sector, unless this is the first bio */
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = peer_req;
@@ -2060,7 +2058,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(pi->size >> 9, &device->rs_sect_ev);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE, 0,
+	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE,
 				     DRBD_FAULT_RS_WR) == 0)
 		return 0;
 
@@ -2682,7 +2680,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 		peer_req->flags |= EE_CALL_AL_COMPLETE_IO;
 	}
 
-	err = drbd_submit_peer_request(device, peer_req, op, op_flags,
+	err = drbd_submit_peer_request(device, peer_req, op | op_flags,
 				       DRBD_FAULT_DT_WR);
 	if (!err)
 		return 0;
@@ -2980,7 +2978,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 submit:
 	update_receiver_timing_details(connection, drbd_submit_peer_request);
 	inc_unacked(device);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ, 0,
+	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
 				     fault_type) == 0)
 		return 0;
 
@@ -4970,7 +4968,8 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 		spin_unlock_irq(&device->resource->req_lock);
 
 		atomic_add(pi->size >> 9, &device->rs_sect_ev);
-		err = drbd_submit_peer_request(device, peer_req, op, 0, DRBD_FAULT_RS_WR);
+		err = drbd_submit_peer_request(device, peer_req, op,
+					       DRBD_FAULT_RS_WR);
 
 		if (err) {
 			spin_lock_irq(&device->resource->req_lock);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index af3051dd8912..0bb1a900c2d5 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -405,7 +405,7 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(size >> 9, &device->rs_sect_ev);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ, 0,
+	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
 				     DRBD_FAULT_RS_RD) == 0)
 		return 0;
 
