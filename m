Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75041C761A6
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 22:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjC1WRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjC1WRN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D02D52
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z31-20020a25a122000000b00b38d2b9a2e9so13339305ybh.3
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQQVGwjs4PjltBBm07Wln67ACtAz9IV2/pUsgTkN4l8=;
        b=BwpN5IENfDJAO3k0fvlZBkjsW+/4dRHFvKU3Y61vx7dQ2RtgMRwRfqyo0DTmjCAyVc
         CnLkW84f17NTLqbLQGhvt1qFEPE3lJHVmINhnviNxj716C70wOSUz3DOzWHSZ0RhU5XN
         r07qEoT8pGKoQFAOapju4r5aUWkkVs0eQmIgIci7KEjffCx1HyDeGdNPdwdlAJbu1aOk
         7WwXMQu8pO8A54UInZRnQw9kbNQZxf/x1jM4losJCUKwsJkxT/8pf/ZH8ftd03KJhEdg
         XtPwGtxKxPzrVZOjpFL3fFaXSbnVLYOlrmJD9NS/UpXXC6msV74XQ/lannH6QIJ1sQ32
         hXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQQVGwjs4PjltBBm07Wln67ACtAz9IV2/pUsgTkN4l8=;
        b=N4nWsAO1qNt7wzF+nQqDSY4w7jXwfKrO9Ko9QTumtWMMTNcl6PnVQA1dHM/8FdXMUw
         N/oaNwGL1IR4CKcuYC5FHh0aXdWlqiIMlAIiYOOqYkRIDDogKeEDTHUANJRd8AltVfA5
         KoSXR4vZoisUmVJr2wUKAa67vVkwGCNUXD9ZsX1Jnzcb25ia21YW82QzROSNNYm2xUx3
         fksu7OzxABtby4gn/rOkER710B5brFPsKXJ6FE6yfQr+4z+m640C9IbQYR4WLxt67YiT
         dje3RzGSWZcsKL1IdVAv1i+KmEBWiugsDKut+Nk1RQvheko+m5ty0ARqkd8iqYfGhYAL
         jaqg==
X-Gm-Message-State: AAQBX9fQ5aFwnpOlOYv7w2hQqqAAwzqlcvaJqxWPyOlA+J3TL9cMkwBg
        rXjTdtCDzpeJP64GUlHT/MiITmhGs0V6jzeW
X-Google-Smtp-Source: AKy350a+cGo/rQiavcF9zU9F0niI9qIhWFxPTrQKaAQYONdIyzIaIiEtY9m/Hx7sNG18TtPt6miuAFUHkt3sB0SU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1003:b0:b1d:5061:98e3 with
 SMTP id w3-20020a056902100300b00b1d506198e3mr11533410ybt.6.1680041818092;
 Tue, 28 Mar 2023 15:16:58 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:39 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-5-yosryahmed@google.com>
Subject: [PATCH v2 4/9] cgroup: rstat: add WARN_ON_ONCE() if flushing outside
 task context
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

rstat flushing is too expensive to perform in irq context.
The previous patch removed the only context that may invoke an rstat
flush from irq context, add a WARN_ON_ONCE() to detect future
violations, or those that we are not aware of.

Ideally, we wouldn't flush with irqs disabled either, but we have one
context today that does so in mem_cgroup_usage(). Forbid callers from
irq context for now, and hopefully we can also forbid callers with irqs
disabled in the future when we can get rid of this callsite.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/rstat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index d3252b0416b6..c2571939139f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -176,6 +176,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 {
 	int cpu;
 
+	/* rstat flushing is too expensive for irq context */
+	WARN_ON_ONCE(!in_task());
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-- 
2.40.0.348.gf938b09366-goog

