Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20180627012421.80B8F24E094@nmr-admin>
 <CAMuHMdUOGdF-bm8j59Om8JNV0mFqK0yixGifgLAjxGwOGLoyqQ@mail.gmail.com>
 <ab97678c-ad67-8020-73d4-c0a5eed2f9f7@gmail.com>
 <CAMuHMdV035mVe1g6sm0wA8LCG7Z9cdnRXrHNtVTCr97tu-yo0Q@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
 Martin Steigerwald <martin@lichtvoll.de>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <26c4b7c8-4cc8-8304-524f-2af73366a676@gmail.com>
Date: Sun, 1 Jul 2018 09:26:42 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV035mVe1g6sm0wA8LCG7Z9cdnRXrHNtVTCr97tu-yo0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

Am 01.07.2018 um 09:10 schrieb Geert Uytterhoeven:
> Hi Michael,
>
> On Fri, Jun 29, 2018 at 11:12 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> Am 28.06.18 um 01:30 schrieb Geert Uytterhoeven:
>>> On Wed, Jun 27, 2018 at 4:47 AM <schmitzmic@gmail.com> wrote:
>>>> From 5299e0e64dfb33ac3a1f3137b42178734ce20087 Mon Sep 17 00:00:00 2001
>>> ??
>>>
>>>> The Amiga RDB partition parser module uses int for partition sector
>>>> address and count, which will overflow for disks 2 TB and larger.
>>>>
>>>> Use sector_t as type for sector address and size (as expected by
>>>> put_partition) to allow using such disks without danger of data
>>>> corruption.
>>> Note that sector_t is not guaranteed to be 64-bit:
>>>
>>>     #ifdef CONFIG_LBDAF
>>>     typedef u64 sector_t;
>>>     typedef u64 blkcnt_t;
>>>     #else
>>>     typedef unsigned long sector_t;
>>>     typedef unsigned long blkcnt_t;
>>>     #endif
>>>
>>> And it seems CONFIG_LBDAF can still be disabled on 32-bit...
>>>
>>
>> What are the ramifications of using a 2 TB disk on a kernel without
>> CONFIG_LBDAF? Are there any safeguards after the partition scan stage
>> that would prevent the kernel from using partitions on such a disk?
>>
>> Trying to decide whether we absolutely have to bail if sector_t is 32
>> bit ...
>
> Sorry, I don't know.

Not to worry - I'll find out one way or another. I've added some more 
checks to spot both 32 bit and 64 bit overflows following what we 
discussed in the past days (though the latter really shouldn't happen). 
I'm quite sure that will throw everyone on linux-block in a laughing 
fit, but I'm sure someone will point out a better way of doing this 
during review (or prove it won't be necessary).

Pending final test, I'll submit the result today or tomorrow.

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
