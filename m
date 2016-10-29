Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>, Shaohua Li <shli@kernel.org>,
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH 24/60] md: set NO_MP for request queue of md
Date: Sat, 29 Oct 2016 16:08:23 +0800
Message-Id: <1477728600-12938-25-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

MD isn't ready for multipage bvecs, so mark it as
NO_MP.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/md.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index eac84d8ff724..f8d98098dff8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5128,6 +5128,16 @@ static void md_safemode_timeout(unsigned long data)
 
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
@@ -5353,6 +5363,8 @@ int md_run(struct mddev *mddev)
 	if (mddev->flags & MD_UPDATE_SB_FLAGS)
 		md_update_sb(mddev, 0);
 
+	md_set_no_mp(mddev);
+
 	md_new_event(mddev);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
-- 
2.7.4

