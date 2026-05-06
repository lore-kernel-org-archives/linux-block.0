Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100EC2FF
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029385; cv=none; b=plkxmVaPCtebms8TQIHzCrYbYF8CAt1I1uO3fzKUAVedLrn2x43SApQQxSiNHsAxmWnJEMOoZ5RuMvHxsDQ3/k2C++I/bXFcGmaPCIov+b9dSNzstim154+1xet3dVsZCKjMZKTvB9+HOb7cIT4kqD25tGYsJcdOl0VPQuujIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029385; c=relaxed/simple;
	bh=OqWi5XA8OwanHvCQujiLynMqau3YrCnyAdLc8NKQJ1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JQ9Q5x4slY5XzeJ1/koPIqGlCV0sM3QVnABeUd2AgMU8hUwrTI7wHPGBO5g2sxj1zZXT2hx5Rr67RqT1ez+7uL++KotG2yZuKRme9QH0BNM2S1Z39cY7aNPIpi0BYAcnw05oO9AKt9cTEcIWtBDHdqd1ikAV+yPrmZlTFeKgpkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnSXRxyC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnSXRxyC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b788a98557so48331435ad.2
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 18:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778029384; x=1778634184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ItNnWN8t0HB3bWK1Su1xgxa27ZWHAQBjaZPc/nyjiw=;
        b=WnSXRxyCiIQkWGlouI2PQ0QXf7knmN135qx81IvGcQvbNt8YlzDaF5BJEYXOdy+K1C
         xIhHL8Z/Ik2n4PQaudV+glW8bKTT4UA7tMgoxDAWsot1UrFEFgp4+2HsTnblv6q+pFVz
         duDdNLATpWZbxBcMMWrmHpm4ETVaDza8TYZL38bNFadd/cJf1diwbwLEWaRScT8OYr+L
         zFb+IIJBw3JO1ccNsfFjT3fX5xwAUTTRqpuyYkgqIJLrif60EpR8hr2oDyqqSvEiTKGt
         4kNoVF74qhHEMqGjWwK1JAtdnKrs9XGoIDTj3+OmdOzF4N5KqQ/ysgUhfTtMCKGcuJbP
         4TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778029384; x=1778634184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ItNnWN8t0HB3bWK1Su1xgxa27ZWHAQBjaZPc/nyjiw=;
        b=blxWSz/chveR04sFXE+3iP/+/DXFQ0bmsDWSvlwqqejRouN3CoX/l5Le4Me6khEvVe
         oWAFQiwBunVww09VBFFwdDdr9DHtfqhT/gEyVytskphQWofFHzs7MEqc/VIbcIS8cnt1
         OENzGh0dV8+orIGhLyJEgUQ2EHC9mw8YAPfE4+HpRKZ1+rgu4i6jcf0Ie83TkrALkwt9
         FsWCeZCB0P2i9k3YXGu8rN8vsgxTEUJoK7cwqyrObEdP8RTeGNGHHdAtz8ieDqlWCZO/
         086jQ4koTvryfCM+VtN3EiXxTydEtXP7L6EhxAGqGpgHp77mYXpkg7ZDVOtzwy5a5fwj
         Z0qA==
X-Gm-Message-State: AOJu0Yz2WkZ7HbCKGRDsf/E0E9Vh+PINuz3+JXBZ3jhyYUjhkyJMXFx9
	blXJydIiEJ9tj1W9bxG09ceHJf7cLxKn9yutk2J/G49IB9UqmuAb5hnc
X-Gm-Gg: AeBDiesWaA5/QQXJi0v6cluQr1X/sxkQbyoKNf9MmRjujjB1sol3hr46fXAqFMb2UVn
	k0SepwabQbkjWxEWvF+wDNgEYyvOEkMk+yllBZmRqQzrSKMJX9CsIgW4wNJ8NCQql/Hp1jDieww
	tD8NA/c2vavjj2L7RtYMD8L8NbOs8Y/t1KL1Xj4e8iyMvy34cBwHQzmSGaUGajexJv6AEiE8/mD
	fHth2jXD5KHvC5ZAG3HtGMYteLTItHD6nzHsPmt+zBRpaGWcWEKgH8KAth/g2hs9STlkEgkMSMv
	UqHel+oizRQ1mWkg0ACBlfiKV505vor2ga5pejvvEWinErdZaLtjqpdTdm5W6kiIXFoIp4kNgHt
	wBJFOGJlHd6yLmPi9pXfr/RhGWBkvh4T6PqB0mA6VCN7d7dmmEUUDjnwDFgq6UjmVpjRw+3tx5K
	Hc3Vi9LZtvCK7QQSlWgeRzX9NaPaT8
X-Received: by 2002:a17:903:3887:b0:2b9:4941:7f6e with SMTP id d9443c01a7336-2ba792b53damr11720365ad.2.1778029383778;
        Tue, 05 May 2026 18:03:03 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bd2bd0csm5116705ad.12.2026.05.05.18.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 18:03:03 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: efremov@linux.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Cen Zhang <zzzccc427@gmail.com>
Subject: [PATCH] floppy: force media-change checks when clearing events
Date: Wed,  6 May 2026 09:02:48 +0800
Message-Id: <20260506010248.3275696-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

floppy_open() tries to make blocking read/write opens perform a fresh
media-change check by clearing drive_state[drive].last_checked before
calling disk_check_media_change().  That timestamp is also updated by
disk_change() when another FDC operation observes that the disk-change
line is clear.

The worker path that calls disk_change() is not serialized by the
floppy_mutex/open_lock pair held by floppy_open().  A worker can therefore
store a recent jiffies value after floppy_open() stores zero and before the
synchronous disk_check_media_change() call reaches floppy_check_events().
The checkfreq throttle can then treat the media-change state as fresh and
skip the hardware poll that the open path explicitly tried to force.

Use the block layer's clearing mask instead of a racy timestamp sentinel.
When DISK_EVENT_MEDIA_CHANGE is being synchronously cleared, bypass the
checkfreq throttle and poll the drive.  Periodic event checks still use
last_checked to avoid unnecessary polling, and floppy_open() no longer
needs to write last_checked itself.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/floppy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 92e446a643712..7217db0b907b3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4051,7 +4051,6 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
 		fdc_state[FDC(drive)].rawcmd = 2;
 	if (!(mode & BLK_OPEN_NDELAY)) {
 		if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
-			drive_state[drive].last_checked = 0;
 			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
 				  &drive_state[drive].flags);
 			if (disk_check_media_change(disk))
@@ -4092,7 +4091,9 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags))
 		return DISK_EVENT_MEDIA_CHANGE;
 
-	if (time_after(jiffies, drive_state[drive].last_checked + drive_params[drive].checkfreq)) {
+	if ((clearing & DISK_EVENT_MEDIA_CHANGE) ||
+	    time_after(jiffies, drive_state[drive].last_checked +
+			       drive_params[drive].checkfreq)) {
 		if (lock_fdc(drive))
 			return 0;
 		poll_drive(false, 0);
-- 
2.43.0

