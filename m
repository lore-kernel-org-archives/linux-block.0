Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: schmitzmic@gmail.com
Cc: axboe@kernel.dk, geert@linux-m68k.org, jdow@earthlink.net, linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Wed, 27 Jun 2018 10:24:30 +0200
Message-ID: <2157764.1gpVE8K9i5@merkaba>
In-Reply-To: <20180627012421.80B8F24E094@nmr-admin>
References: <20180627012421.80B8F24E094@nmr-admin>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Thanks a lot again for your patch.

schmitzmic@gmail.com - 27.06.18, 03:24:
> +               if (start_sect > INT_MAX || nr_sects > INT_MAX
> +                       || (start_sect + nr_sects) > INT_MAX) {
> +                       pr_err("%s: Warning: RDB partition
> overflow!\n", +                               bdevname(state->bdev,

I=B4d word this:

Warning: RDB partition 32-bit overflow

AmigaOS developers can do 64 bit math on a 32 bit operating system. Just=20
like Linux can.

> b));
> +                       pr_err("%s: start 0x%llX size 0x%llX\n",
> +                               bdevname(state->bdev, b), start_sect,
> +                               nr_sects);
> +                       pr_err("%s: partition incompatible with 32 bit
> OS\n", +                               bdevname(state->bdev, b));
> +               }

And as stated in my other reply to the patch:

partition needs 64 bit disk device support in AmigaOS or AmigaOS like=20
operating systems (NSD64, TD64 or SCSI direct)

see my other reply to the patch and my other mails in the
"Re: moving affs + RDB partition support to staging?" thread as to why.=20
And for references.

Thanks,
=2D-=20
Martin
