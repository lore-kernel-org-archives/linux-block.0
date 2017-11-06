Return-Path: <axboe@kernel.dk>
Subject: Re: high overhead of functions blkg_*stats_* in bfq
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
 Luca Miccio <lucmiccio@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>,
 dhowells@redhat.com, hpa@zytor.com, akinobu.mita@gmail.com
References: <07DF24AB-9B62-4EE5-8B45-3E04C1CEA84C@linaro.org>
 <20171018131918.GB1302522@devbig577.frc2.facebook.com>
 <76CAD24C-BE7A-4AE0-A207-0FDD0E6506DD@linaro.org>
 <83aaaeb1-2e04-33ed-193a-7d36024fc9dd@kernel.dk>
 <20171106150002.GY3252168@devbig577.frc2.facebook.com>
 <A9703041-F28C-4068-81AB-4CE36D806716@linaro.org>
 <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <01f923d7-f263-0664-e214-3d37c63dbfaa@kernel.dk>
Date: Mon, 6 Nov 2017 09:13:21 -0700
MIME-Version: 1.0
In-Reply-To: <CDDD839D-93E8-4D63-9456-1AEAF101651B@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 11/06/2017 09:11 AM, Paolo Valente wrote:
> 
>> Il giorno 06 nov 2017, alle ore 16:47, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>>>
>>> Il giorno 06 nov 2017, alle ore 16:00, Tejun Heo <tj@kernel.org> ha scritto:
>>>
>>> Hello,
>>>
>>> On Sun, Nov 05, 2017 at 07:21:01PM -0700, Jens Axboe wrote:
>>>> It's pointless to give up on this so soon, when no effort has apparently
>>>> been dedicated to figuring out what the actual issue is yet. So no, no
>>>> patch that will just disable the stats is going to be accepted.
>>>>
>>>> That said, I have no idea who uses these stats. Surely someone can
>>>> answer that question. Tejun?
>>>
>>> Except for the basic bytes / ios counts, it's all debug fluff, which
>>> should have been hidden behind a debug boot param or go under debugfs.
>>> I'm not sure we can get rid of them at this point for cfq but I don't
>>> see why we'd have them for bfq.
>>>
>>
>> Ok, then I think this is the right time to ask you what I can throw
>> way for bfq.  According to your documentation, basic non-debug stats
>> should be:
>>
>> blkio.time
>> blkio.time_recursive
>> blkio.sectors
>> blkio.io_service_bytes
>> blkio.io_service_bytes_recursive
>> blkio.io_serviced
>> blkio.io_serviced_recursive
>> blkio.io_service_time
>> blkio.io_service_time_recursive
>> blkio.io_wait_time
>> blkio.io_wait_time_recursive
>> blkio.io_merged
>> blkio.io_merged_recursive
>> blkio.io_queued
>> blkio.io_queued_recursive
>>
>> So, I have to keep them in bfq, right?  Or is there something I can
>> remove for bfq, in your opinion?  Of course, I would be very happy to remove stuff!
>>
> 
> Or, more mildly, could some of these stats be moved behind
> CONFIG_DEBUG_BLK_CGROUP?

It'd be nice to have them be runtime enabled, but I don't think
that's a hard requirement at all. So if you can just move them
under DEBUG_BLK_CGROUP, that should be good enough.

-- 
Jens Axboe
