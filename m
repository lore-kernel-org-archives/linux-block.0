Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7631F2395
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469432; cv=none; b=frZ3gLvyMDF0mjgUVnRVsd5kd7lI7KBW9l2ycN78ZRFaDR9zfiD5vvaFqVFQaUn8CdqnNctpFk/7Jg9nluiH2Oj0ca3I9zhi/2fc8MDOLh8kW0IFUDmf36pURxaM/dN2y4F9oVq1A79ORd13XgnHW9mmdiokDcphIkHQ0Q1w1qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469432; c=relaxed/simple;
	bh=djPMCH+oULT72tbh1LSngF8eVCrDX/VPC8ayX3TD+TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDhWtLcS2c/H4r96UWVIahR6umhP1x/1M70KOBp2Zb7WfcuOj+XWHJcbHfw65ARYwnhnL7y1c0x6lz6s/cD34P3sS5gOIIXKt6uBmr96nKNtJtZj83YosZvx2N5kR1reGExOieUKK1W8FrOw2RyhvvBwH1XGFU0tIMYpVl8GOEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XGbg6lhM; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XGbg6lhM"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTnL1KcHzlff0H;
	Tue, 17 Dec 2024 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734469427; x=1737061428; bh=IBZ7s
	5zPdP/QT6Oqx+UuKyMEnWDh3S2vG5NKG/Zejp4=; b=XGbg6lhM54wszEDpVIam3
	hSskmuyaIXzxvs9HHN2CdK+Qv82nvEV2LlhO+XOEnDc86ty0DvATolHifjyZ9oUr
	zZTe5su3vtI/VvEiG/QOsimsqWY1xIdy9OrfcqJjXmBv67Bp+9Lw4Bsp0Xal2R1m
	teb1O6m8zX5+tLWIp2C1qD4UM/3eCaVGibV/w7NrQDf0HLZCVoC76TrLyUcGocMy
	4gbmz7rnMENOfDsBBPINvb+vGKnzDo/pEm5cmTVeKgYlZWhhbwRfmwZpPM/twUDf
	2gmptObW+HYwwj0XemKvsvCbTL8OM+BJusNZXFM3hiuwLmad16tlpXSJxGgwLAyK
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hqrNUJangEYV; Tue, 17 Dec 2024 21:03:47 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTnF461jzlgd70;
	Tue, 17 Dec 2024 21:03:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 4/4] blk-zoned: Split queue_zone_wplugs_show()
Date: Tue, 17 Dec 2024 13:03:10 -0800
Message-ID: <20241217210310.645966-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217210310.645966-1-bvanassche@acm.org>
References: <20241217210310.645966-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reduce the indentation level of the code in queue_zone_wplugs_show() by
moving the body of the loop in that function into a new function.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7876a6458022..4b0be40a8ea7 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1774,37 +1774,41 @@ int blk_zone_issue_zeroout(struct block_device *b=
dev, sector_t sector,
 EXPORT_SYMBOL_GPL(blk_zone_issue_zeroout);
=20
 #ifdef CONFIG_BLK_DEBUG_FS
+static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
+				  struct seq_file *m)
+{
+	unsigned int zwp_wp_offset, zwp_flags;
+	unsigned int zwp_zone_no, zwp_ref;
+	unsigned int zwp_bio_list_size;
+	unsigned long flags;
+
+	spin_lock_irqsave(&zwplug->lock, flags);
+	zwp_zone_no =3D zwplug->zone_no;
+	zwp_flags =3D zwplug->flags;
+	zwp_ref =3D refcount_read(&zwplug->ref);
+	zwp_wp_offset =3D zwplug->wp_offset;
+	zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
+	spin_unlock_irqrestore(&zwplug->lock, flags);
+
+	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
+		   zwp_wp_offset, zwp_bio_list_size);
+}
=20
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q =3D data;
 	struct gendisk *disk =3D q->disk;
 	struct blk_zone_wplug *zwplug;
-	unsigned int zwp_wp_offset, zwp_flags;
-	unsigned int zwp_zone_no, zwp_ref;
-	unsigned int zwp_bio_list_size, i;
-	unsigned long flags;
+	unsigned int i;
=20
 	if (!disk->zone_wplugs_hash)
 		return 0;
=20
 	rcu_read_lock();
-	for (i =3D 0; i < disk_zone_wplugs_hash_size(disk); i++) {
-		hlist_for_each_entry_rcu(zwplug,
-					 &disk->zone_wplugs_hash[i], node) {
-			spin_lock_irqsave(&zwplug->lock, flags);
-			zwp_zone_no =3D zwplug->zone_no;
-			zwp_flags =3D zwplug->flags;
-			zwp_ref =3D refcount_read(&zwplug->ref);
-			zwp_wp_offset =3D zwplug->wp_offset;
-			zwp_bio_list_size =3D bio_list_size(&zwplug->bio_list);
-			spin_unlock_irqrestore(&zwplug->lock, flags);
-
-			seq_printf(m, "%u 0x%x %u %u %u\n",
-				   zwp_zone_no, zwp_flags, zwp_ref,
-				   zwp_wp_offset, zwp_bio_list_size);
-		}
-	}
+	for (i =3D 0; i < disk_zone_wplugs_hash_size(disk); i++)
+		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
+					 node)
+			queue_zone_wplug_show(zwplug, m);
 	rcu_read_unlock();
=20
 	return 0;
