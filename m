Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32970 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbcL0P7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 10:59:51 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH v1 11/54] md: set NO_MP for request queue of md
Date: Tue, 27 Dec 2016 23:56:00 +0800
Message-Id: <1482854250-13481-12-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MD isn't ready for multipage bvecs, so mark it as
NO_MP.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/md.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 82821ee0d57f..63c6326bafde 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5162,6 +5162,16 @@ static void md_safemode_timeout(unsigned long data)
 
 static int start_dirty_degraded;
 
+/*
+ * MD isn't ready for multipage bvecs yet, and set the flag
+ * so that MD still can see singlepage bvecs bio
+ */
+static inline void md_set_no_mp(struct mddev *mddev)
+{
+	if (mddev->queue)
+		set_bit(QUEUE_FLAG_NO_MP, &mddev->queue->queue_flags);
+}
+
 int md_run(struct mddev *mddev)
 {
 	int err;
@@ -5381,6 +5391,8 @@ int md_run(struct mddev *mddev)
 	if (mddev->sb_flags)
 		md_update_sb(mddev, 0);
 
+	md_set_no_mp(mddev);
+
 	md_new_event(mddev);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-- 
2.7.4

