Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
Date: Wed, 25 Apr 2018 19:25:42 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <110372C3-6206-45FC-9610-614790144564@linaro.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
 <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 25 apr 2018, alle ore 19:06, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/25/18 11:03 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 25 apr 2018, alle ore 18:50, Jens Axboe <axboe@kernel.dk> =
ha scritto:
>>>=20
>>> Hi Linus,
>>>=20
>>> I ended up sitting on this about a week longer than I wanted to,
>>> since we were hashing out details with a timeout change. I've now
>>> killed that patch, so we can flush the existing queue in due time.
>>>=20
>>> This pull request contains:
>>>=20
>>> - Fix for an old regression, where entering the queue can be =
disturbed
>>> by a signal to the process. This can cause spurious EIO. Fix from =
Alan
>>> Jenkins.
>>>=20
>>> - cdrom information leak fix from Dan.
>>>=20
>>> - Trivial helper for testing queue FUA from Dave Chinner, part of =
his
>>> O_DIRECT FUA series.
>>>=20
>>> - Series of swim fixes from Finn that actually makes it work again.
>>>=20
>>> - Loop O_DIRECT corruption fix, which caused data corruption in
>>> production for us. =46rom me.
>>>=20
>>> - BFQ crash fix from me.
>>>=20
>>=20
>> For what it's worth, I disagree with this patch.  This change is =
based
>> on an apparently buggy motivation, as I wrote in my reply in the
>> thread where Jens proposed it.  As such, I think it might even bury
>> more deeply the actual bug that causes the crash (although of course
>> this patch does eliminate the crash for the use case reported in that
>> thread).
>=20
> The patch fixes the issue and I've explained why.

Definitely, but I wrote you that your explanation seems wrong.

> If you have a
> motivation to fix it differently, for whatever reason, then by all
> means submit a patch. So far I haven't seen it, and we still have
> the known crash that people are actually hitting.
>=20

Unfortunately I don't have a solution, because I don't know what the
bug is.  I only know that there's a bug in your explanation for the
bug you want to fix.

> I'll be happy to work with you on that later in the week, when
> the LSFMM conference has wound down.
>=20

I do thank you for that.  If you can, please start by answering my
concerns on your explanation.  Maybe your explanation can be fixed (or
I'm simply wrong), and all will be fine.  Or, if your explanation is
really buggy and we don't find the actual bug in the code, we can
just enrich your proposed change with a comment, and state that this
is a crutch to walk on, while waiting for the actual bug to show up.

Thanks,
Paolo

> --=20
> Jens Axboe
