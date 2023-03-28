Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BBC76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 22:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjC1WRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjC1WRP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990030C2
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:17:00 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so8199975plh.8
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PicCaNLBAprYzcnNZKIFMVmM/pcbqkg3z9jyIWcMc+U=;
        b=h3KlqW+jIEJYTK+BpLRlcd0fDHvnJwiAwYWj6YfVTBV4VsUspeq7grO2+Nyd5Hs9eL
         i4P1tnbfhFqPfNn0TjyAIHaXO2gZSr29zn48TaONjgFqCTDEnUQ3f8yJSse0IzidGN/G
         NpCoYbM12CNmhz16TMo5PtvGfqzYl/w2IuM1QOzqxIgbpDSLm4BrT8d/pKei+Ju4GCP/
         Ogx40HCdcd1U7cHn91PPNKl9xn/1CmyhrjIjg+lC++Gh679/KOFvr1XoPNmeY+cl/pIr
         M7KlNiqZzpwmUKaPk8gBIyxokfcnZJdVNjXvvh+f/KGJuZhwnOInjtgGjgRxKbQyAU78
         gp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PicCaNLBAprYzcnNZKIFMVmM/pcbqkg3z9jyIWcMc+U=;
        b=glrFxRsfhrWUQcw03iZd17qhmFl8V/qPfyQFEomJ8QYSjPsIobB/8s8IlDFD7Z51Ax
         T3WJqa0euSt+AKCMXS8tuWRnGn5zBNPWD2wv3EpTcIGUdtn2iNZ+7Gij2Ozq+CAvRsE+
         qQbEM3Ln9LF4ARwHC7tNiEUGYJdNjRlfLnoLcDkRHAC6PYm6ydeoSuALO2PmEei3/L+j
         o1b8ewET4hpVWypuJZ1/437EELdWXOtCowfR+zZXzP7iqW7CXG0iatLl0SJP0N73Cjua
         VJvMVd3CZi+nwp2O/dRfiPKAlCGvdbv/2ELgapxNquKQt87/nUr+f2i+/E9qFPUXfIta
         Hs4g==
X-Gm-Message-State: AAQBX9cLscuDSktlWvOsCcQ9HzwyNxCj7KUEw5Mnd+7Mo/oz+pIPoGSY
        E6x+vl6WmVvEWRapnXE5hk1ahIp/PTjcFCEC
X-Google-Smtp-Source: AKy350aocwWe2yH7hemOfHMFd7M5GQ6mfc2FkU5LSUuK9d8xU2zKVz1ThP6UHoZndV91Ud7xpyV60PqDU9oxBKYZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:ce08:0:b0:50c:6cd:cace with SMTP id
 y8-20020a63ce08000000b0050c06cdcacemr4745231pgf.2.1680041819916; Tue, 28 Mar
 2023 15:16:59 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:40 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-6-yosryahmed@google.com>
Subject: [PATCH v2 5/9] memcg: replace stats_flush_lock with an atomic
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As Johannes notes in [1], stats_flush_lock is currently used to:
(a) Protect updated to stats_flush_threshold.
(b) Protect updates to flush_next_time.
(c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.

However:

1. stats_flush_threshold is already an atomic

2. flush_next_time is not atomic. The writer is locked, but the reader
   is lockless. If the reader races with a flush, you could see this:

                                        if (time_after(jiffies, flush_next_time))
        spin_trylock()
        flush_next_time = now + delay
        flush()
        spin_unlock()
                                        spin_trylock()
                                        flush_next_time = now + delay
                                        flush()
                                        spin_unlock()

   which means we already can get flushes at a higher frequency than
   FLUSH_TIME during races. But it isn't really a problem.

   The reader could also see garbled partial updates, so it needs at
   least READ_ONCE and WRITE_ONCE protection.

3. Serializing cgroup_rstat_flush() calls against the ratelimit
   factors is currently broken because of the race in 2. But the race
   is actually harmless, all we might get is the occasional earlier
   flush. If there is no delta, the flush won't do much. And if there
   is, the flush is justified.

So the lock can be removed all together. However, the lock also served
the purpose of preventing a thundering herd problem for concurrent
flushers, see [2]. Use an atomic instead to serve the purpose of
unifying concurrent flushers.

[1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
[2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ff39f78f962e..65750f8b8259 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -585,8 +585,8 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
+static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_next_time;
 
@@ -636,15 +636,19 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 static void __mem_cgroup_flush_stats(void)
 {
-	unsigned long flag;
-
-	if (!spin_trylock_irqsave(&stats_flush_lock, flag))
+	/*
+	 * We always flush the entire tree, so concurrent flushers can just
+	 * skip. This avoids a thundering herd problem on the rstat global lock
+	 * from memcg flushers (e.g. reclaim, refault, etc).
+	 */
+	if (atomic_read(&stats_flush_ongoing) ||
+	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
 
-	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
+	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
-	spin_unlock_irqrestore(&stats_flush_lock, flag);
+	atomic_set(&stats_flush_ongoing, 0);
 }
 
 void mem_cgroup_flush_stats(void)
@@ -655,7 +659,7 @@ void mem_cgroup_flush_stats(void)
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
-	if (time_after64(jiffies_64, flush_next_time))
+	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
 		mem_cgroup_flush_stats();
 }
 
-- 
2.40.0.348.gf938b09366-goog

