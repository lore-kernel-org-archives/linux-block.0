Return-Path: <mail@maciej.szmigiero.name>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RESEND][PATCH v2] cfq: clear queue pointers from cfqg after
 unpinning them in cfq_pd_offline
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 jiufei.xue@linux.alibaba.com, Caspar Zhang <caspar@linux.alibaba.com>
Message-ID: <9ce04d22-d9ae-fe19-b0b5-52a5e8eb5ed4@maciej.szmigiero.name>
Date: Wed, 19 Sep 2018 23:58:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
List-ID: <linux-block@vger.kernel.org>

BFQ is already doing a similar thing in its .pd_offline_fn() method
implementation.

While it seems that after
commit 4c6994806f70 ("blk-throttle: fix race between blkcg_bio_issue_check() and cgroup_rmdir()")
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
index 2eb87444b157..ed41aa978c4a 100644
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
