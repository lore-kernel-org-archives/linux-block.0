Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 05/11] add support for allowing applications to pass in
 write life time hints
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
 <1497374123-15286-6-git-send-email-axboe@kernel.dk>
 <73C2B2DD-612C-451B-BDD9-B7BAAD497D28@dilger.ca>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <87485842-77a4-af5f-c3f5-22d7cb6521fe@kernel.dk>
Date: Tue, 13 Jun 2017 14:21:53 -0600
MIME-Version: 1.0
In-Reply-To: <73C2B2DD-612C-451B-BDD9-B7BAAD497D28@dilger.ca>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2017 01:36 PM, Andreas Dilger wrote:
> On Jun 13, 2017, at 11:15 AM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Add four flags for the pwritev2(2) system call, allowing an application
>> to give the kernel a hint about what on-media life times can be
>> expected from a given write.
>>
>> The intent is for these values to be relative to each other, no
>> absolute meaning should be attached to these flag names.
>>
>> Define IOCB flags to carry this information over, and finally
>> transform them into the block defined stream values.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>> fs/read_write.c         | 17 ++++++++++++++++-
>> include/linux/fs.h      | 18 ++++++++++++++++++
>> include/uapi/linux/fs.h |  4 ++++
>> 3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 47c1d4484df9..1734728aa48b 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -678,7 +678,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>> 	struct kiocb kiocb;
>> 	ssize_t ret;
>>
>> -	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC))
>> +	if (flags & ~(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_WRITE_LIFE_SHORT |
>> +			RWF_WRITE_LIFE_MEDIUM | RWF_WRITE_LIFE_LONG |
>> +			RWF_WRITE_LIFE_EXTREME))
>> 		return -EOPNOTSUPP;
> 
> Since this is essentially just a 4-bit mask, which also works fine if the stream
> ID is an arbitrary value, it would be more clear to just define a mask like
> RWF_WRITE_LIFE_MASK that covers these bits instead of spelling out individual bits.

I almost defined a RWF_VALID_FLAGS mask to cover them all. How's that? I don't think
we should split these out separately, if we don't have to.

>> @@ -688,6 +690,19 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
>> 		kiocb.ki_flags |= IOCB_DSYNC;
>> 	if (flags & RWF_SYNC)
>> 		kiocb.ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
>> +	if (flags & RWF_WRITE_LIFE_SHORT) {
>> +		kiocb.ki_flags |= IOCB_WRITE_LIFE_SHORT;
>> +		file_inode(filp)->i_stream = WRITE_LIFE_SHORT;
>> +	} else if (flags & RWF_WRITE_LIFE_MEDIUM) {
>> +		kiocb.ki_flags |= IOCB_WRITE_LIFE_MEDIUM;
>> +		file_inode(filp)->i_stream = WRITE_LIFE_MEDIUM;
>> +	} else if (flags & RWF_WRITE_LIFE_LONG) {
>> +		kiocb.ki_flags |= IOCB_WRITE_LIFE_LONG;
>> +		file_inode(filp)->i_stream = WRITE_LIFE_LONG;
>> +	} else if (flags & RWF_WRITE_LIFE_EXTREME) {
>> +		kiocb.ki_flags |= IOCB_WRITE_LIFE_EXTREME;
>> +		file_inode(filp)->i_stream = WRITE_LIFE_EXTREME;
>> +	}
> 
> This should just pass all of the bits through:
> 
> 	if (flags & RWF_WRITE_LIFE_MASK) {
> 		file_inode(filp)->i_stream =
> 			((flags & RWF_WRITE_LIFE_MASK) >> RWF_WRITE_LIFE_SHIFT;
> 		kiocb.ki_flags |=
> 			file_inode(filp)->i_stream << IOCB_WRITE_LIFE_SHIFT;
> 	}

Agree, that's the nice benefit of rolling them into one, it'll make the code
more efficient too. OK, let me get that done...


-- 
Jens Axboe
