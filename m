Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1CC74A5B
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 13:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjCNNHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCNNGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 09:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3FAB896
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678798872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GCd/y9yJtVA8XDAYt1glGnmt8lD08vACmNvU781sw/g=;
        b=acsxJ5Yo1fqwb/5U1yDPgQbVLj6wdY2m21P3B8UzNi/relUG7grnGeWMHvRQ4lmYQyG+Nm
        Ekbb71i2iU9hHGU9OyK1VlCRoOj9fowfCAd2U/9fWPiV9GCRvjepBln1tciE0rnADiy31B
        ThmLnZMdH+9FxfbX4gzWHAH3NQOj5nY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-aOmwJdxqNMSZ8Y4AIowvlQ-1; Tue, 14 Mar 2023 08:58:00 -0400
X-MC-Unique: aOmwJdxqNMSZ8Y4AIowvlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9F3B8027FD;
        Tue, 14 Mar 2023 12:57:59 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3674640AE2C0;
        Tue, 14 Mar 2023 12:57:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 07/16] block: ublk_drv: don't consider flush request in map/unmap io
Date:   Tue, 14 Mar 2023 20:57:18 +0800
Message-Id: <20230314125727.1731233-8-ming.lei@redhat.com>
In-Reply-To: <20230314125727.1731233-1-ming.lei@redhat.com>
References: <20230314125727.1731233-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There isn't data in request of REQ_OP_FLUSH always, so don't consider
it in both ublk_map_io() and ublk_unmap_io().

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 64821755f415..5b13a58b424b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -529,15 +529,13 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		struct ublk_io *io)
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
+
 	/*
 	 * no zero copy, we delay copy WRITE request data into ublksrv
 	 * context and the big benefit is that pinning pages in current
 	 * context is pretty fast, see ublk_pin_user_pages
 	 */
-	if (req_op(req) != REQ_OP_WRITE && req_op(req) != REQ_OP_FLUSH)
-		return rq_bytes;
-
-	if (ublk_rq_has_data(req)) {
+	if (ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -772,9 +770,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 		return;
 	}
 
-	if (ublk_need_get_data(ubq) &&
-			(req_op(req) == REQ_OP_WRITE ||
-			req_op(req) == REQ_OP_FLUSH)) {
+	if (ublk_need_get_data(ubq) && (req_op(req) == REQ_OP_WRITE)) {
 		/*
 		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
 		 * so immepdately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
-- 
2.39.2

