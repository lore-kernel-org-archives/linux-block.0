Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Fri, 29 Jun 2018 23:10:20 +0200
Message-ID: <4338391.UcfQxFzGmz@merkaba>
In-Reply-To: <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com> <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Hi Michael.

Michael Schmitz - 29.06.18, 10:42:
> Am 28.06.18 um 21:25 schrieb Geert Uytterhoeven:
> >>> Do we really need the warning?
> >>> Once the parsing is fixed doing 64-bit math, it does not matter
> >>> for
> >>> Linux anymore.
> >> 
> >> Well, irony of this is: In my case the RDB has been created on a
> >> machine with a native OS. So Linux warns me about something I
> >> already did so on the native OS without any warning. In this case
> >> AmigaOS 4.0.> 
> > Exactly.
> > 
> > So moving a disk partitioned under AmigaOS 4.0 to a system running
> > an
> > older version of AmigaOS can fail miserably. Not a Linux issue.
> > Linux also doesn't warn about disks with GPT failing to work on old
> > MSDOS.
> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> to use it?

As far as I know most GPT partitioning tools create a fake MBR with one 
large partition of a partition type for GPT to tell legacy applications 
to leave the disk alone.

Thanks,
-- 
Martin
