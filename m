Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467AA2080E1
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494690; cv=none; b=cPQnYTjFrWfdN225WE837+2RR5i6XSYPSfVBGzZ441Lzq2ICYIb+Wh4T8a2L7cGFzyxo4Ds6lK4f0oYtOc6zraakIKELAn37gkocKVYXSKxXy1lw7jMauePaHFVCXqU3jIS8fTxXaVqxAKeoZ7IC7YDIIOcdTS2Po5x4f6E+sVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494690; c=relaxed/simple;
	bh=QtAsjwGcMr/cl8FB/1WvCspVxDh08/JBTZi1wckbVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uy4KT2F7bMhaQHI+L7oJO80+uKx5T6hhHzV7zKO+Kx4n/zigXL1nxbUpb8gLIj9ERaZMG+/qTtYA3DBiU4O4wlqG3l3Wst7A5y+rcTsyQpRtaQxAXK0nwGZ0mPalZ9qya5vHdtz0I578n7DxO4KZ8Ha3breN4OBOf7AeS1p4/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pj+meaqa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pj+meaqa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3Jtcm6CMpcaO8P1Y7V8sqa3C2at6TAs1buK5yy5RA5s=; b=pj+meaqa74fiolEk4xzP+zCEKq
	zTz0pRDSJqtp4o2q6zP/IXjy2LJ3kW5ugKIZSdJl3yGKa3afUnB5j7xnKXsTM6ncA4KPLKIbpniV7
	DGYC5m2G2qXMmak1Piv2XINhwd+S4xDOK/WDijsu32sLv43CFCj2BTJH0D+mFaVX8b+L6IITw/9Su
	wT2cFLKLSNrHyPRv6YtEA5jVwF36WC/uNX45U9MwCEGCWmAKtEnlIu40MXDNgUbAcbeQC4oHYH883
	yhzTo8IVA8LqU90nqsAQqvD37WvtAeEk7c5frIef8rxYD6z97GP4SeuySwcGMpyt829Fe70ddTopZ
	Wha6P66w==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9aq-0000000EOSB-1GJY;
	Fri, 10 Jan 2025 07:38:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/8] loop: only write back pagecache when starting to to use direct I/O
Date: Fri, 10 Jan 2025 08:37:34 +0100
Message-ID: <20250110073750.1582447-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

There is no point in doing an fdatasync to write out pages when switching
away from direct I/O, as there won't be any.  The writeback is only
needed when switching to direct I/O, which would have to invalidate the
pagecache less efficiently from the I/O path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 55bea9c95b45..cf80cdf5e440 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -203,8 +203,9 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	if (lo->use_dio == use_dio)
 		return;
 
-	/* flush dirty pages before changing direct IO */
-	vfs_fsync(lo->lo_backing_file, 0);
+	/* flush dirty pages before starting to use direct I/O */
+	if (use_dio)
+		vfs_fsync(lo->lo_backing_file, 0);
 
 	/*
 	 * The flag of LO_FLAGS_DIRECT_IO is handled similarly with
-- 
2.45.2

