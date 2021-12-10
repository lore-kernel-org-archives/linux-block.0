Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F9DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 03:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbhLJD5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 22:57:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53846 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhLJD5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 22:57:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30306210FC;
        Fri, 10 Dec 2021 03:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639108439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMu/aevduW42MHg3tanWmOWU0rlV9i7k/PrF10BgEqM=;
        b=ubb5HPyIxEb4UJcp2Rsr9UPMGEdv8LBHRhAMngk2nAr0SVC9BaZhtMrJUOS0mLnxLbFOoK
        Ix35aMQlRQRdjvOS/DWFtkbXEwUh8xW9t7Q+FbfSVYJAxuGnYes9iSAd/v6v+Y+VaztYcN
        34rM2453Zh54isGxqXw0uO/SQOIIS3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639108439;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JMu/aevduW42MHg3tanWmOWU0rlV9i7k/PrF10BgEqM=;
        b=G40e/VqRMilTbrLGkWQ2LSeUZI9luJTwmHUG18VUu+Di5czmGLvoCKYgQlw1UtOglkJYE5
        L448Wd3F8OpnTRDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 222E513463;
        Fri, 10 Dec 2021 03:53:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f1ekNFXPsmHpQwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 10 Dec 2021 03:53:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>,
        "Jens Axboe" <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v3] pktdvd: stop using bdi congestion framework.
In-reply-to: <163910839418.9928.16399258868028694519@noble.neil.brown.name>
References: <163712340344.13692.2840899631949534137@noble.neil.brown.name>,
 <YZTx/93/9cjYW4zI@infradead.org>,
 <163910839418.9928.16399258868028694519@noble.neil.brown.name>
Date:   Fri, 10 Dec 2021 14:53:55 +1100
Message-id: <163910843527.9928.857338663717630212@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


From afac2a88e6a256ffde7040c4191a2bae5df7f5f3 Mon Sep 17 00:00:00 2001
From: NeilBrown <neilb@suse.de>
Date: Wed, 29 Sep 2021 14:24:01 +1000
Subject: [PATCH] pktdvd: stop using bdi congestion framework.

The bdi congestion framework isn't widely used and should be
deprecated.

pktdvd makes use of it to track congestion, but this can be done
entirely internally to pktdvd, so it doesn't need to use the framework.

So introduce a "congested" flag.  When waiting for bio_queue_size to
drop, set this flag and a var_waitqueue() to wait for it.  When
bio_queue_size does drop and this flag is set, clear the flag and call
wake_up_var().

We don't use a wait_var_event macro for the waiting as we need to set
the flag and drop the spinlock before calling schedule() and while that
is possible with __wait_var_event(), result is not easy to read.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/block/pktcdvd.c | 31 ++++++++++++++++++++-----------
 include/linux/pktcdvd.h |  2 ++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b53f648302c1..96fe68dbd6c7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1107,7 +1107,6 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	sector_t zone =3D 0; /* Suppress gcc warning */
 	struct pkt_rb_node *node, *first_node;
 	struct rb_node *n;
-	int wakeup;
=20
 	atomic_set(&pd->scan_queue, 0);
=20
@@ -1179,12 +1178,14 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 		spin_unlock(&pkt->lock);
 	}
 	/* check write congestion marks, and if bio_queue_size is
-	   below, wake up any waiters */
-	wakeup =3D (pd->write_congestion_on > 0
-	 		&& pd->bio_queue_size <=3D pd->write_congestion_off);
+	 * below, wake up any waiters
+	 */
+	if (pd->congested &&
+	    pd->bio_queue_size <=3D pd->write_congestion_off) {
+		pd->congested =3D false;
+		wake_up_var(&pd->congested);
+	}
 	spin_unlock(&pd->lock);
-	if (wakeup)
-		clear_bdi_congested(pd->disk->bdi, BLK_RW_ASYNC);
=20
 	pkt->sleep_time =3D max(PACKET_WAIT_TIME, 1);
 	pkt_set_state(pkt, PACKET_WAITING_STATE);
@@ -2356,7 +2357,7 @@ static void pkt_make_request_write(struct request_queue=
 *q, struct bio *bio)
 	}
 	spin_unlock(&pd->cdrw.active_list_lock);
=20
- 	/*
+	/*
 	 * Test if there is enough room left in the bio work queue
 	 * (queue size >=3D congestion on mark).
 	 * If not, wait till the work queue size is below the congestion off mark.
@@ -2364,12 +2365,20 @@ static void pkt_make_request_write(struct request_que=
ue *q, struct bio *bio)
 	spin_lock(&pd->lock);
 	if (pd->write_congestion_on > 0
 	    && pd->bio_queue_size >=3D pd->write_congestion_on) {
-		set_bdi_congested(bio->bi_bdev->bd_disk->bdi, BLK_RW_ASYNC);
-		do {
+		struct wait_bit_queue_entry wqe;
+
+		init_wait_var_entry(&wqe, &pd->congested, 0);
+		for (;;) {
+			prepare_to_wait_event(__var_waitqueue(&pd->congested),
+					      &wqe.wq_entry,
+					      TASK_UNINTERRUPTIBLE);
+			if (pd->bio_queue_size <=3D pd->write_congestion_off)
+				break;
+			pd->congested =3D true;
 			spin_unlock(&pd->lock);
-			congestion_wait(BLK_RW_ASYNC, HZ);
+			schedule();
 			spin_lock(&pd->lock);
-		} while(pd->bio_queue_size > pd->write_congestion_off);
+		}
 	}
 	spin_unlock(&pd->lock);
=20
diff --git a/include/linux/pktcdvd.h b/include/linux/pktcdvd.h
index 174601554b06..c391e694aa26 100644
--- a/include/linux/pktcdvd.h
+++ b/include/linux/pktcdvd.h
@@ -183,6 +183,8 @@ struct pktcdvd_device
 	spinlock_t		lock;		/* Serialize access to bio_queue */
 	struct rb_root		bio_queue;	/* Work queue of bios we need to handle */
 	int			bio_queue_size;	/* Number of nodes in bio_queue */
+	bool			congested;	/* Someone is waiting for bio_queue_size
+						 * to drop. */
 	sector_t		current_sector;	/* Keep track of where the elevator is */
 	atomic_t		scan_queue;	/* Set to non-zero when pkt_handle_queue */
 						/* needs to be run. */
--=20
2.34.1

