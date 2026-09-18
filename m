Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704F34F7CB2;
	Fri, 18 Sep 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743706; cv=none; b=p+3QBUqCXnoA3VANBrBD33csoX5v17/04UhgBLSq3yV8V4R4ebpQYxwqjbzQnxnv8Fefb42ecJEtFjXF1MPqEx1+2tZiuAXt65/YB3uzVBP4W7ishDDqSlQ2lJCoOZmyoZvQUvLmIbm/RabFJvn5NWqpq52hXpEOGbL4geK2nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743706; c=relaxed/simple;
	bh=P6JAC0zbWbMCQcuPeT0DKubinZja6GhcL2AL/YCT7VE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kEXZQbpl2CPpiY3CGAq4pAVyRJXRYT75/8wk3JJqV3HcQ/EivqYoP44Ly52mhSxoV36RTuxODmIQUTGtMEGUye5fdZR/esBGm0RupXvPWAKyxKQGv6uXYL0FraeCV6fOAYunpHBZ+uI1EIplC7MGy/OIKy51fkRcmyMIiVdY4V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68IF0C2Z073061;
	Sat, 19 Sep 2026 00:00:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68IF0BGg073055
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 19 Sep 2026 00:00:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f597b6e6-77a7-4c09-9d72-e5a9cbe6d7c2@I-love.SAKURA.ne.jp>
Date: Sat, 19 Sep 2026 00:00:07 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        rust-for-linux@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nilay Shroff <nilay@linux.ibm.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 1/2] block: Add post_release() operation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav111.rs.sakura.ne.jp

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

This post_release() operation is called from only bdev_release() path.
This is because loop_configure() is not yet called (there is nothing to
clear) if something went wrong between an initialization lo_open() and
an error-unwinding lo_release() within the bdev_open() path.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  Dropped description about idempotence, for it seems that Vart wants to
  let current thread run __loop_clr_fd() instead of offloading to WQ context
  and letting current thread call flush_work()
  ( https://lkml.kernel.org/r/cdaebcf71c5de3e994f535dfdc9daa15a77bf59b.1789680010.git.bvanassche@acm.org ).

 block/bdev.c                     | 2 ++
 include/linux/blkdev.h           | 8 ++++++++
 rust/kernel/block/mq/gen_disk.rs | 1 +
 3 files changed, 11 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..7ce5acaacf43 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1188,6 +1188,8 @@ void bdev_release(struct file *bdev_file)
 	else
 		blkdev_put_whole(bdev);
 	mutex_unlock(&disk->open_mutex);
+	if (bdev->bd_disk->fops->post_release)
+		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 
 	module_put(disk->fops->owner);
 put_no_open:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..d13d703a7bea 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1577,6 +1577,14 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open)(struct gendisk *disk, blk_mode_t mode);
 	void (*release)(struct gendisk *disk);
+	/*
+	 * This operation is called after returned from release() and
+	 * disk->open_mutex was released. But be careful that this operation
+	 * is not called after an initialization open() has succeeded but
+	 * something went wrong and an error-unwinding release() was called.
+	 * This operation might sleep.
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
2.55.0

