Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3459AC35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 03:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456D20714
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 03:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBKDwo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:52:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727800AbgBKDwo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 22:52:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0293FC4337C545197046;
        Tue, 11 Feb 2020 11:52:42 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 11:52:33 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>
CC:     <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>, <luoshijie1@huawei.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] block: rename 'q->debugfs_dir' in blk_unregister_queue()
Date:   Tue, 11 Feb 2020 11:51:37 +0800
Message-ID: <20200211035137.19454-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting use after free bug in debugfs_remove[1].

This is because in request_queue, 'q->debugfs_dir' and
'q->blk_trace->dir' could be the same dir. And in __blk_release_queue(),
blk_mq_debugfs_unregister() will remove everything inside the dir.

With futher investigation of the reporduce repro, the problem can be
reporduced by following procedure:

1. LOOP_CTL_ADD, create a request_queue q1, blk_mq_debugfs_register() will
create the dir.
2. LOOP_CTL_REMOVE, blk_release_queue() will add q1 to release queue.
3. LOOP_CTL_ADD, create another request_queue q2,blk_mq_debugfs_register()
will fail because the dir aready exist.
4. BLKTRACESETUP, create two files(msg and dropped) inside the dir.
5. call __blk_release_queue() for q1, debugfs_remove_recursive() will
delete the files created in step 4.
6. LOOP_CTL_REMOVE, blk_release_queue() will add q2 to release queue.
And when __blk_release_queue() is called for q2, blk_trace_shutdown() will
try to release the two files created in step 4, wich are aready released
in step 5.

|thread1		  |kworker	             |thread2               |
| ----------------------- | ------------------------ | -------------------- |
|loop_control_ioctl       |                          |                      |
| loop_add                |                          |                      |
|  blk_mq_debugfs_register|                          |                      |
|   debugfs_create_dir    |                          |                      |
|loop_control_ioctl       |                          |                      |
| loop_remove		  |                          |                      |
|  blk_release_queue      |                          |                      |
|   schedule_work         |                          |                      |
|			  |			     |loop_control_ioctl    |
|			  |			     | loop_add             |
|			  |			     |  ...                 |
|			  |			     |blk_trace_ioctl       |
|			  |			     | __blk_trace_setup    |
|			  |			     |   debugfs_create_file|
|			  |__blk_release_queue       |                      |
|			  | blk_mq_debugfs_unregister|                      |
|			  |  debugfs_remove_recursive|                      |
|			  |			     |loop_control_ioctl    |
|			  |			     | loop_remove          |
|			  |			     |  ...                 |
|			  |__blk_release_queue       |                      |
|			  | blk_trace_shutdown       |                      |
|			  |  debugfs_remove          |                      |

commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
final release of request_queue to a workqueue, so, when loop_add() is
called again(step 3), __blk_release_queue() might not been called yet,
which causes the problem.

Fix the problem by renaming 'q->debugfs_dir' in blk_unregister_queue().

[1] https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
References: CVE-2019-19770
Fixes: commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
Reported-by: syzbot <syz...@syzkaller.appspotmail.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 block/blk-sysfs.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fca9b158f4a0..69d28b3f52d0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -1011,6 +1012,33 @@ int blk_register_queue(struct gendisk *disk)
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
 
+/*
+ * blk_prepare_release_queue - rename q->debugfs_dir
+ * @q: request_queue of which the dir to be renamed belong to.
+ *
+ * Because the final release of request_queue is in a workqueue, the
+ * cleanup might not been finished yet while the same device start to
+ * create. It's not correct if q->debugfs_dir still exist while trying
+ * to create a new one.
+ */
+static struct dentry *blk_prepare_release_queue(struct request_queue *q)
+{
+	struct dentry *new = NULL;
+	char name[DNAME_INLINE_LEN];
+	int i = 0;
+
+	if (IS_ERR_OR_NULL(q->debugfs_dir))
+		return q->debugfs_dir;
+
+	while (new == NULL) {
+		sprintf(name, "ready_to_remove_%d", i++);
+		new = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
+				     blk_debugfs_root, name);
+	}
+
+	return new;
+}
+
 /**
  * blk_unregister_queue - counterpart of blk_register_queue()
  * @disk: Disk of which the request queue should be unregistered from sysfs.
@@ -1039,6 +1067,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	mutex_unlock(&q->sysfs_lock);
 
 	mutex_lock(&q->sysfs_dir_lock);
+	q->debugfs_dir = blk_prepare_release_queue(q);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
-- 
2.17.2

