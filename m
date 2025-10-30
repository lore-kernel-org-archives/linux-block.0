Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0C27381E
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835540; cv=none; b=D86rHmXHYNBtFn51Q2Tm7fmg+/OoqtJKNLYhmLhruFEYXB0PVMlVS26lpMHuJ/8qJpmZLtQbLPG0dgSBqLYY1/XyJNSX545fhmD8J1zkuuh9JjDtysXPR21a0D89RPIltP5Cp7AnmDKmTfcGX7s6fdMEg33pE/Z8GzPwHMw13l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835540; c=relaxed/simple;
	bh=QXqeTqcWRjnhU3kITX6VKoWuEIUYd97hGJU83xUnhOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TubNKCAlC3hDQkizykg1USEMCfJ4+yjl2EQRgu5UtP58PooWK/BxTctcsZp8GQUS/mmdmIxP605sj/Kxkd6e6O/Trr4dXgUP8nkz6ByjG1gJgfVHWgTFRGdQzNr6tngESt/3XbPEFCKmqMT/AqJCush/Fl93XPMhoi3UkmLh+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wqNRYou7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wqNRYou7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Eoj1OEHT5gEyjS/5nI5WzZLQbNGQsMfwYd4vO9r5qmw=; b=wqNRYou7FJPwSJ+gLYXpSYAzB9
	QvMSIIJ6z2rqYPTsdVOWF7Atefal04o8XXlwN3ffcg1p22uwDkqF8CzA2ZL6duXnCgs5jDLi0SqsL
	MaaGB8vPNuL6AOaYjONnrKy/y1NXSnBq7YAXTU8+9gJ5hidnl7uQloPXYmx8gTJdQT8AN4VMht+BI
	55Ih6uz4HOhCvRCBr5TamqdZ5usWFL/TNKtmhz4VOKNoA2kTXkx6CvX/yR67bw4OthGJzUTdIul+U
	MAOsoISOszgdZ9112Ygr3wBE/MWwl47iOAQpdd5pgTZUbjHC4wfBJShmcYfwgeRCI3wZ1yQ9NmD8M
	6CE185DQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vETuB-00000004JzT-0OyF;
	Thu, 30 Oct 2025 14:45:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: make block layer auto-PI deadlock safe v2
Date: Thu, 30 Oct 2025 15:44:52 +0100
Message-ID: <20251030144530.1372226-1-hch@lst.de>
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
