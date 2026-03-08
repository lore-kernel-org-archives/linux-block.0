Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565A1A83F9
	for <linux-block@vger.kernel.org>; Sun,  8 Mar 2026 00:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772928908; cv=none; b=VwgSnQ2lhCV7y/xxK0c/dVUB7NHH6Z2uOinqhGAXAlaKa5+qz/qGHTsxf6Bsv12rUw0FC1DggYkI/uUZ/2oxoo7T298MJVH9O3eDQfZyG9eolbzfDDq2YTgSDXCitYUkFmf25LMziNVOsnFYUP03eoMGDpLQElfURUMbh2eLh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772928908; c=relaxed/simple;
	bh=FNz4mqUtJvniaS740HIZmjIeq6NhnHImvn1ePA1cD3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxnJTsLtWLyT3Ik/5s6EGM/A6I4ZHxA/wVSltZHOQlaYkUoPYWrQisqqK6Q7m2D1zCgknonHaSr4jPD1de1WEr8J+74YyQFBY6Cu9Xz5l9YYKSBjM0F3k0xkyYJR07INzP6iCXIlyhM0VwH58YbZvdBfnhehtQ3VokQaBGBhvbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-793fdbb8d3aso127496977b3.3
        for <linux-block@vger.kernel.org>; Sat, 07 Mar 2026 16:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772928905; x=1773533705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDVoImbCMyrTI+fckI2KesjRHDf+Y2Y+sy8o597R4xM=;
        b=u5UM6YLwww2oRzB/P6mWKvCpBDaz05K1WcfpBMGQoWS7BU6DdKJm8mW+OPJqIDvDgL
         SBZUiXzWwk5PUG9vfg4SMRtVkgMCHSfERn2H8tptqGyawUjELJ024+kjn/G+algOKc3l
         FV2UnnLHjd+V234dnV6d++rRPoxBkDXUVwVjldshaswN4F6ki2po9fVh3iGzE5mXgn8l
         jXSuye82Yhwd9vM6mIttHvfUCPxJ4WflH2ar2psbQg9kNYw4sdbqWWej7LX4Ca3/QItb
         hWgqbgpuTj5OQ3Dqo/yEGsaxit65QGGs+ZuY1B6gNmjCgMhw8vh8FlHAUZBK0heVz+Kp
         JyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo8FaXjxuF0x2Y7ntnSeD7hbjkmYs4ZPjMGnVk5PLGMQ0FO62Iria3qUuXykhNTiL7zalcIpAT9Yr+JA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/FxBnb0YFaJh3/OIkqVsMe4WM2nvXOl2vhLySv/jD2BJPnTi
	yWYpCwx0HulBEWm7pA/4Zgfb9szC0ilO7wCpH/xKc52JX/YWJyxRJ9U1
X-Gm-Gg: ATEYQzwzJUS7OQpS5CIWxCxF5hdu/xoDgOFQ49VabiZ+1ikjOJ2spxDCyy7kOJFakOi
	SzMwBU3j0exk6J42lLsk9ApguthXtfS8p9ZjzJa55zcRDMJ+Xkd60MQ2ve1jsCcNIyGUvZ5oBzT
	Mypa4iRKhM/qgC3OHrnC2v5xHv+MEe5rTaVZQ5yT2SJN9H7JhqPHXu74yc3VFi8xGBGHZe0Ke3Q
	sKa+LW3R0t7YZ4mvplU6uj82xJYrd/2wFoviVvmP/ZCrx1Q8UMC+idWpKQjcEwnZePKzXDRKVZX
	fXZ0VwrxXqG2R5RuF9oNQhvuBsTM5Pld0yBZieVsuAbxEZHv1B+8KpxYXrqCithm3J/NmOepq8x
	T6dxLvOSYqdxqTNUNjWe4lHkpA4a0Ak4ra6577D6OB91kaJsCAmrXACcDXwYRidz7adKm5hFScJ
	LwqhIun2OpiA==
X-Received: by 2002:a05:690c:a:b0:798:6d23:17d3 with SMTP id 00721157ae682-798dd7d130dmr62437067b3.61.1772928905338;
        Sat, 07 Mar 2026 16:15:05 -0800 (PST)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-798decdd38dsm25665067b3.21.2026.03.07.16.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 16:15:04 -0800 (PST)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: Sungwoo Kim <iam@sung-woo.kim>,
	Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>,
	Dave Tian <daveti@purdue.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix null-ptr-deref in bio_integrity_map_user()
Date: Sat,  7 Mar 2026 19:13:58 -0500
Message-ID: <20260308001358.1675543-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user program can request large user-memory pinning via
ioctl with a large metadata_len. However, this does not guarantee
that all requested memory will be pinned. Pinning may partially succeed
and return the number of bytes that were actually pinned, which may not
match the requested size. In this case, only the addresses of the
pinned pages are valid.

The current implementation does not handle partial pinning and
incorrectly assumes that all pages in the range [0, nr_vecs) are valid.
This can lead to a null-pointer dereference because pages[n] may refer
to an unpinned memory range.

To fix this, add a check to verify that all requested pages are
successfully pinned. Pinning all pages is required to copy user data.

KASAN splat:

Syzkaller hit 'general protection fault in bio_integrity_map_user' bug.

nvme nvme0: Command: 80f60320000000000300000000c9ffffb38ab5410000000070693aa0ffffffffb00e619dffffffff80f6032000000000b38ab5410000000070fc38a0ffffffff
nvme nvme0: Command: 80f60320000000000300000000c9ffffb38ab5410000000070693aa0ffffffffb00e619dffffffff80f6032000000000b38ab5410000000070fc38a0ffffffff
nvme nvme0: 2/0/0 default/read/poll queues
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 280 Comm: syz-executor294 Not tainted 6.11.0-dirty #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:_compound_head home/wukong/fuzznvme/linux/./include/linux/page-flags.h:240 [inline]
RIP: 0010:bvec_from_pages home/wukong/fuzznvme/linux/block/bio-integrity.c:290 [inline]
RIP: 0010:bio_integrity_map_user+0x5a3/0x11e0 home/wukong/fuzznvme/linux/block/bio-integrity.c:345
Code: 4c 89 e0 48 c1 e8 03 80 3c 30 00 0f 85 4b 0a 00 00 48 be 00 00 00 00 00 fc ff df 49 8b 1c 24 48 8d 7b 08 48 89 f8 48 c1 e8 03 <80> 3c 30 00 0f 85 35 0a 00 00 48 8b 43 08 31 ff 49 89 c5 48 89 44
RSP: 0018:ffffc900010cf4f0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000000f761
RDX: ffff888006cae600 RSI: dffffc0000000000 RDI: 0000000000000008
RBP: ffffc900010cf7d0 R08: ffff888006cae600 R09: ffffed1000e0db95
R10: ffff88800706dcaf R11: ffff888006a31a00 R12: ffff888006a31a08
R13: 0000000000000740 R14: ffff888006a31a00 R15: 0000000000000001
FS:  0000555587e483c0(0000) GS:ffff88806ce00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002002f8c0 CR3: 000000000719a000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 nvme_map_user_request+0x4b6/0x5e0 home/wukong/fuzznvme/linux/drivers/nvme/host/ioctl.c:149
 nvme_submit_user_cmd+0x2e8/0x3c0 home/wukong/fuzznvme/linux/drivers/nvme/host/ioctl.c:185
 nvme_user_cmd.constprop.0+0x35b/0x540 home/wukong/fuzznvme/linux/drivers/nvme/host/ioctl.c:325
 nvme_ns_ioctl+0x11e/0x1c0 home/wukong/fuzznvme/linux/drivers/nvme/host/ioctl.c:570
 nvme_ioctl+0x147/0x1d0 home/wukong/fuzznvme/linux/drivers/nvme/host/ioctl.c:605
 blkdev_ioctl+0x28c/0x6c0 home/wukong/fuzznvme/linux/block/ioctl.c:676
 vfs_ioctl home/wukong/fuzznvme/linux/fs/ioctl.c:51 [inline]
 __do_sys_ioctl home/wukong/fuzznvme/linux/fs/ioctl.c:907 [inline]
 __se_sys_ioctl home/wukong/fuzznvme/linux/fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x1bc/0x230 home/wukong/fuzznvme/linux/fs/ioctl.c:893
 x64_sys_call+0x1209/0x20d0 home/wukong/fuzznvme/linux/./arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 home/wukong/fuzznvme/linux/arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6f/0x110 home/wukong/fuzznvme/linux/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f5b3d8e98bd
Code: c3 e8 a7 1f 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd1c0e988 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f5b3d8e98bd
RDX: 000000002003f680 RSI: 00000000c0484e43 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f5b3d93eb4d R09: 00007f5b3d93eb4d
R10: 00007f5b3d93eb4d R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffd1c0ebe8 R14: 00007fffd1c0e9b0 R15: 00007fffd1c0e9a0
 </TASK>
Modules linked in:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#2] PREEMPT SMP KASAN PTI

Fixes: 492c5d455969 (block: bio-integrity: directly map user buffers)
Acked-by: Chao Shi <cshi008@fiu.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Acked-by: Dave Tian <daveti@purdue.edu>
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
 block/bio-integrity.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 96a265390..7d633f39e 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -341,6 +341,23 @@ int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t bytes,
 	ret = iov_iter_extract_pages(&iter, &pages, bytes, nr_vecs, 0, &offset);
 	if (unlikely(ret < 0))
 		goto free_bvec;
+	if (unlikely(ret != bytes)) {
+		/*
+		 * Not all pages could be pinned. This can happen when
+		 * pin_user_pages_fast() returns fewer pages than requested.
+		 * All pages must be pinned to copy user data, so unpin
+		 * whatever we got and fail.
+		 */
+		int npinned = DIV_ROUND_UP(offset + ret, PAGE_SIZE);
+		int i;
+
+		for (i = 0; i < npinned; i++)
+			unpin_user_page(pages[i]);
+		if (pages != stack_pages)
+			kvfree(pages);
+		ret = -EFAULT;
+		goto free_bvec;
+	}
 
 	nr_bvecs = bvec_from_pages(bvec, pages, nr_vecs, bytes, offset);
 	if (pages != stack_pages)
-- 
2.47.3

