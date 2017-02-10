Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36256 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752133AbdBJSk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 13:40:26 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so11067501pfu.3
        for <linux-block@vger.kernel.org>; Fri, 10 Feb 2017 10:40:06 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Paolo Valente <paolo.valente@linaro.org>, kernel-team@fb.com
Subject: [PATCH] blk-mq-sched: don't hold queue_lock when calling exit_icq
Date: Fri, 10 Feb 2017 10:32:34 -0800
Message-Id: <73cd0cf484e8b75a771d908c172cd3a931dc00a3.1486751329.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

None of the other blk-mq elevator hooks are called with this lock held.
Additionally, it can lead to circular locking dependencies between
queue_lock and the private scheduler lock.

Reported-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-ioc.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index fe186a9eade9..b12f9c87b4c3 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -35,7 +35,10 @@ static void icq_free_icq_rcu(struct rcu_head *head)
 	kmem_cache_free(icq->__rcu_icq_cache, icq);
 }
 
-/* Exit an icq. Called with both ioc and q locked. */
+/*
+ * Exit an icq. Called with both ioc and q locked for sq, only ioc locked for
+ * mq.
+ */
 static void ioc_exit_icq(struct io_cq *icq)
 {
 	struct elevator_type *et = icq->q->elevator->type;
@@ -166,6 +169,7 @@ EXPORT_SYMBOL(put_io_context);
  */
 void put_io_context_active(struct io_context *ioc)
 {
+	struct elevator_type *et;
 	unsigned long flags;
 	struct io_cq *icq;
 
@@ -184,13 +188,19 @@ void put_io_context_active(struct io_context *ioc)
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
-		if (spin_trylock(icq->q->queue_lock)) {
+
+		et = icq->q->elevator->type;
+		if (et->uses_mq) {
 			ioc_exit_icq(icq);
-			spin_unlock(icq->q->queue_lock);
 		} else {
-			spin_unlock_irqrestore(&ioc->lock, flags);
-			cpu_relax();
-			goto retry;
+			if (spin_trylock(icq->q->queue_lock)) {
+				ioc_exit_icq(icq);
+				spin_unlock(icq->q->queue_lock);
+			} else {
+				spin_unlock_irqrestore(&ioc->lock, flags);
+				cpu_relax();
+				goto retry;
+			}
 		}
 	}
 	spin_unlock_irqrestore(&ioc->lock, flags);
-- 
2.11.1
