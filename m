Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/10] block: Fix block device shutdown related races
Date: Thu,  9 Feb 2017 13:44:23 +0100
Message-Id: <20170209124433.2626-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

this patch set fixes several different races and issues I've found when testing
device shutdown and reuse. The first three patches and fixes to problems in my
previous series fixing BDI lifetime issues. Patch 4 fixes issues with reuse of
BDI name with scsi devices. With it I cannot reproduce the BDI name reuse
issues using Omar's stress test using scsi_debug so it can be used as a
replacement of Dan's patches. Patches 5-8 fix oops that is triggered by
__blkdev_put() calling inode_detach_wb() too early (the problem reported by
Thiago). Patches 9 and 10 fix oops due to a bug in gendisk code where
get_gendisk() can return already freed gendisk structure (again triggered by
Omar's stress test).

People, please have a look at patches. The are mostly simple however the
interactions are rather complex so I may have missed something. Also I'm
happy for any additional testing these patches can get - I've stressed them
with Omar's script, tested memcg writeback, tested static (not udev managed)
device inodes.

								Honza
