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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CE2C433E7
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B3C221FA
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392509AbgFSPRi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392502AbgFSPRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 11:17:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05174C0613EF;
        Fri, 19 Jun 2020 08:17:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jmIlo-0007JW-Fn; Fri, 19 Jun 2020 17:17:32 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] block: remove retry loop in ioc_release_fn()
Date:   Fri, 19 Jun 2020 17:23:18 +0206
Message-Id: <20200619151718.22338-3-john.ogness@linutronix.de>
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

The reverse-order double lock dance in ioc_release_fn() is using a
retry loop. This is a problem on PREEMPT_RT because it could preempt
the task that would release q->queue_lock and thus live lock in the
retry loop.

RCU is already managing the freeing of the request queue and icq. If
the trylock fails, use RCU to guarantee that the request queue and
icq are not freed and re-acquire the locks in the correct order,
allowing forward progress.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 block/blk-ioc.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 5dbcfa1b872e..57299f860d41 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -107,9 +107,23 @@ static void ioc_release_fn(struct work_struct *work)
 			ioc_destroy_icq(icq);
 			spin_unlock(&q->queue_lock);
 		} else {
-			spin_unlock_irq(&ioc->lock);
-			cpu_relax();
-			spin_lock_irq(&ioc->lock);
+			/* Make sure q and icq cannot be freed. */
+			rcu_read_lock();
+
+			/* Re-acquire the locks in the correct order. */
+			spin_unlock(&ioc->lock);
+			spin_lock(&q->queue_lock);
+			spin_lock(&ioc->lock);
+
+			/*
+			 * The icq may have been destroyed when the ioc lock
+			 * was released.
+			 */
+			if (!(icq->flags & ICQ_DESTROYED))
+				ioc_destroy_icq(icq);
+
+			spin_unlock(&q->queue_lock);
+			rcu_read_unlock();
 		}
 	}
 
-- 
2.20.1

