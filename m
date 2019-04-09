Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69EC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AC121473
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G5e5PYnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfDIFaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:30:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55414 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfDIFaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 01:30:18 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x395OQhE037119;
        Tue, 9 Apr 2019 05:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=su3ixxBc2ovQWzmQ9/v1Os38Ax8F/YPHBU0NA41zfVk=;
 b=G5e5PYnwou3btMOqJx2XgE7EhCdQa+BS83Zd/we+zzwfBVh/I7Gbbvca3XmHD7/xzgg4
 ykK8fI0aO/0rpbZdRQoMfLriypxHnyUsqEQH2rR9CXswb7eyzyWDUUtboDd6Lot9LFfR
 +FP2Zvr/Pex9fqsLZjrZVFB8aP9D5mfvusUh+8L2BaLtw8q9kqmYOry3RY9WJtHXcmkA
 KhBQ5LaZJ64CBIL4a6vyAiMNZ4d/RkIbiq8UcGafZLj8r/bsCQi8GTSchJYFb2QzTM2z
 NVKdwVVwCXIIZfWomMCmcs72wonYjc00zro2kAGJRLyjFG3OpswhIj+yLO6mBN7FbK0G oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2rphmeapwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 05:30:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x395ScF4002820;
        Tue, 9 Apr 2019 05:30:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2rph7scx2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 05:30:12 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x395UAVF022109;
        Tue, 9 Apr 2019 05:30:11 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 22:30:09 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] io_uring: introduce inline reqs for IORING_SETUP_IOPOLL
Date:   Tue,  9 Apr 2019 13:21:54 +0800
Message-Id: <1554787314-27179-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090037
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090037
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the IORING_SETUP_IOPOLL case, all of the submission and
completion are handled under ctx->uring_lock or in SQ poll thread
context, so io_get_req and io_put_req has been serialized well.
The only exception is the asynchronous workqueue context where could
free the io_kiocb for error. To overcome this, we allocate a new
io_kiocb and free the previous inlined one.

Based on this, we introduce the preallocated reqs list per ctx and
needn't to provide any lock to serialize the updating of list. The
performacne benefits from this. The test result of following fio
command

fio --name=io_uring_test --ioengine=io_uring --hipri --fixedbufs
--iodepth=16 --direct=1 --numjobs=1 --filename=/dev/nvme0n1 --bs=4k
--group_reporting --runtime=10

shows IOPS upgrade from 197K to 206K.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
V2 -> V1:
 - use list to maintian the preallocated io_kiocb
 - allocate a new io_kiocb when punt io to workqueue context

 fs/io_uring.c | 142 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 112 insertions(+), 30 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6aaa3058..e944ec0 100644
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
 
+	struct io_kiocb 		*inline_req_array;
+	struct list_head 		inline_req_list;
+	unsigned int 			inline_available_reqs;
+
 	struct {
 		unsigned int		flags;
 		bool			compat;
@@ -226,9 +232,9 @@ struct io_kiocb {
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
 #define REQ_F_PREPPED		16	/* prep already done */
+#define REQ_F_INLINE		32	/* ctx inline req */
 	u64			user_data;
 	u64			error;
-
 	struct work_struct	work;
 };
 
@@ -396,6 +402,23 @@ static void io_ring_drop_ctx_refs(struct io_ring_ctx *ctx, unsigned refs)
 		wake_up(&ctx->wait);
 }
 
+static struct io_kiocb *io_get_inline_req(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	req = list_first_entry(&ctx->inline_req_list, struct io_kiocb, list);
+	list_del_init(&req->list);
+	ctx->inline_available_reqs--;
+	return req;
+}
+
+static void io_free_inline_req(struct io_ring_ctx *ctx, struct io_kiocb *req)
+{
+	INIT_LIST_HEAD(&req->list);
+	list_add(&req->list, &ctx->inline_req_list);
+	ctx->inline_available_reqs++;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
@@ -405,10 +428,14 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (!percpu_ref_tryget(&ctx->refs))
 		return NULL;
 
-	if (!state) {
+	if (ctx->inline_available_reqs) {
+		req = io_get_inline_req(ctx);
+	    req->flags = REQ_F_INLINE;
+	} else if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto out;
+		req->flags = 0;
 	} else if (!state->free_reqs) {
 		size_t sz;
 		int ret;
@@ -429,14 +456,15 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->free_reqs = ret - 1;
 		state->cur_req = 1;
 		req = state->reqs[0];
+		req->flags = 0;
 	} else {
 		req = state->reqs[state->cur_req];
 		state->free_reqs--;
 		state->cur_req++;
+		req->flags = 0;
 	}
 
 	req->ctx = ctx;
-	req->flags = 0;
 	/* one is dropped after submission, the other at completion */
 	refcount_set(&req->refs, 2);
 	return req;
@@ -456,10 +484,15 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
 static void io_free_req(struct io_kiocb *req)
 {
+	struct io_ring_ctx	*ctx = req->ctx;
+
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	io_ring_drop_ctx_refs(req->ctx, 1);
-	kmem_cache_free(req_cachep, req);
+	if (req->flags & REQ_F_INLINE)
+		io_free_inline_req(ctx, req);
+	else
+	    kmem_cache_free(req_cachep, req);
 }
 
 static void io_put_req(struct io_kiocb *req)
@@ -492,7 +525,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file.
 			 */
-			if (req->flags & REQ_F_FIXED_FILE) {
+			if (!(req->flags & REQ_F_INLINE) && req->flags & REQ_F_FIXED_FILE) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -1593,6 +1626,45 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	return 0;
 }
 
+static int io_punt_req_to_work(struct io_ring_ctx *ctx, struct sqe_submit *s,
+			 struct io_kiocb *req)
+{
+	struct io_uring_sqe *sqe_copy;
+	struct io_kiocb *req_copy;
+	struct async_list *list;
+
+	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+	if (!sqe_copy)
+		return -ENOMEM;
+
+	if (req->flags & REQ_F_INLINE) {
+		req_copy = kmem_cache_alloc(req_cachep, GFP_KERNEL);
+		if (!req_copy) {
+			kfree(sqe_copy);
+			return -ENOMEM;
+		}
+
+		memcpy(req_copy, req, sizeof(*req));
+		req_copy->flags &= ~REQ_F_INLINE;
+		io_free_inline_req(ctx, req);
+		req = req_copy;
+	}
+
+	memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
+	s->sqe = sqe_copy;
+
+	memcpy(&req->submit, s, sizeof(*s));
+	list = io_async_list_from_sqe(ctx, s->sqe);
+	if (!io_add_to_prev_work(list, req)) {
+		if (list)
+			atomic_inc(&list->cnt);
+		INIT_WORK(&req->work, io_sq_wq_submit_work);
+		queue_work(ctx->sqo_wq, &req->work);
+	}
+
+	return 0;
+}
+
 static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 			 struct io_submit_state *state)
 {
@@ -1613,31 +1685,13 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 
 	ret = __io_submit_sqe(ctx, req, s, true, state);
 	if (ret == -EAGAIN) {
-		struct io_uring_sqe *sqe_copy;
-
-		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
-		if (sqe_copy) {
-			struct async_list *list;
-
-			memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
-			s->sqe = sqe_copy;
-
-			memcpy(&req->submit, s, sizeof(*s));
-			list = io_async_list_from_sqe(ctx, s->sqe);
-			if (!io_add_to_prev_work(list, req)) {
-				if (list)
-					atomic_inc(&list->cnt);
-				INIT_WORK(&req->work, io_sq_wq_submit_work);
-				queue_work(ctx->sqo_wq, &req->work);
-			}
-
-			/*
-			 * Queued up for async execution, worker will release
-			 * submit reference when the iocb is actually
-			 * submitted.
-			 */
+		/*
+		 * Queued up for async execution, worker will release
+		 * submit reference when the iocb is actually
+		 * submitted.
+		 */
+		if (!io_punt_req_to_work(ctx, s, req))
 			return 0;
-		}
 	}
 
 out:
@@ -2520,6 +2574,9 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		sock_release(ctx->ring_sock);
 #endif
 
+	if (ctx->inline_req_array)
+		kfree(ctx->inline_req_array);
+
 	io_mem_free(ctx->sq_ring);
 	io_mem_free(ctx->sq_sqes);
 	io_mem_free(ctx->cq_ring);
@@ -2783,7 +2840,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	struct user_struct *user = NULL;
 	struct io_ring_ctx *ctx;
 	bool account_mem;
-	int ret;
+	int ret, i;
 
 	if (!entries || entries > IORING_MAX_ENTRIES)
 		return -EINVAL;
@@ -2817,6 +2874,31 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
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
+	ctx->inline_available_reqs = 0;
+	if (ctx->flags & IORING_SETUP_IOPOLL) {
+		ctx->inline_req_array = kmalloc(
+			sizeof(struct io_kiocb) * INLINE_REQS_TOTAL,
+			GFP_KERNEL);
+		if (ctx->inline_req_array) {
+			struct io_kiocb *req;
+			INIT_LIST_HEAD(&ctx->inline_req_list);
+			for (i = 0; i < INLINE_REQS_TOTAL; i++) {
+				req = ctx->inline_req_array + i;
+			    INIT_LIST_HEAD(&req->list);
+			    list_add_tail(&req->list, &ctx->inline_req_list);
+			}
+			ctx->inline_available_reqs = INLINE_REQS_TOTAL;
+		}
+	}
+
 	ctx->compat = in_compat_syscall();
 	ctx->account_mem = account_mem;
 	ctx->user = user;
-- 
2.7.4

