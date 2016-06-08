Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] cfq-iosched: Expose microsecond interfaces
Date: Wed,  8 Jun 2016 15:11:38 +0200
Message-Id: <1465391499-27867-3-git-send-email-jack@suse.cz>
In-Reply-To: <1465391499-27867-1-git-send-email-jack@suse.cz>
References: <1465391499-27867-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

From: Jeff Moyer <jmoyer@redhat.com>

Expose interfaces to tune time slices of CFQ IO scheduler in
microseconds.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/cfq-iosched.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 228ff138a66b..afba86813f2a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -4681,6 +4681,21 @@ SHOW_FUNCTION(cfq_low_latency_show, cfqd->cfq_latency, 0);
 SHOW_FUNCTION(cfq_target_latency_show, cfqd->cfq_target_latency, 1);
 #undef SHOW_FUNCTION
 
+#define USEC_SHOW_FUNCTION(__FUNC, __VAR)				\
+static ssize_t __FUNC(struct elevator_queue *e, char *page)		\
+{									\
+	struct cfq_data *cfqd = e->elevator_data;			\
+	u64 __data = __VAR;						\
+	__data = div_u64(__data, NSEC_PER_USEC);			\
+	return cfq_var_show(__data, (page));				\
+}
+USEC_SHOW_FUNCTION(cfq_slice_idle_us_show, cfqd->cfq_slice_idle);
+USEC_SHOW_FUNCTION(cfq_group_idle_us_show, cfqd->cfq_group_idle);
+USEC_SHOW_FUNCTION(cfq_slice_sync_us_show, cfqd->cfq_slice[1]);
+USEC_SHOW_FUNCTION(cfq_slice_async_us_show, cfqd->cfq_slice[0]);
+USEC_SHOW_FUNCTION(cfq_target_latency_us_show, cfqd->cfq_target_latency);
+#undef USEC_SHOW_FUNCTION
+
 #define STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, __CONV)			\
 static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
 {									\
@@ -4715,6 +4730,26 @@ STORE_FUNCTION(cfq_low_latency_store, &cfqd->cfq_latency, 0, 1, 0);
 STORE_FUNCTION(cfq_target_latency_store, &cfqd->cfq_target_latency, 1, UINT_MAX, 1);
 #undef STORE_FUNCTION
 
+#define USEC_STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)			\
+static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)	\
+{									\
+	struct cfq_data *cfqd = e->elevator_data;			\
+	unsigned int __data;						\
+	int ret = cfq_var_store(&__data, (page), count);		\
+	if (__data < (MIN))						\
+		__data = (MIN);						\
+	else if (__data > (MAX))					\
+		__data = (MAX);						\
+	*(__PTR) = (u64)__data * NSEC_PER_USEC;				\
+	return ret;							\
+}
+USEC_STORE_FUNCTION(cfq_slice_idle_us_store, &cfqd->cfq_slice_idle, 0, UINT_MAX);
+USEC_STORE_FUNCTION(cfq_group_idle_us_store, &cfqd->cfq_group_idle, 0, UINT_MAX);
+USEC_STORE_FUNCTION(cfq_slice_sync_us_store, &cfqd->cfq_slice[1], 1, UINT_MAX);
+USEC_STORE_FUNCTION(cfq_slice_async_us_store, &cfqd->cfq_slice[0], 1, UINT_MAX);
+USEC_STORE_FUNCTION(cfq_target_latency_us_store, &cfqd->cfq_target_latency, 1, UINT_MAX);
+#undef USEC_STORE_FUNCTION
+
 #define CFQ_ATTR(name) \
 	__ATTR(name, S_IRUGO|S_IWUSR, cfq_##name##_show, cfq_##name##_store)
 
@@ -4725,12 +4760,17 @@ static struct elv_fs_entry cfq_attrs[] = {
 	CFQ_ATTR(back_seek_max),
 	CFQ_ATTR(back_seek_penalty),
 	CFQ_ATTR(slice_sync),
+	CFQ_ATTR(slice_sync_us),
 	CFQ_ATTR(slice_async),
+	CFQ_ATTR(slice_async_us),
 	CFQ_ATTR(slice_async_rq),
 	CFQ_ATTR(slice_idle),
+	CFQ_ATTR(slice_idle_us),
 	CFQ_ATTR(group_idle),
+	CFQ_ATTR(group_idle_us),
 	CFQ_ATTR(low_latency),
 	CFQ_ATTR(target_latency),
+	CFQ_ATTR(target_latency_us),
 	__ATTR_NULL
 };
 
-- 
2.6.6
