Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40554356766
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766891; cv=none; b=eHWNT1Zlxh9jHyUV29fMuTrV4e9bjsnBMyiROXkGiYcSoOgC7D7EvajqEdxYgf38MGK8/mJR+IhbBFZkQ8mJHHil/jEysEDLD07u7iBVbiyl+yHG7ho/tVqz1pgax8k9GVXDaGtj61p6LPaAYCw3jc8vusPNoHeKIn21CjUwtaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766891; c=relaxed/simple;
	bh=OdB4SOnDnH2LIU95RbOfX39db5Nb6mD8anDds3KpENg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMhXFq+BKAFNn8+D50wxjaK8hmadVr+rKXVGUAXMKNWUwz32enDGtR//hVrpoU8BwlhtnngrBwhCRBZWsfiLcPx0NF6caiGhMqcRyQAa0G88JP8XvLPBNJBybJgNj/ZQ88Dshz333SIz5foOZ6hSIigua4/3ltgFfRAYQrS3rnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4YlJlp8l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4YlJlp8l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=w8ZTvbnQY8fxwh3ja2H+7CvxCzmOPh3X0+oe+r4HtUk=; b=4YlJlp8lHnIkzBz4aYG1ABpd9n
	MvGrTpunnYgU6J4SKprSMSU/2Qgmvu/+ivxwd2O51mVS4p9jwKQLYrskkK/LCJ35aqr7FVw9EbyLz
	hUi5ODFJ0w+QVgHzqgC44QMs1fKplo53yIxuY7OeuYQSOKbMeVgVIvY4qe/0Mv8GhOpBTO+y5vdgH
	p+glNko7FYfmJAa8lFk7p0Rmdgd/06IDqbbTpBL6py4hd10EaoACHepV7ge+GR8suLXddjekbXCXb
	LPZq9TnjVE/3KVo9Tcp8AG90KsrnYCfHy2IJidna0EQhPF8kqDTdvmYdV/Lqj4lpXUgXP2V/fbTp8
	FDekwAXw==;
Received: from [91.92.197.219] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Tyq-00000006Axh-1KVN;
	Mon, 07 Sep 2026 07:41:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: cap atomic write size by PI buffer size constraints
Date: Mon,  7 Sep 2026 10:40:53 +0300
Message-ID: <20260907074111.721054-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907074111.721054-1-hch@lst.de>
References: <20260907074111.721054-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

As Sashiko points out, limiting the I/O size by the size of the available
PI buffer can cause inconsistencies for atomic writes.  This also limit
atomic_write_max_sectors in blk_validate_integrity_limits.

Fixes: ec7f31b2a2d3 ("block: make bio auto-integrity deadlock safe")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8274631290db..e469baa1f08b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -206,6 +206,12 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	lim->max_sectors = min(lim->max_sectors,
 		max_integrity_io_size(lim) >> SECTOR_SHIFT);
 
+	if (lim->features & BLK_FEAT_ATOMIC_WRITES) {
+		lim->atomic_write_max_sectors =
+			min(lim->atomic_write_max_sectors,
+				max_integrity_io_size(lim) >> SECTOR_SHIFT);
+	}
+
 	return 0;
 }
 
-- 
2.53.0

