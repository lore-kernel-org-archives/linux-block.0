Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFDAC76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjC1GSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjC1GRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:39 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06513C02
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:58 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c2-20020a62f842000000b0062d93664ad5so1294109pfm.19
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8wz9BoJKucmcMBXvIGPOuITeThi///HtllaZbgtCo=;
        b=G3C3U8FV5xO4vsplclhU9+4PkBH686vIIIrQFFquICu8//oGn5xL/Tmt4VNVE1HnMt
         hORJK4mB81itHhGs1+plTWPpHn6PXb4UvAXp2In5M38sRtIYXUydb86gW9UCcwU8NUMK
         AKSJULzbSmJ/Zh8xR8z20CA4EuuFhupmK6yUb7XM0dWX+orGZyC4roBLz+bFSVl/SrGz
         jDFcau8INkey+e5jkuXnym7vXagjhy1slym0NeO+iUEtBeJGIjBlnt29eYQhaZCdCsb9
         TItPIolnMlslNIl39r9v4yrb91hLywelng+1GUeMlXmGbk+u0V1YHrp34uG87/cMCuf4
         DKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy8wz9BoJKucmcMBXvIGPOuITeThi///HtllaZbgtCo=;
        b=zY7eKo2qrGQCVC3SdoBicstkJiAFztCJo1cRPF5p6olgaQJghkRfrji1zxes4+p2xr
         mtzB6m86bQ+WINi8Sg3H2NpoW0tS4qq2JoD9BFENkVrQ4jFuZIiKdJmaZ+Ima7TXdlsc
         ywqqsbsIUDyezRzLjkrDOhqOTTLi3Mj3YsgGKJv4ZEO+v+pXqxi4wKFozPw4wd4WZBy0
         gCTGh14xZdt7kQq6gDabmj6r+lT2h0xIO2+q6B31+qAzqGDiEZmusx3MOv8YcbN/4U22
         1/Dzr8WLptx5yU7v74sI5PT7gv4Xvsrl2pxm51ENrTzt3kTIqe9ypc0Mgmzc4eYsc3ST
         6ixA==
X-Gm-Message-State: AAQBX9cznU2OBMQKNDHpv/uUFuegn3posSBHOXAgRW9ZF/R9dOAyp1qZ
        b6XFMu+O9POyAiLUMjnpY0twTB7knitaVjyS
X-Google-Smtp-Source: AKy350aVn7i51pwbUpBHdDCfopSzB0y7+YNrEoZI1+8jV5mnjDSATrQRcelVSU3ikfIyno7DP54WO5q/0DmrmRgv
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:1781:b0:593:fcfb:208b with
 SMTP id s1-20020a056a00178100b00593fcfb208bmr7364360pfg.3.1679984218020; Mon,
 27 Mar 2023 23:16:58 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:38 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-10-yosryahmed@google.com>
Subject: [PATCH v1 9/9] memcg: do not modify rstat tree for zero updates
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

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0c0e74188e90..828e670e721a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -618,6 +618,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
+	if (!val)
+		return;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
-- 
2.40.0.348.gf938b09366-goog

