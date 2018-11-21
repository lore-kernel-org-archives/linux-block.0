Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A694C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 08:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7302146F
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 08:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7302146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeKUTaZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:30:25 -0500
Received: from verein.lst.de ([213.95.11.211]:50120 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbeKUTaZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 14:30:25 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 82C7168C19; Wed, 21 Nov 2018 09:56:45 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:56:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 14/14] nvme-tcp: add NVMe over TCP host driver
Message-ID: <20181121085645.GA29747@lst.de>
References: <20181120030019.31738-1-sagi@grimberg.me> <20181120030019.31738-16-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120030019.31738-16-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 07:00:16PM -0800, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi@lightbitslabs.com>
> 
> This patch implements the NVMe over TCP host driver. It can be used to
> connect to remote NVMe over Fabrics subsystems over good old TCP/IP.
> 
> The driver implements the TP 8000 of how nvme over fabrics capsules and
> data are encapsulated in nvme-tcp pdus and exchaged on top of a TCP byte
> stream. nvme-tcp header and data digest are supported as well.
> 
> To connect to all NVMe over Fabrics controllers reachable on a given taget
> port over TCP use the following command:
> 
> 	nvme connect-all -t tcp -a $IPADDR
> 
> This requires the latest version of nvme-cli with TCP support.
> 
> Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
> Signed-off-by: Roy Shterman <roys@lightbitslabs.com>
> Signed-off-by: Solganik Alexander <sashas@lightbitslabs.com>
> ---
>  drivers/nvme/host/Kconfig  |   15 +
>  drivers/nvme/host/Makefile |    3 +
>  drivers/nvme/host/tcp.c    | 2306 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2324 insertions(+)
>  create mode 100644 drivers/nvme/host/tcp.c
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 88a8b5916624..0f345e207675 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -57,3 +57,18 @@ config NVME_FC
>  	  from https://github.com/linux-nvme/nvme-cli.
>  
>  	  If unsure, say N.
> +
> +config NVME_TCP
> +	tristate "NVM Express over Fabrics TCP host driver"
> +	depends on INET
> +	depends on BLK_DEV_NVME
> +	select NVME_FABRICS
> +	help
> +	  This provides support for the NVMe over Fabrics protocol using
> +	  the TCP transport.  This allows you to use remote block devices
> +	  exported using the NVMe protocol set.
> +
> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
> +	  from https://github.com/linux-nvme/nvme-cli.
> +
> +	  If unsure, say N.
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index aea459c65ae1..8a4b671c5f0c 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
>  obj-$(CONFIG_NVME_FABRICS)		+= nvme-fabrics.o
>  obj-$(CONFIG_NVME_RDMA)			+= nvme-rdma.o
>  obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
> +obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
>  
>  nvme-core-y				:= core.o
>  nvme-core-$(CONFIG_TRACING)		+= trace.o
> @@ -21,3 +22,5 @@ nvme-fabrics-y				+= fabrics.o
>  nvme-rdma-y				+= rdma.o
>  
>  nvme-fc-y				+= fc.o
> +
> +nvme-tcp-y				+= tcp.o
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> new file mode 100644
> index 000000000000..4c583859f0ad
> --- /dev/null
> +++ b/drivers/nvme/host/tcp.c
> @@ -0,0 +1,2306 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * NVMe over Fabrics TCP host.
> + * Copyright (c) 2018 LightBits Labs. All rights reserved.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/nvme-tcp.h>
> +#include <net/sock.h>
> +#include <net/tcp.h>
> +#include <linux/blk-mq.h>
> +#include <crypto/hash.h>
> +
> +#include "nvme.h"
> +#include "fabrics.h"
> +
> +struct nvme_tcp_queue;
> +
> +enum nvme_tcp_send_state {
> +	NVME_TCP_SEND_CMD_PDU = 0,
> +	NVME_TCP_SEND_H2C_PDU,
> +	NVME_TCP_SEND_DATA,
> +	NVME_TCP_SEND_DDGST,
> +};
> +
> +struct nvme_tcp_send_ctx {
> +	struct bio		*curr_bio;
> +	struct iov_iter		iter;
> +	size_t			offset;
> +	size_t			data_sent;
> +	enum nvme_tcp_send_state state;
> +};
> +
> +struct nvme_tcp_recv_ctx {
> +	struct iov_iter		iter;
> +	struct bio		*curr_bio;
> +};

I don't understand these structures.  There should only be
a bio to be send or receive, not both.  Why do we need two
curr_bio pointers?

To me it seems like both structures should just go away and
move into nvme_tcp_request ala:


	struct bio		*curr_bio;

	/* send state */
	struct iov_iter		send_iter;
	size_t			send_offset;
	enum nvme_tcp_send_state send_state;
	size_t			data_sent;

	/* receive state */
	struct iov_iter		recv_iter;

