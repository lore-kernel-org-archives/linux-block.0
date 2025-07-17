Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290729A9FE
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752223; cv=none; b=PQM1jncuAB4h0JOg2l1OoBps0iQiNQacuK6yDNXp0GcrtyHyFHvYv8057tMHAeodnuwpLFKFNIXiXI1Vdchrnbce+vjE23jdBRznAoNOaRMUfViWbTCweauk93iFnrBpRdYB5kWKjLchfgkl8j+N+fM/YRVr2w6dIxyNwFC40vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752223; c=relaxed/simple;
	bh=9J1Ew4TZsghQQfy890MfkF8wAm2MwJv2s26WVEL+A6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rZULW2igZ/FHNvhQm3//lTSmGYeY1i8qyD190Hqb2k1yMUJfqgSA+tpm16ueMvc1SehVCFOMsv6Hz8CvWJCi1VUeP58FCchP4NIJmccyuVS/7i2eeuS/bvNdfGd5fzdYx4O+r/3+bQArDvL8RyroeQ+opXdPjZfk5cKMSFIzCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fyYBzgdm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fyYBzgdm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=LiMX4zXZm5inHHY6IvtGUw3iKra4Hn1K3aeA1DUKkgU=; b=fyYBzgdmWP+gij/+3SwyJQZhdC
	GxpmrK1TwhOlEno2NlvA3xzDRZQIOMehfMZ+aLGXMHrISoeLJZX+lrwVx2fKV17T00OVjWX8rLLgK
	RdZ9cD49rmhMNJttdH52gally+EVzEbNLK6jj8cQ7glYWon0LlFjwt1q7kopS8v1LBMPh9UTAfDY9
	AvPhQXIpRcD5IxO4rHqcwVCg5kEFCE1lCGOJ9hgkr7NbAeiYdkpjCIK/CVVMOSWs3HVs5KCH67U68
	E1tyDRU8MEaavu4OXGY6jo/X5J+zbA74JJlpFROF0pOYKHb+2w08zgg4WP8gfGdVSvB4i65r51zM4
	q3GqSkEw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMv5-00000009zfq-3x5k;
	Thu, 17 Jul 2025 11:37:00 +0000
Date: Thu, 17 Jul 2025 13:36:56 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.16
Message-ID: <aHjgWKyuasbJrqg6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 3051247e4faa32a3d90c762a243c2c62dde310db:

  block: fix kobject leak in blk_unregister_queue (2025-07-11 20:39:23 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-17

for you to fetch changes up to 0523c6cc87e558c50ff4489c87c54c55068b1169:

  nvmet-tcp: fix callback lock for TLS handshake (2025-07-15 09:49:13 +0200)

----------------------------------------------------------------
nvme-fix for Linux 6.16

 - revert the cross-controller atomic write size validation that caused
   regressions (Christoph Hellwig)
 - fix endianness of command word prints in nvme_log_err_passthru()
   (John Garry)
 - fix callback lock for TLS handshake (Maurizio Lombardi)
 - fix misaccounting of nvme-mpath inflight I/O (Yu Kuai)
 - fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()
   (Zheng Qixing)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: revert the cross-controller atomic write size validation

John Garry (1):
      nvme: fix endianness of command word prints in nvme_log_err_passthru()

Maurizio Lombardi (1):
      nvmet-tcp: fix callback lock for TLS handshake

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Zheng Qixing (1):
      nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()

 drivers/nvme/host/core.c  | 27 +++++++++++----------------
 drivers/nvme/target/tcp.c |  4 ++--
 2 files changed, 13 insertions(+), 18 deletions(-)
