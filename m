Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD24C352A3
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02207214DB
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 13:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgBKNxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:53:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729674AbgBKNxj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 08:53:39 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC4654E584C1934F9423;
        Tue, 11 Feb 2020 21:53:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 21:53:34 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <jack@suse.cz>, <bvanassche@acm.org>, <tj@kernel.org>
Subject: [PATCH] bdi: fix use-after-free for bdi device
Date:   Tue, 11 Feb 2020 22:00:38 +0800
Message-ID: <20200211140038.146629-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We reported a kernel crash:

[201962.639350] Call trace:
[201962.644403]  string+0x28/0xa0
[201962.650501]  vsnprintf+0x5f0/0x748
[201962.657472]  seq_vprintf+0x70/0x98
[201962.664442]  seq_printf+0x7c/0xa0
[201962.671238]  __blkg_prfill_rwstat+0x84/0x128
[201962.679949]  blkg_prfill_rwstat_field+0x94/0xc0
[201962.689182]  blkcg_print_blkgs+0xcc/0x140
[201962.697370]  blkg_print_stat_bytes+0x4c/0x60
[201962.706083]  cgroup_seqfile_show+0x58/0xc0
[201962.714446]  kernfs_seq_show+0x44/0x50
[201962.722112]  seq_read+0xd4/0x4a8
[201962.728732]  kernfs_fop_read+0x16c/0x218
[201962.736748]  __vfs_read+0x60/0x188
[201962.743717]  vfs_read+0x94/0x150
[201962.750338]  ksys_read+0x6c/0xd8
[201962.756958]  __arm64_sys_read+0x24/0x30
[201962.764800]  el0_svc_common+0x78/0x130
[201962.772466]  el0_svc_handler+0x38/0x78
[201962.780131]  el0_svc+0x8/0xc

__blkg_prfill_rwstat() tries to get the device name by
'bdi->dev', while the 'dev' has been freed by bdi_unregister().
Then, blkg_dev_name() will return an invalid name pointer,
resulting in crash on string(). The race as following:

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

To fix the bug, we add a new spinlock for bdi to protect
the device. Then, blk_dev_name() returns valid name or
'NULL', both of them will be okay.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 block/blk-cgroup-rwstat.c        |  3 ++-
 block/blk-cgroup.c               | 26 +++++++++++++++++++-------
 block/blk-iocost.c               |  9 ++++++---
 block/blk-iolatency.c            |  3 ++-
 block/blk-throttle.c             |  3 ++-
 include/linux/backing-dev-defs.h |  1 +
 include/linux/blk-cgroup.h       |  2 +-
 mm/backing-dev.c                 |  8 ++++++--
 8 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index 85d5790ac49b..20ef51cb3ea4 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -49,7 +49,8 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		[BLKG_RWSTAT_ASYNC]	= "Async",
 		[BLKG_RWSTAT_DISCARD]	= "Discard",
 	};
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 	u64 v;
 	int i;
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94d5390..41bf7513c249 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -492,12 +492,22 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	return 0;
 }
 
-const char *blkg_dev_name(struct blkcg_gq *blkg)
+char *blkg_dev_name(struct blkcg_gq *blkg, char *dname)
 {
 	/* some drivers (floppy) instantiate a queue w/o disk registered */
-	if (blkg->q->backing_dev_info->dev)
-		return dev_name(blkg->q->backing_dev_info->dev);
-	return NULL;
+	struct backing_dev_info *bdi = blkg->q->backing_dev_info;
+
+	/*
+	 * We use spinlock to protect bdi->dev, avoiding
+	 * the device been freed by bdi_unregister().
+	 */
+	spin_lock_irq(&bdi->lock);
+	if (bdi->dev)
+		strlcpy(dname, dev_name(bdi->dev), 32);
+	else
+		dname = NULL;
+	spin_unlock_irq(&bdi->lock);
+	return dname;
 }
 
 /**
@@ -551,7 +561,8 @@ EXPORT_SYMBOL_GPL(blkcg_print_blkgs);
  */
 u64 __blkg_prfill_u64(struct seq_file *sf, struct blkg_policy_data *pd, u64 v)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 
 	if (!dname)
 		return 0;
@@ -749,7 +760,8 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct blkg_iostat_set *bis = &blkg->iostat;
-		const char *dname;
+		char dev_name[32];
+		char *dname;
 		char *buf;
 		u64 rbytes, wbytes, rios, wios, dbytes, dios;
 		size_t size = seq_get_buf(sf, &buf), off = 0;
@@ -762,7 +774,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 		if (!blkg->online)
 			goto skip;
 
-		dname = blkg_dev_name(blkg);
+		dname = blkg_dev_name(blkg, dev_name);
 		if (!dname)
 			goto skip;
 
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 27ca68621137..d38d2f81343e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2047,7 +2047,8 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			     int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
@@ -2133,7 +2134,8 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			  int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	const char *dname = blkg_dev_name(pd->blkg, dev_name);
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 
 	if (!dname)
@@ -2304,7 +2306,8 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 static u64 ioc_cost_model_prfill(struct seq_file *sf,
 				 struct blkg_policy_data *pd, int off)
 {
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 	u64 *u = ioc->params.i_lcoefs;
 
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index c128d50cb410..71bcbd757889 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -868,7 +868,8 @@ static u64 iolatency_prfill_limit(struct seq_file *sf,
 				  struct blkg_policy_data *pd, int off)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 
 	if (!dname || !iolat->min_lat_nsec)
 		return 0;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 98233c9c65a8..83b0b43fe4a3 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1560,7 +1560,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 			 int off)
 {
 	struct throtl_grp *tg = pd_to_tg(pd);
-	const char *dname = blkg_dev_name(pd->blkg);
+	char dev_name[32];
+	char *dname = blkg_dev_name(pd->blkg, dev_name);
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..c98dac4a7953 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -227,6 +227,7 @@ struct backing_dev_info {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debug_dir;
 #endif
+	spinlock_t lock;		/* protects dev */
 };
 
 enum {
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index e4a6949fd171..6034ef9cf07a 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -198,7 +198,7 @@ int blkcg_activate_policy(struct request_queue *q,
 void blkcg_deactivate_policy(struct request_queue *q,
 			     const struct blkcg_policy *pol);
 
-const char *blkg_dev_name(struct blkcg_gq *blkg);
+char *blkg_dev_name(struct blkcg_gq *blkg, char *dev_name);
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 		       u64 (*prfill)(struct seq_file *,
 				     struct blkg_policy_data *, int),
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 62f05f605fb5..a5aa00ec2d8a 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -859,6 +859,7 @@ static int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
+	spin_lock_init(&bdi->lock);
 
 	ret = cgwb_bdi_init(bdi);
 
@@ -1007,15 +1008,18 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	struct device *dev = bdi->dev;
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_unregister(bdi);
 
-	if (bdi->dev) {
+	if (dev) {
 		bdi_debug_unregister(bdi);
-		device_unregister(bdi->dev);
+		spin_lock(&bdi->lock);
 		bdi->dev = NULL;
+		spin_unlock(&bdi->lock);
+		device_unregister(dev);
 	}
 
 	if (bdi->owner) {
-- 
2.16.2.dirty

