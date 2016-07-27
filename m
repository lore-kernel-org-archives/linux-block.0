Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH RFC V8 08/22] block, cfq: get rid of latency tunables
Date: Wed, 27 Jul 2016 18:13:24 +0200
Message-Id: <1469636018-31247-9-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
References: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
 <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

BFQ guarantees a low latency for interactive applications in a
completely different way with respect to CFQ. On the other hand, in
terms of interface and exactly as CFQ does, BFQ exports a boolean
low_latency tunable to switch low-latency heuristics on (in BFQ, these
heuristics lowers latency for interactive and soft real-time
applications). Finally, differently from CFQ, BFQ has not other
latency tunable.

Accordingly, this commit temporarily turns all latency tunables into
fake tunables, by turning the functions for reading and writing these
tunables into functions that just generate warnings. The commit
introducing low-latency heuristics in BFQ then restores only the
boolean low_latency tunable.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index df8fb826..47e23e5 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -30,7 +30,6 @@ static const int cfq_slice_sync = HZ / 10;
 static int cfq_slice_async = HZ / 25;
 static const int cfq_slice_async_rq = 2;
 static int cfq_slice_idle = HZ / 125;
-static const int cfq_target_latency = HZ * 3/10; /* 300 ms */
 static const int cfq_hist_divisor = 4;
 
 /*
@@ -227,8 +226,6 @@ struct cfq_data {
 	unsigned int cfq_slice[2];
 	unsigned int cfq_slice_async_rq;
 	unsigned int cfq_slice_idle;
-	unsigned int cfq_latency;
-	unsigned int cfq_target_latency;
 
 	/*
 	 * Fallback dummy cfqq for extreme OOM conditions
@@ -1463,7 +1460,7 @@ static bool cfq_may_dispatch(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	 * We also ramp up the dispatch depth gradually for async IO,
 	 * based on the last sync IO we serviced
 	 */
-	if (!cfq_cfqq_sync(cfqq) && cfqd->cfq_latency) {
+	if (!cfq_cfqq_sync(cfqq)) {
 		unsigned long last_sync = jiffies - cfqd->last_delayed_sync;
 		unsigned int depth;
 
@@ -2269,10 +2266,8 @@ static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	cfqd->cfq_back_penalty = cfq_back_penalty;
 	cfqd->cfq_slice[0] = cfq_slice_async;
 	cfqd->cfq_slice[1] = cfq_slice_sync;
-	cfqd->cfq_target_latency = cfq_target_latency;
 	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
 	cfqd->cfq_slice_idle = cfq_slice_idle;
-	cfqd->cfq_latency = 1;
 	cfqd->hw_tag = -1;
 	/*
 	 * we optimistically start assuming sync ops weren't delayed in last
@@ -2330,8 +2325,6 @@ SHOW_FUNCTION(cfq_slice_idle_show, cfqd->cfq_slice_idle, 1);
 SHOW_FUNCTION(cfq_slice_sync_show, cfqd->cfq_slice[1], 1);
 SHOW_FUNCTION(cfq_slice_async_show, cfqd->cfq_slice[0], 1);
 SHOW_FUNCTION(cfq_slice_async_rq_show, cfqd->cfq_slice_async_rq, 0);
-SHOW_FUNCTION(cfq_low_latency_show, cfqd->cfq_latency, 0);
-SHOW_FUNCTION(cfq_target_latency_show, cfqd->cfq_target_latency, 1);
 #undef SHOW_FUNCTION
 
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
@@ -2363,13 +2356,27 @@ STORE_FUNCTION(cfq_slice_sync_store, &cfqd->cfq_slice[1], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_store, &cfqd->cfq_slice[0], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_rq_store, &cfqd->cfq_slice_async_rq, 1,
 		UINT_MAX, 0);
-STORE_FUNCTION(cfq_low_latency_store, &cfqd->cfq_latency, 0, 1, 0);
-STORE_FUNCTION(cfq_target_latency_store, &cfqd->cfq_target_latency, 1, UINT_MAX, 1);
 #undef STORE_FUNCTION
 
+static ssize_t cfq_fake_lat_show(struct elevator_queue *e, char *page)
+{
+	pr_warn_once("CFQ I/O SCHED: tried to read removed latency tunable");
+	return sprintf(page, "0\n");
+}
+
+static ssize_t
+cfq_fake_lat_store(struct elevator_queue *e, const char *page, size_t count)
+{
+	pr_warn_once("CFQ I/O SCHED: tried to write removed latency tunable");
+	return count;
+}
+
 #define CFQ_ATTR(name) \
 	__ATTR(name, S_IRUGO|S_IWUSR, cfq_##name##_show, cfq_##name##_store)
 
+#define CFQ_FAKE_LAT_ATTR(name) \
+	__ATTR(name, S_IRUGO|S_IWUSR, cfq_fake_lat_show, cfq_fake_lat_store)
+
 static struct elv_fs_entry cfq_attrs[] = {
 	CFQ_ATTR(quantum),
 	CFQ_ATTR(fifo_expire_sync),
@@ -2380,8 +2387,8 @@ static struct elv_fs_entry cfq_attrs[] = {
 	CFQ_ATTR(slice_async),
 	CFQ_ATTR(slice_async_rq),
 	CFQ_ATTR(slice_idle),
-	CFQ_ATTR(low_latency),
-	CFQ_ATTR(target_latency),
+	CFQ_FAKE_LAT_ATTR(low_latency),
+	CFQ_FAKE_LAT_ATTR(target_latency),
 	__ATTR_NULL
 };
 
-- 
1.9.1
