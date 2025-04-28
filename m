Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9426B2B2
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745849425; cv=none; b=c+2OYeIfGrJ7up+Psuse3Kr3Vxg0TrORLduyKnQTcU7mFJhQ5ntF0AsaxAUwVDoP7xPoRLPU9wFfHT26CuajEcdRuI/lYcy8I1L1nPTOqAxlAwZHbPexEy5g6UcmU/zS+M4SSI/Wl3Ev1C1RQTvUmWdg0kF8dKbo++t5cgU2rIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745849425; c=relaxed/simple;
	bh=NWJMZVM1QM8LTlW/3+YrgxV3i6Ny8TZqn1L0EpeXvKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsdgNGiyjrhWZe4/0QdxksBY0SfXLmKdzRa5WPPG4L5mhN4eW/D8Qdy0r8pn7MfQXDNSTypeUI8sTWkuCIWq/mKxDbSw8KjlNfJATqKMLmGl8BpbxU0IA+kfufQjyg++fu/PbTknsPQXBidTC+JpJxANF0aSA0ABmYe93LOn6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m+xxUmXG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+xxUmXG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=24Kg0bEHB7ohOzswxDAovL+9P2NXJis65sRrfNmSmNk=; b=m+xxUmXGqlDH8HrngfqLiNYIYN
	r2GibEwPadA/nOSQU4iPr2HZX1kxZmgkY/IHr2UesH1IdSu98ADiqMno+WcqTQEGbV77dV7NGr79h
	KoCqW34mrWJNMpUaS+uBiGaE82q2+VOvlvBULTWfNrB+ZZag7Z3xGhO5bw3VDR6pbsAcCwc1dfxj8
	etMK1QCBK3gBxxky7RkxQyZYCqu1QLg/Cw+cJe/R3D/+tlUR5h5cTzKFRTaHLyCycpNn5NyWb1Q+q
	mXf4GKKNyPzO3K/JA/xSnGuXURrBAN5DQrIHUaU8385bji4qBZMvuPOt1qeguR/eOHwbhTFxLK8Er
	NGF6ikvA==;
Received: from [206.0.71.28] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PBf-00000006aVh-3muw;
	Mon, 28 Apr 2025 14:10:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/5] brd: use bvec_kmap_local in brd_do_bvec
Date: Mon, 28 Apr 2025 07:09:49 -0700
Message-ID: <20250428141014.2360063-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250428141014.2360063-1-hch@lst.de>
References: <20250428141014.2360063-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use the proper helper to kmap a bvec in brd_do_bvec instead of directly
accessing the bvec fields and use the deprecated kmap_atomic API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 91eb50126355..0c70d29379f1 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -207,15 +207,15 @@ static int brd_rw_bvec(struct brd_device *brd, struct bio_vec *bv,
 			return err;
 	}
 
-	mem = kmap_atomic(bv->bv_page);
+	mem = bvec_kmap_local(bv);
 	if (!op_is_write(opf)) {
-		copy_from_brd(mem + bv->bv_offset, brd, sector, bv->bv_len);
+		copy_from_brd(mem, brd, sector, bv->bv_len);
 		flush_dcache_page(bv->bv_page);
 	} else {
 		flush_dcache_page(bv->bv_page);
-		copy_to_brd(brd, mem + bv->bv_offset, sector, bv->bv_len);
+		copy_to_brd(brd, mem, sector, bv->bv_len);
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 	return 0;
 }
 
-- 
2.47.2

