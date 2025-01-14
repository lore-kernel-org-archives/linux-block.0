Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE381C5F2A;
	Tue, 14 Jan 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736844986; cv=none; b=IU3HUCGLQgtamlBbtO7Mzur0rye1N9uw8BL1a2VraV1XN/stY6efsOFhw2ZHxEXN3LPwp/TLUjnb8F+9efW/nJiA1u1HIMLxL93T5EtcITYCHn0EhS0wbVzgu8HiklUyrrkkgjyt8j/PqbULmMc0ngKqghNBHGzOrOI+vJuha5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736844986; c=relaxed/simple;
	bh=yqJqreKCgTHxcEq0pCknMqc0mCI+HEnWpu6oAJb+l8A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rIIox9N0c+It4+ZVx7RruRgQIs3tsmZeLvgQvZH+bwuUPvlOjQEBUu6n5q7oytHIr74eGLC7MQ8po7Xxfx+BLIVHD627zS5jROD51FITl+tSNnr4AmQSz5RWce63vxgemJOCp16EyKwfdIvn3XBiHMlZiEelpFvAzW/cCOzfPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wQsd5rAc; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wQsd5rAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736844667; bh=kOrA/jdezv8dwIHIO/bajeBhK3ka0+dV1+9ZtKz/BGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wQsd5rAcBTTA0XZSAMzYdEql33QW2GaqXvMgzfvT8+VyqgxlW3yR7wYm/guLcjYSB
	 xVlsZNFnITSywXFfLv6DgSLkZRcT5OEUPmecIYnpQAWprJcTIBXjImzcavNCxTrfgH
	 +tBIkIz8N9gmA98Wy0EnNfPGIwpSmansYN91tlUo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id CC513C79; Tue, 14 Jan 2025 16:51:05 +0800
X-QQ-mid: xmsmtpt1736844665ti9lnj1xl
Message-ID: <tencent_9E78266DF82CB96C549658EA5AED66CD240A@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NocU4h9huvo04sZDC4CvWf5ssF2S6yrwQjh/tYSepeT45jcrc+4t
	 HoRg6ZixpEgTQqO+7XgwxJk2dAtWYIeaEXXWnmNFS8Z3XfXUF7hQ5QFS74E3xE2TmW1nLCAEum7a
	 MfpzFBElNuu/H8fcENxiaDJro6qwhC40JoeSTv2dP5Pphot08ddEqZ0XLdJfIoiXKz16kJuiFbN4
	 mQsup5+XAeXwJK1V2oVRt3taH7gESQx2m6JjlE8rLPlfV1spUEJEDnKmZKwQ1nXTk7Kz9iZvqkPT
	 xunf64QTKXpmp4NBb9C/8RNDyjE6wMHvUdt1dZs15pvENnTuV+4+9efnNyuPfcv5piSTKmJukNSM
	 TbdY9qid9yCuJI9Yxpn48L9+tbeYHDWuOB8Nle+B8iN86h6kLHe8yvmbu78pTaudi2LBJAKcoWov
	 E+VK5h1q58isgbWl3IeV3zAkwuV6giI0ItP77VScffR6OzXdjcPHSq0HyroOoVyTLjvVxbFhbpsQ
	 uO3V2pe5z3w3tjMTFkfG4K1+CE0ClV77Z6KTgsRSMlFI39JGrfHoOgLGR3cNoM2HMqZi/MRVyht9
	 9l4lTrJSXq4rJw/x2fRuY40EW5yk7utXVSuleVtpq8I1mdxPjNZXoQH/WiJ4dhJyVp3uq+guoX97
	 /zp/UWN2L/Tz1Fl7u23nhAs09F2wANGycuomkw9Yu0MJv7rqlK4eJigHpGc+T4rtoTxlIwkvjlL8
	 X7VfiReAlU7AB1nxnZiK2Acvr0bDY8lhBJSnw9x7HCbLAcQ423P7LELi/F7hPS5cVeln0NuB7rrx
	 szK2xb00VEXnMLrkyeaKfHZWS4SEw1s++s/dv8inQg8SeSD/Kbjx07mLoe219XlaHD/yia6T1q5/
	 mAEX22T83I+1GYwwNThRX4fQ3ZNZUKXHmtPFvfxW4JkOuhSP+4XHl05cgagOVGVIRIpDBj9Zj3+F
	 rm2wawzWY=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: hare@suse.de
Cc: axboe@kernel.dk,
	eadavis@qq.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] block: no show partitions if partno corrupted
Date: Tue, 14 Jan 2025 16:51:06 +0800
X-OQ-MSGID: <20250114085105.2571688-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <abd5921f-a37f-4736-b1b4-920a5c108f71@suse.de>
References: <abd5921f-a37f-4736-b1b4-920a5c108f71@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a global-out-of-bounds in number. [1]

Corrupted partno causes out-of-bounds access when accessing the hex_asc_upper
array.

To avoid this issue, skip partitions with partno greater than DISK_MAX_PARTS.

[1]
BUG: KASAN: global-out-of-bounds in number+0x3be/0xf40 lib/vsprintf.c:494
Read of size 1 at addr ffffffff8c5fc971 by task syz-executor351/5832

CPU: 0 UID: 0 PID: 5832 Comm: syz-executor351 Not tainted 6.13.0-rc6-next-20250107-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 number+0x3be/0xf40 lib/vsprintf.c:494
 pointer+0x764/0x1210 lib/vsprintf.c:2484
 vsnprintf+0x75a/0x1220 lib/vsprintf.c:2846
 seq_vprintf fs/seq_file.c:391 [inline]
 seq_printf+0x172/0x270 fs/seq_file.c:406
 show_partition+0x29f/0x3f0 block/genhd.c:905
 seq_read_iter+0x969/0xd70 fs/seq_file.c:272
 proc_reg_read_iter+0x1c2/0x290 fs/proc/inode.c:299
 copy_splice_read+0x63a/0xb40 fs/splice.c:365
 do_splice_read fs/splice.c:985 [inline]
 splice_direct_to_actor+0x4af/0xc80 fs/splice.c:1089
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x289/0x3e0 fs/splice.c:1233
 do_sendfile+0x564/0x8a0 fs/read_write.c:1363
 __do_sys_sendfile64 fs/read_write.c:1424 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fcee6b76cf2e261c51a4
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Add a warning

 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9130e163e191..8d539a4a3b37 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -890,7 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&sgp->part_tbl, idx, part) {
-		if (!bdev_nr_sectors(part))
+		int partno = bdev_partno(part);
+
+		if (!bdev_nr_sectors(part) || WARN_ON(partno >= DISK_MAX_PARTS))
 			continue;
 		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
 			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
-- 
2.47.0

