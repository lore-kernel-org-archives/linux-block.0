Return-Path: <SRS0=xoF3=VK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F0FC742A7
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 04:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B78217D4
	for <linux-block@archiver.kernel.org>; Sat, 13 Jul 2019 04:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfGMEzf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Jul 2019 00:55:35 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:37147 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfGMEzf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 00:55:35 -0400
X-QQ-mid: bizesmtp29t1562993729tihfd2ck
Received: from localhost.localdomain (unknown [113.240.168.78])
        by esmtp10.qq.com (ESMTP) with 
        id ; Sat, 13 Jul 2019 12:54:55 +0800 (CST)
X-QQ-SSF: 01400000002000H0ZG31000A0000000
X-QQ-FEAT: OZolv6ISmR8qCm/mxIqdlafCh5LSh31lYdNBe8/GBg7KEGcr0eIPTtlovptFA
        zWy+yob5FbxVLj4SG2xchlHsyC4vGaXdLUd1K/uiVeYuEDRhznfoZunuU7iJVmKyotTYY7D
        qUuW1YHF0WNzoVakCtZFFVmGNTFoe8kwSgIbTrYiJKa7e/PXD9vQbBn9Qo+8NJ0zkEvQ8KD
        27b77NldjNlbYguQ2sEsSD4PiiXxEOORQcGjkqBU0wcJK7SQKv2RBOTSZQzRV1MIain/NBJ
        wYjoklTwi2/VlyonqKjbLV0dk69HjArjKrzPFQgAX5R645x6Sesu93OyD2xvrVQgm2JGJEW
        MXAeH5D
X-QQ-GoodBg: 2
From:   Zhengyuan Liu <liuzhengyuan@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] io_uring: use kmem_cache to alloc sqe
Date:   Sat, 13 Jul 2019 12:54:54 +0800
Message-Id: <20190713045454.2929-1-liuzhengyuan@kylinos.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As we introduced three lists(async, defer, link), there could been
many sqe allocation. A natural idea is using kmem_cache to satisfy
the allocation just like io_kiocb does.

Signed-off-by: Zhengyuan Liu <liuzhengyuan@kylinos.cn>
---
 fs/io_uring.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 392cbf777f25..c325193a20bd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -368,6 +368,7 @@ struct io_submit_state {
 static void io_sq_wq_submit_work(struct work_struct *work);
 
 static struct kmem_cache *req_cachep;
+static struct kmem_cache *sqe_cachep;
 
 static const struct file_operations io_uring_fops;
 
@@ -1673,14 +1674,14 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list))
 		return 0;
 
-	sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+	sqe_copy = kmem_cache_alloc(sqe_cachep, GFP_KERNEL | __GFP_NOWARN);
 	if (!sqe_copy)
 		return -EAGAIN;
 
 	spin_lock_irq(&ctx->completion_lock);
 	if (!io_sequence_defer(ctx, req) && list_empty(&ctx->defer_list)) {
 		spin_unlock_irq(&ctx->completion_lock);
-		kfree(sqe_copy);
+		kmem_cache_free(sqe_cachep, req);
 		return 0;
 	}
 
@@ -1845,7 +1846,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		}
 
 		/* async context always use a copy of the sqe */
-		kfree(sqe);
+		kmem_cache_free(sqe_cachep, (void *)sqe);
 
 		/* req from defer and link list needn't dec async_list->cnt */
 		if (req->flags & (REQ_F_IO_DRAINED | REQ_F_LINKED))
@@ -1991,7 +1992,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {
 		struct io_uring_sqe *sqe_copy;
 
-		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmem_cache_alloc(sqe_cachep, GFP_KERNEL | __GFP_NOWARN);
 		if (sqe_copy) {
 			struct async_list *list;
 
@@ -2076,12 +2077,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 	if (*link) {
 		struct io_kiocb *prev = *link;
 
-		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
+		sqe_copy = kmem_cache_alloc(sqe_cachep, GFP_KERNEL | __GFP_NOWARN);
 		if (!sqe_copy) {
 			ret = -EAGAIN;
 			goto err_req;
 		}
 
+		memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
 		s->sqe = sqe_copy;
 		memcpy(&req->submit, s, sizeof(*s));
 		list_add_tail(&req->list, &prev->link_list);
@@ -3470,6 +3472,7 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
 static int __init io_uring_init(void)
 {
 	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	sqe_cachep = KMEM_CACHE(io_uring_sqe, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
 	return 0;
 };
 __initcall(io_uring_init);
-- 
2.19.1



