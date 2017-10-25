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
Subject: [PATCH v5 2/9] locking/lockdep: Provide empty lockdep_map structure for !CONFIG_LOCKDEP
Date: Wed, 25 Oct 2017 17:55:58 +0900
Message-Id: <1508921765-15396-3-git-send-email-byungchul.park@lge.com>
In-Reply-To: <1508921765-15396-1-git-send-email-byungchul.park@lge.com>
References: <1508921765-15396-1-git-send-email-byungchul.park@lge.com>
List-ID: <linux-block@vger.kernel.org>

By this patch, the lockdep_map structure takes no space if lockdep is
disabled, making a debug facility's impact on unreleated kernel less.

Thanks to this, we don't need #ifdef to sparate code due to the
lockdep_map structure.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index bfa8e0b..b6662d0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -527,6 +527,11 @@ static inline void lockdep_on(void)
  */
 struct lock_class_key { };
 
+/*
+ * The lockdep_map takes no space if lockdep is disabled:
+ */
+struct lockdep_map { };
+
 #define lockdep_depth(tsk)	(0)
 
 #define lockdep_is_held_type(l, r)		(1)
-- 
1.9.1
