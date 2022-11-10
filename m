Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5334C433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 05:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKJFkA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 00:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiKJFj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 00:39:57 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAD2D753
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 21:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668058795; x=1699594795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yst/XTpEEicvNCjU+IwodK8sMavEdmblsUxSOmVR/Gw=;
  b=jKySTObrwf4SXJe2+OQmIleQ1ICxTU1cH517V3x4u3OW6bgQyodbyOSo
   w+lXmQoQoB+NzWxzow2N8mfIfDch/N9bOz5QQwGSoUv3PONwSddoaGab7
   CrCnHzAh/wWRilvkD6Nl41d6ag9rp9IMWJb40hlZssIlcxAe1Zi05NoLJ
   s/7rl7qWp2XIap8FzQESWcpz3nMZlgs3RDmbvW41+CvBNyxmssQi6L85B
   JEhM09pByknD1ptZ1iLvxyrSLL5ZXgzHQuoV3vHEfGDDtHjgaylCdEXEV
   eT87S64zciSQZLyqK8O0+NxECnIQxUfDfqBc9ndkB9kvNDnL9sy1Nrj34
   w==;
X-IronPort-AV: E=Sophos;i="5.96,152,1665417600"; 
   d="scan'208";a="320264546"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2022 13:39:55 +0800
IronPort-SDR: iZnxuTagJUTaTmmLp4d4f2Kt22Lv1L1NCoPABGTtqKdvNtzhKx5KIYJyoloFFpd4Yy8K4jI8bk
 hWZGDiTCBfcwpAxME0cec/BykfQoepn6r5nIhPpObIbz09tSV/zt+iylBjnZF7eY/KEtvzMa9O
 OKmA9nH2fAQZqylWkW37/6fIxjmuuOiAzK1feZKkUnAxxSAvdlqKg1PyDZcQDbfLGWW+3O0Stg
 hJRdl/z6Q2M+0avCHMoqADQKDYCCsT7Z1VKvONV+41/UQ9UoqRYpG0VhgWe6vxkZZiKuiX1eeX
 n5U=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Nov 2022 20:58:58 -0800
IronPort-SDR: M3HD86vYp5Wa5Sp0JLzZYan7/pT6CB5fEfHiGiE1FAxAe2gPIblhKT58FqGuemhECQeOqSmnj4
 9UDJt6l8nRJeLtF3M8Zn8JmEfk+Bc/dY9rJuWNg9+LSt+9FGA8xef+srYuTSU9RazwjL2zu3RW
 mRGIcRlHnZs0e6UCNbzTsRVsKiV5B+DpgDpWan1KHwmNVK/aryo+AjAb+ix2y74BDdL+FVNZ10
 VbDoDVRS8EbhNucFs3KbiZ3qikz6V2MQMKSLES/6utvb7neLySYqFZ4wQ4a207gTtz82mdkN9B
 kAc=
WDCIronportException: Internal
Received: from unknown (HELO oryx.wdc.com) ([10.225.167.43])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Nov 2022 21:39:54 -0800
From:   Dmitry Fomichev <dmitry.fomichev@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: [PATCH v7 1/2] virtio-blk: use a helper to handle request queuing errors
Date:   Thu, 10 Nov 2022 00:39:51 -0500
Message-Id: <20221110053952.3378990-2-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110053952.3378990-1-dmitry.fomichev@wdc.com>
References: <20221110053952.3378990-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define a new helper function, virtblk_fail_to_queue(), to
clean up the error handling code in virtio_queue_rq().

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

