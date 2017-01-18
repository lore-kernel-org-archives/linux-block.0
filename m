Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36478 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbdART4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 14:56:50 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so6665003pfu.3
        for <linux-block@vger.kernel.org>; Wed, 18 Jan 2017 11:55:52 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>, kernel-team@fb.com
Subject: [PATCH 1/2] sbitmap: use smp_mb__after_atomic() in sbq_wake_up()
Date: Wed, 18 Jan 2017 11:55:21 -0800
Message-Id: <b8c8740615f38f36e3a5f726f97903ca2af9f549.1484769083.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We always do an atomic clear_bit() right before we call sbq_wake_up(),
so we can use smp_mb__after_atomic(). While we're here, comment the
memory barriers in here a little more.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 lib/sbitmap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2cecf05c82fd..df4e472df8a3 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -299,8 +299,14 @@ static void sbq_wake_up(struct sbitmap_queue *sbq)
 	struct sbq_wait_state *ws;
 	int wait_cnt;
 
-	/* Ensure that the wait list checks occur after clear_bit(). */
-	smp_mb();
+	/*
+	 * Pairs with the memory barrier in set_current_state() to ensure the
+	 * proper ordering of clear_bit()/waitqueue_active() in the waker and
+	 * test_and_set_bit()/prepare_to_wait()/finish_wait() in the waiter. See
+	 * the comment on waitqueue_active(). This is __after_atomic because we
+	 * just did clear_bit() in the caller.
+	 */
+	smp_mb__after_atomic();
 
 	ws = sbq_wake_ptr(sbq);
 	if (!ws)
@@ -331,7 +337,8 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq)
 	int i, wake_index;
 
 	/*
-	 * Make sure all changes prior to this are visible from other CPUs.
+	 * Pairs with the memory barrier in set_current_state() like in
+	 * sbq_wake_up().
 	 */
 	smp_mb();
 	wake_index = atomic_read(&sbq->wake_index);
-- 
2.11.0

