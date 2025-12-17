Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5725485A
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 19:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765998199; cv=none; b=pCejEoEF53KPUin25VyaHKBC0tk1+faeUn28MIHLWX5bCzFA4pObtO6glh0NOSc2TjKM/udBuRS5FJLdUnek06Vv2xVTYowelora6qKv8hYL/qkYNLc4WKfGDU1so1L2We3Hf9ATO92OkDWpg7c3H/+MUomCW/pFCQR7OgVRnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765998199; c=relaxed/simple;
	bh=6IPbdt1L4AGkDZACFtU1zcBqo0Cbbff5QZYI76FNr+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvWz2n8cbLt0AXy1baPRiXC0NuTcHqzfCH0hnPvH8jUdjmfZqy6wh1Q5L4NmTMsktUkm+AQCqMtMK6cc2rT9OIzajzyBvKFKyXCNJcqHUBhayXx8GgpySYgml66wvc/IZxHCI5iDdM7VQWj/pSICCMPjMBmnG8JAvwM56hvlEvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTLTw+qg; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTLTw+qg"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5eae7bb8018so579128137.2
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765998197; x=1766602997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oz8NDBC8rkRf0BKM+wNwYegVQjLipzJuVVp9JyHFbTo=;
        b=ZTLTw+qgAC7cXw8GoNUsjoxWRKZgCvpwuzi55V7GDQihbrehL0yTOHqaqm/dcF6vkQ
         tIVieKkO7dk8onaxrkIsL37gIWz4Z9At4WTaG4VOwp7EZjpZtc/+Sf3t9YrM4EoTlolu
         +aTJTsgRSRrQBHBgH5fD0KmSZdrXH+EDuGkIiz53qscm3NOLL7U8ewznmBRyiuSx9Psq
         PlYoxRiVyF+qGCYoJQwRpbR8BvXhTzhdAaVEMPVxRYOHonioNJKe1vl5H53zezYMNlBt
         g5OCi+MXSMhMUVd0k9bQPwdiz7QRujpeZ1e24bWj74VtE0hCzLuldO0DzLP8nIBJ1x9x
         JbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765998197; x=1766602997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oz8NDBC8rkRf0BKM+wNwYegVQjLipzJuVVp9JyHFbTo=;
        b=Mbr6CabRw5Fcx9BX6ZkTsvVb7CCCeZBVI42iGo9dxqt6XV525ydkm73zg1wns2LzMH
         uXiEGfcvdWkJocGuG7pubon11wvIUTySKeqJpMuzpA+PHAP1KSM3mFuTckbSj8j7q6Qp
         GOHdpdBK8kF5UMLo00x42BirgR4BeGLj3Q08qEsbtZxwSl49GpSa6RNE0fqv0bcXzSOw
         yxtiL8GQbXS57aMnzx8OEZ+MRd9svMxE6RnSwSN62xNFDyhhfb5O/T/IIRMwd8OEo7GK
         hYODnL0DGDp2TKBPsNmyWFMqRN8SdUE2FLq2nt3jcY3aD1fzN7J9nF2udzI+F7wSqS1e
         q0og==
X-Forwarded-Encrypted: i=1; AJvYcCXIdWuVJIFfm1TF1PRj+AHxdKuG83ZH8KZra8C8OxcEttegSRPetzhN/fqg1RLS+50a5eiQDo6b3MQItQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MpXPtrExBFxjTSDiKCCruBKxYlyjO9gYezFo5ieDfq5XKHAJ
	cjl4EiXYVvheeINavrlyRJba8Ap4nIDhtUfppU7BbvzNTL5Tqsilrg9L
X-Gm-Gg: AY/fxX5/8gDjo6//L4+6UJlp3uHJskHtvQAUYA8fosIOypNw2jrfH3Q2vSSqtWtPwLu
	3BLLTzPBtD+QA39SJb2wmMcC32vJxN3b/f0IhHhuJ5XyLNAj9BYrG0myztwv5ffZNPNsxhXxxOJ
	oxMewiwibnRI1aTMlp5pmo3ry96Q8rWsTTW/TxeR5t39nPFIwyLCXKukxMo1xMGWgZ0csLGt8/J
	hb14liXVmJazEX2LSOT5bV1Zg1V7jXRA4yW7UNthJ6jgrG4CZhw5nPj1We/jRpvwNdVhkLJ3tBA
	B3Sh+45O9HF+AU3RUh1zHJ8gIRM/op5GhHwJhP1avoT1FZFazufHYkzu25hIMRvwapptti7GIw4
	lV320U6Ui9TlZm5/a6VlrutFCNoJBhHuKkqmqU6zMhRXU+hg38jM4+sDy7Dih7HiTcPS3fDm4Cl
	Cv7Y78Scel29OEYfKEqsCh5IEoY4es63c=
X-Google-Smtp-Source: AGHT+IEtFw7PJ5j7j9LgFaSmuKm/BvvOVGHX9z+Y+/Ht/9IPYaHhHPd/iE63FBwhRQqgHyc5KvxbvQ==
X-Received: by 2002:a05:6102:4498:b0:5dd:a616:69fc with SMTP id ada2fe7eead31-5e827472567mr5852681137.9.1765998196849;
        Wed, 17 Dec 2025 11:03:16 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88c61188285sm1365616d6.44.2025.12.17.11.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:03:16 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: axboe@kernel.dk
Cc: jack@suse.cz,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v2] loop: don't change loop device under exclusive opener in loop_set_status
Date: Wed, 17 Dec 2025 14:00:40 -0500
Message-ID: <20251217190040.490204-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2crvwmytxw5splvtauxdq6o3dt4rnnzuy22vcub45rjk354alr@6m66k3ucoics>
References: <2crvwmytxw5splvtauxdq6o3dt4rnnzuy22vcub45rjk354alr@6m66k3ucoics>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loop_set_status() is allowed to change the loop device while there
are other openers of the device, even exclusive ones.

In this case, it causes a KASAN: slab-out-of-bounds Read in
ext4_search_dir(), since when looking for an entry in an inlined
directory, e_value_offs is changed underneath the filesystem by
loop_set_status().

Fix the problem by forbidding loop_set_status() from modifying the loop
device while there are exclusive openers of the device. This is similar
to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
change loop device under exclusive opener") alongside commit ecbe6bc0003b
("block: use bd_prepare_to_claim directly in the loop driver").

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
v2:
- added Tested-by and Reviewed-by tags for v1

 drivers/block/loop.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 053a086d547e..756ee682e767 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1222,13 +1222,24 @@ static int loop_clr_fd(struct loop_device *lo)
 }
 
 static int
-loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
+loop_set_status(struct loop_device *lo, blk_mode_t mode,
+		struct block_device *bdev, const struct loop_info64 *info)
 {
 	int err;
 	bool partscan = false;
 	bool size_changed = false;
 	unsigned int memflags;
 
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & BLK_OPEN_EXCL)) {
+		err = bd_prepare_to_claim(bdev, loop_set_status, NULL);
+		if (err)
+			goto out_reread_partitions;
+	}
+
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
@@ -1270,6 +1281,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+	if (!(mode & BLK_OPEN_EXCL))
+		bd_abort_claiming(bdev, loop_set_status);
+out_reread_partitions:
 	if (partscan)
 		loop_reread_partitions(lo);
 
@@ -1349,7 +1363,9 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 }
 
 static int
-loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
+loop_set_status_old(struct loop_device *lo, blk_mode_t mode,
+		    struct block_device *bdev,
+		    const struct loop_info __user *arg)
 {
 	struct loop_info info;
 	struct loop_info64 info64;
@@ -1357,17 +1373,19 @@ loop_set_status_old(struct loop_device *lo, const struct loop_info __user *arg)
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
@@ -1546,14 +1564,14 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
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
@@ -1647,8 +1665,9 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 }
 
 static int
-loop_set_status_compat(struct loop_device *lo,
-		       const struct compat_loop_info __user *arg)
+loop_set_status_compat(struct loop_device *lo, blk_mode_t mode,
+		    struct block_device *bdev,
+		    const struct compat_loop_info __user *arg)
 {
 	struct loop_info64 info64;
 	int ret;
@@ -1656,7 +1675,7 @@ loop_set_status_compat(struct loop_device *lo,
 	ret = loop_info64_from_compat(arg, &info64);
 	if (ret < 0)
 		return ret;
-	return loop_set_status(lo, &info64);
+	return loop_set_status(lo, mode, bdev, &info64);
 }
 
 static int
@@ -1682,7 +1701,7 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = loop_set_status_compat(lo,
+		err = loop_set_status_compat(lo, mode, bdev,
 			     (const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
-- 
2.43.0

