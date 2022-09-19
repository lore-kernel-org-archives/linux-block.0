Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A7DECAAD8
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 02:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiISC3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Sep 2022 22:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiISC3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2022 22:29:30 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278418B3E
        for <linux-block@vger.kernel.org>; Sun, 18 Sep 2022 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663554565; x=1695090565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNb+/158WfESrvTvT5D6Z+hur4/5GiSw0BJK04QCbXo=;
  b=bSkNCfNMPq4H9ojmeWK+qoMwIkL+ZRyhryE6bwzYgqz26ofpZDfU/toD
   PUZW/KBDt/cr8Ipkark75zHxDENYSSxHPWTDle1ED9NGPGYd0gxn512/D
   lBZsVCmw9eY2gIvaO++3nLBe8D9AIWiZ/8SweSFINHkiSEtbWlJD6Uzcc
   J4zeLz/N4m/s+2QRsrzYp45CpPwWjBBplNYJp5XCyow4ArYgHuHIf3AOf
   jJam2AXhWUW6dFNdrGYmEod2BlnjVgnhvUtGmiLKp352emYc5D/H2fHZ3
   uVShNoDxhoIrt/hNzjWKmS7HYuEta52j09fa6wIzkGOZlErstrHRYqpRx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,325,1654531200"; 
   d="scan'208";a="211668179"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 10:29:23 +0800
IronPort-SDR: gFv104u8h5KAe+S6C9sT9hKAivKLvpiZiuxTe5nhDJDrSS7kNpZpeIfTnLXVou+syfcpK8FWhT
 IEZJzw/FVspLi/TgoZUnPLOExuKZTqxov0XhSjF5+CgjGUb2iwsaguCZgbp1DbuRu4tDP/2ey/
 JodPBqNz+aFEcVgnOYiAVHTuRoB+T9XgprcpiCdfolVhFBdbNR2UdL80cT5qQxuPRVhTSBUIoS
 mEkJf8L2hHzSH34b0RpfklsbnIN7TR0bAMxdLkoTqTnL1apXpXmkwUNmvYbURIWk8DZpxTbFe1
 jp4tIMp22C7OocnjRRrkHy22
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2022 18:44:02 -0700
IronPort-SDR: 9YuJInBtVKMvbha1acyCrKFr89WYGCowwaZPM5te1sK3rm4sAW8vmFMhYK743Wswo+sW1CquQB
 ln0UKZyPcQ+uIag3aegtgN/3oi3MvD483rbiWP2m/V/ojJy9qp5jSecoB2QR6qmLm+Tqv0Z4s3
 S1pdeSPtW1RY9iYI9c8r0DWOLvO7EVH/UWkevr2VW/aSbS1RdCZOyxNLkZQMmvKRqsLgqx6mmG
 wHvyRdIsNW/rLyqRKE25ENqvlFMZeVGT7B/uaYldl884Kt1C5m+Q+SBkvmUz7A7UPoNbkBKhgT
 RN4=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.110])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Sep 2022 19:29:24 -0700
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH 1/3] virtio-blk: use a helper to handle request queuing errors
Date:   Sun, 18 Sep 2022 22:29:19 -0400
Message-Id: <20220919022921.946344-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
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
index 30255fcaf181..9a6aa94a212c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -311,6 +311,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
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
@@ -325,10 +338,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(vbr->sg_table.nents < 0)) {
-		virtblk_cleanup_cmd(req);
-		return BLK_STS_RESOURCE;
-	}
+	if (unlikely(vbr->sg_table.nents < 0))
+		return virtblk_fail_to_queue(req, -ENOMEM);
 
 	return BLK_STS_OK;
 }
@@ -360,15 +371,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
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

