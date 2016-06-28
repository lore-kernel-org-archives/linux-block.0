Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] cfq-iosched: Charge at least 1 jiffie instead of 1 ns
Date: Tue, 28 Jun 2016 09:04:02 +0200
Message-Id: <1467097442-5400-5-git-send-email-jack@suse.cz>
In-Reply-To: <1467097442-5400-1-git-send-email-jack@suse.cz>
References: <1467097442-5400-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Commit 9a7f38c42c2b (cfq-iosched: Convert from jiffies to nanoseconds)
could result in charging just 1 ns to a cgroup submitting IO instead of 1
jiffie we always charged before. It is arguable what is the right amount
to change but for now lets retain the old behavior of always charging at
least one jiffie.

Fixes: 9a7f38c42c2b92391d9dabaf9f51df7cfe5608e4
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/cfq-iosched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index e074dd4f1384..81accf9c4eaf 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1455,7 +1455,8 @@ static inline u64 cfq_cfqq_slice_usage(struct cfq_queue *cfqq,
 		 * a single request on seeky media and cause lots of seek time
 		 * and group will never know it.
 		 */
-		slice_used = max_t(u64, (now - cfqq->dispatch_start), 1);
+		slice_used = max_t(u64, (now - cfqq->dispatch_start),
+					jiffies_to_nsecs(1));
 	} else {
 		slice_used = now - cfqq->slice_start;
 		if (slice_used > cfqq->allocated_slice) {
-- 
2.6.6
