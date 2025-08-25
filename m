Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60D2741DA
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146463; cv=none; b=iIUcw/p86jBCulXSd58F1Fm+jHqowywQF+y99ioN7Rs/8b7q6lCagF5B5zEJO2NkEloPI7l0XFQWR8GRBNWjHf4KDPAAeQTWEgSCrpHAgNM8jS/i+l+jb0eED1ML3EIg7ZtNCbOO7gAciZqG3hBUXTbXRscNBsQGjm8p/RKyaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146463; c=relaxed/simple;
	bh=j748ER8dNugfb2W/p/egcOaeeLwzkk4lufR6OPSx/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7LtECOIoAn8y13Go//k4/RAFJBxcYpp+z0LnK9HG0Cbzvr0zmLn+ICKuyTyXvxFV+tMdYPLrt2ob11k2QwxNPn+Y9WJs2reHHfp6OubfKh4vmC/irxoFFbZ/Ijz4Js3gKmvE1LTA1QwU6RCNy8z0srN+lCH+LOHDskB+/hNd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zLKlcXSC; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zLKlcXSC"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4c9fRH2yj2zm174D;
	Mon, 25 Aug 2025 18:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1756146457; x=1758738458; bh=LOJniSLLnDt8hto+mpuq2vbwwSE0AY29jfw
	L2o5iLCs=; b=zLKlcXSCH46Hmtvha/skJsrgE52pl6TCmU++2AenIGumMcPhBSl
	44JXdx/225jpvFjm+soT4x1ZEppmwxiX+SwA1uO50z9GZjtjJ44/H/kiPT8A672e
	qWRDgmkHt95VFpigiQlihNYqPuaR125/4PtjdcOwHWA1FjJTxvxJ3Q4trmzGE5Tu
	JwhhauoWfMMS2NfCHN0dyypivtij7ag7xCcvMZqvyuFdVmhyIiKx3adTuKGc1tqN
	+u70TBBGFciAOWN6eGeTNkqFZlDJBjl1qnRIBuTiKyt6w3qKx9R/k/cCWoYMJCFg
	6s5aZEKQ2PqtdiMJzZfG8Q7IGZNbNRO659Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id beJOD4ZoZIdp; Mon, 25 Aug 2025 18:27:37 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4c9fR94Thvzm10gS;
	Mon, 25 Aug 2025 18:27:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-zoned: Fix a lockdep complaint about recursive locking
Date: Mon, 25 Aug 2025 11:27:19 -0700
Message-ID: <20250825182720.1697203-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If preparing a write bio fails then blk_zone_wplug_bio_work() calls
bio_endio() with zwplug->lock held. If a device mapper driver is stacked
on top of the zoned block device then this results in nested locking of
zwplug->lock. The resulting lockdep complaint is a false positive
because this is nested locking and not recursive locking. Suppress this
false positive by calling blk_zone_wplug_bio_io_error() without holding
zwplug->lock. This is safe because no code in
blk_zone_wplug_bio_io_error() depends on zwplug->lock being held. This
patch suppresses the following lockdep complaint:

WARNING: possible recursive locking detected
--------------------------------------------
kworker/3:0H/46 is trying to acquire lock:
ffffff882968b830 (&zwplug->lock){-...}-{2:2}, at: blk_zone_write_plug_bio=
_endio+0x64/0x1f0

but task is already holding lock:
ffffff88315bc230 (&zwplug->lock){-...}-{2:2}, at: blk_zone_wplug_bio_work=
+0x8c/0x48c

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&zwplug->lock);
  lock(&zwplug->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/3:0H/46:
 #0: ffffff8809486758 ((wq_completion)sdd_zwplugs){+.+.}-{0:0}, at: proce=
ss_one_work+0x1bc/0x65c
 #1: ffffffc085de3d70 ((work_completion)(&zwplug->bio_work)){+.+.}-{0:0},=
 at: process_one_work+0x1e4/0x65c
 #2: ffffff88315bc230 (&zwplug->lock){-...}-{2:2}, at: blk_zone_wplug_bio=
_work+0x8c/0x48c

stack backtrace:
CPU: 3 UID: 0 PID: 46 Comm: kworker/3:0H Tainted: G        W  OE      6.1=
2.38-android16-5-maybe-dirty-4k #1 8b362b6f76e3645a58cd27d86982bce10d1500=
25
Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: Spacecraft board based on MALIBU (DT)
Workqueue: sdd_zwplugs blk_zone_wplug_bio_work
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xa0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x38c/0x398
 __lock_acquire+0x13e8/0x2e1c
 lock_acquire+0x134/0x2b4
 _raw_spin_lock_irqsave+0x5c/0x80
 blk_zone_write_plug_bio_endio+0x64/0x1f0
 bio_endio+0x9c/0x240
 __dm_io_complete+0x214/0x260
 clone_endio+0xe8/0x214
 bio_endio+0x218/0x240
 blk_zone_wplug_bio_work+0x204/0x48c
 process_one_work+0x26c/0x65c
 worker_thread+0x33c/0x498
 kthread+0x110/0x134
 ret_from_fork+0x10/0x20

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ef43aaca49f4..5e2a5788dc3b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1286,14 +1286,14 @@ static void blk_zone_wplug_bio_work(struct work_s=
truct *work)
 	struct block_device *bdev;
 	unsigned long flags;
 	struct bio *bio;
+	bool prepared;
=20
 	/*
 	 * Submit the next plugged BIO. If we do not have any, clear
 	 * the plugged flag.
 	 */
-	spin_lock_irqsave(&zwplug->lock, flags);
-
 again:
+	spin_lock_irqsave(&zwplug->lock, flags);
 	bio =3D bio_list_pop(&zwplug->bio_list);
 	if (!bio) {
 		zwplug->flags &=3D ~BLK_ZONE_WPLUG_PLUGGED;
@@ -1304,13 +1304,14 @@ static void blk_zone_wplug_bio_work(struct work_s=
truct *work)
 	trace_blk_zone_wplug_bio(zwplug->disk->queue, zwplug->zone_no,
 				 bio->bi_iter.bi_sector, bio_sectors(bio));
=20
-	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
+	prepared =3D blk_zone_wplug_prepare_bio(zwplug, bio);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	if (!prepared) {
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
 	}
=20
-	spin_unlock_irqrestore(&zwplug->lock, flags);
-
 	bdev =3D bio->bi_bdev;
=20
 	/*
