Return-Path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
References: <cover.1523493475.git.fthain@telegraphics.com.au> <ed5a2015ecd360746ab52e8d3f5e8b6f5e1568fa.1523493475.git.fthain@telegraphics.com.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 10:08:27 +0200
Message-ID: <CAMuHMdUHFdjk-XMRDn7rx6iDjJYaxYDGAwfn8u-zKiBdCX+Jww@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] m68k/mac: Fix SWIM memory resource end address
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Jens Axboe <axboe@kernel.dk>, Laurent Vivier <lvivier@redhat.com>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
	stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Finn,

On Thu, Apr 12, 2018 at 2:50 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The resource size is 0x2000 == end - start + 1.
> Therefore end == start + 0x2000 - 1.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: stable@vger.kernel.org # v4.14+
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v4.18.

> --- a/arch/m68k/mac/config.c
> +++ b/arch/m68k/mac/config.c
> @@ -1011,7 +1011,7 @@ int __init mac_platform_init(void)
>                 struct resource swim_rsrc = {
>                         .flags = IORESOURCE_MEM,
>                         .start = (resource_size_t)swim_base,
> -                       .end   = (resource_size_t)swim_base + 0x2000,
> +                       .end   = (resource_size_t)swim_base + 0x1FFF,

BTW, probably you want to change swim_base from u8 * to phys_addr_t, one day.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
