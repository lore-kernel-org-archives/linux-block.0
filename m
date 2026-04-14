Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441EB392C28
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154704; cv=none; b=SciEd1eQeWtZPIzbKoqjfZq9Nz3bJnDojqLEdN2bFcM2iDfKbnJV1KqJNQVQiegimEAmFDUrFDZEPInxCtTr58Bv64ceJD4hxr7bG/0tW11z6i8mDEs38GIMoAoSkzGIoTetutAOn7NtGcCVk6rXXqSPVsp3fGCTsuSqwJWY5+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154704; c=relaxed/simple;
	bh=q3FjPR6E1jRfTRqh/C2Jc4A0NPsEYV7ICg+g3IqkCaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyaIRQhcn2IfMDopnhC2fCP57nk6lbPCrS1K1k0aWgPmIPY5su1eSAw75O7hvP61gwG2FqVOLgbGQIdyT28A0MvVnHdf3EbWzQDo+f06MR/z5iOibqk3cFVAs/ZtUYpMqeEi46yn+KXvjF68NylxpCU+uoC6/2s6m0CUHeQSzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k6a/6TcT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k6a/6TcT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2vHIgt70H5PXHALAjif7ENoH2Uo7Gg8KZhTnPJ4ymQ0=; b=k6a/6TcTokKCuLPdTXOItZ2J+k
	NLoAK8dNty45PLrORmDIAzBnZybBJhbuOnM0nE4XSgYHNZjQ26vjBM94g8PGT3zEAWRgvnUCorPag
	CJCvYROFUkBQY+bqwntGIXtSkiNTtyOiy9FDEieOHR8L+E9IyX8eDG6mPs75cYo6y2xvLVLpCnq7I
	XfxbapkrQF+tOM+AEoRDWtuMzaoILVVDmaoY5ET8fQU307QqadCcc5h2DBnp0l+u9Yv5d22MHlU7w
	AFtgfCcEjWHeC+Zkn1Lhf2G7h9CW/b+x495fSyOWzEpC1zDl7n50YdxNiddV8U192uDDW6Y9hWFBk
	iU35trpQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyU-0000000GxjA-2BfQ;
	Tue, 14 Apr 2026 08:18:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/6] zloop: improve the unaligned write pointer warning
Date: Tue, 14 Apr 2026 10:17:48 +0200
Message-ID: <20260414081811.549755-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
References: <20260414081811.549755-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the IS_ALIGNED helper and avoid extra conversions, and tell the
user what the unaligned size is.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index fc54480ed62d..a738f8629062 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -313,9 +313,9 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 		return -EINVAL;
 	}
 
-	if (file_sectors & ((zlo->block_size >> SECTOR_SHIFT) - 1)) {
-		pr_err("Zone %u file size not aligned to block size %u\n",
-		       zone_no, zlo->block_size);
+	if (!IS_ALIGNED(stat.size, zlo->block_size)) {
+		pr_err("Zone %u file size (%llu) not aligned to block size %u\n",
+		       zone_no, stat.size, zlo->block_size);
 		return -EINVAL;
 	}
 
-- 
2.53.0

