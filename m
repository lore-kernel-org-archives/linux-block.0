Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7886347F79
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217855; cv=none; b=E5xa0TpLcbeE6IVBwy247QUlNoUQoJ1cf2IjWq09c2QZ55L/eidvacqYx16Yzle3qrR4kvko6xCGnafEJQ7OA/SRGTtB5kl/sQmD8tmecfleOnE8RR7wlwhEkpMs5pCc+6z6lG89mFwtDmEdsy5nNxmnWUMJT8ETg/PnxtPVWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217855; c=relaxed/simple;
	bh=9luKb4/tPYsi49e8Ll4145zV6aiGGGMphz4lqqMO7o4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D95KOVVelFXT1zUWqgRLX2eYSq99z6Dd26+WbxbO2l69v7En2MRKkqMXiFp7h4KsfwtJim2bgF1EjcCH5yzJ1/LsPJ4Y57b9T1Z5MzH92W6XqFc9tgVPd42dczktcvTx/ybInub0LCybDXnhLiXxlwEXtTWa7SgcBetZbryQfVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bgJKvqUZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgJKvqUZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DbLq2r/oB+9JHIZd9FVYK/Mgl2bYNa2mqgPKnMKvHEk=; b=bgJKvqUZDSPq6HN6EeDobxYFP5
	Fs36gYvc/tzLdGgtCTU/6zEUvAMfrsmeB/0tj9x9/YkSIGnqQLOZiOOrl3ZCu4eBPhlfiJ8wR64dY
	BMufxkN9FbEaleAweF2P0vuKbVWXZs+iNW1Tf5Uq0h2wKDyrZa+xPu2bcC3mHU1wGFrLncoQwo2qs
	/BDJlXPOyxrCNZc9T4Hh3cG/nB68UMpeWDWvqxl/I/GZ9AjuMbb8SHRuexic4Ng+MJKErtAH1KLk7
	yBxgO9KYXibTk+Cu3zOMiu1Tvd64/CH/7YJOoTC/SQR+dIqSXPh9+0BFPuBTt4y21r/qQ+9nQoPxM
	ID780XKA==;
Received: from [216.9.110.7] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfhds-0000000Duu9-3yoR;
	Thu, 29 Feb 2024 14:44:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: pali@kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] pktcdvd: don't set max_hw_sectors on the underlying device
Date: Thu, 29 Feb 2024 06:44:08 -0800
Message-Id: <20240229144408.1047967-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

pktcdvd sets max_hw_sectors on the queue of the underlying device that
it doesn't own (and doesn't reset it ever) since the driver was merged.
This can create all kinds of problems as the underlying driver doesn't
even know about it changing the limit.

As the state purpose is to not create I/Os larger than a single frame,
and pktcdvd never builds bios larger than that, just set REQ_NOMERGE
on the bios it submits so that largers I/Os never get built.

Note: I don't have packet writing hardware, so this is compile tested
only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/pktcdvd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 12fcc881b04f54..9071c4ebc1b901 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -828,6 +828,12 @@ static noinline_for_stack int pkt_set_speed(struct pktcdvd_device *pd,
  */
 static void pkt_queue_bio(struct pktcdvd_device *pd, struct bio *bio)
 {
+	/*
+	 * Some CDRW drives can not handle writes larger than one packet,
+	 * even if the size is a multiple of the packet size.
+	 */
+	bio->bi_opf |= REQ_NOMERGE;
+
 	spin_lock(&pd->iosched.lock);
 	if (bio_data_dir(bio) == READ)
 		bio_list_add(&pd->iosched.read_queue, bio);
@@ -2191,11 +2197,6 @@ static int pkt_open_dev(struct pktcdvd_device *pd, bool write)
 		ret = pkt_open_write(pd);
 		if (ret)
 			goto out_putdev;
-		/*
-		 * Some CDRW drives can not handle writes larger than one packet,
-		 * even if the size is a multiple of the packet size.
-		 */
-		blk_queue_max_hw_sectors(q, pd->settings.size);
 		set_bit(PACKET_WRITABLE, &pd->flags);
 	} else {
 		pkt_set_speed(pd, MAX_SPEED, MAX_SPEED);
-- 
2.39.2

