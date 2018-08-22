Return-Path: <holger@applied-asynchrony.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <72f90be2-0b63-d3a0-e953-da9232f44d5b@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
 <ed71fb8f-1f36-c216-5886-269c77250e29@kernel.dk>
Message-ID: <1c40bce3-24fc-f473-5263-a04a677a3f69@applied-asynchrony.com>
Date: Wed, 22 Aug 2018 21:12:44 +0200
MIME-Version: 1.0
In-Reply-To: <ed71fb8f-1f36-c216-5886-269c77250e29@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/22/18 19:28, Jens Axboe wrote:
> On 8/22/18 8:27 AM, Jens Axboe wrote:
>> On 8/22/18 6:54 AM, Holger Hoffstätte wrote:
>>> On 08/22/18 06:10, Jens Axboe wrote:
>>>> [...]
>>>> If you have time, please look at the 3 patches I posted earlier today.
>>>> Those are for mainline, so should be OK :-)
>>>
>>> I'm just playing along at home but with those 3 I get repeatable
>>> hangs & writeback not starting at all, but curiously *only* on my btrfs
>>> device; for inexplicable reasons some other devices with ext4/xfs flush
>>> properly. Yes, that surprised me too, but it's repeatable.
>>> Now this may or may not have something to do with some of my in-testing
>>> patches for btrfs itself, but if I remove those 3 wbt fixes, everything
>>> is golden again. Not eager to repeat since it hangs sync & requires a
>>> hard reboot.. :(
>>> Just thought you'd like to know.
>>
>> Thanks, that's very useful info! I'll see if I can reproduce that.
> 
> Any chance you can try with and see which patch is causing the issue?
> I can't reproduce it here, seems solid.
> 
> Either that, or a reproducer would be great...

It's a hacked up custom tree but the following things have emerged so far:

- it's not btrfs.

- it also happens with ext4.

- I first suspected bfq on a nonrotational device disabling WBT by default,
but using deadline didn't help either. Can't even mkfs.ext4.

- I suspect - but do not know - that using xfs everywhere else is the
reason I got lucky, because xfs. :D

- it immediately happens with only the first patch
("move disable check into get_limit()")

So the obvious suspect is the new return of UINT_MAX from get_limit() to
__wbt_wait(). I first suspected that I mispatched something, but it's all
like in mainline or your tree. Even the recently moved-around atomic loop
inside rq_wait_inc_below() is 1:1 the same and looks like it should.
Now building mainline and see where that leads me.

cheers,
Holger
