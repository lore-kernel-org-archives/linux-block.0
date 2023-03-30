Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562BEC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 11:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjC3Llr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjC3Llc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 07:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA164B75F
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680176379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2HaaAMVXBOU9npIKRCm63G2Jnf2K0Y8PRLMtIL+XBWM=;
        b=MjFbtW/QqLHQfLAV9OScLju9IhFOO4Gw8pVmnhbysGrLzYjJglnVk0b5NIXDRrhJQMAOAz
        xfzHMn4d+qOgXxKF91PZgQUYC6RdGItXK+XzZ8RBGEDIYdnDh7Y+q2E5S7hIAnQy+jDgXh
        q/V7dkk1hfSqc/vTVWHQo5+Ah9XpdX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-Rhj8dw_eM82Bc3Cpkq4GXA-1; Thu, 30 Mar 2023 07:37:14 -0400
X-MC-Unique: Rhj8dw_eM82Bc3Cpkq4GXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD54888B7A2;
        Thu, 30 Mar 2023 11:37:13 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4F83202701F;
        Thu, 30 Mar 2023 11:37:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V6 07/17] block: ublk_drv: add common exit handling
Date:   Thu, 30 Mar 2023 19:36:20 +0800
Message-Id: <20230330113630.1388860-8-ming.lei@redhat.com>
In-Reply-To: <20230330113630.1388860-1-ming.lei@redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify exit handling a bit, and prepare for supporting fused command.

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c73cc57ec547..bc46616710d4 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -655,14 +655,15 @@ static void ublk_complete_rq(struct request *req)
 	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublk_io *io = &ubq->ios[req->tag];
 	unsigned int unmapped_bytes;
+	blk_status_t res = BLK_STS_OK;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
 		io->res = -EIO;
 
 	if (io->res < 0) {
-		blk_mq_end_request(req, errno_to_blk_status(io->res));
-		return;
+		res = errno_to_blk_status(io->res);
+		goto exit;
 	}
 
 	/*
@@ -671,10 +672,8 @@ static void ublk_complete_rq(struct request *req)
 	 *
 	 * Both the two needn't unmap.
 	 */
-	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
-		blk_mq_end_request(req, BLK_STS_OK);
-		return;
-	}
+	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE)
+		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
 	unmapped_bytes = ublk_unmap_io(ubq, req, io);
@@ -691,6 +690,10 @@ static void ublk_complete_rq(struct request *req)
 		blk_mq_requeue_request(req, true);
 	else
 		__blk_mq_end_request(req, BLK_STS_OK);
+
+	return;
+exit:
+	blk_mq_end_request(req, res);
 }
 
 /*
-- 
2.39.2

