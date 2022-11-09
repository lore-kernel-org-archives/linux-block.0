Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DEC43217
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 04:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKIEqh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 23:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKIEqg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 23:46:36 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC8B1B1E6
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 20:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667969196; x=1699505196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZyJmxY8o9EoEtsWW+ujyaO/aESRQf6l2qbP4n/xlUqA=;
  b=flX2Fxpe0XbtJ6cUpR/oixJTYeVqiIh+XPAsFtihys8wPZ0VgEhRfP63
   83dKaGed8myYPR/+D+BvR1rz/Af8qatko03ToZEnEFeORmY5HJQ+2igz+
   LKCLQSwrlC70WWQWoHoJKsOOmdUd1FmBE3oJUxHldlnF4cMz8vQKmXanL
   hkvzRpWHPN1XGNbUMSlypEH5UaEmPojesoK0OVCknM5Wghwh0OZq/yrCb
   DTLL8liBJdd0lr1wKigmS5YFRKa3FGQ3yKVRaga07WKfYf1CFtsU4GqPT
   zOh2XXefw9sMONa6Sw1js78mZJlANrCzt8vlT5SOU+zAxvKhS4CmOANtq
   A==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="220986601"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 12:46:36 +0800
IronPort-SDR: 7kJ9FGU646nSZb3oQ9nI1dpx9fx1MFQUcP2Orhw88FWLyW04An4+nk/m6x712EVAglKeQDriAo
 2w8BEaUgN1wHod4NDg2Wak0jkb8mgQkRfd+vDdqfj+6k2+s7ss94x8B/pNrWQsipdkYLnqXAmk
 L/jWSLykPQ1cuud14gU/3AWGkvHTemL168wR4KL1ja6qz5xEu56j+hXnBq6PE469a2k1IKAuLn
 UxmUS6Vr08DImtXeDOxJ6TPhhNnp5C0IkqX4bZcJb/DDDDnPc3WzyVrX3GZOK0EIcM7/JTco81
 VXM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 19:59:56 -0800
IronPort-SDR: v9vTfjB/9Mej+aMAoooKrg9ysvSk/myT/zmCsC0VJiGW4aSJYwo+DMpsUG7fGOwaQQh1iNOMS0
 MdkOIjya+1oISutlhmJntR/nBQ6giNfXpmbJM+9xHabcHCAuvwUD/Lv8y5FQvDA0+M8Al/8mh6
 4LSulDhI0D6ykyW4crdSuhbQM4/t9h2tz8e/J1aMWc+ADzyKPdoBPV78viJRfcOH/1oreb3wgO
 OoRNvkx0MCpeYGvXrB3SMk1aScSiRpDohaZ53IaqkDZJkNaudvEqz1lubhWbBU3m4LQvQPR8kk
 M5Q=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Nov 2022 20:46:34 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v6 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Tue,  8 Nov 2022 23:46:31 -0500
Message-Id: <20221109044632.3121790-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
References: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 19da5defd734..3efe3da5f8c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -315,6 +315,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
 		virtqueue_notify(vq->vq);
 }
 
+static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
+{
+	virtblk_cleanup_cmd(req);
+	switch (rc) {
+	case -ENOSPC:
+		return BLK_STS_DEV_RESOURCE;
+	case -ENOMEM:
+		return BLK_STS_RESOURCE;
+	default:
+		return BLK_STS_IOERR;
+	}
+}
+
 static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 					struct virtio_blk *vblk,
 					struct request *req,
@@ -327,10 +340,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 		return status;
 
 	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(vbr->sg_table.nents < 0)) {
-		virtblk_cleanup_cmd(req);
-		return BLK_STS_RESOURCE;
-	}
+	if (unlikely(vbr->sg_table.nents < 0))
+		return virtblk_fail_to_queue(req, -ENOMEM);
 
 	blk_mq_start_request(req);
 
@@ -364,15 +375,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 			blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 		virtblk_unmap_data(req, vbr);
-		virtblk_cleanup_cmd(req);
-		switch (err) {
-		case -ENOSPC:
-			return BLK_STS_DEV_RESOURCE;
-		case -ENOMEM:
-			return BLK_STS_RESOURCE;
-		default:
-			return BLK_STS_IOERR;
-		}
+		return virtblk_fail_to_queue(req, err);
 	}
 
 	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
-- 
2.34.1

