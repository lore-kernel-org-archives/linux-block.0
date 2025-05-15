Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7BB819
	for <linux-block@vger.kernel.org>; Thu, 15 May 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310171; cv=none; b=ANF99ZBA3ZZ9/Uw3LhyIsbETUdq8lSzadmM4JrEg1ho1ykIUG5e8HVKFvHfMI8EEngw/K1PKuOSBFmQllfgMP8vTghDZu0jLyPiBiprt+EfLWtVGvSI+8dpyxcIeKnjOxXW43WKazgDr0g8bTLr9uT2LaDryU8nPX2Cv1+x7r8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310171; c=relaxed/simple;
	bh=OJD4Aa6GFHWMbZ16oJn/bcQdBGZmEYpGK5GIdSwAIF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a1124t40fRubxRtxTb7pwxcvv5k0goXglzR+OWcmJM5lJYLQ2rM/wW6V1tbsqzoZf3Ol99KFQ5mvfr5HQQ/oloOT35LG66m6ktBfbdnOMFzGB4dw3rRHVK2Xs0rb3bLa/OSK8H0ssSFZ0F2+ChvSeH+v7Yc74TyqszUppgD97lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AamfIGt2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AamfIGt2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GMoJk3nIUzRLwu8Ju+e04/dNWPdEo2bfpzS7WTSeD3U=; b=AamfIGt22MPss9JX02xyOX7QsR
	kBBLoDy8WnTxFM8JnPOu6+V6dsS2K2L3IaR30nn9uYYf51mYQJblltJeP9MeyLEQ6ypfuYjNM4+ns
	OEiJxJ+k4Kij4GcfgFuGxEtw/XJIRCLg6g5zTcjJHbRz2Jbx5PGESGe5oPxijhCA0FxNVtK8qVV7e
	2GtV1o9qG9pk8+hMkK05hkfdahBmuG8asT0PZl16ZRqMj/Rhjf/aUzzVrpeecJl11DGZ4LD0W3Upg
	x+sl+9I9Llp5nnCeQcy13w4vef6CTC5tyDdbA4Kw4Lfn3BWyMsF5pvSu4jNs6IA5ngmNnM7KW575q
	NdJadqnQ==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXC3-00000000TMR-45rp;
	Thu, 15 May 2025 11:56:08 +0000
Date: Thu, 15 May 2025 13:56:05 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aCXWVQ0-cbSsQXFk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 8098514bd5ca98beca6ec725751d82d0d5b492d8:

  block: always allocate integrity buffer when required (2025-05-12 07:14:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-15

for you to fetch changes up to e765bf89f42b5c82132a556b630affeb82b2a21f:

  nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro (2025-05-14 17:16:16 +0200)

----------------------------------------------------------------
nvme fixes for linux 6.15

 - fixes for atomic writes (Alan Adamson)
 - fixes for polled CQs in nvmet-epf (Damien Le Moal)
 - fix for polled CQs in nvme-pci (Keith Busch)
 - fix compile on odd configs that need to be forced to inline
   (Kees Cook)
 - one more quirk (Ilya Guterman)

----------------------------------------------------------------
Alan Adamson (2):
      nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
      nvme: all namespaces in a subsystem must adhere to a common atomic write size

Damien Le Moal (5):
      nvmet: pci-epf: clear completion queue IRQ flag on delete
      nvmet: pci-epf: do not fall back to using INTX if not supported
      nvmet: pci-epf: cleanup nvmet_pci_epf_raise_irq()
      nvmet: pci-epf: improve debug message
      nvmet: pci-epf: remove NVMET_PCI_EPF_Q_IS_SQ

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Kees Cook (1):
      nvme-pci: make nvme_pci_npages_prp() __always_inline

Keith Busch (1):
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

 drivers/nvme/host/core.c      | 30 +++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  3 ++-
 drivers/nvme/host/pci.c       |  6 +++++-
 drivers/nvme/target/pci-epf.c | 39 +++++++++++++++++++++++----------------
 5 files changed, 59 insertions(+), 22 deletions(-)
