Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC22B642
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715053705; cv=none; b=Y4dg1qMtI+TAnQ+I1wPVoQqhcSQQBIHm7yqniztJ6kJVWjy90/GD/KaON/Fc4x208c7iL7zbNxQftXKomNhQ20UVESqLxRRR48ViCFCUiXZTNv3YAUkNcEAdgJSQbblKxv2BF+QaVOX19IWNJoEYSfs3DK2oi0F/NUQkbRS29eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715053705; c=relaxed/simple;
	bh=m/879LQuL8JXETpqluE9o4A4OYLRvuKZ6yO7+lbGxZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fM8sxh6+YyN2oT7o0/6eZ1l18jPWq6V4Qws2Zb/RfNxSJ2KMCY74bmeF9voFmvzvmciSn/EKqFZDDSmnaVEv6EOiTNeEUxC5tJAoC/rOInIuQ0Suv9fQxzfIu4WXJPRb3kfziwIhoPx2d6B9xNnyd6brH+XnWjYxFCgVv+FMH0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zHOTh7I1; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zHOTh7I1"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7dabc125bddso331852839f.1
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715053703; x=1715658503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rj2jBFPI6Z7ZTex3xlLubFd8OE8ofA5lm6spLyhQDT8=;
        b=zHOTh7I1pAPZbfbiooyT/yNoGtGkTpA2TKSEBjS2zhuvtDNWEyvNwecvVPS08WvvA0
         dK7Nqaps5QGoShtKi6RMxQUPYIcVJCOFAnxpaFCsCuYsonRPiFBjl8nhWWoFDHMf2322
         tRKDdsxU5jfLDkmgWxufwqWiwVipcLr04tQq71n2Cj72JP9G90n02slkuuxhqQPMYJCH
         Eas1kg6L1rvXd0ZnVoymMg/u6Oar6zIICIDP9L/ytDPn5I+gkNlmM/mst3ZNajSda2xI
         6ykFoQPIvB65aC3Rws6pyQB7/dRxWNcHBhm0RxeL/YVrBr4kfnnj3mMELqov1cPdK7nH
         tspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715053703; x=1715658503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rj2jBFPI6Z7ZTex3xlLubFd8OE8ofA5lm6spLyhQDT8=;
        b=E/TxdUP0lDuTjYt9va4q532hLgZok1RdUE53v9PPqX/XgcQspgzG9glvriQNTT5B/r
         I/ewohnzhrVV4IFkpKENDFongBpaNyae39POFIuZLSqMqtDXIHlQMFYInngWdVj3VCVA
         rYyMKIiGBvLw0bRVW6vGH+8wu/A2zUC61JmMhuW1IwA3QhI4meiTb1f9Z5xJE9b/SX0b
         iXw2AaXCHMO3P/B4wwtVPjlYFARO5Z38IYZDjo00O4fLS7mPyCJmOP8qrkQ9FhbgxcF5
         DHJz+ZO8zu4aJhOPbSL5x8YIQgVqc6zxAKJZVtO3phej7ZmPctlqoFlYse0xNzZ8rrQq
         q1Zg==
X-Gm-Message-State: AOJu0YxtsvXmMhMqdnJSvmvlZR4Diapp6xLYNAel8tjMrkyZuxcvNw6c
	9y84BBypA6LrrA8YKzqsiHAkI5lDduNEGeATcjrGLR8p7qdvXJR08yvsNFms2NGOqkvkFbzxkMK
	Vl0kYEOiIaOyu9YSUisWWLw==
X-Google-Smtp-Source: AGHT+IF9pz2j6uD0BOLZD3RuF1fODTXrHqY0ZFsVdk4z478cCgDWlZtMQ9jc/1kwXxkxEg9w0eiXgsxELlaELuV1Eg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6602:6c19:b0:7de:de58:3b1f with
 SMTP id ik25-20020a0566026c1900b007dede583b1fmr446358iob.4.1715053702950;
 Mon, 06 May 2024 20:48:22 -0700 (PDT)
Date: Tue, 07 May 2024 03:48:21 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAISkOWYC/32NQQ6CMBBFr0Jm7ZhSixhX3sOwgOkUJiJjWkI0h
 LtbOYDL9/P/+yskjsIJrsUKkRdJolMGeyiAhnbqGcVnBmusM5U5Y+cwd7AblR4oSvOI9YWDr50
 NITjIw1fkIO9dem8yD5JmjZ/9Yyl/6V/dUmKJvq1OFZGxxtOtV+1HPpI+odm27QuXpL1dtQAAA A==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715053701; l=4122;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=m/879LQuL8JXETpqluE9o4A4OYLRvuKZ6yO7+lbGxZ8=; b=WlDNs6XesT9Dq9XcqMxvRoN4jY5WbclObVpngRPBmNc3EItY3fQdpDx6cG5UAUPiIKoksAwrO
 8xLeNDKGNkgBXSrd6KG2KSVE7A647d8GfbwEWE1svFm6xamRks5l0/a
X-Mailer: b4 0.12.3
Message-ID: <20240507-b4-sio-block-ioctl-v2-1-e11113aeb10f@google.com>
Subject: [PATCH v2] block/ioctl: prefer different overflow check Running
 syzkaller with the newly reintroduced signed integer overflow sanitizer shows
 this report:
From: Justin Stitt <justinstitt@google.com>
To: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

[   62.982337] ------------[ cut here ]------------
[   62.985692] cgroup: Invalid name
[   62.986211] UBSAN: signed-integer-overflow in ../block/ioctl.c:36:46
[   62.989370] 9pnet_fd: p9_fd_create_tcp (7343): problem connecting socket to 127.0.0.1
[   62.992992] 9223372036854775807 + 4095 cannot be represented in type 'long long'
[   62.997827] 9pnet_fd: p9_fd_create_tcp (7345): problem connecting socket to 127.0.0.1
[   62.999369] random: crng reseeded on system resumption
[   63.000634] GUP no longer grows the stack in syz-executor.2 (7353): 20002000-20003000 (20001000)
[   63.000668] CPU: 0 PID: 7353 Comm: syz-executor.2 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
[   63.000677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   63.000682] Call Trace:
[   63.000686]  <TASK>
[   63.000731]  dump_stack_lvl+0x93/0xd0
[   63.000919]  __get_user_pages+0x903/0xd30
[   63.001030]  __gup_longterm_locked+0x153e/0x1ba0
[   63.001041]  ? _raw_read_unlock_irqrestore+0x17/0x50
[   63.001072]  ? try_get_folio+0x29c/0x2d0
[   63.001083]  internal_get_user_pages_fast+0x1119/0x1530
[   63.001109]  iov_iter_extract_pages+0x23b/0x580
[   63.001206]  bio_iov_iter_get_pages+0x4de/0x1220
[   63.001235]  iomap_dio_bio_iter+0x9b6/0x1410
[   63.001297]  __iomap_dio_rw+0xab4/0x1810
[   63.001316]  iomap_dio_rw+0x45/0xa0
[   63.001328]  ext4_file_write_iter+0xdde/0x1390
[   63.001372]  vfs_write+0x599/0xbd0
[   63.001394]  ksys_write+0xc8/0x190
[   63.001403]  do_syscall_64+0xd4/0x1b0
[   63.001421]  ? arch_exit_to_user_mode_prepare+0x3a/0x60
[   63.001479]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[   63.001535] RIP: 0033:0x7f7fd3ebf539
[   63.001551] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[   63.001562] RSP: 002b:00007f7fd32570c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   63.001584] RAX: ffffffffffffffda RBX: 00007f7fd3ff3f80 RCX: 00007f7fd3ebf539
[   63.001590] RDX: 4db6d1e4f7e43360 RSI: 0000000020000000 RDI: 0000000000000004
[   63.001595] RBP: 00007f7fd3f1e496 R08: 0000000000000000 R09: 0000000000000000
[   63.001599] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[   63.001604] R13: 0000000000000006 R14: 00007f7fd3ff3f80 R15: 00007ffd415ad2b8
...
[   63.018142] ---[ end trace ]---

Historically, the signed integer overflow sanitizer did not work in the
kernel due to its interaction with `-fwrapv` but this has since been
changed [1] in the newest version of Clang; It being re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rework this overflow checking logic to not actually perform an
overflow during the check itself, thus avoiding the UBSAN splat.

[1]: https://github.com/llvm/llvm-project/pull/82432

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- don't use check_add_overflow as I accidentally was writing to p.start
  and the alternative of using a dummy (unused) variable does not seem great.
- Link to v1: https://lore.kernel.org/r/20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f505f9c341eb..2639ce9df385 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -33,7 +33,7 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
-	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+	if (p.start < 0 || p.length <= 0 || LLONG_MAX - p.length < p.start)
 		return -EINVAL;
 	/* Check that the partition is aligned to the block size */
 	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240506-b4-sio-block-ioctl-78efd742fff4

Best regards,
--
Justin Stitt <justinstitt@google.com>

