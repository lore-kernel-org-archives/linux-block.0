Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A6C4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 09:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiJQJCb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 05:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbiJQJC3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 05:02:29 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE92CE08
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 02:02:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r14so15042256edc.7
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 02:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyIBpa3bTnnDtimMMPiGhNnHhdO52yLRUstRRKbUhJ8=;
        b=ulhGiN4soXuS5KmM1YMAwKIR2KnB6r9pKDhy82pAiji2oXQUh+U96txIRe9mA3KEoQ
         1Tm937rUAGAJZxZfL6MjnOzmAhNHmHWk5A14B/P9YhZAyOoLVRvpM5nGyTDTBq4KHiww
         AGYYTbqNDsZxtKjK8tR9QUSDl8uvguMlbJi49etNg7TA2cviNq4rnp5O9E7feplg5ks0
         lDJIi9bp7OPLGAHIn2GdkQHpRtwPBAWTATLWBjBBKQw+lr4munHlTBENv4KQtR62HKAL
         JE9A7SsE6XEkqcKcXJrFpcAuc2t5QvgWSEix9CYfv8wD40nWytHfnPfRym8Ma4fEEsbZ
         arew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyIBpa3bTnnDtimMMPiGhNnHhdO52yLRUstRRKbUhJ8=;
        b=mUQmUEA6fE4jSrLny6iZuDIqOmEHlCatzSIh2zH3WbB4H8NKT2etXK+x6ORncxhzuS
         R4BLLBAjymrqtBt8oAmMGMHNyxymyxgEMwCoTkn4i00Ce3S2nZShQy7LXXDfcenVv2bk
         ZIQrCfJJeEhfoZ0TrZK7D4TJOTiBOPpTPMkx71vhanTD6/o1ILeAD5goC0lujrr9X5cs
         LxzzHFTmUZZ0XK7J4K/UvHIUYb6jmTOg8AC93k9DJAs1vkYdXv3j0+gqgK+2+i8xCEy8
         lPR4sSoudZKISTRHJHYjZ8CVx0wtNwOjhz5yKPDx5S69sa9cZkSGjilsABo1cUFyt3kv
         WFgw==
X-Gm-Message-State: ACrzQf2Rx8OGXvKwd7So0Nsep7/Pdf51HmRfwTtCtwB4WUcpleUqRC18
        ASQB5+wAPV5G1wVDKghNMsXUiw==
X-Google-Smtp-Source: AMsMyM6XwaK3rqfreGiuadZXYAW13YPPLgydIyI948aduyZ5oPqDccCE+WwkDCzjwHLXMW5RLQTCog==
X-Received: by 2002:a05:6402:e9d:b0:443:7833:3d7b with SMTP id h29-20020a0564020e9d00b0044378333d7bmr9043547eda.151.1665997341270;
        Mon, 17 Oct 2022 02:02:21 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id sd42-20020a1709076e2a00b0076ff600bf2csm5768092ejc.63.2022.10.17.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:02:20 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH] drbd: Store op in drbd_peer_request
Date:   Mon, 17 Oct 2022 11:01:54 +0200
Message-Id: <20221017090154.15696-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

(Sort of) cherry-picked from the out-of-tree drbd9 branch. Original
commit message by Joel Colledge:

    This simplifies drbd_submit_peer_request by removing most of the
    arguments. It also makes the treatment of the op better aligned with
    that in struct bio.

    Determine fault_type dynamically using information which is already
    available instead of passing it in as a parameter.

Note: The opf in receive_rs_deallocated was changed from
REQ_OP_WRITE_ZEROES to REQ_OP_DISCARD. This was required in the
out-of-tree module, and does not matter in-tree. The opf is ignored
anyway in drbd_submit_peer_request, since the discard/zero-out is
decided by the EE_TRIM flag.

Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h      |  8 ++-
 drivers/block/drbd/drbd_receiver.c | 81 +++++++++++++++++-------------
 drivers/block/drbd/drbd_worker.c   |  4 +-
 3 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 4d661282ff41..0f8e3b94a635 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -395,6 +395,7 @@ struct drbd_peer_request {
 	struct drbd_peer_device *peer_device;
 	struct drbd_epoch *epoch; /* for writes */
 	struct page *pages;
+	unsigned int opf; /* to be used as bi_opf */
 	atomic_t pending_bios;
 	struct drbd_interval i;
 	/* see comments on ee flag bits below */
@@ -406,6 +407,10 @@ struct drbd_peer_request {
 	};
 };
 
+/* Equivalent to bio_op and req_op. */
+#define peer_req_op(peer_req) \
+       ((peer_req)->opf & REQ_OP_MASK)
+
 /* ee flag bits.
  * While corresponding bios are in flight, the only modification will be
  * set_bit WAS_ERROR, which has to be atomic.
@@ -1545,8 +1550,7 @@ extern void drbd_send_acks_wf(struct work_struct *ws);
 extern bool drbd_rs_c_min_rate_throttle(struct drbd_device *device);
 extern bool drbd_rs_should_slow_down(struct drbd_device *device, sector_t sector,
 		bool throttle_if_app_is_waiting);
-extern int drbd_submit_peer_request(struct drbd_device *,
-				    struct drbd_peer_request *, blk_opf_t, int);
+extern int drbd_submit_peer_request(struct drbd_peer_request *);
 extern int drbd_free_peer_reqs(struct drbd_device *, struct list_head *);
 extern struct drbd_peer_request *drbd_alloc_peer_req(struct drbd_peer_device *, u64,
 						     sector_t, unsigned int,
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index c897c4572036..41cf706a5e7a 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1603,9 +1603,19 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
 	drbd_endio_write_sec_final(peer_req);
 }
 
+static int peer_request_fault_type(struct drbd_peer_request *peer_req)
+{
+	if (peer_req_op(peer_req) == REQ_OP_READ) {
+		return peer_req->flags & EE_APPLICATION ?
+			DRBD_FAULT_DT_RD : DRBD_FAULT_RS_RD;
+	} else {
+		return peer_req->flags & EE_APPLICATION ?
+			DRBD_FAULT_DT_WR : DRBD_FAULT_RS_WR;
+	}
+}
+
 /**
  * drbd_submit_peer_request()
- * @device:	DRBD device.
  * @peer_req:	peer request
  *
  * May spread the pages to multiple bios,
@@ -1619,10 +1629,9 @@ static void drbd_issue_peer_discard_or_zero_out(struct drbd_device *device, stru
  *  on certain Xen deployments.
  */
 /* TODO allocate from our own bio_set. */
-int drbd_submit_peer_request(struct drbd_device *device,
-			     struct drbd_peer_request *peer_req,
-			     const blk_opf_t opf, const int fault_type)
+int drbd_submit_peer_request(struct drbd_peer_request *peer_req)
 {
+	struct drbd_device *device = peer_req->peer_device->device;
 	struct bio *bios = NULL;
 	struct bio *bio;
 	struct page *page = peer_req->pages;
@@ -1667,7 +1676,18 @@ int drbd_submit_peer_request(struct drbd_device *device,
 	 * generated bio, but a bio allocated on behalf of the peer.
 	 */
 next_bio:
-	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, opf, GFP_NOIO);
+	/* _DISCARD, _WRITE_ZEROES handled above.
+	 * REQ_OP_FLUSH (empty flush) not expected,
+	 * should have been mapped to a "drbd protocol barrier".
+	 * REQ_OP_SECURE_ERASE: I don't see how we could ever support that.
+	 */
+	if (!(peer_req_op(peer_req) == REQ_OP_WRITE ||
+				peer_req_op(peer_req) == REQ_OP_READ)) {
+		drbd_err(device, "Invalid bio op received: 0x%x\n", peer_req->opf);
+		return -EINVAL;
+	}
+
+	bio = bio_alloc(device->ldev->backing_bdev, nr_pages, peer_req->opf, GFP_NOIO);
 	/* > peer_req->i.sector, unless this is the first bio */
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = peer_req;
@@ -1697,7 +1717,7 @@ int drbd_submit_peer_request(struct drbd_device *device,
 		bios = bios->bi_next;
 		bio->bi_next = NULL;
 
-		drbd_submit_bio_noacct(device, fault_type, bio);
+		drbd_submit_bio_noacct(device, peer_request_fault_type(peer_req), bio);
 	} while (bios);
 	return 0;
 }
@@ -2051,6 +2071,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	 * respective _drbd_clear_done_ee */
 
 	peer_req->w.cb = e_end_resync_block;
+	peer_req->opf = REQ_OP_WRITE;
 	peer_req->submit_jif = jiffies;
 
 	spin_lock_irq(&device->resource->req_lock);
@@ -2058,8 +2079,7 @@ static int recv_resync_read(struct drbd_peer_device *peer_device, sector_t secto
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(pi->size >> 9, &device->rs_sect_ev);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_WRITE,
-				     DRBD_FAULT_RS_WR) == 0)
+	if (drbd_submit_peer_request(peer_req) == 0)
 		return 0;
 
 	/* don't care for the reason here */
@@ -2375,16 +2395,6 @@ static int wait_for_and_update_peer_seq(struct drbd_peer_device *peer_device, co
 	return ret;
 }
 
-/* see also bio_flags_to_wire()
- * DRBD_REQ_*, because we need to semantically map the flags to data packet
- * flags and back. We may replicate to other kernel versions. */
-static blk_opf_t wire_flags_to_bio_flags(u32 dpf)
-{
-	return  (dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
-		(dpf & DP_FUA ? REQ_FUA : 0) |
-		(dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
-}
-
 static enum req_op wire_flags_to_bio_op(u32 dpf)
 {
 	if (dpf & DP_ZEROES)
@@ -2395,6 +2405,15 @@ static enum req_op wire_flags_to_bio_op(u32 dpf)
 		return REQ_OP_WRITE;
 }
 
+/* see also bio_flags_to_wire() */
+static unsigned long wire_flags_to_bio(struct drbd_connection *connection, u32 dpf)
+{
+	unsigned long opf = wire_flags_to_bio_op(dpf) |
+		(dpf & DP_RW_SYNC ? REQ_SYNC : 0) |
+		(dpf & DP_FUA ? REQ_FUA : 0) |
+		(dpf & DP_FLUSH ? REQ_PREFLUSH : 0);
+}
+
 static void fail_postponed_requests(struct drbd_device *device, sector_t sector,
 				    unsigned int size)
 {
@@ -2538,8 +2557,6 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	struct drbd_peer_request *peer_req;
 	struct p_data *p = pi->data;
 	u32 peer_seq = be32_to_cpu(p->seq_num);
-	enum req_op op;
-	blk_opf_t op_flags;
 	u32 dp_flags;
 	int err, tp;
 
@@ -2578,11 +2595,10 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 	peer_req->flags |= EE_APPLICATION;
 
 	dp_flags = be32_to_cpu(p->dp_flags);
-	op = wire_flags_to_bio_op(dp_flags);
-	op_flags = wire_flags_to_bio_flags(dp_flags);
+	peer_req->opf = wire_flags_to_bio(connection, dp_flags);
 	if (pi->cmd == P_TRIM) {
 		D_ASSERT(peer_device, peer_req->i.size > 0);
-		D_ASSERT(peer_device, op == REQ_OP_DISCARD);
+		D_ASSERT(peer_device, peer_req_op(peer_req) == REQ_OP_DISCARD);
 		D_ASSERT(peer_device, peer_req->pages == NULL);
 		/* need to play safe: an older DRBD sender
 		 * may mean zero-out while sending P_TRIM. */
@@ -2590,7 +2606,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 			peer_req->flags |= EE_ZEROOUT;
 	} else if (pi->cmd == P_ZEROES) {
 		D_ASSERT(peer_device, peer_req->i.size > 0);
-		D_ASSERT(peer_device, op == REQ_OP_WRITE_ZEROES);
+		D_ASSERT(peer_device, peer_req_op(peer_req) == REQ_OP_WRITE_ZEROES);
 		D_ASSERT(peer_device, peer_req->pages == NULL);
 		/* Do (not) pass down BLKDEV_ZERO_NOUNMAP? */
 		if (dp_flags & DP_DISCARD)
@@ -2677,8 +2693,7 @@ static int receive_Data(struct drbd_connection *connection, struct packet_info *
 		peer_req->flags |= EE_CALL_AL_COMPLETE_IO;
 	}
 
-	err = drbd_submit_peer_request(device, peer_req, op | op_flags,
-				       DRBD_FAULT_DT_WR);
+	err = drbd_submit_peer_request(peer_req);
 	if (!err)
 		return 0;
 
@@ -2789,7 +2804,6 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 	struct drbd_peer_request *peer_req;
 	struct digest_info *di = NULL;
 	int size, verb;
-	unsigned int fault_type;
 	struct p_block_req *p =	pi->data;
 
 	peer_device = conn_peer_device(connection, pi->vnr);
@@ -2849,11 +2863,11 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		put_ldev(device);
 		return -ENOMEM;
 	}
+	peer_req->opf = REQ_OP_READ;
 
 	switch (pi->cmd) {
 	case P_DATA_REQUEST:
 		peer_req->w.cb = w_e_end_data_req;
-		fault_type = DRBD_FAULT_DT_RD;
 		/* application IO, don't drbd_rs_begin_io */
 		peer_req->flags |= EE_APPLICATION;
 		goto submit;
@@ -2867,14 +2881,12 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 		fallthrough;
 	case P_RS_DATA_REQUEST:
 		peer_req->w.cb = w_e_end_rsdata_req;
-		fault_type = DRBD_FAULT_RS_RD;
 		/* used in the sector offset progress display */
 		device->bm_resync_fo = BM_SECT_TO_BIT(sector);
 		break;
 
 	case P_OV_REPLY:
 	case P_CSUM_RS_REQUEST:
-		fault_type = DRBD_FAULT_RS_RD;
 		di = kmalloc(sizeof(*di) + pi->size, GFP_NOIO);
 		if (!di)
 			goto out_free_e;
@@ -2923,7 +2935,6 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 					(unsigned long long)sector);
 		}
 		peer_req->w.cb = w_e_end_ov_req;
-		fault_type = DRBD_FAULT_RS_RD;
 		break;
 
 	default:
@@ -2975,8 +2986,7 @@ static int receive_DataRequest(struct drbd_connection *connection, struct packet
 submit:
 	update_receiver_timing_details(connection, drbd_submit_peer_request);
 	inc_unacked(device);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
-				     fault_type) == 0)
+	if (drbd_submit_peer_request(peer_req) == 0)
 		return 0;
 
 	/* don't care for the reason here */
@@ -4947,7 +4957,6 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 
 	if (get_ldev(device)) {
 		struct drbd_peer_request *peer_req;
-		const enum req_op op = REQ_OP_WRITE_ZEROES;
 
 		peer_req = drbd_alloc_peer_req(peer_device, ID_SYNCER, sector,
 					       size, 0, GFP_NOIO);
@@ -4957,6 +4966,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 		}
 
 		peer_req->w.cb = e_end_resync_block;
+		peer_req->opf = REQ_OP_DISCARD;
 		peer_req->submit_jif = jiffies;
 		peer_req->flags |= EE_TRIM;
 
@@ -4965,8 +4975,7 @@ static int receive_rs_deallocated(struct drbd_connection *connection, struct pac
 		spin_unlock_irq(&device->resource->req_lock);
 
 		atomic_add(pi->size >> 9, &device->rs_sect_ev);
-		err = drbd_submit_peer_request(device, peer_req, op,
-					       DRBD_FAULT_RS_WR);
+		err = drbd_submit_peer_request(peer_req);
 
 		if (err) {
 			spin_lock_irq(&device->resource->req_lock);
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
index 0bb1a900c2d5..c69beefc9d5c 100644
--- a/drivers/block/drbd/drbd_worker.c
+++ b/drivers/block/drbd/drbd_worker.c
@@ -400,13 +400,13 @@ static int read_for_csum(struct drbd_peer_device *peer_device, sector_t sector,
 		goto defer;
 
 	peer_req->w.cb = w_e_send_csum;
+	peer_req->opf = REQ_OP_READ;
 	spin_lock_irq(&device->resource->req_lock);
 	list_add_tail(&peer_req->w.list, &device->read_ee);
 	spin_unlock_irq(&device->resource->req_lock);
 
 	atomic_add(size >> 9, &device->rs_sect_ev);
-	if (drbd_submit_peer_request(device, peer_req, REQ_OP_READ,
-				     DRBD_FAULT_RS_RD) == 0)
+	if (drbd_submit_peer_request(peer_req) == 0)
 		return 0;
 
 	/* If it failed because of ENOMEM, retry should help.  If it failed
-- 
2.37.3

