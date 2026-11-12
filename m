Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470331;
	b=3mOMnnpj9K3l8SsN6Ow5JCOBOCi40g+y8lnkf6rQ2mxasHtO/lz/kZ/mZbpBUBqqJn/R
	 t8Mf61WOIpO3G9/CsR+QGlGE1JOHOsQIS+hGQ0zvXcUseqOOxtRnQwxCK3nuDrsUuZpoK
	 UkN2IieUh8TSKJX3dkMfeNNnmH7XV2e5E5xhle7/AETUelTsOkBzkI2qklHuUf9yD1OjV
	 4ssrfiKcXvpukWSLqbx8LvuEdGAljTF7v6/LGkzokwufCDUW1XsYn4UDOiEfp4oTnLlDM
	 MtEcKVbHijBCuVzhNkC8llTJQohh+ZF0nmbCzW+PIqm+ooLU+n2MkD5jKB2Y9Kpc1XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470331;
	h=DMARC-Filter:DKIM-Signature:Message-Id:X-Original-From:
	 Content-Transfer-Encoding:X-Lms-Return-Path:To:From:Mime-Version:
	 X-Mailer:Cc:Date:Subject:Content-Type;
	bh=+4Pj5fMw5JaEDS11w0GPPkKr9F4BJw0sbKvK5YLXRt0=;
	b=W1EFoUPNpIdrucP571I66UAvW6LrhiCBopaFkF6Dsh8RDkA5iegr1QD2e5m+ayLISsDs
	 Bjs847Ufm/9dxAZ8AkdUpfOls/9kh58b4vEEhcP+bU52L/hsAsRZXzPLc5oE8/dW3Ydu0
	 n8jjEocWDQ4Z1tkDKxTqZCqmQ15PNagTc9JKG3tz9QzLFlyKVhKurN5m6bzPygAg32ejT
	 XQwPODnnllJFCPON9t0IvRu66Oc8/0o4O/Tv5MgPLRaAxhj0UXK+mP3EP+aQwLXOO1c/T
	 rk7r9Jh4wEQdA/x4afQeWd56wyVwz2uHOGSzLa1fV2OEK7ld+VR1g51NORiM7KJf/HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=Q0Mk9aCK;
	arc=none smtp.remote-ip=209.127.231.113
Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDB606A323
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 07:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EFDB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=Q0Mk9aCK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794470324; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+4Pj5fMw5JaEDS11w0GPPkKr9F4BJw0sbKvK5YLXRt0=;
 b=Q0Mk9aCKdAJA3rDaA59iWWcvmbXh9j+ne6ojSR4BPyTmCTiXP347xaTt0rkk/NDl3PPOuT
 C8idSDvHge3bmYI76Qd699UMx1q9FdpdWRp/O6uDlu7faMN9G6I0MzB9zDN2HmFrOASFVr
 lzQnpPuptdCiBVCGNddSTGZenv9QH26qZUpjdFk/CgMu8NWA5Pe0AtHfI6simmSGI5SH+j
 kE7ucH6ry4Gnudx4WS/0xXUx1tRlEZ0rFyeqxN0iAp956U6R/jOkcczW/xE+/32COPZeMm
 fzIl3SwdPgVTZclFyrPF4k83iMTfTOM5zzyYnbZn1OptF6feSZwf7FNTb7Sz2g==
Message-Id: <20261112075806.53821-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26af571b2+901462+vger.kernel.org+zhaogongyi@bytedance.com>
To: "Jens Axboe" <axboe@kernel.dk>
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jan Kara" <jack@suse.cz>, "Zhao Gongyi" <zhaogongyi@bytedance.com>
Date: Thu, 12 Nov 2026 15:58:06 +0800
Subject: [PATCH] loop: protect geometry changes in loop_set_status
Content-Type: text/plain; charset=UTF-8

LOOP_SET_STATUS accepts offset and size-limit changes while a filesystem
is mounted on the loop device. An offset change can redirect filesystem
I/O to different backing-file sectors, risking data corruption. Shrinking
the size limit can remove sectors the filesystem still uses. A rejected
request to change geometry can also invalidate the block-device cache
before validation.

Validate the request before invalidation. Claim the whole loop device for
geometry changes, including ioctls through a partition fd, so mounted
sibling partitions also block the change. Keep the claim through partition
scanning. Leave non-geometry updates such as AUTOCLEAR available while
mounted.

Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
The earlier attempt, commit 08e136ebd193 ("loop: don't change loop device
under exclusive opener in loop_set_status"), claimed every status update.
It was reverted by commit a6abd64e145c ("loop: revert exclusive opener
loop status change") after a udisks unmount regression.

Tests:
- QEMU A/B: mounted whole-disk and sibling-partition geometry changes
  returned -EBUSY with this patch.
- Non-root udisksctl loop-setup/mount/unmount/loop-delete passed.
- A flag-only AUTOCLEAR update while mounted succeeded.

 drivers/block/loop.c | 89 ++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 32 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a3325ceab484..d122cb008811 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -803,17 +803,7 @@ static void loop_free_idle_workers_timer(struct timer_list *timer)
 	return loop_free_idle_workers(lo, false);
 }
 
-/**
- * loop_set_status_from_info - configure device from loop_info
- * @lo: struct loop_device to configure
- * @info: struct loop_info64 to configure the device with
- *
- * Configures the loop device parameters according to the passed
- * in loop_info64 configuration.
- */
-static int
-loop_set_status_from_info(struct loop_device *lo,
-			  const struct loop_info64 *info)
+static int loop_validate_status_from_info(const struct loop_info64 *info)
 {
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
@@ -835,12 +825,18 @@ loop_set_status_from_info(struct loop_device *lo,
 	if (info->lo_offset > LLONG_MAX || info->lo_sizelimit > LLONG_MAX)
 		return -EOVERFLOW;
 
+	return 0;
+}
+
+static void
+loop_set_status_from_info(struct loop_device *lo,
+			  const struct loop_info64 *info)
+{
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-	return 0;
 }
 
 static unsigned int loop_default_blocksize(struct loop_device *lo)
@@ -951,9 +947,10 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		goto out_unlock;
 	}
 
-	error = loop_set_status_from_info(lo, &config->info);
+	error = loop_validate_status_from_info(&config->info);
 	if (error)
 		goto out_unlock;
+	loop_set_status_from_info(lo, &config->info);
 	lo->lo_flags = config->info.lo_flags;
 
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & BLK_OPEN_WRITE) ||
@@ -1140,24 +1137,47 @@ static int loop_clr_fd(struct loop_device *lo)
 }
 
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status(struct loop_device *lo, blk_mode_t mode,
+		struct block_device *bdev, const struct loop_info64 *info)
 {
+	struct block_device *claim_bdev = bdev_whole(bdev);
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
+	bool claiming = false;
 	unsigned int memflags;
 
+retry:
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
-		return err;
+		goto out_abort_claiming;
 	if (lo->lo_state != Lo_bound) {
 		err = -ENXIO;
 		goto out_unlock;
 	}
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		size_changed = true;
+	err = loop_validate_status_from_info(info);
+	if (err)
+		goto out_unlock;
+
+	size_changed = lo->lo_offset != info->lo_offset ||
+		lo->lo_sizelimit != info->lo_sizelimit;
+	if (size_changed &&
+	    !((mode & BLK_OPEN_EXCL) && bdev == claim_bdev) && !claiming) {
+		/*
+		 * lo_offset and lo_sizelimit are whole-device geometry.
+		 * A partition fd does not own sibling partitions, so claim
+		 * the whole loop device before changing the mapping.
+		 */
+		mutex_unlock(&lo->lo_mutex);
+		err = bd_prepare_to_claim(claim_bdev, loop_set_status, NULL);
+		if (err)
+			return err;
+		claiming = true;
+		goto retry;
+	}
+
+	if (size_changed) {
 		sync_blockdev(lo->lo_device);
 		invalidate_bdev(lo->lo_device);
 	}
@@ -1165,9 +1185,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O needs to be drained before changing lo_offset or lo_sizelimit */
 	memflags = blk_mq_freeze_queue(lo->lo_queue);
 
-	err = loop_set_status_from_info(lo, info);
-	if (err)
-		goto out_unfreeze;
+	loop_set_status_from_info(lo, info);
 
 	partscan = !(lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 		(info->lo_flags & LO_FLAGS_PARTSCAN);
@@ -1178,7 +1196,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* update the direct I/O flag if lo_offset changed */
 	loop_update_dio(lo);
 
-out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
@@ -1190,6 +1207,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo);
+out_abort_claiming:
+	if (claiming)
+		bd_abort_claiming(claim_bdev, loop_set_status);
 
 	return err;
 }
@@ -1267,7 +1287,9 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 }
 
 static int
-loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
+loop_set_status_old(struct loop_device *lo, blk_mode_t mode,
+		    struct block_device *bdev,
+		    const struct loop_info __user *arg)
 {
 	struct loop_info info;
 	struct loop_info64 info64;
@@ -1275,17 +1297,19 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT;
 	loop_info64_from_old(&info, &info64);
-	return loop_set_status(lo, &info64);
+	return loop_set_status(lo, mode, bdev, &info64);
 }
 
 static int
-loop_set_status64(struct loop_device *lo, const struct loop_info64 __user *arg)
+loop_set_status64(struct loop_device *lo, blk_mode_t mode,
+		  struct block_device *bdev,
+		  const struct loop_info64 __user *arg)
 {
 	struct loop_info64 info64;
 
 	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
 		return -EFAULT;
-	return loop_set_status(lo, &info64);
+	return loop_set_status(lo, mode, bdev, &info64);
 }
 
 static int
@@ -1468,14 +1492,14 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_status_old(lo, argp);
+			err = loop_set_status_old(lo, mode, bdev, argp);
 		break;
 	case LOOP_GET_STATUS:
 		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_status64(lo, argp);
+			err = loop_set_status64(lo, mode, bdev, argp);
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
@@ -1569,7 +1593,8 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 }
 
 static int
-loop_set_status_compat(struct loop_device *lo,
+loop_set_status_compat(struct loop_device *lo, blk_mode_t mode,
+		       struct block_device *bdev,
 		       const struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
@@ -1578,7 +1603,7 @@ loop_set_status_compat(struct loop_device *lo,
 	ret = loop_info64_from_compat(arg, &info64);
 	if (ret < 0)
 		return ret;
-	return loop_set_status(lo, &info64);
+	return loop_set_status(lo, mode, bdev, &info64);
 }
 
 static int
@@ -1606,8 +1631,8 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & BLK_OPEN_WRITE) || capable(CAP_SYS_ADMIN))
-			err = loop_set_status_compat(lo,
-				(const struct compat_loop_info __user *)arg);
+			err = loop_set_status_compat(lo, mode, bdev,
+						     (const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,

base-commit: 8bb045949e86cc2e929e868f52de3fa86c379e30
-- 
2.39.5 (Apple Git-154)
