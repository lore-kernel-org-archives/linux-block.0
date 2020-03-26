Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF0C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0572A2076A
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 11:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtuIanoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgCZLMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:12:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44069 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZLMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 07:12:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so1984267plr.11;
        Thu, 26 Mar 2020 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VWkQKW+0O9iGIwovqTyuSGTaplJbqkl4t8fzkYB4gBE=;
        b=jtuIanoHNItiirMWqxq81HOmQO2g4kebKtPeLHoPUBHRdUsO4RmJUE6V0b0mDqtEAy
         0UxXC+5zfdWOBpgY///uHtfhxqErywduYLYuu8B6wEBsyyLPU4L0e93uXJ5nftwe9Y4L
         WLDYuW6h5Q82TLYvN9SdpvzrBIIC6WcKa7JEt/CjFi+TjuRopw3RcP4qpw8lKE7GbDqX
         Yeg2OOKhbLoURgHlIY/jhD8egHuh9GzOb2d0c1gVTuvORoFCiFXvE1AOreHfUfehGOUB
         llax+axfGrqJpcoiprDg+pIrBN917mhZRRmKZ5b/LKE1FihI7PAUa2Oc7Obe8A6e7FLA
         WqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VWkQKW+0O9iGIwovqTyuSGTaplJbqkl4t8fzkYB4gBE=;
        b=I1US1LRTjASnoBr0M/4AaexbQ3t+J6SQAV7X3khc7mQ5ZrtZPXyKkC0QlVZIhSZ4Cz
         gn+oUkyp20tuc5kKcSImZ4oXQFpsAStTOWnRFIbRTnfZUjb9spdCx3pbednS9nMaeyTJ
         Ro5itPReMvLMc8Jqra/ZYYNqidptytS+sqKektG2zTYijzpaib+lR58NKTiVY9CHKFu/
         uJtFQ31V5W6G0ni5iLRqQtP8cI+pnUGOoNGR3xkyTK6/33xzf408b1yOw8Ap1eTNMNM1
         v3rqWIDkGoxGVg8iZoAgAJibFDo4idb722S2IZ7uSNdx/HAU+aexVHOaqkKvN9ZkcDqj
         IuQw==
X-Gm-Message-State: ANhLgQ1TY0QRFTzHh8CwW7rdUPUV3Rmakjuwx77pOOLarhbEXlp20KhF
        hh660yqYKyWfuofzM+1d/xI=
X-Google-Smtp-Source: ADFU+vsxeoWk59cjGMPBDRmaqKSKdxpR2NavHs+av5lDO++pcLbiPu6pPI7YI2Hup0JPrfSsyCLzSg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr7153100plp.252.1585221169497;
        Thu, 26 Mar 2020 04:12:49 -0700 (PDT)
Received: from dev.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id m9sm1427723pff.93.2020.03.26.04.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 04:12:48 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     hannes@cmpxchg.org, peterz@infradead.org,
        akpm@linux-foundation.org, mhocko@kernel.org, axboe@kernel.dk,
        mgorman@suse.de, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/2] psi: introduce various types of memstall
Date:   Thu, 26 Mar 2020 07:12:06 -0400
Message-Id: <1585221127-11458-2-git-send-email-laoar.shao@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The memstall is used as a memory pressure index now. But there're many
paths to get into memstall, so once memstall happens we don't know the
specific reason of it.

This patch introduces various types of memstall as bellow,
	MEMSTALL_KSWAPD
	MEMSTALL_RECLAIM_DIRECT
	MEMSTALL_RECLAIM_MEMCG
	MEMSTALL_RECLAIM_HIGH
	MEMSTALL_KCOMPACTD
	MEMSTALL_COMPACT
	MEMSTALL_WORKINGSET_REFAULT
	MEMSTALL_WORKINGSET_THRASHING
	MEMSTALL_MEMDELAY
	MEMSTALL_SWAPIO
and adds a new parameter 'type' in psi_memstall_{enter, leave}.

After that, we can trace specific types of memstall with other
powerful tools like tracepoint, kprobe, ebpf and etc. It can also help us
to analyze latency spike caused by memory pressure. But note that we
can't use it to build memory pressure for a specific type of memstall,
e.g. memcg pressure, compaction pressure and etc, because it doesn't
implement various types of task->in_memstall, e.g. task->in_memcgstall,
task->in_compactionstall and etc. IOW, the main goal of it is to trace
the spread of latencies and the specific reason of these latencies.

Although there're already some tracepoints can help us to achieve this
goal, e.g.
	vmscan:mm_vmscan_kswapd_{wake, sleep}
	vmscan:mm_vmscan_direct_reclaim_{begin, end}
	vmscan:mm_vmscan_memcg_reclaim_{begin, end}
	/* no tracepoint for memcg high reclaim*/
	compcation:mm_compaction_kcompactd_{wake, sleep}
	compcation:mm_compaction_begin_{begin, end}
	/* no tracepoint for workingset refault */
	/* no tracepoint for workingset thrashing */
	/* no tracepoint for use memdelay */
	/* no tracepoint for swapio */
but psi_memstall_{enter, leave} gives us a unified entrance for all
types of memstall and we don't need to add many begin and end tracepoints
that hasn't been implemented yet.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 block/blk-cgroup.c        |  4 ++--
 block/blk-core.c          |  4 ++--
 include/linux/psi.h       | 15 +++++++++++----
 include/linux/psi_types.h | 13 +++++++++++++
 kernel/sched/psi.c        |  6 ++++--
 mm/compaction.c           |  4 ++--
 mm/filemap.c              |  4 ++--
 mm/memcontrol.c           |  4 ++--
 mm/page_alloc.c           |  8 ++++----
 mm/page_io.c              |  4 ++--
 mm/vmscan.c               |  8 ++++----
 11 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a229b94..fc24095 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1593,7 +1593,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
 
 	if (use_memdelay)
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, MEMSTALL_MEMDELAY);
 
 	exp = ktime_add_ns(now, delay_nsec);
 	tok = io_schedule_prepare();
@@ -1605,7 +1605,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	io_schedule_finish(tok);
 
 	if (use_memdelay)
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, MEMSTALL_MEMDELAY);
 }
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index 60dc955..e2039cf 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1190,12 +1190,12 @@ blk_qc_t submit_bio(struct bio *bio)
 	 * submission can be a significant part of overall IO time.
 	 */
 	if (workingset_read)
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, MEMSTALL_WORKINGSET_REFAULT);
 
 	ret = generic_make_request(bio);
 
 	if (workingset_read)
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, MEMSTALL_WORKINGSET_REFAULT);
 
 	return ret;
 }
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b3de73..7bf94f6 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -19,8 +19,8 @@
 void psi_task_change(struct task_struct *task, int clear, int set);
 
 void psi_memstall_tick(struct task_struct *task, int cpu);
-void psi_memstall_enter(unsigned long *flags);
-void psi_memstall_leave(unsigned long *flags);
+void psi_memstall_enter(unsigned long *flags, enum memstall_types type);
+void psi_memstall_leave(unsigned long *flags, enum memstall_types type);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 
@@ -41,8 +41,15 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 
 static inline void psi_init(void) {}
 
-static inline void psi_memstall_enter(unsigned long *flags) {}
-static inline void psi_memstall_leave(unsigned long *flags) {}
+static inline void psi_memstall_enter(unsigned long *flags,
+				      enum memstall_types type)
+{
+}
+
+static inline void psi_memstall_leave(unsigned long *flags,
+				      enum memstall_types type)
+{
+}
 
 #ifdef CONFIG_CGROUPS
 static inline int psi_cgroup_alloc(struct cgroup *cgrp)
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b..52a3f08 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -7,6 +7,19 @@
 #include <linux/kref.h>
 #include <linux/wait.h>
 
+enum memstall_types {
+	MEMSTALL_KSWAPD,
+	MEMSTALL_RECLAIM_DIRECT,
+	MEMSTALL_RECLAIM_MEMCG,
+	MEMSTALL_RECLAIM_HIGH,
+	MEMSTALL_KCOMPACTD,
+	MEMSTALL_COMPACT,
+	MEMSTALL_WORKINGSET_REFAULT,
+	MEMSTALL_WORKINGSET_THRASH,
+	MEMSTALL_MEMDELAY,
+	MEMSTALL_SWAP,
+};
+
 #ifdef CONFIG_PSI
 
 /* Tracked task states */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 0285207..460f084 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -806,11 +806,12 @@ void psi_memstall_tick(struct task_struct *task, int cpu)
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
+ * @type: type of memstall
  *
  * Marks the calling task as being stalled due to a lack of memory,
  * such as waiting for a refault or performing reclaim.
  */
-void psi_memstall_enter(unsigned long *flags)
+void psi_memstall_enter(unsigned long *flags, enum memstall_types type)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -837,10 +838,11 @@ void psi_memstall_enter(unsigned long *flags)
 /**
  * psi_memstall_leave - mark the end of an memory stall section
  * @flags: flags to handle nested memdelay sections
+ * @type: type of memstall
  *
  * Marks the calling task as no longer stalled due to lack of memory.
  */
-void psi_memstall_leave(unsigned long *flags)
+void psi_memstall_leave(unsigned long *flags, enum memstall_types type)
 {
 	struct rq_flags rf;
 	struct rq *rq;
diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c7..c0d5331 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2647,9 +2647,9 @@ static int kcompactd(void *p)
 		wait_event_freezable(pgdat->kcompactd_wait,
 				kcompactd_work_requested(pgdat));
 
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, MEMSTALL_KCOMPACTD);
 		kcompactd_do_work(pgdat);
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, MEMSTALL_KCOMPACTD);
 	}
 
 	return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478..f5459e3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1123,7 +1123,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, MEMSTALL_WORKINGSET_THRASH);
 		thrashing = true;
 	}
 
@@ -1182,7 +1182,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	if (thrashing) {
 		if (delayacct)
 			delayacct_thrashing_end();
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, MEMSTALL_WORKINGSET_THRASH);
 	}
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7a4bd8b..a9b336e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2399,9 +2399,9 @@ void mem_cgroup_handle_over_high(void)
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
 	 * need to account for any ill-begotten jiffies to pay them off later.
 	 */
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_RECLAIM_HIGH);
 	schedule_timeout_killable(penalty_jiffies);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_RECLAIM_HIGH);
 
 out:
 	css_put(&memcg->css);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb75..8789234a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3884,14 +3884,14 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	if (!order)
 		return NULL;
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_COMPACT);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
 								prio, &page);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_COMPACT);
 
 	/*
 	 * At least in one zone compaction wasn't deferred or skipped, so let's
@@ -4106,7 +4106,7 @@ void fs_reclaim_release(gfp_t gfp_mask)
 
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_RECLAIM_DIRECT);
 	fs_reclaim_acquire(gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -4115,7 +4115,7 @@ void fs_reclaim_release(gfp_t gfp_mask)
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_RECLAIM_DIRECT);
 
 	cond_resched();
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be..67de6b1 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -369,7 +369,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * or the submitting cgroup IO-throttled, submission can be a
 	 * significant part of overall IO time.
 	 */
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_SWAPIO);
 
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
@@ -431,7 +431,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_put(bio);
 
 out:
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_SWAPIO);
 	return ret;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8763705..4445c1d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3352,13 +3352,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 
 	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_RECLAIM_MEMCG);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_RECLAIM_MEMCG);
 
 	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
@@ -3568,7 +3568,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, MEMSTALL_KSWAPD);
 	__fs_reclaim_acquire();
 
 	count_vm_event(PAGEOUTRUN);
@@ -3747,7 +3747,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
 
 	snapshot_refaults(NULL, pgdat);
 	__fs_reclaim_release();
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, MEMSTALL_KSWAPD);
 	set_task_reclaim_state(current, NULL);
 
 	/*
-- 
1.8.3.1

