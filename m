Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2749AC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C322DFA
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392076AbhALHss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 02:48:48 -0500
Received: from verein.lst.de ([213.95.11.211]:54203 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbhALHss (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:48:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 932E367373; Tue, 12 Jan 2021 08:48:05 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:48:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210112074805.GA24443@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index a50b7bcac67a..bdf09d8faa48 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>  		log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
>  		log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
>  		break;
> +	case NVME_CSI_ZNS:
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +			u32 *iocs = log->iocs;
> +
> +			iocs[nvme_cmd_zone_append]	= cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_send]	= cpu_to_le32(1 << 0);
> +			iocs[nvme_cmd_zone_mgmt_recv]	= cpu_to_le32(1 << 0);
> +		}
> +		break;

We need to return errors if the command set is not actually supported.
I also think splitting this into one helper per command set would
be nice.

> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>  	if (status)
>  		goto out;
>  
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +		u16 nvme_cis_zns = NVME_CSI_ZNS;
> +
> +		if (req->ns->csi == NVME_CSI_ZNS)
> +			status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +							  NVME_NIDT_CSI_LEN,
> +							  &nvme_cis_zns, &off);
> +		if (status)
> +			goto out;
> +	}

We need to add the CSI for every namespace, i.e. something like:

	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,
					  &req->ns->csi);		
	if (status)
		goto out;

and this hunk needs to go into the CSI patch.

>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>  			off) != NVME_IDENTIFY_DATA_SIZE - off)
>  		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>  	switch (req->cmd->identify.cns) {
>  	case NVME_ID_CNS_NS:
>  		return nvmet_execute_identify_ns(req);
> +	case NVME_ID_CNS_CS_NS:
> +		if (req->cmd->identify.csi == NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ns(req);
> +		break;
>  	case NVME_ID_CNS_CTRL:
>  		return nvmet_execute_identify_ctrl(req);
> +	case NVME_ID_CNS_CS_CTRL:
> +		if (req->cmd->identify.csi == NVME_CSI_ZNS)
> +			return nvmet_execute_identify_cns_cs_ctrl(req);
> +		break;

How does the CSI get mirrored into the cns field?

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 672e4009f8d6..17d5da062a5a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>  static inline bool nvmet_cc_css_check(u8 cc_css)
>  {
>  	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
> +	case NVME_CC_CSS_CSI:
>  	case NVME_CC_CSS_NVM:
>  		return true;
>  	default:
> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>  {
>  	/* command sets supported: NVMe command set: */
>  	ctrl->cap = (1ULL << 37);
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> +		ctrl->cap |= (1ULL << 43);
>  	/* CC.EN timeout in 500msec units: */
>  	ctrl->cap |= (15ULL << 24);
>  	/* maximum queue entries supported: */

This needs to go into a separate patch for multiple command set support.
We can probably merge the CAP and CC bits with the CSI support, though.

> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {

bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED
these days.

> +/*
> + *  ZNS related command implementation and helpers.
> + */

Well, that is the description of the whole file, isn't it?  I don't think
this comment adds much value.

> +	/*
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligned
> +	 * to the device physical block size. So use this value as the logical
> +	 * block size to avoid errors.
> +	 */

I do not understand the logic here, given that NVMe does not have
conventional zones.
