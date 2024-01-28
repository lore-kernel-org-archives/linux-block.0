Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D720B29;
	Sun, 28 Jan 2024 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461108; cv=none; b=DN/zK8wEUpvTFA3eqlWwlfaB+mg1ZiQAfyaTY2uahU+ghUfvp2OJPHrCc+EICn2L/n+P3KnXzvy7se1/7BN4c9PlbR1vuXcrYCMJMHeQO50NK6gjVHwT8IKRePZZ7QM0Fckktkzp1AVPAtWPuo4Krr8b+7LeJB7Mxn2Fkhe0YM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461108; c=relaxed/simple;
	bh=pOxejoN0CG5BeWMnHP97I/IC1yUpa4Bx5Jxxor5j5Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oL5tBDb25INlMbslR5woinv0MRRkY2ohNKUD70q6bqPmFcavzSabh+BTljhkIp52mhuXQBLNppwu5jocM4zdr5k4WryQJkbjeW/9LvQs2Mw8jVhAPeXQk5HR4Lf1DIOh328usloeEe7OwHIH1fgAkNlgjRZLCZSmBPsTvCMaR6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vtnf37Yg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vtnf37Yg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=t8/5TaCxuroVSP4GMjqC2cE3K0Q1/cXcNHEHPiYjfPk=; b=vtnf37Yg1h1KOo8mN5uMvN2H8c
	oV4/vRZgkDkGuQ+weW/szEeIDgoL6vGviR5JOA+06nxBE48ivRU/maqN21IolW9yzWwwuNYAGsMxP
	o93ifuFpCQdDsknfRBgdbgMCor8al4tqJGqVMIdac32xzH61JyB6/66M5x4L7Hox/dzDcoYvFFxwk
	I9g8FwPmwC6GuYRnuqFFwYoic3qkfkiSiIu5C26XMqGN3brranzv8/37Fpj/t56PbSSABzyHxkbLh
	8nKLMcKItBTkxJ0qGgp8ItUgHk2cg5OT/AZ15UejGk67LskWGRsahsB9+jiP1NKR4HwHmebMBdjwB
	ebpqbHOA==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8U5-0000000A1xA-0ggr;
	Sun, 28 Jan 2024 16:58:17 +0000
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
Subject: atomic queue limits updates v2
Date: Sun, 28 Jan 2024 17:57:59 +0100
Message-Id: <20240128165813.3213508-1-hch@lst.de>
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

Chances since v1:
 - remove a spurious NULL return in blk_alloc_queue
 - keep the existing max_discard_sectors == 0 behavior
 - drop the patch nvme discard limit update hack - it will go into
   the series updating nvme instead
 - drop a chunk_sector check
 - use PAGE_SECTORS in a few places
 - document the checks and defaults in blk_validate_limits
 - various spelling fixes

Diffstat:
 arch/um/drivers/ubd_kern.c          |    2 
 block/blk-core.c                    |   31 ++-
 block/blk-mq.c                      |   26 +--
 block/blk-settings.c                |  213 ++++++++++++++++++++++++-
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
 drivers/nvme/host/core.c            |    8 
 drivers/s390/block/dasd_genhd.c     |    2 
 drivers/s390/block/scm_blk.c        |    2 
 drivers/scsi/scsi_scan.c            |    2 
 drivers/ufs/core/ufshcd.c           |    2 
 include/linux/blk-mq.h              |   10 -
 include/linux/blkdev.h              |   36 +++-
 40 files changed, 526 insertions(+), 296 deletions(-)
