Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5203C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjC3TSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjC3TSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D80E38D
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:18:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so19626569ybp.6
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd9n7cK9XN/T+IJ39MyPXAm65DzgHuyZCFnDGQgZIE=;
        b=tY0E3oybgVZIuKKOOKBykm8/TKbf2scexLJVT3DkzJcaMo8pgAVQKd31VkYqY1QVPJ
         mHo+yh2Z2e/UWhIAS6NyKjgzsMFfM3Q7bRmRT9xetX5hDAZEg0lz49jvXxYxOEOA0GHz
         2iOR7gvTKjdYv9QT9UofKbbkFs9vSWVQ0TKS3904q473sNNcjSfvya1m1B2ab+CL/f+M
         4qtYTT2pypw3Co5Bobg3nKNc5an7wdNYyXFt6rny9eUWrmoVflUhZJQGBV9r+u9oNXbf
         thlMA7X4kUIdycQp/zBF4S4OoaK6pqFmZjXA4rakf85jUKtTz9rXXIDv36itoKwLwzmv
         vt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECd9n7cK9XN/T+IJ39MyPXAm65DzgHuyZCFnDGQgZIE=;
        b=BsKAasW/HkjCAJ93cQ/1FYmBi8Iolsr+mkh04kT9sQXPz+SsiCKljpn+uLpnkf6u4B
         QFl4a6L4F+m/EksMeHX5vIeAfQnL7+LJycrlaICizumbZYvMhnFtKAV43Ttyfhq3FOP/
         6EzYX/fF+N/4wFWbjXCVzbzLWcfqg1LzcvWlDMLl9olIesPeAHi9BCt7kqmiFJpkIU9s
         RtSYBVYLwQS1POhB5ydlP+o35SeLc5GAggBoHJLfkPH7lgknSzimiO4/DCyWi6sAJaWC
         yzryG9nfG16z+yYTnx8jy4iG/y78qqs2mMRCeVmjC1ItFnjEiMh0cBu9GBOFaL/yqcbT
         8ihg==
X-Gm-Message-State: AAQBX9fuAOnBomuex18BehJA34AqYGI8Qc3qBI2JVp2qLaPY8HLadSdO
        aAzgjGgWzS73s+W7NPdhPHaDy8o8mBtPj95t
X-Google-Smtp-Source: AKy350aEWgmUGoq47vtgVPSLObUE1OHXFIc1JYGvZjZHSdRsfuGe4z8jTEoHLVbNJzm7tfhcDcAxLa1st977h/QM
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:d1d8:0:b0:b6d:fc53:c5c0 with SMTP
 id i207-20020a25d1d8000000b00b6dfc53c5c0mr4650822ybg.1.1680203885608; Thu, 30
 Mar 2023 12:18:05 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:54 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-2-yosryahmed@google.com>
Subject: [PATCH v3 1/8] cgroup: rename cgroup_rstat_flush_"irqsafe" to "atomic"
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

cgroup_rstat_flush_irqsafe() can be a confusing name. It may read as
"irqs are disabled throughout", which is what the current implementation
does (currently under discussion [1]), but is not the intention. The
intention is that this function is safe to call from atomic contexts.
Name it as such.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/cgroup.h | 2 +-
 kernel/cgroup/rstat.c  | 4 ++--
 mm/memcontrol.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3410aecffdb4..885f5395fcd0 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -692,7 +692,7 @@ static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
  */
 void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
+void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(void);
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 831f1f472bb8..d3252b0416b6 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -241,12 +241,12 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 }
 
 /**
- * cgroup_rstat_flush_irqsafe - irqsafe version of cgroup_rstat_flush()
+ * cgroup_rstat_flush_atomic- atomic version of cgroup_rstat_flush()
  * @cgrp: target cgroup
  *
  * This function can be called from any context.
  */
-void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp)
+void cgroup_rstat_flush_atomic(struct cgroup *cgrp)
 {
 	unsigned long flags;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..0205e58ea430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -642,7 +642,7 @@ static void __mem_cgroup_flush_stats(void)
 		return;
 
 	flush_next_time = jiffies_64 + 2*FLUSH_TIME;
-	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
 	atomic_set(&stats_flush_threshold, 0);
 	spin_unlock_irqrestore(&stats_flush_lock, flag);
 }
-- 
2.40.0.348.gf938b09366-goog

