Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <cover.1539092111.git.christophe.leroy@c-s.fr> <0d489a2c917d6e8528fad099023eac3d5a516787.1539092111.git.christophe.leroy@c-s.fr>
 <1539097191.64374.44.camel@acm.org>
In-Reply-To: <1539097191.64374.44.camel@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Oct 2018 17:13:57 +0200
Message-ID: <CAMuHMdVpS2wzUniDdXKSWyyTr3Cn9NsXAxOJEKe=D9BUrpdt=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/24] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dominik Brodowski <linux@dominikbrodowski.net>,
	Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Kumar Gala <galak@kernel.crashing.org>, Leo Li <leoyang.li@nxp.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	DRI Development <dri-devel@lists.freedesktop.org>, linux-block@vger.kernel.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Debian m68k <debian-68k@lists.debian.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Bart,

CC debian-68k, linux-m68k

On Tue, Oct 9, 2018 at 5:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
> On Tue, 2018-10-09 at 13:51 +0000, Christophe Leroy wrote:
> > _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
> >
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>
> Hi Geert,
>
> All patches that have been applied to this driver since 2005 are API refactoring
> patches. I haven't found any patches in the history of this driver that seem to
> have been submitted by a user of this driver. Do you perhaps know whether anyone
> is using this driver?

The z2ram is a very simple driver, used to configure (slower) Zorro II RAM as
a swap device.  So I'm not so surprised no one submitted functional patches.

I believe it's still being used.
Probably it could be modified to use mtdram.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
