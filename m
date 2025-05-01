Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925392AF04
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106406; cv=none; b=oV2fa8DCLAtk2XqQtUjqxFScCfMBzcE1/J1SKtQpfFdzc16gPZSY94fXWdWvGjd65/aNbBBtzrl44Hc4GxdULcpUK4/YT1Fb8Pc463URIEqfJojnLReqvmvzRYhAp9agmZy1KLyPCBF4Y8rmIfhYZrYrBDFNtNeTSaGga+QoLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106406; c=relaxed/simple;
	bh=URmeTrG+Cmrkzm89LRTSKtuLRr2LMcd7NxywMSFhlOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F9jvt4itnb3vQz1NdHvGSqZ62b+LmeSeF+Z7FhhsoRfJ6JjX6Q84lq83y+0Uc2/Dm39dR7EpbCdH1Kuc/9KpT9XREUyivDWTM1d9mAyuzLycb0/rPrqsOhJoer0h9V9zgiJfYT/WdfxSy2woiHMOkAYw/v8xQCcPOQUeoZlnCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A3YFREao; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A3YFREao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=f/rYEcwn8rWojhSbupuGw1x9rDfspVAzKTDyTUlJoUM=; b=A3YFREaoyhM8cY3+K/ZmQhm/Og
	X1DnHGzcCVeEO9f6mNhfYMJoEWKLjWQlDkavYnL1EsYESVA6N0gARBb9DxVOjka5ymsPlkPQj6Ybv
	a9wocU2Ea6o0DZNmwGeZirWMg+6bFHVHbVIyQ/7UKEP2fWXvdlfU4mtzbV0hY/QYspd7F2LOJjdD2
	ST6PdkNo2gNEAAS0y6W4WQd1rd/vBV9hY87NcB4vM9cRvv+Xzl6EmlcvKxJoLMoeXubKqw89ch6nH
	XFygBE6o+SxMuinKhLcLlgK4rJL2QfHR8D5l0Of9WkwUegTrNcoX0GDzbQZggPi+0i3LN/Ntrti1f
	1SXdrkjA==;
Received: from [104.254.106.146] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAU2U-0000000FpkN-40tc;
	Thu, 01 May 2025 13:33:23 +0000
Date: Thu, 1 May 2025 08:33:21 -0500
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aBN4IW2wlSfRIfjU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit a584b2630b0d31f8a20e4ccb4de370b160177b8a:

  ublk: remove the check of ublk_need_req_ref() from __ublk_check_and_get_req (2025-04-29 06:01:36 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-01

for you to fetch changes up to 8edb86b2ed1d63cc400aecae8eb8c8114837171a:

  nvmet-auth: always free derived key data (2025-04-30 08:09:09 -0500)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix queue unquiesce check on PCI slot_reset (Keith Busch)
 - fix premature queue removal and I/O failover in nvme-tcp
   (Michael Liang)
 - don't restore null sk_state_change (Alistair Francis)
 - select CONFIG_TLS where needed (Alistair Francis)
 - always free derived key data (Hannes Reinecke)
 - more quirks (Wentao Guan)

----------------------------------------------------------------
Alistair Francis (3):
      nvme-tcp: select CONFIG_TLS from CONFIG_NVME_TCP_TLS
      nvmet-tcp: select CONFIG_TLS from CONFIG_NVME_TARGET_TCP_TLS
      nvmet-tcp: don't restore null sk_state_change

Hannes Reinecke (1):
      nvmet-auth: always free derived key data

Keith Busch (1):
      nvme-pci: fix queue unquiesce check on slot_reset

Michael Liang (1):
      nvme-tcp: fix premature queue removal and I/O failover

Wentao Guan (2):
      nvme-pci: add quirks for device 126f:1001
      nvme-pci: add quirks for WDC Blue SN550 15b7:5009

 drivers/nvme/host/Kconfig   |  1 +
 drivers/nvme/host/pci.c     |  8 +++++++-
 drivers/nvme/host/tcp.c     | 31 +++++++++++++++++++++++++++++--
 drivers/nvme/target/Kconfig |  1 +
 drivers/nvme/target/auth.c  |  3 +--
 drivers/nvme/target/tcp.c   |  3 +++
 6 files changed, 42 insertions(+), 5 deletions(-)
