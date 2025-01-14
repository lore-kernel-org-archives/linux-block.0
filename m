Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181301EBFE8;
	Tue, 14 Jan 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869201; cv=none; b=pY1i2c6fybAuxFgHNSdYynPV3WzpVx4BHSeficxN2wYjl8I6cQlkOxIfKn49bhNJt2XIbB9rXVaJSaDDtZ6f+WyuEnA66zIUxzSdEDpfFpo3giTCWH+AtvXlyMCyirEm7cVE0RDtvHKq/BAJG7wrXxHKvxsPRYZN5bm5ely2l5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869201; c=relaxed/simple;
	bh=crIIEjx6k7+pCwNwVGmLwfvJKAWVUHNO6BBjODxU9g4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YFbG5REDlHSd85njY0YqrDGp1r6vmSDSJ7aOxDU9u+qjEPPLRuQB/JT0SOCDtHF0z/rcl0xxYZhfw4mmK6LJk9fWrT0P6zfrm+iBqvjBKKKJeoZvVJkNZLYVdNdtYj1iS7RPdR9h85mx1RmYQhj/RuTz4TB2BGJFXzfbow8IAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RmLj/NVA; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RmLj/NVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736868888; bh=7G2JnY5yG7fMYZ4BbbZIRBAA3PMiRm6+lzCoyHpiqqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RmLj/NVAO+avTd/GlvEavDrQUdn9aX8sDx14bQ3AJYFr9hp0FfD1qFNCVM1ivpF2q
	 HBUOX71YSv8+Dlh/nOB+5KDe+khpEnTEHEz6UsQkoYjGojFoU/dAvEhF5PMs5p4Luo
	 DOBz7Qr0j5SQtj0C+51shEbT1bHsV59OSJaoiVC0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8AE80C23; Tue, 14 Jan 2025 23:34:46 +0800
X-QQ-mid: xmsmtpt1736868886tz2zd8so0
Message-ID: <tencent_0006E4D2C28641498B2ED06ECB8C9BE7D706@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aU3UDNenrYzmRtapKPU6FoQZ+OIF2700qtipqAdBFg7mLuqaA/T
	 Q90Iel3tsPHx+HqjW3+fkyQBmu4pR/GpcmbR+p29oSFlnUY1VsjCknKJMg68J/rQeODvcwJ1eJ4j
	 9bI5kcXVT4nn6eRJm+VyHEVoF1ziG5xlWFqlHgLAjj3RSnD2HvYEVVHN9LH/S6mYyvibqmqoBnv1
	 uhQ7IH/JsiK0UFeAJMBwhD6xX2iclUo0S8h5aP1R3rNiqz4DCfYdD/VIDuDtdCdonluew38LNYRh
	 Ch/prUBYHiy0VazMYP5OI3kxdNVV4oqKmhgVIUfIOjibDFDJRHOJU57k4Lwkboo74rDkXWrxUBU8
	 QU6Nl0nC7iBwz85UiwnY1uwI/txQPC9uUppEaJe2vV2qmJ1u46DW00EveNIlc5OipW5D9/CO4mM1
	 rgWQw97gt14bdf5rUowhMCdANBrFqNC80V+DI6116ta7C8Dyhn3+8hAl1QeV/GDBLUCBSMphUK7G
	 8XWjvjpFzohfbuJCqJMngQEJWtBsOGfztEguKDUfsBNNWSNF1G194dbAwQkt4RGmKYN+E8N44SUG
	 j1k+xkUztUoWeghQBlOZDbmsaLh6pVbf1SrrF53lLTCFF8eX6J1/FZG7srmoLTIsetxsA5X5VEY+
	 y0V8CNGnkeXUkZmwbJMciGAzXaYw4+vFH7ae1EbtiPdEFmdy4hQoDG6ZrgghIeyLb5QbqrNkVvcZ
	 ap3t0fSQt/mKQZwm6bTNaJUCrVRGlGVNujaqs7m/yHWhYjZrzda8ub0DQLmeJiQyQP7qv/VUK57L
	 yF434Deivk7r7NteufcQ/e+RyW5PK0nfOECv+TWc7O0+/BJupfVvnwf7eXNG8RGrOa2KCXFpVWvx
	 f96GKiSOcQ4Jc5LLuAm386XRBk+zvVAEN6jFcunJIcbXIQ9Toofjpio5Fu+T9ZRmnuTc4k77RJE4
	 MyGKe+2R93qihJaGKVHQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: axboe@kernel.dk
Cc: eadavis@qq.com,
	hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V4] block: no show partitions if partno corrupted
Date: Tue, 14 Jan 2025 23:34:47 +0800
X-OQ-MSGID: <20250114153446.2978887-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2df5c0d7-cf9e-49ce-a39a-4e3d50c6df0c@kernel.dk>
References: <2df5c0d7-cf9e-49ce-a39a-4e3d50c6df0c@kernel.dk>
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
V3 -> V4: add continue

 block/genhd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9130e163e191..a9a1d5a429aa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -890,8 +890,12 @@ static int show_partition(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&sgp->part_tbl, idx, part) {
+		int partno = bdev_partno(part);
+
 		if (!bdev_nr_sectors(part))
 			continue;
+		if (WARN_ON_ONCE(partno >= DISK_MAX_PARTS))
+			continue;
 		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
 			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
 			   bdev_nr_sectors(part) >> 1, part);
-- 
2.47.0

