Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <3488210.nMeMqUQulA@merkaba>
 <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com> <1604984.EVDKEPedqG@merkaba>
In-Reply-To: <1604984.EVDKEPedqG@merkaba>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Jun 2018 09:39:38 +0200
Message-ID: <CAMuHMdU40oRv+2GE_kWj3MQeEfOyy8efMnP_=Pkbn5bQxuBBSA@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Martin,

On Thu, Jun 28, 2018 at 9:29 AM Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
> Michael Schmitz - 28.06.18, 06:58:
> [=E2=80=A6]
> > >> In the interest of least surprises, we have to fix the 32 bit
> > >> overflow (so we can even detect that it would have happened), and
> > >> give the user the chance to carefully consider whether to accept
> > >> the new behaviour. That means refusing to make available any
> > >> partition that would have been affected by such overflow.
> > >
> > > That is acceptable for me as I told before. Either mount or refuse
> > > to
> > > mount, but do not overflow and mount nonetheless :)
> > >
> > > Mind you, I am not using my Amiga machines either at the moment. And
> > > I repurposed the 2 TB disk years ago.
> >
> > That's fine - I understand the 'profile' image was a true binary copy
> > of the RDB, and placing that file at offset 0 in an image file is a
> > legitimate use?
>
> You actually ask me to remember about what that 'profile' image was? :)
>
> Well, in the attachment note on the bug report I wrote: "should be just
> a binary copy", so I did not know exactly back then either. However the
> file starts with "RDSK" and then it has "PART" headers and so on. That
> looks pretty much like a binary copy of an RDB. I am a bit surprised by
> its small size of 2 KiB. But I see three partitions in there. According
> to the screenshot I also provided, the disk had three partitions. So
> probably Media Toolbox has been intelligent enough to just copy the used
> space of the reserved RDB area. Cause I think the reserved space must
> have been higher than 2 KiB. However the RDB/disk geometry editing
> screen does not display it and off hand I do not know where to look
> inside the RDB to see how much space has been reserved. Interestingly
> the "Total sectors" value in that Media Toolbox window also overflowed.

The RDB can be anywhere in the first 2 tracks of the disk, and is identifie=
d
by the "RDSK" block (with a correct checksum). The remainder (e.g. "PART"
blocks) is in a linked list. So 2 KiB sounds fine for 3 partitions (1 RDSK =
+
3 * PART =3D 4 blocks =3D 4 * 512 bytes).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
