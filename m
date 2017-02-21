Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Omar Sandoval <osandov@osandov.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/13 v2] block: Fix block device shutdown related races
Date: Tue, 21 Feb 2017 18:09:45 +0100
Message-Id: <20170221170958.21845-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

this is a second revision of the patch set to fix several different races and
issues I've found when testing device shutdown and reuse. The first three
patches are fixes to problems in my previous series fixing BDI lifetime issues.
Patch 4 fixes issues with reuse of BDI name with scsi devices. With it I cannot
reproduce the BDI name reuse issues using Omar's stress test using scsi_debug
so it can be used as a replacement of Dan's patches. Patches 5-11 fix oops that
is triggered by __blkdev_put() calling inode_detach_wb() too early (the problem
reported by Thiago). Patches 12 and 13 fix oops due to a bug in gendisk code
where get_gendisk() can return already freed gendisk structure (again triggered
by Omar's stress test).

People, please have a look at patches. They are mostly simple however the
interactions are rather complex so I may have missed something. Also I'm
happy for any additional testing these patches can get - I've stressed them
with Omar's script, tested memcg writeback, tested static (not udev managed)
device inodes.

Jens, I think at least patches 1-3 should go in together with my fixes you
already have in your tree (or shortly after them). It is up to you whether
you decide to delay my first fixes or pick these up quickly. Patch 4 is
(IMHO a cleaner) replacement of Dan's patches so consider whether you want
to use it instead of those patches.

Changes since v1:
* Added Acks and Tested-by tags for patches in areas that did not change
* Reworked inode_detach_wb() related fixes based on Tejun's feedback

								Honza
