Return-Path: <linux-block-owner@vger.kernel.org>
Received: from vps-vb.mhejs.net ([37.28.154.113]:52092 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeJKEk5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 00:40:57 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RESEND][PATCH v2] cfq: clear queue pointers from cfqg after
 unpinning them in cfq_pd_offline
To: Jens Axboe <axboe@kernel.dk>
Cc: Caspar Zhang <caspar@linux.alibaba.com>,
        jiufei.xue@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Message-ID: <befb45da-2a7b-8dff-30e7-59b441f604fe@maciej.szmigiero.name>
Date: Wed, 10 Oct 2018 23:16:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BFQ is already doing a similar thing in its .pd_offline_fn() method
implementation.

While it seems that after commit 4c6994806f70
("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
was reverted leaving these pointers intact no longer causes crashes
clearing them is still a sensible thing to do to make the code more robust.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: Drop stable and fixes tags, rewrite the commit message
as after commit 4c6994806f70 was reverted this change is no longer
required to fix a crash.

 block/cfq-iosched.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index d219e9a1af65..6a3d87dd3c1a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1644,14 +1644,20 @@ static void cfq_pd_offline(struct blkg_policy_data *pd)
 	int i;
 
 	for (i = 0; i < IOPRIO_BE_NR; i++) {
-		if (cfqg->async_cfqq[0][i])
+		if (cfqg->async_cfqq[0][i]) {
 			cfq_put_queue(cfqg->async_cfqq[0][i]);
-		if (cfqg->async_cfqq[1][i])
+			cfqg->async_cfqq[0][i] = NULL;
+		}
+		if (cfqg->async_cfqq[1][i]) {
 			cfq_put_queue(cfqg->async_cfqq[1][i]);
+			cfqg->async_cfqq[1][i] = NULL;
+		}
 	}
 
-	if (cfqg->async_idle_cfqq)
+	if (cfqg->async_idle_cfqq) {
 		cfq_put_queue(cfqg->async_idle_cfqq);
+		cfqg->async_idle_cfqq = NULL;
+	}
 
 	/*
 	 * @blkg is going offline and will be ignored by
-- 
2.17.0
