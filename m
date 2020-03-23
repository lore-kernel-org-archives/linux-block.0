Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCBBC4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938162080C
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgCWNZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:25:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54438 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728357AbgCWNZl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 09:25:41 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A044BBEDA84FCA343AA3;
        Mon, 23 Mar 2020 21:25:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Mar 2020
 21:25:29 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>
Subject: [PATCH v3 3/4] bdi: replace bdi_dev_name() with bdi_get_dev_name()
Date:   Mon, 23 Mar 2020 21:22:53 +0800
Message-ID: <20200323132254.47157-4-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200323132254.47157-1-yuyufen@huawei.com>
References: <20200323132254.47157-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since kobj->name can be freed by bdi_unregister(), we try to copy
the name into buffer rather than return name pointer. This patch
is prepare for following patch to fix use-after-free for bdi->dev.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/bfq-iosched.c              |  7 +++---
 block/blk-cgroup-rwstat.c        |  6 +++--
 block/blk-cgroup.c               | 19 +++++-----------
 block/blk-iocost.c               | 14 +++++++-----
 block/blk-iolatency.c            |  5 +++--
 block/blk-throttle.c             |  6 +++--
 fs/fs-writeback.c                |  4 +++-
 include/linux/blk-cgroup.h       |  1 -
 include/trace/events/wbt.h       |  8 +++----
 include/trace/events/writeback.h | 38 ++++++++++++++------------------
 10 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 94261b7d7181..a8a67a95006e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4971,6 +4971,7 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	struct task_struct *tsk = current;
 	int ioprio_class;
 	struct bfq_data *bfqd = bfqq->bfqd;
+	char dname[BDI_DEV_NAME_LEN];
 
 	if (!bfqd)
 		return;
@@ -4978,9 +4979,9 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
 	default:
-		pr_err("bdi %s: bfq: bad prio class %d\n",
-				bdi_dev_name(bfqq->bfqd->queue->backing_dev_info),
-				ioprio_class);
+		bdi_get_dev_name(bfqq->bfqd->queue->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN);
+		pr_err("bdi %s: bfq: bad prio class %d\n", dname, ioprio_class);
 		/* fall through */
 	case IOPRIO_CLASS_NONE:
 		/*
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 85d5790ac49b..2dc260802228 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -4,6 +4,7 @@
  * Do not use in new code.
  */
 #include "blk-cgroup-rwstat.h"
+#include <linux/backing-dev.h>
 
 int blkg_rwstat_init(struct blkg_rwstat *rwstat, gfp_t gfp)
 {
@@ -49,11 +50,12 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		[BLKG_RWSTAT_ASYNC]	= "Async",
 		[BLKG_RWSTAT_DISCARD]	= "Discard",
 	};
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 	u64 v;
 	int i;
 
-	if (!dname)
+	if (!bdi_get_dev_name(pd->blkg->q->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN))
 		return 0;
 
 	for (i = 0; i < BLKG_RWSTAT_NR; i++)
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index be92405c6547..a072ca6141ca 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -492,14 +492,6 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-const char *blkg_dev_name(struct blkcg_gq *blkg)
-{
-	/* some drivers (floppy) instantiate a queue w/o disk registered */
-	if (blkg->q->backing_dev_info->dev)
-		return bdi_dev_name(blkg->q->backing_dev_info);
-	return NULL;
-}
-
 /**
  * blkcg_print_blkgs - helper for printing per-blkg data
  * @sf: seq_file to print to
@@ -551,9 +543,10 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
  */
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 
-	if (!dname)
+	if (!bdi_get_dev_name(pd->blkg->q->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN))
 		return 0;
 
 	seq_printf(sf, "%s %llu\n", dname, (unsigned long long)v);
@@ -749,7 +742,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct blkg_iostat_set *bis = &blkg->iostat;
-		const char *dname;
+		char dname[BDI_DEV_NAME_LEN];
 		char *buf;
 		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
@@ -762,8 +755,8 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		if (!blkg->online)
 			goto skip;
 
-		dname = blkg_dev_name(blkg);
-		if (!dname)
+		if (!bdi_get_dev_name(blkg->q->backing_dev_info, dname,
+					BDI_DEV_NAME_LEN))
 			goto skip;
 
 		/*
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 27ca68621137..4231d65915c8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2047,10 +2047,11 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			     int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
-	if (dname && iocg->cfg_weight)
+	if (bdi_get_dev_name(pd->blkg, dname, BDI_DEV_NAME_LEN) &&
+			iocg->cfg_weight)
 		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight);
 	return 0;
 }
@@ -2133,10 +2134,11 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			  int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 
-	if (!dname)
+	if (!bdi_get_dev_name(pd->blkg->q->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN))
 		return 0;
 
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
@@ -2304,11 +2306,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 static u64 ioc_cost_model_prfill(struct seq_file *sf,
 				 struct blkg_policy_data *pd, int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 	u64 *u = ioc->params.i_lcoefs;
 
-	if (!dname)
+	if (!bdi_get_dev_name(pd->blkg, dname, BDI_DEV_NAME_LEN))
 		return 0;
 
 	seq_printf(sf, "%s ctrl=%s model=linear "
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c128d50cb410..2ab49167aea1 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -868,9 +868,10 @@ static u64 iolatency_prfill_limit(struct seq_file *sf,
 				  struct blkg_policy_data *pd, int off)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 
-	if (!dname || !iolat->min_lat_nsec)
+	if (!bdi_get_dev_name(pd->blkg, dname, BDI_DEV_NAME_LEN)
+			|| !iolat->min_lat_nsec)
 		return 0;
 	seq_printf(sf, "%s target=%llu\n",
 		   dname, div_u64(iolat->min_lat_nsec, NSEC_PER_USEC));
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 98233c9c65a8..f77dc93d4e83 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -13,6 +13,7 @@
 #include <linux/blk-cgroup.h>
 #include "blk.h"
 #include "blk-cgroup-rwstat.h"
+#include <linux/backing-dev.h>
 
 /* Max dispatch from a group in 1 round */
 static int throtl_grp_quantum = 8;
@@ -1560,14 +1561,15 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dname[BDI_DEV_NAME_LEN];
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
 	char idle_time[26] = "";
 	char latency_time[26] = "";
 
-	if (!dname)
+	if (!bdi_get_dev_name(pd->blkg->q->backing_dev_info, dname,
+				BDI_DEV_NAME_LEN))
 		return 0;
 
 	if (off == LIMIT_LOW) {
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..8d36c256560c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2062,8 +2062,10 @@ void wb_workfn(struct work_struct *work)
 	struct bdi_writeback *wb = container_of(to_delayed_work(work),
 						struct bdi_writeback, dwork);
 	long pages_written;
+	char dname[BDI_DEV_NAME_LEN];
 
-	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
+	set_worker_desc("flush-%s",
+			bdi_get_dev_name(wb->bdi, dname, BDI_DEV_NAME_LEN));
 	current->flags |= PF_SWAPWRITE;
 
 	if (likely(!current_is_workqueue_rescuer() ||
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a6949fd171..384b3343d5f4 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -198,7 +198,6 @@ int blkcg_activate_policy(struct request_queue *q,
 void blkcg_deactivate_policy(struct request_queue *q,
 			     const struct blkcg_policy *pol);
 
-const char *blkg_dev_name(struct blkcg_gq *blkg);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
 				     struct blkg_policy_data *, int),
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 9996420d7ec4..3fbf15565962 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -33,7 +33,7 @@ TRACE_EVENT(wbt_stat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->rmean		= stat[0].mean;
 		__entry->rmin		= stat[0].min;
@@ -68,7 +68,7 @@ TRACE_EVENT(wbt_lat,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->lat = div_u64(lat, 1000);
 	),
@@ -105,7 +105,7 @@ TRACE_EVENT(wbt_step,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->msg	= msg;
 		__entry->step	= step;
@@ -141,7 +141,7 @@ TRACE_EVENT(wbt_timer,
 	),
 
 	TP_fast_assign(
-		strlcpy(__entry->name, bdi_dev_name(bdi),
+		bdi_get_dev_name(bdi, __entry->name,
 			ARRAY_SIZE(__entry->name));
 		__entry->status		= status;
 		__entry->step		= step;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index d94def25e4dc..4767a5ab5e36 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -66,9 +66,8 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name,
-			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
-					 NULL), 32);
+		bdi_get_dev_name(mapping ? inode_to_bdi(mapping->host) : NULL,
+				__entry->name, 32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
@@ -111,7 +110,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
-		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
+		bdi_get_dev_name(bdi, __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->flags		= flags;
@@ -192,7 +191,7 @@ TRACE_EVENT(inode_foreign_history,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, bdi_dev_name(inode_to_bdi(inode)), 32);
+		bdi_get_dev_name(inode_to_bdi(inode), __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 		__entry->history	= history;
@@ -221,7 +220,7 @@ TRACE_EVENT(inode_switch_wbs,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,	bdi_dev_name(old_wb->bdi), 32);
+		bdi_get_dev_name(old_wb->bdi, __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->old_cgroup_ino	= __trace_wb_assign_cgroup(old_wb);
 		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
@@ -254,7 +253,7 @@ TRACE_EVENT(track_foreign_dirty,
 		struct address_space *mapping = page_mapping(page);
 		struct inode *inode = mapping ? mapping->host : NULL;
 
-		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->name, 32);
 		__entry->bdi_id		= wb->bdi->id;
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
@@ -287,7 +286,7 @@ TRACE_EVENT(flush_foreign,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->name, 32);
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 		__entry->frn_bdi_id	= frn_bdi_id;
 		__entry->frn_memcg_id	= frn_memcg_id;
@@ -316,8 +315,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name,
-			    bdi_dev_name(inode_to_bdi(inode)), 32);
+		bdi_get_dev_name(inode_to_bdi(inode), __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
@@ -360,7 +358,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->name, 32);
 		__entry->nr_pages = work->nr_pages;
 		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
 		__entry->sync_mode = work->sync_mode;
@@ -413,7 +411,7 @@ DECLARE_EVENT_CLASS(writeback_class,
 		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->name, 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%lu",
@@ -435,7 +433,7 @@ TRACE_EVENT(writeback_bdi_register,
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
+		bdi_get_dev_name(bdi, __entry->name, 32);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -460,7 +458,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
+		bdi_get_dev_name(bdi, __entry->name, 32);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -511,7 +509,7 @@ TRACE_EVENT(writeback_queue_io,
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->name, 32);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -597,7 +595,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->bdi, 32);
 		__entry->write_bw	= KBps(wb->write_bandwidth);
 		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
 		__entry->dirty_rate	= KBps(dirty_rate);
@@ -662,7 +660,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_fast_assign(
 		unsigned long freerun = (thresh + bg_thresh) / 2;
-		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
+		bdi_get_dev_name(wb->bdi, __entry->bdi, 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
@@ -722,8 +720,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name,
-			    bdi_dev_name(inode_to_bdi(inode)), 32);
+		bdi_get_dev_name(inode_to_bdi(inode), __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
@@ -796,8 +793,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name,
-			    bdi_dev_name(inode_to_bdi(inode)), 32);
+		bdi_get_dev_name(inode_to_bdi(inode), __entry->name, 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
-- 
2.17.2

