Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5F1C84BB
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051940; cv=none; b=Wn5XUB8iYSiwr+D+i5xqGh2MWSwq8f/UPuevRMkd2DGQXWdNW3eERl5thgevSSkJxnl+iphkncQ/71g4+YMQE9ecnqib2U4tCbdW44d0KWsmSL5Pq08qLMO1YZTTNVhlk6ktsX/QjYhnSRxy9hO2YZknQIRV5yaUDLIukkyJzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051940; c=relaxed/simple;
	bh=KzRyl0dLZyaFzu4TOScR8Q0rmR4NKEfYO/rfTPp6mNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psD1JcG9imWnTk5Lvb4VTNO3OqB4zKFXkFOT9BASIwNqYRKJBgGL1ihUeufoalvqWRoB3kcrAzlIyj+hXcqpX9t4GWF5Tjaw6V9nvcAUgsJOJD2vFRYqMb1OUU9a88GX8JElehscKwmP7XMm0SE0JSXuxXR6+akraEe68T7LBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d6vWCdU6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6vWCdU6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JDzA0YDzEFlhv7IC4EtN9fM3j1+Rljpch3wYUa38ZP8=; b=d6vWCdU6f3KiPV2tl2xcoPd+eg
	33QICnkwD4u3rMjOZIpQX8dRrVkdGNTadb0n84tGmgs52N0ayIq96dD5bP4gpsPn3Io+6rc2hgYsV
	O61+ec3/NMikTjubFCWeR/GQh1sCudo24NFOWjJKkXQNjc5Z1QGCvBuJpaOShnPWx9DLsCbDT3qA6
	vX0PzDABU7Jca8pX57hAe6Jq66re0QNYy6PiI6NZ5vgbPUl2d7y+Ydpb2CXeAWJo9fiGafFum6bkK
	4yre+uQl0nDk4teqdO5QS5RzrysTxKLiuE9+7zDBdkY0FzMWtfqwpoJpAnqLb1fBtM2pnqKHg3rHD
	XaxVfJbQ==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7w5x-0000000FMzS-2whx;
	Wed, 01 Apr 2026 13:58:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	ebiggers@kernel.org
Subject: [PATCH] blk-crypto: fix name of the bio completion callback
Date: Wed,  1 Apr 2026 15:58:51 +0200
Message-ID: <20260401135854.125109-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Fix a simple naming issue in the documentation: the completion
routine is called bi_end_io and not bi_complete.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/inline-encryption.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
index 7e0703a12dfb..cae23949a626 100644
--- a/Documentation/block/inline-encryption.rst
+++ b/Documentation/block/inline-encryption.rst
@@ -153,7 +153,7 @@ blk-crypto-fallback completes the original bio.  If the original bio is too
 large, multiple bounce bios may be required; see the code for details.
 
 For decryption, blk-crypto-fallback "wraps" the bio's completion callback
-(``bi_complete``) and private data (``bi_private``) with its own, unsets the
+(``bi_end_io``) and private data (``bi_private``) with its own, unsets the
 bio's encryption context, then submits the bio.  If the read completes
 successfully, blk-crypto-fallback restores the bio's original completion
 callback and private data, then decrypts the bio's data in-place using the
-- 
2.47.3

