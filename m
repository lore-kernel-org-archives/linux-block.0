Subject: Re: [PATCH 1/8] block: add WRITE_BG
To: Christoph Hellwig <hch@infradead.org>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
 <1477515135-16469-2-git-send-email-axboe@fb.com>
 <20161027063717.GA1165@infradead.org>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, jack@suse.cz,
 kernel@kolivas.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <4ae57faa-2f69-98cd-e276-1e091a6922b0@fb.com>
Date: Fri, 28 Oct 2016 08:57:07 -0600
MIME-Version: 1.0
In-Reply-To: <20161027063717.GA1165@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/27/2016 12:37 AM, Christoph Hellwig wrote:
>>   *			non-volatile media on completion.
>> + * WRITE_BG		Background write. This is for background activity like
>> + *			the periodic flush and background threshold writeback
>>   *
>>   */
>>  #define RW_MASK			REQ_OP_WRITE
>> @@ -202,6 +204,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>>  #define WRITE_FLUSH		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH)
>>  #define WRITE_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_FUA)
>>  #define WRITE_FLUSH_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
>> +#define WRITE_BG		(REQ_NOIDLE | REQ_BG)
>
> I've been trying to kill off these WRITE_ flags as they aren't exactly
> helpful, see my branch here that I'm waiting for the previous serious to
> go in:
>
>    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-flags

I'll just adapt to whatever goes in first, not really a concern for me.

> Which also begs the question why you add the REQ_NOIDLE flag above, as
> it's only applied to synchronous queues in cfq as far as I can tell.

Right, it's a CFQ hint. We only want to potentially idle for direct/sync 
writes, not buffer async writeback.

> And while I'm at nitpicking about the most trivial patch of the
> series anyway:  any good reason to not just spell out the "BACKGROUND" ?

Sure, I can make that change.

-- 
Jens Axboe
