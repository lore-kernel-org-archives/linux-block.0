Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6B2DF147
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930062; cv=none; b=giCgpKPQsFeOS7ZotKnTl4h2M5fYmH0yeNmRG+gLV0rcmMwWOzq3Q+Qqjo7jXOj9EUTUtj0EE/OAHt5CvXRQ4KZqk2WQDXyJEdhaRj0Iw+5ULJHneFhB0jQ58Z0fszl0yfvvN3Tu1ITEBorwzDNHQ+GGzkLs5YnS+NOOM6XQq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930062; c=relaxed/simple;
	bh=Bneeo1vxh4vYHM3KoS/Q6iWQ2VX9Krg1LKjJm1nUb58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov0ZRS+JYesrEC8QdNMVYwNnEQCO1NvoXld5hI3HWImG1wfYNahDxjWpIyt+apVTutK5XNi42KEgOlaItSVc2C5DrtgqUUHOBiecLBFoa0rMVKU0ufBldtKjbsw8GDOhSDH2FIJDo9mqJ3G0n5noVorC72LHourRgaCCT8KlpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dW6317Uk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dW6317Uk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FblVd7Lw1WrRW+NirKAoyAngxHzZIBZ7i3VtdtRfJnI=; b=dW6317Uk3iaeJDFL44ZYNzqGWb
	JQZLn0uLDtohH5BsVABup+58H5nPxvsORHHvkk9q97aMxkCgZl+Mql2Wh1pOBKjCiogqbip0FMV+I
	UPx/fKMFefDWwxjtr/zqL3UYt55m+4zmrrhXL+duGvM6fQujEFj6gQoNmf5nhPsUTK1llhOcr1cdK
	O6LT/3E70zxIU4dNHDF7k+CnMcxAX3d6uv+ymhPxCNlKcVmZ4HbW/VyQB2j9mQCYx64o3lDRMgPV9
	KNiwPtJLurq/9aazqPoiP93a529W0Kp/aHi3CgtKuoaX61ew9x2NhSbqgEPavinRh8tjI/L610Vpj
	pyFS5KoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uttlZ-00000005e6K-0FU3;
	Wed, 03 Sep 2025 20:07:37 +0000
Date: Wed, 3 Sep 2025 21:07:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC][PATCHES] convert ->getgeo() from block_device of partition
 to gendisk
Message-ID: <20250903200737.GM39973@ZenIV>
References: <20250718192642.GE2580412@ZenIV>
 <c821c881-76c4-4dde-a208-bb9e8f3ea63f@kernel.dk>
 <20250903140936.GK39973@ZenIV>
 <b0de8c00-050f-45ee-9a77-72d12159fed5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0de8c00-050f-45ee-9a77-72d12159fed5@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 03, 2025 at 12:58:32PM -0600, Jens Axboe wrote:

> > Which tree would you prefer it to go through?  Currently it's in viro/vfs.git
> > #work.getgeo (rebased to 6.17-rc1, no changes since the last posting);
> > I can merge it into vfs/viro #for-next and push it to Linus in the next
> > window, unless you prefer it to go through the block tree...
> 
> Assuming it merges cleanly with my for-6.18/block tree, which I believe
> it should as there's not that much in there, I'm fine with it going in
> via your vfs tree. Which is also why I provided my acked-by. It probably
> _should_ go in via the block tree, but little risk of complications
> here, so...

I can send a pull request to you just as easily as to Linus, so if you would
prefer it in your tree - not a problem:

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-getgeo

for you to fetch changes up to 4fc8728aa34f54835b72e4db0f3db76a72948b65:

  block: switch ->getgeo() to struct gendisk (2025-08-13 02:59:29 -0400)

----------------------------------------------------------------
switching ->getgeo() from struct block_device to struct gendisk

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (3):
      scsi: switch scsi_bios_ptable() and scsi_partsize() to gendisk
      scsi: switch ->bios_param() to passing gendisk
      block: switch ->getgeo() to struct gendisk

 Documentation/filesystems/locking.rst     |  2 +-
 Documentation/scsi/scsi_mid_low_api.rst   |  8 ++++----
 arch/m68k/emu/nfblock.c                   |  4 ++--
 arch/um/drivers/ubd_kern.c                |  6 +++---
 block/ioctl.c                             |  4 ++--
 block/partitions/ibm.c                    |  2 +-
 drivers/ata/libata-scsi.c                 |  4 ++--
 drivers/block/amiflop.c                   | 10 +++++-----
 drivers/block/aoe/aoeblk.c                |  4 ++--
 drivers/block/floppy.c                    |  4 ++--
 drivers/block/mtip32xx/mtip32xx.c         |  6 +++---
 drivers/block/rnbd/rnbd-clt.c             |  4 ++--
 drivers/block/sunvdc.c                    |  3 +--
 drivers/block/swim.c                      |  4 ++--
 drivers/block/virtio_blk.c                |  6 +++---
 drivers/block/xen-blkfront.c              |  4 ++--
 drivers/md/dm.c                           |  4 ++--
 drivers/md/md.c                           |  4 ++--
 drivers/memstick/core/ms_block.c          |  4 ++--
 drivers/memstick/core/mspro_block.c       |  4 ++--
 drivers/message/fusion/mptscsih.c         |  2 +-
 drivers/message/fusion/mptscsih.h         |  2 +-
 drivers/mmc/core/block.c                  |  4 ++--
 drivers/mtd/mtd_blkdevs.c                 |  4 ++--
 drivers/mtd/ubi/block.c                   |  4 ++--
 drivers/nvdimm/btt.c                      |  4 ++--
 drivers/nvme/host/core.c                  |  4 ++--
 drivers/nvme/host/nvme.h                  |  2 +-
 drivers/s390/block/dasd.c                 |  7 ++++---
 drivers/scsi/3w-9xxx.c                    |  2 +-
 drivers/scsi/3w-sas.c                     |  2 +-
 drivers/scsi/3w-xxxx.c                    |  2 +-
 drivers/scsi/BusLogic.c                   |  4 ++--
 drivers/scsi/BusLogic.h                   |  2 +-
 drivers/scsi/aacraid/linit.c              |  6 +++---
 drivers/scsi/advansys.c                   |  2 +-
 drivers/scsi/aha152x.c                    |  4 ++--
 drivers/scsi/aha1542.c                    |  2 +-
 drivers/scsi/aha1740.c                    |  2 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c        |  4 ++--
 drivers/scsi/aic7xxx/aic7xxx_osm.c        |  4 ++--
 drivers/scsi/arcmsr/arcmsr_hba.c          |  6 +++---
 drivers/scsi/atp870u.c                    |  2 +-
 drivers/scsi/fdomain.c                    |  4 ++--
 drivers/scsi/imm.c                        |  2 +-
 drivers/scsi/initio.c                     |  4 ++--
 drivers/scsi/ipr.c                        |  8 ++++----
 drivers/scsi/ips.c                        |  2 +-
 drivers/scsi/ips.h                        |  2 +-
 drivers/scsi/libsas/sas_scsi_host.c       |  2 +-
 drivers/scsi/megaraid.c                   |  4 ++--
 drivers/scsi/megaraid.h                   |  2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |  4 ++--
 drivers/scsi/mpi3mr/mpi3mr_os.c           |  4 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |  4 ++--
 drivers/scsi/mvumi.c                      |  2 +-
 drivers/scsi/myrb.c                       |  2 +-
 drivers/scsi/pcmcia/sym53c500_cs.c        |  2 +-
 drivers/scsi/ppa.c                        |  2 +-
 drivers/scsi/qla1280.c                    |  2 +-
 drivers/scsi/qlogicfas408.c               |  2 +-
 drivers/scsi/qlogicfas408.h               |  2 +-
 drivers/scsi/scsicam.c                    | 16 ++++++++--------
 drivers/scsi/sd.c                         |  8 ++++----
 drivers/scsi/stex.c                       |  2 +-
 drivers/scsi/storvsc_drv.c                |  2 +-
 drivers/scsi/wd719x.c                     |  2 +-
 include/linux/blkdev.h                    |  2 +-
 include/linux/libata.h                    |  2 +-
 include/scsi/libsas.h                     |  2 +-
 include/scsi/scsi_host.h                  |  2 +-
 include/scsi/scsicam.h                    |  7 ++++---
 72 files changed, 135 insertions(+), 134 deletions(-)
