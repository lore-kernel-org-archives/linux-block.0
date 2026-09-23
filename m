Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F8414DFA;
	Wed, 23 Sep 2026 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140290; cv=none; b=THl+kfR+nWifk/sjZn417mC3KiSnizmS+ZUuD5Sm0FMNnbUppHwPBtOydJdnmDxY9H2EgO2/7+CBoEOF5PrfmCA3jXMhjrLQJqJsAG1dwcynj0pTzuaYkG/JavX4QANJaC41LooXKQxIXzuFxPiDt7cpyFS9ysW/ZMgvsxcaais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140290; c=relaxed/simple;
	bh=VpCqEALnYueCZ/uuf/U/dS9wtmGxFNB/pTswfhfia/w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aE1hDyaHs2ZVW85QjdmpuUTgHuuC96zvQGOayVyTnOhzlO9CAT1cSNt8Jp/d5gMPB4ZlkqpAC6DJO6cg1LU9TxKZu5YCki5re3ikHg+0FnRCT6Mnp58A/6gyCEi+QsCRW3z7bSSxOLaZFrKQnUJ500/G7uJHD48HmaTaHJF+ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68N59wNB077943;
	Wed, 23 Sep 2026 14:09:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68N59wGt077940
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Sep 2026 14:09:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
Date: Wed, 23 Sep 2026 14:09:58 +0900
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
Subject: [PATCH v5 1/2] block: Add post_release() operation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav211.rs.sakura.ne.jp

Add post_release() block device operation which provides a hook for
performing synchronous cleanup without disk->open_mutex held, which is
needed by the loop devices.

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
behavior and the latter is a subjective dependency. Nonetheless, we need
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
Changes in v5:
  Since Bart Van Assche commented that post_release() is more clear
  and more descriptive than run_todo(), renamed run_todo() back to
  post_release(), and make it be called only if release() was called.

 block/bdev.c                     | 28 +++++++++++++++++++---------
 include/linux/blkdev.h           | 10 ++++++++++
 rust/kernel/block/mq/gen_disk.rs |  1 +
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..50cd82719236 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -766,7 +766,8 @@ static void blkdev_put_whole(struct block_device *bdev)
 		bdev->bd_disk->fops->release(bdev->bd_disk);
 }
 
-static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
+static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode,
+			    bool *called_release)
 {
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
@@ -793,18 +794,20 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 		ret = bdev_disk_changed(disk, false);
 		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
 			blkdev_put_whole(bdev);
+			*called_release = true;
 			return ret;
 		}
 	}
 	return 0;
 }
 
-static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
+static int blkdev_get_part(struct block_device *part, blk_mode_t mode,
+			   bool *called_release)
 {
 	struct gendisk *disk = part->bd_disk;
 	int ret;
 
-	ret = blkdev_get_whole(bdev_whole(part), mode);
+	ret = blkdev_get_whole(bdev_whole(part), mode, called_release);
 	if (ret)
 		return ret;
 
@@ -821,6 +824,7 @@ static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 
 out_blkdev_put:
 	blkdev_put_whole(bdev_whole(part));
+	*called_release = true;
 	return ret;
 }
 
@@ -974,6 +978,8 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bool unblock_events = true;
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
+	bool called_release = false;
+	struct module *fops_owner = NULL;
 
 	if (holder) {
 		mode |= BLK_OPEN_EXCL;
@@ -993,15 +999,16 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 		goto abort_claiming;
 	if (!try_module_get(disk->fops->owner))
 		goto abort_claiming;
+	fops_owner = disk->fops->owner;
 	ret = -EBUSY;
 	if (!bdev_may_open(bdev, mode))
-		goto put_module;
+		goto abort_claiming;
 	if (bdev_is_partition(bdev))
-		ret = blkdev_get_part(bdev, mode);
+		ret = blkdev_get_part(bdev, mode, &called_release);
 	else
-		ret = blkdev_get_whole(bdev, mode);
+		ret = blkdev_get_whole(bdev, mode, &called_release);
 	if (ret)
-		goto put_module;
+		goto abort_claiming;
 	bdev_claim_write_access(bdev, mode);
 	if (holder) {
 		bd_finish_claiming(bdev, holder, hops);
@@ -1036,13 +1043,14 @@ int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
 	bdev_file->private_data = holder;
 
 	return 0;
-put_module:
-	module_put(disk->fops->owner);
 abort_claiming:
 	if (holder)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
 	disk_unblock_events(disk);
+	if (called_release && disk->fops->post_release)
+		disk->fops->post_release(disk);
+	module_put(fops_owner);
 	return ret;
 }
 
@@ -1188,6 +1196,8 @@ void bdev_release(struct file *bdev_file)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	if (disk->fops->post_release)
+		disk->fops->post_release(disk);
 
 	module_put(disk->fops->owner);
 put_no_open:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..5354eb006c02 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1577,6 +1577,16 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * This operation is for performing synchronous cleanup after
+	 * release() was called. Since this operation is called without
+	 * disk->open_mutex held, users of this operation must implement
+	 * appropriate serialization. For example, even if thread-A called
+	 * release() operation before thread-B calls release() operation,
+	 * it is possible that thread-B calls post_release() operation
+	 * before thread-A calls post_release() operation.
+	 */
+	void (*post_release)(struct gendisk *disk);
 	int (*ioctl)(struct block_device *bdev, blk_mode_t mode,
 			unsigned cmd, unsigned long arg);
 	int (*compat_ioctl)(struct block_device *bdev, blk_mode_t mode,
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..2ff77ef49781 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -129,6 +129,7 @@ pub fn build<T: Operations>(
             submit_bio: None,
             open: None,
             release: None,
+            post_release: None,
             ioctl: None,
             compat_ioctl: None,
             check_events: None,
-- 
2.52.0

