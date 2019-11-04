Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A1CA9ECF
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6F222CA
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 08:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfKDIew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:34:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbfKDIew (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 03:34:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E846F73A4D7D85F8EE32;
        Mon,  4 Nov 2019 16:34:50 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 4 Nov 2019 16:34:41 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [RFC] io_uring: stop only support read/write for ctx with IORING_SETUP_IOPOLL
Date:   Mon, 4 Nov 2019 16:56:08 +0800
Message-ID: <20191104085608.44816-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no problem to support other type request for the ctx with
IORING_SETUP_IOPOLL. What we should do is just insert read/write
requests to poll list, and protect cqes with comopletion_lock in
io_iopoll_complete since other requests now can be completed as the same
time while we do io_iopoll_complete.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/io_uring.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f9a38998f2fc..8bf52d9a2c55 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -753,9 +753,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 {
 	void *reqs[IO_IOPOLL_BATCH];
 	struct io_kiocb *req;
+	unsigned long flags;
 	int to_free;
 
 	to_free = 0;
+	spin_lock_irqsave(&ctx->completion_lock, flags);
 	while (!list_empty(done)) {
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
@@ -781,6 +783,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 	}
 
 	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 	io_free_req_many(ctx, reqs, &to_free);
 }
 
@@ -1517,9 +1520,6 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 	struct io_ring_ctx *ctx = req->ctx;
 	long err = 0;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-
 	io_cqring_add_event(ctx, user_data, err);
 	io_put_req(req);
 	return 0;
@@ -1527,13 +1527,9 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
 
 static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	struct io_ring_ctx *ctx = req->ctx;
-
 	if (!req->file)
 		return -EBADF;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
@@ -1574,14 +1570,11 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	int ret = 0;
 
 	if (!req->file)
 		return -EBADF;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
 	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
 		return -EINVAL;
 
@@ -1627,9 +1620,6 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	struct socket *sock;
 	int ret;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
-
 	sock = sock_from_file(req->file, &ret);
 	if (sock) {
 		struct user_msghdr __user *msg;
@@ -1712,8 +1702,6 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_kiocb *poll_req, *next;
 	int ret = -ENOENT;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
 	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index ||
 	    sqe->poll_events)
 		return -EINVAL;
@@ -1833,8 +1821,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	__poll_t mask;
 	u16 events;
 
-	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
 	if (sqe->addr || sqe->ioprio || sqe->off || sqe->len || sqe->buf_index)
 		return -EINVAL;
 	if (!poll->file)
@@ -1932,8 +1918,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct timespec64 ts;
 	unsigned span = 0;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
-		return -EINVAL;
 	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
 	    sqe->len != 1)
 		return -EINVAL;
@@ -2032,6 +2016,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			   const struct sqe_submit *s, bool force_nonblock)
 {
 	int ret, opcode;
+	bool poll = false;
 
 	req->user_data = READ_ONCE(s->sqe->user_data);
 
@@ -2046,17 +2031,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
+		poll = true;
 		ret = io_read(req, s, force_nonblock);
 		break;
 	case IORING_OP_WRITEV:
 		if (unlikely(s->sqe->buf_index))
 			return -EINVAL;
+		poll = true;
 		ret = io_write(req, s, force_nonblock);
 		break;
 	case IORING_OP_READ_FIXED:
+		poll = true;
 		ret = io_read(req, s, force_nonblock);
 		break;
 	case IORING_OP_WRITE_FIXED:
+		poll = true;
 		ret = io_write(req, s, force_nonblock);
 		break;
 	case IORING_OP_FSYNC:
@@ -2088,7 +2077,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ret)
 		return ret;
 
-	if (ctx->flags & IORING_SETUP_IOPOLL) {
+	if ((ctx->flags & IORING_SETUP_IOPOLL) && poll) {
 		if (req->result == -EAGAIN)
 			return -EAGAIN;
 
-- 
2.17.2

