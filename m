Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E026CA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18A21872
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="esOf3FYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfJXJSs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 05:18:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47590 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJXJSs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 05:18:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9EGh1102762;
        Thu, 24 Oct 2019 09:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=RFiYoL3woTaimItrxpUSKEnlZ5kBNxOQ9Ts7gUiqZZo=;
 b=esOf3FYtgPo/WsVMt7Z162TmfzC5x59DRZTazv+d6TpyVztMoDj1k5aHh+becjOUOtrJ
 wTRpd9+62bm/BQpBiXPCVtvIy2HUlHUMseKOMZo19fpVg1dzmKYzM+iSlMQI7o7TcA3/
 rHDWL36adsqo3T9Jx0Is3Wop9fXELNLvu51xBQ0r3XcJoW8nmGESO/0Jh4wPrVuvaiKg
 8zGpl5rjML9gTCiS8NeaoKQ3w85m7ldfGzG/MpnP9epuFJLOWijM/gvExHtnodhbDF/s
 fl2OjdLMepFNKGfzkRvV4qaXHYknqTftx5N9nMp+uMOWOvdSdtMpaS8+PoJpS83aDJ/Z nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4r25wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O9Ie1C001513;
        Thu, 24 Oct 2019 09:18:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vtsk48mxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 09:18:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9IOVD028402;
        Thu, 24 Oct 2019 09:18:24 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 02:18:24 -0700
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [RFC 1/2] io_uring: create io_queue_async() function
Date:   Thu, 24 Oct 2019 02:18:07 -0700
Message-Id: <1571908688-22488-2-git-send-email-bijan.mottahedeh@oracle.com>
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
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240090
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch pulls out the code from __io_queue_sqe() and creates a new
io_queue_async() function.  It doesn't change run time, but it's a bit
cleaner and will be used in future patches.

Signed-off-by: <bijan.mottahedeh@oracle.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5415fcc..acb213c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -362,6 +362,8 @@ struct io_submit_state {
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
+static int io_queue_async(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			  struct sqe_submit *s);
 
 static struct kmem_cache *req_cachep;
 
@@ -2437,6 +2439,35 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 	return 0;
 }
 
+static int io_queue_async(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			  struct sqe_submit *s)
+{
+	struct io_uring_sqe *sqe_copy;
+	struct async_list *list;
+
+	/* async context always use a copy of the sqe */
+	sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
+	if (!sqe_copy)
+		return -ENOMEM;
+
+	s->sqe = sqe_copy;
+
+	memcpy(&req->submit, s, sizeof(*s));
+	list = io_async_list_from_sqe(ctx, s->sqe);
+	if (!io_add_to_prev_work(list, req)) {
+		if (list)
+			atomic_inc(&list->cnt);
+		INIT_WORK(&req->work, io_sq_wq_submit_work);
+		io_queue_async_work(ctx, req);
+	}
+
+	/*
+	 * Queued up for async execution, worker will release
+	 * submit reference when the iocb is actually submitted.
+	 */
+	return 0;
+}
+
 static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			struct sqe_submit *s, bool force_nonblock)
 {
@@ -2448,30 +2479,10 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	 * We async punt it if the file wasn't marked NOWAIT, or if the file
 	 * doesn't support non-blocking read/write attempts
 	 */
-	if (ret == -EAGAIN && (!(req->flags & REQ_F_NOWAIT) ||
-	    (req->flags & REQ_F_MUST_PUNT))) {
-		struct io_uring_sqe *sqe_copy;
-
-		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
-		if (sqe_copy) {
-			struct async_list *list;
-
-			s->sqe = sqe_copy;
-			memcpy(&req->submit, s, sizeof(*s));
-			list = io_async_list_from_sqe(ctx, s->sqe);
-			if (!io_add_to_prev_work(list, req)) {
-				if (list)
-					atomic_inc(&list->cnt);
-				INIT_WORK(&req->work, io_sq_wq_submit_work);
-				io_queue_async_work(ctx, req);
-			}
-
-			/*
-			 * Queued up for async execution, worker will release
-			 * submit reference when the iocb is actually submitted.
-			 */
-			return 0;
-		}
+	if (ret == -EAGAIN &&
+	    (!(req->flags & REQ_F_NOWAIT) || (req->flags & REQ_F_MUST_PUNT)) &&
+	    !io_queue_async(ctx, req, s)) {
+		return 0;
 	}
 
 	/* drop submission reference */
-- 
1.8.3.1

