Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Fri, 29 Jun 2018 23:17:59 +0200
Message-ID: <2831908.UM38Rgggmb@merkaba>
In-Reply-To: <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com> <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi,

Geert Uytterhoeven - 29.06.18, 10:51:
> On Fri, Jun 29, 2018 at 10:43 AM Michael Schmitz=20
<schmitzmic@gmail.com> wrote:
> > Am 28.06.18 um 21:25 schrieb Geert Uytterhoeven:
> > >>> Do we really need the warning?
> > >>> Once the parsing is fixed doing 64-bit math, it does not matter
> > >>> for
> > >>> Linux anymore.
> > >>=20
> > >> Well, irony of this is: In my case the RDB has been created on a
> > >> machine with a native OS. So Linux warns me about something I
> > >> already did so on the native OS without any warning. In this
> > >> case AmigaOS 4.0.> >=20
> > > Exactly.
> > >=20
> > > So moving a disk partitioned under AmigaOS 4.0 to a system running
> > > an
> > > older version of AmigaOS can fail miserably. Not a Linux issue.
> > > Linux also doesn't warn about disks with GPT failing to work on
> > > old MSDOS.>=20
> > Would MSDOS recognize the GPT partition as 'probably FAT', and
> > attempt to use it?
>=20
> No idea...
>=20
> Probably some old Windows or MacOS versions will just suggest to
> format your "new" disk ;-)

Heh=E2=80=A6 MacOS X last I saw it just offers to initialize any disk it do=
es=20
not know about. I had this with a friend who uses Mac quite some years=20
ago with an external harddrive with Linux filesystems. I told him Mac OS=20
X would not understand it, but he did not believe me. Well luckily=20
enough I have been quick enough to unplug the USB cable before he could=20
hit the initialize button. And yes, that is right, Mac OS X at that time=20
did not even tell the user that initializing means *formatting the disk=20
and making all data that was previously on it unavailable*. I did not=20
even believe it that they had no stern warning about initializing in the=20
dialog window. I hope they improved the wording meanwhile.

Thanks,
=2D-=20
Martin
