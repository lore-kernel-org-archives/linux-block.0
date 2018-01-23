Return-Path: <axboe@kernel.dk>
Subject: Re: Hard LOCKUP on 4.15-rc9 + 'blkmq/for-next' branch
To: David Zarzycki <dave@znu.io>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <95E75EBE-D01A-4236-8762-FF3522D6DBAD@znu.io>
 <78e10971-611e-8dd7-104e-8266c3ba3b5c@kernel.dk>
 <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <6025644f-e147-903a-e836-a2f53d3a61e9@kernel.dk>
Date: Mon, 22 Jan 2018 18:20:30 -0700
MIME-Version: 1.0
In-Reply-To: <7E93BF17-8476-4A93-BD27-D2E22E5DAB00@znu.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/22/18 6:05 PM, David Zarzycki wrote:
> 
> 
>> On Jan 22, 2018, at 18:34, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/22/18 4:31 PM, David Zarzycki wrote:
>>> Hello,
>>>
>>> I previously reported a hang when building LLVM+clang on a block
>>> multi-queue device (NVMe _or_ loopback onto tmpfs with the ’none’
>>> scheduler).
>>>
>>> I’ve since updated the kernel to 4.15-rc9, merged the
>>> ‘blkmq/for-next’ branch, disabled nohz_full parameter (used for
>>> testing), and tried again. Both NVMe and loopback now lock up hard
>>> (ext4 if it matters). Here are the backtraces:
>>>
>>> NVMe:      http://znu.io/IMG_0366.jpg
>>> Loopback:  http://znu.io/IMG_0367.jpg
>>
>> I tried to reproduce this today using the exact recipe that you provide,
>> but it ran fine for hours. Similar setup, nvme on a dual socket box
>> with 48 threads.
> 
> Hi Jens,
> 
> Thanks for the quick reply and thanks for trying to reproduce this.
> I’m not sure if this makes a difference, but this dual Skylake machine
> has 96 threads, not 48 threads. Also, just to be clear, NVMe doesn’t
> seem to matter. I hit this bug with a tmpfs loopback device set up
> like so:
>
> dd if=/dev/zero bs=1024k count=10000 of=/tmp/loopdisk
> losetup /dev/loop0 /tmp/loopdisk
> echo none > /sys/block/loop0/queue/scheduler
> mkfs -t ext4 -L loopy /dev/loop0
> mount /dev/loop0 /l
> ### build LLVM+clang in /l
> ### 'ninja check-all’ in a loop in /l
> 
> (No swap is setup because the machine has 192 GiB of RAM.)

The 48 vs 96 is probably not that significant.Just to be clear, you can
reproduce something else on tmpfs loopback, they don't look related
apart from the fact that they are both lockups off the IO completion
path.

>>> What should I try next to help debug this?
>>
>> This one looks different than the other one. Are you sure your hw is
>> sane?
>
> I can build LLVM+clang in /tmp (tmpfs) reliably which suggests the the
> fundamental hardware is sane. It’s only when the software multi-queue
> layer gets involved that I see quick crashes/hangs.
> 
> As for the different backtraces, that's probably because I removed
> nohz_full from the kernel boot parameters.

Hardware issues can manifest itself in mysterious ways. It might very
well be a software bug, but it'd be the first one of its kind that I've
seen reported. Which does make me a little skeptical, it might just be
the canary in this case.

>> I'd probably try and enable lockdep debugging etc and see if you
>> catch anything.
> 
> Thanks. I turned on lockdep plus other lock debugging. Here is the
> resulting backtrace:
> 
> http://znu.io/IMG_0368.jpg
> 
> Here is the resulting backtrace with transparent huge pages disabled:
> 
> http://znu.io/IMG_0369.jpg
> 
> Here is the resulting backtrace with transparent huge pages disabled
> AND with systemd-coredumps disabled too:
> 
> http://znu.io/IMG_0370.jpg

All of these are off the blk-wbt completion path. I suggested earlier to
try and disable CONFIG_BLK_WBT to see if it goes away, or at least to
see if the pattern changes.

Lockdep didn't catch anything. Maybe try some of the other debugging
features, like page poisoning, memory allocation debugging, slub debug
on-by-default.

> I’m open to trying anything at this point. Thanks for helping,

I'd try other types of stress testing. Has the machine otherwise been
stable, or is it a new box?

-- 
Jens Axboe
