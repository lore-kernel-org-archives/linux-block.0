Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
	<x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
	<5759E177.9040307@kernel.dk> <5759E299.2060200@kernel.dk>
	<x49mvmuvx2n.fsf@segfault.boston.devel.redhat.com>
	<5759E820.1010609@kernel.dk>
Date: Thu, 09 Jun 2016 18:08:44 -0400
In-Reply-To: <5759E820.1010609@kernel.dk> (Jens Axboe's message of "Thu, 9 Jun
	2016 16:05:20 -0600")
Message-ID: <x49inxivwur.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 06/09/2016 04:04 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>>> I went and checked, but I don't see it. Where is this?
>>>
>>> Ah now I see, you're looking at current -git. The patch is against
>>> for-4.8/core.
>>
>> Ah, right, Mike's patches went in.
>>
>>> Updated version below, dropping REQ_META and changing the naming
>>> s/meta/prio.
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index 32a283eb7274..3cfd67d006fb 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1781,6 +1781,11 @@ get_rq:
>>>   		rw_flags |= REQ_SYNC;
>>>
>>>   	/*
>>> +	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
>>> +	 */
>>> +	rw_flags |= (bio->bi_rw & (REQ_META | REQ_PRIO));
>>> +
>>> +	/*
>>
>> Do we still need to pass in META here?
>
> We don't have to, but it doesn't really hurt. Frankly, we should pass
> in the whole damn thing.

Heh, okay.

Fine by me, Jens.  :)

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
