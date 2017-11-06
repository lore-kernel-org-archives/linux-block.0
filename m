Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Tejun Heo <tj@kernel.org>, Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 dhowells@redhat.com, hpa@zytor.com, akinobu.mita@gmail.com
References: <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
 <20171106150002.GY3252168@devbig577.frc2.facebook.com>
 <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org>
 <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org>
 <01f923d7-f263-0664-e214-3d37c63dbfaa@kernel.dk>
 <C223E9AE-BE2D-4603-86BC-E72097DCD6D5@linaro.org>
 <f9483b0c-e1b2-9ed4-f217-01568d1aaa7e@kernel.dk>
 <A4406E55-0956-4A8C-B14D-B95E8743D399@linaro.org>
 <20171106163040.GC3252168@devbig577.frc2.facebook.com>
 <6BC5F831-9777-47A9-A141-B03453F7AF46@linaro.org>
 <20171106163730.GD3252168@devbig577.frc2.facebook.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2614a5f5-5520-5d5f-2013-d7c19fa8f856@kernel.dk>
Date: Mon, 6 Nov 2017 09:39:07 -0700
MIME-Version: 1.0
In-Reply-To: <20171106163730.GD3252168@devbig577.frc2.facebook.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/06/2017 09:37 AM, Tejun Heo wrote:
> On Mon, Nov 06, 2017 at 05:33:45PM +0100, Paolo Valente wrote:
>>
>>> Il giorno 06 nov 2017, alle ore 17:30, Tejun Heo <tj@kernel.org> ha scritto:
>>>
>>> Hello,
>>>
>>> On Mon, Nov 06, 2017 at 05:26:38PM +0100, Paolo Valente wrote:
>>>> Yes.  DEBUG_BLK_CGROUP will just serve to keep the for-debugging
>>>> subset switched off even when the dynamic parameter is on.
>>>>
>>>> We'll wait for possible counter-arguments from Tejun, and then start
>>>> to work on what you propose.
>>>
>>> So, I think the only *really* required ones are io_serviced and the
>>> corresponding byte counts, which are tracked by blk-cgroup core
>>> anyway.  Everything else can be hidden behind an obviously debug boot
>>> param, say, bfq.__DEBUG__extra_stats or whatever.
>>>
>>
>> ok, can we change it, or do you want us to change it, for cfq too?
> 
> I don't have a strong opinion there but it coudl be more hassle than
> its worth given how long the stats have been out there.  idk.
> 
> Please also note that you can still allow the extra stats to be
> enabled run-time through /sys/kernel/module moduleparams and gate them
> with the static_branch.  No idea whether making it that way is
> worthwhile tho.  Creating / removing the files dynamically is
> supported but given that some stats need to be tracking all the time
> to be correct (like # in flights), it seems kinda silly.

Yeah, I'd keep them enable-only through some boot/module parameter.
Folks using this can just reboot to turn them back off.

Bonus points for doing the same for CFQ.

-- 
Jens Axboe
