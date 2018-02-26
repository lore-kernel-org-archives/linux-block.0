Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 0/6 v2] block: Fix races in bdev - gendisk handling
Date: Mon, 26 Feb 2018 13:01:36 +0100
Message-Id: <20180226120142.25786-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

these patches fix races happening when devices are frequently destroyed and
recreated in association of block device inode with corresponding gendisk.
Generally when such race happen it results in use-after-free issues, block
device page cache inconsistencies, or other problems. I have verified these
patches fix use-after-free issues that could be reproduced by frequent creation
and destruction of loop device. Hou Tao has verified that races reported by
him in [1] related to gendisk-blkdev association were also fixed. Jens, can
you please merge these patches? Thanks!

Changes since v1:
* Added tested-by tags

								Honza

[1] https://www.spinics.net/lists/linux-block/msg20015.html
