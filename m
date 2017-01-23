Return-Path: <bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-block@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Jan Kara <jack@suse.cz>, Rabin Vincent <rabinv@axis.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Wei Fang <fangwei1@huawei.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 0/2] block: fix backing_dev_info lifetime
Date: Mon, 23 Jan 2017 19:17:21 -0200
In-Reply-To: <148375097100.37020.495735345355345658.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148375097100.37020.495735345355345658.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <7780787.RVFXFXDN3H@morokweng>
List-ID: <linux-block@vger.kernel.org>

Hello Dan,

Am Freitag, 6. Januar 2017, 17:02:51 BRST schrieb Dan Williams:
> v1 of these changes [1] was a one line change to bdev_get_queue() to
> prevent a shutdown crash when del_gendisk() races the final
> __blkdev_put().
> 
> While it is known at del_gendisk() time that the queue is still alive,
> Jan Kara points to other paths [2] that are racing __blkdev_put() where
> the assumption that ->bd_queue, or inode->i_wb is valid does not hold.
> 
> Fix that broken assumption, make it the case that if you have a live
> block_device, or block_device-inode that the corresponding queue and
> inode-write-back data is still valid.
> 
> These changes survive a run of the libnvdimm unit test suite which puts
> some stress on the block_device shutdown path.

I realize that the kernel test robot found problems with this series, but FWIW 
it fixes the bug mentioned in [2].

> [1]: http://marc.info/?l=linux-block&m=148366637105761&w=2
> [2]: http://www.spinics.net/lists/linux-fsdevel/msg105153.html

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
