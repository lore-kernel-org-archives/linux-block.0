Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4CCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A474C2166E
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SqSi56+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfJXJSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:18:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38368 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJXJSq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 05:18:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9EiAE107662;
        Thu, 24 Oct 2019 09:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=H3Qxkp3BPvOVi2rOIUqQXuxVeEzZ3HZt4pQgXNs5hHY=;
 b=SqSi56+QsWxjKk/8H7GJ5AYUafUYRjGJiHD5PlykOpHN1QseQiwxAOju8GhlAhGK1ZE4
 D1KxFqt28PoeEnKG5riqsPeYPNXFognm/aCSfoCO6GY0Q/dNP2+D5cSJbER99NIpBdDS
 LZ+pPqrtb2l/+Db0kXEwneWnYoI/pV3ZOirQHa/CIHHKn5jTS9WhVaVq8TqaVJLZmPBs
 tl1Ns3fTBKaVdsm14nUiwMpcNOwTi6pi0txLwWBxyrAOb+6iel8QEyUfhY9FJ1mYs1BV
 c7bI7Oed7AH4/PftXScMT/wk1BDw7fho8dPLhit5wtD4JaG6H3xrS+VdglEXcUh4ocO7 kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vqteq2bmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9IYqg116925;
        Thu, 24 Oct 2019 09:18:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vtm244yc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:41 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9IOM5016236;
        Thu, 24 Oct 2019 09:18:24 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 02:18:24 -0700
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 2/2] io_uring: examine request result only after completion
Date:   Thu, 24 Oct 2019 02:18:08 -0700
Message-Id: <1571908688-22488-3-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
References: <1571908688-22488-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240090
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__io_submit_sqe() checks the result of a request for -EAGAIN in
polled mode, without ensuring first that the request has completed.
The request will be immediately resubmitted in io_sq_wq_submit_work(),
potentially before the the first submission has completed.  This creates
a race where the original completion may set REQ_F_IOPOLL_COMPLETED in
a freed submission request.

Move a submitted request to the poll list unconditionally in polled mode.
The request can then be retried if necessary once the original submission
has indeed completed.

Signed-off-by: <bijan.mottahedeh@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/io_uring.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index acb213c..9e2eef5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -328,6 +328,7 @@ struct io_kiocb {
 #define REQ_F_TIMEOUT		1024	/* timeout request */
 #define REQ_F_ISREG		2048	/* regular file */
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
+#define REQ_F_SQE_ALLOC		8192	/* dynamically allocated sqe */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -657,6 +658,16 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 {
 	if (*nr) {
+		int i;
+		struct io_kiocb *req;
+
+		for (i = 0; i < *nr; i++) {
+			req = reqs[i];
+			if (req->flags & REQ_F_SQE_ALLOC) {
+				kfree(req->submit.sqe);
+				req->submit.sqe = NULL;
+			}
+		}
 		kmem_cache_free_bulk(req_cachep, *nr, reqs);
 		percpu_ref_put_many(&ctx->refs, *nr);
 		*nr = 0;
@@ -668,6 +679,10 @@ static void __io_free_req(struct io_kiocb *req)
 	if (req->file && !(req->flags & REQ_F_FIXED_FILE))
 		fput(req->file);
 	percpu_ref_put(&req->ctx->refs);
+	if (req->flags & REQ_F_SQE_ALLOC) {
+		kfree(req->submit.sqe);
+		req->submit.sqe = NULL;
+	}
 	kmem_cache_free(req_cachep, req);
 }
 
@@ -789,6 +804,29 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
+		/*
+		 * If a retry is needed, reset the request and queue
+		 * it for async submission.
+		 */
+		if (req->result == -EAGAIN) {
+			int ret;
+
+			refcount_set(&req->refs, 2);
+			req->flags &= ~REQ_F_IOPOLL_COMPLETED;
+			req->result = 0;
+
+			ret = io_queue_async(ctx, req, &req->submit);
+			if (!ret)
+				continue;
+
+			/*
+			 * The async submission failed.  Mark the
+			 * request as complete.
+			 */
+			refcount_set(&req->refs, 1);
+			req->flags |= REQ_F_IOPOLL_COMPLETED;
+		}
+
 		io_cqring_fill_event(ctx, req->user_data, req->result);
 		(*nr_events)++;
 
@@ -835,9 +873,14 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		 * Move completed entries to our local list. If we find a
 		 * request that requires polling, break out and complete
 		 * the done list first, if we have entries there.
+		 * Make sure the completed entries have been properly
+		 * reference counted before moving them.  This accounts
+		 * for a race where a request can complete before its
+		 * reference count is decremented after the submission.
 		 */
 		if (req->flags & REQ_F_IOPOLL_COMPLETED) {
-			list_move_tail(&req->list, &done);
+			if (refcount_read(&req->refs) < 2)
+				list_move_tail(&req->list, &done);
 			continue;
 		}
 		if (!list_empty(&done))
@@ -1007,8 +1050,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
 	req->result = res;
-	if (res != -EAGAIN)
-		req->flags |= REQ_F_IOPOLL_COMPLETED;
+	req->flags |= REQ_F_IOPOLL_COMPLETED;
 }
 
 /*
@@ -2116,6 +2158,7 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
 	req->submit.sqe = sqe_copy;
+	req->flags |= REQ_F_SQE_ALLOC;
 
 	INIT_WORK(&req->work, io_sq_wq_submit_work);
 	trace_io_uring_defer(ctx, req, false);
@@ -2189,9 +2232,12 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return ret;
 
 	if (ctx->flags & IORING_SETUP_IOPOLL) {
-		if (req->result == -EAGAIN)
-			return -EAGAIN;
-
+		/*
+		 * Add the request to the poll list unconditionally.
+		 * The request may be resubmitted in case of EAGAIN
+		 * during completion processing.
+		 */
+		memcpy(&req->submit, s, sizeof(*s));
 		/* workqueue context doesn't hold uring_lock, grab it now */
 		if (s->in_async)
 			mutex_lock(&ctx->uring_lock);
@@ -2284,9 +2330,6 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 			io_put_req(req, NULL);
 		}
 
-		/* async context always use a copy of the sqe */
-		kfree(sqe);
-
 		/* if a dependent link is ready, do that as the next one */
 		if (!ret && nxt) {
 			req = nxt;
@@ -2451,6 +2494,7 @@ static int io_queue_async(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		return -ENOMEM;
 
 	s->sqe = sqe_copy;
+	req->flags |= REQ_F_SQE_ALLOC;
 
 	memcpy(&req->submit, s, sizeof(*s));
 	list = io_async_list_from_sqe(ctx, s->sqe);
@@ -2607,6 +2651,7 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		}
 
 		s->sqe = sqe_copy;
+		req->flags |= REQ_F_SQE_ALLOC;
 		memcpy(&req->submit, s, sizeof(*s));
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
-- 
1.8.3.1

