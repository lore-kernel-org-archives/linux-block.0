Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C61DDA21
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 21:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734382999; cv=none; b=CDPZ9gnblUJ56R2C8PtHA7S2Dzlb+v77QAceUCI3GQLcwwJZXgH2vDzcRyz0hVAMC3dNud9kwy+LcrSXt/Ty51DwSOskwMGqHswCIh1ZQCXHdwjJ+lJ9ro+Zn3EZEohc8tXQS44iBPSj67s39bR0o3CPsB/HnHpJWfvK1sRzSQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734382999; c=relaxed/simple;
	bh=2Ph+ckJX+fc1IBb1oVC5HTjexIIyiGqPDJLEQYLnNQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3amTPdalg444uM5FI/EIYZlMrFsyC7QZLC+fS0M8orOmUDbxSXwsJMfg0puenC4nv7O5eQMDZEk4XuZnlQJludAKCn0/AViw0xB9EHSQxTRMUWSsLDWwzTc1J1C5sHl1FAnpROFqXlFO85Kv3926eir4os74kcXMIeTnVF/eiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rxB5/mZK; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rxB5/mZK"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YBsq940rjz6ClL9C;
	Mon, 16 Dec 2024 21:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734382994; x=1736974995; bh=tHGUS
	8kHZ5mZzZyaiXIx6o9AVK4Y4JY2Qq/yPY+00Kc=; b=rxB5/mZKUpYZgAk/vj3xG
	D6Yyy9scocWhWdoW0cOj1ANowbufEZWPwEIldy8z/1KLRt5M+ofO4Hm+l7IxuWBA
	hd9km+jQlMgjCck2jwzdrJd+dfQkkblXwnHBcXq+pVRN4xZhJUacpjA+r2mD/036
	w4Dr2yTJzx0ZppPdd6z2i1GS42f4X63bXVFbMk81V/2DW/1IO2QBua7lRVFSx61E
	TqJ4dAVzyWwyc3/Fq9AV51mSSmeB0el2T9XUn1N4lYibUiAy2i6BfluwmCFO+Mzu
	zvCXQxJm3ZMAbl+RrDLVFoUcesNdDVPXhwH6/LliPVlctZeiWaRNK4bgSb4gWgGP
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gc-Cxix3DxGo; Mon, 16 Dec 2024 21:03:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YBsq45HbSz6ClL93;
	Mon, 16 Dec 2024 21:03:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 3/6] blk-zoned: Document locking assumptions
Date: Mon, 16 Dec 2024 13:02:41 -0800
Message-ID: <20241216210244.2687662-4-bvanassche@acm.org>
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

Document which functions expect that their callers must hold a lock.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3e42372fa832..ca44b2d6727c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -460,6 +460,8 @@ static inline void disk_put_zone_wplug(struct blk_zon=
e_wplug *zwplug)
 static inline bool disk_should_remove_zone_wplug(struct gendisk *disk,
 						 struct blk_zone_wplug *zwplug)
 {
+	lockdep_assert_held(&zwplug->lock);
+
 	/* If the zone write plug was already removed, we are done. */
 	if (zwplug->flags & BLK_ZONE_WPLUG_UNHASHED)
 		return false;
@@ -914,6 +916,8 @@ static bool blk_zone_wplug_prepare_bio(struct blk_zon=
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
