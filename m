Return-Path: <jdow@earthlink.net>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-block@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Martin Steigerwald <martin@lichtvoll.de>
References: <20180627012421.80B8F24E094@nmr-admin>
 <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com>
 <CAOmrzkK5M9Gjpd9K5Hccu-bYK758UVxei5FtO2veY2FVy1kO_A@mail.gmail.com>
 <CAMuHMdUHnx41fooeSdvJDGVHkZrWeY9TYqubARo8XwFRdMwCAg@mail.gmail.com>
From: jdow <jdow@earthlink.net>
Message-ID: <19c60bc1-fa11-ab38-fd7c-0dee7de9c7f3@earthlink.net>
Date: Tue, 3 Jul 2018 03:02:16 -0700
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHnx41fooeSdvJDGVHkZrWeY9TYqubARo8XwFRdMwCAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 20180703 00:22, Geert Uytterhoeven wrote:
> Hi Michael,
> 
> On Tue, Jul 3, 2018 at 1:58 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>> On Mon, Jul 2, 2018 at 8:29 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>> +
>>>> +               /* Warn user if start_sect or nr_sects overflow u32 */
>>>> +               if ((nr_sects > UINT_MAX || start_sect > UINT_MAX ||
>>>> +                   (start_sect + nr_sects) > UINT_MAX) && !did_warn) {
>>>
>>> I guess "start_sect + nr_sects > UINT_MAX" is sufficient?
>>
>> No, we need to catch any partition address overflowing. nr_sects >
>> UINT_MAX may be redundant though.
> 
> The three tests may have been needed when both variables were 32-bit,
> but when using unsigned 64-bit arithmetic, it shouldn't matter: if any of the
> two values doesn't fit in 32-bit, the sum also doesn't.
> Or is this also used to catch 64-bit add overflow? In that case, please use
> check_add_overflow().

Um, both values can be high 32 bits with the sum being greater than 32 bits. 
Seems to me, though, that the only test needed is whether the sum is greater 
than 32 bits. If either number is greater the sum certainly is. (Of course, 
either a comment to that effect or code that pounds the concept into the code's 
future reader should appear.) The 2TB issue is one that may surprise old hands 
given the appearance of the RDBs being able to support absurdly large, NSA 
pleasing, disks. It's hard to decide where warnings should appear. (And it's 
difficult to justify them in the RDB parser unless it overflows the interface to 
the Linux OS. The mkfs-(RDB reading Amiga filesystem) took should be where the 
warnings are posted.

>>> I would remove the did_warn check, as multiple partitions may be affected.
>>
>> Any partition overflowing means danger lurks (in AmigaDOS of
>> sufficient vintage, that is)
> 
> Yes, that's what I meant: dropping the did_warn check means always printing
> the warning, not just for the first "unusable" partition.

Actually anything greater than 2 gigabytes may be a problem on some versions of 
AmigaDOS that spoke to hard disks of one kind or another. A newcomer to the 
surprisingly active Amiga scene could get distressed by that error. Old timers 
know of the fixes that circulated. Those fixes appear to work with greater than 
2TB disks to some limited degree. There are probably some official "Commodore" 
OS utilities which will blow their little minds at 2TB if not sooner. That's one 
that can be protected for in the partitioning tool. The RDB parser should warn 
if it gets confused or overflows its interface into the OS. Ideally it should 
back out of mounting partitions it does not understand.

Note that the original RDB parser patch I made was part of patch to allow 2k 
physical block size to match some 640 megabyte Fujitsu magneto-optical drives. I 
hope the OS can still cope with that situation. (I don't know if I can recover 
the actual data written to the disk. I can't remember if I limited the LSEG 
data, which Linux should ignore anyway, to 512 bytes or not when I built the low 
level partitioning tools. So LONG ago and a mind with a 7 in front of its age 
gets tad flaky remembering such ancient history.)

>>> Also, RDB doesn't enforce partition ordering, IIRC, so e.g. partitions 1
>>> and 3 could be outside the 2 TiB area, while 2 could be within.
>>
>> The first partition (partly) outside 2 TB will warn. But the point
>> about partition ordering later is well taken.
>>>
>>>> +                       pr_err("Dev %s: partition 32 bit overflow! ",
>>>
>>> pr_warn()
>>
>> OK.
>>
>>>
>>>> +                               bdevname(state->bdev, b));
>>>> +                       pr_cont("start_sect 0x%llX, nr_sects 0x%llx\n",
>>>> +                                start_sect, nr_sects);
>>>
>>> No need for pr_cont(), just merge the two statements.
>>
>> Checkpatch catch-22 (thou shalt not exceed 80 cols, thou shalt not
>> split string consts over multiple lines, and thou shalt not use
>> pr_cont() without good cause). I'll ignore the 80 cols error then.
> 
> That's the sane thing to do: single pr_warn() statement, and ignoring the 80
> columns error if it would mean splitting the string, so people can easily
> grep for it when they see the message on their consoles.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert

And thank you for your work with the Linux community, Geert. I've noticed and 
admired it.

{^_^}   Joanne Dow (Her just cruseing face.)
