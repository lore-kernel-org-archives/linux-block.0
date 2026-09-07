Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EB41834B
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766887; cv=none; b=WvdB1SNW69xZG0vmA8qP9tWG64uVt2i26QtNTGB3ro0b3XdgQXy2VZFipFsvVnmCARPnKdUnj2ppV4H6mmaOvjlKF0uuOh0U5EPXee1bQeffy4BTJlOBi3UUs8ZEJYuDdHnHWoxCyWa4Aj6nn27upQLSZ40TKFb8gTJZdxt1goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766887; c=relaxed/simple;
	bh=AtTliLJeBF5w0LqnJB3s46upY2ddUo+06s9SrRkidOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWrAcXtjz11VQfjPIctcjIJKg1GvgzuxqErKqht9JPqOmcFMATHHvDfmnMrRJCCII+CQSvVjiwblkp1XjnmgRzGvydrjYQaW5nbESGIAM7+Bp0LJnCJ5CXpQRYFDAOuwBuCoO9yiOWbvf4kBtEW24Qmyo0z1QyrFZC2UXqZ95vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1TSsNPfU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1TSsNPfU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5qQGSDQyuibZmKamKI4SEZyzoWbi0MjKS0gtUIk5g0M=; b=1TSsNPfUFmbuvLqZlSIEV6sld5
	3E3SiYCmkR4O253sL8ffqyKCcuRYSQoVNa19z01SULMvs/TCe33mPNTa0PDEmPGw93t7HV4T1d/yn
	y8A2M9KRgz52+yNCQ3ycL9PLGa5hFoO0mA1Bec3JPYw/FcwY3qhbz4GGlmlZpUe+jwdgWV0hcs8yT
	JBbqXDPU7+0nAm1bgTQYsLhAV6kvydHg/4QeITtizuCUs/3aqsWbru3VWuOT4zyLFMk+4UPSjc6I0
	famxtK8EowYDDo9YFbWfhmf2H8ieYZDCEqqIWadjKPxoo4DEpY6lRj9Q9QJA6tkoFZAcrQfz+AKsz
	qXK1SRiw==;
Received: from [91.92.197.219] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Tyk-00000006AxL-1EGP;
	Mon, 07 Sep 2026 07:41:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/3] block: avoid integer overflows in max_integrity_io_size
Date: Mon,  7 Sep 2026 10:40:52 +0300
Message-ID: <20260907074111.721054-2-hch@lst.de>
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

Sashiko reports that the calculation in max_integrity_io_size could
overflow a u32 when using 16kiB or larger LBA sizes.  Fix this by
evaluating the maximum size as a 64-bit integer.

Fixes: ec7f31b2a2d3 ("block: make bio auto-integrity deadlock safe")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f7905c3412b..098a65f3e48b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1816,9 +1816,11 @@ static inline int bio_split_rw_at(struct bio *bio,
  */
 static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
 {
-	return min_t(unsigned int, lim->max_segment_size,
-		(BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size) <<
-			lim->integrity.interval_exp);
+	u64 max_intervals;
+
+	max_intervals = BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size;
+	return min_t(u64, lim->max_segment_size,
+		max_intervals << lim->integrity.interval_exp);
 }
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
-- 
2.53.0

