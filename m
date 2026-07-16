Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00463DB321
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193199; cv=none; b=uNyMjJGWLXDNpCRtfglUa3T5q3Hg4Zi65yNWyGerEU9SXee+bYtQA8OR0kkiDjTxYBwwIr0H+gDv3fEjRg7RqVdLyU/5vrof69JitM4ZPqhDinT9+kaojddvjUJ08vS/7WVrHEviXQ8/fa1x2GHiU2hfC3zbqa5UqPDBls9GMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193199; c=relaxed/simple;
	bh=q25AQ2qu47NL3bW4batTP3GbnVj/2LblVppV5xeUPaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJhJVmvPHzF0O0qvdulkXZPktAQ0BPOA8Fh1Zfv7TAv3ecfBv/ocr/4q4Lnnsn3pa/wL2Gs3zr+Nq6rYyKx1cojN0mw16l2o5Ub+hWa+O95AWgvjMIWL1+ept6GQaR22rKC67S9oYqlTIsWRS3QvvPLTtmqH+U5Wk7rqmCIgkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DzS1R1U7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DzS1R1U7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Ry3mJNASz6vi39sRC8lkbe416l9DpIb4nuVA9HsNvHk=; b=DzS1R1U7nTBnPMn766EF3oVDvC
	cumVvkGYEaymVCvSaeMea3/RV+mJgn1X6dPSCivjFBh7NsjU0RJBf6iTjCag0M0qz8Np3c9tzpIyK
	NVIiiWN5WDRF7cKRw9msxKyxj8JogC/gDa+SzetTdTD0xqBYB2kP+oYjqxtmo2UEJWPERB3Rb07vz
	wusMwnFx7fBGa8iscnjp+jOgvI9CPX/RR235o0GkxubDW0lOFdHwUp6duS/ZEQ1wk9Zz19G76ajLn
	+PB6wfZaPJWkZf2mgVZUWjqxuFEfKXLOUIJfHKwaBHJfBHrBo+/MfxgXoR4H1vvzYPQR72T0CeFbL
	f/oxTyQA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkI9Y-0000000GpRx-3bat;
	Thu, 16 Jul 2026 09:13:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	0wnerD1ed <l7z@0b1t.tech>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: handle huge zero folios in bio_free_folios
Date: Thu, 16 Jul 2026 11:12:45 +0200
Message-ID: <20260716091306.316625-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716091306.316625-1-hch@lst.de>
References: <20260716091306.316625-1-hch@lst.de>
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

