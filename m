Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDED1DFDE;
	Wed, 14 May 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254625; cv=none; b=CmswBwXOl6EsybR0Dapl3VqlZNqupllOz7kbqzuJAFRCWwpTRd1k0HZnkgdtM/nUVkhSEFr15USmdVbdxs+4XV7L9YnWwHxlzigx4Q9Lwltwb8O7YCmvwrAEmJSQF2l6LqxQKSuhyu9idjRed2RliNlpegY6dVyjVSfFTD63jlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254625; c=relaxed/simple;
	bh=SqVJvVx0DDE+TEeB25XEH20eWB2Lv7mPZ5OF4yizEAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/kzNitjPRTMAunlXMGVP9gX9mYXbyO51E3ImNYJvZf8k62dcxdxUYR9O92Bx9TnfuGLxKz8qAM80IeTDXaU0o8k3iNjhJzpREJoIxXO2ToKfhU8R9k4MtSIwdPRrdt0h09HI9CJ5Xt8u6hebErJtcmg6Obl+wECIYsN9ovWxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=AsEGBReO; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="AsEGBReO"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZyQ2Q5zFkzlvfnC;
	Wed, 14 May 2025 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1747254621; x=1749846622; bh=QVO8h
	rgc8dnIG0hh1VR7Z6C7IkKPAgXncs3zfs7O7Dc=; b=AsEGBReO25f0VJAWUqTX3
	NLYGVkyPELSBe2Zi1hVpBgNtcf1QI6wDt/IDhh+NJ03N317cna4u3BR0a68NJl4L
	/lEZYI63a350Uie9S18zLL8SEn09fbLSmDC+mwNwiHuyczskCH9jpjbyNK8Lo0dr
	a9atxi6NE3CyX5uZ2F+cyDEbBZuRE3uuWzEveIEXFwqiO0zjAHsdea9dW1BI1Rtv
	1OTaZFYnM/Wj5ph9mvlK2ipTDYgZ7v4QP4C4+hsjZbAjRke+zsgnyIZoWPfI3PSL
	XmIB49aPQszqdp7cG0PjURJXJv6GjFzjGpb40gS9AOy3YDSTZ3O1XGQVxySbzbo4
	g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tBMOljth_dPu; Wed, 14 May 2025 20:30:21 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZyQ2H2kWbzlrnRx;
	Wed, 14 May 2025 20:30:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] block: Fix a deadlock related freezing zoned storage devices
Date: Wed, 14 May 2025 13:29:37 -0700
Message-ID: <20250514202937.2058598-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250514202937.2058598-1-bvanassche@acm.org>
References: <20250514202937.2058598-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

blk_mq_freeze_queue() never terminates if one or more bios are on the plu=
g
list and if the block device driver defines a .submit_bio() method.
This is the case for device mapper drivers. The deadlock happens because
blk_mq_freeze_queue() waits for q_usage_counter to drop to zero, because
a queue reference is held by bios on the plug list and because the
__bio_queue_enter() call in __submit_bio() waits for the queue to be
unfrozen.

This patch fixes the following deadlock:

Workqueue: dm-51_zwplugs blk_zone_wplug_bio_work
Call trace:
 __schedule+0xb08/0x1160
 schedule+0x48/0xc8
 __bio_queue_enter+0xcc/0x1d0
 __submit_bio+0x100/0x1b0
 submit_bio_noacct_nocheck+0x230/0x49c
 blk_zone_wplug_bio_work+0x168/0x250
 process_one_work+0x26c/0x65c
 worker_thread+0x33c/0x498
 kthread+0x110/0x134
 ret_from_fork+0x10/0x20

Call trace:
 __switch_to+0x230/0x410
 __schedule+0xb08/0x1160
 schedule+0x48/0xc8
 blk_mq_freeze_queue_wait+0x78/0xb8
 blk_mq_freeze_queue+0x90/0xa4
 queue_attr_store+0x7c/0xf0
 sysfs_kf_write+0x98/0xc8
 kernfs_fop_write_iter+0x12c/0x1d4
 vfs_write+0x340/0x3ac
 ksys_write+0x78/0xe8

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: stable@vger.kernel.org
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4b728fa1c138..e961896a8717 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -621,6 +621,13 @@ static inline blk_status_t blk_check_zone_append(str=
uct request_queue *q,
 	return BLK_STS_OK;
 }
=20
+/*
+ * Do not call bio_queue_enter() if the BIO_ZONE_WRITE_PLUGGING flag has=
 been
+ * set because this causes blk_mq_freeze_queue() to deadlock if
+ * blk_zone_wplug_bio_work() submits a bio. Calling bio_queue_enter() fo=
r bios
+ * on the plug list is not necessary since a q_usage_counter reference i=
s held
+ * while a bio is on the plug list.
+ */
 static void __submit_bio(struct bio *bio)
 {
 	/* If plug is not used, add new plug here to cache nsecs time. */
@@ -633,7 +640,8 @@ static void __submit_bio(struct bio *bio)
=20
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
-	} else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
+	} else if (likely(bio_zone_write_plugging(bio) ||
+			  bio_queue_enter(bio) =3D=3D 0)) {
 		struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 =09
 		if ((bio->bi_opf & REQ_POLLED) &&
@@ -643,7 +651,8 @@ static void __submit_bio(struct bio *bio)
 		} else {
 			disk->fops->submit_bio(bio);
 		}
-		blk_queue_exit(disk->queue);
+		if (!bio_zone_write_plugging(bio))
+			blk_queue_exit(disk->queue);
 	}
=20
 	blk_finish_plug(&plug);
