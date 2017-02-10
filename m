Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <tom.leiming@gmail.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5 0/2] loop: enable different logical blocksizes
Date: Fri, 10 Feb 2017 09:43:06 +0100
Message-Id: <1486716188-38638-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Currently the loop driver just simulates 512-byte blocks. When
creating bootable images for virtual machines it might be required
to use a different physical blocksize (eg 4k for S/390 DASD), as
the some bootloaders (like lilo or zipl for S/390) need to know
the physical block addresses of the kernel and initrd.

With this patchset the loop driver will export the logical and
physical blocksize and the current LOOP_SET_STATUS64 ioctl is
extended to set the logical blocksize by re-using the existing
'init' fields, which are currently unused.

As usual, comments and reviews are welcome.

Changes to v1:
- Move LO_FLAGS_BLOCKSIZE definition
- Reshuffle patches
Changes to v2:
- Include reviews from Ming Lei
Changes to v3:
- Include reviews from Christoph
- Merge patches
Changes to v4:
- Add LO_INFO_BLOCKSIZE definition

Hannes Reinecke (2):
  loop: Remove unused 'bdev' argument from loop_set_capacity
  loop: support 4k physical blocksize

 drivers/block/loop.c      | 40 +++++++++++++++++++++++++++++++++-------
 drivers/block/loop.h      |  1 +
 include/uapi/linux/loop.h |  3 +++
 3 files changed, 37 insertions(+), 7 deletions(-)

-- 
1.8.5.6
