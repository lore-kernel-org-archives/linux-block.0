Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for disks >= 2 TB
Date: Fri, 29 Jun 2018 23:24:36 +0200
Message-ID: <2499668.52U9LxLmUp@merkaba>
In-Reply-To: <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com>
References: <20180627012421.80B8F24E094@nmr-admin> <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com> <76bf5b8d-6ee1-8e77-4c2a-e0b5a095992b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael.

Michael Schmitz - 29.06.18, 11:07:
> > But it's up to the person (which is not Linux) formatting the disk
> > to
> > not try to use
> > it on systems that cannot handle it, and may destroy it.
> >=20
> >>> Let me clarify: what exactly would the kernel option allow? When
> >>> to use it?>>=20
> >> Whether to use it if safe (on Linux). But whatever Linux does
> >> (after
> >> this patch), access will go to the right area of the disk (as
> >> specified by the RDB) so Linux won't any longer stomp on anything
> >> that would have mattered to 32 bit disk drivers. So it really
> >> should be safe.>=20
> > Personally, I see no reason to depend on a kernel option, if it is
> > safe to use. Just use it.
>=20
> So to recap - someone partitions a disk on AmigaOS 4.x, taking
> advantage of the large block device support there.
> Using that disk on AmigaOS 3.1, data loss ensues. Whether or not Linux
> (patched) ever touched the disk has no impact on that outcome.

I am not even completely sure about that. Frankly I have no idea what=20
would happen when using such a disk on AmigaOS 3.1 *without* NSDPatch or=20
TD64 support (I think you could patch AmigaOS 3.1 with 64 Bit support=20
already and some 3rd party harddisk controllers by Phase 5 hat TD64=20
support at that time already). Unless I try it, which I won=C2=B4t at the=20
moment, I=C2=B4d say the behaviour is largely undefined.

But hey, undefined means it may just overwrite start overwriting from=20
the beginning of the disk beyond 32 bit. And I think that is quite=20
likely. It could also crash, but if its an overflow I don=C2=B4t think why =
it=20
would crash. Anyway, I never tried this out.

But in any way: This would happen or not happen no matter whether Linux=20
parsed the RDB or not.

I still think that the native OS warning really does not hurt=E2=80=A6 but =
I=C2=B4d=20
spare myself the kernel option. Having the warning without the kernel=20
option would be a compromise between being cautious and being bold :).

Thanks,
=2D-=20
Martin
