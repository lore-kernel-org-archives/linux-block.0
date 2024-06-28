Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964931BE25F
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 13:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719581269; cv=none; b=hrl+gnrA6imtz1lSIzhHwsn0oF8CYOkH2TOxY8zuMQNSruWp+mObwIID1DboOabMLTsHW8XjhByxatfk/Iyj1XlXKo9Ai5EPzbSkixLprl8lBfX//U2AK1S34V2T/XvUuqwdW5Cdx48BUjgpjzqI81AzczKFEBm2J+voTUm0NNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719581269; c=relaxed/simple;
	bh=HCTk/0KQ6pZlGAXPBjPkRwrBQhkHWiQDulIqyBoway8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SU0o8S5ZAkVXJh9/PSr+Z26iZ6CRf2WUoADn0XkoyZgDa6b5I63bT7uODA93ERipO16B5oTm2PeD4vdRa51U0flq1+xPZNmHKMhj/myO30KjiMqX1idy0Y1m0quuyI9N7PARkJOFYtQa8sir1MAoYJpqt1jhT1soM7ET10A4RKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aOJi+v60; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOJi+v60"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RE5ZyYC07wI3H/fMNTgg02U8vPFwzmICFxNb1zBI5Do=; b=aOJi+v60VuVJnfn4QIiiOeAuYv
	3PFBr74vRl+O19g0tJzHpsRKDMTyvbJJ9kT7QRQdBHlT+N/DD4hQbh85v0H1JrD11zAPzJkW4mqhn
	z3bflOq0yNtDEzS/6ozm38+QR5kGZ1q5Zr2NTluenUmaGG5gW7s7S98n6uTbD0A+AV+FIIp1S/Kl5
	S/CZIGAv4FN1ZkYNhRfzbRKRqnzymCrpP7AI/xWrYCzdxmDtxTttTNFSO90pwWTZomcfj6vg2mMZ+
	V4AeT0PHMjrh/sQdlhg2K+TaSNRCbE6XoyNpU3oVql8P0bQ4ss4ZbxrNZT9WGwAe4W7YAQkhI7r2r
	pIgXgoTA==;
Received: from [2001:4bb8:2af:2acb:3b26:86b1:bdec:6790] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNBdi-0000000Doij-3Gzk;
	Fri, 28 Jun 2024 13:27:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] block: also return bio_integrity_payload * from stubs
Date: Fri, 28 Jun 2024 15:27:18 +0200
Message-ID: <20240628132736.668184-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240628132736.668184-1-hch@lst.de>
References: <20240628132736.668184-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

struct bio_integrity_payload is defined unconditionally. No need to
return void * from bio_integrity() and bio_integrity_alloc().

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bio-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 0912f47f1d1eea..7b6e687d436de2 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -84,7 +84,7 @@ void bio_integrity_init(void);
 
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 
-static inline void *bio_integrity(struct bio *bio)
+static inline struct bio_integrity_payload *bio_integrity(struct bio *bio)
 {
 	return NULL;
 }
@@ -134,8 +134,8 @@ static inline bool bio_integrity_flagged(struct bio *bio, enum bip_flags flag)
 	return false;
 }
 
-static inline void *bio_integrity_alloc(struct bio * bio, gfp_t gfp,
-		unsigned int nr)
+static inline struct bio_integrity_payload *
+bio_integrity_alloc(struct bio * bio, gfp_t gfp, unsigned int nr)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.43.0

