Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/3] cfq-iosched: Fix warning about unused dummy functions
Date: Fri, 26 May 2017 14:22:36 -0700
Message-Id: <20170526212237.103525-3-mka@chromium.org>
In-Reply-To: <20170526212237.103525-1-mka@chromium.org>
References: <20170526212237.103525-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

Only define dummies for cfqg_stats_set_start_group_wait_time()
and cfqg_stats_end_empty_time() when CONFIG_CFQ_GROUP_IOSCHED=y. This
fixes the following warnings when building with clang:

    block/cfq-iosched.c:589:20: error: unused function
        'cfqg_stats_set_start_group_wait_time' [-Werror,-Wunused-function]

    block/cfq-iosched.c:590:20: error: unused function
        'cfqg_stats_end_empty_time' [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 block/cfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 36ab3645effc..b23c73db4cc0 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -588,8 +588,10 @@ static void cfqg_stats_update_avg_queue_size(struct cfq_group *cfqg)
 
 #else	/* CONFIG_CFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
 static inline void cfqg_stats_set_start_group_wait_time(struct cfq_group *cfqg, struct cfq_group *curr_cfqg) { }
 static inline void cfqg_stats_end_empty_time(struct cfqg_stats *stats) { }
+#endif
 static inline void cfqg_stats_update_dequeue(struct cfq_group *cfqg) { }
 static inline void cfqg_stats_set_start_empty_time(struct cfq_group *cfqg) { }
 static inline void cfqg_stats_update_idle_time(struct cfq_group *cfqg) { }
-- 
2.13.0.219.gdb65acc882-goog
