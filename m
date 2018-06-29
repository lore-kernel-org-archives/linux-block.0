Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <20180627012421.80B8F24E094@nmr-admin> <b39c2bf0-de19-ef6e-75bf-b9fae33255c6@gmail.com>
 <CAMuHMdVtvv1Cxxuf__TUKGUJiuTUohGx5XvY_3nQ7vD5J_BBAw@mail.gmail.com>
 <3681004.ZGfTzPZDUK@merkaba> <CAMuHMdXqzQFTNjWrRrgUrEO5XVy+X_ztnnCEZo3vYXVCJp4n8w@mail.gmail.com>
 <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
In-Reply-To: <102c5f41-7fa8-267c-973a-176d3c3d4f57@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Jun 2018 10:51:12 +0200
Message-ID: <CAMuHMdXqkQLtcUFxxhMYiGxMfLyuYVSxFfOpnu7_qn3+0eOt=w@mail.gmail.com>
Subject: Re: Subject: [PATCH RFC] block: fix Amiga RDB partition support for
 disks >= 2 TB
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Martin Steigerwald <martin@lichtvoll.de>, Jens Axboe <axboe@kernel.dk>, jdow <jdow@earthlink.net>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Michael,

On Fri, Jun 29, 2018 at 10:43 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.18 um 21:25 schrieb Geert Uytterhoeven:
> >>> Do we really need the warning?
> >>> Once the parsing is fixed doing 64-bit math, it does not matter for
> >>> Linux anymore.
> >> Well, irony of this is: In my case the RDB has been created on a machine
> >> with a native OS. So Linux warns me about something I already did so on
> >> the native OS without any warning. In this case AmigaOS 4.0.
> > Exactly.
> >
> > So moving a disk partitioned under AmigaOS 4.0 to a system running an
> > older version of AmigaOS can fail miserably. Not a Linux issue.
> > Linux also doesn't warn about disks with GPT failing to work on old MSDOS.
>
> Would MSDOS recognize the GPT partition as 'probably FAT', and attempt
> to use it?

No idea...

Probably some old Windows or MacOS versions will just suggest to
format your "new" disk ;-)

But it's up to the person (which is not Linux) formatting the disk to
not try to use
it on systems that cannot handle it, and may destroy it.

> > Let me clarify: what exactly would the kernel option allow? When to use it?
>
> Whether to use it if safe (on Linux). But whatever Linux does (after
> this patch), access will go to the right area of the disk (as specified
> by the RDB) so Linux won't any longer stomp on anything that would have
> mattered to 32 bit disk drivers. So it really should be safe.

Personally, I see no reason to depend on a kernel option, if it is safe to use.
Just use it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
