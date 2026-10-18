Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858F4C4F7F
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337230; cv=none; b=QUG9CaSEOIQL53BOng4Sw1mSLtbpKX0hQheH7ry/Pjp4OWICGYhdohCuAZcMJBzPG3rXEcwKhvtNoSnM8uqevRcY0yMRleNZYMPnYN8E7we699oOzq4DLpDbcmt5v2wkcctBCgMRIumV8wghGs2QZpaZprJpUyutI4GT43VdNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337230; c=relaxed/simple;
	bh=n9ITuBjjnPPvVDZmo1Msj32xUs0M4ldAdKghpymrP70=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pB6Ao2S0bIvm82yCoXwgu8+31q7KXL8chNtp+HTBfb+KwC/OcIk7rjgg0JAI8YLENGKn8pxWuORZN2/OfgkOimvJpSvIqLF8En/I5nbCAsbdZbRz+GJgmE1zQAdQH7ufzNSXUnemOL63+kdDdEBFzH4vlncEonpTlaXuJlsOdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69IFQkKx087078;
	Mon, 19 Oct 2026 00:26:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69IFQjMZ087075
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Oct 2026 00:26:46 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <81c9adbe-14f3-4d1b-8a88-8b796e91f3a9@I-love.SAKURA.ne.jp>
Date: Mon, 19 Oct 2026 00:26:44 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v8 2/2] block: wait for inflight requests in bdev_release()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
 <20261007130851.GA30117@lst.de>
 <4d7c7365-259c-402e-9cf5-d55ad9333200@I-love.SAKURA.ne.jp>
 <380f04ef-902d-4664-9ae3-228692d2efb9@I-love.SAKURA.ne.jp>
 <696e5e7c-e3f1-4181-be2a-8915fd1753cf@I-love.SAKURA.ne.jp>
 <cc2910d3-3113-44d4-94ef-0c8d365fac9c@I-love.SAKURA.ne.jp>
 <53c3ccf7-1a5e-4861-afc0-7cbfd3284655@I-love.SAKURA.ne.jp>
 <d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp>
 <e8d48691-9e29-41e0-9326-fff961b10cdf@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <e8d48691-9e29-41e0-9326-fff961b10cdf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav313.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting a NULL pointer dereference [1] and invalid reading of
destroyed "struct file" [2] in lo_rw_aio() within the loop driver. Also,
syzbot-ci is reporting read attempt on a no-longer bound loop device [3].
These reports are caused by current implementation that a block device's
backing storage and associated structures (such as "struct file") are
invalidated before all outstanding asynchronous or file-system-driven I/O
requests have fully completed.

Investigation revealed that filesystems can leak outstanding non-blocking
Read/Write requests during error-rollbacks in the mount failure path or
during standard unmount sequences:

1. Write Leaks via -EIO: When filemap_fdatawrite_range() returns an error
   (such as -EIO due to filesystem errors), filemap_write_and_wait_range()
   skips the subsequent __filemap_fdatawait_range() call. As a result,
   sync_blockdev() returns prematurely without waiting for the completion
   of write requests already sitting in flight.
2. Read Leaks via Readahead: Asynchronous metadata readahead requests are
   entirely ignored by sync_blockdev(), allowing ongoing Read I/O to bypass
   data synchronization entirely.

When these leaked requests later complete or attempt backend processing via
loop's kworker (loop_handle_cmd()), they dereference now-invalid or
nullified fields.

While earlier attempts tried to address this regression inside the loop
driver by temporarily releasing disk->open_mutex [4] or proposing a core
layer post_release() callback [5], these approaches were rejected because
they either introduced invasive driver-specific hooks into the block layer
or broke the core mutual exclusion semantics that the block layer relies
upon.

To fix this comprehensively without introducing deadlocks or altering
driver-specific semantics, enforce an explicit queue freeze in the core
VFS close path inside bdev_release(), right before disk->open_mutex is
acquired:

1. Lock-Free Congestion Clearing: Calling blk_mq_freeze_queue() before
   acquiring disk->open_mutex avoids any circular locking dependencies
   (disk->open_mutex => wq_completion => VFS locks => disk->open_mutex),
   guaranteeing that the lockdep hierarchy remains perfectly undisturbed.
2. Guaranteed Quenching: Freezing the queue ensures that all outstanding
   asynchronous Direct I/O (cmd->use_aio != 0) and page-cache readahead
   requests are physically completed and drained before the loop device
   proceeds to teardown and unbind the backing file via fput().

This architecture-compliant fix should be able to ensure data integrity
and lifecycle synchronization across all virtual block devices without
muddying block layer locks.

Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
Reported-by: syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3 [2]
Link: https://lkml.kernel.org/r/6acbe268.8cdf6287.1eb53.00ed.GAE@google.com [3]
Link: https://lkml.kernel.org/r/8dedfc40-9cae-44ff-9960-e0eb1825e963@I-love.SAKURA.ne.jp [4]
Link: https://lkml.kernel.org/r/69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp [5]
Assisted-by: Gemini-Pro
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Notes on why this cannot and should not be fixed on the filesystem side:

(1) In filemap_fdatawrite_range(), BIOs are submitted before -EIO is returned.
(2) The comment in filemap_write_and_wait_range() states that we don't wait for submitted
    BIOs when filemap_fdatawrite_range() returned -EIO.
(3) As a result, sync_blockdev() does not wait for block layer's queue to become empty when
    filemap_fdatawrite_range() returned -EIO.
(4) As a result, we need to wait for block layer's queue to become empty (by calling
    freeze/unfreeze API) between sync_blockdev() and lo_release() if we want to make sure
    that there is no inflight BIOs when lo_release() is called.
(5) Modifying individual filesystems does not help, for sync_blockdev() from
    bdev_release() might append inflight BIOs.

It will introduce several architectural and stability issues if we shift the responsibility
to individual filesystems to explicitly freeze/unfreeze the queue:

(a) Violation of Layer Separation:

  Filesystems should remain agnostic to whether the underlying block device is
  a physical hardware disk or a virtual loop device. Forcing filesystems to handle
  this layer-specific quirk violates VFS/block layer separation.

(b) Risk of Double Freeze / Deadlocks:

  Filesystem layer should handle only filesystem level freezing, and block layer
  should handle only block level freezing.

(c) Ownership of the Device Lifecycle:

  Quenching inflight I/O before destroying a device's context is the fundamental
  responsibility of the layer managing the device's lifecycle. Since bdev_release()
  is the final gatekeeper before __loop_clr_fd() nullifies the backing file,
  the block core (before releasing open_mutex) or the loop module (after releasing
  open_mutex) must enforce this last line of defense.

 block/bdev.c                     | 38 +++++++++++++++++++++++++++++++-
 drivers/block/loop.c             |  1 +
 include/linux/blkdev.h           |  1 +
 rust/kernel/block/mq/gen_disk.rs |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index a4065e16544d..3d5292fa4432 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -753,7 +753,9 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
 static void blkdev_flush_mapping(struct block_device *bdev)
 {
 	WARN_ON_ONCE(bdev->bd_holders);
-	sync_blockdev(bdev);
+	/* See bd_early_sync() for this behavior. */
+	if (!bdev->bd_disk->fops->sync_queue_before_release)
+		sync_blockdev(bdev);
 	kill_bdev(bdev);
 	bdev_write_inode(bdev);
 }
@@ -1180,11 +1182,45 @@ static inline void bd_early_sync(struct gendisk *disk, struct block_device *bdev
 	 * Therefore, this bdev->bd_openers == 1 + bdev->bd_closers condition
 	 * guarantees that any thread who might become the last opener performs
 	 * synchronization which should be done before holding open_mutex.
+	 *
+	 * Also, wait for all in-flight BIOs to complete if
+	 * sync_queue_before_release is set, due to reasons listed below.
+	 *
+	 * (1) sync_blockdev() fails to wait for completion of writeback when
+	 *     filemap_fdatawrite_range() returned -EIO after some write BIOs
+	 *     have been submitted. Also, sync_blockdev() does not wait for
+	 *     completion of read BIOs submitted by e.g. filesystem's readahead
+	 *     behavior. To wait for completion of already submitted BIOs, we
+	 *     need to freeze block layer's queue which we are about to close.
+	 * (2) At least, lo_release() (one of bdev->bd_disk->fops->release()
+	 *     targets) depends on that there is no in-flight BIO when
+	 *     lo_release() is called. If this dependency is broken, the kernel
+	 *     crashes due to lo_rw_aio() trying to process in-flight BIOs
+	 *     after blkdev_flush_mapping() and lo_release() are called.
+	 * (3) lo_release() is not allowed to freeze block layer's queue due to
+	 *     circular locking dependency which involves open_mutex. Also,
+	 *     lo_release() is required to complete fput() from __loop_clr_fd()
+	 *     before lo_release() returns to usermode, for existing userspace
+	 *     programs depend on such behavior. These constraints make it
+	 *     impossible for lo_release() to defer queue freezing and fput()
+	 *     to delayed context such as WQ or task work.
+	 * (4) If blkdev_flush_mapping() submits new BIOs, there might be
+	 *     in-flight BIOs when bdev->bd_disk->fops->release() is called.
+	 *     Since lo_release() cannot accept such possibility, we freeze
+	 *     queue here and forbid further submission of BIOs after we
+	 *     unfreeze queue and re-acquires open_mutex.
+	 * (5) Whether to wait for all in-flight BIOs to complete is an opt-in
+	 *     basis switch, for this behavior is required by loop module which
+	 *     cannot freeze queue with open_mutex held due to circular locking
+	 *     dependency.
 	 */
 	if (atomic_read(&bdev->bd_openers) == 1 + bdev->bd_closers) {
 		bdev->bd_closers++;
 		mutex_unlock(&disk->open_mutex);
 		sync_blockdev(bdev);
+		if (disk->fops->sync_queue_before_release)
+			blk_mq_unfreeze_queue(bdev->bd_queue,
+					      blk_mq_freeze_queue(bdev->bd_queue));
 		mutex_lock(&disk->open_mutex);
 		bdev->bd_closers--;
 	}
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..5104cc9b9253 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1796,6 +1796,7 @@ static const struct block_device_operations lo_fops = {
 	.compat_ioctl =	lo_compat_ioctl,
 #endif
 	.free_disk =	lo_free_disk,
+	.sync_queue_before_release = true,
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..dcb08337518a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1598,6 +1598,7 @@ struct block_device_operations {
 			enum blk_unique_id id_type);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
+	bool sync_queue_before_release;
 
 	/*
 	 * Special callback for probing GPT entry at a given sector.
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index fc97dd873974..fa554e5b2c18 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -145,6 +145,7 @@ pub fn build<T: Operations>(
             pr_ops: core::ptr::null_mut(),
             free_disk: None,
             poll_bio: None,
+            sync_queue_before_release: false,
         };
 
         // SAFETY: `gendisk` is a valid pointer as we initialized it above
-- 
2.56.0

