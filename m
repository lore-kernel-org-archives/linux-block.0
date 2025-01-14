Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2123244D;
	Tue, 14 Jan 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867239; cv=none; b=pV/yeeRxTaAZnFmcl/9d0U/b822xD+VmZSkEu+9lTy1wnQAPaoSkHoVflRLBKbX9yEzGpHAbwhDLBwG0CeVjBAk5nuS6cEdbQhzWwBR321nmNq8cyJv95zhc2BbX/YuQByjL2KqAA29AEfOfUOVoifaRPZKKkeVJxPfz7AhglTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867239; c=relaxed/simple;
	bh=xmbVQbyTUvk/hosRmIdiUT6LjHRAk1SkMqkyi4bBsUM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P+9erSaO0I7hHTUjHJEVN5xGTv+sq5ebOyodl2c8PEUht7U4DlVVV3eAthgBIewJ4BeXBZczUaOnwPqGYNFEFNtxYQsCCTpbUYsGy+4TGE6K3ugP6v9O/00HampyTjj2ICF50LQ9snrnEX4rLbvDzBR6j156hwmBtwDD1kkpK1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dwwMo5jS; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dwwMo5jS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736867224; bh=q78owxTBWC8l0qqyieov0PNv7ygwqy1LY6+q1WARVLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dwwMo5jSTIeXhctOsUvR6/NXktMVrsOvgpc5aHL0sCX3OrmeUL5tMpmn8eE6/vgtv
	 CxlkM+f+KhoHyMuzDMm/JP3IjIWu1ktgk1fQuhRzOF+XmJRTa8lV5kwx8o3Kify0Eu
	 jivdEjFmfadfgv9qGSa2v7edLBiDctaZiXbROq3w=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id EAC97279; Tue, 14 Jan 2025 22:58:44 +0800
X-QQ-mid: xmsmtpt1736866724tg9zpv05v
Message-ID: <tencent_7C8CA167C306EFD2EAC6590982EEC5AEE406@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVSwQqj9fwOSIHsVsrTlGl3pIfpNtQiv7rZ2RLKvYFY4CV6AU7t8
	 ZPcRz0g8zJu/q2m9AhAKNJnsnGp6poE7JkNPlmVgigR5Zn7EOvxz3hrAddGAGcyVD5PiyNQpRwO8
	 p/c+VDn63R5Xe0mNX7No5wFo8KZ+nlgBnizVHqd1wf9iWJTnrNObvLbuVtVEUIl3tSbHxwglMgt8
	 liA2l+9cj5BB6xFf6t9Ez3VaBApkEvHu6UM3kxjGyYEjdKRGd2UQ690K/Ngrq0IiKMjWlIrX3VbR
	 i4jMRAj0j6kVnhpNRmhRkmy986W+npz5JT7x6lseee71oyC8LSAI9ob/cZ0Ms4zSzmIQGYsIZ5wh
	 MGRemEV0qeMRiB+kK61xbRU7x58uZGbzI+lRrJ8c3uQu4dCQ8+5cFFWWAgsvOKg/hccADeLhBS53
	 ywa272FOw6IeNtMcDSyodwcAFFHMS+4u8biDknUr8MyTy1nPqc2+9/XlgJfRNsQAOW0nCxqYLXqe
	 9Yzs9ckc3xK+PLhjXAYqUqVxyp4zqzx447VAVEl3EODDde8pFiv1xHgnSTcRoCccj4xZ56muVWtR
	 /nSfYAKXtX+L63osQcFdCzpVgPJiIpAHgvHhHgK/ZHwOnB6TaLozARhnv3DfclQwml0BvPrANG/X
	 s9aHq//LlYqJUQ+L4Z/LGjxoBKo/J2b11t7j5V8xSnmD2RlnW4mD2QLmH59jUdHyVjBARNiXTKZy
	 Gqn9rqkmaiBGEBnLK89bgPyANCznSK5S32ulRwzEMo8oJMnIPhARgXeB2Aa/6thyn8VnUmonaS4d
	 uwSHCsXCL68r+ItAydK1nYMATBZSUSvh4HFwn3fvQPFyCqxIGxkDRQSD5uG4e41P0r2OaMhJFwPi
	 O4iH3tZerYa2DquM3foBwQ4xVb+RVOXsYns4BRTC0fHSHk5Un+VisFdSySqZvCcwhLu4xkErFBGF
	 fkuALeIw8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: axboe@kernel.dk
Cc: eadavis@qq.com,
	hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] block: no show partitions if partno corrupted
Date: Tue, 14 Jan 2025 22:58:44 +0800
X-OQ-MSGID: <20250114145843.2940415-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
References: <d384b565-0be8-461d-ba8c-0185842c9d9c@kernel.dk>
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
V2 -> V3: replace to WARN_ON_ONCE on a separate line

 block/genhd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9130e163e191..3a9c36ad6bbd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -890,6 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&sgp->part_tbl, idx, part) {
+		int partno = bdev_partno(part);
+
+		WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
 		if (!bdev_nr_sectors(part))
 			continue;
 		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
-- 
2.47.0

