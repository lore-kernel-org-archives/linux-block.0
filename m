Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09302FE060
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122024; cv=none; b=kKi+6yGu6Ch2HblBcNH0f7tOFkZJL3lEdBS+6BK6cep6yuOl+Ozfl7BoXyKWkbmx8bfxzyXFB0P8XgWnt/4ddEh2FZpzpiR4VAiHy+VPQp5j1FxFT24OzGb586/LytgQO/stWKqfL/Hjefeh0jDRcWpwR6BJGQE46GWyZvilN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122024; c=relaxed/simple;
	bh=IISNIUcamqPCiXQEDbi3sM7MmxotyT3kO93PXKma5NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AU/sDdJKhPVaEp8356HzLcFL0BPD2fAffM784jSblsN76we/qbg/MzuQ6xCgqO2e+SQPxSsoYB2TyJmPensAWZxwqgLudp0zf7uTU8YrN/lx26Y0oEZhV/02i+NPrOcab+sMfWcYZFaa9CPkzZc6GQ2jT2ingut6m8daqtoxZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ja0nUrpM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ja0nUrpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9bIBhEiJs9f+Y10nyqtFi1V/uDKCp6PVj4S8MI6SAV8=; b=ja0nUrpMHjApcV6lcDMpsuZgos
	kBeLMY9bNHo7/nKWdRz5x1V7Mgm23GUR7jVr/g9FT7gdXoXTnNGUSYDtrB/KjMmG9M7BMSAuxf/IZ
	kluI62nM/0aNighlaEHOKUgh/Hr4wLRQ4sRZno+6JRbAp7McaAf0u10Go1WD1/Ri7l3vGF9kY27JO
	N9wskVHCQeZf2gxHx8UDUy938WQTonz2XvlHoJ5YYT5f6obXhN5s18E5unNyshfACLPqahRI5Yood
	LHdkj2b2s/OqPtdrvVMrTezkDZHhvxcLjULQYsFlTro7wVRYljpWktxrWtG3pccxK1GMT3/TnHSem
	aqIMXWuQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBUHr-000000026uR-2l3Z;
	Wed, 22 Oct 2025 08:33:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	linux-block@vger.kernel.org,
	martin.petersen@oracle.com
Subject: [PATCH] block: require LBA dma_alignment when using PI
Date: Wed, 22 Oct 2025 10:33:31 +0200
Message-ID: <20251022083335.2147105-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The block layer PI generation / verification code expects the bio_vecs
to have at least LBA size (or more correctly integrity internal)
granularity.  With the direct I/O alignment relaxation in 2022, user
space can now feed bios with less alignment than that, leading to
scribbling outside the PI buffers.  Apparently this wasn't noticed so far
because none of the tests generate such buffers, but since 851c4c96db00
("xfs: implement XFS_IOC_DIOINFO in terms of vfs_getattr"), xfstests
generic/013 by default generates such I/O now that the relaxed alignment
is advertised by the XFS_IOC_DIOINFO ioctl.

Fix this by increasing the required alignment when using PI, although
handling arbitrary alignment in the long run would be even nicer.

Fixes: bf8d08532bc1 ("iomap: add support for dma aligned direct-io")
Fixes: b1a000d3b8ec ("block: relax direct io memory alignment")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 54cffaae4df4..d74b13ec8e54 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -184,6 +184,16 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 	if (!bi->interval_exp)
 		bi->interval_exp = ilog2(lim->logical_block_size);
 
+	/*
+	 * The PI generation / validation helpers do not expect intervals to
+	 * straddle multiple bio_vecs.  Enforce alignment so that those are
+	 * never generated, and that each buffer is aligned as expected.
+	 */
+	if (bi->csum_type) {
+		lim->dma_alignment = max(lim->dma_alignment,
+					(1U << bi->interval_exp) - 1);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

