Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396A13C8F9
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821706; cv=none; b=XXI4H2HYhIiq+D88H4oW54j7lajQFj3pyRdaKsoHHeD4eR0IoLpO/U1J/rqEuTtjgILzsNCCVyz5bC3b3mS28iHSCR/iXg54GijJWCqtfjgDcuIqmK/ObYpMu7zMJT3ynjuEBD9spwJgIjOb735rJRolk5ryBh1IdWT18R9VLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821706; c=relaxed/simple;
	bh=rPc+cvlWcIsx7IlXjAhsYkQN6vnU2WUNjiM5ZD6TJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzXh7Ibv2VobJXPtWGfZNrVDCWxF7XTW3QU0qKk1GIqewwT0wr77eLmnjw+yWYIKz5X+iv2qmCLb+y6ejd0TOlxhLKvQ7K3siFvgvj+HI9O+m2RIDdEia1GnN+7XUIQ/ffTuVtXnBf6i2SCqaLiT6j3ufnegLVlPR8pknwpKr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DNaS1l9i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNaS1l9i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c4Xt+KF6M3NsNW/Vd0vXkfHzIET7y4QZarV6dRACmNI=; b=DNaS1l9iIax11e/14VvJah3h0d
	hU6FZGwjCwTYvwRiTk62/z5/cN3JICU1rGaEjqkXm3KAFflmenyDIhjZRVO8tstjIfY8edOqNbXOK
	vUF/KbVh6ZH2w+DhUTyJvJsbdO4aIaQ9+mGb7UFN2KsCL73zVJVFySoQoEinPnlDnizvud/x5Dheg
	kVeaAE6kr/vYJUH2VwFvZ0HvySSA4czCKeEDfuejj8mYF/lpSORPLxwJWZ4jC4wswo7grHlzolMu5
	ClNVXygQfTDHJvjAtWFWALYMubb2TZG+ZDYJZMrIzNaShhayvmo0iBW2QuLGd+gZaedAd4K6ijrdS
	MHk4kKAg==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln5-0000000HU8X-2rEB;
	Tue, 05 Nov 2024 15:48:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] block: initialize max_hw_zone_append_sectors in blk_set_stacking_limits
Date: Tue,  5 Nov 2024 16:48:11 +0100
Message-ID: <20241105154817.459638-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
References: <20241105154817.459638-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Because max_zone_append_sectors is now just derived from it.

Fixes: 2a8f6153e1c2 ("block: pre-calculate max_zone_append_sectors")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5cb69d85af0e..7d6b296997c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -50,7 +50,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
-	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_hw_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
-- 
2.45.2

