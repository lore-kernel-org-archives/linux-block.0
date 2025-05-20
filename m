Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071124EF88
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756943; cv=none; b=aijzy2meaKU9MQiCFQ1d2tIwqcRCNRtkH4VKkFqFwJ//xkgqmvqmF40pGvMeXzPLHUfCWRYus8HQwJgIhNwuK1uIo1eTZx6gFqcgYv1dTWtLlb5+0hJzfKlz2kMiAu8Xp0u8YRrX54a+HlxKJ9OxxSLbi1DAitEqikEdefN2kTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756943; c=relaxed/simple;
	bh=yQat2Vyi4Zfb1B/A6dGmgEV+mcncC0+F2mRf0v7tWLY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jC4vP3Ie7gii/IdLyY9Re66DZtLGo0la9ofch0qwPpbp6I524J+qmbOXK/gYl15deXYyQX8AdSNtwRgTlhiTtKGVPkdSD2ZyFXAqV1p3bI3OE1kcZvsrSBv3lnun9iTfA4VsQri0Y2znMCiUCmxxSl+hCsu4rQ1H21y5lrgzYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=octHarzD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="octHarzD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=B7gJftj33Q+f5gyhyPsRGbZTZbMOtVqd6ZE/JG57XvI=; b=octHarzDkx68gfFVhpFEo8+S4B
	epcIaxu6B0lI1MpDYRLI/W6Ol7CagjgiKsE+RP+yMl/GIxBC88cl7Dnp5pYQTts+Bgwb0dIIqswBU
	2VRrevoYrJmKCKgj9RKoWtj5v37LYMcHmUojpR997y7bVNbowE57aIjbbGmDptNBv7bwdSErd+YhM
	8gfcaLzzP+raF9iNsbsc6gOYjTYaGGOv6UQ4zYC/sbwv8vFGWpga6z7hOp2uR8qTHY9JrGW8bWrMX
	k/SNxLAvWHjspjhMZq34nnotD2xi2JjTgxlxocy5QHlhqANC7R97yZXbednmGyL4+3poRfftnWuBb
	4yu1VPOQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPQ4-0000000DRLj-07yR;
	Tue, 20 May 2025 16:02:20 +0000
Date: Tue, 20 May 2025 18:02:16 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org
Subject: [GIT PULL] nvme updates for Linux 6.16
Message-ID: <aCyniHQRl2HMjsvu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NOTE: this includes changes to mm/dmapool.c.  We've not managed to
get any replies from mm folks for it despite repeated pings.


The following changes since commit 496a3bc5e46c6485a50730ffbcbc92fc53120425:

  blk-mq: add a copyright notice to blk-mq-dma.c (2025-05-16 08:43:41 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-05-20

for you to fetch changes up to 9e221d8cf90b8599a6a3d62a1ebb712468f42a35:

  nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk (2025-05-20 05:34:52 +0200)

----------------------------------------------------------------
nvme updates for Linux 6.16

 - add per-node DMA pools and use them for PRP/SGL allocations
   (Caleb Sander Mateos, Keith Busch)
 - nvme-fcloop refcounting fixes (Daniel Wagner)
 - support delayed removal of the multipath node and optionally support
   the multipath node for private namespaces (Nilay Shroff)
 - support shared CQs in the PCI endpoint target code (Wilfred Mallawa)
 - support admin-queue only authentication (Hannes Reinecke)
 - use the crc32c library instead of the crypto API (Eric Biggers)
 - misc cleanups (Christoph Hellwig, Marcelo Moreira, Hannes Reinecke,
   Leon Romanovsky, Gustavo A. R. Silva)

----------------------------------------------------------------
Caleb Sander Mateos (2):
      nvme-pci: factor out a nvme_init_hctx_common() helper
      nvme-pci: make PRP list DMA pools per-NUMA-node

Christoph Hellwig (6):
      nvme-pci: don't try to use SGLs for metadata on the admin queue
      nvme-pci: remove struct nvme_descriptor
      nvme-pci: rename the descriptor pools
      nvme-pci: use a better encoding for small prp pool allocations
      nvme-pci: use struct_size for allocation struct nvme_dev
      nvme-pci: derive and better document max segments limits

Daniel Wagner (14):
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: refactor fcloop_nport_alloc and track lport
      nvmet-fcloop: refactor fcloop_delete_local_port
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: access fcpreq only when holding reqlock
      nvmet-fcloop: prevent double port deletion
      nvmet-fcloop: allocate/free fcloop_lsreq directly
      nvmet-fcloop: drop response if targetport is gone
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: take tgtport refs for portentry
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fcloop: don't wait for lport cleanup
      nvme-fc: do not reference lsrsp after failure

Eric Biggers (1):
      nvmet-tcp: switch to using the crc32c library

Gustavo A. R. Silva (1):
      nvme-loop: avoid -Wflex-array-member-not-at-end warning

Hannes Reinecke (6):
      nvme-tcp: remove redundant check to ctrl->opts
      nvme-tcp: open-code nvme_tcp_queue_request() for R2T
      nvme-auth: do not re-authenticate queues with no prior authentication
      nvmet-auth: authenticate on admin queue only
      nvme-auth: use SHASH_DESC_ON_STACK
      nvmet-auth: use SHASH_DESC_ON_STACK

Keith Busch (1):
      dmapool: add NUMA affinity support

Leon Romanovsky (2):
      nvme-pci: store aborted state in flags variable
      nvme-pci: add a symolic name for the small pool size

Marcelo Moreira (1):
      nvmet: replace strncpy with strscpy

Nilay Shroff (3):
      nvme-multipath: introduce delayed removal of the multipath head node
      nvme: introduce multipath_always_on module param
      nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk

Wilfred Mallawa (5):
      nvmet: add a helper function for cqid checking
      nvmet: cq: prepare for completion queue sharing
      nvmet: fabrics: add CQ init and destroy
      nvmet: support completion queue sharing
      nvmet: simplify the nvmet_req_init() interface

 drivers/nvme/common/auth.c        |  15 +-
 drivers/nvme/host/auth.c          |  30 ++-
 drivers/nvme/host/core.c          |  12 +-
 drivers/nvme/host/fc.c            |  13 +-
 drivers/nvme/host/multipath.c     | 206 ++++++++++++++++--
 drivers/nvme/host/nvme.h          |  24 ++-
 drivers/nvme/host/pci.c           | 300 ++++++++++++++------------
 drivers/nvme/host/sysfs.c         |   7 +
 drivers/nvme/host/tcp.c           |  14 +-
 drivers/nvme/target/admin-cmd.c   |  31 +--
 drivers/nvme/target/auth.c        |  21 +-
 drivers/nvme/target/core.c        |  94 ++++++--
 drivers/nvme/target/discovery.c   |   2 +-
 drivers/nvme/target/fabrics-cmd.c |  12 +-
 drivers/nvme/target/fc.c          |  96 +++++++--
 drivers/nvme/target/fcloop.c      | 439 ++++++++++++++++++++++++--------------
 drivers/nvme/target/loop.c        |  29 ++-
 drivers/nvme/target/nvmet.h       |  24 ++-
 drivers/nvme/target/pci-epf.c     |  14 +-
 drivers/nvme/target/rdma.c        |   8 +-
 drivers/nvme/target/tcp.c         | 100 +++------
 include/linux/dmapool.h           |  21 +-
 mm/dmapool.c                      |  15 +-
 23 files changed, 1001 insertions(+), 526 deletions(-)
