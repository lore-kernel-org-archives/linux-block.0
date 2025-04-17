Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495411CAA92
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744872430; cv=none; b=pS7qLXkFHl044jL4n3cjVScbNYPBPb47CyN9HGlRKcote3xcCqCMblm8dcmX0sfM7V8yp7+FdecLeD8+Cr5lsnrHJnijYMbTX1rFbbQP+OF85kDaMp1eizln/eG2LZtpHKr8joysaD07lSHITJ/psrRVhNVR9LcV5bQD1ZCINaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744872430; c=relaxed/simple;
	bh=4nDhb/LCPWpR2I5n7aKSN44ieoq6cOwJgec0mMVY7ek=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q9gvP7WOquLB8JWskeUHmkImjQ91Y5xDU1Q6XXGjrzyb4j/e2vUuAmnr8LoKjdctyraRLXsgkoN2Au445Plhamb2b9vso3xHd8z3q3B0h9YZo750wAxdmoktkHgwPYtwOCYkyR0pQYSBDwCB1injUjnQa0goofzPQkaTpJKRyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VT0SCZsC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VT0SCZsC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=c9kni1jFYiyoXztyV0kzepCImzHwZJUkBjwKuQf090w=; b=VT0SCZsC8SoaANsZktGtOjMWaB
	JvBK3rfUfAB+EYhr/wlUbqwsmy2xKAzJ59EYV4YtCw7fdIXdUBwZ/a6TVRuOW9Zgi++yUKJQIBLJY
	/B8bspkpO/Qx1RNUBPE3Kx5/FnqNB5zzrLIFotw0xM+MboP1aAOdGx0hfD+ve/JAURwCnv8pW07pM
	aC7/mOQ/97clMEC6WusipGBBiMykGCecdB2eW5zdNYu9l02XrBpDbHRCKcfoqfiIMa0mS9+FUWW2A
	c0bI8pBRTA4WQgxJMQrhHbm8IzbIPzUs1xdM3fofd6A8PhPuxWJaFogkYyA7hNEH8kynYKCbxqVEh
	YMTE++fQ==;
Received: from 089144221046.atnat0030.highway.webapn.at ([89.144.221.46] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5J1e-0000000Bwpo-0SlH;
	Thu, 17 Apr 2025 06:47:06 +0000
Date: Thu, 17 Apr 2025 08:47:02 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aACj5pg7dLAsfZ1u@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 0b7a4817756c7906d0a8112c953ce88d7cd8d4c6:

  ublk: don't suggest CONFIG_BLK_DEV_UBLK=Y (2025-04-15 18:59:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-17

for you to fetch changes up to ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7:

  nvmet: pci-epf: cleanup link state management (2025-04-16 07:37:37 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix scan failure for non-ANA multipath controllers (Hannes Reinecke)
 - fix multipath sysfs links creation for some cases (Hannes Reinecke)
 - PCIe endpoint fixes (Damien Le Moal)
 - use NULL instead of 0 in the auth code (Damien Le Moal)

----------------------------------------------------------------
Damien Le Moal (4):
      nvmet: auth: use NULL to clear a pointer in nvmet_auth_sq_free()
      nvmet: pci-epf: always fully initialize completion entries
      nvmet: pci-epf: clear CC and CSTS when disabling the controller
      nvmet: pci-epf: cleanup link state management

Hannes Reinecke (2):
      nvme: fixup scan failure for non-ANA multipath controllers
      nvme-multipath: sysfs links may not be created for devices

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 14 +++----
 drivers/nvme/target/auth.c    |  2 +-
 drivers/nvme/target/pci-epf.c | 88 ++++++++++++++++++++++++++++---------------
 4 files changed, 67 insertions(+), 39 deletions(-)
