Return-Path: <SRS0=5kok=TX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D8C282CE
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 02:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40A12173C
	for <linux-block@archiver.kernel.org>; Thu, 23 May 2019 02:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfEWCAd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 22:00:33 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:46454 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfEWCAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 22:00:33 -0400
X-QQ-mid: bizesmtp7t1558576828tg86gbhzk
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 23 May 2019 10:00:24 +0800 (CST)
X-QQ-SSF: 01400000000000Q0VN60
X-QQ-FEAT: mJep2VbaKxYl4BTctPrS0KuqaCYlz6IBikPeLA10ZNOR9dkK291Vl/WrmUe5N
        1IH5Aezz7ge5osLvO/xaOJfWyzgJZVYU1QT9IPE+SeenVBjbrZvuwAO9sd+mDviv7/NA57i
        NbsfRH0+/dwb8cBM6a6BnC49sJeEd+fKDvJeyo4FEP/jqk3+K4768iSzI0HFiaY4u2bYWZk
        wllvoP5tuy4q18M25as2yYzgr+2zcujmW25oHrhhsV61k3YheVbvTPJWThOjAyOt+DRBVKL
        WDmPguFAU5boaz3zibJmlC6C5NfZeC7Lvq0klZONtJYSUIla+0CZa35CYl0Bf49iJ5NV4rl
        qmlcso8
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH 3/3] io_uring: adjust the code logic when an error occurs
Date:   Thu, 23 May 2019 09:59:47 +0800
Message-Id: <1558576787-18310-3-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
References: <1558576787-18310-1-git-send-email-liuyun01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can quickly reclaim memory and resources immediately
when error happened, without having to go through longer logic.

In case of create uring, there is no data generated at this
time, no need to reap events and polling data, it's more
efficient to directly recycle the memory.

In addition, it will make the code easy to understand.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 fs/io_uring.c | 96 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3bbd202..035d729 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -361,6 +361,7 @@ struct io_submit_state {
 };
 
 static void io_sq_wq_submit_work(struct work_struct *work);
+static void io_free_scq_urings(struct io_ring_ctx *ctx);
 
 static struct kmem_cache *req_cachep;
 
@@ -417,6 +418,12 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	return ctx;
 }
 
+static void io_ring_ctx_free(struct io_ring_ctx *ctx)
+{
+	percpu_ref_exit(&ctx->refs);
+	kfree(ctx);
+}
+
 static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
 				     struct io_kiocb *req)
 {
@@ -2254,16 +2261,20 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 	}
 }
 
-static void io_finish_async(struct io_ring_ctx *ctx)
+static void io_sq_wq_destroy(struct io_ring_ctx *ctx)
 {
-	io_sq_thread_stop(ctx);
-
 	if (ctx->sqo_wq) {
 		destroy_workqueue(ctx->sqo_wq);
 		ctx->sqo_wq = NULL;
 	}
 }
 
+static void io_finish_async(struct io_ring_ctx *ctx)
+{
+	io_sq_thread_stop(ctx);
+	io_sq_wq_destroy(ctx);
+}
+
 #if defined(CONFIG_UNIX)
 static void io_destruct_skb(struct sk_buff *skb)
 {
@@ -2483,6 +2494,18 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 	return ret;
 }
 
+static void io_sq_offload_end(struct io_ring_ctx *ctx)
+{
+	io_sq_thread_stop(ctx);
+
+	if (ctx->sqo_mm) {
+		mmdrop(ctx->sqo_mm);
+		ctx->sqo_mm = NULL;
+	}
+
+	io_sq_wq_destroy(ctx);
+}
+
 static void io_unaccount_mem(struct user_struct *user, unsigned long nr_pages)
 {
 	atomic_long_sub(nr_pages, &user->locked_vm);
@@ -2765,33 +2788,6 @@ static int io_eventfd_unregister(struct io_ring_ctx *ctx)
 	return -ENXIO;
 }
 
-static void io_ring_ctx_free(struct io_ring_ctx *ctx)
-{
-	io_finish_async(ctx);
-	if (ctx->sqo_mm)
-		mmdrop(ctx->sqo_mm);
-
-	io_sqe_buffer_unregister(ctx);
-	io_sqe_files_unregister(ctx);
-	io_eventfd_unregister(ctx);
-
-#if defined(CONFIG_UNIX)
-	if (ctx->ring_sock)
-		sock_release(ctx->ring_sock);
-#endif
-
-	io_mem_free(ctx->sq_ring);
-	io_mem_free(ctx->sq_sqes);
-	io_mem_free(ctx->cq_ring);
-
-	percpu_ref_exit(&ctx->refs);
-	if (ctx->account_mem)
-		io_unaccount_mem(ctx->user,
-				ring_pages(ctx->sq_entries, ctx->cq_entries));
-	free_uid(ctx->user);
-	kfree(ctx);
-}
-
 static __poll_t io_uring_poll(struct file *file, poll_table *wait)
 {
 	struct io_ring_ctx *ctx = file->private_data;
@@ -2825,9 +2821,27 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
 
+	/* poll all events and reap */
 	io_poll_remove_all(ctx);
 	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
+
+	io_sq_offload_end(ctx);
+
+	/* unregister fixed buffer and files */
+	io_sqe_buffer_unregister(ctx);
+	io_sqe_files_unregister(ctx);
+	io_eventfd_unregister(ctx);
+
+#if defined(CONFIG_UNIX)
+	if (ctx->ring_sock)
+		sock_release(ctx->ring_sock);
+#endif
+	io_free_scq_urings(ctx);
+	if (ctx->account_mem)
+		io_unaccount_mem(ctx->user,
+				 ring_pages(ctx->sq_entries, ctx->cq_entries));
+	free_uid(ctx->user);
 	io_ring_ctx_free(ctx);
 }
 
@@ -2994,6 +3008,13 @@ static int io_allocate_scq_urings(struct io_ring_ctx *ctx,
 	return ret;
 }
 
+static void io_free_scq_urings(struct io_ring_ctx *ctx)
+{
+	io_mem_free(ctx->sq_ring);
+	io_mem_free(ctx->sq_sqes);
+	io_mem_free(ctx->cq_ring);
+}
+
 /*
  * Allocate an anonymous fd, this is what constitutes the application
  * visible backing of an io_uring instance. The application mmaps this
@@ -3083,11 +3104,11 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 
 	ret = io_allocate_scq_urings(ctx, p);
 	if (ret)
-		goto err;
+		goto err_scq;
 
 	ret = io_sq_offload_start(ctx, p);
 	if (ret)
-		goto err;
+		goto err_off;
 
 	ret = io_uring_get_fd(ctx);
 	if (ret < 0)
@@ -3110,8 +3131,17 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	p->cq_off.overflow = offsetof(struct io_cq_ring, overflow);
 	p->cq_off.cqes = offsetof(struct io_cq_ring, cqes);
 	return ret;
+
 err:
-	io_ring_ctx_wait_and_kill(ctx);
+	io_sq_offload_end(ctx);
+err_off:
+	io_free_scq_urings(ctx);
+err_scq:
+	free_uid(user);
+	if (account_mem)
+		io_unaccount_mem(user, ring_pages(p->sq_entries,
+							p->cq_entries));
+	io_ring_ctx_free(ctx);
 	return ret;
 }
 
-- 
2.7.4



