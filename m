Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793598964;
	b=NX5jS0gvgAhbVwu5WpRWMw9/I6GI9PIvq1p91b0XclObyvoRPuzS80swQzVs/FrVVMIq
	 BTfCak6/NJHz3IJ8Cb6cQz0+I3HdK66kce/JILrKtzO86wWhD1Z/YqqgoS21oBP+E3qX5
	 ySVW435cKhqW/TiQujiKbdrYimELxICE/fl6b/wuQTCw3YzYm7xXkMytE2876oqtKN/fp
	 WWtGt9bPAx5PjctSuj4LbGCFU1H0kVNBfvjE0pH5zTtobnGllvW6h0ck+7Fat6Pjctki9
	 ZYsUxtCZCPRFKi8a3VcleDXHl0Dx89+5TsYoEePtDtZM4WyzpNca+aYJGZbwDTHwSdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598964;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-SRS-Rewrite;
	bh=IOezQWgemUh+UuPlVw9WRa9KDtCOqKaIASKjiV9nnw4=;
	b=rcydImQm8w1BOPAQteCTqXEcSK9lJLxp49hXlzDSaYiIQCIKJpdPEULRvqQWCuaZg6JN
	 R5KN3SBrxza0ZSsBX8a9RHis8VS9NMPDA5fiIjHAgmGtFlVGtd4dlPZi8bvrJr688Eh9j
	 PmGeewX54MylWsSQfGFVjbe11FJY+gMnCEfgvjT2TvxTUqqzW3qC0AIAYJFLm/bTAzeRd
	 vcoH+plpgqXXpjl/6GNMosAnm0Jr32yUQHikK1WfZq5Kb4DqlLuexyWIdrVAnT6RIQgoF
	 1r+pBygNdViijQI2y3pHY+r/Qa17JGTMn08RWUmVs0imuWVXyFJcveUeKHBwp5BdMtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i1sbwmSg;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9C60A260A
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 05:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28F9C60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=i1sbwmSg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IOezQWgemUh+UuPlVw9WRa9KDtCOqKaIASKjiV9nnw4=; b=i1sbwmSg18j6bMEjCw6ZaTDIcI
	syl6M037sQ9/cSw+yty0nmDpwBvO17Ivi+aW7wNW25PWNNKoGubUNNFAKgD50nyZwzrovqP8I006h
	roifmkzj4AEPjQt2Hm/Yn+D3esP3cDH8xVT8OLKabgXm1xGT54ljcJo98/qWjhzPkg/t8l75RtVxf
	MOSQnX0YZ/vVuWT77qMVii6olRmaK8PLMY/eQOYnlnks1IvS9CoDWH0AgeBgJ7AFI9d1CC22owmmB
	18uptOpOQidl7A+X2U1jxl98A/9nGP/2C4uE/s9OytAIW/i+gBzndXf8c8QlDfU+dZMx/HeygujrN
	VajBMmYA==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNl1V-0000000FbzL-2KgH;
	Mon, 02 Nov 2026 05:56:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] zloop: fix block size query
Date: Mon,  2 Nov 2026 06:55:58 +0100
Message-ID: <20261102055558.3212814-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The block size obviously needs to be queried when it is not set, not when
it already is set.

Reported: Damien Le Moal <dlemoal@kernel.org>
Fixes: 5e9929e2f03c ("zloop: share more code for opening a zone backing file")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bf..5cfbb5a6b771 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1137,7 +1137,7 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		goto out_fput;
 	}
 
-	if (zlo->block_size) {
+	if (!zlo->block_size) {
 		ret = zloop_get_block_size(zlo, zone);
 		if (ret)
 			goto out_fput;
-- 
2.53.0

