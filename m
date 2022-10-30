Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E263FA3743
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 04:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJ3Efv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 00:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ3Eft (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 00:35:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD545998
        for <linux-block@vger.kernel.org>; Sat, 29 Oct 2022 21:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667104548; x=1698640548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nXSK2yJpJDXz3sMFjQKzUsbRRq9JfvrOiZuF6hPo9Ug=;
  b=IugAKeDFGNjBwuW3Moo2QKAJBY8NXub8sjBsYd47o7xNID7D9HF5OXab
   eTGMgmkrMc/BZNjjwrwie/gUCadvRewYD+Wa3tMyNcmrQ1TD5Dkf2Mx37
   hD4R3WuQl/5IpINVxgfMMLNUmpXAy9yyJJxoEZJlkMeWr6A3MaHZY8S71
   pNdTdTzZdrfE9EcS/tr/UXMSrQEcEFw89WohkF5PN8/eAxpmG7SgRFL3U
   HS7eSXciZHbDUGOyVzvEQGVePdTQJWzTkD97+Qq2fcwpeusN3Oix4wFan
   EjIE1a6L6YvhssIgnuBTER1jdDUuWioiosPJg6rQzFqqI1v8+497O300q
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,225,1661788800"; 
   d="scan'208";a="213350181"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2022 12:35:48 +0800
IronPort-SDR: 8urqUefqhzGypbVAKOU+eFNvDyqgt52EGIKcHpY5L8A0Dq3QxaxoL5jGm4R9qz7egTjjiLMuns
 cA55JhIUAJcAYCd+kiOwyyGbfw5a3qkJm2mTPFq82vGVk0jlf6HoGrQHakL1HJGof4ATPNVPZb
 eM1DW6LTf5RZ5ZRb8s8NgBkYncruOJIFsAORXGfFZNwt2O7TZ9t+2KeMY7aklPtBku5lwmnctl
 lx0hjGW9N2lm4MBVAKZ7+o9BWxfNkZEDzyrbsjH6orXUYdjXr50C67e+DcaSJzHImm+qj69l0g
 g58LEFwVAd26jwtkQXF40HBT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2022 20:49:22 -0700
IronPort-SDR: VY14G4jX4ww7TXgK2ZhdhSPjOMpaxUcECi6271PXz0u7zDTpNh1X5dz2klkzQZ724xqhsH8BKY
 2chN/aKrg2KcBrf+9QP/ROvnUf3P2WcfpFSI4CR72G4BFgNLxTPgDbHQRORyo5xOdvBIBMfijb
 kmkN2RmMpXs9a+KaIgF3QXK1zIa73LhVHcizI2sbIiUZQOWmVL0MGyWOlZkuW6bfEKe2zgkzcP
 rEzEqO8bm/T9f4OHbD93rYL3fj+AZX+2mGjsOezmsbFNkzcI3ACDXQR5fBBKOI7BXo93MEf139
 FYU=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2022 21:35:47 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v4 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Sun, 30 Oct 2022 00:35:44 -0400
Message-Id: <20221030043545.974223-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030043545.974223-1-dmitry.fomichev@wdc.com>
References: <20221030043545.974223-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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

