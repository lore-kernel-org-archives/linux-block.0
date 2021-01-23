Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5DBC433DB
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D6922EBE
	for <linux-block@archiver.kernel.org>; Sat, 23 Jan 2021 20:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbhAWULW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Jan 2021 15:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbhAWULT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Jan 2021 15:11:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C5C06174A;
        Sat, 23 Jan 2021 12:10:39 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611432635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvialIUza76ZQsVU543wsyBevXPATQcHABCWvzhOsa0=;
        b=WvSBCSb7AKFnNe0oNkxslbemJCZo+5Wn3G8cPxu2WQHbSkRcsMxQ7zXSEi+mrqAjE3e5bP
        sirdN98jEqRvdfI97P28vkHMaiwZzr1+ha3bVFW+7oRtJOwKfS5oDElKJf0u0+HfuRHb38
        ULM9Vc84IakrEMl0pwxTXqnFzUCALQl+Nxw4uCJc/jaYtgKg9M5SaxSevVzsVm1cWZ4cWq
        QKFbmRG9TRcxVHKCNxHyZuRS2fnLPuo4IMJENO1Ee3FDZpzBMxeMytVRql7ox+g1q11bld
        eTehjLw9gVnl0QAYMmbOpCj/xS1Z7vmjIVJGzLX4M55mO6/Yr8Nrnw4cRhTXng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611432635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvialIUza76ZQsVU543wsyBevXPATQcHABCWvzhOsa0=;
        b=n5lkVAuRVZqteTCZ7UWJtYsIMymG6Zjw0vi4qtRMTPqoCQw4OFzkFApI6HCVCWb74H2qAx
        cGgbT30Jxat9iyAg==
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] smp: Process pending softirqs in flush_smp_call_function_from_idle()
Date:   Sat, 23 Jan 2021 21:10:25 +0100
Message-Id: <20210123201027.3262800-2-bigeasy@linutronix.de>
In-Reply-To: <20210123201027.3262800-1-bigeasy@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

send_call_function_single_ipi() may wake an idle CPU without sending an
IPI. The woken up CPU will process the SMP-functions in
flush_smp_call_function_from_idle(). Any raised softirq from within the
SMP-function call will not be processed.
Should the CPU have no tasks assigned, then it will go back to idle with
pending softirqs and the NOHZ will rightfully complain.

Process pending softirqs on return from flush_smp_call_function_queue().

Fixes: b2a02fc43a1f4 ("smp: Optimize send_call_function_single_ipi()")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index 1b6070bf97bb0..aeb0adfa06063 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -14,6 +14,7 @@
 #include <linux/export.h>
 #include <linux/percpu.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
@@ -449,6 +450,9 @@ void flush_smp_call_function_from_idle(void)
=20
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
+	if (local_softirq_pending())
+		do_softirq();
+
 	local_irq_restore(flags);
 }
=20
--=20
2.30.0

