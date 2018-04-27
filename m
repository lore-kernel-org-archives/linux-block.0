Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [GIT PULL] Block fixes for 4.17-rc2
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6f595f77-a25c-ac1b-7f14-5be0956f5995@kernel.dk>
Date: Fri, 27 Apr 2018 19:55:15 +0200
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <7B64C8FD-E0A2-456E-ADCF-966F838713E8@linaro.org>
References: <4af49398-d746-f9a9-a9bc-ca2007b39a00@kernel.dk>
 <E045C6CF-0E1E-44DB-B82B-43932F76A327@linaro.org>
 <96816828-4521-0bab-df73-1e2ecddd7f77@kernel.dk>
 <110372C3-6206-45FC-9610-614790144564@linaro.org>
 <cb9cc55a-8696-98b1-143a-4ee66630c483@kernel.dk>
 <078F88D3-B9E3-415F-BA56-7B02D5CB6407@linaro.org>
 <1e743001-6284-d18b-1cfa-dc3edde3fd35@kernel.dk>
 <08D740DA-3918-47B8-867A-F1AAAA94E08D@linaro.org>
 <AF1C1826-49A6-4219-9BA0-0ABB86FDD1C3@linaro.org>
 <6f595f77-a25c-ac1b-7f14-5be0956f5995@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 27 apr 2018, alle ore 16:29, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 4/27/18 1:57 AM, Paolo Valente wrote:
>> Should Jens' commit for bfq be still blocked by my concern, this is
>=20
> The patch is in.
>=20
>> just to inform you that I think I found a way to improve bfq, so that
>> it can handle also requests that are prepared, but then disappear
>> without any communication to bfq.  In particular, my change would
>=20
> This is going about it in totally the wrong way. If things magically
> disappear "without any communication to bfq", then it's either a bug =
in
> the scheduling framework OR a bug in bfq. Those are the only two
> options. Request don't magically appear or disappear, they follow a
> specific set of rules.
>=20

I meant "disappear for bfq", sorry if this created confusion.  To
clear further confusion, let me restate the consequences of what you
told me that happens, reusing your own words.

(1) "For the flush case, you start out with a regular request, and
assign the pointers." -> bfq assigns the pointers, for that regular
request, because bfq associates that request with an internal queue
(as it has to do).  In particular bfq increments reference counters
and other counters in that queue (as it has to do).

(2) "Then when we transform that into a flush, it's bypass inserted,"
-> The same request is then transformed into a request with no icq,
i.e., a request not associated with any queue. bfq has no way to know =
that this
bypass-inserted request is a transformed version of the same request
prepared one moment before, because no bfq hook is invoked in the
middle ( "...  the request has an end_io hook, we go through there and
don't finish the request").

So, the incrementing of counters done for of event (1) will *never* be
balanced, pushing bfq into an inconsistent state.  Unless, of course,
I misinterpreted your sentences above.


>> include Jens's change, so I will simply base my change on Jens' one,
>> and I remove my disagreement.  Of course, Jens' change alone would
>> just move the system from an immediate crash, to an unpredictable
>> behavior, which may include later crashes.
>=20
> Can we please stop with this nonsense. A (->priv[0]) and B (->priv[1])
> are valid, IFF C (->elv.icq) is valid. The patch ensures we clear A =
and
> B, if C isn't valid. There's nothing unpredictable about the patch.

You got me wrong.  The sense is as follows: because of the above,
the transformation of the request leads bfq into an inconsistent
state, with which your patch has nothing to do.  Your patch opens the
door to the consequences of this inconsistency only because your patch
eliminates an immediate crash, on request dispatch, occurring *before*
those consequences could have effects.  Your patch *is not* the cause
of this inconsistency.

That said, once a complex system is inconsistent, its behavior may be
hard to predict.  For example, one of the problems we fixed some
months ago was the missing of the requeue hook in bfq, which caused a
very similar unbalance of counters, and ultimately a system hang.

I can even paste involved code snippets, if needed, but I guess it
won't be necessary.

Anyway, I'm already testing a patch that should solve the problem I
described again in this email.  I'm basing that patch on yours, if ok
for you.

Thanks,
Paolo

>=20
> --=20
> Jens Axboe
>=20
