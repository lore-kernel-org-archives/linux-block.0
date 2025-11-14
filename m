Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC1A3254A7
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763131486; cv=none; b=UUdcc237gcxT2WUZgErZfowJOfgNuS8fAQYk1wzGrBmbHXr4X8NN/yGq3eVOeolH/u8Q1kXN1/xiDAHryIykNmSOk7aSbuu2phdElW2rc8ux+bk2kvGre9I6E05rrYluZmYEn6y5hHqqyqZMrMev/6z77Aax7ZiCEbofjdiI9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763131486; c=relaxed/simple;
	bh=ri3Ab/w8ylepNYDhS7++udAmqB7j+tQzODtC2zg91p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWt+m2RA4OcEnu+3xMgk5NV0JswaQkyVIv95QOFyRGeLI+UMLtw1+vBTlFC1vAk1bOZ3eu3noMh9Hi+aSu45k5L5o6zbViAX0leJL7VR31w2Envl+270j1q7+XHR5rhUy8lMongpsu94pQnoms1bU8MNpc5Eq/TJ2UfOwBlpHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9B9K/ha; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9B9K/ha"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f2b29b651so194866085a.0
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 06:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763131483; x=1763736283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWteGZHapM/ld2g8RPEQnKVKieUk3L8Us0utHpeCavw=;
        b=E9B9K/ha46D26PJezHpYj1Qq37r9xf9hnuH4vrf7MR6iHdRON8DCOZ7v2H+2GUZ9uL
         tw5riJIB4bPh0iRxPAzvc2gcHFxLV7fd4SOviyu92nRkFKOj3flpKGs0WbcJ1kcm9tRS
         hlYv9+xT0wBFbJK1vvyiHJxphi3NrgxbmxsODU4f3sy+R8AqTtF6uTadUVQeUPQtOaEK
         16PZ/RcYDCyO7FMHIg6manGj28bv+d87em3RiygF8oOJIKT4oR6UqkNN+OPaYOdPXhPD
         m+PbKw/Q/uQ4iZK8mHcBC+kGcEk4VcwN2JebYBo1q+8Qh3cdHIntee2UloRw4FJpV1GG
         r0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763131483; x=1763736283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWteGZHapM/ld2g8RPEQnKVKieUk3L8Us0utHpeCavw=;
        b=OlRjZdRTPCLeVBDYjlDYWl0ikohyo3+txvqQMjR/kFFgpe8vig0KDmKaQwFqSxKYWb
         Fiuoo+bwgU0mEBeX6/55eFDFpyPxMmLhc6TrraZCpvtQtCiB3z+7pPHaFWuTxYJTur2H
         3Y9Ct4HU2zu9Q1aK58nS1LaeMZdZehfF4Y2+lKHdae5U1e++anGiT/0fc9ckHPZqLH5j
         Pp1W0bShaxB1upCBcU54dgAWa9vwY3BQbU8Riz7qlMblhKm5vLsmHQ+p+WM+HNz2UzFK
         B9Xj+DJG23ypRp4Ayg2GKxjsmnIAnIR3HpjICUSysuID+uH96kckmTyumuRJM20V1wGI
         YC6A==
X-Gm-Message-State: AOJu0YxS2xpKgiN/DvaUVDco0NC1eoWEVQuQ9VjrKXVCA5GxqZVXt5Cr
	eOKueVFNDQySindF/SE2vtJnF0sDCP0JfFSuyBBDQyr8cZP11IDoPY/w
X-Gm-Gg: ASbGncvkb3t3L1dE/+f3AeSD8Alq5C1oSCwhLOAQPs47Q/Nu5weQqlanK9V8u0kd1gO
	xTDJ7uq+xbX8CtKHFY6iDgfRyPetrofz0xv1URIjvofJXJ32soYmNEiVmGvjlJwKtcpOv6HfoIq
	UyimPvVfGy7k+wZ94M8PyfkavVyLbV9m8oI00QSKC4l7DHJ3swbCovQYRESBignzoAQoVXo8hlp
	vH3+Z3KUN2vAm+t1MOYlSS4CdI/0AgScWhVsHhj/2KOld3yXx/KrCZUhsgHJE65juo7eWoJJe8O
	5PDNuL5xaVN7kpRdkIigOzeEocvo8JZLYnTFksSaHYX+HgW7KZP1Cn7FuIv8y9MPauv0OXtQGxz
	lHly7X+raZY8rqOqcM287mT49QgiYL/ikbBrxR+jcjXmNMUq2I8vP3bbBTgsjzQWUDG67Cyrq67
	/Z7PpbK0Qm1oY3bJiZ0EX4K6/ZPvPb3+g=
X-Google-Smtp-Source: AGHT+IFPjQlSqC/ss4lwRCrHnzgS910DC//wiBOCNwnW0xCnYqx8uCQ1I2xzaPFYMjeaq4Ndw+mQCQ==
X-Received: by 2002:a05:620a:f15:b0:8b2:7726:c7cd with SMTP id af79cd13be357-8b2c31a622amr400786885a.49.1763131483265;
        Fri, 14 Nov 2025 06:44:43 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af048749sm344232285a.49.2025.11.14.06.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 06:44:42 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jack@suse.cz,
	cascardo@igalia.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH] loop: don't change loop device under exclusive opener in loop_set_status
Date: Fri, 14 Nov 2025 09:42:05 -0500
Message-ID: <20251114144204.2402336-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
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
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
ML thread for previous, misguided patch idea:
https://lore.kernel.org/all/20251112185712.2031993-2-rpthibeault@gmail.com/t/

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

