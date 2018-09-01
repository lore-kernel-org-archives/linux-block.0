Return-Path: <yangx.jy@cn.fujitsu.com>
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
To: <axboe@kernel.dk>, <joseph.qi@linux.alibaba.com>, <bart.vanassche@wdc.com>
CC: <jack@suse.com>, <linux-block@vger.kernel.org>, Xiao Yang
	<yangx.jy@cn.fujitsu.com>
Subject: [PATCH] block/elevator: Avoid a NULL pointer dereference in kobject_uevent()
Date: Sat, 1 Sep 2018 17:06:07 +0800
Message-ID: <1535792767-20364-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Since commit a063057d7c73 ("block: Fix a race between request queue
removal and the block cgroup controller"), q->elevator will be set
to NULL in blk_cleanup_queue() so that calling blk_cleanup_queue()
and del_gendisk() in the order may trigger a NULL pointer dereference
in kobject_uevent() because del_gendisk() will call the released
q->elevator again by elv_unregister_queue() in some cases.

See the following Call Trace:
[  423.693305] Call Trace:
...
[  423.693317]  [<ffffffffb057652b>] kobject_uevent+0xb/0x10
[  423.693321]  [<ffffffffb053a266>] elv_unregister_queue+0x26/0x40
[  423.693324]  [<ffffffffb05459d8>] blk_unregister_queue+0xd8/0x130
[  423.693327]  [<ffffffffb0556e09>] del_gendisk+0x139/0x2a0

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 block/elevator.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 6a06b5d..2c88076 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -863,11 +863,13 @@ void elv_unregister_queue(struct request_queue *q)
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q) {
-		struct elevator_queue *e = q->elevator;
+		if (q->elevator) {
+			struct elevator_queue *e = q->elevator;
 
-		kobject_uevent(&e->kobj, KOBJ_REMOVE);
-		kobject_del(&e->kobj);
-		e->registered = 0;
+			kobject_uevent(&e->kobj, KOBJ_REMOVE);
+			kobject_del(&e->kobj);
+			e->registered = 0;
+		}
 		/* Re-enable throttling in case elevator disabled it */
 		wbt_enable_default(q);
 	}
-- 
1.8.3.1
