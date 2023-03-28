Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4027DC76195
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjC1GR5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 02:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjC1GRZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 02:17:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62773AB3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:56 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b8-20020a17090a488800b0023d1bf65c7eso2972520pjh.3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 23:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679984216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IFy8THM3GBUAgd4d/GEKRMIpmDkqCRA5AxR/3TFCM=;
        b=BGZjnL6U27C3nu3nfjJxe/VV851RC/VP1GsLD606AgPd6FshXe6WNQk0I659Owa2wU
         gVJoC9Crt60CfuYM+ql+MgbEx44waD/ankuLiQjCR+6oc5mr8Ex9gHFcY/MTbuN2MESv
         WG+o2vmHU2skqPZDZWhEEvumwbMUFH8XB/2P7lCWIxY9j69P+XyQb7YmlC5lJf3dl83N
         R/+G9MzJdyv2aInyc3KBZTsCKswAeBzT3OW0sicqNfQnZRl6LhPxfTDtAjqxejZWrmX4
         kekpZffHaXAsR+R6/xnXuXgj0ngR8GdA98eO9lk+Gv9Mx4rtmu3ZFp7UhRacTBWLo1ks
         cDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7IFy8THM3GBUAgd4d/GEKRMIpmDkqCRA5AxR/3TFCM=;
        b=KfZuFCDDctNokE6cJHFN7xDwwyZAdnzZvLVDqzx3uhvlbu9LHNwSdUs5JAKLQ9BggH
         Ohb/Srbl+1Efphe0bG/dqQwYkagffuKvvLQvH5apuvZVgV+UdU1Lz+2qoYLykcPKuqiD
         qcMlxhFQlRhOoWTRm4bZMVpcfUXgqjFD3EN82xQ61PO419zDbWazdUBQOKwHEnuhTUYf
         bDB7o0AfBkdJR2eiRMwePBWGZnsz24SnCKqBL2nhKPIxcgw/2x98H8hb7THhdmcqopQE
         xtcvXuh24GfZYzwcv9HH2qi2N/OVJ1/8EfA69MD1X0Dfd/TooiNR7twNd335rCQzD026
         dDpA==
X-Gm-Message-State: AAQBX9cW1oWRaeqaM7lVgubnUb0MpBu1tsYVcOc2W1Y4h/9icJZoI0hs
        6eg+quHSZrZrK4rAAyn9mspQYPXZ0T6l9Jkl
X-Google-Smtp-Source: AKy350ZXKLWX99WV75Zn5bhPto8WUfX5S0Ha1cMIMK8Z1sFTdLjrJB9JMxzEwgWixGxokt8xM3tEMiwbJzx2bThN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:c49:0:b0:502:fd71:d58c with SMTP id
 9-20020a630c49000000b00502fd71d58cmr3919025pgm.9.1679984216134; Mon, 27 Mar
 2023 23:16:56 -0700 (PDT)
Date:   Tue, 28 Mar 2023 06:16:37 +0000
In-Reply-To: <20230328061638.203420-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328061638.203420-9-yosryahmed@google.com>
Subject: [PATCH v1 8/9] vmscan: memcg: sleep when flushing stats during reclaim
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

Memory reclaim is a sleepable context. Allow sleeping when flushing
memcg stats to avoid unnecessarily performing a lot of work without
sleeping. This can slow down reclaim code if flushing stats is taking
too long, but there is already multiple cond_resched()'s in reclaim
code.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
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

