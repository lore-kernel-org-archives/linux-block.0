Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB662C54FD0
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAA72076A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCYMkY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:40:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727290AbgCYMkX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 734B69D7FB448A74284C;
        Wed, 25 Mar 2020 20:40:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:08 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 6/6] blkcg: fix use-after-free for bdi->dev
Date:   Wed, 25 Mar 2020 20:38:43 +0800
Message-ID: <20200325123843.47452-7-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
References: <20200325123843.47452-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__blkg_prfill_rwstat() tries to get the device name by 'bdi->dev',
while the device and kobj->name has been freed by bdi_unregister().
Then, blkg_dev_name() will return an invalid name pointer, resulting
in crash on string(). The race as following:

CPU1                          CPU2
blkg_print_stat_bytes
                              __scsi_remove_device
                              del_gendisk
                                bdi_unregister

                                put_device(bdi->dev)
                                  kfree(bdi->dev)
__blkg_prfill_rwstat
  blkg_dev_name
    //use the freed bdi->dev
    dev_name(blkg->q->backing_dev_info->dev)
                                bdi->dev = NULL

After protecing "bdi->dev" with lock, we just need to use
bdi_get_dev_name() to get device name. Then, the race can be fixed.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-cgroup-rwstat.c  |  6 ++++--
 block/blk-cgroup.c         | 19 ++++++-------------
 block/blk-iocost.c         | 14 ++++++++------
 block/blk-iolatency.c      |  5 +++--
 block/blk-throttle.c       |  6 ++++--
 include/linux/blk-cgroup.h |  1 -
 6 files changed, 25 insertions(+), 26 deletions(-)

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
index 9a599cc28c29..2ae69d475d60 100644
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
-- 
2.17.2

