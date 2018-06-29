Return-Path: <schmitzmic@gmail.com>
Return-Path: <schmitzmic@gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>,
 jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linux-block@vger.kernel.org
References: <20180627012421.80B8F24E094@nmr-admin>
 <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba>
 <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
 <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com>
Date: Fri, 29 Jun 2018 21:07:44 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Geert,


Am 29.06.18 um 20:51 schrieb Geert Uytterhoeven:
> Hi Michael,
>
>> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
>> to use it?
> No idea...
>
> Probably some old Windows or MacOS versions will just suggest to
> format your "new" disk ;-)

Yep, that's what I'd expect. Windows even used to trash the LILO boot
code in the MBR if you just happened to boot to it by accident. Did we
complain?

>
> But it's up to the person (which is not Linux) formatting the disk to
> not try to use
> it on systems that cannot handle it, and may destroy it.
>
>>> Let me clarify: what exactly would the kernel option allow? When to use it?
>> Whether to use it if safe (on Linux). But whatever Linux does (after
>> this patch), access will go to the right area of the disk (as specified
>> by the RDB) so Linux won't any longer stomp on anything that would have
>> mattered to 32 bit disk drivers. So it really should be safe.
> Personally, I see no reason to depend on a kernel option, if it is safe to use.
> Just use it.

So to recap - someone partitions a disk on AmigaOS 4.x, taking advantage
of the large block device support there.
Using that disk on AmigaOS 3.1, data loss ensues. Whether or not Linux
(patched) ever touched the disk has no impact on that outcome.

Right?

Cheers,

    Michael

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
