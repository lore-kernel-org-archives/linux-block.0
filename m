Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, hch@infradead.org, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
Date: Wed, 14 Jun 2017 22:33:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170615041503.GB4521@birch.djwong.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/14/2017 10:15 PM, Darrick J. Wong wrote:
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 47c1d4484df9..9cb2314efca3 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -678,7 +678,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>>  	struct kiocb kiocb;
>>  	ssize_t ret;
>>  
>> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
>> +	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_WRITE_LIFE_MASK))
>>  		return -EOPNOTSUPP;
>>  
>>  	init_sync_kiocb(&kiocb, filp);
>> @@ -688,6 +688,13 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>>  		kiocb.ki_flags |= IOCB_DSYNC;
>>  	if (flags & RWF_SYNC)
>>  		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>> +	if (flags & RWF_WRITE_LIFE_MASK) {
>> +		struct inode *inode = file_inode(filp);
>> +
>> +		inode->i_write_hint = (flags & RWF_WRITE_LIFE_MASK) >>
>> +					RWF_WRITE_LIFE_SHIFT;
> 
> Hmm, so once set, hints stick around until someone else sets a different
> one.  I suppose it's unlikely that you'd have two programs writing to
> the same inode with different write hints, right?

You'd hope so... There's really no good way to support that with
buffered writes. For the NVMe use case, you'd be no worse off than you
were without hints, however.

But I do think one change should be made above - we only reset the hint
if someone passes a new hint in. But we probably also want to do so for
the case where no hint is passed in, but one is currently set.

> Also, how does userspace query the write hint value once set?

It doesn't. Ideally this hint would be "for this write only", but that's
not really possible with deferred write back.

>> +/*
>> + * Data life time write flags, steal 4 bits for that
>> + */
>> +#define RWF_WRITE_LIFE_SHIFT		4
>> +#define RWF_WRITE_LIFE_MASK		0x000000f0 /* 4 bits of stream ID */
>> +#define RWF_WRITE_LIFE_SHORT		(1 << RWF_WRITE_LIFE_SHIFT)
>> +#define RWF_WRITE_LIFE_MEDIUM		(2 << RWF_WRITE_LIFE_SHIFT)
>> +#define RWF_WRITE_LIFE_LONG		(3 << RWF_WRITE_LIFE_SHIFT)
>> +#define RWF_WRITE_LIFE_EXTREME		(4 << RWF_WRITE_LIFE_SHIFT)
> 
> Should O_TMPFILE files ought to be created with i_write_hint =
> RWF_WRITE_LIFE_SHORT by default?

The answer here is "it depends". If we're already using hints on that
device, then yes, O_TMPFILE is a clear candidate for
RWF_WRITE_LIFE_SHORT. However, if we are not, then we should not set it
as it may have implications on how the device manages writes. For that
case we'll potentially only be driving a single stream, short writes,
and that may not be enough to saturate device bandwidth.

I would rather leave that for future experimentation. There are similar
things we can do with short lived writes, like apply them to the log
writes in the file system. But all of that should be built on top of
what we end up agreeing on, not included from the get-go. I'd rather get
the basic usage and model going first before we further complicate
matters.

-- 
Jens Axboe
