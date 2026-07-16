Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2D3C455C
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193196; cv=none; b=Jl0WdhyO2enEOdMFiN9IqKKEYbYd11BlswrhmAdLJfm/Xn+1kFVcgMFJ3Tl8ETSkdrm8Yz+bQM+POt0Rex0+ejN1syP+Vyy9JA0pHIZfz8QAL+pR0NNGAWlZEv8up7XIxoZFe3rmOSJb+e6BfnMjajBAl8/VLH9KJnMTddexcuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193196; c=relaxed/simple;
	bh=fq9Bg4DnH/m07kT2/y4DDlAE+UUy6g835/QaVpK4MHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vut+CMaz6GLiyA5AljDRJ7iCT0hTRsxR4BkOG3wvpAgTbkqU60/b9kDkr/om2M5UTeuLQiwjtoh0UbMYhDZ0VYCPFY3vaDHKliyIIHD7TJTk41p50+CguQ11lE/eYzFQKCEEhy5jYAfk2IBy7oriFQ/bQLTA9JrkBO/Sogc9Xv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=khDLpDZn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="khDLpDZn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=75Ac/yGGdisdg3elGal4loJA5UhGWq0GxMI3wjHefD8=; b=khDLpDZnlwke91cQKV+qv8mvtl
	Hobg9fdPkEhf9599P/hBlHpz3G/94ICEmNZV7p26MvttOEkqzZgYGRBuopT3mjcVdMniuDmWUGQGR
	JHKqP5nbuVjsDxn/SnWdCOrI30l1WlPGux13fg537GC8gUum7OK9YuB6VSl26dOK7xRmm0HU2QenF
	ar7w+6Ikm1Tvn5XNrxs6cbE8r8rfdGVJeXl1RCzAqUFQA1eSGdPePmkr4Ku496D0kAVOB18ueT009
	C7GbcKuD6pmJlS0uMc4OCbZworqZbuYSYwHzZ5Oo/ef02nZT16pBAqQf53tNujP1fwuvakrKVEh0z
	N12GFUVA==;
Received: from 2a02-8389-2301-9f00-b29a-36e9-8c1c-0994.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:b29a:36e9:8c1c:994] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkI9V-0000000GpRV-30Q6;
	Thu, 16 Jul 2026 09:13:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Neptune <z1281552865@gmail.com>,
	0wnerD1ed <l7z@0b1t.tech>,
	linux-block@vger.kernel.org
Subject: bio bounce buffering fixes v3
Date: Thu, 16 Jul 2026 11:12:44 +0200
Message-ID: <20260716091306.316625-1-hch@lst.de>
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

this series fixes a few issues with the bio bounce buffering code.

Changes since v2:
 - fix another issue found by the original reproducer

Changes since v1:
 - go back to the previously tested approach without iov_iter.c
   changes that break small vectors

Diffstat:
 bio.c |   53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)
