Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0F420B22
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749116058; cv=none; b=KLaW9zff7qA2wTPgeNNs74RWzVD97f0IK177Lw3kVqIwH9Kuq7oNrLQWfiy3xiMgRIiz4tDuqOPUVkHIIN9HspKTuPXF+4l2qrHnGZIyPwy1OIMTLjg55u9JeUrzbS0W6iAt/B7yINrV8SD1FreGm2ZtVHku6mkkVzi3fDXv934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749116058; c=relaxed/simple;
	bh=PsezYQqnGZoCIrLbHoRluasIn+pJG02q9/vya2GGpRk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=prRQwb8GYHpbhl/m3bohzy6S6vn9Ad9n8722wipFXpQ22ASB5FsvH7xJpeT6afojNd0O9nwU4ZS1S/7R1fYFWaW/ZV6GGPBnoR+z1Ev4xTOP9QWm6xcoNm3gIC62JanJkBpnX7j7n0zDgY6N92OhY7Nkz8OtU6tbneK7AcpKT1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NoaQNsWZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NoaQNsWZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=YYjeuCcthxQp2Rj4IBlNgZmfsGf7h2Z1vLxzsw/HV+g=; b=NoaQNsWZHBEuxBsTqxraF0YEDf
	OsDlBEDDOGLbDuGK8hUOd5NEUVQrxsvuQmgpYE6tmViyMGE8mO66QkOfVzaiphrJQShcQPuousrRV
	cow7WWy0nbPRccZRDekNzdOvHt9+COarFwh9mY9mxw8y/zzSF4hXPpudN3nOPnPSdJu9tPI6fEyhP
	xS9uwMfPlvQ9gUm4YyrlPQrAOyqQUx04lRZ5N06GJvvXpF0eIQjq58KcQm/l1byNTAgTrMOOPZnvs
	ZJ7TScDni9JX42lJy5vbv5neWWrHhqpk5L2apyqAINrR3+2LCydmwuDMwVkfroBitgPoLr6lK6/Ji
	JbUGLreQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6zD-0000000FAWy-0DwF;
	Thu, 05 Jun 2025 09:34:11 +0000
Date: Thu, 5 Jun 2025 11:34:07 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aEFkj8jfrDVGuG4_@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit a2f4c1ae163b815dc81e3cab97c3149fdc6639e3:

  selftests: ublk: kublk: improve behavior on init failure (2025-06-03 20:19:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-06-05

for you to fetch changes up to 44e479d7202070c3bc7f084a4951ee8689769f71:

  nvme: spelling fixes (2025-06-04 10:23:28 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.16

 - TCP error handling fix (Shin'ichiro Kawasaki)
 - TCP I/O stall handling fixes (Hannes Reinecke)
 - fix command limits status code (Keith Busch)
 - support vectored buffers also for passthrough (Pavel Begunkov)
 - spelling fixes (Yi Zhang)

----------------------------------------------------------------
Hannes Reinecke (2):
      nvme-tcp: sanitize request list handling
      nvme-tcp: fix I/O stalls on congested sockets

Keith Busch (1):
      nvme: fix command limits status code

Pavel Begunkov (2):
      nvme: fix implicit bool to flags conversion
      nvme: enable vectored registered bufs for passthrough cmds

Shin'ichiro Kawasaki (1):
      nvme-tcp: remove tag set when second admin queue config fails

Yi Zhang (1):
      nvme: spelling fixes

 drivers/nvme/common/auth.c        |  6 +++---
 drivers/nvme/host/Kconfig         |  2 +-
 drivers/nvme/host/constants.c     |  2 +-
 drivers/nvme/host/core.c          |  3 +--
 drivers/nvme/host/fabrics.c       |  2 +-
 drivers/nvme/host/fabrics.h       |  6 +++---
 drivers/nvme/host/fc.c            |  4 ++--
 drivers/nvme/host/ioctl.c         | 18 ++++++++++--------
 drivers/nvme/host/multipath.c     |  2 +-
 drivers/nvme/host/nvme.h          |  2 +-
 drivers/nvme/host/pci.c           |  4 ++--
 drivers/nvme/host/pr.c            |  2 --
 drivers/nvme/host/rdma.c          |  4 ++--
 drivers/nvme/host/tcp.c           | 24 +++++++++++++++++++++---
 drivers/nvme/target/admin-cmd.c   |  2 +-
 drivers/nvme/target/core.c        | 11 ++---------
 drivers/nvme/target/fc.c          |  2 +-
 drivers/nvme/target/io-cmd-bdev.c | 11 ++---------
 drivers/nvme/target/passthru.c    |  2 +-
 include/linux/nvme.h              |  2 +-
 20 files changed, 57 insertions(+), 54 deletions(-)
