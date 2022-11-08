Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3182BC43219
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 04:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKHEHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 23:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKHEHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 23:07:24 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC4F1019
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 20:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667880442; x=1699416442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nXSK2yJpJDXz3sMFjQKzUsbRRq9JfvrOiZuF6hPo9Ug=;
  b=Xf9AL7527iafzf3CLcTvOSDMdSU1eIO4++6V91Gv5ObAUDD3TRhy/cAR
   oIp9Py0ePpFplij7Uu1CvE6D5hphOFNJDYqspNd9HY9IX+LAXEdpvBS6K
   ckzRUyT/u1Hm5ez8s/FWNIF1ctR7QodovK3Ebg36Ewim6lluIPHY+VO4f
   Azf32CEeCmEXJXp3f+FSdQo2H2YJqFYvZ1PLnfIhDD1yP4XfR5US/eZz5
   K/5ZgmAZ740Gz9Q61WVdZBb1m7lPVy8QOjtq2Fm1cbTInfc5PrTJl6bQd
   Ur1YarLwJUT4IZjvsqmbDqmcLCXYYbDCShBGEKMxT3x34jDuoV+rhGuQs
   g==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327825124"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 12:07:22 +0800
IronPort-SDR: Su7aeFo8Q1NV26pCJQ70LOMccLfnbO40HTlCxsb2YMB2oyr1GXdS0Q/fE0pAjD/6DvcFjnZ3Xt
 QLV24H6/w2fvSWG6Fm9KaOagNytpDPwZao1qUdfKjNhkFNx1qRCCqXOWjNkYZKidAIbXG/N2/t
 bUjRlDzn/N5bXuaDNMy15CrjOKxQbpSXy0co/gPvnwJbe/fYxzLatGoh80/x7cSNHTOIMA5Mly
 w9jgbKA7DjvYwRfwuvA+x7ECXxHc+4AxpQcKEseeYHmHNdHJk97wwwRCeFWeBslWnXuPeCU13/
 WXM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 19:20:44 -0800
IronPort-SDR: jYqj8WXBwyuCVkLjK7xhGt3u8oB1A2i/BeFYiilAdOW2sxGZfGThGlsfPEhhObkHDtGfzqcXwO
 gnMZ0/GiomhYm22V1xtJY/szNLebknFenuCgzdSmezO6mBWIfF8OThxbNzPAqy/whQt1RNEcgT
 RZL053xx8uX9qQ9Uf6E0f5cl9/6Q4BqlqoMhcFKGoWEl0cALDfgrwuj0+uPNqdQ0mDptJzGrSN
 p+VTpRN0hRddRjFv6zjrGDP6TFd6mnPHaC+AOyz9i84HiWTxuaTUNJ1pLAdGvrpWbcllYXWDMq
 Ldg=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2022 20:07:22 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v5 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Mon,  7 Nov 2022 23:07:17 -0500
Message-Id: <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
References: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
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

