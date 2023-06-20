Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC40AEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 08:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjFTIjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFTIjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 04:39:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA27DB
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 01:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4316108A
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 08:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06FA3C433C0;
        Tue, 20 Jun 2023 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687250339;
        bh=jjUcMxYNhNCneqRlZF5iLv7MfScvw8SWroDvMEU+tL0=;
        h=From:To:Cc:Subject:Date:From;
        b=OYGS5cHpN3f+NrZZ5orExkj8NNsagzinG6ovnDk1G0AdA+KNV6lhYVXgS1Jml8PrT
         TZUFDHSzvEQMfSU7p4/abd9b8S6k/4Z8E+Cxe6evUww6Q/BVBOYfa2FMJzzX46TVJh
         9ajTtDSyG6/GP4tkNTnpJrXbnjH4DF7FOaUV1Mnc7ikI75oW1uFCnIvVvQb6PeNW/2
         2apBceOJXZq1H+skui8q18HCtc3ZuCr3wV2L2RLXX1s5vE0D8QEIFb3oP1i4rait8S
         +7gKITbEaCc+dsmYlnmpmnDbGpm97yFN4uxu9iauUr5nXJe5WRajAHEBdTwHxa7K3K
         tshQCrVao5PuQ==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Suwan Kim <suwan.kim027@gmail.com>,
        Sam Li <faithilikerun@gmail.com>
Subject: [PATCH] block: virtio-blk: Fix handling of zone append command completion
Date:   Tue, 20 Jun 2023 17:38:57 +0900
Message-Id: <20230620083857.611153-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The introduction of completion batching with commit 07b679f70d73
("virtio-blk: support completion batching for the IRQ path") overlloked
handling correctly the completion of zone append operations, which
require an update of the request __sector field, as is done in
virtblk_request_done(): the function virtblk_complete_batch() only
executes virtblk_unmap_data() and virtblk_cleanup_cmd() without doing
this update. This causes problems with zone append operations, e.g.
zonefs complains about invalid zone append locations.

Fix this by introducing the function virtblk_end_request(), which is
almost identicatl to virtblk_request_done() but without the call to
blk_mq_end_request(). Use this new function to rewrite
virtblk_request_done() and call it in virtblk_complete_batch() to end
all request of a batch.

Reported-by: Sam Li <faithilikerun@gmail.com>
Fixes: 07b679f70d73 ("virtio-blk: support completion batching for the IRQ path")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/virtio_blk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..513d8b582aec 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -332,10 +332,9 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }
 
-static inline void virtblk_request_done(struct request *req)
+static inline blk_status_t virtblk_end_request(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 
 	virtblk_unmap_data(req, vbr);
@@ -345,17 +344,21 @@ static inline void virtblk_request_done(struct request *req)
 		req->__sector = virtio64_to_cpu(vblk->vdev,
 						vbr->in_hdr.zone_append.sector);
 
-	blk_mq_end_request(req, status);
+	return virtblk_result(virtblk_vbr_status(vbr));
+}
+
+static inline void virtblk_request_done(struct request *req)
+{
+	blk_mq_end_request(req, virtblk_end_request(req));
 }
 
 static void virtblk_complete_batch(struct io_comp_batch *iob)
 {
 	struct request *req;
 
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
+	rq_list_for_each(&iob->req_list, req)
+		virtblk_end_request(req);
+
 	blk_mq_end_request_batch(iob);
 }
 
-- 
2.40.1

