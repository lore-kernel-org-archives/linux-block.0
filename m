Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeAWRUo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jan 2018 12:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0206D355F
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2018 17:20:44 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
To: linux-block@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq-debugfs: don't allow write on attributes with seq_operations set
Date: Wed, 24 Jan 2018 01:20:00 +0800
Message-Id: <20180123172000.20919-1-eguan@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Attributes that only implement .seq_ops are read-only, any write to
them should be rejected. But currently kernel would crash when
writing to such debugfs entries, e.g.

chmod +w /sys/kernel/debug/block/<dev>/requeue_list
echo 0 > /sys/kernel/debug/block/<dev>/requeue_list
chmod -w /sys/kernel/debug/block/<dev>/requeue_list

Fix it by returning -EPERM in blk_mq_debugfs_write() when writing to
such attributes.

Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 block/blk-mq-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b56a4f35720d..54bd8c31b822 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -703,7 +703,11 @@ static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
 	const struct blk_mq_debugfs_attr *attr = m->private;
 	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
 
-	if (!attr->write)
+	/*
+	 * Attributes that only implement .seq_ops are read-only and 'attr' is
+	 * the same with 'data' in this case.
+	 */
+	if (attr == data || !attr->write)
 		return -EPERM;
 
 	return attr->write(data, buf, count, ppos);
-- 
2.14.3
