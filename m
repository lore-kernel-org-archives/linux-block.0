Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA8C761A6
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 19:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjC3TTG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjC3TS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 15:18:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A010429
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:18:17 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id kp6-20020a170903280600b001a2945a7fdeso775661plb.18
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUaqJ6BFfuwa7nRJSvBlAwhhxeRf5mk+29EPOCHz/Q=;
        b=ltNePRXuZIePvYweAMHUj9ZiAeC5qavTrptvs7HWUZy4ZQjHtls0D9eRHEg0pqkaqA
         2rj8RSL+AK/a3iTAV1slsfA/XO8i87DoFdpL6M03j+wstTxD0gNLM1Eo1e2c6UpyLkfA
         02M3+F6NXEWgNHJDDpxLzGC2sGDBHCNs+LO2yZgTc79ihpz2oe9Gkrj2oQSZRb8nP/pk
         DTjpgFJ4LNEzmr5tCkDpR0cOQrENPev1JFpwtylRIUOchlXAi5bgsrxJgKXBgxobydtr
         bGBrN9gUtdaDKVSRv2j9cJxRBN0C3BLXf8CobNS0sZxfbCzcE+BakwfvTig0jcnVMYxC
         dA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203896;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcUaqJ6BFfuwa7nRJSvBlAwhhxeRf5mk+29EPOCHz/Q=;
        b=7Zw256l7Ij15lRxObxRe1nTjISkSv28rBqjPzBy+ij0L9wNQdaWgVYgdYEIG7W1SEo
         3UEFoHvTMYNNKhfKuBOc6IGAXIT1XIuagjyzon6ns6VWRx5r+ZbC3k4V6eAgfdFW1uq3
         0IZ+ByHyWTFW9smM6bE138hD/HuEr63nA8hYwIwqklXAt0pPobLPOwXX27tIvpz6pcQT
         507suc9iymhDbB2V4aE3BFuUSRN41r/M9bBOnTYszfdD+UkCitA49oaLnejHFnr/rWw0
         VfTVy7MhHui4ZqYrdPtsfI6R3/2LU6+PpcLE6Guq3/gvCejiAbIXs58Cm2jL+jbQYZxP
         Z0cw==
X-Gm-Message-State: AAQBX9dDMUiT4jRDEDSvhJnPW+r6EE3Cxy7KiEmcoEuXU2bH/1Hu/O7O
        16YIyA5sMiF0DZ2Y1ZXw8clawwYHUD/vnPeK
X-Google-Smtp-Source: AKy350bGhjPkePduCVIwuMcmgqQ6a76256SvlUw7LUz9ChuwvjB5lA7RHnWs+sTxxUB3GpOtDLTlb1QCGdSZixrZ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:40c1:0:b0:4fd:5105:eb93 with SMTP
 id n184-20020a6340c1000000b004fd5105eb93mr6667473pga.3.1680203896567; Thu, 30
 Mar 2023 12:18:16 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:18:00 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-8-yosryahmed@google.com>
Subject: [PATCH v3 7/8] vmscan: memcg: sleep when flushing stats during reclaim
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
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Memory reclaim is a sleepable context. Flushing is an expensive
operaiton that scales with the number of cpus and the number of cgroups
in the system, so avoid doing it atomically unnecessarily.
This can slow down reclaim code if flushing stats is taking too long,
but there is already multiple cond_resched()'s in reclaim code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a9511ccb936f..9c1c5e8b24b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
-- 
2.40.0.348.gf938b09366-goog

