Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EEDC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 11:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjC3Ljb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjC3LjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 07:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABF4A248
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680176246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=litTAfSrcuMc4HupIpacq5wCRTNFJAvtr6mPltpyGGw=;
        b=KPkErqkO2QGcNBu9NjAOrcVV8IcGLofu+FmtTCDWBa14/vmY3+t05a+yzV9BNGkoNVV0zD
        YJ36aRElXO88FZpWW07b+auBnnJ78xVJjlcnjE/FhOoIa5BXtRgueusIOGm5y4AR3HduqU
        6zHYDTDomgc3dg+gONV1efrCZ/jGCVo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Z5OlN6ElNumhZQ3Ooc8j3g-1; Thu, 30 Mar 2023 07:37:22 -0400
X-MC-Unique: Z5OlN6ElNumhZQ3Ooc8j3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 948F628237CE;
        Thu, 30 Mar 2023 11:37:21 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2CF4042AC0;
        Thu, 30 Mar 2023 11:37:20 +0000 (UTC)
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
Subject: [PATCH V6 09/17] block: ublk_drv: add two helpers to clean up map/unmap request
Date:   Thu, 30 Mar 2023 19:36:22 +0800
Message-Id: <20230330113630.1388860-10-ming.lei@redhat.com>
In-Reply-To: <20230330113630.1388860-1-ming.lei@redhat.com>
References: <20230330113630.1388860-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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
index c73b2dba25ce..f87597a7d679 100644
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
@@ -772,7 +781,7 @@ static inline void __ublk_rq_task_work(struct request *req,
 		return;
 	}
 
-	if (ublk_need_get_data(ubq) && (req_op(req) == REQ_OP_WRITE)) {
+	if (ublk_need_get_data(ubq) && ublk_need_map_req(req)) {
 		/*
 		 * We have not handled UBLK_IO_NEED_GET_DATA command yet,
 		 * so immepdately pass UBLK_IO_RES_NEED_GET_DATA to ublksrv
-- 
2.39.2

