Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>, Joanne Dow <jdow@earthlink.net>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Thu, 28 Jun 2018 09:28:59 +0200
Message-ID: <1604984.EVDKEPedqG@merkaba>
In-Reply-To: <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <3488210.nMeMqUQulA@merkaba> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael.

Probably I was right with not submitting a patch myself. I=C2=B4d likely=20
would have been overwhelmed by the discussion and feedback :)

Michael Schmitz - 28.06.18, 06:58:
[=E2=80=A6]
> >> In the interest of least surprises, we have to fix the 32 bit
> >> overflow (so we can even detect that it would have happened), and
> >> give the user the chance to carefully consider whether to accept
> >> the new behaviour. That means refusing to make available any
> >> partition that would have been affected by such overflow.
> >=20
> > That is acceptable for me as I told before. Either mount or refuse
> > to
> > mount, but do not overflow and mount nonetheless :)
> >=20
> > Mind you, I am not using my Amiga machines either at the moment. And
> > I repurposed the 2 TB disk years ago.
>=20
> That's fine - I understand the 'profile' image was a true binary copy
> of the RDB, and placing that file at offset 0 in an image file is a
> legitimate use?

You actually ask me to remember about what that 'profile' image was? :)

Well, in the attachment note on the bug report I wrote: "should be just=20
a binary copy", so I did not know exactly back then either. However the=20
file starts with "RDSK" and then it has "PART" headers and so on. That=20
looks pretty much like a binary copy of an RDB. I am a bit surprised by=20
its small size of 2 KiB. But I see three partitions in there. According=20
to the screenshot I also provided, the disk had three partitions. So=20
probably Media Toolbox has been intelligent enough to just copy the used=20
space of the reserved RDB area. Cause I think the reserved space must=20
have been higher than 2 KiB. However the RDB/disk geometry editing=20
screen does not display it and off hand I do not know where to look=20
inside the RDB to see how much space has been reserved. Interestingly=20
the "Total sectors" value in that Media Toolbox window also overflowed.=20
But from my memory this was just a cosmetic issue in Media Toolbox. The=20
"*.device" device drivers, the filesystems and the RDB handling code in=20
AmigaOS do their own math. That is what NSD64 / TD64 was about.

https://bugzilla.kernel.org/show_bug.cgi?id=3D43511

> > I would not name the kernel option "eat_my_rdb", but use a less
> > dramatizing name.
> >=20
> > Maybe just: "allow_64bit_rdb" or something like that.
>=20
> I don't expect to get away with that :-)

Heh. :)

> > How does the user come to know about this kernel option? Will you
> > print its name in kernel log?
>=20
> Depends on how easy we want to make it for users. If I put a BUG()
> trap with the check, the resulting log section will point to a
> specific line in block/partitions/amiga.c, from which the override
> option will be obvious. But that might be a little too opaque for
> some...

kernel-parameters.txt or mentioning in the warning would also be an=20
option.

Thanks,
=2D-=20
Martin
