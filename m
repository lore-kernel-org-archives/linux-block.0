Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5912F58A;
	Sun, 26 May 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716607; cv=none; b=goZDcML1i12gFQDdDny+x07d6rkRbot5WX5msQa15HzN6e4jrphklGYT61mrPSXT3V6N5M2xdrM8YkeZZBX+VD8zWNoLeSY7snhnti/nSqhtZ288g5M8NZDYqYg0/fhxywijfqno5QthfJ7blIs6uhny3lAHHvttgkBLXwecQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716607; c=relaxed/simple;
	bh=3zGo9WOPGlqGax7+dFHaeHTftQyTAVZYdngRlCtixFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6kywTBPCXL6Em/eplEQxu35NYeHw5OmqPKSHIRM5Sdo9KGuCt1uAma3Z+Cx3OrdJe1BQEJXM8mjOUL0a+jhTwLwlV2YWAx1UjeXr/Lxf6Cq6bSUYgdxNOR1zjTunX+Us9ygOHbAzvhEoOoalcJW5lt3MxTqxmdAqN44EvwCk8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSukhc76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSukhc76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BCAC2BD10;
	Sun, 26 May 2024 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716607;
	bh=3zGo9WOPGlqGax7+dFHaeHTftQyTAVZYdngRlCtixFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lSukhc76f3Bu9oO4Klc/0DJamIgjes75HrG5K6JGI3KFTzvEFVUQ05GBUcm4OkO9n
	 oC+db1aeURYyYPIXkb0C179TxkjgMprQcWI9DcAgnCrhcfJfvRDGR29Dpzk0aLEdwu
	 88xfOTKGNxIu3x4a4pbEoHeYGdJJ4ZorAM2PP6zFwi2PrFj9z7jfQ45+D+LgLZQ5Fh
	 GT3YBWPdNjweRKoBC9aDpS3v1LBcTdW/X+nttwh7UEcdw0w9OcH8z92wfejEiIi/8S
	 lcKtDCQhV76SffyC5QrMnZm7nDyhJeySincjHZgdceG67GrD9DhZuJfdLmlIYAHvf9
	 Mijtev/THcbVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	linux-block@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 9/9] block/ioctl: prefer different overflow check
Date: Sun, 26 May 2024 05:43:10 -0400
Message-ID: <20240526094312.3413460-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094312.3413460-1-sashal@kernel.org>
References: <20240526094312.3413460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.91
Content-Transfer-Encoding: 8bit

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit ccb326b5f9e623eb7f130fbbf2505ec0e2dcaff9 ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240507-b4-sio-block-ioctl-v3-1-ba0c2b32275e@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 47567ba1185a6..f19fbe12d19b5 100644
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
-- 
2.43.0

