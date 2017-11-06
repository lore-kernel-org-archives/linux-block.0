Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: high overhead of functions blkg_*stats_* in bfq
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <2614a5f5-5520-5d5f-2013-d7c19fa8f856@kernel.dk>
Date: Mon, 6 Nov 2017 18:05:58 +0100
Cc: Tejun Heo <tj@kernel.org>,
 linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 dhowells@redhat.com,
 hpa@zytor.com,
 akinobu.mita@gmail.com
Message-Id: <21866329-AEE2-4804-933D-70D538140121@linaro.org>
References: <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk> <20171106150002.GY3252168@devbig577.frc2.facebook.com> <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org> <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org> <01f923d7-f263-0664-e214-3d37c63dbfaa@kernel.dk> <C223E9AE-BE2D-4603-86BC-E72097DCD6D5@linaro.org> <f9483b0c-e1b2-9ed4-f217-01568d1aaa7e@kernel.dk> <A4406E55-0956-4A8C-B14D-B95E8743D399@linaro.org> <20171106163040.GC3252168@devbig577.frc2.facebook.com> <6BC5F831-9777-47A9-A141-B03453F7AF46@linaro.org> <20171106163730.GD3252168@devbig577.frc2.facebook.com> <2614a5f5-5520-5d5f-2013-d7c19fa8f856@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 06 nov 2017, alle ore 17:39, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 11/06/2017 09:37 AM, Tejun Heo wrote:
>> On Mon, Nov 06, 2017 at 05:33:45PM +0100, Paolo Valente wrote:
>>>=20
>>>> Il giorno 06 nov 2017, alle ore 17:30, Tejun Heo <tj@kernel.org> ha =
scritto:
>>>>=20
>>>> Hello,
>>>>=20
>>>> On Mon, Nov 06, 2017 at 05:26:38PM +0100, Paolo Valente wrote:
>>>>> Yes.  DEBUG_BLK_CGROUP will just serve to keep the for-debugging
>>>>> subset switched off even when the dynamic parameter is on.
>>>>>=20
>>>>> We'll wait for possible counter-arguments from Tejun, and then =
start
>>>>> to work on what you propose.
>>>>=20
>>>> So, I think the only *really* required ones are io_serviced and the
>>>> corresponding byte counts, which are tracked by blk-cgroup core
>>>> anyway.  Everything else can be hidden behind an obviously debug =
boot
>>>> param, say, bfq.__DEBUG__extra_stats or whatever.
>>>>=20
>>>=20
>>> ok, can we change it, or do you want us to change it, for cfq too?
>>=20
>> I don't have a strong opinion there but it coudl be more hassle than
>> its worth given how long the stats have been out there.  idk.
>>=20
>> Please also note that you can still allow the extra stats to be
>> enabled run-time through /sys/kernel/module moduleparams and gate =
them
>> with the static_branch.  No idea whether making it that way is
>> worthwhile tho.  Creating / removing the files dynamically is
>> supported but given that some stats need to be tracking all the time
>> to be correct (like # in flights), it seems kinda silly.
>=20
> Yeah, I'd keep them enable-only through some boot/module parameter.
> Folks using this can just reboot to turn them back off.
>=20

Ok to change our solution that way.  One question though: if this
switch must be system-wide (as I seem to understand), and not only
bfq-specific, is a per-scheduler-module parameter ok?

> Bonus points for doing the same for CFQ.
>=20

Prepare the points ... :)

I'm unsure we can finish all this by the next merge window, so, to not
miss the chance of the merge window for the other patches we have
already almost finished, in the next days we'll submit only patches
to:
1) Hide behind DEBUG_BLK_CGROUP all the parameters that Tejun said can
be hidden behind it (only for bfq, as agreed)
2) Move the execution of stat update functions outside the scheduler
lock, which does increase parallelism, and provides a boost of about
30% of sustainable throughput when stats need to be update.  Because
of the patch in item 1), this boost will provide most benefits when
DEBUG_BLK_CGROUP is set, and when also the boot/module parameter is
set, after we will have implemented that too.

Thanks,
Paolo

> --=20
> Jens Axboe
