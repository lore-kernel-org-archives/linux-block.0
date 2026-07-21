Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDE432E71
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618270; cv=none; b=ZBjdOpDISWvtNauA8zbgPK70Mcuu9lic+2z6wzK6xwRsEGMcUl8Nwk7C/+isGgYnL3sPk6t9JrBLUEN0y+yofGIhVxKnQKUdCge2Fwqy7rvZp6VUxWKxmtw1BXDirTBwQpA7q6Yo7KT2l5pyKSiOHn7ToFtVoH1y6pS1Ym/1zlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618270; c=relaxed/simple;
	bh=9Ezv4gbj5ETMrpweW19L0Bi3dprVD3FihTI5+IM05D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DyamCN8vS/fw8BW0jhgCS5O2AfuhYHcl/pO8K0x+IbYegtJs4hfLnKCBNHk0PB8mfNdzejr7RlmzuOqgK0u1CN46sEoPm8iVfLh89d8igByPx/f0DOHdvWiZzQFIwmjKzJEDKSszqpZYkWf6tm8//oDV9qPqPiobmYVpOWjO/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dO56wg+i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dO56wg+i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=saJcxGswh6orpsE5acpjCKhMmx/sp6WNi5ASs5GyeM0=; b=dO56wg+iuXCBbop8Jdj7nR4kJK
	0AAcXOuh3rEdRsrJ9sOwQvjsfaijjy+iB/7q6y+SbPWFn5IPEFWcPaZ68wAiGTSwkYC4Cq7mgsP4Q
	e/0oCftnUer3lpe6H4F2hniM6Wx6ETWWbfIG/mg+aDy6wWKy43Ep9GNm31gSORBFUvXuEv1fV3IqO
	JavC4X5IiiFp5Z6sEWwviOwQc2Pl+btvSuPhYJY7UmBoI1DhSzaMrTFQAt6n1ESnXa5zECNVr/BOv
	XTYAuL23wZpzPmB4Pi1aub1FgsbE2M/pMc1RseYAkFGzfgkQxzUSQs/g09iAzaoCip0KlfC5fnwyA
	YsHot7vA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm4jX-00000008dMk-37l5;
	Tue, 21 Jul 2026 07:17:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org
Subject: fix fs-integrity for non-PI metadata
Date: Tue, 21 Jul 2026 09:17:24 +0200
Message-ID: <20260721071739.2514228-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series fixes incorrect calls into the PI generation helpers
when using fs-integrity on devics with non-PI metadata.

Diffstat:
 block/bio-integrity-auto.c    |   10 ++--------
 block/bio-integrity-fs.c      |   11 +++++++----
 include/linux/bio-integrity.h |    5 ++++-
 3 files changed, 13 insertions(+), 13 deletions(-)
