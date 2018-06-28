Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
References: <20180627012421.80B8F24E094@nmr-admin>
 <2157764.1gpVE8K9i5@merkaba>
 <CAOmrzkLZCE7jPHVP0Et7L7=8UAAG80v7gpYrKpZVJADQz6PeaA@mail.gmail.com>
 <3488210.nMeMqUQulA@merkaba>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Joanne Dow <jdow@earthlink.net>, Linux/m68k
 <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
Date: Thu, 28 Jun 2018 16:58:52 +1200
MIME-Version: 1.0
In-Reply-To: <3488210.nMeMqUQulA@merkaba>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Martin,

Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
>>> And as stated in my other reply to the patch:
>>>
>>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
>>> like
>>> operating systems (NSD64, TD64 or SCSI direct)
>>
>> I'd probably leave it at 'disk needs 64 bit disk device support on
>> native OS', and only print that warning once.
>
> This is fine with me.

OK, I'll go with that.

>> In the interest of least surprises, we have to fix the 32 bit overflow
>> (so we can even detect that it would have happened), and give the
>> user the chance to carefully consider whether to accept the new
>> behaviour. That means refusing to make available any partition that
>> would have been affected by such overflow.
>
> That is acceptable for me as I told before. Either mount or refuse to
> mount, but do not overflow and mount nonetheless :)
>
> Mind you, I am not using my Amiga machines either at the moment. And I
> repurposed the 2 TB disk years ago.

That's fine - I understand the 'profile' image was a true binary copy of 
the RDB, and placing that file at offset 0 in an image file is a 
legitimate use?

> I would not name the kernel option "eat_my_rdb", but use a less
> dramatizing name.
>
> Maybe just: "allow_64bit_rdb" or something like that.

I don't expect to get away with that :-)

> How does the user come to know about this kernel option? Will you print
> its name in kernel log?

Depends on how easy we want to make it for users. If I put a BUG() trap 
with the check, the resulting log section will point to a specific line 
in block/partitions/amiga.c, from which the override option will be 
obvious. But that might be a little too opaque for some...

Cheers,

	Michael
