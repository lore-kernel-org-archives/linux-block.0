Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	kernel-team@fb.com,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] blk-iolatency: deal with small samples
Date: Mon, 10 Sep 2018 16:49:30 -0400
Message-Id: <20180910204932.14323-5-josef@toxicpanda.com>
In-Reply-To: <20180910204932.14323-1-josef@toxicpanda.com>
References: <20180910204932.14323-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

There is logic to keep cgroups that haven't done a lot of IO in the most
recent scale window from being punished for over-active higher priority
groups.  However for things like ssd's where the windows are pretty
short we'll end up with small numbers of samples, so 5% of samples will
come out to 0 if there aren't enough.  Make the floor 1 sample to keep
us from improperly bailing out of scaling down.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 4ed05d09a69e..ca545991df83 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -366,7 +366,7 @@ static void check_scale_change(struct iolatency_grp *iolat)
 		 * scale down event.
 		 */
 		samples_thresh = lat_info->nr_samples * 5;
-		samples_thresh = div64_u64(samples_thresh, 100);
+		samples_thresh = max(1ULL, div64_u64(samples_thresh, 100));
 		if (iolat->nr_samples <= samples_thresh)
 			return;
 	}
-- 
2.14.3
