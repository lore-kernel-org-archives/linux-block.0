Return-Path: <dan.j.williams@gmail.com>
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <7780787.RVFXFXDN3H@morokweng>
References: <148375097100.37020.495735345355345658.stgit@dwillia2-desk3.amr.corp.intel.com>
 <7780787.RVFXFXDN3H@morokweng>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 25 Jan 2017 13:43:58 -0800
Message-ID: <CAA9_cmc5gg39kDGcWRVzBd_9VaU8rTU1ZfHWu=01n7uTNKEkRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] block: fix backing_dev_info lifetime
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, Rabin Vincent <rabinv@axis.com>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	Andi Kleen <andi@firstfloor.org>, Wei Fang <fangwei1@huawei.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 23, 2017 at 1:17 PM, Thiago Jung Bauermann
<bauerman@linux.vnet.ibm.com> wrote:
> Hello Dan,
>
> Am Freitag, 6. Januar 2017, 17:02:51 BRST schrieb Dan Williams:
>> v1 of these changes [1] was a one line change to bdev_get_queue() to
>> prevent a shutdown crash when del_gendisk() races the final
>> __blkdev_put().
>>
>> While it is known at del_gendisk() time that the queue is still alive,
>> Jan Kara points to other paths [2] that are racing __blkdev_put() where
>> the assumption that ->bd_queue, or inode->i_wb is valid does not hold.
>>
>> Fix that broken assumption, make it the case that if you have a live
>> block_device, or block_device-inode that the corresponding queue and
>> inode-write-back data is still valid.
>>
>> These changes survive a run of the libnvdimm unit test suite which puts
>> some stress on the block_device shutdown path.
>
> I realize that the kernel test robot found problems with this series, but FWIW
> it fixes the bug mentioned in [2].
>

Thanks for the test result. I might take a look at cleaning up the
test robot reports and resubmitting this approach unless Jan beats me
to the punch with his backing_devi_info lifetime change patches.

>> [2]: http://www.spinics.net/lists/linux-fsdevel/msg105153.html
