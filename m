Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbdCMPOU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2017 11:14:20 -0400
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Tahsin Erdogan <tahsin@google.com>,
        Omar Sandoval <osandov@osandov.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/11 v4] block: Fix block device shutdown related races
Date: Mon, 13 Mar 2017 16:13:59 +0100
Message-Id: <20170313151410.5586-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

this is a series with the remaining patches (on top of 4.11-rc2) to fix several
different races and issues I've found when testing device shutdown and reuse.
The first two patches fix possible (theoretical) problems when opening of a
block device races with shutdown of a gendisk structure. Patches 3-9 fix oops
that is triggered by __blkdev_put() calling inode_detach_wb() too early (the
problem reported by Thiago). Patches 10 and 11 fix oops due to a bug in gendisk
code where get_gendisk() can return already freed gendisk structure (again
triggered by Omar's stress test).

People, please have a look at patches. They are mostly simple however the
interactions are rather complex so I may have missed something. Also I'm
happy for any additional testing these patches can get - I've stressed them
with Omar's script, tested memcg writeback, tested static (not udev managed)
device inodes.

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
