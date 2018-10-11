Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com
Subject: [PATCH v2 11/11] floppy: convert to blk-mq
Date: Thu, 11 Oct 2018 12:20:51 -0700
Message-Id: <425e985d1937bcda9193a076375b84e2a69d8558.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This driver likes to fetch requests from all over the place, so make
queue_rq put requests on a list so that the logic stays the same. Tested
with QEMU.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/floppy.c | 74 +++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 30 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f2b6f4da1034..62e0c218e5c6 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -252,13 +252,13 @@ static int allowed_drive_mask = 0x33;
 
 static int irqdma_allocated;
 
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/blkpg.h>
 #include <linux/cdrom.h>	/* for the compatibility eject ioctl */
 #include <linux/completion.h>
 
+static LIST_HEAD(floppy_reqs);
 static struct request *current_req;
-static void do_fd_request(struct request_queue *q);
 static int set_next_request(void);
 
 #ifndef fd_get_dma_residue
@@ -414,10 +414,10 @@ static struct floppy_drive_struct drive_state[N_DRIVE];
 static struct floppy_write_errors write_errors[N_DRIVE];
 static struct timer_list motor_off_timer[N_DRIVE];
 static struct gendisk *disks[N_DRIVE];
+static struct blk_mq_tag_set tag_sets[N_DRIVE];
 static struct block_device *opened_bdev[N_DRIVE];
 static DEFINE_MUTEX(open_lock);
 static struct floppy_raw_cmd *raw_cmd, default_raw_cmd;
-static int fdc_queue;
 
 /*
  * This struct defines the different floppy types.
@@ -2216,8 +2216,9 @@ static void floppy_end_request(struct request *req, blk_status_t error)
 	/* current_count_sectors can be zero if transfer failed */
 	if (error)
 		nr_sectors = blk_rq_cur_sectors(req);
-	if (__blk_end_request(req, error, nr_sectors << 9))
+	if (blk_update_request(req, error, nr_sectors << 9))
 		return;
+	__blk_mq_end_request(req, error);
 
 	/* We're done with the request */
 	floppy_off(drive);
@@ -2797,27 +2798,14 @@ static int make_raw_rw_request(void)
 	return 2;
 }
 
-/*
- * Round-robin between our available drives, doing one request from each
- */
 static int set_next_request(void)
 {
-	struct request_queue *q;
-	int old_pos = fdc_queue;
-
-	do {
-		q = disks[fdc_queue]->queue;
-		if (++fdc_queue == N_DRIVE)
-			fdc_queue = 0;
-		if (q) {
-			current_req = blk_fetch_request(q);
-			if (current_req) {
-				current_req->error_count = 0;
-				break;
-			}
-		}
-	} while (fdc_queue != old_pos);
-
+	current_req = list_first_entry_or_null(&floppy_reqs, struct request,
+					       queuelist);
+	if (current_req) {
+		current_req->error_count = 0;
+		list_del_init(&current_req->queuelist);
+	}
 	return current_req != NULL;
 }
 
@@ -2901,29 +2889,38 @@ static void process_fd_request(void)
 	schedule_bh(redo_fd_request);
 }
 
-static void do_fd_request(struct request_queue *q)
+static blk_status_t floppy_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *bd)
 {
+	blk_mq_start_request(bd->rq);
+
 	if (WARN(max_buffer_sectors == 0,
 		 "VFS: %s called on non-open device\n", __func__))
-		return;
+		return BLK_STS_IOERR;
 
 	if (WARN(atomic_read(&usage_count) == 0,
 		 "warning: usage count=0, current_req=%p sect=%ld flags=%llx\n",
 		 current_req, (long)blk_rq_pos(current_req),
 		 (unsigned long long) current_req->cmd_flags))
-		return;
+		return BLK_STS_IOERR;
+
+	spin_lock_irq(&floppy_lock);
+	list_add_tail(&bd->rq->queuelist, &floppy_reqs);
+	spin_unlock_irq(&floppy_lock);
 
 	if (test_and_set_bit(0, &fdc_busy)) {
 		/* fdc busy, this new request will be treated when the
 		   current one is done */
 		is_alive(__func__, "old request running");
-		return;
+		return BLK_STS_OK;
 	}
+
 	command_status = FD_COMMAND_NONE;
 	__reschedule_timeout(MAXTIMEOUT, "fd_request");
 	set_fdc(0);
 	process_fd_request();
 	is_alive(__func__, "");
+	return BLK_STS_OK;
 }
 
 static const struct cont_t poll_cont = {
@@ -4486,6 +4483,10 @@ static struct platform_driver floppy_driver = {
 	},
 };
 
+static const struct blk_mq_ops floppy_mq_ops = {
+	.queue_rq = floppy_queue_rq,
+};
+
 static struct platform_device floppy_device[N_DRIVE];
 
 static bool floppy_available(int drive)
@@ -4527,15 +4528,28 @@ static int __init do_floppy_init(void)
 		return -ENOMEM;
 
 	for (drive = 0; drive < N_DRIVE; drive++) {
+		struct blk_mq_tag_set *set;
+
 		disks[drive] = alloc_disk(1);
 		if (!disks[drive]) {
 			err = -ENOMEM;
 			goto out_put_disk;
 		}
 
-		disks[drive]->queue = blk_init_queue(do_fd_request, &floppy_lock);
-		if (!disks[drive]->queue) {
-			err = -ENOMEM;
+		set = &tag_sets[drive];
+		set->ops = &floppy_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = 2;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		err = blk_mq_alloc_tag_set(set);
+		if (err)
+			goto out_put_disk;
+
+		disks[drive]->queue = blk_mq_init_queue(set);
+		if (IS_ERR(disks[drive]->queue)) {
+			err = PTR_ERR(disks[drive]->queue);
+			disks[drive]->queue = NULL;
 			goto out_put_disk;
 		}
 
-- 
2.19.1
