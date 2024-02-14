Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5C171C4
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904514; cv=none; b=I4pnRU0BGsfqnoru+ABj2iG5W/IaA9joHyN6AVGfQvFoH2hyXfApQFUHV4Prn9fjZRvq7NLAVnGHyRSdxZg1NBzxP0jayoFpV/2FxbEEIMyHgv6oOoXt9EmU6WLOMXcwSOx39PqZRBEb6kGb2EtPgRitKjDLs7zjKvH3pxcVKNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904514; c=relaxed/simple;
	bh=mThJacwYj7x4dGqc6snoKIY+nh4eE837g2SnfYso0I4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJbWCBjGCxoJsN0pjyZlYM7ZW4us2ff9oMdRoinsixYgVEZSU8o1aH84mwABXobbOP1UE+RfZS6zCOtFHelbuShsftgSrjHsSbiCKDndFDx2+AVlOcoLBsfM8jD1IIZ5dxEHPp21fKDSmkdOeIwFJBL1OXi8ggZWjEykjknb5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OmieWMdi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OmieWMdi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=B/wBNwQaCeq2TBM3FIAVCw3ESEgLkc0pcW3fEr2wnuE=; b=OmieWMdiHFIjXDYIVFwYgrUXXh
	S14ZvRio4CXRu5TCkfthDYkR7oKIhR3rThRiFo68An8HSrajHm5zyG1Vx1EaSKt9rN1a1/cn6W9sC
	XaErSzaHCDbZ9AGhFWYMHanRSXxHdeQG7GOOzFD18tZdsWHqm+VPE8zMY4KMG7YejaZZoHQbXVn39
	K3pI0QKhoX8AwarwUm46hFWedJs6ob6a8sl8M2ZmtKH5HWmdPxR9T9vSiI+wXxZcS/qwcEhz3FIID
	BJ9rrm7S4pj8BqGkgCRTuROOIRk7hZUXCAwRW+Lx0RNTVMX8byYKMqCPkf3KYtr2DzZQhm3h8aKcZ
	7hreT+qw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raByx-0000000CSCB-0ZI5;
	Wed, 14 Feb 2024 09:55:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: drop bio mode from null_blk and convert it to atomic queue limits
Date: Wed, 14 Feb 2024 10:54:56 +0100
Message-Id: <20240214095501.1883819-1-hch@lst.de>
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

this series drops the obsolete bio mode from the null_blk driver and
then converts the driver to pass the queue limits to blk_mq_alloc_disk.

Diffstat:
 main.c     |  500 +++++++++++++++----------------------------------------------
 null_blk.h |   17 --
 trace.h    |    5 
 zoned.c    |   17 --
 4 files changed, 134 insertions(+), 405 deletions(-)
