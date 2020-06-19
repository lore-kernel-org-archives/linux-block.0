Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D19C433E0
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63436217D9
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbgFSPTH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392503AbgFSPRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC33C0613F0;
        Fri, 19 Jun 2020 08:17:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jmIln-0007JW-Up; Fri, 19 Jun 2020 17:17:32 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] block: remove unnecessary ioc nested locking
Date:   Fri, 19 Jun 2020 17:23:17 +0206
Message-Id: <20200619151718.22338-2-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200619151718.22338-1-john.ogness@linutronix.de>
References: <20200619151718.22338-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The legacy CFQ IO scheduler could call put_io_context() in its exit_icq()
elevator callback. This led to a lockdep warning, which was fixed in
commit d8c66c5d5924 ("block: fix lockdep warning on io_context release
put_io_context()") by using a nested subclass for the ioc spinlock.
However, with commit f382fb0bcef4 ("block: remove legacy IO schedulers")
the CFQ IO scheduler no longer exists.

The BFQ IO scheduler also implements the exit_icq() elevator callback but
does not call put_io_context().

The nested subclass for the ioc spinlock is no longer needed. Since it
existed as an exception and no longer applies, remove the nested subclass
usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 block/blk-ioc.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 9df50fb507ca..5dbcfa1b872e 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -96,15 +96,7 @@ static void ioc_release_fn(struct work_struct *work)
 {
 	struct io_context *ioc = container_of(work, struct io_context,
 					      release_work);
-	unsigned long flags;
-
-	/*
-	 * Exiting icq may call into put_io_context() through elevator
-	 * which will trigger lockdep warning.  The ioc's are guaranteed to
-	 * be different, use a different locking subclass here.  Use
-	 * irqsave variant as there's no spin_lock_irq_nested().
-	 */
-	spin_lock_irqsave_nested(&ioc->lock, flags, 1);
+	spin_lock_irq(&ioc->lock);
 
 	while (!hlist_empty(&ioc->icq_list)) {
 		struct io_cq *icq = hlist_entry(ioc->icq_list.first,
@@ -115,13 +107,13 @@ static void ioc_release_fn(struct work_struct *work)
 			ioc_destroy_icq(icq);
 			spin_unlock(&q->queue_lock);
 		} else {
-			spin_unlock_irqrestore(&ioc->lock, flags);
+			spin_unlock_irq(&ioc->lock);
 			cpu_relax();
-			spin_lock_irqsave_nested(&ioc->lock, flags, 1);
+			spin_lock_irq(&ioc->lock);
 		}
 	}
 
-	spin_unlock_irqrestore(&ioc->lock, flags);
+	spin_unlock_irq(&ioc->lock);
 
 	kmem_cache_free(iocontext_cachep, ioc);
 }
@@ -170,7 +162,6 @@ void put_io_context(struct io_context *ioc)
  */
 void put_io_context_active(struct io_context *ioc)
 {
-	unsigned long flags;
 	struct io_cq *icq;
 
 	if (!atomic_dec_and_test(&ioc->active_ref)) {
@@ -178,19 +169,14 @@ void put_io_context_active(struct io_context *ioc)
 		return;
 	}
 
-	/*
-	 * Need ioc lock to walk icq_list and q lock to exit icq.  Perform
-	 * reverse double locking.  Read comment in ioc_release_fn() for
-	 * explanation on the nested locking annotation.
-	 */
-	spin_lock_irqsave_nested(&ioc->lock, flags, 1);
+	spin_lock_irq(&ioc->lock);
 	hlist_for_each_entry(icq, &ioc->icq_list, ioc_node) {
 		if (icq->flags & ICQ_EXITED)
 			continue;
 
 		ioc_exit_icq(icq);
 	}
-	spin_unlock_irqrestore(&ioc->lock, flags);
+	spin_unlock_irq(&ioc->lock);
 
 	put_io_context(ioc);
 }
-- 
2.20.1

