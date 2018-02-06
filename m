Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Eric Biggers <ebiggers3@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6] block: Fix races in bdev - gendisk handling
Date: Tue,  6 Feb 2018 17:05:23 +0100
Message-Id: <20180206160529.20713-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

these patches fix races happening when devices are frequently destroyed and
recreated in association of block device inode with corresponding gendisk.
Generally when such race happen it results in use-after-free issues, block
device page cache inconsistencies, or other problems. I have verified these
patches fix use-after-free issues that could be reproduced by frequent creation
and destruction of loop device. I was not able to reproduce races reported by
Hou Tao [1] related to gendisk-blkdev association (at least I was not able to
hit any issues with stressing using scsi_debug in various ways with or without
patches). My patches should fix those but it would be great if Tao could verify
that. Any comments and review welcome!

								Honza

[1] https://www.spinics.net/lists/linux-block/msg20015.html
