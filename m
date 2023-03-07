Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E67C678D4
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 14:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCGOWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 09:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCGOV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 09:21:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D098B044
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 06:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678198550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMsNgQWQgB6DB71lSdY+b0QQaIZnvxIxMO/B+UZ8jwc=;
        b=grhFRKau3oPnZdfnP21VIjseGFXpbUg95w6yu46SuQjl5WJA1vetyCIqitFsnPBev/a/7u
        vhc8GQ7BXJn+YPckodrSssipxXY6AC47LtAmq1E3eJv4z67QwrNMQ/sIQqfj64E+NoEcBl
        MjMlPGjPjXvA5srTR/4xFP4dNP7m+FE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-fx7QMbn4NM2lWKqc-E5k9A-1; Tue, 07 Mar 2023 09:15:46 -0500
X-MC-Unique: fx7QMbn4NM2lWKqc-E5k9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B07A43C0E44B;
        Tue,  7 Mar 2023 14:15:45 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED11E2026D4B;
        Tue,  7 Mar 2023 14:15:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 04/17] io_uring: support OP_READ/OP_WRITE for fused slave request
Date:   Tue,  7 Mar 2023 22:15:07 +0800
Message-Id: <20230307141520.793891-5-ming.lei@redhat.com>
In-Reply-To: <20230307141520.793891-1-ming.lei@redhat.com>
References: <20230307141520.793891-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Start to allow fused slave request to support OP_READ/OP_WRITE, and
the buffer can be retrieved from master request.

Once the slave request is completed, the master buffer will be returned
back.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/opdef.c |  2 ++
 io_uring/rw.c    | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 63b90e8e65f8..f044629e5475 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -235,6 +235,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.ioprio			= 1,
 		.iopoll			= 1,
 		.iopoll_queue		= 1,
+		.fused_slave		= 1,
 		.prep			= io_prep_rw,
 		.issue			= io_read,
 	},
@@ -248,6 +249,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.ioprio			= 1,
 		.iopoll			= 1,
 		.iopoll_queue		= 1,
+		.fused_slave		= 1,
 		.prep			= io_prep_rw,
 		.issue			= io_write,
 	},
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 4c233910e200..36d31a943317 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -19,6 +19,7 @@
 #include "kbuf.h"
 #include "rsrc.h"
 #include "rw.h"
+#include "fused_cmd.h"
 
 struct io_rw {
 	/* NOTE: kiocb has the file as the first member, so don't do it here */
@@ -371,6 +372,17 @@ static struct iovec *__io_import_iovec(int ddir, struct io_kiocb *req,
 	size_t sqe_len;
 	ssize_t ret;
 
+	/*
+	 * SLAVE OP passes buffer offset from sqe->addr actually, since
+	 * the fused cmd kbuf's mapped start address is zero.
+	 */
+	if (req->flags & REQ_F_FUSED_SLAVE) {
+		ret = io_import_kbuf_for_slave(rw->addr, rw->len, ddir, iter, req);
+		if (ret)
+			return ERR_PTR(ret);
+		return NULL;
+	}
+
 	if (opcode == IORING_OP_READ_FIXED || opcode == IORING_OP_WRITE_FIXED) {
 		ret = io_import_fixed(ddir, iter, req->imu, rw->addr, rw->len);
 		if (ret)
@@ -428,11 +440,19 @@ static inline loff_t *io_kiocb_ppos(struct kiocb *kiocb)
  */
 static ssize_t loop_rw_iter(int ddir, struct io_rw *rw, struct iov_iter *iter)
 {
+	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 	struct kiocb *kiocb = &rw->kiocb;
 	struct file *file = kiocb->ki_filp;
 	ssize_t ret = 0;
 	loff_t *ppos;
 
+	/*
+	 * Fused slave req hasn't user buffer, so ->read/->write can't
+	 * be supported
+	 */
+	if (req->flags & REQ_F_FUSED_SLAVE)
+		return -EOPNOTSUPP;
+
 	/*
 	 * Don't support polled IO through this interface, and we can't
 	 * support non-blocking either. For the latter, this just causes
-- 
2.39.2

