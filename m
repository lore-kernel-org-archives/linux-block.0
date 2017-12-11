Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:57258 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752234AbdLKDuw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Dec 2017 22:50:52 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@lge.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        oleg@redhat.com, tj@kernel.org
Subject: [PATCH] locking/lockdep: Add CONFIG_LOCKDEP_AGGRESSIVE
Date: Sun, 10 Dec 2017 22:50:17 -0500
Message-Id: <20171211035017.32678-1-tytso@mit.edu>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS can result
in a large number of false positives because lockdep doesn't
understand how to deal with multiple stacked loop or MD devices.

Until someone can figure out how to automatically add annotations to
all file system and storage devices --- hopefully without forcing
developers to insert a large number of calls to undocumented lockdep
macros into the the loop device, every single file system, and every
single device-mapper backend --- let's add an option to allow these
lockdep features to be disabled.  Otherwise, many file system
developers will disable LOCKDEP entirely since it results in far too
many false positives when trying to use xfstests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@lge.com
Cc: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: oleg@redhat.com
Cc: tj@kernel.org
---
 lib/Kconfig.debug | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 947d3e2ed5c2..acae7ba99c16 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1099,8 +1099,8 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
-	select LOCKDEP_CROSSRELEASE
-	select LOCKDEP_COMPLETIONS
+	select LOCKDEP_CROSSRELEASE if LOCKDEP_AGGRESSIVE
+	select LOCKDEP_COMPLETIONS if LOCKDEP_AGGRESSIVE
 	select TRACE_IRQFLAGS
 	default n
 	help
@@ -1137,6 +1137,16 @@ config PROVE_LOCKING
 
 	 For more details, see Documentation/locking/lockdep-design.txt.
 
+config LOCKDEP_AGGRESSIVE
+	bool "Lock debugging: use aggressive techniques"
+	default n
+	help
+	 This enables some extremely aggressive lockdep checking that
+	 may result in false positives.
+
+	 Say N here if you are planning on using xfstests and don't
+	 want to deal with many false positive test failures.
+
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.11.0.rc0.7.gbe5a750
