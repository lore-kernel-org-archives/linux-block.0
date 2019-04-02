Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54326C10F00
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8442084B
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 03:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBH7v73K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDBDTF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:19:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33706 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBDTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 23:19:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x323J08H015187;
        Tue, 2 Apr 2019 03:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=qIOAyMoFW13BhhAz4Yel9a3u5wBN/L0O3eqf4+9E9Mo=;
 b=MBH7v73KwAYCFK18cuF7+k2cVy0PP8s3voVKruuTBNeZCQ++UDCY9zq50m6LUxUQeV0+
 1TOqug7V5g2urnFWoFqBputscJ2vCuJr1OxWFAYeqdZzYpIB9TVs+Sa5NXEKhi2QnOdN
 NmTeJquAgNh3fHqucZnHFmDJNtFkndq9CBWCWU+Pns7Qw9gfgaIeZ3UEKp8+eps30rJx
 XFosgJYBiTAN2W6GfWudwxprGJksOpSr5JJUFkhE//cBhlbZkbGvQ7SZKGyslKo5MjiO
 6oUQplkilIjdreEtY1yKflLF7xNZDEFtRvf2KrT+/nFK5bTcefmE8qT3800M0aptm1Ic rw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2rj13q2dy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 03:19:00 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x323IwxZ013477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 03:18:59 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x323Ivfn016028;
        Tue, 2 Apr 2019 03:18:57 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Apr 2019 20:18:56 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: introduce inline reqs for IORING_SETUP_IOPOLL & direct_io
Date:   Tue,  2 Apr 2019 11:10:46 +0800
Message-Id: <1554174646-1715-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9214 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020022
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the IORING_SETUP_IOPOLL & direct_io case, all of the submission
and completion are handled under ctx->uring_lock or in SQ poll thread
context, so io_get_req and io_put_req has been serialized well.

Based on this, we introduce the preallocated reqs ring per ctx and
needn't to provide any lock to serialize the updating of the head
and tail. The performacne benefits from this. The test result of
following fio command

fio --name=io_uring_test --ioengine=io_uring --hipri --fixedbufs
--iodepth=16 --direct=1 --numjobs=1 --filename=/dev/nvme0n1 --bs=4k
--group_reporting --runtime=10

shows IOPS upgrade from 197K to 206K.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 fs/io_uring.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 18 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aaa3058..40837e4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -104,11 +104,17 @@ struct async_list {
 	size_t			io_pages;
 };
 
+#define INLINE_REQS_TOTAL 128
+
 struct io_ring_ctx {
 	struct {
 		struct percpu_ref	refs;
 	} ____cacheline_aligned_in_smp;
 
+	struct io_kiocb *inline_reqs[INLINE_REQS_TOTAL];
+	struct io_kiocb *inline_req_array;
+	unsigned long inline_reqs_h, inline_reqs_t;
+
 	struct {
 		unsigned int		flags;
 		bool			compat;
@@ -183,7 +189,9 @@ struct io_ring_ctx {
 
 struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
+	struct file 			*file;
 	unsigned short			index;
+	bool 				is_fixed;
 	bool				has_user;
 	bool				needs_lock;
 	bool				needs_fixed_file;
@@ -228,7 +236,7 @@ struct io_kiocb {
 #define REQ_F_PREPPED		16	/* prep already done */
 	u64			user_data;
 	u64			error;
-
+	bool 			ctx_inline;
 	struct work_struct	work;
 };
 
@@ -397,7 +405,8 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 }
 
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
-				   struct io_submit_state *state)
+				   struct io_submit_state *state,
+				   bool direct_io)
 {
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct io_kiocb *req;
@@ -405,10 +414,19 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	if (!state) {
+	/*
+	 * Avoid race with workqueue context that handle buffered IO.
+	 */
+	if (direct_io &&
+	    ctx->inline_reqs_h - ctx->inline_reqs_t < INLINE_REQS_TOTAL) {
+	    req = ctx->inline_reqs[ctx->inline_reqs_h % INLINE_REQS_TOTAL];
+	    ctx->inline_reqs_h++;
+	    req->ctx_inline = true;
+	} else if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto out;
+		req->ctx_inline = false;
 	} else if (!state->free_reqs) {
 		size_t sz;
 		int ret;
@@ -429,10 +447,12 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->free_reqs = ret - 1;
 		state->cur_req = 1;
 		req = state->reqs[0];
+		req->ctx_inline = false;
 	} else {
 		req = state->reqs[state->cur_req];
 		state->free_reqs--;
 		state->cur_req++;
+		req->ctx_inline = false;
 	}
 
 	req->ctx = ctx;
@@ -456,10 +476,17 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
 static void io_free_req(struct io_kiocb *req)
 {
+	struct io_ring_ctx	*ctx = req->ctx;
+
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	io_ring_drop_ctx_refs(req->ctx, 1);
-	kmem_cache_free(req_cachep, req);
+	if (req->ctx_inline) {
+	    ctx->inline_reqs[ctx->inline_reqs_t % INLINE_REQS_TOTAL] = req;
+	    ctx->inline_reqs_t++;
+	} else {
+	    kmem_cache_free(req_cachep, req);
+	}
 }
 
 static void io_put_req(struct io_kiocb *req)
@@ -492,7 +519,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file.
 			 */
-			if (req->flags & REQ_F_FIXED_FILE) {
+			if (!req->ctx_inline && req->flags & REQ_F_FIXED_FILE) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -1562,7 +1589,7 @@ static bool io_op_needs_file(const struct io_uring_sqe *sqe)
 	}
 }
 
-static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
+static int io_req_set_file(struct io_ring_ctx *ctx, struct sqe_submit *s,
 			   struct io_submit_state *state, struct io_kiocb *req)
 {
 	unsigned flags;
@@ -1572,7 +1599,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	fd = READ_ONCE(s->sqe->fd);
 
 	if (!io_op_needs_file(s->sqe)) {
-		req->file = NULL;
+		s->file = NULL;
 		return 0;
 	}
 
@@ -1580,13 +1607,13 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		if (unlikely(!ctx->user_files ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
-		req->file = ctx->user_files[fd];
-		req->flags |= REQ_F_FIXED_FILE;
+		s->file = ctx->user_files[fd];
+		s->is_fixed = true;
 	} else {
 		if (s->needs_fixed_file)
 			return -EBADF;
-		req->file = io_file_get(state, fd);
-		if (unlikely(!req->file))
+		s->file = io_file_get(state, fd);
+		if (unlikely(!s->file))
 			return -EBADF;
 	}
 
@@ -1603,13 +1630,20 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (unlikely(s->sqe->flags & ~IOSQE_FIXED_FILE))
 		return -EINVAL;
 
-	req = io_get_req(ctx, state);
-	if (unlikely(!req))
-		return -EAGAIN;
-
 	ret = io_req_set_file(ctx, s, state, req);
 	if (unlikely(ret))
-		goto out;
+		return ret;
+
+	req = io_get_req(ctx, state, io_is_direct(s->file));
+	if (unlikely(!req)) {
+		if (s->file && !s->is_fixed)
+			fput(s->file);
+		return -EAGAIN;
+	}
+
+	req->file = s->file;
+	if (s->is_fixed)
+	    req->flags |= REQ_F_FIXED_FILE;
 
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
@@ -1640,7 +1674,6 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		}
 	}
 
-out:
 	/* drop submission reference */
 	io_put_req(req);
 
@@ -2520,6 +2553,9 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		sock_release(ctx->ring_sock);
 #endif
 
+	if (ctx->inline_req_array)
+		kfree(ctx->inline_req_array);
+
 	io_mem_free(ctx->sq_ring);
 	io_mem_free(ctx->sq_sqes);
 	io_mem_free(ctx->cq_ring);
@@ -2783,7 +2819,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	struct user_struct *user = NULL;
 	struct io_ring_ctx *ctx;
 	bool account_mem;
-	int ret;
+	int ret, i;
 
 	if (!entries || entries > IORING_MAX_ENTRIES)
 		return -EINVAL;
@@ -2817,6 +2853,30 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 		free_uid(user);
 		return -ENOMEM;
 	}
+
+	/*
+	 * When IORING_SETUP_IOPOLL and direct_io, all of submit and
+	 * completion are handled under ctx->uring_lock or in SQ poll
+	 * thread context, so io_get_req and io_put_req are serialized
+	 * well. we could update inline_reqs_h and inline_reqs_t w/o any
+	 * lock and benefit from the inline reqs.
+	 */
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		ctx->inline_req_array = kmalloc(
+			sizeof(struct io_kiocb) * INLINE_REQS_TOTAL,
+			GFP_KERNEL);
+		if (ctx->inline_req_array) {
+			for (i = 0; i < INLINE_REQS_TOTAL; i++)
+				ctx->inline_reqs[i] = ctx->inline_req_array + i;
+			ctx->inline_reqs_h = ctx->inline_reqs_t = 0;
+		}
+	}
+
+	if (!ctx->inline_req_array) {
+		ctx->inline_reqs_h = INLINE_REQS_TOTAL;
+		ctx->inline_reqs_t = 0;
+	}
+
 	ctx->compat = in_compat_syscall();
 	ctx->account_mem = account_mem;
 	ctx->user = user;
-- 
2.7.4

