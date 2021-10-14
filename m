Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E343DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 23:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E0160F5D
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 23:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJNXWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 19:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhJNXWa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 19:22:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A8DC061570;
        Thu, 14 Oct 2021 16:20:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so5976006pjb.0;
        Thu, 14 Oct 2021 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rLxq7jNq6GEmbWP2MEcN7fAu58gvlZAZinIDW778wxI=;
        b=ZtYdm25YI/lmChgYUUTowIlOeRHYgEfG7IK9pZryTUCSZBs/5jRozeAymZmaIs3IkI
         Ql0Y+1xUdn5CZjuMyEccOb7MQzyRzWd0pf+VuuvDuZmWoaSDKtlh+tDG9k88bWOWDeCI
         DoKvqoZ8XbCgtVySGSGRkZV8cdYABN/WgNmM5FU1cKvZNz+WuKtNSZ/6Cp/Pr/TjuLMF
         FLatbmPx1jedqni3wlshqJkApto7ZLWqjEZkcreG36QcKlhQhP1SweVfcknIxUL0Rg8u
         OMoGff/8S6CA9N48Q+mXoS/P/MHGVJ1T8iznxFEkFU7Et/Jqur9x1hjs8LLaVbTXWNUd
         zTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=rLxq7jNq6GEmbWP2MEcN7fAu58gvlZAZinIDW778wxI=;
        b=5OonleYANLxehHXmC1SBc/n6xOG0r2ur1L0xf1JOHJP06B2EgMDcR64BPGnTzgITSS
         9+veSIdB3oIxuA2uP1pwq86FboF+AFapY8XyP9/47l3MWyhHLSmFOtTr4vtikdDljcMQ
         dyeY1D93n79+Pv5PlhVyp90px5CB0XhJtFjdvcZmW1P3yQMca8d6sSAuJLvqc1QpmOhw
         4pJa5MSsWtZuYwgKMqgQ54ZxtZzle/poeKOuUyCQ1ORSfMWTCtBf9GcmjuBOr3VvOO8y
         Jy28mzOQI9c3uBxUx5/89452DAo+EwmsJh6bBsPn/7MYjm52I2s4q53WRDVg653LJgjT
         yKzw==
X-Gm-Message-State: AOAM533KZy7/zYfd6RVrhrChHXuk1YtF/UQteO0ZedYm8uC8dS1Hjc4R
        fHAi3w41rBWgsFi6976sqYE=
X-Google-Smtp-Source: ABdhPJxGMCCg1bfY6qEIk+JpZV3SSJHJcV+AubAcALdX3tkgsAvYc7sO0xMW8P6yY1ddBArlVgmSTw==
X-Received: by 2002:a17:902:9882:b0:13e:1749:daae with SMTP id s2-20020a170902988200b0013e1749daaemr7744265plp.60.1634253624504;
        Thu, 14 Oct 2021 16:20:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c11sm3465639pfm.55.2021.10.14.16.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 16:20:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Oct 2021 13:20:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH block-5.15] blk-cgroup: blk_cgroup_bio_start() should use
 irq-safe operations on blkg->iostat_cpu
Message-ID: <YWi7NrQdVlxD6J9W@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

c3df5fb57fe8 ("cgroup: rstat: fix A-A deadlock on 32bit around
u64_stats_sync") made u64_stats updates irq-safe to avoid A-A deadlocks.
Unfortunately, the conversion missed one in blk_cgroup_bio_start(). Fix it.

Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
Cc: stable@vger.kernel.org # v5.13+
Reported-by: syzbot+9738c8815b375ce482a1@syzkaller.appspotmail.com
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 31fe9be179d99..7d0509d9f4ea8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1906,10 +1906,11 @@ void blk_cgroup_bio_start(struct bio *bio)
 {
 	int rwd = blk_cgroup_io_type(bio), cpu;
 	struct blkg_iostat_set *bis;
+	unsigned long flags;
 
 	cpu = get_cpu();
 	bis = per_cpu_ptr(bio->bi_blkg->iostat_cpu, cpu);
-	u64_stats_update_begin(&bis->sync);
+	flags = u64_stats_update_begin_irqsave(&bis->sync);
 
 	/*
 	 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a split
@@ -1921,7 +1922,7 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 	bis->cur.ios[rwd]++;
 
-	u64_stats_update_end(&bis->sync);
+	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
 		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
 	put_cpu();
