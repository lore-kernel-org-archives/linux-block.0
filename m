Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18063225413
	for <linux-block@vger.kernel.org>; Wed, 15 Jul 2026 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097743; cv=none; b=SIjYgYtT8eyOEIeUH1+QKSCqMylm5efrWHsQd6qkFCFX0Une/Uk4GyFMjGSKYsfq5RyKLfR/5/283b0KwXkxnEe78YqTJYyJa4f7L7NDYkbCOi5gjukWgckxgk7mLkl9QtHEcV1FYHLrABX25MYhVXOesaKcT+ThuNBxmf23V/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097743; c=relaxed/simple;
	bh=q25AQ2qu47NL3bW4batTP3GbnVj/2LblVppV5xeUPaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1FcZ+94DQ7njIJxnqfl3yEmQdbYOh52uAN4Y5CJpp2VK15YsgSdP1gvit1d/v1sldcHV8X7FeHWEOM7rqmB/OZ1ZOphX4gy6UKFtLcGo+jX0Lz+HeR75TzVPKoKUCsZQGEA8Y0655kFJS+RMwrYK3fCC0ofLTEklW1RlfgzOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1vkcPY+u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1vkcPY+u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ry3mJNASz6vi39sRC8lkbe416l9DpIb4nuVA9HsNvHk=; b=1vkcPY+uDejvEG4b0x9PpugBId
	MAlRqSHwZ3hDn+UtNfVbyPsTlszBzgDeYofzYGJtOgJryzrIeaPfTjVuT1d3IEb81PqF97Zk3ZDJr
	QUzj7rJ8SgCSFXVt25EnRsKC8DuZdUQfnGgQdQa96h4iIkeBSfaNEpMVYBp+HPHFVzJ5f3UMNJXAi
	JHYvNGVFJHMX8IBmS1OHSK5xFotaQB757S8tXhgxirv5NwbFUZCjVjjiZU/EciKq3dsEj+rP2k522
	XTm9F5DqKTmB+tEFNO2cl4oaLVsRoK93CPNJe5FnBFB1VEhk428DbRxThIaOS4J1Cy8KgQbqMgXjA
	Tba4I23Q==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjtK1-0000000DviL-1HVS;
	Wed, 15 Jul 2026 06:42:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: handle huge zero folios in bio_free_folios
Date: Wed, 15 Jul 2026 08:42:07 +0200
Message-ID: <20260715064215.2934345-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715064215.2934345-1-hch@lst.de>
References: <20260715064215.2934345-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When CONFIG_PERSISTENT_HUGE_ZERO_FOLIO is enabled, iomap_dio_zero() can
add a huge zero folio to a zeroing bio, which needs special treatment
in bio_free_folios by also checking is_huge_zero_folio() in addition to
is_zero_folio().

Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index f2a5f4d0a967..4d6e5f5f5710 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1302,7 +1302,7 @@ static void bio_free_folios(struct bio *bio)
 	bio_for_each_bvec_all(bv, bio, i) {
 		struct folio *folio = bvec_folio(bv);
 
-		if (!is_zero_folio(folio))
+		if (!is_zero_folio(folio) && !is_huge_zero_folio(folio))
 			folio_put(folio);
 	}
 }
-- 
2.53.0

