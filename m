Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 2/2] blk-iolatency: truncate our current time
Date: Mon, 16 Jul 2018 12:12:23 -0400
Message-Id: <20180716161223.21486-2-josef@toxicpanda.com>
In-Reply-To: <20180716161223.21486-1-josef@toxicpanda.com>
References: <20180716161223.21486-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

In our longer tests we noticed that some boxes would degrade to the
point of uselessness.  This is because we truncate the current time when
saving it in our bio, but I was using the raw current time to subtract
from.  So once the box had been up a certain amount of time it would
appear as if our IO's were taking several years to complete.  Fix this
by truncating the current time so it matches the issue time.  Verified
this worked by running with this patch for a week on our test tier.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/blk-iolatency.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 893f888eebb1..bb59b2929e0d 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -425,6 +425,12 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	u64 start = bio_issue_time(issue);
 	u64 req_time;
 
+	/*
+	 * Have to do this so we are truncated to the correct time that our
+	 * issue is truncated to.
+	 */
+	now = __bio_issue_time(now);
+
 	if (now <= start)
 		return;
 
-- 
2.14.3
