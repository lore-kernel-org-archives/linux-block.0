Return-Path: <SRS0=/o95=RK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF376C43381
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF14920840
	for <linux-block@archiver.kernel.org>; Thu,  7 Mar 2019 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCGSJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:09:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfCGSJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Mar 2019 13:09:35 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1h1xSX-0001lx-3L
        for linux-block@vger.kernel.org; Thu, 07 Mar 2019 18:09:33 +0000
Received: by mail-wr1-f72.google.com with SMTP id o6so8973162wrm.2
        for <linux-block@vger.kernel.org>; Thu, 07 Mar 2019 10:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CNOTSLqaS5V7TljZnZkBn/fAkhgWZBqkz11C4gbNPOw=;
        b=giP4eCaJYEGJoBxihFrXoEve8/Cu/ATZUMXxQ5O4vQZ69PyDtkx6NcAX7eAMvAFjon
         LxkepoKYYzWxo6gZr7lOjFFaCR6Reiwp1OGJzqPnebcaqek0soKBAk8IG1LX+yL9WTrk
         0yaN4eB4D59OBCExVYF5KBJoFnOpTyUexyTGEnlK5bF8MoCbGXWT3U5x1WUtwY+VwFjY
         5zH0UswVmZae3AzJ3QJqFicnnamAz0cPvf5bPkZoNRin1yyMpvMMwTH34xRONxI7U3sz
         N6Bc7ebFqCacahzbXCS2wFP8QEDXJ8TxZBLS66u9TrGUk00ZmedpW0kXzuB7U5c6oN69
         p+DQ==
X-Gm-Message-State: APjAAAXOe6q+5Bu8WGB+hDatUqR++66FlsAEAmJ9gPZWJy+iwZPVw2lZ
        S6dxNT9PMrchjfTmmUB77AX2o82XneaPi2NrLeDSRUq0LCFxFPqRhhx9rLMtkKsYHTZiwAzTE/7
        JDyfOypijSKrR+VzWvLJPvgkZxWHLYg5CJsfZJQ/z
X-Received: by 2002:a1c:a186:: with SMTP id k128mr6422925wme.54.1551982171147;
        Thu, 07 Mar 2019 10:09:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqykjffXiPK3uPkOWMzHaT0L5xNpaep1AUrHEod+vGcJmvuJscvgdTQc1O7PBeciVq05Zu1R7g==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr6422908wme.54.1551982170847;
        Thu, 07 Mar 2019 10:09:30 -0800 (PST)
Received: from localhost.localdomain (host22-124-dynamic.46-79-r.retail.telecomitalia.it. [79.46.124.22])
        by smtp.gmail.com with ESMTPSA id a74sm7872747wma.22.2019.03.07.10.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:09:30 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] blkcg: implement sync() isolation
Date:   Thu,  7 Mar 2019 19:08:34 +0100
Message-Id: <20190307180834.22008-4-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190307180834.22008-1-andrea.righi@canonical.com>
References: <20190307180834.22008-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Keep track of the inodes that have been dirtied by each blkcg cgroup and
make sure that a blkcg issuing a sync() can trigger the writeback + wait
of only those pages that belong to the cgroup itself.

This behavior is applied only when io.sync_isolation is enabled in the
cgroup, otherwise the old behavior is applied: sync() triggers the
writeback of any dirty page.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 block/blk-cgroup.c         | 47 ++++++++++++++++++++++++++++++++++
 fs/fs-writeback.c          | 52 +++++++++++++++++++++++++++++++++++---
 fs/inode.c                 |  1 +
 include/linux/blk-cgroup.h | 22 ++++++++++++++++
 include/linux/fs.h         |  4 +++
 mm/page-writeback.c        |  1 +
 6 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4305e78d1bb2..7d3b26ba4575 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1480,6 +1480,53 @@ void blkcg_stop_wb_wait_on_bdi(struct backing_dev_info *bdi)
 	spin_unlock(&blkcg_wb_sleeper_lock);
 	rcu_read_unlock();
 }
+
+/**
+ * blkcg_set_mapping_dirty - set owner of a dirty mapping
+ * @mapping: target address space
+ *
+ * Set the current blkcg as the owner of the address space @mapping (the first
+ * blkcg that dirties @mapping becomes the owner).
+ */
+void blkcg_set_mapping_dirty(struct address_space *mapping)
+{
+	struct blkcg *curr_blkcg, *blkcg;
+
+	if (mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
+	    mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
+		return;
+
+	rcu_read_lock();
+	curr_blkcg = blkcg_from_current();
+	blkcg = blkcg_from_mapping(mapping);
+	if (curr_blkcg != blkcg) {
+		if (blkcg)
+			css_put(&blkcg->css);
+		css_get(&curr_blkcg->css);
+		rcu_assign_pointer(mapping->i_blkcg, curr_blkcg);
+	}
+	rcu_read_unlock();
+}
+
+/**
+ * blkcg_set_mapping_clean - clear the owner of a dirty mapping
+ * @mapping: target address space
+ *
+ * Unset the owner of @mapping when it becomes clean.
+ */
+
+void blkcg_set_mapping_clean(struct address_space *mapping)
+{
+	struct blkcg *blkcg;
+
+	rcu_read_lock();
+	blkcg = rcu_dereference(mapping->i_blkcg);
+	if (blkcg) {
+		css_put(&blkcg->css);
+		RCU_INIT_POINTER(mapping->i_blkcg, NULL);
+	}
+	rcu_read_unlock();
+}
 #endif
 
 /**
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 77c039a0ec25..d003d0593f41 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -58,6 +58,9 @@ struct wb_writeback_work {
 
 	struct list_head list;		/* pending work list */
 	struct wb_completion *done;	/* set if the caller waits */
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct blkcg *blkcg;
+#endif
 };
 
 /*
@@ -916,6 +919,29 @@ static int __init cgroup_writeback_init(void)
 }
 fs_initcall(cgroup_writeback_init);
 
+static void blkcg_set_sync_domain(struct wb_writeback_work *work)
+{
+	rcu_read_lock();
+	work->blkcg = blkcg_from_current();
+	rcu_read_unlock();
+}
+
+static bool blkcg_same_sync_domain(struct wb_writeback_work *work,
+				   struct address_space *mapping)
+{
+	struct blkcg *blkcg;
+
+	if (!work->blkcg || work->blkcg == &blkcg_root)
+		return true;
+	if (!test_bit(BLKCG_SYNC_ISOLATION, &work->blkcg->flags))
+		return true;
+	rcu_read_lock();
+	blkcg = blkcg_from_mapping(mapping);
+	rcu_read_unlock();
+
+	return blkcg == work->blkcg;
+}
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static void bdi_down_write_wb_switch_rwsem(struct backing_dev_info *bdi) { }
@@ -959,6 +985,15 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 	}
 }
 
+static void blkcg_set_sync_domain(struct wb_writeback_work *work)
+{
+}
+
+static bool blkcg_same_sync_domain(struct wb_writeback_work *work,
+				   struct address_space *mapping)
+{
+	return true;
+}
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 
 /*
@@ -1131,7 +1166,7 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 	LIST_HEAD(tmp);
 	struct list_head *pos, *node;
 	struct super_block *sb = NULL;
-	struct inode *inode;
+	struct inode *inode, *next;
 	int do_sb_sort = 0;
 	int moved = 0;
 
@@ -1141,11 +1176,12 @@ static int move_expired_inodes(struct list_head *delaying_queue,
 		expire_time = jiffies - (dirtytime_expire_interval * HZ);
 		older_than_this = &expire_time;
 	}
-	while (!list_empty(delaying_queue)) {
-		inode = wb_inode(delaying_queue->prev);
+	list_for_each_entry_safe(inode, next, delaying_queue, i_io_list) {
 		if (older_than_this &&
 		    inode_dirtied_after(inode, *older_than_this))
 			break;
+		if (!blkcg_same_sync_domain(work, inode->i_mapping))
+			continue;
 		list_move(&inode->i_io_list, &tmp);
 		moved++;
 		if (flags & EXPIRE_DIRTY_ATIME)
@@ -1560,6 +1596,15 @@ static long writeback_sb_inodes(struct super_block *sb,
 			break;
 		}
 
+		/*
+		 * Only write out inodes that belong to the blkcg that issued
+		 * the sync().
+		 */
+		if (!blkcg_same_sync_domain(work, inode->i_mapping)) {
+			redirty_tail(inode, wb);
+			continue;
+		}
+
 		/*
 		 * Don't bother with new inodes or inodes being freed, first
 		 * kind does not need periodic writeout yet, and for the latter
@@ -2447,6 +2492,7 @@ void sync_inodes_sb(struct super_block *sb)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
+	blkcg_set_sync_domain(&work);
 	blkcg_start_wb_wait_on_bdi(bdi);
 
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
diff --git a/fs/inode.c b/fs/inode.c
index e9d97add2b36..b9659aaa8546 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -564,6 +564,7 @@ static void evict(struct inode *inode)
 		bd_forget(inode);
 	if (S_ISCHR(inode->i_mode) && inode->i_cdev)
 		cd_forget(inode);
+	blkcg_set_mapping_clean(&inode->i_data);
 
 	remove_inode_hash(inode);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6ac5aa049334..a2bcc83c8c3e 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -441,6 +441,15 @@ extern void blkcg_destroy_blkgs(struct blkcg *blkcg);
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 
+static inline struct blkcg *blkcg_from_mapping(struct address_space *mapping)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return rcu_dereference(mapping->i_blkcg);
+}
+
+void blkcg_set_mapping_dirty(struct address_space *mapping);
+void blkcg_set_mapping_clean(struct address_space *mapping);
+
 /**
  * blkcg_cgwb_get - get a reference for blkcg->cgwb_list
  * @blkcg: blkcg of interest
@@ -474,6 +483,19 @@ void blkcg_stop_wb_wait_on_bdi(struct backing_dev_info *bdi);
 
 #else
 
+static inline struct blkcg *blkcg_from_mapping(struct address_space *mapping)
+{
+	return NULL;
+}
+
+static inline void blkcg_set_mapping_dirty(struct address_space *mapping)
+{
+}
+
+static inline void blkcg_set_mapping_clean(struct address_space *mapping)
+{
+}
+
 static inline void blkcg_cgwb_get(struct blkcg *blkcg) { }
 
 static inline void blkcg_cgwb_put(struct blkcg *blkcg)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 08f26046233e..19e99b4a9fa2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -420,6 +420,7 @@ int pagecache_write_end(struct file *, struct address_space *mapping,
  * @nrpages: Number of page entries, protected by the i_pages lock.
  * @nrexceptional: Shadow or DAX entries, protected by the i_pages lock.
  * @writeback_index: Writeback starts here.
+ * @i_blkcg: blkcg owner (that dirtied the address_space)
  * @a_ops: Methods.
  * @flags: Error bits and flags (AS_*).
  * @wb_err: The most recent error which has occurred.
@@ -438,6 +439,9 @@ struct address_space {
 	unsigned long		nrexceptional;
 	pgoff_t			writeback_index;
 	const struct address_space_operations *a_ops;
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct blkcg __rcu	*i_blkcg;
+#endif
 	unsigned long		flags;
 	errseq_t		wb_err;
 	spinlock_t		private_lock;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9f61dfec6a1f..e16574f946a7 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2418,6 +2418,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
 		inode_attach_wb(inode, page);
 		wb = inode_to_wb(inode);
 
+		blkcg_set_mapping_dirty(mapping);
 		__inc_lruvec_page_state(page, NR_FILE_DIRTY);
 		__inc_zone_page_state(page, NR_ZONE_WRITE_PENDING);
 		__inc_node_page_state(page, NR_DIRTIED);
-- 
2.19.1

