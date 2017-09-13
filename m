Return-Path: <SRS0=1cqs=AO=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 4/4] block/loop: make loop cgroup aware
Date: Wed, 13 Sep 2017 14:01:29 -0700
Message-Id: <2f16f7a5176195bc70a2c10dd7fa11ea85b9145f.1505335620.git.shli@fb.com>
In-Reply-To: <cover.1505335620.git.shli@fb.com>
References: <cover.1505335620.git.shli@fb.com>
In-Reply-To: <cover.1505335620.git.shli@fb.com>
References: <cover.1505335620.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

loop block device handles IO in a separate thread. The actual IO
dispatched isn't cloned from the IO loop device received, so the
dispatched IO loses the cgroup context.

I'm ignoring buffer IO case now, which is quite complicated.  Making the
loop thread aware cgroup context doesn't really help. The loop device
only writes to a single file. In current writeback cgroup
implementation, the file can only belong to one cgroup.

For direct IO case, we could workaround the issue in theory. For
example, say we assign cgroup1 5M/s BW for loop device and cgroup2
10M/s. We can create a special cgroup for loop thread and assign at
least 15M/s for the underlayer disk. In this way, we correctly throttle
the two cgroups. But this is tricky to setup.

This patch tries to address the issue. We record bio's css in loop
command. When loop thread is handling the command, we then use the API
provided in patch 1 to set the css for current task. The bio layer will
use the css for new IO (from patch 3).

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/block/loop.c | 13 +++++++++++++
 drivers/block/loop.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8934e25..37c4da7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -479,6 +479,8 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
 {
 	struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
 
+	if (cmd->css)
+		css_put(cmd->css);
 	cmd->ret = ret > 0 ? 0 : ret;
 	lo_rw_aio_do_completion(cmd);
 }
@@ -538,6 +540,8 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
+	if (cmd->css)
+		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
@@ -545,6 +549,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		ret = call_read_iter(file, &cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
+	kthread_associate_blkcg(NULL);
 
 	if (ret != -EIOCBQUEUED)
 		cmd->iocb.ki_complete(&cmd->iocb, ret, 0);
@@ -1689,6 +1694,14 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	}
 
+	/* always use the first bio's css */
+#ifdef CONFIG_CGROUPS
+	if (cmd->use_aio && cmd->rq->bio && cmd->rq->bio->bi_css) {
+		cmd->css = cmd->rq->bio->bi_css;
+		css_get(cmd->css);
+	} else
+#endif
+		cmd->css = NULL;
 	kthread_queue_work(&lo->worker, &cmd->work);
 
 	return BLK_STS_OK;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index f68c1d5..d93b669 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -74,6 +74,7 @@ struct loop_cmd {
 	long ret;
 	struct kiocb iocb;
 	struct bio_vec *bvec;
+	struct cgroup_subsys_state *css;
 };
 
 /* Support for loadable transfer modules */
-- 
2.9.5
