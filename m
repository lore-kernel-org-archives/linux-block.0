Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Cc: Josef Bacik <jbacik@fb.com>
Subject: [PATCH 14/14] skip readahead if the cgroup is congested
Date: Tue,  3 Jul 2018 11:15:03 -0400
Message-Id: <20180703151503.2549-15-josef@toxicpanda.com>
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
References: <20180703151503.2549-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

From: Josef Bacik <jbacik@fb.com>

We noticed in testing we'd get pretty bad latency stalls under heavy
pressure because read ahead would try to do its thing while the cgroup
was under severe pressure.  If we're under this much pressure we want to
do as little IO as possible so we can still make progress on real work
if we're a throttled cgroup, so just skip readahead if our group is
under pressure.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/readahead.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index e273f0de3376..9f62b7151100 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -19,6 +19,7 @@
 #include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
+#include <linux/blk-cgroup.h>
 
 #include "internal.h"
 
@@ -505,6 +506,9 @@ void page_cache_sync_readahead(struct address_space *mapping,
 	if (!ra->ra_pages)
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* be dumb */
 	if (filp && (filp->f_mode & FMODE_RANDOM)) {
 		force_page_cache_readahead(mapping, filp, offset, req_size);
@@ -555,6 +559,9 @@ page_cache_async_readahead(struct address_space *mapping,
 	if (inode_read_congested(mapping->host))
 		return;
 
+	if (blk_cgroup_congested())
+		return;
+
 	/* do read-ahead */
 	ondemand_readahead(mapping, ra, filp, true, offset, req_size);
 }
-- 
2.14.3
