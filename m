Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604E8593E
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646048; cv=none; b=fsKQRZ62cK62DZPGfkYZa3FXwOtgiFVwCwDc9J74Y3obC1lTjmxNM5pt1JcUPRmqOeXowXRGPCwtu2b7688lN9Wj5Juq39GFJEGMqUCwwa+i0wLmojmi2QQUIXUZoEaRq0jyestJuseSDn6sAPwxGHmHkstjr0VUcEBmNOf2wPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646048; c=relaxed/simple;
	bh=WZ2XdsWjVwQod0N+mJSg6AOyJz4P/zy2BHCxKr7xQYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2lmBXVeybaFtrTTHEO6VG4RrAKPHdi+N5bhmwjKe/BncJnr2DQ6PXRJE4jPEHtuhdtckkbP8padbv7de0i1hi41gb4Wp1YLsbSusMUgtOPzjDdOaR5BWlRdNlaJmnhDOnigxsRxpMQWtUsUS2rb3Z/gcBEGAfo/ggBieTIPa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JzetSQPh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzetSQPh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Wu4aQNgacSiuDXEhKe8iEjuSJnZOtB4WhweP8yWkb8A=; b=JzetSQPho4DWyiYrFfDYFnS/Bg
	RATsclB+qRKWQDSHUiDY6ZJBqofBZWsxPIZIhoDXsA2s7E1oGIBB9HwsyiYt+1i23QWWYlnWkpFlC
	/AwdJBnSrkxoBl/3Zar2fnYiXyGU5qQDQrTBWXgo1IZwKS9BBWBnBlFndleZ14ew5jF5CUQ7nNAXe
	UmlbqrzvZgB7G6tcHC+kaWYXVl7qDcs+pEdVihw7/JUzAK/LW/dbNk29Sj9BRH8oNRNiMdnaeJjnK
	v5Lq68NKmC5i2lquTyU2OrchTa5tQYzYpE1RAn8K3oia+1q4PIoncsmWXGOJG5dCauXvlGMa+nn3g
	Qd3At4pw==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2E-0000000Dqy8-1j4m;
	Tue, 05 Mar 2024 13:40:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 5/7] drbd: don't set max_write_zeroes_sectors in decide_on_discard_support
Date: Tue,  5 Mar 2024 06:40:39 -0700
Message-Id: <20240305134041.137006-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

fixup_write_zeroes always overrides the max_write_zeroes_sectors value
a little further down the callchain, so don't bother to setup a limit
in decide_on_discard_support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0f40fdee089971..a79b7fe5335de4 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1260,7 +1260,6 @@ static void decide_on_discard_support(struct drbd_device *device,
 	blk_queue_discard_granularity(q, 512);
 	max_discard_sectors = drbd_max_discard_sectors(connection);
 	blk_queue_max_discard_sectors(q, max_discard_sectors);
-	blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
 	return;
 
 not_supported:
-- 
2.39.2

