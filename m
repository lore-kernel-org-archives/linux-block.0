Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F398C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C7B2076A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgCYMk2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:40:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727279AbgCYMk2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 68DFC276D04602731DAD;
        Wed, 25 Mar 2020 20:40:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:07 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 4/6] memcg: fix crash in wb_workfn when bdi unregister
Date:   Wed, 25 Mar 2020 20:38:41 +0800
Message-ID: <20200325123843.47452-5-yuyufen@huawei.com>
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

Commit 68f23b89067f ("memcg: fix a crash in wb_workfn when a device
disappears") try to handle bdi->dev beening NULL by adding bdi_dev_name().
But, bdi->dev can be freed and set as 'NULL' after bdi_dev_name()
think the value is valid. Then it can cause use-after-free for dev
or kobj->name.

After protecting the bdi->dev with lock, the race can be fixed thoroughly.
Here, we just need to replace bdi_dev_name() with bdi_get_dev_name().

Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/fs-writeback.c                |  4 +++-
 include/trace/events/writeback.h | 38 ++++++++++++++------------------
 2 files changed, 20 insertions(+), 22 deletions(-)

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

