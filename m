Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE88C2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C61222C2
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgBMOM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:12:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:50358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgBMOM2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 09:12:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F28A4AE34;
        Thu, 13 Feb 2020 14:12:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 2/3] bcache: Revert "bcache: shrink btree node cache after bch_btree_check()"
Date:   Thu, 13 Feb 2020 22:12:06 +0800
Message-Id: <20200213141207.77219-3-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200213141207.77219-1-colyli@suse.de>
References: <20200213141207.77219-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 1df3877ff6a4810054237c3259d900ded4468969.

In my testing, sometimes even all the cached btree nodes are freed,
creating gc and allocator kernel threads may still fail. Finally it
turns out that kthread_run() may fail if there is pending signal for
current task. And the pending signal is sent from OOM killer which
is triggered by memory consuption in bch_btree_check().

Therefore explicitly shrinking bcache btree node here does not help,
and after the shrinker callback is improved, as well as pending signals
are ignored before creating kernel threads, now such operation is
unncessary anymore.

This patch reverts the commit 1df3877ff6a4 ("bcache: shrink btree node
cache after bch_btree_check()") because we have better improvement now.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2749daf09724..0c3c5419c52b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1917,23 +1917,6 @@ static int run_cache_set(struct cache_set *c)
 		if (bch_btree_check(c))
 			goto err;
 
-		/*
-		 * bch_btree_check() may occupy too much system memory which
-		 * has negative effects to user space application (e.g. data
-		 * base) performance. Shrink the mca cache memory proactively
-		 * here to avoid competing memory with user space workloads..
-		 */
-		if (!c->shrinker_disabled) {
-			struct shrink_control sc;
-
-			sc.gfp_mask = GFP_KERNEL;
-			sc.nr_to_scan = c->btree_cache_used * c->btree_pages;
-			/* first run to clear b->accessed tag */
-			c->shrink.scan_objects(&c->shrink, &sc);
-			/* second run to reap non-accessed nodes */
-			c->shrink.scan_objects(&c->shrink, &sc);
-		}
-
 		bch_journal_mark(c, &journal);
 		bch_initial_gc_finish(c);
 		pr_debug("btree_check() done");
-- 
2.16.4

