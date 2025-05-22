Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3D0175D5D;
	Thu, 22 May 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934092; cv=none; b=KLHcBoAkUnIh1XRaTdAkLZaQDFpHbRYD6r/eroB8pi3X3Aak4Bhem1nAMDA744SvPlvIDnTN4O47Kg/L4GP1Peggs1ng4QkfeqJUzsUYs76ACSSNcQsr6vce5sB4bD8iIB5E0ukNRt/kfuz0yXa6Bm/OnOLJWVl7sWrRe5l6YTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934092; c=relaxed/simple;
	bh=GBF68IOP9NjaPwpGli8++09h9CZcVdNSfSygHbD9iSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=adPr5L9J9u0PPAYoF5yDp74jrJk7N9+D+CI041I71zYl7iYOhk+wopB5uobiof3mAGKvKp377Tj7Jtnqo/0Xg+CjSOXQ4PnyXMoFrZvt0gfmmXmxNRyQvsnhALqvI+UBMssS2pus7joXXthjnaXr80NsszVex05yGSoQ8NEo6tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RgZDnLKH; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RgZDnLKH"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b3FK03jgLzlrnS1;
	Thu, 22 May 2025 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1747934082; x=1750526083; bh=c2rWDY+jd2ieNF5lMp8q7CN2MyaJ+mWTG9G
	Mt4+wcno=; b=RgZDnLKHC8W1ReUrfNJS+YEA1Gp1DjLQ8LT2uIgBna+wKTLgRrE
	46VBf0hsQXNTIZXNdDEmG7HVzpVkgIgiDKz9WxxB9P9qPJbobKwhSixfcLOCDf/z
	hBEXtDAOqLXnXWcm77pRAN0JttyhT+ncc6UJufbLy7hoC5Q7nPCLap+kA72macMT
	O7jlBYnuwCR0KkdR962HSLbk8wFCfTTz2q261OnU4c5RWoBsCV90koz1sgnZlgqi
	9aTG4EbA/O+flhIDHV9isuWKlI7uqjAWVk0RnCq2uCguJJ87X+rwEMGkLZSYZ9SH
	4+FQfsqmZ90xkWuyZyVX96WlaUjMn9TU1iw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GLXbSam6zfhz; Thu, 22 May 2025 17:14:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b3FJs3YXyzlvt1l;
	Thu, 22 May 2025 17:14:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: Fix a deadlock related freezing zoned storage devices
Date: Thu, 22 May 2025 10:14:05 -0700
Message-ID: <20250522171405.3239141-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
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

Changes compared to v1: fixed a race condition. Call bio_zone_write_plugg=
ing()
  only before submitting the bio and not after it has been submitted.

 block/blk-core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b862c66018f2..713fb3865260 100644
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
@@ -633,8 +640,12 @@ static void __submit_bio(struct bio *bio)
=20
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
-	} else if (likely(bio_queue_enter(bio) =3D=3D 0)) {
+	} else {
 		struct gendisk *disk =3D bio->bi_bdev->bd_disk;
+		bool zwp =3D bio_zone_write_plugging(bio);
+
+		if (unlikely(!zwp && bio_queue_enter(bio) !=3D 0))
+			goto finish_plug;
 =09
 		if ((bio->bi_opf & REQ_POLLED) &&
 		    !(disk->queue->limits.features & BLK_FEAT_POLL)) {
@@ -643,9 +654,12 @@ static void __submit_bio(struct bio *bio)
 		} else {
 			disk->fops->submit_bio(bio);
 		}
-		blk_queue_exit(disk->queue);
+
+		if (!zwp)
+			blk_queue_exit(disk->queue);
 	}
=20
+finish_plug:
 	blk_finish_plug(&plug);
 }
=20
