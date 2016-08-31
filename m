Return-Path: <prvs=80513f069d=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/8] writeback: track if we're sleeping on progress in balance_dirty_pages()
Date: Wed, 31 Aug 2016 11:05:47 -0600
Message-ID: <1472663151-18560-5-git-send-email-axboe@fb.com>
In-Reply-To: <1472663151-18560-1-git-send-email-axboe@fb.com>
References: <1472663151-18560-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Note in the bdi_writeback structure if a task is currently being
limited in balance_dirty_pages(), waiting for writeback to
proceed.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/backing-dev-defs.h | 2 ++
 mm/backing-dev.c                 | 1 +
 mm/page-writeback.c              | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c357f27d5483..5a56588573f6 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -116,6 +116,8 @@ struct bdi_writeback {
 	struct list_head work_list;
 	struct delayed_work dwork;	/* work item used for writeback */
 
+	atomic_t dirty_sleeping;	/* waiting on dirty limit exceeded */
+
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8fde443f36d7..ffd607c9f00d 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -310,6 +310,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
+	atomic_set(&wb->dirty_sleeping, 0);
 
 	wb->congested = wb_congested_get_create(bdi, blkcg_id, gfp);
 	if (!wb->congested)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f4cd7d8005c9..c8e9e7a487c6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1778,7 +1778,9 @@ pause:
 					  pause,
 					  start_time);
 		__set_current_state(TASK_KILLABLE);
+		atomic_inc(&wb->dirty_sleeping);
 		io_schedule_timeout(pause);
+		atomic_dec(&wb->dirty_sleeping);
 
 		current->dirty_paused_when = now + pause;
 		current->nr_dirtied = 0;
-- 
2.7.4
