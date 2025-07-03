Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E2E2D77F2
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543503; cv=none; b=VRog9KlBQJ2ieFRhtQn56ITr0Z+xfgjdVzO2o/EHsO+Iov2hyXJAYOU5l2C84D1fOzLCPgOJ59bMJ0PqDe6N+V6uVXx+aSWnKEF0g7n3ymudilFJ9z0fLMjpcKB7ZbwNW+Dd+0DI5OWnl5+VibZ1qpz93423qkyQ70+QRTkCpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543503; c=relaxed/simple;
	bh=h60KY1LPsYKjnmqvpLB9DeO2tZzHh/UgtTWQJPV8B30=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lbembiowVwynOGflnheiTyCzTbI+ie8NSfD+c7SlMtzxpG8htZpviBKMg32B1PEf6iq3ZWzTP5cWTFKAygLmx+ep4nPw8jzvvVNuLEyxPYibdUgZOgShnUhX3LoEn3aUvlVQnSKFJLwoVqt29t3TMPUMLNQzGUY8GLumj+O5hsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qXVbwdJs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qXVbwdJs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=mrnEFAQtqxLZGcbjaYw141JliT60nsKNTrMACRJgZbA=; b=qXVbwdJsjS/VslyxCZ4ZzAL0hi
	YsABqq3sU4oV6JV8OXfy/771uAxt9ePjM15vpTutTDc0PHEFiYbP6Q8DiHos+v4ewnIAe6p072Q+m
	KWbObytr0pslETF5A9LaRm1OzbtgIR+bOXbAp+ZCtHm0TLccuLbDr9QnpgbUMI5V4tOCOGUL5NC2W
	miGdegeyODLG/GF71Qm4qo48jX1Zo5ydRghw5BDf7d14L/Ypdg3ub6NQkQnmcKxOPznSXNURATeGI
	lTOMNGDlhAjBEpSsMt7pdKbjO55RkQN4/Er6isYTiJAZT1kzPG+ZfYEimAvtQ8oq5s4jHrseF+LbZ
	5+272wPA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXITc-0000000BDvY-1OWm;
	Thu, 03 Jul 2025 11:51:40 +0000
Date: Thu, 3 Jul 2025 13:51:36 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.16
Message-ID: <aGZuyPbzY__Rb8Kz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit c007062188d8e402c294117db53a24b2bed2b83f:

  block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-03

for you to fetch changes up to d6811074203b13f715ce2480ac64c5b1c773f2a5:

  nvme-multipath: fix suspicious RCU usage warning (2025-07-01 08:17:02 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.16

 - fix incorrect cdw15 value in passthru error logging (Alok Tiwari)
 - fix memory leak of bio integrity in nvmet (Dmitry Bogdanov)
 - refresh visible attrs after being checked (Eugen Hristev)
 - fix suspicious RCU usage warning in the multipath code (Geliang Tang)
 - correctly account for namespace head reference counter (Nilay Shroff)

----------------------------------------------------------------
Alok Tiwari (1):
      nvme: Fix incorrect cdw15 value in passthru error logging

Dmitry Bogdanov (1):
      nvmet: fix memory leak of bio integrity

Eugen Hristev (1):
      nvme-pci: refresh visible attrs after being checked

Geliang Tang (1):
      nvme-multipath: fix suspicious RCU usage warning

Nilay Shroff (1):
      nvme: correctly account for namespace head reference counter

 drivers/nvme/host/core.c      | 18 ++++++++++++++++--
 drivers/nvme/host/multipath.c |  8 ++++++--
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/target/nvmet.h   |  2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)
