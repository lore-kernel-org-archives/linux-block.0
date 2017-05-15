Return-Path: <b.zolnierkie@samsung.com>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian
	Hunter <adrian.hunter@intel.com>, linux-block@vger.kernel.org, Jens Axboe
	<axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann
	<arnd@arndb.de>, Paolo Valente <paolo.valente@linaro.org>, Daniel Mack
	<daniel@zonque.org>, Marc Zyngier <marc.zyngier@arm.com>, "Steven J. Hill"
	<Steven.Hill@cavium.com>
Subject: Re: [PATCH 1/5] mmc: core: Delete bounce buffer Kconfig option
Date: Mon, 15 May 2017 16:04:04 +0200
Message-id: <3202707.f2tzK1cxd8@amdc3058>
In-reply-to: <20170510082418.10513-2-linus.walleij@linaro.org>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <20170510082418.10513-1-linus.walleij@linaro.org>
	<CGME20170510082450epcas1p148987e484907660670e2f875530c31c8@epcas1p1.samsung.com>
	<20170510082418.10513-2-linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>


Hi,

[ I added Daniel, Marc & Steven to cc: ]

On Wednesday, May 10, 2017 10:24:14 AM Linus Walleij wrote:
> This option is activated by all multiplatform configs and what
> not so we almost always have it turned on, and the memory it
> saves is negligible, even more so moving forward. The actual
> bounce buffer only gets allocated only when used, the only
> thing the ifdefs are saving is a little bit of code.
> 
> It is highly improper to have this as a Kconfig option that
> get turned on by Kconfig, make this a pure runtime-thing and
> let the host decide whether we use bounce buffers. We add a
> new property "disable_bounce" to the host struct.
> 
> Notice that mmc_queue_calc_bouncesz() already disables the
> bounce buffers if host->max_segs != 1, so any arch that has a
> maximum number of segments higher than 1 will have bounce
> buffers disabled.
> 
> The option CONFIG_MMC_BLOCK_BOUNCE is default y so the
> majority of platforms in the kernel already have it on, and
> it then gets turned off at runtime since most of these have
> a host->max_segs > 1. The few exceptions that have
> host->max_segs == 1 and still turn off the bounce buffering
> are those that disable it in their defconfig.
> 
> Those are the following:
> 
> arch/arm/configs/colibri_pxa300_defconfig
> arch/arm/configs/zeus_defconfig
> - Uses MMC_PXA, drivers/mmc/host/pxamci.c
> - Sets host->max_segs = NR_SG, which is 1
> - This needs its bounce buffer deactivated so we set
>   host->disable_bounce to true in the host driver

[...]

> arch/mips/configs/cavium_octeon_defconfig
> - Uses MMC_CAVIUM_OCTEON, drivers/mmc/host/cavium.c
> - Sets host->max_segs to 16 or 1
> - Setting host->disable_bounce to be sure for the 1 case

>From looking at the code it seems that bounce buffering should
be always beneficial to MMC performance when host->max_segs == 1.

It would be useful to know why these specific defconfigs
disable bounce buffering (to save memory?). Maybe the defaults
should be changed nowadays?

[...]

>  drivers/mmc/core/Kconfig  | 18 ------------------
>  drivers/mmc/core/queue.c  | 15 +--------------
>  drivers/mmc/host/cavium.c |  3 +++
>  drivers/mmc/host/pxamci.c |  6 ++++++
>  include/linux/mmc/host.h  |  1 +
>  5 files changed, 11 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index fc1ecdaaa9ca..42e89060cd41 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -61,24 +61,6 @@ config MMC_BLOCK_MINORS
>  
>  	  If unsure, say 8 here.
>  
> -config MMC_BLOCK_BOUNCE
> -	bool "Use bounce buffer for simple hosts"
> -	depends on MMC_BLOCK
> -	default y
> -	help
> -	  SD/MMC is a high latency protocol where it is crucial to
> -	  send large requests in order to get high performance. Many
> -	  controllers, however, are restricted to continuous memory
> -	  (i.e. they can't do scatter-gather), something the kernel
> -	  rarely can provide.
> -
> -	  Say Y here to help these restricted hosts by bouncing
> -	  requests back and forth from a large buffer. You will get
> -	  a big performance gain at the cost of up to 64 KiB of
> -	  physical memory.
> -
> -	  If unsure, say Y here.
> -
>  config SDIO_UART
>  	tristate "SDIO UART/GPS class support"
>  	depends on TTY
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 5c37b6be3e7b..545466342fb1 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -219,7 +219,6 @@ static struct mmc_queue_req *mmc_queue_alloc_mqrqs(int qdepth)
>  	return mqrq;
>  }
>  
> -#ifdef CONFIG_MMC_BLOCK_BOUNCE
>  static int mmc_queue_alloc_bounce_bufs(struct mmc_queue_req *mqrq, int qdepth,
>  				       unsigned int bouncesz)
>  {
> @@ -258,7 +257,7 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
>  {
>  	unsigned int bouncesz = MMC_QUEUE_BOUNCESZ;
>  
> -	if (host->max_segs != 1)
> +	if (host->max_segs != 1 || host->disable_bounce)
>  		return 0;
>  
>  	if (bouncesz > host->max_req_size)
> @@ -273,18 +272,6 @@ static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
>  
>  	return bouncesz;
>  }
> -#else
> -static inline bool mmc_queue_alloc_bounce(struct mmc_queue_req *mqrq,
> -					  int qdepth, unsigned int bouncesz)
> -{
> -	return false;
> -}
> -
> -static unsigned int mmc_queue_calc_bouncesz(struct mmc_host *host)
> -{
> -	return 0;
> -}
> -#endif
>  
>  static int mmc_queue_alloc_sgs(struct mmc_queue_req *mqrq, int qdepth,
>  			       int max_segs)
> diff --git a/drivers/mmc/host/cavium.c b/drivers/mmc/host/cavium.c
> index 58b51ba6aabd..66066f73e477 100644
> --- a/drivers/mmc/host/cavium.c
> +++ b/drivers/mmc/host/cavium.c
> @@ -1050,6 +1050,9 @@ int cvm_mmc_of_slot_probe(struct device *dev, struct cvm_mmc_host *host)
>  	else
>  		mmc->max_segs = 1;
>  
> +	/* Disable bounce buffers for max_segs = 1 */
> +	mmc->disable_bounce = true;
> +
>  	/* DMA size field can address up to 8 MB */
>  	mmc->max_seg_size = 8 * 1024 * 1024;
>  	mmc->max_req_size = mmc->max_seg_size;
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index c763b404510f..d3b5e6376504 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -666,6 +666,12 @@ static int pxamci_probe(struct platform_device *pdev)
>  	mmc->max_segs = NR_SG;
>  
>  	/*
> +	 * This architecture used to disable bounce buffers through its
> +	 * defconfig, now it is done at runtime as a host property.
> +	 */
> +	mmc->disable_bounce = true;
> +
> +	/*
>  	 * Our hardware DMA can handle a maximum of one page per SG entry.
>  	 */
>  	mmc->max_seg_size = PAGE_SIZE;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 21385ac0c9b1..b53c0e18a33b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -310,6 +310,7 @@ struct mmc_host {
>  	/* host specific block data */
>  	unsigned int		max_seg_size;	/* see blk_queue_max_segment_size */
>  	unsigned short		max_segs;	/* see blk_queue_max_segments */
> +	bool			disable_bounce; /* disable bounce buffers */
>  	unsigned short		unused;
>  	unsigned int		max_req_size;	/* maximum number of bytes in one req */
>  	unsigned int		max_blk_size;	/* maximum size of one mmc block */

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
