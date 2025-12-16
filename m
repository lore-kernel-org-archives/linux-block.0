Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE491EEE6;
	Tue, 16 Dec 2025 03:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765855412; cv=none; b=fM9FPRvN67OEgD++HeU2rPpQR7M8HTbQIFHj0znaWDjy+B4anB357/hzfKEl4qmWcBwCDTfYiuLQQFDLWaFZim9yQnITE3lGwV3/kQj5GJA7++QeOodQ0qrWKYjrevdLZ/hfXYxWSUFh9AJ8CKxB0QnfTXloriPvvaGvVAy7O3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765855412; c=relaxed/simple;
	bh=PF6nFxIEwkJtkqBvZ196wD7p+090h+6B6+WuSnigkqg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t/4YG4j47a+w+7sR8o3ovT/d/TwWZ1Qre6/6t1aDCuams+rZVojQCQi3HKy9FMSyFFI8X81O2Me0tnypAjKJR3r2Mchb9/4InFDFaiU+x8lamOwmc3nptW6KGx74v9ap545MzGndrAj3HeJUXb6yaWYfsqKd3S0eg/EUAVw/YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gemG07/Y; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gemG07/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1765855406; bh=p5yuLsGyp5kCvNGGIQ8SyQX+Gu2MixumdLNQY2QtFxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gemG07/YvSM49h/xZirbGXAm9MyutMHK1jYhUiGE7Xm4aQ2oIvPFGWaaVgjAiqsno
	 XxDU1r+QewwLG8JxttuCjpRlbn36VBnG7zfjOQDgjG+m55q3hsB9R/jTCdovxyz/QO
	 jXlULSNJYOTLIcugMHCNuiTetzNnL9Dh2Hu/Id1o=
Received: from lxu-ped-host.. ([111.201.7.117])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 5D78585E; Tue, 16 Dec 2025 11:23:23 +0800
X-QQ-mid: xmsmtpt1765855403t6mlkxap7
Message-ID: <tencent_2AC2ECAACC587B4E6C342D096F909424E90A@qq.com>
X-QQ-XMAILINFO: NvfE96cLltb5C1bT1tmooJOBdWJs+NzOOjfFwX7X/PixaY8cpvQi+LbvE4Jp1o
	 X182O/rXSwNbP7FjXdcgTWygdZg8OxkC5TTIQeAFEIVJibQUDQVQgJM7NzVOo4U0fg7McwP7PSK3
	 ppKf9as1w2NEZqiP7TLwAyWDMf/bNWPkJ421epsftLcSqEQAlsfFMmLlcmc5aEQ5yVWmybBILp+/
	 /uJZtuqt4fLoeTDMwpzpYg15rwEQxLChVplQNG0zt5OL/Yoe1lt9mD4Xsm8AFRLf6dyckCSHibCV
	 Rh9vuz0OjQWkCusUulUbrAQp7XNNAgx22JVW+3G3HJ+DtRJvUnV/SyDCtyJPMTaCaEc++p+2cuPj
	 uGKza85gjR76qYktJkeuYKxFis3nx1xwFbYiLc8GmU8EadNnBNvGRe6uqGZqEnPhjBraKXalLtFF
	 gh6fLDGRHLv5MuLfI3dObZyjOlVygQA0BHXvTMdBarBks9H2ez8Z111eIpwlUG13nwftY6dnVN90
	 uoHqwuOUuaZbBD+rQ4yqbZ20u53F08Y+q2Dg4k1NmELPmybROEdIgIibWDPigw2Z56quHlYhhayk
	 N0JiXMlo9Wec08FvdLXqmWu6QT0zNu/RqDAp8OuPs2kAnt1sMtFVk79wPRNGp3foatOSGuQcAkfj
	 a6XJvQ65xhJO53d8Xaj/OM1eGevvQLXSRaHlCJJsVORMwAwgpkkEbfJz5wKBykyPRE9ZGQq1nycU
	 nS73ySRta7tYmNbYIGjyDs2C9+7nJmQc+Ks15E5w52uDSwEPYKtC6LwLvgAFSCLaMvl7QrO5Jywq
	 k/w6gFspTijrKofcM+rCZW6UY3Nz1tVimk9i0PkrIgHk4IKEGCjR8LF0pXAGT6/oAQNPl2RAF1NZ
	 e1q+Zg8Mu8xPwoM5z5jVMHhFoFmGsjujVzn11rdOXbRmpLIKEkOwaCUYlvEhbjEKyBW23eShZfAQ
	 Y/fg8o3PLgeVobVBrAkcG6j5pPiDkeQaifQVBayQ6MUKSKbqfWG2qLCd+FLTt9RgkabB4SDZkp2G
	 /WNT7P5aFdT0Wpudy3
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	jfs-discussion@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: Extend the done of the window period
Date: Tue, 16 Dec 2025 11:23:24 +0800
X-OQ-MSGID: <20251216032323.15192-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <693eb292.a70a0220.33cd7b.00c7.GAE@google.com>
References: <693eb292.a70a0220.33cd7b.00c7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In lbmRead(), the I/O event waited for by wait_event() finishes before
it goes to sleep, and the lbmIODone() prematurely sets the flag to
lbmDONE, thus ending the wait. This causes wait_event() to return before
lbmREAD is cleared (because lbmDONE was set first), the premature return
of wait_event() leads to the release of lbuf before lbmIODone() returns,
thus triggering the use-after-free vulnerability reported in [1].

Moving the operation of setting the lbmDONE flag to after clearing lbmREAD
in lbmIODone() avoids the use-after-free vulnerability reported in [1].

[1]
BUG: KASAN: slab-use-after-free in rt_spin_lock+0x88/0x3e0 kernel/locking/spinlock_rt.c:56
Call Trace:
 blk_update_request+0x57e/0xe60 block/blk-mq.c:1007
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1169
 blk_complete_reqs block/blk-mq.c:1244 [inline]
 blk_done_softirq+0x10a/0x160 block/blk-mq.c:1249

Allocated by task 6101:
 lbmLogInit fs/jfs/jfs_logmgr.c:1821 [inline]
 lmLogInit+0x3d0/0x19e0 fs/jfs/jfs_logmgr.c:1269
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532

Freed by task 6101:
 kfree+0x1bd/0x900 mm/slub.c:6876
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1864 [inline]
 lmLogInit+0x1137/0x19e0 fs/jfs/jfs_logmgr.c:1415
 open_inline_log fs/jfs/jfs_logmgr.c:1175 [inline]
 lmLogOpen+0x4e1/0xfa0 fs/jfs/jfs_logmgr.c:1069
 jfs_mount_rw+0xe9/0x670 fs/jfs/jfs_mount.c:257
 jfs_fill_super+0x754/0xd80 fs/jfs/super.c:532

Reported-by: syzbot+1d38eedcb25a3b5686a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1d38eedcb25a3b5686a7
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_logmgr.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index b343c5ea1159..dda9ffa8eaf5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2180,8 +2180,6 @@ static void lbmIODone(struct bio *bio)
 
 	LCACHE_LOCK(flags);		/* disable+lock */
 
-	bp->l_flag |= lbmDONE;
-
 	if (bio->bi_status) {
 		bp->l_flag |= lbmERROR;
 
@@ -2196,12 +2194,10 @@ static void lbmIODone(struct bio *bio)
 	if (bp->l_flag & lbmREAD) {
 		bp->l_flag &= ~lbmREAD;
 
-		LCACHE_UNLOCK(flags);	/* unlock+enable */
-
 		/* wakeup I/O initiator */
 		LCACHE_WAKEUP(&bp->l_ioevent);
 
-		return;
+		goto out;
 	}
 
 	/*
@@ -2225,8 +2221,7 @@ static void lbmIODone(struct bio *bio)
 
 	if (bp->l_flag & lbmDIRECT) {
 		LCACHE_WAKEUP(&bp->l_ioevent);
-		LCACHE_UNLOCK(flags);
-		return;
+		goto out;
 	}
 
 	tail = log->wqueue;
@@ -2278,8 +2273,6 @@ static void lbmIODone(struct bio *bio)
 	 * leave buffer for i/o initiator to dispose
 	 */
 	if (bp->l_flag & lbmSYNC) {
-		LCACHE_UNLOCK(flags);	/* unlock+enable */
-
 		/* wakeup I/O initiator */
 		LCACHE_WAKEUP(&bp->l_ioevent);
 	}
@@ -2288,7 +2281,6 @@ static void lbmIODone(struct bio *bio)
 	 *	Group Commit pageout:
 	 */
 	else if (bp->l_flag & lbmGC) {
-		LCACHE_UNLOCK(flags);
 		lmPostGC(bp);
 	}
 
@@ -2302,9 +2294,11 @@ static void lbmIODone(struct bio *bio)
 		assert(bp->l_flag & lbmRELEASE);
 		assert(bp->l_flag & lbmFREE);
 		lbmfree(bp);
-
-		LCACHE_UNLOCK(flags);	/* unlock+enable */
 	}
+
+out:
+	bp->l_flag |= lbmDONE;
+	LCACHE_UNLOCK(flags);
 }
 
 int jfsIOWait(void *arg)
-- 
2.43.0

