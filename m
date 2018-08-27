Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
References: <ab6b6c60d921335b44c100c5018fcc6585f05c24.1535385970.git.christophe.leroy@c-s.fr>
 <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
In-Reply-To: <48bcbeb8e5f57c958e6e0bc7a29feae44821901d.1535385970.git.christophe.leroy@c-s.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Aug 2018 18:42:16 +0200
Message-ID: <CAMuHMdVFUH_6dW0zFP4tuLHjaXWQFr7TXKGuaLz0q57gX9Tpmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRITETHRU)
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-block@vger.kernel.org,
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 27, 2018 at 6:10 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> _PAGE_WRITETHRU is a target specific flag. Prefer generic functions.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

>From a Zorro bus point of view:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/block/z2ram.c
> +++ b/drivers/block/z2ram.c
> @@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
>                         vfree(vmalloc (size));
>                 }
>
> -               vaddr = (unsigned long) __ioremap (paddr, size,
> -                                                  _PAGE_WRITETHRU);
> +               vaddr = (unsigned long)ioremap_wt(paddr, size);
>
>  #else
>                 vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);

However, since the removal of APUS support, this file can no longer be
compiled on powerpc.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
