Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDF3DB63A
	for <linux-block@vger.kernel.org>; Mon,  5 Oct 2026 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234402; cv=none; b=ogFXDK7Ckog/OvKtQNH1/nO3nHrB49x9gqQLX9aSde3vETbqhWWxw86D3l3X2fCRq0JDbd3vqglvxGZOPp/+FHZ+oHeqagGSBbPxGl5t3S24iRWrbZRVgmGV95IKurpS6mxShN+BewvXp+LTL6tEdIx5eQ0tcoBM1VPKD5KOhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234402; c=relaxed/simple;
	bh=wv2959ePKX1ywbNlKsSwOCxix/0oQ9bLl875jkdkMS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WlPLFeuOq36NIfjF6Usz48I1SjJNmSwxPXDObrDrSAJ2p/0Rr/ZkMJmUeSXkK5i0fGcH6hIRwaxcGNZSK1G2eVSwdePXR0I5Zm0nWkjaX67c97+6aCns4Nu0vycZFwfRizddhGGhPgac7qQ3oQ6gjwXYifK41pa6AQbC8K7FwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gyPY1tVf; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gyPY1tVf"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hzBlF6V7Mz1XM4Tl;
	Mon,  5 Oct 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1791234380; x=1793826381; bh=sP34S
	qkNDeL/tKBxZ9lGYpaVz8noERnL0QBOEYwdpGo=; b=gyPY1tVfbai+QkYnLwEMk
	uPab3AFnKHIJ3o0s2thpbsRIO150Xm93hHaDNCu9wjkj/Aby3+8pxGXkDyp13+WM
	lLql7RzdPjTgZRGIA/xmALhUJh8x2LVAuXSO/f8tlkBim0ObzzbqYDT8rbZnLoJu
	xNeaXs7m2ky6ovtLEsv6zA6D3ng0DnPTsBnEP+XbwX1VPhUyVZl/dTyX9jV9+WZr
	+Ceo4IC3S7VCbNnn/rDGL9tobLuFDWS+G3nvtjd63gfGAm2KPMG/Exub7mwMX9we
	8qhmlVOllc1KmKB5zCLblyboBvMxVBnUlR9LxHK8CoepBPTobuqOOtbGn5bAstJX
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id DPN_uoNMMemL; Mon,  5 Oct 2026 21:06:20 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hzBkx2zh3z1XM4TB;
	Mon,  5 Oct 2026 21:06:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6] loop: Wait for I/O completion in __loop_clr_fd()
Date: Mon,  5 Oct 2026 14:06:02 -0700
Message-ID: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Syzbot reports a NULL pointer dereference in lo_rw_aio(). This crash
probably happens because commit b15e4310633f ("jfs: Set the lbmDONE flag =
at
the end of lbmIODone"), merged in the 7.1 merge window, lets the JFS log
code report a write as finished while it is still in flight. JFS then tea=
rs
down and releases the loop device with that write still sitting in the lo=
op
workqueue.

Although the root cause is in JFS, improve the loop driver by waiting in
__loop_clr_fd() for ongoing I/O. Release &disk->open_mutex temporarily
because otherwise a deadlock would be triggered.

This patch introduces a behavior change: openers racing with teardown now
get -ENXIO instead of waiting.

Link: https://lkml.kernel.org/r/fbb3edda-f108-4e5b-acf2-266f043f8125@I-lo=
ve.SAKURA.ne.jp
Link: https://syzkaller.appspot.com/bug?extid=3Dcd8a9a308e879a4e2c28
Link: https://syzkaller.appspot.com/bug?extid=3Dbc273027d5643e48e5b3
Cc: Christoph Hellwig <hch@lst.de>
Cc: Edward Adam Davis <eadavis@qq.com>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
Assisted-by: Gemini Pro
Assisted-by: Claude Opus
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[ bvanassche: rewrote description, eliminated .post_release() callback,
  changed a synchronize_rcu() call into quiescing + unquiescing the
  request queue, reordered code in __loop_clr_fd() and rewrote several
  comments ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes from v5 to v6:
- Drop the invasive core block-layer changes (adding .post_release to
  struct block_device_operations and calling it from block/bdev.c). Keep
  all changes completely self-contained within drivers/block/loop.c.
- Instead of deferring teardown to a core post_release callback, temporar=
ily
  unlock and re-acquire &disk->open_mutex inside __loop_clr_fd().
- Add WARN_ON_ONCE(lo->lo_state !=3D Lo_rundown) checks around the unlock=
/lock
  window to ensure racing openers get -ENXIO via lo_open() rather than se=
eing
  a partially torn-down device.
- Replace drain_workqueue() with flush_workqueue() to prevent warnings ab=
out
  queueing work on a draining workqueue (__WQ_DRAINING).
- Replace synchronize_rcu() with blk_mq_quiesce_queue() + blk_mq_unquiesc=
e_queue()
  to properly synchronize against in-flight loop_queue_rq() instances usi=
ng
  standard block-layer primitives.
- Add an extensive comment documenting the exact 3-step circular locking
  scenario caught by syzbot (disk->open_mutex -> wq_completion -> VFS/sub=
system
  locks -> disk->open_mutex).
- Identify and document the probable trigger in JFS (commit b15e4310633f,
  "jfs: Set the lbmDONE flag at the end of lbmIODone") in the commit mess=
age.
- Add Cc tags for JFS maintainers (Dave Kleikamp, jfs-discussion) and Chr=
istoph
  Hellwig. Update AI assistance tags to conform to Linux kernel attributi=
on guidelines.

Changes from v4 to v5:
- Introduce a new .post_release() callback in struct block_device_operati=
ons
  called from bdev_release() after dropping disk->open_mutex.
- Invoke __loop_clr_fd() from the new loop_post_release() callback instea=
d of
  calling it synchronously under disk->open_mutex in loop_release().

Changes from v3 to v4:
- Add blk_mq_freeze_queue() / blk_mq_unfreeze_queue() in __loop_clr_fd() =
to
  wait for pending asynchronous direct I/O (lo_rw_aio returning -EIOCBQUE=
UED)
  which drain_workqueue() alone does not wait for.

Changes from v2 to v3:
- Address the syzbot circular locking report (bug extid=3D2f62807dc3239b8=
f584e)
  caused by calling drain_workqueue() while holding disk->open_mutex.

Changes from v1 to v2:
- Remove the custom SRCU domain (loop_io_srcu).
- Replace srcu_read_lock() / synchronize_srcu() with rcu_read_lock() and
  synchronize_rcu().

 drivers/block/loop.c | 72 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..94a62b92b5a1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1138,11 +1138,65 @@ static int loop_configure(struct loop_device *lo,=
 blk_mode_t mode,
=20
 static void __loop_clr_fd(struct loop_device *lo)
 {
+	struct gendisk *disk =3D lo->lo_disk;
 	struct queue_limits lim;
 	struct file *filp;
 	gfp_t gfp =3D lo->old_gfp_mask;
 	int err;
=20
+	/*
+	 * lo->lo_state must be Lo_rundown before we release disk->open_mutex
+	 * to ensure that lo_open() fails while disk->open_mutex is unlocked.
+	 */
+	WARN_ON_ONCE(lo->lo_state !=3D Lo_rundown);
+
+	/*
+	 * Unlock disk->open_mutex to prevent circular locking. Without the
+	 * mutex_unlock() call below, circular locking would be triggered as
+	 * follows when an autoclearing loop device is closed by its last opene=
r:
+	 * 1. open_mutex =E2=86=92 Workqueue Completion / Queue Freeze: Waiting=
 for
+	 *    pending I/O requires draining the loop device's execution
+	 *    workqueue (flush_workqueue(lo->workqueue)) and/or freezing the
+	 *    request queue (blk_mq_freeze_queue()). Draining the workqueue
+	 *    acquires its completion lockdep tracking context
+	 *    ((wq_completion)loopX). If called while disk->open_mutex is held,
+	 *    lockdep records the lock acquisition ordering: disk->open_mutex =E2=
=9F=B6
+	 *    (wq_completion)loopX
+	 * 2. Workqueue Completion =E2=86=92 Subsystem/VFS Locks: In-flight wor=
k items
+	 *    executed by worker threads on lo->workqueue (loop_process_work()=E2=
=86=92
+	 *    lo_rw_aio()) perform file operations on the underlying backing
+	 *    file. These operations acquire VFS and filesystem locks (such as
+	 *    inode locks, file-specific locks, kernfs mutexes like &of->mutex,
+	 *    or seq_file locks).
+	 * 3. Subsystem/VFS Locks =E2=86=92 open_mutex: Other code paths in the=
 kernel
+	 *    (for instance, partition scanners, power management/hibernation
+	 *    resume routines such as resume_store() =E2=86=92 swsusp_check(), =
or sysfs
+	 *    operations) acquire subsystem/filesystem locks first and then cal=
l
+	 *    bdev_open(), which acquires disk->open_mutex.
+	 *
+	 * This creates a circular locking dependency: disk->open_mutex =E2=9F=B6
+	 * (wq_completion)loopX =E2=9F=B6 VFS=C2=A0/=C2=A0Subsystem=C2=A0Locks =
=E2=9F=B6 disk->open_mutex
+	 *
+	 * Syzbot caught this exact circular locking scenario. See also
+	 * https://syzkaller.appspot.com/bug?extid=3D2f62807dc3239b8f584e.
+	 */
+	mutex_unlock(&disk->open_mutex);
+
+	/* Wait for all outstanding I/O requests to finish. */
+	blk_mq_unfreeze_queue(lo->lo_queue, blk_mq_freeze_queue(lo->lo_queue));
+	/*
+	 * Wait until all ongoing loop_queue_rq() calls have finished. Freezing
+	 * the request queue may finish before loop_queue_rq() has finished.
+	 */
+	blk_mq_quiesce_queue(lo->lo_queue);
+	blk_mq_unquiesce_queue(lo->lo_queue);
+	/* Wait for ongoing loop_handle_cmd() calls to finish. */
+	flush_workqueue(lo->workqueue);
+
+	/* Reacquire disk->open_mutex and clear *lo. */
+	mutex_lock(&disk->open_mutex);
+	WARN_ON_ONCE(lo->lo_state !=3D Lo_rundown);
+
 	spin_lock_irq(&lo->lo_lock);
 	filp =3D lo->lo_backing_file;
 	lo->lo_backing_file =3D NULL;
@@ -1153,16 +1207,16 @@ static void __loop_clr_fd(struct loop_device *lo)
 	lo->lo_sizelimit =3D 0;
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
=20
-	/*
-	 * Reset the block size to the default.
-	 *
-	 * No queue freezing needed because this is called from the final
-	 * ->release call only, so there can't be any outstanding I/O.
-	 */
+	/* Reset the block size to the default. */
 	lim =3D queue_limits_start_update(lo->lo_queue);
 	lim.logical_block_size =3D SECTOR_SIZE;
 	lim.physical_block_size =3D SECTOR_SIZE;
 	lim.io_min =3D SECTOR_SIZE;
+	/*
+	 * No queue freeze around the queue limits update below because any I/O
+	 * that races with this update fails in loop_queue_rq(), so a
+	 * transiently inconsistent view of the limits is harmless.
+	 */
 	queue_limits_commit_update(lo->lo_queue, &lim);
=20
 	invalidate_disk(lo->lo_disk);
@@ -1202,9 +1256,9 @@ static void __loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
=20
 	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
+	 * fput() calls file->f_op->release() asynchronously. Hence, calling
+	 * fput() while holding disk->open_mutex won't trigger recursive lockin=
g
+	 * for disk->open_mutex in case of stacked loop devices.
 	 */
 	fput(filp);
 }
