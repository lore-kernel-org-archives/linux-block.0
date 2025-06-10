Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB725D1F5
	for <linux-block@vger.kernel.org>; Tue, 10 Jun 2025 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749532046; cv=none; b=E3edU5C/KtABazUHbugVEtO7yIaVSGDm66WQdyE8NnV73Wme5fWXPIAA++G2veoVgjB/pct+6U7WRoaTN4AGYLPg4qrYiFzJvOQ0fKGH5vPGAAVhwt+uRgp24bfqsZGe8A5PGbT/MlLkPoG3eNcgBvnTVlkCFB64BQWQXoKIe+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749532046; c=relaxed/simple;
	bh=+4oMHWzkfNkh28O+tArBX25C5ib8mLSa2DDH8Ni+dLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UDOtsRWoN+xmxmo15ePz94Hk+1gLOUt+WHCEp/6WxyjDe88lf/ZH1Z3C/ODXJwk4Pn0vK2rrn/TkaWmsHG31QbmKPUfGQW2oYOr/Nkow+4LtfwdUL5atrsOgo1BJLNWcLT2n+6rLK7HCU2AWyEE6yQqhr0cUD/H5sAueB8C4IT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Urw7w+PN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Urw7w+PN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WMnK/6ynhLT+c63+86ZArPvsHQRCDzd84muxxrMS1W8=; b=Urw7w+PNd5yIG+lCbAKItUlLE5
	ayyyG91fHsmXdQjnjoFVytB7nMMSALhjBEIgJz8m8rRpuEdGXtAZr9OqAgDfufGkqGEF0dWN65le8
	BWVtf316x10an/0GRerly1fJ1W0LiatPTIbHFpmFzn3wJdtekooTSeYEBuFtS5m6Z3WVML3Tdkt8T
	cmezmve+ItfQnNrg4sH6/pT1xm1UgNCNnWePwKJR14IvmQxYXK9oywSfrVis4JrQwvfYdsvykWyYJ
	MiHRJ9UvaInSTXtfGuRHp2mNudbSGZLGAR3lUIvA5OVzgWoopsvDg9/tfCdFKXWLNHZaVFkZPdXxW
	cUCaovEA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCf-00000005ndo-0la8;
	Tue, 10 Jun 2025 05:07:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: new DMA API conversion for nvme-pci
Date: Tue, 10 Jun 2025 07:06:38 +0200
Message-ID: <20250610050713.2046316-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series converts the nvme-pci driver to the new IOVA-based DMA API
for the data path.  Note that I've dropped the the Tested-by: and
Reviewed-by: tags from the version Leon sent out with the DMA API as
there's been quite extensive changes.

Diffstat:
 block/bio-integrity.c      |    3 
 block/bio.c                |   20 -
 block/blk-mq-dma.c         |  162 +++++++++++
 drivers/nvme/host/pci.c    |  615 +++++++++++++++++++++++++--------------------
 include/linux/blk-mq-dma.h |   63 ++++
 include/linux/blk_types.h  |    2 
 6 files changed, 596 insertions(+), 269 deletions(-)
