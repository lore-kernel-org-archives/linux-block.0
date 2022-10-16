Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD802C4332F
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 03:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJPDlb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Oct 2022 23:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJPDla (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Oct 2022 23:41:30 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C83ECFB
        for <linux-block@vger.kernel.org>; Sat, 15 Oct 2022 20:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665891689; x=1697427689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6tDsBf4Hb4yJoBheTcLoanYXMQha0jXG1IVmZ/1mX4k=;
  b=O3x7CvShicrHflYewDN4FMr5MCnWdHUfqRdmhwhZ2rB7Skh5n51JBGMb
   GDTcjD1IBx9M1LtUZmybiTHlQ1tVJswjQzSW5/SBAGaBvbPHIrM4cRU+H
   V9qbdAHPMSk9RiGEoDDTU4fcf/XPx/WP7L+sf/KVHsrgnKb3Pf1Kf0XiD
   XLydfwmnk05HPRTJKzCZ0WW9yeB4GGNYSCF5EIZHNT/2ARMu4GiDwpjn4
   7986HSgzGXnKL3hABcrs05yYlX3b6IizZt7Z1zXPV5VX9i33+SgcwCYPv
   1MQnk/cADjzr+HCtYlAd5dCdT7QNYOi1sT7VQeBrZsKG2Vwegkie2NEKF
   A==;
X-IronPort-AV: E=Sophos;i="5.95,188,1661788800"; 
   d="scan'208";a="318226164"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2022 11:41:29 +0800
IronPort-SDR: EL0edBWDlEwC/TSL21UDZaQv1GpB7akszPJEA+bqVXII7kKc5+TDV77cBWdx+DckyLqW3Gd2Wf
 NbeCfoIqpgp0NFsA5R1YcBrCjWdB6JiQHfOCdntEOVAA55ow4rt7E+yNr2XNXRzslqzfmgiov2
 9Bgq5ao59lNyd74/wD5E/nVP6BmRRpIp3nl/MICxCPRhjr2d0ebY5tHgcTCevKtn1kZLi/s8r6
 0OkL7NWwDc2EcdyNudbOnRBo+ccz7R+THk/qSzpq2xU2IIPKeW1hoamoaHBxm27pB0SsYXrtlB
 amMdrZkq78sPZRDJCQM74p84
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2022 20:01:04 -0700
IronPort-SDR: 5wGvJs/SiAH2HEQQPwwdAAGvW++E6SIxameeKD9pFvOANqhLy4tMGWV9Aa8pKCsckRH5N+E4Xv
 1HOxnhRnpgbC9OXqFivNF5nD4jSncBpDW/ahPAetRgQ1Bf0ca49bjJGQka9VCmj5bA+rQ9JbQs
 jtYiiTjnvBgHYNiDDSQCw+KRFqsysCRF1JATE6wmOPqZ5Tj8cd9B2VQUczxl2pN392zmgML7KG
 qrQXT9DNZLxPhj/tfe59JUVjEfJXNZgLpAEvH1Hndy0U4ZBNfyVO8xtQ0ZJ1jJBXs7N+jH0hyO
 9Nw=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Oct 2022 20:41:29 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v2 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Sat, 15 Oct 2022 23:41:26 -0400
Message-Id: <20221016034127.330942-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
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

