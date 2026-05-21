Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35E397B02;
	Thu, 21 May 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348861; cv=none; b=EtS7zSjjyrTKVuUM0oQkJ43trVvUDFBV6FbFvNsAB5bgt48Dg5Hxwri+3UduTFw09qo40eom1h8u38OWvXmSyFNrKtwW/wca3cw6ILk8zNBbKiyp2mLKGWkoYMtO+pX6ZtigUEsOjKCvCXoIS1F2a9p0pJlgoAUTJbh+rB6TTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348861; c=relaxed/simple;
	bh=OmnMaX9ik+XuaAJfZZpEW4OaX30cmy0+4VMgXEukpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umh5tAo5i3GUmjiW55biqcNioknlwXHYw46cGXRU06tKgGURejqRmXGVIH7Lj98blWqhJ55Z/67YHkwrPCIZ0su3/YxdHVDOaS8O19smtk4gLQRWAaTayYTAScG5eZg/k3YGph8B6I4Hd7ZnF5Pm+BfXi2pALOuDXK6uF4ZjayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=xIJT839r; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="xIJT839r"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1779348537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pgNeb9y7oioHQCP03azgKcyZm+rXC/BLtQGfBx3gEJs=;
	b=xIJT839rjwpMDJ9ntjlxhaYBhsAhDZzKnLBjRzKyQ28PcibudhQlwdF59sXgaNXxGA7HtV
	GmqWrDiv6M06jo+W2egxMt4Sw0MGhupIwv+MV0cjVVDWv6AtMRWP3y0Hxlp9wb1nTkCPw8
	+yeRAgbKZgZNIqmtBKinmvQlGPadw80=
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in userspace
Date: Thu, 21 May 2026 10:28:56 +0300
Message-ID: <20260521072857.5078-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bdev pseudo-filesystem is an internal kernel filesystem with which
userspace should not interfere. Unregister it so that userspace cannot
even attempt to mount it.

This fixes a bug [1] that occurs when attempting to access files,
because the system call move_mount() uses pointers declared in the
inode_operations structure, which for the bdev pseudo-filesystem
are always equal to 0. `inode->i_op = &empty_iops;`

[1]

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 23380067 P4D 23380067 PUD 23381067 PMD 0 
 Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
 CPU: 2 PID: 17125 Comm: syz-executor.0 Not tainted 6.1.155-syzkaller-00350-g84221fde2681 #0
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
 RIP: 0010:0x0

 Call Trace:
 <TASK>
 lookup_open.isra.0+0x700/0x1180 fs/namei.c:3460
 open_last_lookups fs/namei.c:3550 [inline]
 path_openat+0x953/0x2700 fs/namei.c:3780
 do_filp_open+0x1c5/0x410 fs/namei.c:3810
 do_sys_openat2+0x171/0x4d0 fs/open.c:1318
 do_sys_open fs/open.c:1334 [inline]
 __do_sys_openat fs/open.c:1350 [inline]
 __se_sys_openat fs/open.c:1345 [inline]
 __x64_sys_openat+0x13c/0x1f0 fs/open.c:1345
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/all/20131010004732.GJ13318@ZenIV.linux.org.uk/T/#
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 block/bdev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index bb0ffa3bb4df..107ac9eaac7f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -446,15 +446,10 @@ EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
-	int err;
-
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
 				SLAB_ACCOUNT|SLAB_PANIC),
 			init_once);
-	err = register_filesystem(&bd_type);
-	if (err)
-		panic("Cannot register bdev pseudo-fs");
 	blockdev_mnt = kern_mount(&bd_type);
 	if (IS_ERR(blockdev_mnt))
 		panic("Cannot create bdev pseudo-fs");
-- 
2.43.0

