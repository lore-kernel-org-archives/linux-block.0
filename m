Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21F40BE6;
	Mon, 22 Jan 2024 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945025; cv=none; b=fUtGpb+9SW7hqkJ3IZ2/rE2IrpFYZO8ZCjt+GQJXN9wznkXl7f+RWcarTcU8U62YMAKSoq4s247mKr3EsPPBmLQjiDND164dkO+HvjwCZxva7sqdpDuFr+TPewqB2fducf7j9su27Vyn0ai7LtTxQ3X1wa7eehf4+KTnccEzgTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945025; c=relaxed/simple;
	bh=Eya6PEjNjunP1OTqi5RkPciJWlhoayB8OZEByeuS8hU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6wyDv98plhWKyd6kwGAidBnGjSjS0qj+vt0apyJn1+egXa9X3j47HQpAVQWnuJZAiu2eGruyGZpf0Od2TZd8ymvU496Yu2K+Gzigo+0JwiX2kx5qYg4M4hL4kjD88tPT2S0URRU30XBWRKs5/t1/XPLJ7wMsMg08deJY920iYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QjGpB3vP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjGpB3vP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=t9HRa5vgjKuUC52SaApgPp71CS5FhNEd43Ov+g8RmyM=; b=QjGpB3vPTtWQcCV8peKW5YpWfa
	+ro4pRL7QJ5gWv+PYk/XXoVGVxkEw3cTyx08OEj6jeCGFtNqJCzyfSGdLPaMso5I0YRprwpSdcHck
	YsbbFuNLBugnHy9uSsy2no7RERzx6M51VFTlFDjQmzMX8/NK1Z5qLOBFQ3aHqAdv6M7rEOyytrSay
	EYjI253QxquXcfUii8X2Q0WCgBs/4l+oYuCbT/JL4ZLq9Aime2ycMpxj78+ktCuTOgXsnfimgcgiT
	oGfB5EJUjY6Qjg7/A2H6yv0zUdixxA40UQUbGGiOHCbsJx9I842UPEtzDOIJOpjAcP5mNbzesg53M
	DPCoE9XA==;
Received: from [2001:4bb8:198:a22c:146a:86ef:5806:b115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyE4-00DGZx-25;
	Mon, 22 Jan 2024 17:36:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: atomic queue limits updates
Date: Mon, 22 Jan 2024 18:36:30 +0100
Message-Id: <20240122173645.1686078-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

currently queue limits updates are a mess in that they are updated one
limit at a time, which makes both cross-checking them against other
limits hard, and also makes it hard to provide atomicy.

This series tries to change this by updating the whole set of queue
limits atomically.   This in done in two ways:

 - for the initial setup the queue_limits structure is simply passed to
   the queue/disk allocation helpers and applies there after validation.
 - for the (relatively few) cases that update limits at runtime a pair
   of helpers to take a snapshot of the current limits and to commit it
   after picking up the callers changes are provided.

As the series is big enough it only converts two drivers - virtio_blk as
a heavily used driver in virtualized setups, and loop as one that actually
does runtime updates while being fairly simple.  I plan to update most
drivers for this merge window, although SCSI will probably have to wait
for the next one given that it will need extensive API changes in the
LLDD and ULD interfaces.

Diffstat:
 arch/um/drivers/ubd_kern.c          |    2 
 block/blk-core.c                    |   29 ++-
 block/blk-mq.c                      |   26 +--
 block/blk-settings.c                |  172 +++++++++++++++++++-
 block/blk-sysfs.c                   |   59 +++----
 block/blk.h                         |    3 
 block/bsg-lib.c                     |    2 
 block/genhd.c                       |    4 
 drivers/block/amiflop.c             |    2 
 drivers/block/aoe/aoeblk.c          |    2 
 drivers/block/ataflop.c             |    2 
 drivers/block/floppy.c              |    2 
 drivers/block/loop.c                |   75 ++++-----
 drivers/block/mtip32xx/mtip32xx.c   |    2 
 drivers/block/nbd.c                 |    2 
 drivers/block/null_blk/main.c       |    2 
 drivers/block/ps3disk.c             |    2 
 drivers/block/rbd.c                 |    2 
 drivers/block/rnbd/rnbd-clt.c       |    2 
 drivers/block/sunvdc.c              |    2 
 drivers/block/swim.c                |    2 
 drivers/block/swim3.c               |    2 
 drivers/block/ublk_drv.c            |    2 
 drivers/block/virtio_blk.c          |  299 ++++++++++++++++++------------------
 drivers/block/xen-blkfront.c        |    2 
 drivers/block/z2ram.c               |    2 
 drivers/cdrom/gdrom.c               |    2 
 drivers/memstick/core/ms_block.c    |    2 
 drivers/memstick/core/mspro_block.c |    2 
 drivers/mmc/core/queue.c            |    2 
 drivers/mtd/mtd_blkdevs.c           |    2 
 drivers/mtd/ubi/block.c             |    2 
 drivers/nvme/host/apple.c           |    2 
 drivers/nvme/host/core.c            |   18 --
 drivers/s390/block/dasd_genhd.c     |    2 
 drivers/s390/block/scm_blk.c        |    2 
 drivers/scsi/scsi_scan.c            |    2 
 drivers/ufs/core/ufshcd.c           |    2 
 include/linux/blk-mq.h              |   10 -
 include/linux/blkdev.h              |   36 +++-
 40 files changed, 484 insertions(+), 305 deletions(-)
