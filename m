Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AD3559D6
	for <linux-block@vger.kernel.org>; Thu, 23 Jul 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792151; cv=none; b=l8dZEbuJvfuSVGxChlBD4ZeV+4rQ+7f3plceQVHLgKjLCwy44rNCrkeFsVoOhs9rVxTcyyQyRcM1kXQamCperovjhQCot0F9MBTCN7vskH+D01IiohGnMTs8R95IUOCjf+61S57xxwZ0RecvN+9se4rhTNXsJ/yvRUqyD+iZLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792151; c=relaxed/simple;
	bh=bo0xdANJedWMftsTL+Pnp2bnuLSGqDYmR2drRfx9i8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gz2U4sa2j0PdWwg+TA+3Ob1Jkyy275R0xNxrEl7qUScgz5zjXDX9PSlm5gR/tAsxi8ZOmX6q4aqnkidme1ZRVTIJTX2fh5mIEYCkheOC0FlzN3bwFBqV0xCle1g8RVLdXHV6Vq/crjaDZcGyR24yTA2J03UPWYjoWCjoNIjV7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QSoCYfzr; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QSoCYfzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Oe
	0fADTL6FG5r2q2FkWzt70eY2criFpySMqnkmKlFdw=; b=QSoCYfzrW3q5HmNDeR
	iCxatx5B5kx2VEguw+vpd2tHss+1Uqo93/DqFpynjxgllxaFYr8lCtUBaGdejuDk
	hUGV8hSZhUoh0jo0sncE/825+eXY4dfuL3wAj7ML0azgVqHoGaVRrFFOFYJpnX+k
	RdEh4C2NnGlRUDIrStqNBqVUI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3wAAzxGFqxTfeJA--.13191S2;
	Thu, 23 Jul 2026 15:35:15 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH] floppy: avoid NULL deref in reset_interrupt when cont is cleared
Date: Thu, 23 Jul 2026 15:35:12 +0800
Message-Id: <20260723073512.11120-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3wAAzxGFqxTfeJA--.13191S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy7KF1fKrW7tr17Xr43Wrg_yoW5JrWfpr
	W5CF4jgF40qF4Uta1UWw1Ivr15AFnIkFWak3yjyw15CF1UArsxuryktFyaqrsF9r48ZayY
	vwn2qw1j93WDKw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jebyAUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbC6RUxwWphxDU4EAAA3e

reset_fdc() arms do_floppy = reset_interrupt; the IRQ handler then
queues that function via schedule_bh(). If unlock_fdc() or do_wakeup()
clears cont before the work runs, reset_interrupt() dereferences a NULL
cont and oopses.

Example crash excerpt:

[ 1070.468148] status=80
[ 1070.468152] fdc_busy=1
[ 1070.468158] cont=          (null)
[ 1070.468161] current_req=          (null)
[ 1070.468162] command_status=-1
[ 1070.468163]
[ 1070.557051] floppy0: floppy timeout called
[ 1070.557053] no cont in shutdown!
[ 1070.557056] floppy0: floppy_shutdown: timeout handler died.
[ 1074.419509] floppy0: FDC access conflict!
[ 1074.419782] BUG: unable to handle kernel NULL pointer dereference at
0000000000000008
[ 1074.421969] PGD 0 P4D 0
[ 1074.422320] Oops: 0000 [#1] SMP NOPTI
[ 1074.422648] CPU: 10 PID: 3269 Comm: kworker/u256:4 Kdump: loaded
[ 1074.423830] Hardware name: inspur Standard PC (i440FX + PIIX, 1996),
BIOS 0.0.0 02/06/2015
[ 1074.424284] Workqueue: floppy floppy_work_workfn [floppy]
[ 1074.424757] RIP: 0010:reset_interrupt+0x3a/0xa0 [floppy]

The same NULL deref has also been reported by syzbot on upstream.

Return early if cont is already NULL after result(). The hardware reset
has completed; result() still drains the FDC. A later request can lock
the FDC and reset again. This is a defensive fix for stale work, not a
rewrite of the floppy continuation state machine.

Reported-by: syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619e27617b2abe6b9b72
Link: https://lore.kernel.org/linux-block/00000000000093c4d105f9aa34d6@google.com/
Link: https://lists.openwall.net/linux-kernel/2021/10/27/56
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 drivers/block/floppy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..3d2df99dbb29 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1784,6 +1784,9 @@ static void reset_interrupt(void)
 {
 	debugt(__func__, "");
 	result(current_fdc);		/* get the status ready for set_fdc */
+	/* Stale work: unlock_fdc()/do_wakeup() may have cleared cont. */
+	if (!cont)
+		return;
 	if (fdc_state[current_fdc].reset) {
 		pr_info("reset set in interrupt, calling %ps\n", cont->error);
 		cont->error();	/* a reset just after a reset. BAD! */
-- 
2.25.1

