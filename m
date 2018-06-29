Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>,
 jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <a5d6cf31-db2f-0db7-d8ef-2b904a614790@gmail.com>
 <CAMuHMdWSwHeijOeoNO6qERgbnPNHxEC43atK0RFr298=cDHGiw@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <578af177-c036-33a1-a54f-f615436dbb25@gmail.com>
Date: Fri, 29 Jun 2018 21:19:19 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWSwHeijOeoNO6qERgbnPNHxEC43atK0RFr298=cDHGiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Geert,


Am 29.06.18 um 21:10 schrieb Geert Uytterhoeven:
>
>> The question is - can writes to the disk cause any damage to data on the
>> disk, as seen by old OS versions? If the answer is no, we won't need the
>> option after all.
> You mean someone relying on the parameters of his RDB to overflow using
> 32-bit calculations, and still have valid offsets on the disk so it's usable?
> I think that would need hand-crafting an RDB, if possible at all.
> And writing to it on AmigaOS 4.0 or any other OS doing proper 64-bit
> calculations would write to the wrong locations, too.
> IMHO not something to consider.

Something like that. But I haven't stopped for long enough to work out
if that was even possible.

>
>>>>> How does the user come to know about this kernel option? Will you print
>>>>> its name in kernel log?
>>>> Depends on how easy we want to make it for users. If I put a BUG() trap
>>>> with the check, the resulting log section will point to a specific line
>>>> in block/partitions/amiga.c, from which the override option will be
>>>> obvious. But that might be a little too opaque for some...
>>> Please don't use BUG(), unless your goal is to attract attention (from
>>> Linus, who dislikes BUG()!).
>> I'd rather not abuse his patience. Thanks for the hint.
>>> Using BUG() would be a nice way to DoS someones machine by plugging in
>>> a USB stick with a malformed RDB.
>> I guess I deserved that. But BUG() doesn't panic now, does it? The ones
>> I saw did allow the kernel to happily carry on.
> The one in asm-generic does call panic().

Ouch - that explains Linus's aversion.

> The m68k one calls __builtin_trap(), which may cause a trap (and panic?) or
> do nothing, depending on gcc version, I think.

The trap doesn't cause a panic for me. Might rely on the trap vector
being set up right (which we can rely on at partition scan time), and
the context though. But if m68k is the odd one out in gracefully
handling BUG(), better leave it.

Cheers,

    Michael
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
