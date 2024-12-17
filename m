Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67F1F9EA1
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469427; cv=none; b=fYJuCDGL7r6MnErxdl02kE5+fnSORCMf94Z3sSLUSbdDDJC89dfNWnoC+7HlV7i08atap27Q/Vsw0HOdM7JnqpMmo4gGCjLyFcTWmaKsKaA9JkxkBxH/Eu0TOxPHqrpjFuucVpjaHNuzO8iib6icwewREsBX9IHIz7SW3UehxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469427; c=relaxed/simple;
	bh=sTayVdxLAbxgn0NmFyaOeA70Tcd2ToblYi/CduPewTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozoDy3mQEyQ7kLY2aCTz7ZpjT6GfoESqDACAF6wy0VZ975gKLBpr7cqylzgIxP3QJtk2aNRupLh5Tm9lmYkge9bUfpIWXHLTaWQdwVeQvXgAK4xTam8L8OHRz1RZyoqNmMQNDmEzCW6E+28tuSzAv714IXW15wJLpSvygiT99Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=pa/FmH7p; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="pa/FmH7p"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCTnF19dtzlff0S;
	Tue, 17 Dec 2024 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734469422; x=1737061423; bh=zNdUO
	ZJ5W1ph3lRZzM6Hvq55+6hVqNbBrqFuHqEsgm0=; b=pa/FmH7pm1d2YrrrdIRlA
	Rkv4jLe1SOuObECEfexjAjnB3FpcB2CmeUslsg7lk4PRgl81to0RZbMuBNO3dJ0o
	8kY1jS1ypRglbsljKy6yplxeVYB40C/rkqS1aX9Wafyf2vXPPuLSU0auSfdwUHic
	Ig3I2+ztc+6k/YMqpMEmWxqI3iJ3gBG8KPoSpLimeUM86tjirald1yCwP+iPkqK1
	Jtw/gtSLl27TjIuFSh4wiax/dbx4qObj6DG2+zvP9QcldD1Fl6u73g9e0oCVNQLz
	JmVfpHzblgaqttIk83m7M08WYOe4vRDV8+ghUE8BMmo/EXsY6Wn7qdz4iYJS93lq
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p-z725pHn53B; Tue, 17 Dec 2024 21:03:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCTn90NFdzlgd70;
	Tue, 17 Dec 2024 21:03:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/4] blk-zoned: Document locking assumptions
Date: Tue, 17 Dec 2024 13:03:08 -0800
Message-ID: <20241217210310.645966-3-bvanassche@acm.org>
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

Document which functions expect that their callers must hold a lock.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1575b887fa38..954724a2e3c6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -459,6 +459,8 @@ static inline void disk_put_zone_wplug(struct blk_zon=
e_wplug *zwplug)
 static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
 						 struct blk_zone_wplug *zwplug)
 {
+	lockdep_assert_held(&zwplug->lock);
+
 	/* If the zone write plug was already removed, we are done. */
 	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
 		return false;
@@ -913,6 +915,8 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zon=
e_wplug *zwplug,
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
=20
+	lockdep_assert_held(&zwplug->lock);
+
 	/*
 	 * If we lost track of the zone write pointer due to a write error,
 	 * the user must either execute a report zones, reset the zone or finis=
h
