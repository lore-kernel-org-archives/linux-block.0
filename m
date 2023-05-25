Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D4FC77B73
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 04:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEYEgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 00:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEYEgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 00:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDFAA
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 21:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684989328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pUPkBmCCVx12F32b5yFtT1MwzPhxpYDfpTG0aJV/MUs=;
        b=McDfu0HAsPWb1piBGSs1NFlGc6pWR5oYoba6MOL/Bh/eyLHQap2uwQXGaafhgzVP8GscRE
        mVce1H63QE2/4OxGfKE8hkgst8WfwtmEunDGMgfFCEW8GMNmYJrMy3efS6kj7WSNdmCx8S
        0DlcIUp/9mNQNonFsgIchMTpmVqWtK0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-YSiFIgo9OiOZzksJ0MYzjg-1; Thu, 25 May 2023 00:35:24 -0400
X-MC-Unique: YSiFIgo9OiOZzksJ0MYzjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5709A3C11CD4;
        Thu, 25 May 2023 04:35:24 +0000 (UTC)
Received: from localhost (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5811D20296C6;
        Thu, 25 May 2023 04:35:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        stable@vger.kernel.org, Jay Shin <jaeshin@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com, Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH V3] blk-cgroup: Flush stats before releasing blkcg_gq
Date:   Thu, 25 May 2023 12:35:18 +0800
Message-Id: <20230525043518.831721-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As noted by Michal, the blkg_iostat_set's in the lockless list hold
reference to blkg's to protect against their removal. Those blkg's
hold reference to blkcg. When a cgroup is being destroyed,
cgroup_rstat_flush() is only called at css_release_work_fn() which
is called when the blkcg reference count reaches 0. This circular
dependency will prevent blkcg and some blkgs from being freed after
they are made offline.

It is less a problem if the cgroup to be destroyed also has other
controllers like memory that will call cgroup_rstat_flush() which will
clean up the reference count. If block is the only controller that uses
rstat, these offline blkcg and blkgs may never be freed leaking more
and more memory over time.

To prevent this potential memory leak:

- flush blkcg per-cpu stats list in __blkg_release(), when no new stat
can be added

- add global blkg_stat_lock for covering concurrent parent blkg stat
update

- don't grab bio->bi_blkg reference when adding the stats into blkcg's
per-cpu stat list since all stats are guaranteed to be consumed before
releasing blkg instance, and grabbing blkg reference for stats was the
most fragile part of original patch

Based on Waiman's patch:

https://lore.kernel.org/linux-block/20221215033132.230023-3-longman@redhat.com/

Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Cc: stable@vger.kernel.org
Reported-by: Jay Shin <jaeshin@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: mkoutny@suse.com
Cc: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- add one global blkg_stat_lock for avoiding concurrent update on
	blkg stat; this way is easier for backport, also won't cause contention;

V2:
	- remove kernel/cgroup change, and call blkcg_rstat_flush()
	to flush stat directly

 block/blk-cgroup.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ce64dd73cfe..f0b5c9c41cde 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -34,6 +34,8 @@
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
 
+static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
+
 /*
  * blkcg_pol_mutex protects blkcg_policy[] and policy [de]activation.
  * blkcg_pol_register_mutex nests outside of it and synchronizes entire
@@ -56,6 +58,8 @@ static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 bool blkcg_debug_stats = false;
 
+static DEFINE_RAW_SPINLOCK(blkg_stat_lock);
+
 #define BLKG_DESTROY_BATCH_SIZE  64
 
 /*
@@ -163,10 +167,20 @@ static void blkg_free(struct blkcg_gq *blkg)
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+	struct blkcg *blkcg = blkg->blkcg;
+	int cpu;
 
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	WARN_ON(!bio_list_empty(&blkg->async_bios));
 #endif
+	/*
+	 * Flush all the non-empty percpu lockless lists before releasing
+	 * us, given these stat belongs to us.
+	 *
+	 * blkg_stat_lock is for serializing blkg stat update
+	 */
+	for_each_possible_cpu(cpu)
+		__blkcg_rstat_flush(blkcg, cpu);
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
@@ -951,23 +965,26 @@ static void blkcg_iostat_update(struct blkcg_gq *blkg, struct blkg_iostat *cur,
 	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
 }
 
-static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 {
-	struct blkcg *blkcg = css_to_blkcg(css);
 	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
 	struct llist_node *lnode;
 	struct blkg_iostat_set *bisc, *next_bisc;
 
-	/* Root-level stats are sourced from system-wide IO stats */
-	if (!cgroup_parent(css->cgroup))
-		return;
-
 	rcu_read_lock();
 
 	lnode = llist_del_all(lhead);
 	if (!lnode)
 		goto out;
 
+	/*
+	 * For covering concurrent parent blkg update from blkg_release().
+	 *
+	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
+	 * this lock won't cause contention most of time.
+	 */
+	raw_spin_lock(&blkg_stat_lock);
+
 	/*
 	 * Iterate only the iostat_cpu's queued in the lockless list.
 	 */
@@ -991,13 +1008,19 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (parent && parent->parent)
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
-		percpu_ref_put(&blkg->refcnt);
 	}
-
+	raw_spin_unlock(&blkg_stat_lock);
 out:
 	rcu_read_unlock();
 }
 
+static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	/* Root-level stats are sourced from system-wide IO stats */
+	if (cgroup_parent(css->cgroup))
+		__blkcg_rstat_flush(css_to_blkcg(css), cpu);
+}
+
 /*
  * We source root cgroup stats from the system-wide stats to avoid
  * tracking the same information twice and incurring overhead when no
@@ -2075,7 +2098,6 @@ void blk_cgroup_bio_start(struct bio *bio)
 
 		llist_add(&bis->lnode, lhead);
 		WRITE_ONCE(bis->lqueued, true);
-		percpu_ref_get(&bis->blkg->refcnt);
 	}
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
-- 
2.40.1

