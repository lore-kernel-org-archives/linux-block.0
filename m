Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1493D46AED3;
	Tue, 14 Jul 2026 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034815; cv=none; b=NMuT+EkOarmcYeVSNrqVgaZB7EPTQBJgXHosbuLRL/61vlImjy1759bbIU0ZSuqGjgHOkQGQeVNuwLaE87nrG5AMF8P6Rod8tAsSkXgFxs403gTrycVetuaUAssved2Oe0RWuElYZbO+Gts2HTgOvqoh3v4QwdWu0wLpJY5EsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034815; c=relaxed/simple;
	bh=t74FTn+xQ7OrCFzqkJHo9LIzXR6yuAEAsk7GxIjddck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDw2n2496S4QurY0LehVMvvTcff0IT8+Bw7Q9Fizf/J91jFf/L/84QusSZSjTLsgIK6mq9HZKjP0q0/JwfdoVji1M77NTG0J0ENi3a+QSQjP9O2l/VQMSLXY4LjyARKd4nWYQdRLrkDw4XIn9LaHdw0Uijn/Hrxay0Q68LKXpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wVZEzloE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wVZEzloE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hLtrG99Cn5elf5OtzWMeO2Qt0laRtYafJB+GRg2eKxU=; b=wVZEzloEH7fqU57kzkeC4Iu0RV
	IQ1m0VQoJ0idbRRh/BQCVak2Klsuh7iVsIUCOrskPDRPbFz7HgyB/wNKWyy4C+R2x38A9hwkkv33c
	lOjO4vr0LU8Oidiyn4YE3CCxAW8eKyoxrPxlAPTUZgkCdVrorozIu+0SssnrErj58JJBlB5YVAd7P
	PAtFVzrtFJkQ/tqGKKHGO/eWNeKcMt6VK8kjjRyO/hTISNgdiaYaGJqQyCgqsRHfdRtOU2v7W9P2f
	4yAp5PdxTnHg3VK6jFdtabQBgV7ZLAgyFjLxkvzwTJXQNR1MENPO5Vu+rf/bF2SVhYEiCWC4+l35R
	P5xaTJeA==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcx1-0000000C7j6-0R4S;
	Tue, 14 Jul 2026 13:13:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] block: simplify minsize alignment in bio_iov_iter_bounce_write
Date: Tue, 14 Jul 2026 15:11:59 +0200
Message-ID: <20260714131318.2670042-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714131318.2670042-1-hch@lst.de>
References: <20260714131318.2670042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't allow partial copies to create unaligned length, which the file
systems can't handle, and remove thee need for the separate
bio_iov_iter_align_down() pass.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 23f739d5321d..7f707ecf328e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1399,7 +1399,12 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 			 * bytes as @this_len is queued but only advanced
 			 * less than that.
 			 * Need to compensate that for the revert.
+			 *
+			 * Round down the amount copied to the minimum size /
+			 * aligned required by the file system so that we don't
+			 * create unaligned bios.
 			 */
+			copied = rounddown(copied, minsize);
 			iov_iter_revert(iter, bio->bi_iter.bi_size - this_len +
 					copied);
 			bio_free_folios(bio);
@@ -1410,7 +1415,7 @@ static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter,
 
 	if (!bio->bi_iter.bi_size)
 		return -ENOMEM;
-	return bio_iov_iter_align_down(bio, iter, minsize - 1);
+	return 0;
 }
 
 static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter,
-- 
2.53.0

