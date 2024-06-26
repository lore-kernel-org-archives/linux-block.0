Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA081E880
	for <linux-block@vger.kernel.org>; Wed, 26 Jun 2024 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377999; cv=none; b=pajtPhtNI3atBnWo6HtulD+cGDbUTcgCQQnR5oBYQvygWAA4War4w5Yr7x+Ll1o7wQlVEupxjcaxS0J6DvvIDtkv6z2q/Pq2SAO5z6/cJFNWwscMtSTTqCL6zq4uI73pn5cn7B91q4tAPPqwgDQd1aBva4r81+L3+L9bcBGufq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377999; c=relaxed/simple;
	bh=FXwkkXbsX1GuoeRyGX/qHUpkKt3kgXT5A3NRUPKyRTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwH34+kgiC909ASjUx9+4ENopUWpWmMrwmnc8BcvZGUyBHRnTGUvYgtGyDphVZ8T4a6EY7KhCL+FaPQCZn6gKYTDSYjOP/D4FG/VHRyhPazenFAq98bD5AlI30jvLi6DuJHKvbCC10epMxJ1s8zK4S6ulEBlrjE5xhpwzhU59Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bMON78mw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMON78mw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ELP71pxQA/Vn5sM3sDiIYif58GqHEEW44nTTvsbAT4I=; b=bMON78mwRV8xegwIHKW6/XQZ1F
	Ake3M33q9XdYu1o/fBVpRuc4OAmLZNut6iuSn+71Emz7pFjCENws1aW3oOajLtEW7XDzVdJx5Vzzg
	ryK8DyU9koWKfEhTmXNmmNTuaxhP71HnzC4VVxAoHEDlqq2brhuL6EU/7iR5CIO2DnFclTzFQfKE5
	mwR/Tvn6gUYYN6m9xn5kB2VuZAIcyRY2MsGJF5mNQncGt+nxvpci6IxLMhPrVkQXOUj2TZptOF9de
	I4nnJVrycFiwxS1+JFmowU7YfxTs/8Ol46qR1KuCNdxbRKcZshfjN42tTiBGCRQRPVtUAuqXLxsMI
	8r/nO8nw==;
Received: from [2001:4bb8:2cd:5bfc:fac4:f2e7:8d6c:958e] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMKlA-00000005NkX-0QwJ;
	Wed, 26 Jun 2024 04:59:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/5] block: only zero non-PI metadata tuples in bio_integrity_prep
Date: Wed, 26 Jun 2024 06:59:34 +0200
Message-ID: <20240626045950.189758-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240626045950.189758-1-hch@lst.de>
References: <20240626045950.189758-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The PI generation helpers already zero the app tag, so relax the zeroing
to non-PI metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 173ffd4d623788..8c5991a1c535af 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -456,11 +456,11 @@ bool bio_integrity_prep(struct bio *bio)
 
 		/*
 		 * Zero the memory allocated to not leak uninitialized kernel
-		 * memory to disk.  For PI this only affects the app tag, but
-		 * for non-integrity metadata it affects the entire metadata
-		 * buffer.
+		 * memory to disk for non-integrity metadata where nothing else
+		 * initializes the memory.
 		 */
-		gfp |= __GFP_ZERO;
+		if (bi->csum_type == BLK_INTEGRITY_CSUM_NONE)
+			gfp |= __GFP_ZERO;
 	}
 
 	/* Allocate kernel buffer for protection data */
-- 
2.43.0

