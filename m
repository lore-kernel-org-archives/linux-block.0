Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC5C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiF2XcQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiF2XcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:15 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7A30B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:14 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id x4so16521633pfq.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCVLAZbL04u9SZVrKjYZMprVfwgufd4QJXKbK7cpmxg=;
        b=NUqHpe+f/+I6Jvlk4XGgmeG60M0+RE31sPQkFOKImRzyu9onJ+Gup5VqGWUuLV6Al7
         ciFYjnea9/SfodCk1Ag2WKguzker0a8zbaNsgQYYtfZeQbBnRnjSmatmzYWNnu3ymU6L
         X45wqlXxHZswQAe5O9D0hAvb9y0peSo2MdH5dAwDv1zIYt7A5W5/t/yR2XuNDt0MZmU+
         nEJDpnuPvTPFC77c6DxxV1w8qHDLk8f6/EzK9ZWHOsMZL3j4lPVqf/1WXvJhXe2WABOJ
         iALQ+3ITqd9FHQL6Ne2/z9///6QxwQgePV8pBUpUkKbNos5NHCKa3CxBVA/OacSA1GCa
         W1mQ==
X-Gm-Message-State: AJIora//3NU+NOJCJpnB7480+qG5djg00LXKooUwkY/SjbayAEwkmpC/
        efnhktgtuNLeqNXMMCccaM4=
X-Google-Smtp-Source: AGRyM1utn8NvgILBRLYv4PiYQbv9A+2yd23sK+pHJTgOa+lsfm4UQKMN7d8X/+9V1UxgHzGApUfCZA==
X-Received: by 2002:a63:28c:0:b0:3c1:6f72:7288 with SMTP id 134-20020a63028c000000b003c16f727288mr4993859pgc.564.1656545534510;
        Wed, 29 Jun 2022 16:32:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>
Subject: [PATCH v2 13/63] block/drbd: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:30:55 -0700
Message-Id: <20220629233145.2779494-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
 drivers/block/drbd/drbd_bitmap.c   |  3 ++-
 drivers/block/drbd/drbd_int.h      |  6 +++---
 drivers/block/drbd/drbd_receiver.c | 11 ++++++-----
 4 files changed, 16 insertions(+), 13 deletions(-)

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
index bd2133ef6e0a..0845f28a48a7 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -990,7 +990,8 @@ static inline sector_t drbd_md_last_bitmap_sector(struct drbd_backing_dev *bdev)
 static void bm_page_io_async(struct drbd_bm_aio_ctx *ctx, int page_nr) __must_hold(local)
 {
 	struct drbd_device *device = ctx->device;
-	unsigned int op = (ctx->flags & BM_AIO_READ) ? REQ_OP_READ : REQ_OP_WRITE;
+	const enum req_op op = ctx->flags & BM_AIO_READ ? REQ_OP_READ :
+		REQ_OP_WRITE;
 	struct drbd_bitmap *b = device->bitmap;
 	struct bio *bio;
 	struct page *page;
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
