Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB786C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiGNSIB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbiGNSH7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:59 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3849168719
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:57 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id z1so1117954plb.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXAZiGo4IM6Y00mSdVkzbdsABep+VjHKzV4gMdYxjwM=;
        b=mtrh6g6EhBsXRGFFUeOXVF84uvTsD0YPBo7dqEKhrEFyL4jHqtP0h/5V9BJpDA+FIG
         ILYm10ZNWHv7u+L+/Btg7yB+id7ap2LQwAoEpIKPBogy/fNwyFWZF7NhcrezNCUc62DS
         aoxUaZbEC0FSIV0C69J9qlb7jWBWSWnmar0xmlz+x7i3dHP5TuvuYOix4Ejn038143Ls
         7ZZDXBf7/iDD2IBLSybrH2WacBsMtDVNMlt9aGjoAL5Bc4vJu3Igl8mgQGMsRUJhCyJk
         YxjbirbMg2Cm2SPhhK60xT/qojUp4okwYCVb18puHxbz/ED2lnsQ/dRx3U8H9FvmDmy+
         BCgg==
X-Gm-Message-State: AJIora/kXO2/ux2YxfvA3rJuBORj8OdELnz41JX90PfiTHEpQ7EbGXnf
        hAuyR9m2Z++apGi47lHI8+A=
X-Google-Smtp-Source: AGRyM1tKG/sr6PIuoNvaKRnPuyebm+K2hun0jQpscAZNIXYmQnqJPwSCI6VeITQ8OTYZ4iNGucafbA==
X-Received: by 2002:a17:90b:2bd3:b0:1ef:9ac7:d90c with SMTP id ru19-20020a17090b2bd300b001ef9ac7d90cmr11019314pjb.53.1657822077010;
        Thu, 14 Jul 2022 11:07:57 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:56 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH v3 13/63] block/drbd: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:06:39 -0700
Message-Id: <20220714180729.1065367-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Reviewed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_actlog.c   |  9 +++++----
 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_int.h      |  6 +++---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index f5bcded3640d..e27478ae579c 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -124,12 +124,13 @@ void wait_until_done_or_force_detached(struct drbd_device *device, struct drbd_b
 
 static int _drbd_md_sync_page_io(struct drbd_device *device,
 				 struct drbd_backing_dev *bdev,
-				 sector_t sector, int op)
+				 sector_t sector, enum req_op op)
 {
 	struct bio *bio;
 	/* we do all our meta data IO in aligned 4k blocks. */
 	const int size = 4096;
-	int err, op_flags = 0;
+	int err;
+	blk_opf_t op_flags = 0;
 
 	device->md_io.done = 0;
 	device->md_io.error = -ENODEV;
@@ -174,7 +175,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 }
 
 int drbd_md_sync_page_io(struct drbd_device *device, struct drbd_backing_dev *bdev,
-			 sector_t sector, int op)
+			 sector_t sector, enum req_op op)
 {
 	int err;
 	D_ASSERT(device, atomic_read(&device->md_io.in_use) == 1);
@@ -385,7 +386,7 @@ static int __al_write_transaction(struct drbd_device *device, struct al_transact
 		write_al_updates = rcu_dereference(device->ldev->disk_conf)->al_updates;
 		rcu_read_unlock();
 		if (write_al_updates) {
-			if (drbd_md_sync_page_io(device, device->ldev, sector, WRITE)) {
+			if (drbd_md_sync_page_io(device, device->ldev, sector, REQ_OP_WRITE)) {
 				err = -EIO;
 				drbd_chk_io_error(device, 1, DRBD_META_IO_ERROR);
 			} else {
diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 9e060e49b3f8..603f6828dd79 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -977,7 +977,7 @@ static void drbd_bm_endio(struct bio *bio)
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
 	struct drbd_device *device = ctx->device;
-	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
+	enum req_op op = ctx->flags & BM_AIO_READ ? REQ_OP_READ : REQ_OP_WRITE;
 	struct bio *bio = bio_alloc_bioset(device->ldev->md_bdev, 1, op,
 					   GFP_NOIO, &drbd_md_io_bio_set);
 	struct drbd_bitmap *b = device->bitmap;
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4d3efaa20b7b..ecb2ecd8d67d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1495,7 +1495,7 @@ extern int drbd_resync_finished(struct drbd_device *device);
 extern void *drbd_md_get_buffer(struct drbd_device *device, const char *intent);
 extern void drbd_md_put_buffer(struct drbd_device *device);
 extern int drbd_md_sync_page_io(struct drbd_device *device,
-		struct drbd_backing_dev *bdev, sector_t sector, int op);
+		struct drbd_backing_dev *bdev, sector_t sector, enum req_op op);
 extern void drbd_ov_out_of_sync_found(struct drbd_device *, sector_t, int);
 extern void wait_until_done_or_force_detached(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, unsigned int *done);
@@ -1547,8 +1547,8 @@ extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
 extern int drbd_submit_peer_request(struct drbd_device *,
-				    struct drbd_peer_request *, const unsigned,
-				    const unsigned, const int);
+				    struct drbd_peer_request *, enum req_op,
+				    blk_opf_t, int);
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
 						     sector_t, unsigned int,
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 6762be53f409..caf646dd91ba 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1621,7 +1621,7 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
 /* TODO allocate from our own bio_set. */
 int drbd_submit_peer_request(struct drbd_device *device,
 			     struct drbd_peer_request *peer_req,
-			     const unsigned op, const unsigned op_flags,
+			     const enum req_op op, const blk_opf_t op_flags,
 			     const int fault_type)
 {
 	struct bio *bios = NULL;
@@ -2383,14 +2383,14 @@ static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, co
 /* see also bio_flags_to_wire()
  * DRBD_REQ_*, because we need to semantically map the flags to data packet
  * flags and back. We may replicate to other kernel versions. */
-static unsigned long wire_flags_to_bio_flags(u32 dpf)
+static blk_opf_t wire_flags_to_bio_flags(u32 dpf)
 {
 	return  (dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
 		(dpf & DP_FUA ? REQ_FUA : 0) |
 		(dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
 }
 
-static unsigned long wire_flags_to_bio_op(u32 dpf)
+static enum req_op wire_flags_to_bio_op(u32 dpf)
 {
 	if (dpf & DP_ZEROES)
 		return REQ_OP_WRITE_ZEROES;
@@ -2543,7 +2543,8 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	struct drbd_peer_request *peer_req;
 	struct p_data *p = pi->data;
 	u32 peer_seq = be32_to_cpu(p->seq_num);
-	int op, op_flags;
+	enum req_op op;
+	blk_opf_t op_flags;
 	u32 dp_flags;
 	int err, tp;
 
@@ -4951,7 +4952,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 
 	if (get_ldev(device)) {
 		struct drbd_peer_request *peer_req;
-		const int op = REQ_OP_WRITE_ZEROES;
+		const enum req_op op = REQ_OP_WRITE_ZEROES;
 
 		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
 					       size, 0, GFP_NOIO);
