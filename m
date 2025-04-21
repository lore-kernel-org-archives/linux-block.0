Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F13D81
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745220428; cv=none; b=E53ycLYt/01pO6gqEo7pMROxyKsvBsZLk6+s02wwz9IfNvJdriBtuQx92hIkVKtEfPFetvH9a6FYF4KhyM+5LEZVxklB5/coym9ceMXw4lZfByFQTOGoY5miVR9nXu3vI6F7lPNz1wS4t7XRcakl1337LrqB29zd3koblsPM/9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745220428; c=relaxed/simple;
	bh=6ZZkDMZPto5aAJh2NbBS4MsZPYm9fG6GF83bmowVBMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzL0rAqMgp8oQruQzVxIj5Wc57gjC0gdOUBxAP8AhcSiS5Tjt6eaX8PNXHFfUx3uUYwX0fyTh6tbQ88a+4T6bRFJ36aIgbSwGsEKs2ZLqliY4/km75GxX1VTvs/5tvKdqFqkgF+tpUsc1+gPiB6mKt2eAQAPLA6Y62YNeK0ZXpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cBz7Oiw8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBz7Oiw8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5EsMnwA8cCw3m6Cfg9FnwWj8ElcZHIJ64VlzKphSemU=; b=cBz7Oiw8jFfdikp61PYFNKIN7U
	X+fKqiKiv2skgCI3HP7DJaHNs0ZrVVOpD7VsN3R31WXM53kux7pdaadVRacRTzGny6bL4zg+Uqylq
	j/sBbbbDRpD39oZc2OsC8ViiG9Fn2sfOtVfC8y0wl7fnnWOfUY8ulL+OjFFvN7hkA3HsT3AwqMsoK
	KX0bnWjJ5qhnjI1Pr86Lrg77kdvJ1CNb/P4OJMDbtZSqsHL0VLpeU+jw5gMw/b9xcJOF7vFTY3C9/
	sQaNpR++2VhB9uVuD1zf9abA5pu42N5hg5TK5EqwfOrE5eF2lcUfK++VvdsldEDwel0W9VeHaBxVp
	+Owxikcg==;
Received: from [213.208.157.109] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6lYX-00000003n3m-1V5Q;
	Mon, 21 Apr 2025 07:27:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/5] brd: use bvec_kmap_local in brd_do_bvec
Date: Mon, 21 Apr 2025 09:26:07 +0200
Message-ID: <20250421072641.1311040-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421072641.1311040-1-hch@lst.de>
References: <20250421072641.1311040-1-hch@lst.de>
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

