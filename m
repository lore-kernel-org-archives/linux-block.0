Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
To: Jeff Moyer <jmoyer@redhat.com>, Jens Axboe <axboe@fb.com>
References: <20160608204347.GA30146@kernel.dk>
 <x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5759E177.9040307@kernel.dk>
Date: Thu, 9 Jun 2016 15:36:55 -0600
MIME-Version: 1.0
In-Reply-To: <x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 06/09/2016 03:28 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@fb.com> writes:
>
>> At Facebook, we have a number of cases where people use ionice to set a
>> lower priority, then end up having tasks stuck for a long time because
>> eg meta data updates from an idle priority tasks is blocking out higher
>> priority processes. It's bad enough that it will trigger the softlockup
>> warning.
>>
>> This patch adds code to CFQ that bumps the priority class and data for
>> an idle task, if is doing IO marked as PRIO or META. With this, we no
>> longer see the softlockups.
>>
>> Signed-off-by: Jens Axboe <axboe@fb.com>
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 32a283eb7274..3cfd67d006fb 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1781,6 +1781,11 @@ get_rq:
>>   		rw_flags |= REQ_SYNC;
>>
>>   	/*
>> +	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
>> +	 */
>> +	rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
>> +
>> +	/*
>
> This needs a docbook update.  It now reads:
>
>   * @rw_flags: RW and SYNC flags
>
> so whatever flags we're adding should be specified, I guess.
>
> Speaking of which, after much waffling, I think I've decided it would be
> cleaner to limit the priority boost to REQ_PRIO requests only.

I went and checked, but I don't see it. Where is this?

> Other than that, I think this looks fine.

Thanks!

-- 
Jens Axboe
