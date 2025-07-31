Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1E2C1592
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 14:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970904; cv=none; b=svFLMEMZIiCfiD+nO7iz/evsNMqz2m1TAZGsb+Khi21pe5hnl1TnkCZYPPA+jB1+CgKwTLFvSvrMHetGAjQjql50YKLMZmX/Iw879k4IbRF9eQQiZVeMDbCVzRDzW5Kzf07cnbyuHqpLxrXhOGoim3hPNlcF/hxpZoUB9vhEzts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970904; c=relaxed/simple;
	bh=OEHPPjiGEsMqahSRNCAHmuvR2pPqEEkPwx0k2Ct/cuU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ddsIv2+j6XUArHeDVLaeJ+fGJcb0+5+9Gdt5GUqWAwbUEGGuTKVBNs8ITM0xBqxvxqmGy7b8tSWgI13go47gmY8RbROwOiaetxak5Vcjcve08bCRcY8g4EKRFTZKFkiQeWicbIjSoNsdfcNivoPT4dgc2ZfV/LEb8dHy1H2c/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j3by1ajH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j3by1ajH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=1idUh1jegaXThllqHigBe7SBw8P3SMuWB+tbTiKiD84=; b=j3by1ajHehonVMDKAutOkqiNlW
	8WLkCTD0r77qat4pVCXggk62fufeKLUC2QLKASETtLYYB9O7P6yz8JOgGz1SRW1hIHx7sJgIIYRSb
	PSZyrjkZ+M0ksYALAagtc6dwsuv0JpqMTM/EesPyYmyncrHl4R90NCN9Y46lb1PW4fY7d1QA/J+qw
	oM1BOl3paIAhuZQjAdWePAanaSDGGPSgvrtoR2qYsh2V9J6jaSMIFfE4nNLvoCk3lQdabYvHW95AZ
	U3B1yogoZC71sl8fW0AYVcyPRGck2u4rlsXAxPdjfZ2P2Ex93QI+UJ7GbjKxHeWyofNyVFxDE6hRp
	aSHb/EUA==;
Received: from c-76-102-242-2.hsd1.ca.comcast.net ([76.102.242.2] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhTxD-00000003mgg-1oiG;
	Thu, 31 Jul 2025 14:08:19 +0000
Date: Thu, 31 Jul 2025 07:08:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.17
Message-ID: <aIt40gBo9MuyC9Y2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:

  blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-31

for you to fetch changes up to 367c240b0a99c7ada700a44345dd3144a02b6164:

  nvme: fix various comment typos (2025-07-31 06:35:58 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.17

 - add support for getting the FDP featuee in fabrics passthru path
   (Nitesh Shetty)
 - add capability to connect to an administrative controller
   (Kamaljit Singh)
 - fix a leak on sgl setup error (Keith Busch)
 - initialize discovery subsys after debugfs is initialized
   (Mohamed Khalfella)
 - fix various comment typos (Bjorn Helgaas)
 - remove unneeded semicolons (Jiapeng Chong)

----------------------------------------------------------------
Bjorn Helgaas (1):
      nvme: fix various comment typos

Jiapeng Chong (1):
      nvme-auth: remove unneeded semicolon

Kamaljit Singh (1):
      nvme: add capability to connect to an administrative controller

Keith Busch (1):
      nvme-pci: fix leak on sgl setup error

Mohamed Khalfella (1):
      nvmet: initialize discovery subsys after debugfs is initialized

Nitesh Shetty (1):
      nvmet: add support for FDP in fabrics passthru path

 drivers/nvme/host/auth.c       |  4 ++--
 drivers/nvme/host/core.c       | 16 ++++++++++++++++
 drivers/nvme/host/fc.c         |  4 ++--
 drivers/nvme/host/pci.c        |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/core.c     | 12 ++++++------
 drivers/nvme/target/fc.c       |  6 +++---
 drivers/nvme/target/passthru.c |  2 ++
 drivers/nvme/target/rdma.c     |  6 +++---
 9 files changed, 36 insertions(+), 18 deletions(-)
