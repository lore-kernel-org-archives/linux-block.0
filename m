Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com> <3681004.ZGfTzPZDUK@merkaba>
In-Reply-To: <3681004.ZGfTzPZDUK@merkaba>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Jun 2018 11:25:09 +0200
Message-ID: <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Martin,

On Thu, Jun 28, 2018 at 9:13 AM Martin Steigerwald <martin@lichtvoll.de> wr=
ote:
> Geert Uytterhoeven - 28.06.18, 08:45:
> > On Thu, Jun 28, 2018 at 6:59 AM Michael Schmitz <schmitzmic@gmail.com>
> wrote:
> > > Am 28.06.2018 um 09:20 schrieb Martin Steigerwald:
> > > >>> And as stated in my other reply to the patch:
> > > >>> partition needs 64 bit disk device support in AmigaOS or AmigaOS
> > > >>> like
> > > >>> operating systems (NSD64, TD64 or SCSI direct)
> > > >>
> > > >> I'd probably leave it at 'disk needs 64 bit disk device support
> > > >> on
> > > >> native OS', and only print that warning once.
> > > >
> > > > This is fine with me.
> > >
> > > OK, I'll go with that.
> >
> > Do we really need the warning?
> > Once the parsing is fixed doing 64-bit math, it does not matter for
> > Linux anymore.
>
> Well, irony of this is: In my case the RDB has been created on a machine
> with a native OS. So Linux warns me about something I already did so on
> the native OS without any warning. In this case AmigaOS 4.0.

Exactly.

So moving a disk partitioned under AmigaOS 4.0 to a system running an
older version of AmigaOS can fail miserably. Not a Linux issue.
Linux also doesn't warn about disks with GPT failing to work on old MSDOS.

> > > > I would not name the kernel option "eat_my_rdb", but use a less
> > > > dramatizing name.
> > > >
> > > > Maybe just: "allow_64bit_rdb" or something like that.
> > >
> > > I don't expect to get away with that :-)
> >
> > I still fail to see what's the added value of the kernel option...
> > Either the partition is usable, or not.
>
> Well, I could try to contact some of the current AmigaOS developers
> about that and ask them whether they would like to give me a statement
> about this that I am allowed to post here.
>
> I would not know whether they answer and it may take a time. My offer
> stands, but I would only do this, if you really like to have that
> official feedback.

Let me clarify: what exactly would the kernel option allow? When to use it?

> Again, I am pretty sure that what I did is safe on AmigaOS 4 at least,
> but I bet also on AmigaOS <4 with NSD64 or TD64 (except for the
> filesystem sizes, but AmigaOS < 4 does not have JXFS anyway, and did not
> have SFS2 as well, maybe that is available now, I don=C2=B4t know).
>
> However Joanne is without doubt an authority on RDBs, but she has not

As a former AmigaOS user, I'm fully aware of that (Thanks Joanne! ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
