Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F644C74A5B
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 13:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjCNNEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjCNND6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 09:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D9A1630B
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678798689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZx3xS1ITkAS/DMGNSi3565ZmakI+lYblE9nWBc6PMw=;
        b=evvX4AZJSEmxhCmQJ0wCBUp17MfRHEPhHbBhfIuexKIE6Uu7gM7lBhQ2nzimoZn0k7x6L/
        HHLkN6Vpne4Mh96Ovlr3fKc5xIix8kgqEkwhha3rp4Zy68i6Fs/bBpFMgNUhTvy6x7WfeZ
        gNoRpA0zosyrpM7VuyAtyEz/ofAqPkk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-UYLmqG18PSaxDrblaYZ4sQ-1; Tue, 14 Mar 2023 08:58:04 -0400
X-MC-Unique: UYLmqG18PSaxDrblaYZ4sQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F807800B23;
        Tue, 14 Mar 2023 12:58:03 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91FF8140EBF4;
        Tue, 14 Mar 2023 12:58:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/16] block: ublk_drv: add two helpers to clean up map/unmap request
Date:   Tue, 14 Mar 2023 20:57:19 +0800
Message-Id: <20230314125727.1731233-9-ming.lei@redhat.com>
In-Reply-To: <20230314125727.1731233-1-ming.lei@redhat.com>
References: <20230314125727.1731233-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
index 5b13a58b424b..469e15057d7a 100644
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

