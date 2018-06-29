Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
 <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com> <2499668.52U9LxLmUp@merkaba>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e52c09b3-da8e-6c20-aea0-f9a8f28c6736@gmail.com>
Date: Sat, 30 Jun 2018 11:24:44 +1200
MIME-Version: 1.0
In-Reply-To: <2499668.52U9LxLmUp@merkaba>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Martin,


Am 30.06.18 um 09:24 schrieb Martin Steigerwald:
> Hi Michael.
>
> Michael Schmitz - 29.06.18, 11:07:
>>> But it's up to the person (which is not Linux) formatting the disk
>>> to
>>> not try to use
>>> it on systems that cannot handle it, and may destroy it.
>>>
>>>>> Let me clarify: what exactly would the kernel option allow? When
>>>>> to use it?>> 
>>>> Whether to use it if safe (on Linux). But whatever Linux does
>>>> (after
>>>> this patch), access will go to the right area of the disk (as
>>>> specified by the RDB) so Linux won't any longer stomp on anything
>>>> that would have mattered to 32 bit disk drivers. So it really
>>>> should be safe.> 
>>> Personally, I see no reason to depend on a kernel option, if it is
>>> safe to use. Just use it.
>> So to recap - someone partitions a disk on AmigaOS 4.x, taking
>> advantage of the large block device support there.
>> Using that disk on AmigaOS 3.1, data loss ensues. Whether or not Linux
>> (patched) ever touched the disk has no impact on that outcome.
> I am not even completely sure about that. Frankly I have no idea what 
> would happen when using such a disk on AmigaOS 3.1 *without* NSDPatch or 
> TD64 support (I think you could patch AmigaOS 3.1 with 64 Bit support 
> already and some 3rd party harddisk controllers by Phase 5 hat TD64 
> support at that time already). Unless I try it, which I won´t at the 
> moment, I´d say the behaviour is largely undefined.
The problem that still remains is with unpatched legacy versions. RDB
does support large enough partitions out of the box, due to C/H/S all
using u32. We all agree there. The question is with file systems and
device drivers - someone, at some point, has to recast the block offset
at filesystem level to an offset expressed in the devices's native block
size (regardless of block size used by RDB and filesystem). There are
MOs that use 2k block sizes natively, but as far as I am aware, disks
are usually 512 byte block size (the last disk system I remember where
you could chose block size at the hardware level, at format time, was an
Emulex disk controller on  MicroVax II).

I've dug through a few specs to get a better handle on this. SCSI-2 used
a maximum of 4 bytes for block addresses. IDE used 6 bytes, so at the
time these systems were designed, there already was a way of requesting
data at offsets beyond what can be expressed in 32 bits. I would hope
that any system supporting IDE would have done offset calculations in 64
bits. Is that too optimistic?
> But hey, undefined means it may just overwrite start overwriting from 
> the beginning of the disk beyond 32 bit. And I think that is quite 
> likely. It could also crash, but if its an overflow I don´t think why it 
> would crash. Anyway, I never tried this out.
If offsets are calculated in 32 bits, excess bits are truncated (I don't
think integer overflows ever trapped?). That wraps the offset to
somewhere within the first 2 TB of the disk (maybe less if signed int
was used, like in our parser).
> But in any way: This would happen or not happen no matter whether Linux 
> parsed the RDB or not.
>
> I still think that the native OS warning really does not hurt… but I´d 
> spare myself the kernel option. Having the warning without the kernel 
> option would be a compromise between being cautious and being bold :).
Yep, I've come around to that conclusion, too. Just need to test it
properly. And I still need to check what will happen if we allow such a
large partition table to parse on a kernel without LBD support (i.e.,
are there any downstream checks in place to refuse partitions larger
than what can be handled by 32 bit).

Cheers,

    Michael


> Thanks,
