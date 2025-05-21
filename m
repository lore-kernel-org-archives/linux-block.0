Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7534C8E
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786022; cv=none; b=bc9fHZn9506Z3q7EmDACKOvVGdHfNPFd6k4xmMCydTnhuJNJTvf8cPnfjouea8AcPuc4PUyNAA09PBnf2s4FZuJKHj3ktCRDCyq7CqsWIEEl4ArTEupIprv5iclc4umJw6+sf8kwImo8tHl/694VGZ1AYa9Aph+W2xNkkn2tBS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786022; c=relaxed/simple;
	bh=TCcSXnvgiuyl2jdNHfE+8F8JCpXHz7hS/peZyp1kqj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loy7qWii3sFD3s/GN68ZzejND2v+ZxfZPKWr4siZahkHP4j9qY3vN66VxwpgkXnIxjRujOHevU6B4JkCqZfjmYDRY9Jg1pcKxL80EmZc0wlI/Xr1V0r69Xap+Y0vRE67QrBc3AEUN3sujXIGipQhPZtVoCduzGfTcvtkkUjszjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YqzZiPI5; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YqzZiPI5"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b2BYZ52hHzlvqlQ;
	Wed, 21 May 2025 00:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1747786017; x=1750378018; bh=Ce7r9
	ECHXiofgwsXhUlKe1tbRYHnZYv6oPm86coYuzU=; b=YqzZiPI5iVFfDgiVNrMyI
	KUcSnyzaYzEnMSwCuL+8vvpi9BRivRa2ModgoPSBQ5Z+rGdIMUCYTxl0H0MqoTYO
	BTKeduyjOuSo5JNQqmXdbBYGNYqZvWxB76LoK6s9otQlGT/yCBY/IOzd4uGGWNAd
	ZPcxjnUhqP75ksfm8Nv3MZ3Ccuu/yHQBkL1X1TXs+BrLtye9AoUpeFuay3XDqye5
	9mIYYL24Dy7HSZWOO+vss3z0RqEJt3I3b1+JTRWyO1VYNwmhpt7wOEryPAnugJx3
	ZIrh5lpo8dYt/NbuXl3R2Dwdgj4HEwkUU7eiW4jf84mXgnjIyAcsfL8aksfXwe01
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z39s7mAb_RwQ; Wed, 21 May 2025 00:06:57 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b2BYT6bZQzlvm70;
	Wed, 21 May 2025 00:06:53 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] blk-zoned: Move locking into disk_zone_wplug_abort()
Date: Tue, 20 May 2025 17:06:25 -0700
Message-ID: <20250521000626.1314859-3-bvanassche@acm.org>
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

Instead of holding zwplug->lock around disk_zone_wplug_abort() calls, mak=
e
disk_zone_wplug_abort() obtain zwplug->lock. Prepare for reducing the amo=
unt
of code protected by zwplug->lock. No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 75b01068b877..ce5604c92fea 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -607,13 +607,20 @@ static void disk_zone_wplug_abort(struct blk_zone_w=
plug *zwplug)
 {
 	struct bio *bio;
=20
-	if (bio_list_empty(&zwplug->bio_list))
-		return;
+	scoped_guard(spinlock_irqsave, &zwplug->lock)
+		if (bio_list_empty(&zwplug->bio_list))
+			return;
=20
 	pr_warn_ratelimited("%s: zone %u: Aborting plugged BIOs\n",
 			    zwplug->disk->disk_name, zwplug->zone_no);
-	while ((bio =3D bio_list_pop(&zwplug->bio_list)))
-		blk_zone_wplug_bio_io_error(zwplug, bio);
+	for (;;) {
+		scoped_guard(spinlock_irqsave, &zwplug->lock) {
+			bio =3D bio_list_pop(&zwplug->bio_list);
+			if (!bio)
+				break;
+			blk_zone_wplug_bio_io_error(zwplug, bio);
+		}
+	}
 }
=20
 /*
@@ -635,9 +642,10 @@ static void disk_zone_wplug_set_wp_offset(struct gen=
disk *disk,
 		/* Update the zone write pointer and abort all plugged BIOs. */
 		zwplug->flags &=3D ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
 		zwplug->wp_offset =3D wp_offset;
-		disk_zone_wplug_abort(zwplug);
 	}
=20
+	disk_zone_wplug_abort(zwplug);
+
 	/*
 	 * The zone write plug now has no BIO plugged: remove it from the
 	 * hash table so that it cannot be seen. The plug will be freed
@@ -1086,7 +1094,9 @@ static void blk_zone_wplug_handle_native_zone_appen=
d(struct bio *bio)
 	if (!bio_list_empty(&zwplug->bio_list)) {
 		pr_warn_ratelimited("%s: zone %u: Invalid mix of zone append and regul=
ar writes\n",
 				    disk->disk_name, zwplug->zone_no);
+		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_zone_wplug_abort(zwplug);
+		spin_lock_irqsave(&zwplug->lock, flags);
 	}
 	disk_remove_zone_wplug(disk, zwplug);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
