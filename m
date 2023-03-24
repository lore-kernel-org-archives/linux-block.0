Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59654C76196
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCXOAX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjCXOAI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 10:00:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6991B2FD
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679666334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULACr9hwIdunm2lWS57kdMnN4Bb/D0rvhYQEw4GmFbc=;
        b=ACRfrdRhIminy2Smz/VuPjzGLw51qDJfdvBoBL88T8qunxHIljZfjfeK9e+h47dESJYMwk
        7hYt4IiCJxlWgN3DSPe8f77Z1XOaENSCsrugfM3aJK7/2LWgGIyDt1X5Fn05exGZftUpcH
        NFmp3vE8E47JEtfeg+iwCp3UzDRPIXY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-3JFO45fQOEennVluWcWD3A-1; Fri, 24 Mar 2023 09:58:53 -0400
X-MC-Unique: 3JFO45fQOEennVluWcWD3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB518855312;
        Fri, 24 Mar 2023 13:58:52 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE6D02027040;
        Fri, 24 Mar 2023 13:58:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 09/17] block: ublk_drv: add two helpers to clean up map/unmap request
Date:   Fri, 24 Mar 2023 21:58:00 +0800
Message-Id: <20230324135808.855245-10-ming.lei@redhat.com>
In-Reply-To: <20230324135808.855245-1-ming.lei@redhat.com>
References: <20230324135808.855245-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add two helpers for checking if map/unmap is needed, since we may have
passthrough request which needs map or unmap in future, such as for
supporting report zones.

Meantime don't mark ublk_copy_user_pages as inline since this function
is a bit fat now.

Reviewed-by: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4fe324da97a0..43c0b1247924 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -488,8 +488,7 @@ static inline unsigned ublk_copy_io_pages(struct ublk_io_iter *data,
 	return done;
 }
 
-static inline int ublk_copy_user_pages(struct ublk_map_data *data,
-		bool to_vm)
+static int ublk_copy_user_pages(struct ublk_map_data *data, bool to_vm)
 {
 	const unsigned int gup_flags = to_vm ? FOLL_WRITE : 0;
 	const unsigned long start_vm = data->io->addr;
@@ -525,6 +524,16 @@ static inline int ublk_copy_user_pages(struct ublk_map_data *data,
 	return done;
 }
 
+static inline bool ublk_need_map_req(const struct request *req)
+{
+	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE;
+}
+
+static inline bool ublk_need_unmap_req(const struct request *req)
+{
+	return ublk_rq_has_data(req) && req_op(req) == REQ_OP_READ;
+}
+
 static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 		struct ublk_io *io)
 {
@@ -535,7 +544,7 @@ static int ublk_map_io(const struct ublk_queue *ubq, const struct request *req,
 	 * context and the big benefit is that pinning pages in current
 	 * context is pretty fast, see ublk_pin_user_pages
 	 */
-	if (ublk_rq_has_data(req) && req_op(req) == REQ_OP_WRITE) {
+	if (ublk_need_map_req(req)) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -556,7 +565,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
 {
 	const unsigned int rq_bytes = blk_rq_bytes(req);
 
-	if (req_op(req) == REQ_OP_READ && ublk_rq_has_data(req)) {
+	if (ublk_need_unmap_req(req)) {
 		struct ublk_map_data data = {
 			.ubq	=	ubq,
 			.rq	=	req,
@@ -770,7 +779,7 @@ static inline void __ublk_rq_task_work(struct request *req)
 		return;
 	}
 
-	if (ublk_need_get_data(ubq) && (req_op(req) == REQ_OP_WRITE)) {
+	if (ublk_need_get_data(ubq) && ublk_need_map_req(req)) {
 		/*
 		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
 		 * so immepdately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
-- 
2.39.2

