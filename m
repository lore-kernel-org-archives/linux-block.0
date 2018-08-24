Return-Path: <christophe.leroy@c-s.fr>
Message-Id: <a2546edda470a13885cf4a5af1d9d76151307a57.1535104490.git.christophe.leroy@c-s.fr>
In-Reply-To: <4f905a9d9752768c628623276f5e2fb465c947c8.1535104490.git.christophe.leroy@c-s.fr>
References: <4f905a9d9752768c628623276f5e2fb465c947c8.1535104490.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] drivers/video/fbdev: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date: Fri, 24 Aug 2018 10:04:57 +0000 (UTC)
List-ID: <linux-block@vger.kernel.org>

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/video/fbdev/controlfb.c  |  3 +--
 drivers/video/fbdev/platinumfb.c |  3 +--
 drivers/video/fbdev/valkyriefb.c | 10 ++++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 8d14b29aafea..058093990218 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -715,8 +715,7 @@ static int __init control_of_init(struct device_node *dp)
 		goto error_out;
 	}
 	/* map at most 8MB for the frame buffer */
-	p->frame_buffer = __ioremap(p->frame_buffer_phys, 0x800000,
-				    _PAGE_WRITETHRU);
+	p->frame_buffer = ioremap_wt(p->frame_buffer_phys, 0x800000);
 
 	if (!p->control_regs_phys ||
 	    !request_mem_region(p->control_regs_phys, p->control_regs_size,
diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index 377d3399a3ad..df79f102fbc6 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -577,8 +577,7 @@ static int platinumfb_probe(struct platform_device* odev)
 
 	/* frame buffer - map only 4MB */
 	pinfo->frame_buffer_phys = pinfo->rsrc_fb.start;
-	pinfo->frame_buffer = __ioremap(pinfo->rsrc_fb.start, 0x400000,
-					_PAGE_WRITETHRU);
+	pinfo->frame_buffer = ioremap_wt(pinfo->rsrc_fb.start, 0x400000);
 	pinfo->base_frame_buffer = pinfo->frame_buffer;
 
 	/* registers */
diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 275fb98236d3..0c6c1eede800 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -318,7 +318,7 @@ static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 int __init valkyriefb_init(void)
 {
 	struct fb_info_valkyrie	*p;
-	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
+	unsigned long frame_buffer_phys, cmap_regs_phys;
 	int err;
 	char *option = NULL;
 
@@ -337,7 +337,6 @@ int __init valkyriefb_init(void)
 	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
 	frame_buffer_phys = 0xf9000000;
 	cmap_regs_phys = 0x50f24000;
-	flags = IOMAP_NOCACHE_SER; /* IOMAP_WRITETHROUGH?? */
 #else /* ppc (!CONFIG_MAC) */
 	{
 		struct device_node *dp;
@@ -354,7 +353,6 @@ int __init valkyriefb_init(void)
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
-		flags = _PAGE_WRITETHRU;
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
@@ -369,7 +367,11 @@ int __init valkyriefb_init(void)
 	}
 	p->total_vram = 0x100000;
 	p->frame_buffer_phys = frame_buffer_phys;
-	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
+#ifdef CONFIG_MAC
+	p->frame_buffer = ioremap_nocache(frame_buffer_phys, p->total_vram);
+#else
+	p->frame_buffer = ioremap_wt(frame_buffer_phys, p->total_vram);
+#endif
 	p->cmap_regs_phys = cmap_regs_phys;
 	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
 	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
-- 
2.13.3
