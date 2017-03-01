Return-Path: <houtao1@huawei.com>
From: Hou Tao <houtao1@huawei.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <jmoyer@redhat.com>, <jack@suse.cz>,
        <stable@vger.kernel.org>
Subject: [PATCH] cfq-iosched: fix the delay of cfq_group's vdisktime under iops mode
Date: Wed, 1 Mar 2017 10:07:44 +0800
Message-ID: <1488334064-34883-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

When adding a cfq_group into the cfq service tree, we use CFQ_IDLE_DELAY
as the delay of cfq_group's vdisktime if there have been other cfq_groups
already.

When cfq is under iops mode, commit 9a7f38c42c2b ("cfq-iosched: Convert
from jiffies to nanoseconds") could result in a large iops delay and
lead to an abnormal io schedule delay for the added cfq_group. To fix
it, we just need to revert to the old CFQ_IDLE_DELAY value: HZ / 5
when iops mode is enabled.

Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 block/cfq-iosched.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 1379447..fdeb70b 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1361,6 +1361,14 @@ cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
 	cfqg->vfraction = max_t(unsigned, vfr, 1);
 }
 
+static inline u64 cfq_get_cfqg_vdisktime_delay(struct cfq_data *cfqd)
+{
+	if (!iops_mode(cfqd))
+		return CFQ_IDLE_DELAY;
+	else
+		return nsecs_to_jiffies64(CFQ_IDLE_DELAY);
+}
+
 static void
 cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
 {
@@ -1380,7 +1388,8 @@ cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
 	n = rb_last(&st->rb);
 	if (n) {
 		__cfqg = rb_entry_cfqg(n);
-		cfqg->vdisktime = __cfqg->vdisktime + CFQ_IDLE_DELAY;
+		cfqg->vdisktime = __cfqg->vdisktime +
+			cfq_get_cfqg_vdisktime_delay(cfqd);
 	} else
 		cfqg->vdisktime = st->min_vdisktime;
 	cfq_group_service_tree_add(st, cfqg);
-- 
2.5.0
