Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
Date: Wed, 25 Apr 2018 11:06:04 -0600
MIME-Version: 1.0
In-Reply-To: <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/25/18 11:03 AM, Paolo Valente wrote:
> 
> 
>> Il giorno 25 apr 2018, alle ore 18:50, Jens Axboe <axboe@kernel.dk> ha scritto:
>>
>> Hi Linus,
>>
>> I ended up sitting on this about a week longer than I wanted to,
>> since we were hashing out details with a timeout change. I've now
>> killed that patch, so we can flush the existing queue in due time.
>>
>> This pull request contains:
>>
>> - Fix for an old regression, where entering the queue can be disturbed
>>  by a signal to the process. This can cause spurious EIO. Fix from Alan
>>  Jenkins.
>>
>> - cdrom information leak fix from Dan.
>>
>> - Trivial helper for testing queue FUA from Dave Chinner, part of his
>>  O_DIRECT FUA series.
>>
>> - Series of swim fixes from Finn that actually makes it work again.
>>
>> - Loop O_DIRECT corruption fix, which caused data corruption in
>>  production for us. From me.
>>
>> - BFQ crash fix from me.
>>
> 
> For what it's worth, I disagree with this patch.  This change is based
> on an apparently buggy motivation, as I wrote in my reply in the
> thread where Jens proposed it.  As such, I think it might even bury
> more deeply the actual bug that causes the crash (although of course
> this patch does eliminate the crash for the use case reported in that
> thread).

The patch fixes the issue and I've explained why. If you have a
motivation to fix it differently, for whatever reason, then by all
means submit a patch. So far I haven't seen it, and we still have
the known crash that people are actually hitting.

I'll be happy to work with you on that later in the week, when
the LSFMM conference has wound down.

-- 
Jens Axboe
