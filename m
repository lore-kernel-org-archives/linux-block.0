Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: correct documentation for blkdev_issue_discard()
 flags
To: Eric Biggers <ebiggers3@gmail.com>, linux-block@vger.kernel.org
References: <20170123194139.51469-1-ebiggers3@gmail.com>
 <20170324213956.GC4986@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <7713387c-df21-ffa0-739c-7df058e590c1@kernel.dk>
Date: Fri, 24 Mar 2017 15:42:06 -0600
MIME-Version: 1.0
In-Reply-To: <20170324213956.GC4986@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/24/2017 03:39 PM, Eric Biggers wrote:
> On Mon, Jan 23, 2017 at 11:41:39AM -0800, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>>
>> BLKDEV_IFL_* flags no longer exist; blkdev_issue_discard() now actually
>> takes BLKDEV_DISCARD_* flags.
>>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>>  block/blk-lib.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-lib.c b/block/blk-lib.c
>> index ed89c8f4b2a0..463b76dd566f 100644
>> --- a/block/blk-lib.c
>> +++ b/block/blk-lib.c
>> @@ -109,7 +109,7 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
>>   * @sector:	start sector
>>   * @nr_sects:	number of sectors to discard
>>   * @gfp_mask:	memory allocation flags (for bio_alloc)
>> - * @flags:	BLKDEV_IFL_* flags to control behaviour
>> + * @flags:	BLKDEV_DISCARD_* flags to control behaviour
>>   *
>>   * Description:
>>   *    Issue a discard request for the sectors in question.
>> -- 
>> 2.11.0.483.g087da7b7c-goog
>>
> 
> Ping?

Sorry, looks like that got lost. I've applied this, and your other
patch. Thanks for the reminder!

-- 
Jens Axboe
