Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Thu, 28 Jun 2018 09:13:09 +0200
Message-ID: <3681004.ZGfTzPZDUK@merkaba>
In-Reply-To: <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com> <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
List-ID: <linux-block@vger.kernel.org>

Hi Geert.

Geert Uytterhoeven - 28.06.18, 08:45:=20
> On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com>=20
wrote:
> > Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
> > >>> And as stated in my other reply to the patch:
> > >>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
> > >>> like
> > >>> operating systems (NSD64, TD64 or SCSI direct)
> > >>=20
> > >> I'd probably leave it at 'disk needs 64 bit disk device support
> > >> on
> > >> native OS', and only print that warning once.
> > >=20
> > > This is fine with me.
> >=20
> > OK, I'll go with that.
>=20
> Do we really need the warning?
> Once the parsing is fixed doing 64-bit math, it does not matter for
> Linux anymore.

Well, irony of this is: In my case the RDB has been created on a machine=20
with a native OS. So Linux warns me about something I already did so on=20
the native OS without any warning. In this case AmigaOS 4.0.
=20
> Won't it make more sense to have the warning in the tool that created
> the partition table in the first place?

Well that would be up to the AmigaOS developers to decide.

And well for amiga-fdisk or parted developers if they ever choose to=20
support this or already do. (I doubt that amiga-fdisk can handle this.)

> > > I would not name the kernel option "eat_my_rdb", but use a less
> > > dramatizing name.
> > >=20
> > > Maybe just: "allow_64bit_rdb" or something like that.
> >=20
> > I don't expect to get away with that :-)
>=20
> I still fail to see what's the added value of the kernel option...
> Either the partition is usable, or not.

Well, I could try to contact some of the current AmigaOS developers=20
about that and ask them whether they would like to give me a statement=20
about this that I am allowed to post here.

I would not know whether they answer and it may take a time. My offer=20
stands, but I would only do this, if you really like to have that=20
official feedback.

Again, I am pretty sure that what I did is safe on AmigaOS 4 at least,=20
but I bet also on AmigaOS <4 with NSD64 or TD64 (except for the=20
filesystem sizes, but AmigaOS < 4 does not have JXFS anyway, and did not=20
have SFS2 as well, maybe that is available now, I don=B4t know).

However Joanne is without doubt an authority on RDBs, but she has not=20
been involved with AmigaOS development for quite some time and, correct=20
me if this is wrong, Joanne, does not know as much about the recent=20
versions, as I or even more so as current AmigaOS developers know.

Thanks,
=2D-=20
Martin
