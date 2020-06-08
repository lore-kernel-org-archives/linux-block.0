Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422C8C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 00:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADE120810
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 00:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgFHA6q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFHA6p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Jun 2020 20:58:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12767C08C5C3;
        Sun,  7 Jun 2020 17:58:45 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1ji67b-0000x8-F9; Mon, 08 Jun 2020 02:58:39 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v2 14/18] iocost: Use sequence counter with associated spinlock
Date:   Mon,  8 Jun 2020 02:57:25 +0200
Message-Id: <20200608005729.1874024-15-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608005729.1874024-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200608005729.1874024-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 block/blk-iocost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 7c1fe605d0d6..8029a9e8fa55 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -405,7 +405,7 @@ struct ioc {
 	enum ioc_running		running;
 	atomic64_t			vtime_rate;
 
-	seqcount_t			period_seqcount;
+	seqcount_spinlock_t		period_seqcount;
 	u32				period_at;	/* wallclock starttime */
 	u64				period_at_vtime; /* vtime starttime */
 
@@ -872,7 +872,6 @@ static void ioc_now(struct ioc *ioc, struct ioc_now *now)
 
 static void ioc_start_period(struct ioc *ioc, struct ioc_now *now)
 {
-	lockdep_assert_held(&ioc->lock);
 	WARN_ON_ONCE(ioc->running != IOC_RUNNING);
 
 	write_seqcount_begin(&ioc->period_seqcount);
@@ -1958,7 +1957,7 @@ static int blk_iocost_init(struct request_queue *q)
 
 	ioc->running = IOC_IDLE;
 	atomic64_set(&ioc->vtime_rate, VTIME_PER_USEC);
-	seqcount_init(&ioc->period_seqcount);
+	seqcount_spinlock_init(&ioc->period_seqcount, &ioc->lock);
 	ioc->period_at = ktime_to_us(ktime_get());
 	atomic64_set(&ioc->cur_period, 0);
 	atomic_set(&ioc->hweight_gen, 0);
-- 
2.20.1

