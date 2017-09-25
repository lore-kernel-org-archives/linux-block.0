Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:48288
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932135AbdIYCjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Sep 2017 22:39:36 -0400
From: Bough Chen <haibo.chen@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH V9 14/15] mmc: cqhci: support for command queue enabled
 host
Date: Mon, 25 Sep 2017 02:39:33 +0000
Message-ID: <AM4PR0401MB23242EB93D53E48BD31C95F7907A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-15-git-send-email-adrian.hunter@intel.com>
In-Reply-To: <1506083824-4024-15-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Friday, September 22, 2017 8:37 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; linux-block <linux-
> block@vger.kernel.org>; linux-kernel <linux-kernel@vger.kernel.org>; Boug=
h
> Chen <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
> Sahitya Tummala <stummala@codeaurora.org>; Harjani Ritesh
> <riteshh@codeaurora.org>; Venu Byravarasu <vbyravarasu@nvidia.com>;
> Linus Walleij <linus.walleij@linaro.org>; Shawn Lin <shawn.lin@rock-
> chips.com>; Christoph Hellwig <hch@lst.de>
> Subject: [PATCH V9 14/15] mmc: cqhci: support for command queue enabled
> host
>=20
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>=20
> This patch adds CMDQ support for command-queue compatible hosts.
>=20
> Command queue is added in eMMC-5.1 specification. This enables the
> controller to process upto 32 requests at a time.
>=20
> Adrian Hunter contributed renaming to cqhci, recovery, suspend and resume=
,
> cqhci_off, cqhci_wait_for_idle, and external timeout handling.
>=20
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/Kconfig  |   13 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/cqhci.c  | 1154
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h  |  240 ++++++++++
>  4 files changed, 1408 insertions(+)
>  create mode 100644 drivers/mmc/host/cqhci.c  create mode 100644
> drivers/mmc/host/cqhci.h
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig index
> 17afe1ad3a03..f2751465bc54 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -843,6 +843,19 @@ config MMC_SUNXI
>  	  This selects support for the SD/MMC Host Controller on
>  	  Allwinner sunxi SoCs.
>=20
> +config MMC_CQHCI
> +	tristate "Command Queue Host Controller Interface support"
> +	depends on HAS_DMA
> +	help
> +	  This selects the Command Queue Host Controller Interface (CQHCI)
> +	  support present in host controllers of Qualcomm Technologies, Inc
> +	  amongst others.
> +	  This controller supports eMMC devices with command queue support.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
>  config MMC_TOSHIBA_PCI
>  	tristate "Toshiba Type A SD/MMC Card Interface Driver"
>  	depends on PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile index
> 2b5a8133948d..f01d9915304d 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_ST)		+=3D sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+=3D sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+=3D sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)		+=3D sdhci-omap.o
> +obj-$(CONFIG_MMC_CQHCI)			+=3D cqhci.o
>=20
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+=3D -DDEBUG
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c new file
> mode 100644 index 000000000000..eb3c1695b0c7
> --- /dev/null
> +++ b/drivers/mmc/host/cqhci.c
> @@ -0,0 +1,1154 @@
> +/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/scatterlist.h>
> +#include <linux/platform_device.h>
> +#include <linux/ktime.h>
> +
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +
> +#include "cqhci.h"
> +
> +#define DCMD_SLOT 31
> +#define NUM_SLOTS 32
> +
> +struct cqhci_slot {
> +	struct mmc_request *mrq;
> +	unsigned int flags;
> +#define CQHCI_EXTERNAL_TIMEOUT	BIT(0)
> +#define CQHCI_COMPLETED		BIT(1)
> +#define CQHCI_HOST_CRC		BIT(2)
> +#define CQHCI_HOST_TIMEOUT	BIT(3)
> +#define CQHCI_HOST_OTHER	BIT(4)
> +};
> +
> +static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag) {
> +	return cq_host->desc_base + (tag * cq_host->slot_sz); }
> +
> +static inline u8 *get_link_desc(struct cqhci_host *cq_host, u8 tag) {
> +	u8 *desc =3D get_desc(cq_host, tag);
> +
> +	return desc + cq_host->task_desc_len;
> +}
> +
> +static inline dma_addr_t get_trans_desc_dma(struct cqhci_host *cq_host,
> +u8 tag) {
> +	return cq_host->trans_desc_dma_base +
> +		(cq_host->mmc->max_segs * tag *
> +		 cq_host->trans_desc_len);
> +}
> +
> +static inline u8 *get_trans_desc(struct cqhci_host *cq_host, u8 tag) {
> +	return cq_host->trans_desc_base +
> +		(cq_host->trans_desc_len * cq_host->mmc->max_segs * tag); }
> +
> +static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag) {
> +	u8 *link_temp;
> +	dma_addr_t trans_temp;
> +
> +	link_temp =3D get_link_desc(cq_host, tag);
> +	trans_temp =3D get_trans_desc_dma(cq_host, tag);
> +
> +	memset(link_temp, 0, cq_host->link_desc_len);
> +	if (cq_host->link_desc_len > 8)
> +		*(link_temp + 8) =3D 0;
> +
> +	if (tag =3D=3D DCMD_SLOT && (cq_host->mmc->caps2 &
> MMC_CAP2_CQE_DCMD)) {
> +		*link_temp =3D CQHCI_VALID(0) | CQHCI_ACT(0) |
> CQHCI_END(1);
> +		return;
> +	}
> +
> +	*link_temp =3D CQHCI_VALID(1) | CQHCI_ACT(0x6) | CQHCI_END(0);
> +
> +	if (cq_host->dma64) {
> +		__le64 *data_addr =3D (__le64 __force *)(link_temp + 4);
> +
> +		data_addr[0] =3D cpu_to_le64(trans_temp);
> +	} else {
> +		__le32 *data_addr =3D (__le32 __force *)(link_temp + 4);
> +
> +		data_addr[0] =3D cpu_to_le32(trans_temp);
> +	}
> +}
> +
> +static void cqhci_set_irqs(struct cqhci_host *cq_host, u32 set) {
> +	u32 ier;
> +
> +	ier =3D cqhci_readl(cq_host, CQHCI_ISTE);
> +	ier |=3D set;

Hi Adrian,

I think operation ' |=3D ' is not correct, since we will also call cqhci_se=
t_irqs(cq_host, 0),
Which means to mask all cmdq irq,  so I think better to directly write the =
parameter
 'set' to ISTE and ISGE.

Best Regards,
Haibo Chen

> +	cqhci_writel(cq_host, ier, CQHCI_ISTE);
> +	cqhci_writel(cq_host, ier, CQHCI_ISGE); }
> +
> +#define DRV_NAME "cqhci"
> +
