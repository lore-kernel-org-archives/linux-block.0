Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA791F63CF
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734383009; cv=none; b=frnJhnH/mHBmKikpguLsWvh2e4Fs4SgmOre8+3D7tC8O9sZOHOTXENvW5ct5BncH3OZbjhkoqhXDZJH94+d5aEViN3EilLzzdz69S6iPqxDt4y7XXoFy36M6aAoLf7EsQ2ki4iRqsPSqeG7W5UVqID94vy1AbdxC+8NT7DxkNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734383009; c=relaxed/simple;
	bh=1vQduErAgDe6IEAGwdVO7lU1DJvAIpoGcCI/MpLKfeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adtwBPm91mce+Bm0zZYH2pFgjJ30A88beFO3Pga85EoDU79gLQ96oJYd8Bn7iodzfINTxQ7N7ZRVtOICnIuwSUN9ymO1kI39EyRAm+l8ifHAmLEVUNKc4pRpcC4fGPL9rZ2U0pB/MHY4sTOOcQ6roDJDoI1JtJoGCn5Pa/6EbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DiYad5vN; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DiYad5vN"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsqK4NPqz6ClL93;
	Mon, 16 Dec 2024 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734383002; x=1736975003; bh=pMaIv
	TXyz2kjxfcqw1nCs7Jsla/POgbqpj2J3wxOBHE=; b=DiYad5vNbYxd3W1aAj3AY
	k7l7OgR19XdUAZVrsgNljpbECatEUB2FER2UV6yUZfzEm/oyDQKAVEoEO5xdwK36
	Kf/D2hAUA956Z6QxDrG8Wl6hTulRLkhn0V6drzMCLMTacD8KbiBUJifdhH19arBB
	G1o0JuIZ6Y35ywt67Gi2fLTFKPzuf0Zge+pZBwtCZ1gA8bgLqb30MwggkgSInWAK
	Gvmo78kcTlOl9jfD8Jt9d5+lHuXOhHDVme3YJ1eZE/hqrHjUE18ziZ4R8E5K9+d+
	A9bRXpH6lUdsOzDd4Zc42MLgPmuNyuLtphWzvJkkCyGDNLrneJjH0uURHNHhIXz5
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 41cF3vFBZHRk; Mon, 16 Dec 2024 21:03:22 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsqD1tRpz6ClL92;
	Mon, 16 Dec 2024 21:03:19 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6/6] blk-zoned: Split queue_zone_wplugs_show()
Date: Mon, 16 Dec 2024 13:02:44 -0800
Message-ID: <20241216210244.2687662-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216210244.2687662-1-bvanassche@acm.org>
References: <20241216210244.2687662-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Reduce the indentation level of the code in queue_zone_wplugs_show() by
moving the body of the loop in that function into a new function.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 046903fc6030..775ad7016659 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1775,37 +1775,41 @@ int blk_zone_issue_zeroout(struct block_device *b=
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
