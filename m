Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: [PATCH] block: fix Amiga partition support for disks >= 1 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <20180627012421.80B8F24E094@nmr-admin>
 <1530509350-25410-1-git-send-email-schmitzmic@gmail.com>
 <CAMuHMdXgYyQxuBru_oFeBdYaCMSg9fpYaXDpUrNy08Qps5HM-w@mail.gmail.com>
 <CAOmrzkK5M9Gjpd9K5Hccu-bYK758UVxei5FtO2veY2FVy1kO_A@mail.gmail.com>
 <CAMuHMdUHnx41fooeSdvJDGVHkZrWeY9TYqubARo8XwFRdMwCAg@mail.gmail.com>
Cc: linux-block@vger.kernel.org, Linux/m68k <linux-m68k@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
 Martin Steigerwald <martin@lichtvoll.de>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <05f3e8fd-a0fc-03fa-30a1-ab51cf5d303e@gmail.com>
Date: Tue, 3 Jul 2018 20:15:48 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHnx41fooeSdvJDGVHkZrWeY9TYqubARo8XwFRdMwCAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Geert,

Am 03.07.2018 um 19:22 schrieb Geert Uytterhoeven:
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

Right, got it now. Too late for v2 of the patch ...

I just see I've messed up some other things (duplicate types.h 
inclusion) - I'll have to respin anyway. I'll hold off on that waiting 
for futher feedback for now.

> Or is this also used to catch 64-bit add overflow? In that case, please use
> check_add_overflow().

No, the start sector is directly calculated from what's stored in the 
DosEnvVec struct (or whatever the precise name was), as product of four 
32 bit numbers. nr_sects is calculated from the 32 bit cylinder address 
difference and the other three 32 bit numbers, no addition overflow there.

>>> I would remove the did_warn check, as multiple partitions may be affected.
>>
>> Any partition overflowing means danger lurks (in AmigaDOS of
>> sufficient vintage, that is)
>
> Yes, that's what I meant: dropping the did_warn check means always printing
> the warning, not just for the first "unusable" partition.

Yes, I've done that now.

>>> No need for pr_cont(), just merge the two statements.
>>
>> Checkpatch catch-22 (thou shalt not exceed 80 cols, thou shalt not
>> split string consts over multiple lines, and thou shalt not use
>> pr_cont() without good cause). I'll ignore the 80 cols error then.
>
> That's the sane thing to do: single pr_warn() statement, and ignoring the 80
> columns error if it would mean splitting the string, so people can easily
> grep for it when they see the message on their consoles.

True - and there isn't a checkpatch error for overlong format strings 
these days (there might have been at some time, which I remembered).

Thanks again!

Cheers,

	Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
