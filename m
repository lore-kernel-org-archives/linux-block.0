Return-Path: <axboe@kernel.dk>
Received: from [192.168.1.154] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k86sm4226315ioi.23.2017.11.04.10.32.26
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Nov 2017 10:32:26 -0700 (PDT)
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blktrace: fix unlocked access to init/start-stop/teardown
Message-ID: <b786bbb3-12f8-6609-8e0d-2fe740de204f@kernel.dk>
Date: Sat, 4 Nov 2017 11:32:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

sg.c calls into the blktrace functions without holding the proper queue
mutex for doing setup, start/stop, or teardown. This can cause problems
like the below:

CPU: 0 PID: 2995 Comm: syzkaller857118 Not tainted  
4.14.0-rc5-next-20171018+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:16 [inline]
  dump_stack+0x194/0x257 lib/dump_stack.c:52
  panic+0x1e4/0x41c kernel/panic.c:183
  __warn+0x1c4/0x1e0 kernel/panic.c:546
  report_bug+0x211/0x2d0 lib/bug.c:183
  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:177
  do_trap_no_signal arch/x86/kernel/traps.c:211 [inline]
  do_trap+0x260/0x390 arch/x86/kernel/traps.c:260
  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:297
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:310
  invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
RIP: 0010:tracepoint_add_func kernel/tracepoint.c:210 [inline]
RIP: 0010:tracepoint_probe_register_prio+0x397/0x9a0 kernel/tracepoint.c:283
RSP: 0018:ffff8801d1d1f6c0 EFLAGS: 00010293
RAX: ffff8801d22e8540 RBX: 00000000ffffffef RCX: ffffffff81710f07
RDX: 0000000000000000 RSI: ffffffff85b679c0 RDI: ffff8801d5f19818
RBP: ffff8801d1d1f7c8 R08: ffffffff81710c10 R09: 0000000000000004
R10: ffff8801d1d1f6b0 R11: 0000000000000003 R12: ffffffff817597f0
R13: 0000000000000000 R14: 00000000ffffffff R15: ffff8801d1d1f7a0
  tracepoint_probe_register+0x2a/0x40 kernel/tracepoint.c:304
  register_trace_block_rq_insert include/trace/events/block.h:191 [inline]
  blk_register_tracepoints+0x1e/0x2f0 kernel/trace/blktrace.c:1043
  do_blk_trace_setup+0xa10/0xcf0 kernel/trace/blktrace.c:542
  blk_trace_setup+0xbd/0x180 kernel/trace/blktrace.c:564
  sg_ioctl+0xc71/0x2d90 drivers/scsi/sg.c:1089
  vfs_ioctl fs/ioctl.c:45 [inline]
  do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
  SYSC_ioctl fs/ioctl.c:700 [inline]
  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
  entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x444339
RSP: 002b:00007ffe05bb5b18 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006d66c0 RCX: 0000000000444339
RDX: 000000002084cf90 RSI: 00000000c0481273 RDI: 0000000000000009
RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: ffffffffffffffff
R13: 00000000c0481273 R14: 0000000000000000 R15: 0000000000000000

since we can now run these in parallel. Ensure that the exported helpers
for doing this are grabbing the queue trace mutex.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 6da127ad0918 ("blktrace: Add blktrace ioctls to SCSI generic devices")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 45a3928544ce..ea57dd94b2b2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -336,7 +336,7 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 		blk_unregister_tracepoints();
 }
 
-int blk_trace_remove(struct request_queue *q)
+static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
 
@@ -349,6 +349,17 @@ int blk_trace_remove(struct request_queue *q)
 
 	return 0;
 }
+
+int blk_trace_remove(struct request_queue *q)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_remove(q);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_remove);
 
 static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
@@ -550,9 +561,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
+static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+			     struct block_device *bdev, char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -571,6 +581,19 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	}
 	return 0;
 }
+
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev,
+		    char __user *arg)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_setup(q, name, dev, bdev, arg);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
@@ -607,7 +630,7 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 }
 #endif
 
-int blk_trace_startstop(struct request_queue *q, int start)
+static int __blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 	struct blk_trace *bt = q->blk_trace;
@@ -646,6 +669,17 @@ int blk_trace_startstop(struct request_queue *q, int start)
 
 	return ret;
 }
+
+int blk_trace_startstop(struct request_queue *q, int start)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret = __blk_trace_startstop(q, start);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
 
 /*
@@ -676,7 +710,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	switch (cmd) {
 	case BLKTRACESETUP:
 		bdevname(bdev, b);
-		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
@@ -687,10 +721,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	case BLKTRACESTART:
 		start = 1;
 	case BLKTRACESTOP:
-		ret = blk_trace_startstop(q, start);
+		ret = __blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret = blk_trace_remove(q);
+		ret = __blk_trace_remove(q);
 		break;
 	default:
 		ret = -ENOTTY;
@@ -708,10 +742,14 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
+	mutex_lock(&q->blk_trace_mutex);
+
 	if (q->blk_trace) {
-		blk_trace_startstop(q, 0);
-		blk_trace_remove(q);
+		__blk_trace_startstop(q, 0);
+		__blk_trace_remove(q);
 	}
+
+	mutex_unlock(&q->blk_trace_mutex);
 }
 
 #ifdef CONFIG_BLK_CGROUP

-- 
Jens Axboe
