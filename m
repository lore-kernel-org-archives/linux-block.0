Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
Date: Mon, 12 Feb 2018 08:35:01 +0100
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-Id: <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 09 feb 2018, alle ore 20:18, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 2/9/18 12:14 PM, Bart Van Assche wrote:
>> On 02/09/18 10:58, Jens Axboe wrote:
>>> On 2/9/18 11:54 AM, Bart Van Assche wrote:
>>>> Hello Paolo,
>>>>=20
>>>> If I enable the BFQ scheduler for a dm-mpath device then a kernel =
oops
>>>> appears (see also below). This happens systematically with Linus' =
tree from
>>>> this morning (commit 54ce685cae30) merged with Jens' for-linus =
branch (commit
>>>> a78773906147 ("block, bfq: add requeue-request hook")) and for-next =
branch
>>>> (commit 88455ad7f928). Is this a known issue?
>>>=20
>>> Does it happen on Linus -git as well, or just with my for-linus =
merged in?
>>> What I'm getting at is if a78773906147 caused this or not.
>>=20
>> Hello Jens,
>>=20
>> Thanks for chiming in. After having reverted commit a78773906147, =
after=20
>> having rebuilt the BFQ scheduler, after having rebooted and after =
having=20
>> repeated the test I see the same kernel oops being reported. I think=20=

>> that means that this regression is not caused by commit a78773906147. =
In=20
>> case it would be useful, here is how gdb translates the crash =
address:
>>=20
>> $ gdb block/bfq*ko
>> (gdb) list *(bfq_remove_request+0x8d)
>> 0x280d is in bfq_remove_request (block/bfq-iosched.c:1760).
>> 1755                    list_del_init(&rq->queuelist);
>> 1756            bfqq->queued[sync]--;
>> 1757            bfqd->queued--;
>> 1758            elv_rb_del(&bfqq->sort_list, rq);
>> 1759
>> 1760            elv_rqhash_del(q, rq);
>> 1761            if (q->last_merge =3D=3D rq)
>> 1762                    q->last_merge =3D NULL;
>> 1763
>> 1764            if (RB_EMPTY_ROOT(&bfqq->sort_list)) {
>=20
> Looks very odd. So clearly RQF_HASHED is set, but we're blowing up on
> the hash list pointers. I'll let Paolo take a look at this one. Thanks
> for testing without that commit, I want to push out my pending fixes
> today and this would have thrown a wrench in the works.
>=20

Also this smells a little bit like some spurious elevator call.
Unfortunately I have no clue on the cause.  To go on, I need at least
to reproduce it.  In this respect: Bart, could you please tell me how
to setup the offending configuration, and to cause the failure?
Possibly with just one, or at most two PCs.  I don't have fancier hw
at the moment.

Thanks,
Paolo

> --=20
> Jens Axboe
