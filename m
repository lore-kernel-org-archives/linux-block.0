Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C061014A611
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821960; cv=none; b=SswqtyLJIO1BmoTs0bXOrZFj844Z1UtxapKpcZ6DdjYROIlpnyrjBgwnUaXUrdnK81/YFR835UgUdQu4vIUBRy+TTXQWcmftCGBA3vEcAH09ABjI4Y8qK91glFj6px+jetdcFtpp2xcb/1wWYXsqfuTl+PMFdHiBbagW4YcVD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821960; c=relaxed/simple;
	bh=9QekHUQT9FXcIUef4UMo7t6tgMSSuzTXcpG7kgEoL7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzQReH/179xbX+0uq/ExVu6tPlkFjCZ+BETaA0alUhY+EZQ8n5c5pC/FKZGvtt8p3RW0SVL8EaaelRdzPzDkIyEETElH2hC2wcdq6k6COJc/b377qYCLjC72yL8rbYHJHc48t7GyDR/u5hXyAuH7K+DLnvG5iWZnWoujxfcfzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wtx1WayO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wtx1WayO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=U88QMWM7zkx5Bd42rTdqv6LqloVs3LMbnyn3SsJOG6s=; b=wtx1WayOXCIR4SFyB4sRIWhvKl
	HFyV/18D1N4NvryShVW7fbx7EhpRLmtLfUVd9WaUfzCC82oK8koSyjcLPpeL+hZ1W7T5TxaN6NXcR
	Zysu3Jf6XXzPV7SOyaL3mIBgiBcyd41vkPVOHE4iaIPOeMDRZnwDItNUkv+56lpzkH1Mu1s6KxgYL
	wV3pgtU1HYed8Z2r2smyka6WY9AHJS/85xVSCoEfjGvyg/NILucN10fJQgnR8rj/0K6h7X3cnPE30
	Za3qYGQiAEmTmtkPp1vLi6RwCFp642Ny2DOYonblo/tSujvI+/HR2my+Vp/10J5X6NGcyfSgrgQt/
	fg0+IVrA==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LrB-0000000HVBP-3n2H;
	Tue, 05 Nov 2024 15:52:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: bio_add_* cleanups
Date: Tue,  5 Nov 2024 16:52:29 +0100
Message-ID: <20241105155235.460088-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

this removes a bit of dead code and then further consolidates the bio_add_*
helpers.

Diffstat:
 bio.c |   89 ++++++++++++++++++++++--------------------------------------------
 blk.h |    4 --
 2 files changed, 30 insertions(+), 63 deletions(-)
