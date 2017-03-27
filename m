Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 05/18] blk-throttle: configure bps/iops limit for cgroup in low limit
Date: Mon, 27 Mar 2017 10:51:33 -0700
Message-ID: <feb5f99c4fa6f0f561a5a41de7909fdb475f5323.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

each queue will have a state machine. Initially queue is in LIMIT_LOW
state, which means all cgroups will be throttled according to their low
limit. After all cgroups with low limit cross the limit, the queue state
gets upgraded to LIMIT_MAX state.
For max limit, cgroup will use the limit configured by user.
For low limit, cgroup will use the minimal value between low limit and
max limit configured by user. If the minimal value is 0, which means the
cgroup doesn't configure low limit, we will use max limit to throttle
the cgroup and the cgroup is ready to upgrade to LIMIT_MAX

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b7b69ec..1fade50 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -212,12 +212,28 @@ static struct throtl_data *sq_to_td(struct throtl_service_queue *sq)
 
 static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->bps[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	uint64_t ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return U64_MAX;
+	ret = tg->bps[rw][tg->td->limit_index];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
+		return tg->bps[rw][LIMIT_MAX];
+	return ret;
 }
 
 static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 {
-	return tg->iops[rw][tg->td->limit_index];
+	struct blkcg_gq *blkg = tg_to_blkg(tg);
+	unsigned int ret;
+
+	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
+		return UINT_MAX;
+	ret = tg->iops[rw][tg->td->limit_index];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
+		return tg->iops[rw][LIMIT_MAX];
+	return ret;
 }
 
 /**
-- 
2.9.3
