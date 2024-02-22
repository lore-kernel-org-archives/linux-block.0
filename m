Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBFFBF2
	for <linux-block@vger.kernel.org>; Thu, 22 Feb 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587411; cv=none; b=aYhGO83XmF/83wtCTO21ve8SPwkcESVLrexY1XttYs9h1+bcHv2d9vf6TVmArRK9ZOKr/icTWAJS3Jwx9u2Qxr1UDct/OSTIXwbIqWF6GMlsdx9iF/RBe3/IY41W+XdZzUaKTteXD7iEIlsu0U0WAaUHE2gotpAKeuqHZQQ6sgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587411; c=relaxed/simple;
	bh=JkirsZZBmWpT8pBrr2aUdEF0nmQYc01dvey1PIVvJZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glRoBojRFUN0XLVEyfEoYaM2zBUXOiKwZo/UylHwtySyrBLbHF88vVrmqa0knWC4rpO/XTi9Z8Zo7QCXVqTz8ViN9rChfDJpimmOFMXLr95Esn6W9WqRu1h/3G8jKVoaPB0DnqA4UNYXro+FpNRGurMVjfidg4r64AMZ3NyWQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sDFiCaoD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sDFiCaoD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4/DKI6QXJE5TsOpqJv14lsL1v50VdPywbpHUgl7M9bA=; b=sDFiCaoD10kYHXXBoLfxj30nhU
	lEeMYVrLUpv13O4qW+/Y0WQtWc2tavliaizG/b6DgiEccClJZnU2QpB+5LoE6J4+WZaWvOp8bxdQd
	Jx26EdmUPcBKCk3I1xFq6nqqhr9ztNhKnt9xPbBvfNEUP3zR+QfPFVvx9ejdz10t8m8VxO+eaFHEx
	WWIyPvMqmiN7Qaeevmm/lzvRDq/LwmnXkk/W6DFpe4QMRCBRhscqtBzU97VITGtO7fLlD79My+SYM
	id1YNHb3Lgii9qVRrq+A/Dwn0o2nQVFmi/R924cZ4/Ydc3VXVOKUUqwl03eCZ2WcpTTsvIRY7gpb3
	ewwJzAaA==;
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3dR-00000003prs-14Xa;
	Thu, 22 Feb 2024 07:36:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: pass queue limits to alloc_disk for pktcdvd
Date: Thu, 22 Feb 2024 08:36:45 +0100
Message-Id: <20240222073647.3776769-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this series has the queue limits conversion for pktcdvd.

Diffstat:
 pktcdvd.c |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)
