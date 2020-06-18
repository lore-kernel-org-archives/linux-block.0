Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F973C433DF
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A9220739
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 19:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgFRTlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:41:24 -0400
Received: from charlie.dont.surf ([128.199.63.193]:45994 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgFRTlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 15:41:23 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2020 15:41:22 EDT
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id DA454BF56E;
        Thu, 18 Jun 2020 19:35:59 +0000 (UTC)
Date:   Thu, 18 Jun 2020 21:35:56 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Subject: Re: [PATCHv2 5/5] nvme: support for zoned namespaces
Message-ID: <20200618193556.3s2gbkjsfotomot7@apples.localdomain>
References: <20200618145354.1139350-1-kbusch@kernel.org>
 <20200618145354.1139350-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200618145354.1139350-6-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 18 07:53, Keith Busch wrote:
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> new file mode 100644
> index 000000000000..d57fbbfe15e8
> --- /dev/null
> +++ b/drivers/nvme/host/zns.c
> @@ -0,0 +1,238 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/blkdev.h>
> +#include <linux/vmalloc.h>
> +#include "nvme.h"
> +
> +static int nvme_set_max_append(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_command c = { };
> +	struct nvme_id_ctrl_zns *id;
> +	int status;
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.cns = NVME_ID_CNS_CS_CTRL;
> +	c.identify.csi = NVME_CSI_ZNS;
> +
> +	status = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
> +	if (status) {
> +		kfree(id);
> +		return status;
> +	}
> +
> +	ctrl->max_zone_append = 1 << (id->zamds + 3);
> +	kfree(id);
> +	return 0;
> +}
> +
> +int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
> +			  unsigned lbaf)
> +{
> +	struct nvme_effects_log *log = ns->head->effects;
> +	struct request_queue *q = disk->queue;
> +	struct nvme_command c = { };
> +	struct nvme_id_ns_zns *id;
> +	int status;
> +
> +	/* Driver requires zone append support */
> +	if (!(log->iocs[nvme_cmd_zone_append] & NVME_CMD_EFFECTS_CSUPP))
> +		return -ENODEV;
> +
> +	/* Lazily query controller append limit for the first zoned namespace */
> +	if (!ns->ctrl->max_zone_append) {
> +		status = nvme_set_max_append(ns->ctrl);
> +		if (status)
> +			return status;
> +	}
> +
> +	id = kzalloc(sizeof(*id), GFP_KERNEL);
> +	if (!id)
> +		return -ENOMEM;
> +
> +	c.identify.opcode = nvme_admin_identify;
> +	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
> +	c.identify.cns = NVME_ID_CNS_CS_NS;
> +	c.identify.csi = NVME_CSI_ZNS;
> +
> +	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
> +	if (status)
> +		goto free_data;
> +
> +	/*
> +	 * We currently do not handle devices requiring any of the zoned
> +	 * operation characteristics.
> +	 */
> +	if (id->zoc) {
> +		status = -EINVAL;
> +		goto free_data;
> +	}

A dev_err() here would be nice. I had to dig a bit to track down why my
emulated device didn't show up ;)
