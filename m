Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29D23BE63F
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225002; cv=none; b=lWP7NX7krzP36ou0rlgMGILHyyf+baZSXByHT+G79pqebHufsy8Z8qa5S+hc6aF6NWIW+zMFvL+Zf51ei9b/8uvkB+BQEuZSVypboQ7eAZkRekjkOuyEE0r2TMxVIQkJn4d7HwooFYpzfkuFoI6vUivv1NA0uH8NumMSwkeo6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225002; c=relaxed/simple;
	bh=itjjPhcvrZmRfKQhdb+NFMsBDQIRU2csEOWR2BNg8b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bp41lHVt9fetAiUbjS1vly+MJzv0a2V5w8U20J2SWnHBxeaVyPMER8Gg220NPFSJ9obJLfhkH2DUSl6/pxZ9Qc4UrPzZjVlQohqhf20aMkRkpRkr7N0B0Bu3ICg/idzFw7lCzjS6xYVqWSUzYo5ZdIiUDcvl8XVKmtPkhAoJpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aZEZUyZg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZEZUyZg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=T7RPZrZld2qlugv7Mjxjrv452hD7J/EN+hymDmdQ96w=; b=aZEZUyZg6dWwOmEyWd2QXwLmJ1
	MwkAYy42K1BzAPGPOQ7nhfM8T5WnK+4Y/hMNUBTWMKL6c91ejUso9jCVixy/2d7xyn26/dWprUVqw
	6iGNRkEcg/M3/R5OqdixhTqIxsEJRzSwR/sEmscKzGpnRaCU0dLyZNiI7trF131/0/CK6ED8R5r80
	ddDKf8c7JGFdPiCuvF0+mYZKlC/v3GoWS5LJ9x2B5De7aCysmP+9hhjKP9ChCdiPfIqpamuMzyp+2
	AO6Mu7R0Xj24hveF4+eSR+qwkfFen63jenNe/V1AEMyuv6LSK+79BYGRUC6UaZLc7/sNoV5GB0qOx
	9Gnp7jCQ==;
Received: from [2001:4bb8:2f6:ef61:5b2b:8638:3844:9408] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc28W-00000006RWb-2r5L;
	Tue, 23 Jun 2026 14:30:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org
Subject: PI fixes
Date: Tue, 23 Jun 2026 16:29:47 +0200
Message-ID: <20260623142957.1839474-1-hch@lst.de>
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

this series has two unrelated PI/metadata fixes that came up
during a little testing surge.

Diffstat:
 block/bio-integrity-auto.c    |    2 +-
 block/bio-integrity-fs.c      |    4 ++--
 block/bio-integrity.c         |    9 ++++-----
 include/linux/bio-integrity.h |    2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)
