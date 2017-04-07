Return-Path: <hare@suse.de>
Subject: Re: [PATCHv6 2/2] loop: support 4k physical blocksize
To: Ming Lei <ming.lei@redhat.com>
References: <1491548338-71005-1-git-send-email-hare@suse.de>
 <1491548338-71005-3-git-send-email-hare@suse.de>
 <20170407093428.GA27631@ming.t460p>
Cc: Jens Axboe <axboe@kernel.dk>, Omar Sandoval <osandov@fb.com>,
 Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2aa7767b-b8e4-1d54-0752-63253283ad5c@suse.de>
Date: Fri, 7 Apr 2017 11:38:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170407093428.GA27631@ming.t460p>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/07/2017 11:34 AM, Ming Lei wrote:
> On Fri, Apr 07, 2017 at 08:58:58AM +0200, Hannes Reinecke wrote:
>> When generating bootable VM images certain systems (most notably
>> s390x) require devices with 4k blocksize. This patch implements
>> a new flag 'LO_FLAGS_BLOCKSIZE' which will set the physical
>> blocksize to that of the underlying device, and allow to change
>> the logical blocksize for up to the physical blocksize.
> 
> Actually this UAPI flag is only for setting logical block size. 
> 
Hmm? No, we're setting the physical blocksize, too.
Or am I missing something?

>>
>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>> ---
>>  drivers/block/loop.c      | 36 +++++++++++++++++++++++++++++++-----
>>  drivers/block/loop.h      |  1 +
>>  include/uapi/linux/loop.h |  3 +++
>>  3 files changed, 35 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 81b3900..f098681 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -221,7 +221,8 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>>  }
>>  
>>  static int
>> -figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
>> +figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit,
>> +		 loff_t logical_blocksize)
>>  {
>>  	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
>>  	sector_t x = (sector_t)size;
>> @@ -233,6 +234,12 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
>>  		lo->lo_offset = offset;
>>  	if (lo->lo_sizelimit != sizelimit)
>>  		lo->lo_sizelimit = sizelimit;
>> +	if (lo->lo_flags & LO_FLAGS_BLOCKSIZE) {
>> +		lo->lo_logical_blocksize = logical_blocksize;
>> +		blk_queue_physical_block_size(lo->lo_queue, lo->lo_blocksize);
>> +		blk_queue_logical_block_size(lo->lo_queue,
>> +					     lo->lo_logical_blocksize);
>> +	}
> 
> We can move setting physical block size into loop_set_fd(), and set
> 512 bytes as default logical block size in loop_set_fd() too.
> 
Okay.

>>  	set_capacity(lo->lo_disk, x);
>>  	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
>>  	/* let user-space know about the new size */
>> @@ -814,6 +821,7 @@ static void loop_config_discard(struct loop_device *lo)
>>  	struct file *file = lo->lo_backing_file;
>>  	struct inode *inode = file->f_mapping->host;
>>  	struct request_queue *q = lo->lo_queue;
>> +	int lo_bits = blksize_bits(lo->lo_logical_blocksize);
>>  
>>  	/*
>>  	 * We use punch hole to reclaim the free space used by the
>> @@ -833,7 +841,7 @@ static void loop_config_discard(struct loop_device *lo)
>>  
>>  	q->limits.discard_granularity = inode->i_sb->s_blocksize;
>>  	q->limits.discard_alignment = 0;
>> -	blk_queue_max_discard_sectors(q, UINT_MAX >> 9);
>> +	blk_queue_max_discard_sectors(q, UINT_MAX >> lo_bits);
>>  	q->limits.discard_zeroes_data = 1;
>>  	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
>>  }
>> @@ -922,6 +930,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>>  
>>  	lo->use_dio = false;
>>  	lo->lo_blocksize = lo_blocksize;
>> +	lo->lo_logical_blocksize = 512;
> 
> It isn't enough to just this local vaiable as 512 here, since the last
> logical block size is still kept in queue's setting.
> 
Right. Will be updating the queue setting, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
