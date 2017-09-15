Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V3 01/12] block: Fix declaration of blk-mq debugfs
 functions
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
References: <20170915100645.17999-1-damien.lemoal@wdc.com>
 <20170915100645.17999-2-damien.lemoal@wdc.com> <20170915174552.GB8578@lst.de>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
Message-ID: <fcb88792-aad1-75f0-c936-a539c7f4ac12@wdc.com>
Date: Sat, 16 Sep 2017 07:36:52 +0900
MIME-Version: 1.0
In-Reply-To: <20170915174552.GB8578@lst.de>
Content-Type: text/plain; charset=utf-8
Return-Path: Damien.LeMoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

On 9/16/17 02:45, Christoph Hellwig wrote:
> On Fri, Sep 15, 2017 at 07:06:34PM +0900, Damien Le Moal wrote:
>> __blk_mq_debugfs_rq_show() and blk_mq_debugfs_rq_show() are exported
>> symbols but ar eonly declared in the block internal file
>> block/blk-mq-debugfs.h. which is not cleanly accessible to files outside
>> of the block directory.
>> Move the declaration of these functions to the new file
>> include/linux/blk-mq-debugfs.h file to make the declarations cleanly
>> available to other modules.
>>
>> While at it, also move the definition of the blk_mq_debugfs_attr
>> structure to allow scheduler modules outside of the block directory to
>> define debugfs attributes.
> 
> I think we should keep them local to block/ where all I/O schedulers
> live, so: NAK.

OK. I will drop this one and 02/12.

Thanks.

-- 
Damien Le Moal
Western Digital Research
