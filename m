Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E2433D1;
	Tue, 14 Jan 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822080; cv=none; b=SeO9L/WkW5O0KrXfy8fWRJHQfRdiuHGt9+7DC9IIUY4+c1cC2oNPJtKGuQ+MnybBB781og7qkjmUYwaxdrjdb2CDhAKhGKWMRqdt1AeG3BD1Be33dlzNkk6+H7nLWIA8K4RnAjtHmthZTvrz97dOnX/cplek4/OJpP/i/u/iHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822080; c=relaxed/simple;
	bh=5Dw7+waMNCkEW91RAETEKUbDfcESvcZeV9RpTnctHzE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pB7bY/YGVYUZshsfF8oCsHnQzqma2MFmeUUA4EEYYE/ThU1YzdvhnXpCtp7IeOePKU/VF2T3FaaoTSC1+tx/7z22t2MU2Aw3ytIh4Ccm3Tq7EvO2JjG5Wu1EuHE0HVLFJB+ARy0sZkB6SNPELLXhhLjiu5TE9qdG4qLJEOAlvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ysy0M3RC; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ysy0M3RC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736822071; bh=rNAeVnkpK1AIHChvwH7YUf6I2CKXx8Ze5sTc3cKWbfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ysy0M3RCYryenskWmMXAKhdGy9MAQcp6y9TrzVnjDeK1wBRYHMdREB5veqAIPdafl
	 +MkNwN19PW6E1fYnqqeg8EVZRr0x2aRc4CVv/5fPl1JlMND5jFtaQvo+8zBb9r/pfn
	 sR6KVmktIKsIaU3aWOzrctIgLisBZROc5jO22ZM0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 7101C8EA; Tue, 14 Jan 2025 10:28:16 +0800
X-QQ-mid: xmsmtpt1736821696t2x21fdx5
Message-ID: <tencent_E820E9DAED3ACC3079BA6F3C2E896FA4950A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur97laG+t3qcFKMLbpdKorRZDQOaQToC6f6VLgKBgqihpg9ULp0mu
	 K+1S27dA2xtZ8jUo4WcgXoaXpId2pLyB/JiLoUgQYVghs4V6bhEv6K418fX30if3xwtWJ5XiKxuX
	 A27n4ir3oUeCwALlNy+nEAMhye7rtAhSZ57AGGwjRcOYNpXIS5lnOFdaaNd9TKfnAuoEQdS0aJfZ
	 ZEiQSZqf11zcX4uq55La/osZWo3X6cXcQYQZJ3rBlEMZp/iM7MqiweUAlmESLyKrKUH0ingaS6pE
	 h58vE29n1Mu/g/JcTkD95nVVQZShYIrBPlJlLg8/1F37UZBPX0O7nGzItXjZsl7x3J72flFr8Fdp
	 dyqNUa9dCem/pDG9JnEpNDmU0fBCZGj02ggRtgFoRgsMTYEYcOan/LGyhvqrCKZq10fNOk93JANt
	 Mf2FyVwT9sDLSsiabkzFizbQmQusOJzLeDz55vlrzgZL76CuBedxZm0rKYmrLZ/q2uadvqePYGfS
	 45QGHZDSOo3k+ZFYTJm3YL/z3hIJQ7zlOLMjamCwl61Cnuvr9DRPaM39GJR1Vamdb+2UyQAwRvKD
	 xMeQZwWISm3KD/5i19Bhjo+AAdgHCXgFa4ndaWOKb3yhMSChAZXrUmLeUWXzQoMlQ3fKuBy9/2Gg
	 5zyXmYDfKd8PFMxzAZm0h6oKVarhhazp/5y/09VKfSTVH34Q+DDtB/vhuHz+J1dVoOwYLr3uOnxY
	 2biIUaR/tgzYTUzstBu6cE1YfI+NV16nlIErPXtY3amRmVZTOfL0YHmEggwnqd8YNgQyozHBv9vs
	 E1Y0szigFi+d481BTaSMexvfxzumXQ5/aG791abzkZOJjB8EJa5kPhIktFdTkyRKpTQEOsLk8olr
	 W/asNarhw5rs4vAZwIREQdLZTIY3HugU+yuqNTC8i/V6WcZyclSGI=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] block: no show partitions if partno corrupted
Date: Tue, 14 Jan 2025 10:28:16 +0800
X-OQ-MSGID: <20250114022815.2178893-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67841058.050a0220.216c54.0034.GAE@google.com>
References: <67841058.050a0220.216c54.0034.GAE@google.com>
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
Tested-by: syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
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
+		if (!bdev_nr_sectors(part) || partno >= DISK_MAX_PARTS)
 			continue;
 		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
 			   MAJOR(part->bd_dev), MINOR(part->bd_dev),
-- 
2.47.0

