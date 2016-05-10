Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24495 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753924AbcEJAWU (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Mon, 9 May 2016 20:22:20 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4A0LnTq022553
	for <linux-block@vger.kernel.org>; Mon, 9 May 2016 17:22:19 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0001303.ppops.net with ESMTP id 22u4gm04dw-1
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 09 May 2016 17:22:19 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.223.101.97) with ESMTP	id
 40166f6a164511e68ba924be0595f910-ce7d6c50 for <linux-block@vger.kernel.org>;
	Mon, 09 May 2016 17:22:16 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, <axboe@fb.com>,
	<Kernel-team@fb.com>
Subject: [PATCH 3/3] blk-throttle: don't parse cgroup path if trace isn't enabled
Date: Mon, 9 May 2016 17:22:15 -0700
Message-ID: <b395946862a1a963e6d74b70349322eceb5d42d4.1462838969.git.shli@fb.com>
In-Reply-To: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
References: <2c3ee532132f8925dd0be1178e8dee0bba6b448c.1462838969.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

if trace isn't enabled, parsing cgroup path just wastes cpu

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c         | 5 ++---
 include/linux/blktrace_api.h | 9 +++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 2149a1d..47a3e54 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -211,15 +211,14 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
  *
  * The messages are prefixed with "throtl BLKG_NAME" if @sq belongs to a
  * throtl_grp; otherwise, just "throtl".
- *
- * TODO: this should be made a function and name formatting should happen
- * after testing whether blktrace is enabled.
  */
 #define throtl_log(sq, fmt, args...)	do {				\
 	struct throtl_grp *__tg = sq_to_tg((sq));			\
 	struct throtl_data *__td = sq_to_td((sq));			\
 									\
 	(void)__td;							\
+	if (likely(!blk_trace_note_message_enabled(__td->queue)))	\
+		break;							\
 	if ((__tg)) {							\
 		char __pbuf[128];					\
 									\
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index afc1343..0f3172b 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -57,6 +57,14 @@ void __trace_note_message(struct blk_trace *, const char *fmt, ...);
 	} while (0)
 #define BLK_TN_MAX_MSG		128
 
+static inline bool blk_trace_note_message_enabled(struct request_queue *q)
+{
+	struct blk_trace *bt = q->blk_trace;
+	if (likely(!bt))
+		return false;
+	return bt->act_mask & BLK_TC_NOTIFY;
+}
+
 extern void blk_add_driver_data(struct request_queue *q, struct request *rq,
 				void *data, size_t len);
 extern int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
@@ -79,6 +87,7 @@ extern struct attribute_group blk_trace_attr_group;
 # define blk_trace_remove(q)				(-ENOTTY)
 # define blk_add_trace_msg(q, fmt, ...)			do { } while (0)
 # define blk_trace_remove_sysfs(dev)			do { } while (0)
+# define blk_trace_note_message_enabled(q)		(false)
 static inline int blk_trace_init_sysfs(struct device *dev)
 {
 	return 0;
-- 
2.8.0.rc2

