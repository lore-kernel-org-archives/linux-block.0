Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 04/11] fs: add support for allowing applications to pass
 in write life time hints
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 adilger@dilger.ca, martin.petersen@oracle.com
References: <1497498312-17704-1-git-send-email-axboe@kernel.dk>
 <1497498312-17704-5-git-send-email-axboe@kernel.dk>
 <20170615041503.GB4521@birch.djwong.org>
 <a0689580-ac50-3e2c-7c00-2d59e130c9a9@kernel.dk>
 <20170615081914.GD10599@infradead.org>
 <7f8e2e3c-fa15-6864-7afd-b82e5afb87b5@kernel.dk>
 <20170616073339.GC8682@infradead.org>
 <0ac0bb7e-ce8d-cb63-985c-ab2d1f3402f1@kernel.dk>
 <20170616155206.GB27209@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ed334779-20b6-3fef-d66d-cd63a493a92f@kernel.dk>
Date: Fri, 16 Jun 2017 09:59:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170616155206.GB27209@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/16/2017 09:52 AM, Christoph Hellwig wrote:
> On Fri, Jun 16, 2017 at 08:35:07AM -0600, Jens Axboe wrote:
>>> Agreed.  In fact I'd go a little further:  we should have a
>>>
>>> 	u16 hints;
>>>
>>> that goes all the way down from fcntl to the driver, right now
>>> we'll allocate the first 3 bits for the write lifetime hints (2.5,
>>> so we have one value spare, as they don't need to flags but can be
>>> enum values), leaving more space for other kinds of hints.
>>
>> Did you see v5? It adds enum write_hint and passes it all the way down,
>> until we transform them into rq/bio flags.
> 
> Yes.  But with all the way down I mean all the way down to the driver :)

Only missing part is the request flags. And why make that any different
than the flags we already have now? It'd be trivial to pack the value
into the request flags as well, but I'm struggling to see the point of
that, honestly.

Please expand on why you think changing the request flags to also
carry that value would be useful, as opposed to just mapping it when
we setup the request. If you have a valid concern I don't mind making
the change, but I just don't see one right now.

>> Mess? The NVMe code seems pretty straight forward to me. Is it purely
>> the lazy alloc part you're referring to?
> 
> Yes.
> 
>> I'm fine with bubbling down the
>> hint and setting everything up inline from the fcntl() call, but that
>> means we need to make things like btrfs and md/dm aware of it and
>> resolve all mappings. That sort-of sucks, especially since they don't
>> otherwise need to know about it.
> 
> True, that sucks.  But taking the hint and doing things behind the
> scenes sounds nasty.

How so? It's pretty straight forward. The only downside I see is that
we'll have a delay between seeing the first valid write hint and to
the time when nvme has it enabled. But that's so short, and in the
grander scheme of things, doesn't matter one bit.

The alternative is a bunch of infrastructure to do this inline. I
think that choice is pretty clear here.

>> If another driver needs similar setup like NVMe, I'd much rather just
>> fix it up there. From the API point of view, there would be no changes.
> 
> Ok..
> 


-- 
Jens Axboe
