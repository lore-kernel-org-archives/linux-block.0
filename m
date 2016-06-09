Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] cfq: priority boost on meta/prio marked IO
References: <20160608204347.GA30146@kernel.dk>
	<x4937omxd9u.fsf@segfault.boston.devel.redhat.com>
	<5759E177.9040307@kernel.dk>
Date: Thu, 09 Jun 2016 17:47:56 -0400
In-Reply-To: <5759E177.9040307@kernel.dk> (Jens Axboe's message of "Thu, 9 Jun
	2016 15:36:55 -0600")
Message-ID: <x49twh2vxtf.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> On 06/09/2016 03:28 PM, Jeff Moyer wrote:
>> Jens Axboe <axboe@fb.com> writes:
>>
>>> At Facebook, we have a number of cases where people use ionice to set a
>>> lower priority, then end up having tasks stuck for a long time because
>>> eg meta data updates from an idle priority tasks is blocking out higher
>>> priority processes. It's bad enough that it will trigger the softlockup
>>> warning.
>>>
>>> This patch adds code to CFQ that bumps the priority class and data for
>>> an idle task, if is doing IO marked as PRIO or META. With this, we no
>>> longer see the softlockups.
>>>
>>> Signed-off-by: Jens Axboe <axboe@fb.com>
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
>> This needs a docbook update.  It now reads:
>>
>>   * @rw_flags: RW and SYNC flags
>>
>> so whatever flags we're adding should be specified, I guess.
>>
>> Speaking of which, after much waffling, I think I've decided it would be
>> cleaner to limit the priority boost to REQ_PRIO requests only.
>
> I went and checked, but I don't see it. Where is this?

Oops, sorry.  I meant that get_request and __get_request need updates to
their documentation.

On the second part (in case there was confusion on what I meant there),
what I meant was only do the prio boost for REQ_PRIO requests instead
of also doing it for REQ_META.  The way I arrived at that conclusion was
when I was going to ask you to update the documentation for REQ_META to
state that it implied REQ_PRIO, at which point, one has to wonder why we
need two flags.

There are cases where REQ_PRIO is used without REQ_META.
There are cases where REQ_META is used withoug REQ_PRIO.
And of course, there are cases where they're both sent down.

REQ_META itself is useful for tracing, and also makes the code
self-documenting.

REQ_PRIO pretty clearly means that we should boost priority for this
request.  And I think Christoph was making a case for REQ_META that
doesn't require a priority boost (if I read what he said correctly).

So, I think they serve different purposes.  Have I convinced you?  It'll
make your patch smaller!  ;-)

-Jeff
