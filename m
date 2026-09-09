Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CA530E0F;
	Wed,  9 Sep 2026 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950999; cv=none; b=JJG9AM8zIxjcZUUb6lFcIly+9jPeek6rQXdxc2JZMYNwH4Kq1QoOtmDIpJJSLFf2t379u3EuGFNgyr8ZumzN645TaLD6LC0Iw3OtWMhaRnM/UjkmJrL7Y+ckLj1Ps0XVzSwVEb7cGhUIRFGgTMal6oU5j8SSEmSrGp9GsVb1gLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950999; c=relaxed/simple;
	bh=qa7uKVmuRKbzZkSWTupVeLu/yAB1fOSaZ/W3rSwhgRQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=txvdWL3tICw0z6Zd46HwfwtefhcjT2iIsM7FkZg19Pi2gKFRrZT38UNmDuStDir3RThBDCB51nq3J/ZfOKVBW0ytfEXIj41/5g4ROsVrjh0jPWHo8xczMbTYKRdpvu5lnPA44RHXL2BQVpUjTn8srHC6ZjAO0HmEbt4O2vDkTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 689Amg9A031559;
	Wed, 9 Sep 2026 19:48:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 689Amgtj031555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 9 Sep 2026 19:48:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
Date: Wed, 9 Sep 2026 19:48:41 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Foster
 <bfoster@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>, Hillf Danton <hdanton@sina.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        rust-for-linux@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 1/2] block: Add post_release() operation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav213.rs.sakura.ne.jp
X-Virus-Status: clean

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

This post_release() operation is intended for performing only idempotent
actions such as flush_work(), for nothing prevents multiple threads from
concurrently calling this operation. That is, the loop device schedules
a work_struct for calling __loop_clr_fd() from lo_release() where
disk->open_mutex is held, and waits for completion of that work_struct
using post_release() operation where disk->open_mutex is not held.

Also, this post_release() operation is called from only bdev_release()
path. This is because loop_configure() is not yet called (there is nothing
to clear) if something went wrong between an initialization lo_open() and
an error-unwinding lo_release() within the bdev_open() path.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/bdev.c                     | 2 ++
 include/linux/blkdev.h           | 6 ++++++
 rust/kernel/block/mq/gen_disk.rs | 1 +
 3 files changed, 9 insertions(+)

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
index 4f7905c3412b..f05dba1b5962 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1605,6 +1605,12 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+	/*
+	 * Called after disk->open_mutex is released in the bdev_release() path.
+	 * Used by loop devices that need to perform synchronization without
+	 * holding disk->open_mutex. This operation has to be idempotent.
+	 */
+	void (*post_release)(struct gendisk *disk);
 };
 
 #ifdef CONFIG_COMPAT
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
