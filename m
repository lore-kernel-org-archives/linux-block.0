Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0704A2A46
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337227; cv=none; b=sVR8JwG0aepRlauy5PO0srSTOpgZG6EkVTx12pXt4uZmmh6nanyszu4wZADUM+SQ69GA8FNzsmE59G7XKcncJwkxJz3dXCxHIz016u/fKunUunxRHxKofPHOqmbdmN/R2uuzv7/rT34oXjJHHAhUzvFG5Xfkc3sA9WxqTp6H5vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337227; c=relaxed/simple;
	bh=xWvyFR6mh0PiNrbJrqB+hChIX9FBKkd5vEI7A1DSN4k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iIhKGNPFVvROHFV6yrKhdrnBWcz7jdsPXcarwVnC1tVXaxTvGomWWu2wy1xk5ltCrwCk+XBqbX+KA3KFE9yeyU/KOXUuUD6dC5L/bHTfxxCnwq4JYNNy9RGGOJWt6MFKAycP1j+yCA09ngcGN4lLtL0/YMEUXxSRpMrsawgnrWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 69IFQSMv087039;
	Mon, 19 Oct 2026 00:26:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 69IFQJG0087013
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 19 Oct 2026 00:26:28 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e8d48691-9e29-41e0-9326-fff961b10cdf@I-love.SAKURA.ne.jp>
Date: Mon, 19 Oct 2026 00:26:17 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v8 1/2] block: avoid long sync_blockdev() under
 disk->open_mutex during parallel close
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
Content-Language: en-US
In-Reply-To: <d05d7049-70a1-4216-b268-1c209834dc84@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav114.rs.sakura.ne.jp

Commit b849dd84b6cc ("bdev: Reduce time holding bd_mutex in sync in
blkdev_close()") introduced a sync_blockdev() call immediately before
holding disk->open_mutex. But this check was racy and best-effort basis.

If more than one thread concurrently called bdev_release() and saw
atomic_read(&bdev->bd_openers) > 1, the thread which actually hit
the atomic_dec_and_test(&bdev->bd_openers) condition will call
sync_blockdev() from blkdev_flush_mapping() (which could take several
minutes) with disk->open_mutex held.

Kill this race window and make sync_blockdev() always be called before
holding disk->open_mutex, by using a counter that tracks how many threads
are calling sync_blockdev() from bdev_release() without disk->open_mutex
held.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/bdev.c              | 54 +++++++++++++++++++++++++++++++--------
 include/linux/blk_types.h |  1 +
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..a4065e16544d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1150,6 +1150,46 @@ static inline void bd_yield_claim(struct file *bdev_file)
 		bd_end_claim(bdev, holder);
 }
 
+static inline void bd_early_sync(struct gendisk *disk, struct block_device *bdev)
+{
+	/*
+	 * Temporarily drop open_mutex and process writeback (which could take
+	 * several minutes to complete) for this "bdev", if current thread is
+	 * the last opener (or one of threads who might become the last opener)
+	 * when current thread re-acquires open_mutex.
+	 *
+	 * It is safe for this "bdev" to temporarily drop open_mutex here, for
+	 * this "bdev" owns one bd_openers count (avoiding possibility of UAF),
+	 * and bdev_release() has not yet modified any state for this "bdev".
+	 * In essence, bd_early_sync() is doing what we can do (or what we
+	 * should have done) before calling bdev_release().
+	 *
+	 * It is safe if another thread called blkdev_get_{whole,part}() from
+	 * bdev_open() while current thread temporarily dropped open_mutex, for
+	 * the bd_openers elevated by another thread prevents current thread
+	 * from calling blkdev_flush_mapping() when current thread re-acquired
+	 * open_mutex and calls blkdev_put_{whole,part}().
+	 *
+	 * It is also safe if another thread called blkdev_get_{whole,part}()
+	 * from bdev_open() and initiated bdev_release() while current thread
+	 * temporarily dropped open_mutex, for the bd_closers elevated by
+	 * current thread prevents another thread from skipping this step
+	 * (another thread is evaluated as one of threads who might become
+	 * the last opener) and sync_blockdev() is designed to be thread-safe.
+	 *
+	 * Therefore, this bdev->bd_openers == 1 + bdev->bd_closers condition
+	 * guarantees that any thread who might become the last opener performs
+	 * synchronization which should be done before holding open_mutex.
+	 */
+	if (atomic_read(&bdev->bd_openers) == 1 + bdev->bd_closers) {
+		bdev->bd_closers++;
+		mutex_unlock(&disk->open_mutex);
+		sync_blockdev(bdev);
+		mutex_lock(&disk->open_mutex);
+		bdev->bd_closers--;
+	}
+}
+
 void bdev_release(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
@@ -1160,17 +1200,11 @@ void bdev_release(struct file *bdev_file)
 	if (IS_ERR(holder))
 		goto put_no_open;
 
-	/*
-	 * Sync early if it looks like we're the last one.  If someone else
-	 * opens the block device between now and the decrement of bd_openers
-	 * then we did a sync that we didn't need to, but that's not the end
-	 * of the world and we want to avoid long (could be several minute)
-	 * syncs while holding the mutex.
-	 */
-	if (atomic_read(&bdev->bd_openers) == 1)
-		sync_blockdev(bdev);
-
 	mutex_lock(&disk->open_mutex);
+	bd_early_sync(disk, bdev);
+	if (bdev_is_partition(bdev))
+		bd_early_sync(disk, bdev_whole(bdev));
+
 	bdev_yield_write_access(bdev_file);
 
 	if (holder)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 98e21b4cbf32..04d378818c76 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -74,6 +74,7 @@ struct block_device {
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
 #endif
+	int			bd_closers;
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
 	 * path
-- 
2.56.0

