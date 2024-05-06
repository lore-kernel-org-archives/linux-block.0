Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991615AD90
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037036; cv=none; b=mgbPUWQ5GHANrftJBascQDFjLxHFQ3BcR9AJKDfBL3CHIP8qI2THY26ymlm5w26n0HjE6FAH2wEU9vJGwm947bc4UNie6Uz4PzYjwEvKfBT1lozEE73AD8nN7ymWrRG1UeqQpPLl3uMGIKVrMP6OLq5TYcLME+zJj/xCslJmxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037036; c=relaxed/simple;
	bh=kIqH8s12Peez1Ha63AcrGBGXb3oMgek8ZOqH+OM6aL4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=du9I7+yQdVvY+pQrwB90aUU8agR/3IIU4NzR1cOf0d8tgAbwFJJ0hNzWjHHg5DTiTNO6GSZv/pqMqgnQuH544Mb7MZgnNVOUm3jQKml08OJZ6IAznmdiOdQOt6eod1iQRB+3bBcQ5NmHhnDdxgTPKsVhKzmWvAn4D12uMeRjsto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yg9IoGuR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yg9IoGuR"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so56391937b3.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 16:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715037033; x=1715641833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVTeK+PPpIcCC4K8Et9DWqwzsgriwrNP2n+cF7VfKKg=;
        b=yg9IoGuR7ulGDpnnCk8waLUOHeu2OuxtZ9p2JWVDDRtDSCn0L/xASTdUNSrUlqsogx
         IaBh0a0YzqNc72wB+UzYmXGIPawjqRsXV5wDAS9wXzioql1EpZTP6nKK7rmha+xUxvuN
         Yp4GPU/ElF3Igg8j5muXOuSf5ERYE/IJTXA4aYK3f88TOBhBQc9e9Ge8s1CQJbZak19p
         OpBKmU+gjdFVlWUBTRgpktffQe4VokKxC728E48/d0wm2uQoaWb1vyIoBn7JNbg4Eq1x
         H8/AxLYmR+HKej1ArY4TJi3tk7MMj5aHarfYuBof+epsb5owJ8xSfqJFxUgawg0W3Zr6
         keag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037033; x=1715641833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVTeK+PPpIcCC4K8Et9DWqwzsgriwrNP2n+cF7VfKKg=;
        b=Bfa6d6CTYeHUaQGuq9tsv1cFjmtsDv/fBEMn/1wkcKfHWMmbCZruTE5qiRaWZY1ANT
         FM0aMwGKjd+vABTeqhmQH5pj1aEHU9iaX1Kv27+5JmRoqJkx0ZVSGd/1KQmVy0PwnI0S
         xoE870SOkQARyKH+VE+gHue/BQ+7hmVVffVNGugjtLcAmV4x1Re19csDC/CIb2uw7A+6
         zab1ygqnQguKaobw/ebWBzISPVuI7Nurq0X0Ng8mRLc+9/VU/HeXcKQsN0Nm2ZSqY1aO
         rwce+6+62zcXUhd3vFKhGmmTuhjgq2wLMacDjUFQ2AKVr9EFmkxGNmeeJdu9GEuNOnuy
         vSgg==
X-Gm-Message-State: AOJu0Yx0oQICmr95M+mKmMhwz4jYj5wspZjqRnmkq9CDdBXMGM46SM4F
	0qIn9/xKBqs3kNbCTE4RP/XdzsYSMeGocS7oGLdU7L1+0aCc4SCJ4VItQ3x4Flu6fDQ1VjPYs1z
	j5JidTJ0VCGATLMAdbRAcbQ==
X-Google-Smtp-Source: AGHT+IF2zNFukyT8p7wq1ymqZP1R4dIIyH63RYvZYt/QfzEa+yiPKhJv9Eyui+kITd06lvb+8b/KRTq5N7Or7Lpv/Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:100d:b0:ddd:7581:1380 with
 SMTP id w13-20020a056902100d00b00ddd75811380mr3803979ybt.11.1715037033677;
 Mon, 06 May 2024 16:10:33 -0700 (PDT)
Date: Mon, 06 May 2024 23:10:31 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGZjOWYC/x2MQQqAIBAAvxJ7bsHEMvpKdEjbraXI0Igg+nvSc
 WBmHkgUhRJ0xQORLkkS9gxVWYBfxn0mlCkzaKWNqlWDzmB20G3BryjBnxvalniyRjOzgRwekVj uf9oP7/sBTbwINmQAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715037032; l=3971;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=kIqH8s12Peez1Ha63AcrGBGXb3oMgek8ZOqH+OM6aL4=; b=yOCnlsYhbcBawdXupFaQ+B7J0DpIGRdob00ZKEgq5/yFaPGqXUV8fr82P6p55Yn32rPhvTGBD
 dSzQZPLXZtpB8xJ4v7A79F1yhUSY5lDRaAKQ8GG+6chUR4dcwiL8UMA
X-Mailer: b4 0.12.3
Message-ID: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
Subject: [PATCH] block/ioctl: use overflow helper for blkpg_partition fields
From: Justin Stitt <justinstitt@google.com>
To: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Running syzkaller with the newly reintroduced signed integer overflow
sanitizer shows this report:

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

Let's use check_add_overflow to check for overflow between p.start and
p.length, as this method won't trigger a UBSAN splat.

[1]: https://github.com/llvm/llvm-project/pull/82432

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 block/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f505f9c341eb..a66213c88ebb 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -33,7 +33,8 @@ static int blkpg_do_ioctl(struct block_device *bdev,
 	if (op == BLKPG_DEL_PARTITION)
 		return bdev_del_partition(disk, p.pno);
 
-	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
+	if (p.start < 0 || p.length <= 0 ||
+	    check_add_overflow(p.start, p.length, &p.start))
 		return -EINVAL;
 	/* Check that the partition is aligned to the block size */
 	if (!IS_ALIGNED(p.start | p.length, bdev_logical_block_size(bdev)))

---
base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
change-id: 20240506-b4-sio-block-ioctl-78efd742fff4

Best regards,
--
Justin Stitt <justinstitt@google.com>

