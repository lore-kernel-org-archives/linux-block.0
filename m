Return-Path: <schmitzmic@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2157764.1gpVE8K9i5@merkaba>
References: <20180627012421.80B8F24E094@nmr-admin> <2157764.1gpVE8K9i5@merkaba>
From: Michael Schmitz <schmitzmic@gmail.com>
Date: Thu, 28 Jun 2018 08:13:12 +1200
Message-ID: <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Joanne Dow <jdow@earthlink.net>, "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Martin,

thanks for your comments.

On Wed, Jun 27, 2018 at 8:24 PM, Martin Steigerwald <martin@lichtvoll.de> w=
rote:
> Thanks a lot again for your patch.
>
> schmitzmic@gmail.com - 27.06.18, 03:24:
>> +               if (start_sect > INT_MAX || nr_sects > INT_MAX
>> +                       || (start_sect + nr_sects) > INT_MAX) {
>> +                       pr_err("%s: Warning: RDB partition
>> overflow!\n", +                               bdevname(state->bdev,
>
> I=C2=B4d word this:
>
> Warning: RDB partition 32-bit overflow
>
> AmigaOS developers can do 64 bit math on a 32 bit operating system. Just
> like Linux can.

Yes, I realize that. I hadn't gone back through all the mails on the
subject to find out what the exact requrements are on the AmigaOS
side.

Just trying to be as terse as possible to keep checkpatch happy :-(

>
>> b));
>> +                       pr_err("%s: start 0x%llX size 0x%llX\n",
>> +                               bdevname(state->bdev, b), start_sect,
>> +                               nr_sects);
>> +                       pr_err("%s: partition incompatible with 32 bit
>> OS\n", +                               bdevname(state->bdev, b));
>> +               }
>
> And as stated in my other reply to the patch:
>
> partition needs 64 bit disk device support in AmigaOS or AmigaOS like
> operating systems (NSD64, TD64 or SCSI direct)

I'd probably leave it at 'disk needs 64 bit disk device support on
native OS', and only print that warning once.

Geert has raised another important point about 64 bt device support -
all this is moot when the Linux kernel wasn't built with large block
device support enabled (you'd get the same buggy behaviour as before
the patch there).

> see my other reply to the patch and my other mails in the
> "Re: moving affs + RDB partition support to staging?" thread as to why.
> And for references.

Thanks for collating all the references. Please understand that I
can't read all of that, and as a simple patch mechanic I won't even
try to grasp all the subtleties of RDB (I don't even own an Amiga so I
am quite unlikey to ever use this code path).
But please also understand that for that reason, I take Joanne's
advice about backwards compatibility very serious. My patch (actually
Joanne's originally) changes kernel behaviour from what we consider
broken (allowing 32 bit overflow in partition address calculations) to
what we think is the right thing to do. But there might be someone out
there who used the current behaviour to craft a RDB that aliows two
separate sets of partitions to coexist on the same disk (one set
visible to 32 bit disk drivers, before the 32 bit overflow mark, and a
second set above that mark, visible only to 64 bit drivers. Silently
changing our parser behaviour might cause said user to now trash data
past the overflow mark.). This is a little contrived, and perhaps I am
overcomplicating matters (again), but can't be ruled out.

In the interest of least surprises, we have to fix the 32 bit overflow
(so we can even detect that it would have happened), and give the user
the chance to carefully consider whether to accept the new behaviour.
That means refusing to make available any partition that would have
been affected by such overflow.

The user has then all options available - force old behaviour by using
an older kernel, override the parser to force new behaviour (which we
all assume is correct), or leave the disk well alone.

Cheers,

  Michael

> Thanks,
> --
> Martin
>
>
