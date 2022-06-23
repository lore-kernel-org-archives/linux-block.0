Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7F8C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiFWTAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiFWTA3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:29 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FA210CD2F
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:50 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id u37so324643pfg.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w3UvXl/RfnduAkP3mhS5FXVzLYyRvEiflC5jl8OcZ5o=;
        b=EG/Lo9Knlhu/KC3UQAJrcOP2SuM9VqFUMnAelsh2IlUcgnRkiC5NRJWWSJMNbgiLbL
         fwHHuJNomslvAYMQvuNAyeoLSKq3IkTauRhSIvW3U0R0J86cjLyGyBiAb9+oIqwIytaj
         jUw8WDyJSwbuvWHitUqpTI6U/KBKOtrn+QjvR80nst9CV4EfoevKeycacHls6zWULdIf
         QBbsu++ZIqGTRwIZSTnTLxqG60mJDoCkwH1Eo6PsU3EyYZ+1fXGGx2DcDIPt741GEEVY
         u6nfPUMn9cwP7zKl8naUUge6DYlZkajzSadYdL94S687y8k9AjSr3w+h1jY6ZjLiRblF
         MqpA==
X-Gm-Message-State: AJIora9nV/WS+mcmJaANAf5fq9fRSltnFBW8XPwAX3GTF6pZGyuqv+ur
        tkIn9M6dbXceYvhO3Nw7o5E=
X-Google-Smtp-Source: AGRyM1vMhhCUNXpLyRgey4C93QnyHKIhhOd/gln1tAt2+FmtcmxQN0K/ezgRd+6SAOiTA1vhTIOk7g==
X-Received: by 2002:a63:4f04:0:b0:408:8206:5bcd with SMTP id d4-20020a634f04000000b0040882065bcdmr8560148pgb.105.1656007549584;
        Thu, 23 Jun 2022 11:05:49 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:48 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 10/51] block/drbd: Use the enum req_op and blk_opf_t types
Date:   Thu, 23 Jun 2022 11:04:47 -0700
Message-Id: <20220623180528.3595304-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags.

Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
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
