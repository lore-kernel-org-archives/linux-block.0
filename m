Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3D8FA3744
	for <linux-block@archiver.kernel.org>; Fri, 28 Oct 2022 04:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ1E20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 00:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1E2Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 00:28:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C138917FD48
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666931304; x=1698467304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nXSK2yJpJDXz3sMFjQKzUsbRRq9JfvrOiZuF6hPo9Ug=;
  b=FIrlvks+hlykhxxyuSOOCvtfjxgCkxdhOSCAk4vmeik+w7+ORf5NMdhY
   FjN1Ta4E1TFTMcc94LjUQeUbFPZZGrMX7ok0yPiqxzyuqu615dmIK5XN3
   VWpdXrAJu+/c9/KU3qdXNexY4s++jCjBozaLuORRGVCoZsS7QyKUSoPrD
   KtnNgYpmTE2cKKZbYNYDSeKrLOkdi38lJ4x4I0Yl0xrpnaXc6fWyPWr/U
   zEsPwfuH6+OkeT3r9qBJpKpviVjpN1udNnN/2kr7TxtbN3aVcQMDX1Qp+
   TkS7SCWn2dj1psgrStN60jR/cyAAHbX8MLDSb8llJkIaO9m+RVkZlsnvM
   A==;
X-IronPort-AV: E=Sophos;i="5.95,219,1661788800"; 
   d="scan'208";a="213236257"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 12:28:24 +0800
IronPort-SDR: T7pqdIqJSdY5OhQfYwQWONWHL/cishjvE0IiVmgVdrkdMfkba5nCU1L98BKcstp2gbtSSByvus
 w0GPIAKVN1pxGbrZJ3SEZ2w7jXkCPD0/pjW6HOQTCeCDYrD0jKZocS5EuRV+/9h//gib/ZhGeT
 c7SyTwbgz8bxRxJxOdVOun1UI7ouCIeRioZsKCcPHldGPz2A8N9HmQXWJmEjbHmpe5MmH7E8Um
 F2nn6Y2Y8xEQWv0karQxE3I0fj6KyLCF6az7Dx0hluHpOoCdCfhVlrsmfPqG6YhaxOmTwEEdnp
 uUM4y1BO++VWqrh+7xq1+qFL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 20:42:02 -0700
IronPort-SDR: cvg7lwWtNnt4KZ2Ur6P9L98IiDCCBIUza153y2R94IEeYOCr9BChvOP9Zr9gt7O7j1zBHKvxvY
 b5M22yLVB1ZqeXJdSfa4KV2j+KKG0cAVGOpbTWbDjP/YuERGmbmWUN8EXHQUv2bEzNS2IKzaD2
 xkOwXXSNXGB8uZEcGroRlTHhLI+s203ytsL06JKP1VmMohSakLTid+vGgjP7JnCYYezbSVW7td
 7SArvMb0uaBdQz7Y0Y/zPoHX3nsFXvr8QFiBLxC6k1XLORfoSDf7DphiRZgY1WbsenYh3rgAZp
 xac=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Oct 2022 21:28:23 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v3 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Fri, 28 Oct 2022 00:28:20 -0400
Message-Id: <20221028042821.921403-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028042821.921403-1-dmitry.fomichev@wdc.com>
References: <20221028042821.921403-1-dmitry.fomichev@wdc.com>
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

