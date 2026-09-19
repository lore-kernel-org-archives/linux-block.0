Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4B2F7F15;
	Sat, 19 Sep 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815112; cv=none; b=CeOWrx7kjdqM2PLNrvvQfmM0X7l/CQmhe+Wz/oGWCt9edBAAR60N+ZqF4bzSAMrAzD+0bc9VnS9GO0t18CgvhGJ1vfIBU5lsRpdQZFi3hZbLENhADfHSaHv6AlrX0jtxBef3yHgJPoQBnQisi/XZZkPcKk07sbBCWE1EuSdvN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815112; c=relaxed/simple;
	bh=pY5I0QNvPsEWwfeTr6usMkN9sU9ogIQWS78jqgc+3pQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Bemf+LXoceE34ns6CQ2LlJliut8EaSiEjvyvIjq1zg91bdAQAMmtyTtZCWEzKCfTIlaPVrfbZ9iLw3yUd/aDsH6/YrGbuaPrBWG0NGpDI+nek8KswQ1FeGd/uDjBX2k5cM5IvCcm18XB0dyJBWeqxOot1Vw8HW+azTZ+KeU534c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68JAokQU057621;
	Sat, 19 Sep 2026 19:50:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68JAoknU057616
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 19:50:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e615fb71-f386-4029-8ceb-22e375ad9e94@I-love.SAKURA.ne.jp>
Date: Sat, 19 Sep 2026 19:50:43 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v4 1/2] block: Add run_todo() operation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav113.rs.sakura.ne.jp
X-Virus-Status: clean

Add run_todo() block device operation which provides a hook for performing
synchronous cleanup without disk->open_mutex held, which is needed by the
loop devices.

Real-world container engines, test suites, and system utilities rely on
fput() from __loop_clr_fd() being completed when lo_release() returns.
But changes which went to the v7.1 merge window broke an assumption that
there is no outstanding I/O when __loop_clr_fd() is called, causing NULL
pointer dereference problem in lo_rw_aio().

In order to fix this regression, we want to allow __loop_clr_fd() to flush
outstanding I/O. But calling drain_workqueue() from __loop_clr_fd() with
disk->open_mutex held causes lockdep warnings. We need a mechanism which
can flush outstanding I/O without disk->open_mutex held.

But deferring __loop_clr_fd() to WQ context has a problem that there is no
way to wait for completion of __loop_clr_fd() before the calling thread
returns to the userspace, for there is no hook for calling flush_work().
Despite what LO_FLAGS_AUTOCLEAR can guarantee is to clear backing device
"eventually" after the last thread called lo_release(), abovementioned
programs are expecting "synchronously" when a thread who is going to call
umount() or open() as soon as returning from close() called close().
That is an unsatisfiable expectation because the former is an objective
behavior and the latter is an subjective dependency. Nonetheless, we need
to try to wait for completion of __loop_clr_fd() at best-effort basis.

Also, since __loop_clr_fd() calls module_put(THIS_MODULE) and there is no
API for waiting for completion of remote thread's task work context,
deferring __loop_clr_fd() to task work context has a problem (aside from
task_work_add() being not exported to loadable modules) that module unload
operation can unmap code/data segment before __loop_clr_fd() completes.

Therefore, allow the loop driver to safely know completion of
__loop_clr_fd(), by adding a hook which is called after disk->open_mutex
is released.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v4:
  Renamed post_release() to run_todo(), and make it be also called when
  bdev_open() failed.

 block/bdev.c                     | 10 +++++++++-
 include/linux/blkdev.h           | 10 ++++++++++
 rust/kernel/block/mq/gen_disk.rs |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..8f09aafbae11 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -974,6 +974,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bool unblock_events = true;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
+	struct module *fops_owner = NULL;
+	void (*run_todo)(struct gendisk *disk) = NULL;
 
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
@@ -996,6 +998,7 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
 		goto put_module;
+	run_todo = disk->fops->run_todo;
 	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
 	else
@@ -1037,12 +1040,15 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 
 	return 0;
 put_module:
-	module_put(disk->fops->owner);
+	fops_owner = disk->fops->owner;
 abort_claiming:
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
+	if (run_todo)
+		run_todo(disk);
+	module_put(fops_owner);
 	return ret;
 }
 
@@ -1188,6 +1194,8 @@ void bdev_release(struct file *bdev_file)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	if (disk->fops->run_todo)
+		disk->fops->run_todo(disk);
 
 	module_put(disk->fops->owner);
 put_no_open:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..d14fc43de172 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1577,6 +1577,16 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * This operation is for performing synchronous cleanup without
+	 * disk->open_mutex held when blkdev_get_whole() returned an error or
+	 * blkdev_put_whole() was called.
+	 * Since this operation is called after disk->open_mutex was released,
+	 * users of this operation must implement appropriate serialization.
+	 * Also, users of this operation must not expect that either open() or
+	 * release() was called before this operation is called.
+	 */
+	void (*run_todo)(struct gendisk *disk);
 	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
 			unsigned cmd, unsigned long arg);
 	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..fd837d1e3b27 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -129,6 +129,7 @@ pub fn build<T: Operations>(
             submit_bio: None,
             open: None,
             release: None,
+            run_todo: None,
             ioctl: None,
             compat_ioctl: None,
             check_events: None,
-- 
2.55.0
