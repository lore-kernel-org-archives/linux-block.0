Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	Tahsin Erdogan <tahsin@google.com>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10 v5] block: Fix block device shutdown related races
Date: Thu, 23 Mar 2017 01:36:52 +0100
Message-Id: <20170323003702.27571-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

this is a series with the remaining patches (on top of 4.11-rc2) to fix several
different races and issues I've found when testing device shutdown and reuse.
The first patch fixes possible (theoretical) problems when opening of a
block device races with shutdown of a gendisk structure. Patches 2-8 fix oops
that is triggered by __blkdev_put() calling inode_detach_wb() too early (the
problem reported by Thiago). Patches 9 and 10 fix oops due to a bug in gendisk
code where get_gendisk() can return already freed gendisk structure (again
triggered by Omar's stress test).

All patches got reviewed by Tejun and also tested by Thiago (thanks!). Jens,
can you please queue these fixes for the next merge window? Thanks!

Changes since v4:
* Dropped patch fixing possible gendisk shutdown vs blkdev_open race - needs
  more thinking
* Added Tejun's ack

Changes since v3:
* Rebased on top of 4.11-rc2
* Reworked patch 2 (block: Fix race of bdev open with gendisk shutdown) based
  on Tejun's feedback
* Significantly updated patch 5 (and dropped previous Tejun's ack) to
  accommodate for fixes to SCSI re-registration of BDI that went to 4.11-rc2

Changes since v2:
* Added Tejun's acks
* Rebased on top of 4.11-rc1
* Fixed two possible races between blkdev_open() and del_gendisk()
* Fixed possible race between concurrent shutdown of cgwb spotted by Tejun

Changes since v1:
* Added Acks and Tested-by tags for patches in areas that did not change
* Reworked inode_detach_wb() related fixes based on Tejun's feedback

								Honza
