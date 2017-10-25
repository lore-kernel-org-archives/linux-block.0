Return-Path: <byungchul.park@lge.com>
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org,
	mingo@kernel.org,
	axboe@kernel.dk
Cc: johan@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tj@kernel.org,
	johannes.berg@intel.com,
	oleg@redhat.com,
	amir73il@gmail.com,
	david@fromorbit.com,
	darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	hch@infradead.org,
	idryomov@gmail.com,
	kernel-team@lge.com
Subject: [PATCH v4 3/7] locking/lockdep: Remove the BROKEN flag from CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS
Date: Wed, 25 Oct 2017 14:11:08 +0900
Message-Id: <1508908272-15757-4-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1508908272-15757-1-git-send-email-byungchul.park@lge.com>
References: <1508908272-15757-1-git-send-email-byungchul.park@lge.com>
List-ID: <linux-block@vger.kernel.org>

Now that the performance regression is fixed, re-enable
CONFIG_LOCKDEP_CROSSRELEASE=y and CONFIG_LOCKDEP_COMPLETIONS=y.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3db9167..4bef610 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1138,8 +1138,8 @@ config PROVE_LOCKING
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
-	select LOCKDEP_CROSSRELEASE if BROKEN
-	select LOCKDEP_COMPLETIONS if BROKEN
+	select LOCKDEP_CROSSRELEASE
+	select LOCKDEP_COMPLETIONS
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
1.9.1
