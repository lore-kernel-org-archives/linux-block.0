Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D52343210
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372351; cv=none; b=MksPs8ZXaR5hPzZRvi5TYqgFjQumX1ESXyoCo9QCHPs0ORl8MjJWsdf33UYNkkzFu26CQaSivwCBej3lgXu6EWe9ZnH/gXUFu81ENYv3EJIN7gA5+ZEbCpquPGsHYIcO1FkCMutyLvjdLFgcSqkINE1K/H1zfPoYMiZ7f9YXXZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372351; c=relaxed/simple;
	bh=niCggfvedSYAECt714ZQRXGzfvoIe43SaRl6kXf+SD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aw4WphRyBKBxKc4V0se5KvGC9fjlACrOd+Vcb1yP6oOUc+P5eFthdov12gZMfTUQrW/WJkd4atJqYTyRkgDK29KFcEQfzKJ211GSK4yNvrytc81Eo93QnF4D0Ol7JLVA4gdxab6NwSZyh4ydw2u/OUMd1KIrdNuCaJxJdrtqD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jzcIBLqo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jzcIBLqo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bZ+aSxr18r0CQC0aKchu7dBBJYTr0aQ8P44VYRvQpug=; b=jzcIBLqoBMyZubur16fRpoiEJf
	t1ef0AyAp/01tbCloEU/YZGskJbJrIhGo69NYj1Y8XUR7PqthFlJAkaXMvtWLeG4P57fuIxTrA69F
	eCUZWQioG+NHv13u22+6CePQ/Xk4rlP+PpxaI/xY87QWX7kiPcsYbznAMNMjEj7RiV2smQ1ILl4lN
	oDoCDxHoIFP5XR/5abOk5LCZ5WKnKkbqQjXD/yu4XwNxl8XHjVV6B3L11gY9Seusl1DPsNGLS28gm
	hXtJNcXnZ3FTZM3Gl8GaA0tuzsIyCrpoQ45Z4Ysc4STCn0XZh50Jf/vgVH/wVINtshlZl4Wksm7Zl
	aTYNQ2bw==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGjYR-0000000EKw3-20ip;
	Wed, 05 Nov 2025 19:52:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: cached zone reporting fixes
Date: Wed,  5 Nov 2025 14:52:13 -0500
Message-ID: <20251105195225.2733142-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series fixes two issues with the new zone writeplug caching code
found running xfstests on ZNS devices.

Diffstat:
 block/blk-zoned.c      |   46 +++++++++++++++++++++++++++++-----------------
 include/linux/blkdev.h |    1 +
 2 files changed, 30 insertions(+), 17 deletions(-)
