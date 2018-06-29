Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Martin Steigerwald <martin@lichtvoll.de>
Cc: Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba>
 <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
Date: Fri, 29 Jun 2018 20:42:54 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Geert,


Am 28.06.18 um 21:25 schrieb Geert Uytterhoeven:
>
>>> Do we really need the warning?
>>> Once the parsing is fixed doing 64-bit math, it does not matter for
>>> Linux anymore.
>> Well, irony of this is: In my case the RDB has been created on a machine
>> with a native OS. So Linux warns me about something I already did so on
>> the native OS without any warning. In this case AmigaOS 4.0.
> Exactly.
>
> So moving a disk partitioned under AmigaOS 4.0 to a system running an
> older version of AmigaOS can fail miserably. Not a Linux issue.
> Linux also doesn't warn about disks with GPT failing to work on old MSDOS.

Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
to use it?

> Let me clarify: what exactly would the kernel option allow? When to use it?

Whether to use it if safe (on Linux). But whatever Linux does (after
this patch), access will go to the right area of the disk (as specified
by the RDB) so Linux won't any longer stomp on anything that would have
mattered to 32 bit disk drivers. So it really should be safe.

Cheers,

    Michael
