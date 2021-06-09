Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08259C4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE06613C0
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhFIAsT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234286AbhFIAsQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 20:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623199583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZfSqghPsL+bfXYHssQjJ4XQFmLI3++rz1v/X9N49PA=;
        b=QVk4vZD0hQcMNlYksKgQxek3XcG9sf2lCitIHD8JtNfJ2tSdADcVaQR5Bjw2j/rGeYFV0G
        GuOy/1Er+n5Jl8H9uflbMCnxfr97tmXbP0T/xHEgFLpSZM+gwsbEZo/Lm4r8jo4H6UtgdL
        ErwFDoYK8n+yuYhoS+NLnuPoZm8Wslc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Pz0TvnE0OVOAT4S-QPgMug-1; Tue, 08 Jun 2021 20:46:19 -0400
X-MC-Unique: Pz0TvnE0OVOAT4S-QPgMug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E8F8049C5;
        Wed,  9 Jun 2021 00:46:18 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEFE319C45;
        Wed,  9 Jun 2021 00:46:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: [PATCH 2/2] block: support bio merge for multi-range discard
Date:   Wed,  9 Jun 2021 08:45:56 +0800
Message-Id: <20210609004556.46928-3-ming.lei@redhat.com>
In-Reply-To: <20210609004556.46928-1-ming.lei@redhat.com>
References: <20210609004556.46928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far multi-range discard treats each bio as one segment(range) of single
discard request. This way becomes not efficient if lots of small sized
discard bios are submitted, and one example is raid456.

Support bio merge for multi-range discard for improving lots of small
sized discard bios.

Turns out it is easy to support it:

1) always try to merge bio first

2) run into multi-range discard only if bio merge can't be done

3) add rq_for_each_discard_range() for retrieving each range(segment)
of discard request

Reported-by: Wang Shanker <shankerwangmiao@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-merge.c          | 12 ++++-----
 drivers/block/virtio_blk.c |  9 ++++---
 drivers/nvme/host/core.c   |  8 +++---
 include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcdff1879c34..65210e9a8efa 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -724,10 +724,10 @@ static inline bool blk_discard_mergable(struct request *req)
 static enum elv_merge blk_try_req_merge(struct request *req,
 					struct request *next)
 {
-	if (blk_discard_mergable(req))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
+	if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
 		return ELEVATOR_BACK_MERGE;
+	else if (blk_discard_mergable(req))
+		return ELEVATOR_DISCARD_MERGE;
 
 	return ELEVATOR_NO_MERGE;
 }
@@ -908,12 +908,12 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (blk_discard_mergable(rq))
-		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
+	if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
 		return ELEVATOR_FRONT_MERGE;
+	else if (blk_discard_mergable(rq))
+		return ELEVATOR_DISCARD_MERGE;
 	return ELEVATOR_NO_MERGE;
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..970cb0d8acaa 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -116,7 +116,6 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 	unsigned short segments = blk_rq_nr_discard_segments(req);
 	unsigned short n = 0;
 	struct virtio_blk_discard_write_zeroes *range;
-	struct bio *bio;
 	u32 flags = 0;
 
 	if (unmap)
@@ -138,9 +137,11 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
 		range[0].sector = cpu_to_le64(blk_rq_pos(req));
 		n = 1;
 	} else {
-		__rq_for_each_bio(bio, req) {
-			u64 sector = bio->bi_iter.bi_sector;
-			u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
+		struct req_discard_range r;
+
+		rq_for_each_discard_range(r, req) {
+			u64 sector = r.sector;
+			u32 num_sectors = r.size >> SECTOR_SHIFT;
 
 			range[n].flags = cpu_to_le32(flags);
 			range[n].num_sectors = cpu_to_le32(num_sectors);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24bcae88587a..4b0a39360ce9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -813,7 +813,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
 	struct nvme_dsm_range *range;
-	struct bio *bio;
+	struct req_discard_range r;
 
 	/*
 	 * Some devices do not consider the DSM 'Number of Ranges' field when
@@ -835,9 +835,9 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		range = page_address(ns->ctrl->discard_page);
 	}
 
-	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+	rq_for_each_discard_range(r, req) {
+		u64 slba = nvme_sect_to_lba(ns, r.sector);
+		u32 nlb = r.size >> ns->lba_shift;
 
 		if (n < segments) {
 			range[n].cattr = cpu_to_le32(0);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d66d0da72529..bd9d22269a7b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1007,6 +1007,57 @@ static inline unsigned int blk_rq_stats_sectors(const struct request *rq)
 	return rq->stats_sectors;
 }
 
+struct req_discard_range {
+	sector_t	sector;
+	unsigned int	size;
+
+	/*
+	 * internal field: driver don't use it, and it always points to
+	 * next bio to be processed
+	 */
+	struct bio *__bio;
+};
+
+static inline void req_init_discard_range_iter(const struct request *rq,
+		struct req_discard_range *range)
+{
+	range->__bio = rq->bio;
+}
+
+/* return true if @range stores one valid discard range */
+static inline bool req_get_discard_range(struct req_discard_range *range)
+{
+	struct bio *bio;
+
+	if (!range->__bio)
+		return false;
+
+	bio = range->__bio;
+	range->sector = bio->bi_iter.bi_sector;
+	range->size = bio->bi_iter.bi_size;
+	range->__bio = bio->bi_next;
+
+	while (range->__bio) {
+		struct bio *bio = range->__bio;
+
+		if (range->sector + (range->size >> SECTOR_SHIFT) !=
+				bio->bi_iter.bi_sector)
+			break;
+
+		/*
+		 * ->size won't overflow because req->__data_len is defined
+		 *  as 'unsigned int'
+		 */
+		range->size += bio->bi_iter.bi_size;
+		range->__bio = bio->bi_next;
+	}
+	return true;
+}
+
+#define rq_for_each_discard_range(range, rq) \
+	for (req_init_discard_range_iter((rq), &range); \
+			req_get_discard_range(&range);)
+
 #ifdef CONFIG_BLK_DEV_ZONED
 
 /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
-- 
2.31.1

