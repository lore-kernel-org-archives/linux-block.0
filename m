Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6394DC135;
	Mon, 12 Feb 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720391; cv=none; b=W/gU+qwXpwvcodGQxIxLZF3QA8T1FrpRHV6prIRWzSn19cfLe7YmsYaBbBuh9NNJd9W0sEeRdcyIEud7ZWpjKewuCujo3T76rEA13P2Nm/0qVT0jF12pEQMBkQCV7fN0c4vb/tdgBch789ZIvczX6cr2KhxOeq36uKvkGnZAM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720391; c=relaxed/simple;
	bh=E4l5+KQSQgD2n17C6eZFXZjklxp+hvL373wm12oCB2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pi3rD3L+M5ycq2pbWMGLejpUxe1VyOljsW+rouq87m0bisVEC6MCaWGowCJTimkb8hdxQOcmW4mOpR5PjwlHD7WtA2I59bJxRJ09ND1C66QiEw+/1K63awqJ4jJNr34w7kkbfln0kDZVlSPj5exMYscyJI7HazCgxyW9ECc3ex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x6YWzek8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x6YWzek8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=g6JRqS5R4ls1B5jV11JJE5qFl6eiNaPJumzazh62Tbs=; b=x6YWzek8FIgTiXhXFqNV/Yo2qZ
	XlEkPH9N2rW60kBPQHrqzxeG7T3b04bEkDK0damAvC3y5zZXeS8si6GApMIFsjRdAs6Yc5fj6ngx5
	mIiMUOvoBvnb/K1R7SuyhaOElrD+RUFW6MQKSqPWicR1fLQPM3TfKuIOWz1Jk8WjGu+9NIHCsoyJV
	zF74lBE1RznMiTCd9EaXSasKfoaUL5pECpnC88cyXIrSoQKXXa0LoctwFtm11vFZWA3W4YFiSK8iH
	/5FEz0J8hUgefzuMLNPGX05nE0YbRsFpRAqERqPNxsdnYpbuVWx6l1PW2Pd6oCUTiQDdUV5r9K1HJ
	6X25Oyqg==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ54-00000004PYq-0oZe;
	Mon, 12 Feb 2024 06:46:18 +0000
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
Subject: atomic queue limits updates v4
Date: Mon, 12 Feb 2024 07:45:54 +0100
Message-Id: <20240212064609.1327143-1-hch@lst.de>
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

Chances since v3:
 - fix a max_user_discard_sectors bisection hazard
 - fix the max_user_discard_sectors initialization for the new API.
   This led to some major refactoring, so there is a new patch and
   I've dropped the reviews for two existing ones that have major
   modifications

Chances since v2:
 - fix the physical block size default
 - use PAGE_SECTORS_SHIFT more 

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
 block/blk-core.c                    |   27 ++-
 block/blk-mq.c                      |   27 +--
 block/blk-settings.c                |  276 +++++++++++++++++++++++++++------
 block/blk-sysfs.c                   |   59 +++----
 block/blk.h                         |    4 
 block/bsg-lib.c                     |    2 
 block/genhd.c                       |    5 
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
 40 files changed, 547 insertions(+), 337 deletions(-)
