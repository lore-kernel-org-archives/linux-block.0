Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C03FC5B1
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492058; cv=none; b=WI40q8gn//6lkDYIr9/VIZKRS8d6Z1J5mrxZGLDiXhLUzs44McAERVM2G1w87ahQWIF/yFVcGsohubDiwYcPgEG78LYxPvKSm9wfL3RISHmoTjG37iJ0/rdJWKf/B1f7NaQr3K9g93ZGmspzNxqaH0P4HXJT1SKlLdTxxSl4fmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492058; c=relaxed/simple;
	bh=FWJS0BRJJbz86ilEO+/1XN8E/OSQOh7YdKlSB9th7YU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HVekPJPcJpeAHxF359OtmCmo2XUw3fYn5N0vCe5CcwHM4BeMtrZmyzLTDL+c3VsMDQ2ZWC1VmzHixJaewrAB43w2/esuwVhWbAnDMCuh/QPS4vS6vpXNd/PnHYGxAruYStBMBGZX8bcYsl+jLd++0DtKSBhIf51nxVdrW9J7Y00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eDKZ4oxH; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eDKZ4oxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CS
	1YypMXzJVokfYZhU7/rTA4rzuqPoQfTUcXlmDo6jg=; b=eDKZ4oxHNUGGV7TPPa
	wsy20b3TyeKgvWH2m4khZ6fv2mmE3/6BVtBxqqLB79S0QjqSiAiZlkWnv2souIVj
	x72XSWlCHQ1rvq/X/j2uBnVig3ZfnV97fFRqUY2HyeIrwz/fFvzZR8Q+qAQOAnmW
	OAlUAjpP583fYFt8uJ7hS/sxA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wB3+1wScmxqu5ThLA--.441S2;
	Fri, 31 Jul 2026 17:59:48 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v2] floppy: avoid stale cont use after BH is queued
Date: Fri, 31 Jul 2026 17:59:44 +0800
Message-Id: <20260731095944.1939179-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3+1wScmxqu5ThLA--.441S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry7Cry3XFWDKr4xWw17Wrg_yoWrCr4kpr
	W5uFs0gF48JF4SyayxXw18Ary5ArnIkay2k39Fk34Fk3W8trn8Gr1kK342vFZF9rW8XayY
	vws2qrya93W2g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwhVX52pschWNWwAA3Q

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

While a stale reset_interrupt() sits in result(), unlock_fdc() can
also clear cont and let a new request install another continuation, so
a plain !cont check after result() is not enough. Bump cont_seq when
clearing cont, sample it in schedule_bh() as bh_seq, and use cont in
reset_interrupt() only when the sequences still match.

Reported-by: syzbot+619e27617b2abe6b9b72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619e27617b2abe6b9b72
Link: https://lore.kernel.org/linux-block/00000000000093c4d105f9aa34d6@google.com/
Link: https://lists.openwall.net/linux-kernel/2021/10/27/56
Assisted-by: Cursor:Composer
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
Changes in v2:
- Use cont_seq/bh_seq instead of a plain !cont check
v1: https://lore.kernel.org/linux-block/20260723073512.11120-1-yangxiuwei@kylinos.cn/

 drivers/block/floppy.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index f04397b8e381..ec17625b8c08 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -536,6 +536,25 @@ static const struct cont_t {
 				 * succeeded/failed */
 } *cont;
 
+static atomic_t cont_seq = ATOMIC_INIT(0);
+static unsigned int bh_seq;
+
+static void cont_invalidate(void)
+{
+	WRITE_ONCE(cont, NULL);
+	atomic_inc_return_release(&cont_seq);
+}
+
+static const struct cont_t *cont_for_bh(void)
+{
+	unsigned int seq = atomic_read_acquire(&cont_seq);
+	const struct cont_t *c = READ_ONCE(cont);
+
+	if (seq != bh_seq || !c)
+		return NULL;
+	return c;
+}
+
 static void floppy_ready(void);
 static void floppy_start(void);
 static void process_fd_request(void);
@@ -907,7 +926,7 @@ static void unlock_fdc(void)
 	command_status = FD_COMMAND_NONE;
 	cancel_delayed_work(&fd_timeout);
 	do_floppy = NULL;
-	cont = NULL;
+	cont_invalidate();
 	clear_bit(0, &fdc_busy);
 	wake_up(&fdc_wait);
 }
@@ -997,6 +1016,7 @@ static void schedule_bh(void (*handler)(void))
 {
 	WARN_ON(work_pending(&floppy_work));
 
+	bh_seq = atomic_read(&cont_seq);
 	floppy_work_fn = handler;
 	queue_work(floppy_wq, &floppy_work);
 }
@@ -1782,13 +1802,18 @@ static void recalibrate_floppy(void)
  */
 static void reset_interrupt(void)
 {
+	const struct cont_t *c;
+
 	debugt(__func__, "");
 	result(current_fdc);		/* get the status ready for set_fdc */
+	c = cont_for_bh();
+	if (!c)
+		return;
 	if (fdc_state[current_fdc].reset) {
-		pr_info("reset set in interrupt, calling %ps\n", cont->error);
-		cont->error();	/* a reset just after a reset. BAD! */
+		pr_info("reset set in interrupt, calling %ps\n", c->error);
+		c->error();	/* a reset just after a reset. BAD! */
 	}
-	cont->redo();
+	c->redo();
 }
 
 /*
@@ -1988,7 +2013,7 @@ static void floppy_start(void)
 static void do_wakeup(void)
 {
 	reschedule_timeout(MAXTIMEOUT, "do wakeup");
-	cont = NULL;
+	cont_invalidate();
 	command_status += 2;
 	wake_up(&command_done);
 }
-- 
2.25.1

