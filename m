Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E22283FD4
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936018; cv=none; b=fHSTRvCqY4vp+cEUvk5P2Vn+2C6MFrHCVj95EWqSlvNiy2HVBS+riho8nki7hVVum/vvtmBj1rrXqXth4GhqomJoEZ6C79+c+TmxeC3u2QeRNxw9Z0rlMqLbxgy7GPNNcFJUdqK8t5UfJGuPocMTmn7dLCbdYlXnIVS9mCjaPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936018; c=relaxed/simple;
	bh=FPTpwHFg45tD18LXEsesNQ+bWQLa44VC2D/E/Z2npAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QfyDEmeAT1adrt1LAWt5mA9/oi8MoP5UyHhwLJqT+g08+gjo+eDSTiE/75vEAglgq92Hfp1Q3dJs3FvUlQ4LdK4xpjqzkkKZeUa3UuVGhet3Tha+whu/fs8yIrHczKHrxM1NQtlJHD7dEdXmZeZl5zLWfpuKS7EX8zek6K/0NK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO3+08Py; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO3+08Py"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d932cc948so1854812a91.2
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 22:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936016; x=1775540816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXKA5ht7Zy9JGAaY2KftORONRs9LiZlrvJ7zU95HnyE=;
        b=lO3+08PyG0A5poB5VM1h84UsuOtSjvwsMUHFRZwQ3t3njvLBdUw4FhHoZtcS6wbohZ
         XoK+1dKDPJb5JWkW2Cfhk75KoxCCpWes9pwKm0119QmrTsn1kDhrmfpk+QQlr6KJofqT
         S4kGFaIrXO+Kw2k7T9yd+MAcp47crIwRUcwRRKIjojq6Dhxtm/SLfDQX0x8MEI+JkRiE
         O6f4mDLF+NHUqyamuu9Ir1T7IcFJbtX4FpWDBV10NE3pAjacl+/kkRDxj2fRAqFFVaNL
         VF043L1Y1cCbyb8mFidLdALfNewyhXNAAmmRFBnLDGnuCUopSIJa/VfwbuzczvBfUr9i
         01cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936016; x=1775540816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXKA5ht7Zy9JGAaY2KftORONRs9LiZlrvJ7zU95HnyE=;
        b=rzK+m9DXP8h931i/z4vprFidM8MnjJZurEFffLtK7kY1BWf+U9W9TwzRUlY4ITx7Pk
         T5eNIM1YX6hb1Uirqr8iSksUYuF7lFOYpu6pyzjHH0oVT8ioVcchOreH4l0dp9ngroir
         OK4byGh1sn/PYv4HMi6S13tWtecgum5wALNSr038SqlOVfQjUhwLtkj3auWSNTWOCDBE
         ZQFgxbh9uiRmTVj/z3YkC+TcVD0FJEkd1eG6/Wht6hBeG7dlhBX5SrQgn/QjblBwTjRx
         R3niKwE7HOr3iMY2LvN4Bdeb9veVvLaJJTzNF3eNVogtWPxE+bKEiBhQsC2btcXnKxVp
         Y0DA==
X-Forwarded-Encrypted: i=1; AJvYcCW2nREk9Q3JzpajGuy3J3GPgL4mkZALx8ZLJ7qP4q1FidPf6ZsvXWASshvtR7Rpm4OGm2jLyDeyFa7n8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymbje9CA58HUVolAoLF7EG3TvvIvdhQkssfLMzkaQqrMhDFtJO
	Bc/wo0WebVxhZ0oTj7XCKJqwj14ezF5CUSsU+w3C3/xduCWem3UEqmTl
X-Gm-Gg: ATEYQzz1XYsftanF9S4jfoFZpsaPhC99B6Oznfl3bM9Yp50csddF1cJrw32TwHhbvFd
	9JLMwl+cU7M+OcCUz3XbPSsEuk9zOG5cDWgEWSu3GZkZLDs3vnMT/f8emP0OMqD9CD+huq9vQaC
	XBF2N7moxP/HzGk3j3AZclW99G5XVuViUojEEjuanQgEZn+qlixDnBcZIZLcq745n5vYXXiynpT
	o1sXHAMsFuZScW3k5PgGPf9Ttvgy9eqlDbtzH/9/9RkfnQN/IXXS7kgZONCMRkiStZ6Bxfaz2by
	QZ/6/nAuJFLHErkskYU5z9F4g+gtiwNMR4+9Mi84Qah3BLLnHYeO36jojNl2FL9lT7wZyRNqrEO
	atnb5DDkhWfauBWQG8sO/Cte6iIZ/Xar466arUsiYnXri21XUSZ3470t/h//lXVca+Ioo46sT1D
	QAGqtmcwUwIf6oHmvmfXNPPv10zsGysSatIMnJa8W0zHY65zOkc56Sb9kcHVqmM4HzUOInj+8dE
	I9O63SxSrcmUfD8Yg==
X-Received: by 2002:a17:90a:10c9:b0:35d:9bb3:2a31 with SMTP id 98e67ed59e1d1-35d9bb32c11mr5161896a91.25.1774936016165;
        Mon, 30 Mar 2026 22:46:56 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:f56f:ac5b:85d4:f51d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe624756sm527176a91.5.2026.03.30.22.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:46:55 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: axboe@kernel.dk,
	tytso@mit.edu,
	hch@infradead.org
Cc: dvyukov@google.com,
	adilger.kernel@dilger.ca,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: [PATCH v2] loop: block changing lo_offset/lo_sizelimit on mounted device
Date: Tue, 31 Mar 2026 11:16:48 +0530
Message-ID: <20260331054648.4548-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LOOP_SET_STATUS{64} allows changing lo_offset and shrinking
lo_sizelimit while a filesystem is mounted on the loop device.
This effectively mutates the data visible to the mounted filesystem,
which is equivalent to writing directly to the block device.

When CONFIG_BLK_DEV_WRITE_MOUNTED is disabled, direct writes to a
mounted block device are blocked. However, LOOP_SET_STATUS{64}
bypasses this protection because it modifies the loop configuration
through an ioctl rather than opening the block device for writing.

Fix this by checking bdev_writes_blocked() before allowing changes
to lo_offset or shrinking lo_sizelimit. If the loop device has
writes blocked, return -EBUSY. Increasing lo_sizelimit is still
allowed since growing the device is harmless and has legitimate
use cases such as online resize.

Move bdev_writes_blocked() from block/bdev.c to
include/linux/blk_types.h as a static inline function so it can
be used from the loop driver without exporting a symbol.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb32afec111a7d61b939
Tested-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
  - Use #ifndef CONFIG_BLK_DEV_WRITE_MOUNTED instead of exporting
    bdev_writes_blocked(), as suggested by Ted Ts'o
  - Move bdev_writes_blocked() to include/linux/blk_types.h as
    static inline instead of exporting from block/bdev.c, as
    suggested by Christoph Hellwig
  - Allow increasing lo_sizelimit since growing the device is
    harmless, as pointed out by Christoph Hellwig
  - Remove spurious empty line
---
 block/bdev.c              |  5 -----
 drivers/block/loop.c      | 16 ++++++++++++++++
 include/linux/blk_types.h |  5 +++++
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..e0bace1a6c27 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -860,11 +860,6 @@ void blkdev_put_no_open(struct block_device *bdev)
 	put_device(&bdev->bd_device);
 }
 
-static bool bdev_writes_blocked(struct block_device *bdev)
-{
-	return bdev->bd_writers < 0;
-}
-
 static void bdev_block_writes(struct block_device *bdev)
 {
 	bdev->bd_writers--;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..34bbbf3bcb36 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1239,6 +1239,22 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		goto out_unlock;
 	}
 
+#ifndef CONFIG_BLK_DEV_WRITE_MOUNTED
+	/*
+	 * Changing lo_offset or shrinking lo_sizelimit on a mounted
+	 * device is equivalent to modifying the block device contents.
+	 * Block this if writes to the device are blocked.
+	 */
+	if ((lo->lo_offset != info->lo_offset ||
+	     (info->lo_sizelimit &&
+	      (lo->lo_sizelimit == 0 ||
+	       info->lo_sizelimit < lo->lo_sizelimit))) &&
+	    bdev_writes_blocked(lo->lo_device)) {
+		err = -EBUSY;
+		goto out_unlock;
+	}
+#endif
+
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		size_changed = true;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..82ece8737b85 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -84,6 +84,11 @@ struct block_device {
 #define bdev_whole(_bdev) \
 	((_bdev)->bd_disk->part0)
 
+static inline bool bdev_writes_blocked(struct block_device *bdev)
+{
+	return bdev->bd_writers < 0;
+}
+
 #define dev_to_bdev(device) \
 	container_of((device), struct block_device, bd_device)
 
-- 
2.43.0

