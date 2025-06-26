Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EDB21171B
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936056; cv=none; b=UjFBj8spAahW6IeF+2+li6hxJ2QJBvn4ts47+DfqAezjv3wNBo2aWNksYvywrO/t0tLyVpJcqIytFik5E/xOkGvFBowtcP1hSVWo35qOnp6pYeJmbBZKdJ5bs+y2DGZOvr4v5rbSV13rQqDne6AlsqiQhN9Q6rAH9B63fazEXBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936056; c=relaxed/simple;
	bh=PlSWdtINn5Rkn11NMtAeBfh+Nf+R0k/laxu9jK1xtkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WT7Wkwpda5IOf7QEgX6Wu6pIb1hOZxy+YE2bDckcUeIsT3MoSIC9lwvRRNRS7yaWlUyHkUb1ieDq1tu3qQONOlLLjTHXw32+X4oY9xj5j0fg8Uu0+Dmr0TA6giUqOFzHRZuxCWvk4KF8+Z0KmfboV9aZEKFAkgWhgNX/tibYix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=urX3/lvv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urX3/lvv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LcZ98PyYXyygH9Qq0vaX6U6tOe0SgfK12YNTq+HbDHc=; b=urX3/lvv3KM1kUy6EQ8OqBwtED
	SXmmZgjg4qHlyZrkyo/12Ta2tmW2ZHdGM+ColI8uoy4+EdqWIBchNYOTdZ5gmFNeyKihpsm++7qDx
	ubPyUlSHSyDi5GtYQQ4yIO7Fr+C4FV5Swl5luk1kODnh5fKCgu43zjuBaOyF6HGmlvLS5Ac87bPeP
	C3EE2N22d2Vxkw7zeskKJDudZW1EvBAuKhP4BSgnecukoGeRz+44HE8yVbXkwy5J6eCT/VyC76qZV
	jJTTgYokrg2Es6lpDNoiDVczkyPaOHEr+GLcgsWLNMxwTWZ5br982c1u+EDM2t3V1UhCQAROBGLsQ
	0O58Kjww==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUkS5-0000000BMEH-2A7N;
	Thu, 26 Jun 2025 11:07:34 +0000
Date: Thu, 26 Jun 2025 13:07:28 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aF0p8PlTkmFvfDeW@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[note that the commit dates are very recent.  That is because somehow the
tree the ran through the build bot had me as the author for the commit
from Keith, so I did a metadata only rebase just now to fix that]

The following changes since commit dd2c18548964ae7ad48d208a765d909cd35448a1:

  nvme: reset delayed remove_work after reconnect (2025-06-26 13:04:35 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-26

for you to fetch changes up to f46d273449ba65afd53f3dd8fe0182c9df877e08:

  nvme: fix atomic write size validation (2025-06-26 13:04:37 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.16

 - reset delayed remove_work after reconnect (Keith Busch)
 - fix atomic write size validation (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: refactor the atomic write unit detection
      nvme: fix atomic write size validation

 drivers/nvme/host/core.c | 83 ++++++++++++++++++++++--------------------------
 drivers/nvme/host/nvme.h |  3 +-
 2 files changed, 39 insertions(+), 47 deletions(-)
