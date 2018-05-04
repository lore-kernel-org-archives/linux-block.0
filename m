Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
To: axboe@kernel.dk, jack@suse.cz
Cc: linux-block@vger.kernel.org
Subject: [PATCH] loop: remember whether sysfs_create_group() succeeded
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <001a113ed2fa7bedfe055c8316a5@google.com>
	<94eb2c030882b2b1b505610813df@google.com>
	<55ff5960-eaab-5a36-5605-4e2230b77607@I-love.SAKURA.ne.jp>
	<20180502142434.GA10928@kroah.com>
In-Reply-To: <20180502142434.GA10928@kroah.com>
Message-Id: <201805042047.EFJ26068.OtOJFSLFFQOVHM@I-love.SAKURA.ne.jp>
Date: Fri, 4 May 2018 20:47:29 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

>>From 626d33de1b70b11ecaf95a9f83f7644998e54cbb Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 2 May 2018 23:03:48 +0900
Subject: [PATCH] loop: remember whether sysfs_create_group() succeeded

syzbot is hitting WARN() triggered by memory allocation fault
injection [1] because loop module is calling sysfs_remove_group()
when sysfs_create_group() failed.
Fix this by remembering whether sysfs_create_group() succeeded.

[1] https://syzkaller.appspot.com/bug?id=3f86c0edf75c86d2633aeb9dd69eccc70bc7e90b

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+9f03168400f56df89dbc6f1751f4458fe739ff29@syzkaller.appspotmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c | 11 ++++++-----
 drivers/block/loop.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5d4e316..1d758d8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -809,16 +809,17 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 	.attrs= loop_attrs,
 };
 
-static int loop_sysfs_init(struct loop_device *lo)
+static void loop_sysfs_init(struct loop_device *lo)
 {
-	return sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
-				  &loop_attribute_group);
+	lo->sysfs_ready = !sysfs_create_group(&disk_to_dev(lo->lo_disk)->kobj,
+					      &loop_attribute_group);
 }
 
 static void loop_sysfs_exit(struct loop_device *lo)
 {
-	sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
-			   &loop_attribute_group);
+	if (lo->sysfs_ready)
+		sysfs_remove_group(&disk_to_dev(lo->lo_disk)->kobj,
+				   &loop_attribute_group);
 }
 
 static void loop_config_discard(struct loop_device *lo)
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index b78de98..73c801f 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -58,6 +58,7 @@ struct loop_device {
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;
+	bool			sysfs_ready;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
-- 
1.8.3.1
