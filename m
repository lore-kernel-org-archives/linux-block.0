Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57734 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082AbcEKAQu (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Tue, 10 May 2016 20:16:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.16.0.11/8.16.0.11) with SMTP id u4B0ECZC018980
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:49 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0001303.ppops.net with ESMTP id 22u4gm6um8-3
	(version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 10 May 2016 17:16:49 -0700
Received: from facebook.com (2401:db00:11:d0a2:face:0:39:0)	by
 mx-out.facebook.com (10.212.232.59) with ESMTP	id
 a430f664170d11e6b37b0002c991e86a-d20d8c50 for <linux-block@vger.kernel.org>;
	Tue, 10 May 2016 17:16:44 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <tj@kernel.org>, <vgoyal@redhat.com>, <axboe@fb.com>,
	<jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 10/10] blk-throttle: add trace log
Date: Tue, 10 May 2016 17:16:40 -0700
Message-ID: <a26fcd98a87946d4e67b2bfa6b419273cf83edcc.1462923578.git.shli@fb.com>
In-Reply-To: <cover.1462923578.git.shli@fb.com>
References: <cover.1462923578.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add trace log in new low/high logic to help dignose issues.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index a5f3435..d35bbf1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2,6 +2,7 @@
  * Interface for controlling IO bandwidth on a request queue
  *
  * Copyright (C) 2010 Vivek Goyal <vgoyal@redhat.com>
+ * Shaohua Li <shli@fb.com> adds low/high limit
  */
 
 #include <linux/module.h>
@@ -92,6 +93,12 @@ enum {
 	LIMIT_CNT = 3,
 };
 
+static char *limit_name[LIMIT_CNT] = {
+	[LIMIT_LOW] = "low",
+	[LIMIT_HIGH] = "high",
+	[LIMIT_MAX] = "max",
+};
+
 struct throtl_grp {
 	/* must be the first member */
 	struct blkg_policy_data pd;
@@ -1565,6 +1572,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	if (index == LIMIT_MAX && tg->td->limit_index == LIMIT_MAX &&
 	    tg->td->limit_valid[LIMIT_HIGH])
 		tg->td->limit_index = LIMIT_HIGH;
+	throtl_log(&tg->td->service_queue, "switch state to %s",
+		limit_name[tg->td->limit_index]);
 	tg_conf_updated(tg);
 	ret = 0;
 out_finish:
@@ -1710,6 +1719,9 @@ static void throtl_calculate_low_interval(struct throtl_data *td)
 		td->low_upgrade_interval = cg_check_time;
 		td->low_downgrade_interval = dbits / ubits * cg_check_time;
 	}
+	throtl_log(&td->service_queue,
+		"low upgrade interval=%u, downgrade interval=%u",
+		td->low_upgrade_interval, td->low_downgrade_interval);
 }
 
 static void throtl_calculate_high_interval(struct throtl_data *td)
@@ -1729,6 +1741,9 @@ static void throtl_calculate_high_interval(struct throtl_data *td)
 		td->high_upgrade_interval = cg_check_time;
 		td->high_downgrade_interval = dbits / ubits * cg_check_time;
 	}
+	throtl_log(&td->service_queue,
+		"high upgrade interval=%u, downgrade interval=%u",
+		td->high_upgrade_interval, td->high_downgrade_interval);
 }
 
 static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
@@ -1745,6 +1760,8 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
 	/* if cgroup is below low limit for a long time, consider it idle */
 	if (time_after(jiffies,
 	    tg_last_low_overflow_time(tg) + tg->td->low_upgrade_interval)) {
+		throtl_log(&tg->service_queue, "idle upgrade, hit low time=%lu jiffies=%lu",
+			tg_last_low_overflow_time(tg), jiffies);
 		*idle = true;
 		return true;
 	}
@@ -1757,18 +1774,23 @@ static bool throtl_upgrade_check_one(struct throtl_grp *tg, bool *idle)
 		return false;
 	if (tg->iops[WRITE][LIMIT_LOW] != 0 && !sq->nr_queued[WRITE])
 		return false;
+	throtl_log(&tg->service_queue, "reach low limit upgrade");
 	return true;
 check_high:
 	/* if cgroup is below high limit for a long time, consider it idle */
 	if (time_after(jiffies,
 	    tg_last_high_overflow_time(tg) + tg->td->high_upgrade_interval)) {
+		throtl_log(&tg->service_queue, "idle upgrade, hit high time=%lu jiffies=%lu",
+			tg_last_high_overflow_time(tg), jiffies);
 		*idle = true;
 		return true;
 	}
 
 	/* if cgroup reaches high/max limit, it's ok to next limit */
-	if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
+	if (sq->nr_queued[READ] || sq->nr_queued[WRITE]) {
+		throtl_log(&tg->service_queue, "reach high/max limit upgrade");
 		return true;
+	}
 	return false;
 }
 
@@ -1838,6 +1860,8 @@ static void throtl_upgrade_state(struct throtl_data *td)
 	td->limit_index++;
 	while (!td->limit_valid[td->limit_index])
 		td->limit_index++;
+	throtl_log(&td->service_queue, "upgrade state to %s",
+		limit_name[td->limit_index]);
 	td->low_upgrade_time = jiffies;
 	if (td->limit_index == LIMIT_HIGH)
 		td->high_downgrade_time = jiffies;
@@ -1886,6 +1910,8 @@ static void throtl_downgrade_state(struct throtl_data *td, int new)
 	int old = td->limit_index;
 
 	td->limit_index = new;
+	throtl_log(&td->service_queue, "downgrade state to %s",
+		limit_name[td->limit_index]);
 	/* max crosses high to low */
 	if (new == LIMIT_LOW && old == LIMIT_MAX && td->limit_valid[LIMIT_HIGH]) {
 		td->low_downgrade_time = jiffies;
@@ -1926,8 +1952,17 @@ static bool throtl_downgrade_check_one(struct throtl_grp *tg, bool check_low)
 	     time_after(now,
 	      td->high_upgrade_time + td->high_downgrade_interval) &&
 	     time_after(now,
-	      tg_last_high_overflow_time(tg) + td->high_downgrade_interval)))
+	      tg_last_high_overflow_time(tg) + td->high_downgrade_interval))) {
+		throtl_log(&tg->service_queue,
+			"%s idle downgrade, last hit limit time=%lu upgrade time=%lu jiffies=%lu",
+			check_low ? "low" : "high",
+			check_low ? tg_last_low_overflow_time(tg) :
+				tg_last_high_overflow_time(tg),
+			check_low ? td->low_upgrade_time :
+				td->high_upgrade_time,
+			jiffies);
 		return true;
+	}
 	return false;
 }
 
@@ -1986,6 +2021,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 
 	bps = tg->last_bytes_disp[READ] * HZ;
 	do_div(bps, elapsed_time);
+	throtl_log(&tg->service_queue, "rbps=%llu", bps);
 	if (tg->bps[READ][LIMIT_LOW] != 0 &&
 	    bps >= tg->bps[READ][LIMIT_LOW])
 		tg->last_low_overflow_time[READ] = now;
@@ -1996,6 +2032,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 
 	bps = tg->last_bytes_disp[WRITE] * HZ;
 	do_div(bps, elapsed_time);
+	throtl_log(&tg->service_queue, "wbps=%llu", bps);
 	if (tg->bps[WRITE][LIMIT_LOW] != 0 &&
 	    bps >= tg->bps[WRITE][LIMIT_LOW])
 		tg->last_low_overflow_time[WRITE] = now;
@@ -2005,6 +2042,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 		tg->last_high_overflow_time[WRITE] = now;
 
 	iops = tg->last_io_disp[READ] * HZ / elapsed_time;
+	throtl_log(&tg->service_queue, "riops=%u", iops);
 	if (tg->iops[READ][LIMIT_LOW] != 0 &&
 	    iops >= tg->iops[READ][LIMIT_LOW])
 		tg->last_low_overflow_time[READ] = now;
@@ -2014,6 +2052,7 @@ static void throtl_downgrade_check(struct throtl_grp *tg)
 		tg->last_high_overflow_time[READ] = now;
 
 	iops = tg->last_io_disp[WRITE] * HZ / elapsed_time;
+	throtl_log(&tg->service_queue, "wiops=%u", iops);
 	if (tg->iops[WRITE][LIMIT_LOW] != 0 &&
 	    iops >= tg->iops[WRITE][LIMIT_LOW])
 		tg->last_low_overflow_time[WRITE] = now;
-- 
2.8.0.rc2

