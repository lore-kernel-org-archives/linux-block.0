Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141041D524
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054032; cv=none; b=d0M++khrb6omoEfoTUTg6UgeYFwunCssnqfaRGy8Opn5QHPGtRrkUPP3fPNaM32XQR/mFFViFrlCmO8TYhi9yyGd6UAFI6K8+usXZlRRAve/Qpu9Vc/KkeaYmgSz2Ki0XNqe1zqThC+2LHAAQN0ctVFV0fVb/BKMtmC913NW+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054032; c=relaxed/simple;
	bh=tsOaVF+iFdOoeubnHXAxYCPcXOkgBthMQC/BpJg6mDU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hCIjJz5I/D0Mo/mBfFy9f+7AvDtCFiGBw8K8E6dtqrg1udvSYY1CX8GeGz/+4mX1lRUUJxugRexsjxC+ksbu82RpBE1n9OEf3ogbF33kMeLGm9zYHj6l9JUIv5Tb87BKzgu0oxgdat9b5os2Wo+dJRWSLsFgXNyC4xws9GoANTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pj4SQWVJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj4SQWVJ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de468af2b73so5849338276.0
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 20:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715054030; x=1715658830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xtepmuyQ0j0fsK9BoVO4wO3hfVCGXVxAllLwZnrs0Ig=;
        b=pj4SQWVJ5b9orFmM1v2RvXO8mz8U3qmQ9EVLPGEUXeLH5zS/f0u44/Uxs08d09xsBu
         BZ0J/Pw8/BLAmcPClu3XRD52gsfi5UaY/iYh8wNZkhVGFQUwSMEKblkvVJFA1hnCidM7
         Sqyq+PpUiQLW9nxcoKFuwPcgZc0GM/X5bwOPUQ+7Kp/wdARuC0Xoeedte8qC/fr4yYKh
         f7mnMMuow5goUDCgTXUORRhCU6R+TiCDMwqdH1lAZ5hal0HK44Zg2VsUmtnMh834r1qT
         GLRSi7Xg/2RypZ3/3DcUE+oQhdOtsWPxllvrdsC8JH8JHvjr0HgSvp5+8zXLBmM6OLoY
         DxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715054030; x=1715658830;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtepmuyQ0j0fsK9BoVO4wO3hfVCGXVxAllLwZnrs0Ig=;
        b=gSO9xy9u/q6v248zz/exDFV0cIL5jpUdtJb1CHc5z9wIA/5ycx6VIk7Za5TJUj6KoO
         LEjFnlIB9m8V5j/JoCUm5wFVolY8vB6oMfvywi/NwZz9uxUaVrbwe29l/89BvXDg6VMY
         QrMr6M907fQs7RXuqZ/TfVCnxxJRzD5DQFIjxkOZYk8wWmakJJG4gyMKU3O2VMofzR9+
         656ctF86VLWThmDO92DTT+O4x1LbY20Gxa3BdPUAUqBhOo0WD2aBFplG8Snjj7e8f7Ah
         KxntPnOzwF6ajwDcsmN7aW0+SjU1PEq8Y9JcDzl17+PC0NCcYcGWICSw9XXQUjNLZpLa
         rGjQ==
X-Gm-Message-State: AOJu0YxCiFqpTZXjEFyAyTW/W8YbPYKqnSpFG9DpqWwsIiUS8cDls5VZ
	suHQkx3mH7/nMuqOjw1BdjRweX5fUPq0HZwvHokA0vj302Bq9kisDeOJxsU0xKkb1JBEWsnal1R
	Wc390pAldhntrvJjZS5FHDg==
X-Google-Smtp-Source: AGHT+IE9JqdbYYGhT5dM3MiTfDeGoOhvE3xQLWEsDBrRVm7M4ik9C0WBPWd/yifRjOzvgqJjjFlZ+qdE5R2kEIGQjA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1889:b0:de6:16d6:2f34 with
 SMTP id cj9-20020a056902188900b00de616d62f34mr4167590ybb.1.1715054030102;
 Mon, 06 May 2024 20:53:50 -0700 (PDT)
Date: Tue, 07 May 2024 03:53:49 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMylOWYC/33NwQ6CMAwG4FchO1uzjSHGk+9hPEDXQSMys5FFQ
 3h3BydNjL39zd+vs4gUmKI4FbMIlDiyH3Mod4XAvhk7ArY5Cy21kZU8QGsgd6AdPN6APU4D1Ed
 ytjbaOWdEPnwEcvzc0Ms1557j5MNr+5HUuv3LJQUKbFOVFaLU0uK5874baI/+LlYv6U+j/mnob JDKUzbUKum+jGVZ3saeDbT5AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715054029; l=4424;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tsOaVF+iFdOoeubnHXAxYCPcXOkgBthMQC/BpJg6mDU=; b=U4yDqR/Ij+0HPgX8SfS3YkJfZ7uQewzFArl33ppZN2YGNOdQ//XyIk2iFqRLOnLag5yuQAUQ2
 n4AEYLAQ7XTDYQZ2X6qpTa1o8h/6Z6RNblBtIZfdrfZYShLu3kAhwer
X-Mailer: b4 0.12.3
Message-ID: <20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com>
Subject: [PATCH v3] block/ioctl: prefer different overflow check
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
changed [1] in the newest version of Clang; It was re-enabled in the
kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
sanitizer").

Let's rework this overflow checking logic to not actually perform an
overflow during the check itself, thus avoiding the UBSAN splat.

[1]: https://github.com/llvm/llvm-project/pull/82432

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v3:
- move first line of commit body down one to avoid its inclusion in
  subject line
- Link to v2: https://lore.kernel.org/r/20240507-b4-sio-block-ioctl-v2-1-e11113aeb10f@google.com

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

