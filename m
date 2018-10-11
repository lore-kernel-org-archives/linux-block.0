Return-Path: <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 02/24] drivers/video/fbdev: use ioremap_wc/wt() instead
 of __ioremap()
From: Christophe LEROY <christophe.leroy@c-s.fr>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Geoff Levand <geoff@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Kumar Gala <galak@kernel.crashing.org>, Li Yang <leoyang.li@nxp.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <25348d7faf67d5e2829aad03aef8096cd5f6908d.1539092111.git.christophe.leroy@c-s.fr>
Message-ID: <8bd4cbe3-3c7e-1ecb-b627-1970ed7c48af@c-s.fr>
Date: Thu, 11 Oct 2018 16:07:52 +0200
MIME-Version: 1.0
In-Reply-To: <25348d7faf67d5e2829aad03aef8096cd5f6908d.1539092111.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



Le 09/10/2018 à 15:51, Christophe Leroy a écrit :
> _PAGE_NO_CACHE is a platform specific flag. In addition, this flag
> is misleading because one would think it requests a noncached page
> whereas a noncached page is _PAGE_NO_CACHE | _PAGE_GUARDED
> 
> _PAGE_NO_CACHE alone means write combined noncached page, so lets
> use ioremap_wc() instead.
> 
> _PAGE_WRITETHRU is also platform specific flag. Use ioremap_wt()
> instead.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Forgot to add back the acked-by: tags.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thanks
Christophe

> ---
>   drivers/video/fbdev/chipsfb.c    |  3 +--
>   drivers/video/fbdev/controlfb.c  |  5 +----
>   drivers/video/fbdev/platinumfb.c |  5 +----
>   drivers/video/fbdev/valkyriefb.c | 12 ++++++------
>   4 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> index f103665cad43..40182ed85648 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -27,7 +27,6 @@
>   #include <linux/init.h>
>   #include <linux/pci.h>
>   #include <linux/console.h>
> -#include <asm/io.h>
>   
>   #ifdef CONFIG_PMAC_BACKLIGHT
>   #include <asm/backlight.h>
> @@ -401,7 +400,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
>   #endif /* CONFIG_PMAC_BACKLIGHT */
>   
>   #ifdef CONFIG_PPC
> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
> +	p->screen_base = ioremap_wc(addr, 0x200000);
>   #else
>   	p->screen_base = ioremap(addr, 0x200000);
>   #endif
> diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
> index 8d14b29aafea..9cb0ef7ac29e 100644
> --- a/drivers/video/fbdev/controlfb.c
> +++ b/drivers/video/fbdev/controlfb.c
> @@ -48,9 +48,7 @@
>   #include <linux/nvram.h>
>   #include <linux/adb.h>
>   #include <linux/cuda.h>
> -#include <asm/io.h>
>   #include <asm/prom.h>
> -#include <asm/pgtable.h>
>   #include <asm/btext.h>
>   
>   #include "macmodes.h"
> @@ -715,8 +713,7 @@ static int __init control_of_init(struct device_node *dp)
>   		goto error_out;
>   	}
>   	/* map at most 8MB for the frame buffer */
> -	p->frame_buffer = __ioremap(p->frame_buffer_phys, 0x800000,
> -				    _PAGE_WRITETHRU);
> +	p->frame_buffer = ioremap_wt(p->frame_buffer_phys, 0x800000);
>   
>   	if (!p->control_regs_phys ||
>   	    !request_mem_region(p->control_regs_phys, p->control_regs_size,
> diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
> index 377d3399a3ad..bf6b7fb83cf4 100644
> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -32,9 +32,7 @@
>   #include <linux/nvram.h>
>   #include <linux/of_device.h>
>   #include <linux/of_platform.h>
> -#include <asm/io.h>
>   #include <asm/prom.h>
> -#include <asm/pgtable.h>
>   
>   #include "macmodes.h"
>   #include "platinumfb.h"
> @@ -577,8 +575,7 @@ static int platinumfb_probe(struct platform_device* odev)
>   
>   	/* frame buffer - map only 4MB */
>   	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
> -	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
> -					_PAGE_WRITETHRU);
> +	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
>   	pinfo->base_frame_buffer = pinfo->frame_buffer;
>   
>   	/* registers */
> diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
> index 275fb98236d3..d51c3a8009cb 100644
> --- a/drivers/video/fbdev/valkyriefb.c
> +++ b/drivers/video/fbdev/valkyriefb.c
> @@ -54,13 +54,11 @@
>   #include <linux/nvram.h>
>   #include <linux/adb.h>
>   #include <linux/cuda.h>
> -#include <asm/io.h>
>   #ifdef CONFIG_MAC
>   #include <asm/macintosh.h>
>   #else
>   #include <asm/prom.h>
>   #endif
> -#include <asm/pgtable.h>
>   
>   #include "macmodes.h"
>   #include "valkyriefb.h"
> @@ -318,7 +316,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
>   int __init valkyriefb_init(void)
>   {
>   	struct fb_info_valkyrie	*p;
> -	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
> +	unsigned long frame_buffer_phys, cmap_regs_phys;
>   	int err;
>   	char *option = NULL;
>   
> @@ -337,7 +335,6 @@ int __init valkyriefb_init(void)
>   	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
>   	frame_buffer_phys = 0xf9000000;
>   	cmap_regs_phys = 0x50f24000;
> -	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
>   #else /* ppc (!CONFIG_MAC) */
>   	{
>   		struct device_node *dp;
> @@ -354,7 +351,6 @@ int __init valkyriefb_init(void)
>   
>   		frame_buffer_phys = r.start;
>   		cmap_regs_phys = r.start + 0x304000;
> -		flags = _PAGE_WRITETHRU;
>   	}
>   #endif /* ppc (!CONFIG_MAC) */
>   
> @@ -369,7 +365,11 @@ int __init valkyriefb_init(void)
>   	}
>   	p->total_vram = 0x100000;
>   	p->frame_buffer_phys = frame_buffer_phys;
> -	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
> +#ifdef CONFIG_MAC
> +	p->frame_buffer = ioremap_nocache(frame_buffer_phys, p->total_vram);
> +#else
> +	p->frame_buffer = ioremap_wt(frame_buffer_phys, p->total_vram);
> +#endif
>   	p->cmap_regs_phys = cmap_regs_phys;
>   	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
>   	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
> 
