Return-Path: <prvs=9107f69a83=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, <kernel@kolivas.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/8] writeback: track if we're sleeping on progress in balance_dirty_pages()
Date: Wed, 26 Oct 2016 14:52:11 -0600
Message-ID: <1477515135-16469-5-git-send-email-axboe@fb.com>
In-Reply-To: <1477515135-16469-1-git-send-email-axboe@fb.com>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Note in the bdi_writeback structure whenever a task ends up sleeping
waiting for progress. We can use that information in the lower layers
to increase the priority of writes.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 include/linux/backing-dev-defs.h | 2 ++
 mm/backing-dev.c                 | 1 +
 mm/page-writeback.c              | 1 +
 3 files changed, 4 insertions(+)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c357f27d5483..dc5f76d7f648 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -116,6 +116,8 @@ struct bdi_writeback {
 	struct list_head work_list;
 	struct delayed_work dwork;	/* work item used for writeback */
 
+	unsigned long dirty_sleep;	/* last wait */
+
 	struct list_head bdi_node;	/* anchored at bdi->wb_list */
 
 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8fde443f36d7..3bfed5ab2475 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -310,6 +310,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 	spin_lock_init(&wb->work_lock);
 	INIT_LIST_HEAD(&wb->work_list);
 	INIT_DELAYED_WORK(&wb->dwork, wb_workfn);
+	wb->dirty_sleep = jiffies;
 
 	wb->congested = wb_congested_get_create(bdi, blkcg_id, gfp);
 	if (!wb->congested)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 439cc63ad903..52e2f8e3b472 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1778,6 +1778,7 @@ static void balance_dirty_pages(struct address_space *mapping,
 					  pause,
 					  start_time);
 		__set_current_state(TASK_KILLABLE);
+		wb->dirty_sleep = now;
 		io_schedule_timeout(pause);
 
 		current->dirty_paused_when = now + pause;
-- 
2.7.4
