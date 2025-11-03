Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF642FCC10
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165017; cv=none; b=UQBduWOVeSYI+SEb6jnyMbXu8Pqm+qyE4zqgU4vwo66EYdBK+57RvOf935GErYqHoql+mCl/55CZuBZUj0vtf/oZ/7qaujcpOFGQHzxF87aNEsHjEh9dUzqTxWOF+OJzvLuq1/+vrEyoaU8ZzLL1nvAvJvGsH+FHLxpqfEPDCns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165017; c=relaxed/simple;
	bh=ps1lDCna4je5W1ZFUFjCRrNUWkpywppz7E0+xWwGfJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHPUYALaMxxSSKuiAxXm4f3+yXPaJ747gqiDklVcYtpyXKlyFAcFp76PW4wJyBatUkdejq9sGLB3pVqhFG3QMgHvWVFigcqb/KGybznxvfM7Ko3JR+SoRm1+UN3eN3aQ35ssUz64KziDaCvcIOZCVTnTiGSppwIsxOow1uffgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Se7FPe32; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Se7FPe32"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=VTAmBfOKXNldS9EAq9lLAx5G+bC2rZDhZ3T1bBF0x5c=; b=Se7FPe32lUYnIZ0RARL6fZUXa8
	+L9jiGcMjmwXS1HXH2L5gqVRg9R4RNGENbg9Sh0yHTz53MrwDcUCaKPapl8hQ6UDHeM4OCJrq1+41
	Nw55UucaD6KTVCODgFldEQ5eE49AuDF4ZNv3Tk3pmfR8fBO3w1bkDOHBUX/0zRvwP74mPK8eRzEh/
	FhWN/SGEuH9edL5vvRSwH+pvvfaOceTGF8P6TF+fRWG6O/SZlfOoRwOSoSCXdOMd2JiW3U61t8Czv
	t9/Qu7rIynu8NRbQlqORffpbDY4E5BSztdsbX6RGcvCV+81RYyc9NBZ6tqMWKG4Shhmjw6F47ie6k
	H4QzZvzw==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFrcM-00000009bkR-2ZmK;
	Mon, 03 Nov 2025 10:16:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: make block layer auto-PI deadlock safe v3
Date: Mon,  3 Nov 2025 05:16:43 -0500
Message-ID: <20251103101653.2083310-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

currently the automatic block layer PI generation allocates the integrity
buffer using kmalloc, and thus could deadlock, or fail I/O request due
to memory pressure.

Fix this by adding a mempool, and capping the maximum I/O size on PI
capable devices to not exceed the allocation size of the mempool.

This is against the block-6.18 branch as it has a contextual dependency
on the PI fix merged there yesterday.

Chances since v2:
 - comment typo fixes

Chances since v1:
 - keep the gfp flags manipulation local (at least for now)
 - fix the maximum size calculation

Diffstat:
 block/bio-integrity-auto.c    |   26 ++--------------------
 block/bio-integrity.c         |   48 ++++++++++++++++++++++++++++++++++++++++++
 block/blk-settings.c          |   21 ++++++++++++++++++
 include/linux/bio-integrity.h |    6 +++++
 include/linux/blk-integrity.h |    5 ++++
 5 files changed, 83 insertions(+), 23 deletions(-)
