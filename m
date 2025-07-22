Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F7288CAC
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164302; cv=none; b=QpJv+o9zlM933O0/55udrudOvxCV/Ww/5L7ek/o4or1ONZOFPx7vOeThFYpINtNiU+cev/uSnWfvchNxlK3uNB4z/XFozVQ0VdEdWvsHDizm6rakCbxZpgi3gw61ioAu8v3B8B6kCXz+rawWvAJNEfyBYSMAclwloGe3Uzb03t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164302; c=relaxed/simple;
	bh=8rH0nxwzxW86iWVv9SDWF6qc3/R11FUo8jvfRqjBGG0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lerPr5ZnzW87iJA7CjSyPtlYESBOng+Hh0JPIAYStkRuxeH/gBmZyFIXqW+SXEZORMuzO0eeaaToeMkTnpHNbFbL31mEEwycBUt2v7e32HlTbVE2qpKxN653Y0n90WwgkaUFyjUITL9vA4t0RNDE6deBMurYoxQWYG3wxeH4l0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yAJij+vx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yAJij+vx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=L8O+JavWYdIu/uRuDiGUA+k1UuTdTqMRcqDi9Y6C2Kc=; b=yAJij+vxPO7yoo7G4kOxEGZh+y
	CRpZH7tQ60jMkB3LRVg7wn+fg+5kRlPaP4cSRPJvCPIsr/DjMXRYouEOVDaGw///8NAEGolmFgv+N
	6BmduRQYGwYf73xchXCwQD2Q0t08vlHcvRN8bTE+H40hjw9GUg6oHa2nRNh1Ioxs6aY1PCPJ0adl5
	bMC6x8UzviEmvKhARojS0tdzYphTZ83J9FGKhLGae1kk09V1CG9RD9ZN3GcHsPPuDwVI9gAkWrD1r
	zLTOHgGSd+xyIe5ZXi1ElsMp/o1DszCZ8SEQJJ79TOflBoMOWSlYdVFI2TJLha2P3hwAvaL/dxBVG
	vK3gduxQ==;
Received: from [81.144.254.34] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue67X-00000001OKp-1szm;
	Tue, 22 Jul 2025 06:04:59 +0000
Date: Tue, 22 Jul 2025 07:04:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.17
Message-ID: <aH8qCeSvpt3eH5g_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit ab17ead0e0ee8650cd1cf4e481b1ed0ee9731956:

  block: fix blk_zone_append_update_request_bio() kernel-doc (2025-07-16 10:02:18 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-22

for you to fetch changes up to 5b2c214a95942f7997d1916a4c44017becbc3cac:

  nvme-pci: try function level reset on init failure (2025-07-17 17:46:33 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.17

 - try PCIe function level reset on init failure (Keith Busch)
 - log TLS handshake failures at error level (Maurizio Lombardi)
 - pci-epf: do not complete commands twice if nvmet_req_init() fails
   (Rick Wertenbroek)
 - misc cleanups (Alok Tiwari)

----------------------------------------------------------------
Alok Tiwari (5):
      nvme: fix multiple spelling and grammar issues in host drivers
      nvme: fix incorrect variable in io cqes error message
      nvmet: remove redundant assignment of error code in nvmet_ns_enable()
      nvme: fix typo in status code constant for self-test in progress
      docs: nvme: fix grammar in nvme-pci-endpoint-target.rst

Keith Busch (1):
      nvme-pci: try function level reset on init failure

Maurizio Lombardi (1):
      nvme-tcp: log TLS handshake failures at error level

Rick Wertenbroek (1):
      nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails

 Documentation/nvme/nvme-pci-endpoint-target.rst | 22 ++++++++++-----------
 drivers/nvme/host/apple.c                       |  4 ++--
 drivers/nvme/host/constants.c                   |  4 ++--
 drivers/nvme/host/core.c                        |  2 +-
 drivers/nvme/host/fc.c                          | 10 +++++-----
 drivers/nvme/host/nvme.h                        |  2 +-
 drivers/nvme/host/pci.c                         | 26 ++++++++++++++++++++++---
 drivers/nvme/host/rdma.c                        |  2 +-
 drivers/nvme/host/tcp.c                         | 11 ++++++++---
 drivers/nvme/target/core.c                      |  2 --
 drivers/nvme/target/passthru.c                  |  4 ++--
 drivers/nvme/target/pci-epf.c                   | 25 ++++++++++++++++--------
 drivers/nvme/target/zns.c                       |  2 +-
 include/linux/nvme.h                            |  2 +-
 14 files changed, 75 insertions(+), 43 deletions(-)
