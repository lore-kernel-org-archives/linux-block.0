Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C0418361
	for <linux-block@vger.kernel.org>; Mon,  7 Sep 2026 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766898; cv=none; b=BJoOI0ZK32GfWWu/1DF85Y7BasZw1oN3EDFLUYl2f1Obr8pCf0dj5Wmw5aBOpUr9tu3mlFZFE1ol3NadhlzKHVRQKiG2kill0B2PYCGlcMAiQR/iKT7+A4UYPuxabx5ThL1+vKdX5q9UWFb4Jj62UdAzeDHnZBxSamWuEuvptXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766898; c=relaxed/simple;
	bh=lR/xW+tLrVZwkW7wKeYyOcUBBmS/xnn/916MBe/yWHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpVOi8OS6j6VzlU1B34MoE2saQG7UCSzUXKGGHH9qwXH1vB/6yUejrHPnms/XWqGrgQ99tQxW17xnOynYi+Uz9Kdivi/IbALPFM47jzoXy991OUEEaglAx5nhm5V/lyhUb3sS8ERE8etSU5rp4ZNgZ4O5OYminRcO2wgqjKF1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tYYoULmK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYYoULmK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I5LUIguU6xAzNMtbKU5QvVVAwm9A3jgegtlIuD0WB3E=; b=tYYoULmK4l0jrfpg8ExTfgg+85
	/Eh8YENjvGtCHXXVS4GuUWPTX4tj9aRMh3nhw18meYow6COcxc4q96X8FQJ+1X0+69oOrNtOmG1oX
	csMrhpSVZW+/GaLcILqwYpLgpUW3NPGg1vtEPjZp6sV3Vf8kzAN8JbQRT4vB9qHKl7wJSgX60fBDH
	JomgroOClrMsDQfHhCedASPeUiNgUXIWfzzapel7IV/SfF1Rx0yXAL6G4TYXN0b5oYOzFP1UzaenB
	m5TjyvsqB8on6dUtZ6S4R7OELIYuPuNwntY+VQtZ23E/L2xPgJB8rS0xl0cdHgrXHOga9x8wWJlh0
	YBLdg5Tg==;
Received: from [91.92.197.219] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Tyx-00000006Ay0-3VqI;
	Mon, 07 Sep 2026 07:41:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: improve aligning down bios in bio_iov_iter_bounce_write
Date: Mon,  7 Sep 2026 10:40:54 +0300
Message-ID: <20260907074111.721054-4-hch@lst.de>
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

Sashiko complained about bio_iov_iter_align_down potentially dropping
bvecs, and thus losing bounce folios.  While losing bio_vecs is real,
bio_iov_iter_bounce_write allocates all segments and thus the entire bio
in multiples of the minsize, thus making the rounding down redundant.

Replace it with a safety rounding down of this_len in case something odd
happens to the greedy folio allocation helper.

Fixes: e7b8b3c5b2a6 ("block: align down bounces bios")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index f95b63c0604a..57ee335899f3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1389,6 +1389,14 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 		folio = folio_alloc_greedy(GFP_KERNEL, &this_len, minsize);
 		if (!folio)
 			break;
+
+		/*
+		 * Align down the size to the minimum alignment.  In practice
+		 * this should not happen as minsize is expected to be a power
+		 * of two, as is the allocation size, but it offers us a cheap
+		 * extra safety belt.
+		 */
+		this_len &= ~(minsize - 1);
 		bio_add_folio_nofail(bio, folio, this_len, 0);
 
 		if (iter->nofault)
@@ -1416,8 +1424,7 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter,
-			&bio->bi_io_vec[bio->bi_vcnt - 1], minsize - 1);
+	return 0;
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
-- 
2.53.0

