Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0453C433EF
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D23A361BF9
	for <linux-block@archiver.kernel.org>; Wed, 17 Nov 2021 04:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbhKQEdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 23:33:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49818 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhKQEdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 23:33:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D98381FD29;
        Wed, 17 Nov 2021 04:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637123407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eGF11BGFSAGZYVsbJYxkr31YhQ8zybs+KJhq1akHudM=;
        b=erxD1ofx5IfWY63iX5pTrnu1LrLE+SnFq3DtKnwiIjGTBaxus7jxH3asXLBtxrF9tVHI8j
        eMX2zAEGD3kf64c67sDmOF7DzXYkbbE42XAnrz0WoR0HdaaH/34ueJvh5lqzRyRRCG9pDD
        rDrq489JEot2aIgFzpHe268uuTa8G1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637123407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eGF11BGFSAGZYVsbJYxkr31YhQ8zybs+KJhq1akHudM=;
        b=yu4yYPixyP/B8Lz/qtFA71ymauLFFeZF9mpCOUvXwRmOFUGrHUaHimuve/DQQBa9O8IQf4
        9q70hGX4/cQiSqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15D8713BC3;
        Wed, 17 Nov 2021 04:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jkKfMU6FlGEpGAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 17 Nov 2021 04:30:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] pktdvd: stop using bdi congestion framework.
Date:   Wed, 17 Nov 2021 15:30:03 +1100
Message-id: <163712340344.13692.2840899631949534137@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


The bdi congestion framework isn't widely used and should be
deprecated.

pktdvd makes use of it to track congestion, but this can be done
entirely internally to pktdvd, so it doesn't need to use the framework.

So introduce a "congested" flag.  When waiting for bio_queue_size to
drop, set this flag and use wait_var_event() to wait for it.
When bio_queue_size does drop and this flag is set, clear the flag
and call wake_up_var().

Signed-off-by: NeilBrown <neilb@suse.de>
---

Note that I haven't testing this - just confirmed that it compiles.

 drivers/block/pktcdvd.c | 30 +++++++++++++++++-------------
 include/linux/pktcdvd.h |  2 ++
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index b53f648302c1..bf4135e52bf1 100644
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
@@ -2364,12 +2365,15 @@ static void pkt_make_request_write(struct request_que=
ue *q, struct bio *bio)
 	spin_lock(&pd->lock);
 	if (pd->write_congestion_on > 0
 	    && pd->bio_queue_size >=3D pd->write_congestion_on) {
-		set_bdi_congested(bio->bi_bdev->bd_disk->bdi, BLK_RW_ASYNC);
-		do {
-			spin_unlock(&pd->lock);
-			congestion_wait(BLK_RW_ASYNC, HZ);
-			spin_lock(&pd->lock);
-		} while(pd->bio_queue_size > pd->write_congestion_off);
+		___wait_var_event(&pd->congested,
+				  pd->bio_queue_size <=3D pd->write_congestion_off,
+				  TASK_UNINTERRUPTIBLE, 0, 0,
+				  ({pd->congested =3D true;
+				    spin_unlock(&pd->lock);
+				    schedule();
+				    spin_lock(&pd->lock);
+				  })
+		);
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
2.33.1

