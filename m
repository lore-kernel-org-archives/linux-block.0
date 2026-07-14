Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB34657FB;
	Tue, 14 Jul 2026 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034812; cv=none; b=GO8Gw4a4ZsmGjr1vlUdW99SA6Y+sC8gGTem/KT7e8JjyM6n8GrIBFqfkOW5CQteTfFf+NtuMy/IBakSqL8e8y+xpyx7J9D5+8It+ToGrpqg222ByEt7cuBtAZkXfisAT5QfAeC1fGOWvNYDOIaK9QSPWOXsZ6AfwiFH4e/eS4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034812; c=relaxed/simple;
	bh=36L9ZMd0pXqJTwnxJv+nG3G757S/Ql1jy45rh9pJlME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBjGQwTjD/yUlEhrp0MijhgXCHKs8Rd2njDvozrcZLmbfNqP0p+MEXeEOIv1S4k1/zeP6IbrqVu5KccCaTqCvsCVJjRwcmcoCyz1D+JhyQVf8yDj/WNDxQHNOxbx5Rc7LQyLXR7rhuaQ4VQE7IbL0c6qb5J5bT8aVyKtQesvWEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TBXsR2GH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TBXsR2GH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=scEeztD/R9gSoAjDmKwP91lSk+6MtT2VA6/wTS+hUhk=; b=TBXsR2GHWCVkeh4sGxPeTCOyRy
	Osyw5UWnksPEu5HcXtYP2GTB1n5nVqQCs8kmPUYBcPTqiCdHe6jGILzS+KoqX/Pwavfh4jtjVNb/U
	M1zfgl6xfJfpbpXd4hH2OytU3eex0FFKqcJcLp55spyFdTftHQ6YIBrecTLHc2cRsv/fmlXzsMa/C
	NMpW9lmhLPl8j8qwOU0P1G5FTap+f4wsKqkneZ+3U/5XqpytpEgBdpeFv9Q/0dmhTgY9rum40ESl7
	u02QVztjH/1/nFdHK+skotBZ5+BcyF/6o3lA+YHCvKIZC17uf8ywInftLUIfdj/0DNXGmUAPfEk4b
	MXKR1ILQ==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjcwx-0000000C7gj-1JYK;
	Tue, 14 Jul 2026 13:13:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Keith Busch <kbusch@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Neptune <z1281552865@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] block: handle huge zero folios in bio_free_folios
Date: Tue, 14 Jul 2026 15:11:58 +0200
Message-ID: <20260714131318.2670042-2-hch@lst.de>
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
index faad41a72ac7..23f739d5321d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1352,7 +1352,7 @@ static void bio_free_folios(struct bio *bio)
 	bio_for_each_bvec_all(bv, bio, i) {
 		struct folio *folio = bvec_folio(bv);
 
-		if (!is_zero_folio(folio))
+		if (!is_zero_folio(folio) && !is_huge_zero_folio(folio))
 			folio_put(folio);
 	}
 }
-- 
2.53.0

