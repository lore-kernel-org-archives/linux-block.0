Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:37954 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdLLHLu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Dec 2017 02:11:50 -0500
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com
Subject: [PATCH] locking/lockdep: Make CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS optional
Date: Tue, 12 Dec 2017 16:11:21 +0900
Message-Id: <1513062681-5995-1-git-send-email-byungchul.park@lge.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At the moment, it's rather premature to enable
CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS by default,
because we face a lot of false positives for now since all locks and
waiters are not classified properly yet.

Until most of them get annotated properly, it'd be better to be optional.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 lib/Kconfig.debug | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2689b7c..bc099f1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1092,8 +1092,6 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
-	select LOCKDEP_CROSSRELEASE
-	select LOCKDEP_COMPLETIONS
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1164,7 +1162,9 @@ config LOCK_STAT
 	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
 
 config LOCKDEP_CROSSRELEASE
-	bool
+	bool "Lock debugging: enable cross-locking checks in lockdep"
+	depends on PROVE_LOCKING
+	default n
 	help
 	 This makes lockdep work for crosslock which is a lock allowed to
 	 be released in a different context from the acquisition context.
@@ -1174,7 +1174,10 @@ config LOCKDEP_CROSSRELEASE
 	 detector, lockdep.
 
 config LOCKDEP_COMPLETIONS
-	bool
+	bool "Lock debugging: allow completions to use deadlock detector"
+	depends on PROVE_LOCKING
+	select LOCKDEP_CROSSRELEASE
+	default n
 	help
 	 A deadlock caused by wait_for_completion() and complete() can be
 	 detected by lockdep using crossrelease feature.
-- 
1.9.1
