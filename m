Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B54FC6FD1E
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 14:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCGOZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 09:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCGOZ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 09:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1BA8B046
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 06:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678198750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/8o7oVK1PRUQreC7eaCR5WXIzG/YrOlciL0BHCQHEk=;
        b=aXq4fUDScutEiHGVIueubUo9Nki++e5L+BgcUkkgn+E7JtmkGoDpCMnzEpeOfzCHxcS5/3
        OXzTqhyq75ZfYx+r/Kqw3QCa0uPIx9rgfAjmhIAWxn8HOvx5EmvH5D0YQM9BTrT1z9PQZX
        GRRKqQo5lHifsqsE3SzSdxNtK/hktVA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-BIf_w_NgNFy6TKhAB-E8ZA-1; Tue, 07 Mar 2023 09:15:55 -0500
X-MC-Unique: BIf_w_NgNFy6TKhAB-E8ZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8F75858F0E;
        Tue,  7 Mar 2023 14:15:54 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03DC5C15BA0;
        Tue,  7 Mar 2023 14:15:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 05/17] io_uring: support OP_SEND_ZC/OP_RECV for fused slave request
Date:   Tue,  7 Mar 2023 22:15:08 +0800
Message-Id: <20230307141520.793891-6-ming.lei@redhat.com>
In-Reply-To: <20230307141520.793891-1-ming.lei@redhat.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Start to allow fused slave request to support OP_SEND_ZC/OP_RECV, and
the buffer can be retrieved from master request.

Once the slave request is completed, the master buffer will be returned
back.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/net.c   | 23 +++++++++++++++++++++--
 io_uring/opdef.c |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index b7f190ca528e..9ec6a77b4e82 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -16,6 +16,7 @@
 #include "net.h"
 #include "notif.h"
 #include "rsrc.h"
+#include "fused_cmd.h"
 
 #if defined(CONFIG_NET)
 struct io_shutdown {
@@ -378,7 +379,11 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 
-	ret = import_ubuf(ITER_SOURCE, sr->buf, sr->len, &msg.msg_iter);
+	if (!(req->flags & REQ_F_FUSED_SLAVE))
+		ret = import_ubuf(ITER_SOURCE, sr->buf, sr->len, &msg.msg_iter);
+	else
+		ret = io_import_kbuf_for_slave((u64)sr->buf, sr->len,
+				ITER_SOURCE, &msg.msg_iter, req);
 	if (unlikely(ret))
 		return ret;
 
@@ -869,7 +874,11 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		sr->buf = buf;
 	}
 
-	ret = import_ubuf(ITER_DEST, sr->buf, len, &msg.msg_iter);
+	if (!(req->flags & REQ_F_FUSED_SLAVE))
+		ret = import_ubuf(ITER_DEST, sr->buf, len, &msg.msg_iter);
+	else
+		ret = io_import_kbuf_for_slave((u64)sr->buf, sr->len, ITER_DEST,
+				&msg.msg_iter, req);
 	if (unlikely(ret))
 		goto out_free;
 
@@ -983,6 +992,9 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	if (zc->flags & IORING_RECVSEND_FIXED_BUF) {
 		unsigned idx = READ_ONCE(sqe->buf_index);
 
+		if (req->flags & REQ_F_FUSED_SLAVE)
+			return -EINVAL;
+
 		if (unlikely(idx >= ctx->nr_user_bufs))
 			return -EFAULT;
 		idx = array_index_nospec(idx, ctx->nr_user_bufs);
@@ -1119,8 +1131,15 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 		if (unlikely(ret))
 			return ret;
 		msg.sg_from_iter = io_sg_from_iter;
+	} else if (req->flags & REQ_F_FUSED_SLAVE) {
+		ret = io_import_kbuf_for_slave((u64)zc->buf, zc->len,
+				ITER_SOURCE, &msg.msg_iter, req);
+		if (unlikely(ret))
+			return ret;
+		msg.sg_from_iter = io_sg_from_iter;
 	} else {
 		io_notif_set_extended(zc->notif);
+
 		ret = import_ubuf(ITER_SOURCE, zc->buf, zc->len, &msg.msg_iter);
 		if (unlikely(ret))
 			return ret;
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index f044629e5475..0a9d39a9db16 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -271,6 +271,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.manual_alloc		= 1,
+		.fused_slave		= 1,
 #if defined(CONFIG_NET)
 		.prep			= io_sendmsg_prep,
 		.issue			= io_send,
@@ -285,6 +286,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.buffer_select		= 1,
 		.audit_skip		= 1,
 		.ioprio			= 1,
+		.fused_slave		= 1,
 #if defined(CONFIG_NET)
 		.prep			= io_recvmsg_prep,
 		.issue			= io_recv,
@@ -411,6 +413,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.audit_skip		= 1,
 		.ioprio			= 1,
 		.manual_alloc		= 1,
+		.fused_slave		= 1,
 #if defined(CONFIG_NET)
 		.prep			= io_send_zc_prep,
 		.issue			= io_send_zc,
-- 
2.39.2

