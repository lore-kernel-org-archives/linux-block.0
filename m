Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF7BC433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 18:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A3C613DE
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 18:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhEKS7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 14:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhEKS7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 14:59:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A25AC061574;
        Tue, 11 May 2021 11:58:07 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j11so15380541qtn.12;
        Tue, 11 May 2021 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qrWx6sjrboqnBhgfkwaqiWCcjg2j1hn+sj/P7ANiDEQ=;
        b=VhaL9ar4vHEFuRBodILW3Z9252xy4gbmzIwc5+HQoTYuHxHQZb8Tn86ySjUQWcfTxv
         Jda1GCta3+RuqdKYgAza3hJzciwKLDHDLiAljKpc+FTQs5jKkIjpw3kMb8hWoav3DiJb
         XKZdQ+XwerqLOCodGauVENdP1vynUmFtGMmJuemOZh0Wu7lhPvAfctk85ne+P/WaclIA
         vvMR/MlsRNbyQAJC2dAQQgzjMtvZ8Wqh4y4H/N8xg8TqQqjTYs4ffY6thjYD90bqtEDe
         p8WGQK1GMS7/15GSHhBcVyipZFVOXunx6rkvi/k0fAqguQEX3AQoHI/eeNFxbpG3j+6D
         +v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=qrWx6sjrboqnBhgfkwaqiWCcjg2j1hn+sj/P7ANiDEQ=;
        b=M+Uij2Wk01fyA1bBzX4h98LFEu0Y4pse09HCAlwCb+tc4Za2dinHAldoI6OT9+LmOX
         kptKfTTqB3khvE3N1ZuNgTC8jTGdbRXMapn/sEGmshng59M4LqZQWzIs/7b2jvlH3euv
         HyXyd82TPAZwRHcqjPuyNeMG8SYiIJU+3X1QnEZKppcm9iKkhfgGNEMUZ9ekP9b4KdUH
         FxXcBk6f9+/TavD66b3oCUSB/iFVpWLvuW0uOIHnf0n6pciXTa987dHONoM/odVN+JaR
         F0dsyOyB/wh7q/sYgFhynJCYSWV4mLZhLRpvX/b1U4UUGxcZ9k1MAzi9O1PODahQ3lYo
         EaCQ==
X-Gm-Message-State: AOAM531QCD+R69FmQo9JION9AEvMD8KMd1JBgfYdcovseaqk+Rgfb0mT
        6ClUuzBdooGF9C2btnT8iLo=
X-Google-Smtp-Source: ABdhPJwePo0OHjxAzMWLKGdycYB9j73g7VcAfncP+Rr1cPoLt7oRcMwOt41qSK4oGjQrfRSPt00sVw==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr9317315qtx.145.1620759486475;
        Tue, 11 May 2021 11:58:06 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id b188sm14479099qkc.11.2021.05.11.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:58:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 May 2021 14:58:04 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-5.14/block] blkcg: drop CLONE_IO check in
 blkcg_can_attach()
Message-ID: <YJrTvHbrRDbJjw+S@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blkcg has always rejected to attach if any of the member tasks has shared
io_context. The rationale was that io_contexts can be shared across
different cgroups making it impossible to define what the appropriate
control behavior should be. However, this check causes more problems than it
solves:

* The check prevents controller enable and migrations but not CLONE_IO
  itself, which can lead to surprises as the outcome changes depending on
  the order of operations.

* Sharing within a cgroup is fine but the check can't distinguish that. This
  leads to unnecessary conflicts with the recent CLONE_IO usage in io_uring.

io_context sharing doesn't make any difference for rq_qos based controllers
and the way it's used is safe as long as tasks aren't migrated dynamically
which is the vast majority of use cases. While we can try to make the check
more precise to avoid false positives, the added complexity doesn't seem
worthwhile. Let's just drop blkcg_can_attach().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 582d2f18717ee..d169e20551588 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1217,32 +1217,6 @@ void blkcg_exit_queue(struct request_queue *q)
 	blk_throtl_exit(q);
 }
 
-/*
- * We cannot support shared io contexts, as we have no mean to support
- * two tasks with the same ioc in two different groups without major rework
- * of the main cic data structures.  For now we allow a task to change
- * its cgroup only if it's the only owner of its ioc.
- */
-static int blkcg_can_attach(struct cgroup_taskset *tset)
-{
-	struct task_struct *task;
-	struct cgroup_subsys_state *dst_css;
-	struct io_context *ioc;
-	int ret = 0;
-
-	/* task_lock() is needed to avoid races with exit_io_context() */
-	cgroup_taskset_for_each(task, dst_css, tset) {
-		task_lock(task);
-		ioc = task->io_context;
-		if (ioc && atomic_read(&ioc->nr_tasks) > 1)
-			ret = -EINVAL;
-		task_unlock(task);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
 {
 	int i;
@@ -1275,7 +1249,6 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.css_online = blkcg_css_online,
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
-	.can_attach = blkcg_can_attach,
 	.css_rstat_flush = blkcg_rstat_flush,
 	.bind = blkcg_bind,
 	.dfl_cftypes = blkcg_files,
