Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710ED27E
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786026; cv=none; b=ANpK3mqbJOom5OUEFJOdo2ZfAkVR/S1sEpJ5hCYI6ucWPkfoJyp+J8lQHfRpQwLTGzsAf4cMOhyWDFmupDP8QjAZ/JNKvm2v7AvukMeCXF8i3CF+1qWZdqu6hNTPiVhhw2uOKsolEYkxEPzjT71CbEFZLZIYc8iXn/L/ZSOSno4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786026; c=relaxed/simple;
	bh=SXecoBR5swnLhEZaNrCt5dHR7f3a7Spqx6PmQSMEDQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfXEF1gpNA5xoL9YWVnKL+yc90jp/2y0M1iW9qEigyV62vQ9XldpNoTvVu6HHJlcWJQLl4YX6sThHtITWgH0/5tW3k8+2OTEwhq7sSkbU4pkSyMjMJVr61nP0FASf0W4O8RWIFfBjbOUf7r1nL+u5h/iwpacqLK9QSDwAhJ3B7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Zh1Pc4F6; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Zh1Pc4F6"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b2BYg47FszlvkTy;
	Wed, 21 May 2025 00:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1747786022; x=1750378023; bh=wmyUr
	+KKtrVKkkZypa97BQ+f2uNiYgsN5H2RxHGmghw=; b=Zh1Pc4F6MTi2T1HLknbK0
	LneeSBRBJ1YEVExH1CLF4sJ2KJXSxM2+RIiAAWg2yUkhBFiUtvbw9RNt3IEjppg9
	PlOTe4VMTkkAdbppjYjixQGgjYLXBw45zBwcplX3nLjhAxm8H6mhr+e395KJLOvx
	+bHeYBgMSqOtSxARj7ybrhW5KeacrCutGWT6Rk503jcjvu//1eRFVOLa4Y45jIre
	sqrWDy55eBarlyikgiZs++UxCMmKOQAN7Ccem1PFXkV1h/A85lUdhRkHlquMs7Du
	0ohaz0T/BtHPJK32LGKOaeQ47YHeyHst34LQNsbocxDjrxWX9/mTzi7Bcus9myLH
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C8RG56dR8LB1; Wed, 21 May 2025 00:07:02 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b2BYZ2xRSzlvqlB;
	Wed, 21 May 2025 00:06:57 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/3] blk-zoned: Do not lock zwplug->lock recursively
Date: Tue, 20 May 2025 17:06:26 -0700
Message-ID: <20250521000626.1314859-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521000626.1314859-1-bvanassche@acm.org>
References: <20250521000626.1314859-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If zoned block devices are stacked and if a lower driver reports an I/O
error, this triggers nested locking of spinlocks. Rework the zoned block
device code such that this doesn't happen anymore. This patch fixes the
following kernel warning:

WARNING: possible recursive locking detected
--------------------------------------------
kworker/6:1H/203 is trying to acquire lock:
ffffff8881697130 (&zwplug->lock){-...}-{2:2}, at: blk_zone_write_plug_bio=
_endio+0x144/0x290

but task is already holding lock:
ffffff884e99d930 (&zwplug->lock){-...}-{2:2}, at: blk_zone_wplug_bio_work=
+0x30/0x250

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&zwplug->lock);
  lock(&zwplug->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by kworker/6:1H/203:
 #0: ffffff88128ed358 ((wq_completion)sde_zwplugs){+.+.}-{0:0}, at: proce=
ss_one_work+0x1bc/0x65c
 #1: ffffffc088343d70 ((work_completion)(&zwplug->bio_work)){+.+.}-{0:0},=
 at: process_one_work+0x1e4/0x65c
 #2: ffffff884e99d930 (&zwplug->lock){-...}-{2:2}, at: blk_zone_wplug_bio=
_work+0x30/0x250

stack backtrace:
Workqueue: sde_zwplugs blk_zone_wplug_bio_work
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0xa0
 dump_stack+0x18/0x24
 print_deadlock_bug+0x38c/0x398
 __lock_acquire+0x13e8/0x2e1c
 lock_acquire+0x134/0x2b4
 _raw_spin_lock_irqsave+0x5c/0x80
 blk_zone_write_plug_bio_endio+0x144/0x290
 bio_endio+0x9c/0x240
 __dm_io_complete+0x210/0x27c
 clone_endio+0xe8/0x214
 bio_endio+0x218/0x240
 blk_crypto_fallback_encrypt_endio+0x78/0x94
 bio_endio+0x218/0x240
 blk_zone_wplug_bio_work+0xa8/0x250
 process_one_work+0x26c/0x65c
 worker_thread+0x33c/0x498
 kthread+0x110/0x134
 ret_from_fork+0x10/0x20

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ce5604c92fea..4bff76a06204 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -614,12 +614,11 @@ static void disk_zone_wplug_abort(struct blk_zone_w=
plug *zwplug)
 	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
 			    zwplug->disk->disk_name, zwplug->zone_no);
 	for (;;) {
-		scoped_guard(spinlock_irqsave, &zwplug->lock) {
+		scoped_guard(spinlock_irqsave, &zwplug->lock)
 			bio =3D bio_list_pop(&zwplug->bio_list);
-			if (!bio)
-				break;
-			blk_zone_wplug_bio_io_error(zwplug, bio);
-		}
+		if (!bio)
+			break;
+		blk_zone_wplug_bio_io_error(zwplug, bio);
 	}
 }
=20
@@ -1236,8 +1235,9 @@ void blk_zone_write_plug_bio_endio(struct bio *bio)
 	 * needing a write pointer update.
 	 */
 	if (bio->bi_status !=3D BLK_STS_OK) {
-		spin_lock_irqsave(&zwplug->lock, flags);
 		disk_zone_wplug_abort(zwplug);
+
+		spin_lock_irqsave(&zwplug->lock, flags);
 		zwplug->flags |=3D BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 	}
@@ -1288,13 +1288,12 @@ static void blk_zone_wplug_bio_work(struct work_s=
truct *work)
 	unsigned long flags;
 	struct bio *bio;
=20
+again:
 	/*
 	 * Submit the next plugged BIO. If we do not have any, clear
 	 * the plugged flag.
 	 */
 	spin_lock_irqsave(&zwplug->lock, flags);
-
-again:
 	bio =3D bio_list_pop(&zwplug->bio_list);
 	if (!bio) {
 		zwplug->flags &=3D ~BLK_ZONE_WPLUG_PLUGGED;
@@ -1303,6 +1302,7 @@ static void blk_zone_wplug_bio_work(struct work_str=
uct *work)
 	}
=20
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
+		spin_unlock_irqrestore(&zwplug->lock, flags);
 		blk_zone_wplug_bio_io_error(zwplug, bio);
 		goto again;
 	}
