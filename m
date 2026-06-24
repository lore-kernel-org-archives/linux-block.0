Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239083911AD
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285540; cv=none; b=PFCGyGMY+O/8n3QTN0W6D3v0lE70ny/AE3jkyurmNFTwg3G03BexCYA084OVs3HRAODFtFSfJoDeHbWa0xB7EUlbIWlDruCttugNYhsyzZim6dUDBnkLU4uxGfeF/YRgS9wGa62vPshGBTgBt39pooxiIURTPhq1eJSkB6WYXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285540; c=relaxed/simple;
	bh=jFsQwEmUDeKBq9PPlKD/SVbqQCOI0IJCz+Gxm+CmeNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U48rNSTZWVt7nL0ejQJ16pUU3E6uIovMGbWE1u3hvn/DuU+JANiGsKWmE8SCALu4zZi5YaRmFXErhaRQQZS2x7UzTQhQXay/qpc/PQYzU8Oq0Ru9gqs2qk/JnrhcD7w7lneDHBHYKHNp0BWKMldt+EwbcKSBOPQgAyT+aY+B5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPxStTlM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPxStTlM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8454160043aso672761b3a.3
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782285538; x=1782890338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RuGLgY6Mn/nNU0Ony2UCzIMI9JkYUZJKubRBW2J0Ojs=;
        b=RPxStTlMOeKPa7xkPdG/lqJYPB0zfiwNp4Qh/lFSd02GLUdbk3mwAIvV7DobruRVh/
         LC0C/zYohVBtn/qV6PoLj1cnDzHcAF8I3Vce/CAV8vEhIK/blI+xnBJmglFnQF2Ww3gn
         nlU8aXjiw7DHDEgLzNsDHXgMEGA3McTRfh45UF/mnjozpzVj96ez8/Ur531DXJJO+EUs
         srSfHzhF1pPvKXUMq3BDOevlDQPsCf69cWTCWJ2DI1ITgnGkwVfkgi2895+cfFaOFzp4
         P/cbdznv0WHsqXTtVDzqFw5gGIVmPCXEi1HNdlZ0uUcNMRgr6CIchrpH/E1rYKcxsP2W
         D4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782285538; x=1782890338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuGLgY6Mn/nNU0Ony2UCzIMI9JkYUZJKubRBW2J0Ojs=;
        b=fM8zcM8Mfx2cK4qVaFDBPrHI+EeWr6MmSm7HubxR80DsVnzJnJ+2v4WNOhD/rWSNL4
         7Kl+yTGFYnvrpgouWaNMnL8A6JXnRIH5Rq35yEARf2tZmlau6bcQwMkuHvvTRxw2EztL
         +Ltn/akkd/P/A8HtTP7ZwAk96fny6fdAa3ZQ+kiwlpPnPZrGyZzegyeavu0dFYyfETnV
         NnniEcrmyYnFah0N0y0fiAXbZ0tK059pehuzAQJ/1OP/bG64o7HoZRDtkHdlX3lmp2pH
         +pAcgqtWvAWwsrWWlM/uHP/4aUy0XVSfJs38rHaG2lf/V4iNppBghjgh6jG6zMIhYhnD
         E4kQ==
X-Gm-Message-State: AOJu0YyBQ43aDi7+EF/vqUyKmZhfffW36OOJgMN77vHofkbuzr7aevVZ
	BtQ9GjnboBSI+vj3u5Tfj3uEQHOShnKepYqaW9up8qQJbu0wVwwFITk6
X-Gm-Gg: AfdE7ckaw1W/8AVVENn8a3fUBJGswsdLo8idRpqPHOB0BDCQd+02QAJEArCkjflfnBk
	IKQM3lIr1Ip//jPohnIHEO6xOknqBXembUo5qhluemE7tyYhyYqpJ3yyhXUNmOC89ewOwN+7ogD
	YLeBGFNjJ8dgBq+jp0Jgp6ydw7QBfa/8bzNgceB9H9Lx/FxJPr1p7Pd4F7jHqgZqiAWKvcj15yj
	tXDMz/jT89g1xDCwr/Fs2YG+Pbtay5Tro9PGFDGu2snkyGxRNw/p0TFRVIsNd33+Kj/srzql3PT
	e+yVh3ls20v92a+L/ji9rpRxGrmSq1JhicO1m78LDEvuH+z7s1lkYwxb4ysTsCb32sFXki5bNoA
	LgafmEqyJU2/3uMQhlw2ap80O4VOlf7gxEy8IUT/QvoA8v0yuqiOe/kF5fXhjmsaBbWGbqkkEy+
	5p4t2iFlo=
X-Received: by 2002:a05:6a00:f8c:b0:842:5a8d:303a with SMTP id d2e1a72fcca58-845a27962d1mr3235351b3a.37.1782285538243;
        Wed, 24 Jun 2026 00:18:58 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d7d6bsm1334508b3a.35.2026.06.24.00.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:18:57 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] loop: serialize backing file swaps with sysfs readers
Date: Wed, 24 Jun 2026 15:18:51 +0800
Message-Id: <20260624071851.358250-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The backing_file sysfs attribute formats lo->lo_backing_file while holding
lo_lock, but LOOP_CHANGE_FD replaced lo_backing_file without that lock.
The old file can then be fput() after the swap, and that fput may be the
last reference. This leaves a sysfs reader that observed the old pointer
able to run file_path() on a file whose final put is underway.

Validation reproduced this kernel report:
BUG: KCSAN: data-race in lo_ioctl / loop_attr_do_show_backing_file

The buggy scenario involves two paths, with each column showing the order
within that path:

sysfs backing_file show:            LOOP_CHANGE_FD:
1. Take lo_lock.                    1. Save old_file from lo_backing_file.
2. Read lo_backing_file.            2. Store the replacement file pointer.
3. Pass it to file_path().          3. Drop the loop-owned old_file ref.

Serialize loop_assign_backing_file()'s pointer store with lo_lock, the
same lock used by the sysfs show path and by __loop_clr_fd(). This keeps a
sysfs reader that entered before the swap ordered before the old file can
be detached and fput(), and makes readers entering after the swap see the
new file.

Validation reproduced this kernel report:
[   56.673265] BUG: KCSAN: data-race in lo_ioctl / loop_attr_do_show_backing_file
[   56.674430] write to 0xffff888101d21060 of 8 bytes by task 498 on cpu 1:
[   56.675365]  lo_ioctl+0x99d/0xca0
[   56.675819]  blkdev_ioctl+0x2bc/0x380
[   56.676331]  __x64_sys_ioctl+0xc7/0x110
[   56.676846]  x64_sys_call+0x1092/0x1fb0
[   56.677372]  do_syscall_64+0x100/0x570
[   56.677878]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.678777] read to 0xffff888101d21060 of 8 bytes by task 489 on cpu 2:
[   56.679617]  loop_attr_do_show_backing_file+0x51/0xe0
[   56.680280]  dev_attr_show+0x3b/0x90
[   56.680769]  sysfs_kf_seq_show+0x139/0x1e0
[   56.681321]  kernfs_seq_show+0x9c/0xb0
[   56.681823]  seq_read_iter+0x2b3/0x830
[   56.682336]  kernfs_fop_read_iter+0x26b/0x2d0
[   56.682917]  vfs_read+0x414/0x5c0
[   56.683393]  ksys_read+0xa3/0x130
[   56.683844]  __x64_sys_read+0x41/0x50
[   56.684344]  x64_sys_call+0x1efb/0x1fb0
[   56.684856]  do_syscall_64+0x100/0x570
[   56.685364]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.686252] value changed: 0xffff888104d62900 -> 0xffff888104d53680
[   56.687275] Reported by Kernel Concurrency Sanitizer on:
[   56.687963] CPU: 2 UID: 0 PID: 489 Comm: loop_changefd_r Not tainted 7.1.0-02794-g5c7804e3279c #1 PREEMPT(lazy)
[   56.689251] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.690673] ==================================================================
[   62.334003] ==================================================================
[   62.334986] BUG: KCSAN: data-race in lo_ioctl / loop_attr_do_show_backing_file
[   62.336145] write to 0xffff888101d21060 of 8 bytes by task 498 on cpu 3:
[   62.337000]  lo_ioctl+0x99d/0xca0
[   62.337452]  blkdev_ioctl+0x2bc/0x380
[   62.337955]  __x64_sys_ioctl+0xc7/0x110
[   62.338468]  x64_sys_call+0x1092/0x1fb0
[   62.338993]  do_syscall_64+0x100/0x570
[   62.339493]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   62.340381] read to 0xffff888101d21060 of 8 bytes by task 495 on cpu 0:
[   62.341235]  loop_attr_do_show_backing_file+0x51/0xe0
[   62.341900]  dev_attr_show+0x3b/0x90
[   62.342385]  sysfs_kf_seq_show+0x139/0x1e0
[   62.342943]  kernfs_seq_show+0x9c/0xb0
[   62.343447]  seq_read_iter+0x2b3/0x830
[   62.343955]  kernfs_fop_read_iter+0x26b/0x2d0
[   62.344537]  vfs_read+0x414/0x5c0
[   62.344988]  ksys_read+0xa3/0x130
[   62.345438]  __x64_sys_read+0x41/0x50
[   62.345937]  x64_sys_call+0x1efb/0x1fb0
[   62.346446]  do_syscall_64+0x100/0x570
[   62.346956]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   62.347832] value changed: 0xffff888104d50f00 -> 0xffff888104cf4f00
[   62.348871] Reported by Kernel Concurrency Sanitizer on:
[   62.349548] CPU: 0 UID: 0 PID: 495 Comm: loop_changefd_r Not tainted 7.1.0-02794-g5c7804e3279c #1 PREEMPT(lazy)
[   62.350823] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   62.352260] ==================================================================
[   65.676721] ==================================================================
[   65.677703] BUG: KCSAN: data-race in lo_ioctl / loop_attr_do_show_backing_file
[   65.678870] write to 0xffff888101d21060 of 8 bytes by task 498 on cpu 0:
[   65.679712]  lo_ioctl+0x99d/0xca0
[   65.680166]  blkdev_ioctl+0x2bc/0x380
[   65.680673]  __x64_sys_ioctl+0xc7/0x110
[   65.681187]  x64_sys_call+0x1092/0x1fb0
[   65.681707]  do_syscall_64+0x100/0x570
[   65.682214]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.683113] read to 0xffff888101d21060 of 8 bytes by task 497 on cpu 2:
[   65.683955]  loop_attr_do_show_backing_file+0x51/0xe0
[   65.684617]  dev_attr_show+0x3b/0x90
[   65.685109]  sysfs_kf_seq_show+0x139/0x1e0
[   65.685663]  kernfs_seq_show+0x9c/0xb0
[   65.686165]  seq_read_iter+0x2b3/0x830
[   65.686679]  kernfs_fop_read_iter+0x26b/0x2d0
[   65.687265]  vfs_read+0x414/0x5c0
[   65.687720]  ksys_read+0xa3/0x130
[   65.688171]  __x64_sys_read+0x41/0x50
[   65.688665]  x64_sys_call+0x1efb/0x1fb0
[   65.689177]  do_syscall_64+0x100/0x570
[   65.689688]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   65.690582] value changed: 0xffff888100c52600 -> 0xffff888104d54180
[   65.691615] Reported by Kernel Concurrency Sanitizer on:
[   65.692309] CPU: 2 UID: 0 PID: 497 Comm: loop_changefd_r Not tainted 7.1.0-02794-g5c7804e3279c #1 PREEMPT(lazy)
[   65.693596] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.695035] ==================================================================
[   68.697953] ==================================================================
[   68.698927] BUG: KCSAN: data-race in lo_ioctl / loop_attr_do_show_backing_file
[   68.700101] write to 0xffff888101d21060 of 8 bytes by task 498 on cpu 1:

Fixes: 05eb0f252b04 ("loop: fix deadlock when sysfs and LOOP_CLR_FD race against each other")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 drivers/block/loop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 310de0463beb..45937741fcb6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -503,11 +503,18 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 
 static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
 {
+	/*
+	 * Serialize the pointer update with sysfs backing_file show, which
+	 * formats the file path under lo_lock without taking a file reference.
+	 */
+	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = file;
+	spin_unlock_irq(&lo->lo_lock);
+
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
-	if (lo->lo_backing_file->f_flags & O_DIRECT)
+	if (file->f_flags & O_DIRECT)
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
 	lo->lo_min_dio_size = loop_query_min_dio_size(lo);
 }
-- 
2.43.0

