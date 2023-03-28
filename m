Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DAC77B60
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 06:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjC1GRL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjC1GRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84253A85
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b16-20020a17090a991000b0023f803081beso2939299pjp.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wILXj9LqWwom+6PQC1+rRSpOfUrkR+GzdkCDGSSBhGY=;
        b=sq4WxgrXs35T1kNaqttQxLQHBBfHPzw9iKcGHtZRmWn7KoDZlSxKdNufMOgLyKUFr+
         TMiE/wqtjNlMTixUEQeY/Vrw6MeR14OOP90t7VeDCccykNrGNGWLRshNs7Tr5dzPpQxM
         EqNAZipGy1I27uXZW4pV5ZH3WWGxC9s0suXWrK0/Qi+Fx4TfEA0shsUjup5r4I0T4jcO
         otnYwmVT7RvIIuwqMJTULG/AsEi9P5/3lltCZIuxMi9242jZnrgGHko3vAN7pXgBxOSv
         6bmFPpVjK2j81kXxaYSwcWty18LJNFnzIpVeFZG9+e6GZQd6MIhYJNlu+ckzRRvaCz8L
         Rlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wILXj9LqWwom+6PQC1+rRSpOfUrkR+GzdkCDGSSBhGY=;
        b=SURsZkIetGXaZBRsXTvD5QXg4R6KZhZL+d5E0w4gN2bz5dvS7T+PNJyusNSjCvjgRv
         7ASxyECIQYSPkcuJV5kLV+mDuijcQ5Fg2uoRRaIGWa3p/VYNk8H8FwCfvnX785Y1reM/
         2bQYZxPnxS4WAv65+wU8yYp1cK4AXk5UwcNIYDJ8z6BQhYJopfzsu8srGPSnlG/nL7eg
         dyw+8Xw1tm3VJBsCqOXSPvD1EOFfNX6FDiyx5U9Yyrd6/bU+6VpWvoiL3Dy0rdIgiYPi
         A6e4ogq58ePiMxdtduKsfM8wpzYUMXpjQm0R4WW8nBShtcIv4s8qbZ7R9pxpvdy0Kjdi
         AWGw==
X-Gm-Message-State: AO0yUKU98ki+dbCYNbhxt1usDZ2+LKRAO2qmk14e+tASOyQ/G3e4gDaI
        rI7VpjFrKbvH81Oi/ZA21thSnfAEvKFj01L0
X-Google-Smtp-Source: AK7set/NXJ9x9Sdrim9yKl61I9Pd5pvCD8XFm/ZA+2N5HaWD82pwRjDqKXOdg8RZFiQsg1c0bhIGvLI1ByyxVbFu
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:4510:b0:626:1710:9b7d with
 SMTP id cw16-20020a056a00451000b0062617109b7dmr8924786pfb.0.1679984207461;
 Mon, 27 Mar 2023 23:16:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:32 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-4-yosryahmed@google.com>
Subject: [PATCH v1 3/9] memcg: do not flush stats in irq context
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

Currently, the only context in which we can invoke an rstat flush from
irq context is through mem_cgroup_usage() on the root memcg when called
from memcg_check_events(). An rstat flush is an expensive operation that
should not be done in irq context, so do not flush stats and use the
stale stats in this case.

Arguably, usage threshold events are not reliable on the root memcg
anyway since its usage is ill-defined.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3b6aae78901..ff39f78f962e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3669,7 +3669,21 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 	unsigned long val;
 
 	if (mem_cgroup_is_root(memcg)) {
-		mem_cgroup_flush_stats();
+		/*
+		 * We can reach here from irq context through:
+		 * uncharge_batch()
+		 * |--memcg_check_events()
+		 *    |--mem_cgroup_threshold()
+		 *       |--__mem_cgroup_threshold()
+		 *          |--mem_cgroup_usage
+		 *
+		 * rstat flushing is an expensive operation that should not be
+		 * done from irq context; use stale stats in this case.
+		 * Arguably, usage threshold events are not reliable on the root
+		 * memcg anyway since its usage is ill-defined.
+		 */
+		if (in_task())
+			mem_cgroup_flush_stats();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
-- 
2.40.0.348.gf938b09366-goog

