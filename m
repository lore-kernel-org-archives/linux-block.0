Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2451FCCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiF2XcS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiF2XcR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:17 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA330B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:16 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so998986pjj.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOKz1vz36ekTFkt5iNaupDT1HbjBUI9gkJDskhXPeIA=;
        b=i2q17DRlUucbf0XpEt3Dn95dNJRJj8NW6PjM99np0b71Ll+cEZFJYg8apm041/5qHh
         f9XSNFTf4G+lBN3QPj5b+9Ir31rZryHymoPlnIH2fzF+C+hjl5epf3VwKvBWVZ1XV+mO
         HNuYhnljwmnJAtJcEZGKnel9YMnKnwTsGMs6SbH3P/9Dr8qYHndgHgdc5hct43wteAhr
         2UAt6aJcujfrbNyaxns3AT2mvAgtKnb2xQhL8kOtn0OV3P1inFFFTe1KNhrkJcE8hlyz
         yPmjpkIN1PcL41nI+nkuv24xgUug+ky8go/1sqEFGTSmnSMJWuT/bP+G5LkI1MJKW5D+
         jjeA==
X-Gm-Message-State: AJIora851hfyMmx1Xiw4IgMKHu2AaNdjhloiP2KFGj+CFVTtAi8qKWSz
        FoTaGJ4PVrxL4Y8Mh2xF+SM=
X-Google-Smtp-Source: AGRyM1s7a6Yh7eDXDnsHIbm+GWzdvCECvYbEJp2FFEcT06FKW4m1gpZ5nwoW/U2aJF5ZhIzjULW3DA==
X-Received: by 2002:a17:90b:360d:b0:1ef:1250:8e6f with SMTP id ml13-20020a17090b360d00b001ef12508e6fmr6451098pjb.180.1656545536160;
        Wed, 29 Jun 2022 16:32:16 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH v2 14/63] block/drbd: Combine two drbd_submit_peer_request() arguments
Date:   Wed, 29 Jun 2022 16:30:56 -0700
Message-Id: <20220629233145.2779494-15-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine the drbd_submit_peer_request() 'op' and 'op_flags' arguments
into a single argument. This patch does not change any functionality.

Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
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
 
