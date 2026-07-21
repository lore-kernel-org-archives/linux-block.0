Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02E40BCDA
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618274; cv=none; b=mSqp/eaOLM1RJU7IrpQWkz6HkgCdDeePV/tFjL4tjOHbMFFwJ+6PgOSlTW3/jkHhrducUc5uLRn+sMSHrw7HmkYejlAnTGpc73x4Qu7ziTo7jFiV776Xc83bi+07Y/haVWzwTi4biV3L0rLyxztB+HT2rA3QB3gk4PPSCMpRnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618274; c=relaxed/simple;
	bh=334nR0k4oOUmBAx2RMkLKDBAUu8YKAAbH/3mO81W1BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPfVZdmViTocuABTF05pCN8Eao+eiIQ4PfGKitX0GqlzugcItB2y6Dec7otRqFX8KS9o0dfwNLuaZBeQEdl4KXjGQTurYbjYDnGDO23PSkbj/r0WnIFZDcOFEizsIHfUO4p3tbX0VhPK761+egjNXQ9HLghq1z+5SCN1sjJu13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x810d12L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x810d12L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vTykqxUU9JhrjC40BJnn+B4IMjvj7JIls7nQNOBEj4c=; b=x810d12LXOZuJQVLTw4w7nYANG
	OP47Bl0Sak/l2QTj94OrEomQjMDDIKT1c/KQHWb0vZWXgK6MFLhf1nLBn/KdOjAjehTXP+4c1Jnn/
	xfkyxQE/yphafELuIuT7f15WJbKIEdl+rY956WlsaVyQCdRfqj3EHxBo7YIQVY1yzIeqvv9oZLwFC
	LosZqim/mq8q6fQBCL1cORIuJZrj2dd5oPrrb6+Xi1ZRnKnX6uZCcwBZ7DECBCDueBR8dDiMAh0Fk
	GQHOp2hCDPg3+8rCl5Qm1DK9d7rCEXOmPvDOlymwfqWeXNj1MkNlt3zeBhpIZHiASNVarZ8TwajEe
	CH53Fk+A==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm4je-00000008dNv-20FD;
	Tue, 21 Jul 2026 07:17:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: lift BIP_CHECK_FLAGS to include/linux/bio-integrity.h
Date: Tue, 21 Jul 2026 09:17:26 +0200
Message-ID: <20260721071739.2514228-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721071739.2514228-1-hch@lst.de>
References: <20260721071739.2514228-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To allow for users outside of bio-integrity-auto.c.  Also add a little
comment explaining it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-auto.c    | 2 --
 include/linux/bio-integrity.h | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index 43ac9f338183..9456dcffd17a 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -44,8 +44,6 @@ static void bio_integrity_verify_fn(struct work_struct *work)
 	bio_endio(bio);
 }
 
-#define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
-
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index c3dda32fd803..0ea2a8bf7efb 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -17,6 +17,9 @@ enum bip_flags {
 	BIP_MEMPOOL		= 1 << 15, /* buffer backed by mempool */
 };
 
+/* flags that require generate/verify action. */
+#define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
+
 struct bio_integrity_payload {
 	struct bvec_iter	bip_iter;
 
-- 
2.53.0

