Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B3EC48BDF
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D083F613AD
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhFKCQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:16:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:5331 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhFKCQI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 22:16:08 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G1PRH4blXz1BJJy;
        Fri, 11 Jun 2021 10:09:15 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 10:14:09 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 10:14:09 +0800
Subject: Re: [PATCH V15 4/5] nvmet: add Command Set Identifier support
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, <sagi@grimberg.me>, <hch@lst.de>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
 <20210610013252.53874-5-chaitanya.kulkarni@wdc.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <923a0c0e-2f5f-e2f7-aa3b-b4feddd754b2@huawei.com>
Date:   Fri, 11 Jun 2021 10:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20210610013252.53874-5-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/6/10 9:32, Chaitanya Kulkarni wrote:
> NVMe TP 4056 allows controllers to support different command sets.
> NVMeoF target currently only supports namespaces that contain
> traditional logical blocks that may be randomly read and written. In
> some applications there is a value in exposing namespaces that contain
> logical blocks that have special access rules (e.g. sequentially write
> required namespace such as Zoned Namespace (ZNS)).
> 
> In order to support the Zoned Block Devices (ZBD) backend, controllers
> need to have support for ZNS Command Set Identifier (CSI).
> 
> In this preparation patch, we adjust the code such that it can now
> support the default command set identifier. We update the namespace data
> structure to store the CSI value which defaults to NVME_CSI_NVM
> that represents traditional logical blocks namespace type.
> 
> The CSI support is required to implement the ZBD backend for NVMeOF
> with host side NVMe ZNS interface, since ZNS commands belong to
> the different command set than the default one.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/target/admin-cmd.c | 75 +++++++++++++++++++++++++++------
>   drivers/nvme/target/core.c      | 28 +++++++++---
>   drivers/nvme/target/nvmet.h     |  1 +
>   include/linux/nvme.h            |  1 +
>   4 files changed, 87 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 3de6a6c99b01..93aaa7479e71 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -162,15 +162,8 @@ static void nvmet_execute_get_log_page_smart(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> -static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
> +static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
>   {
> -	u16 status = NVME_SC_INTERNAL;
> -	struct nvme_effects_log *log;
> -
> -	log = kzalloc(sizeof(*log), GFP_KERNEL);
> -	if (!log)
> -		goto out;
> -
>   	log->acs[nvme_admin_get_log_page]	= cpu_to_le32(1 << 0);
>   	log->acs[nvme_admin_identify]		= cpu_to_le32(1 << 0);
>   	log->acs[nvme_admin_abort_cmd]		= cpu_to_le32(1 << 0);
> @@ -184,9 +177,30 @@ static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
>   	log->iocs[nvme_cmd_flush]		= cpu_to_le32(1 << 0);
>   	log->iocs[nvme_cmd_dsm]			= cpu_to_le32(1 << 0);
>   	log->iocs[nvme_cmd_write_zeroes]	= cpu_to_le32(1 << 0);
> +}
>   
> -	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
> +static void nvmet_execute_get_log_cmd_effects_ns(struct nvmet_req *req)
> +{
> +	struct nvme_effects_log *log;
> +	u16 status = NVME_SC_SUCCESS;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL);
> +	if (!log) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	switch (req->cmd->get_log_page.csi) {
> +	case NVME_CSI_NVM:
> +		nvmet_get_cmd_effects_nvm(log);
> +		break;
> +	default:
> +		status = NVME_SC_INVALID_LOG_PAGE;
> +		goto free;
> +	}
>   
> +	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
> +free:
>   	kfree(log);
>   out:
>   	nvmet_req_complete(req, status);
> @@ -613,6 +627,12 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>   			goto out;
>   	}
>   
> +	status = nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,
> +					  NVME_NIDT_CSI_LEN,
> +					  &req->ns->csi, &off);
> +	if (status)
> +		goto out;
> +
>   	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
>   			off) != NVME_IDENTIFY_DATA_SIZE - off)
>   		status = NVME_SC_INTERNAL | NVME_SC_DNR;
> @@ -621,6 +641,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
>   	nvmet_req_complete(req, status);
>   }
>   
> +static bool nvmet_handle_identify_desclist(struct nvmet_req *req)
> +{
> +	switch (req->cmd->identify.csi) {
> +	case NVME_CSI_NVM:
> +		nvmet_execute_identify_desclist(req);
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static void nvmet_execute_identify(struct nvmet_req *req)
>   {
>   	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -628,13 +659,31 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   
>   	switch (req->cmd->identify.cns) {
>   	case NVME_ID_CNS_NS:
> -		return nvmet_execute_identify_ns(req);
> +		switch (req->cmd->identify.csi) {
> +		case NVME_CSI_NVM:
> +			return nvmet_execute_identify_ns(req);
> +		default:
> +			break;
> +		}
> +		break;
>   	case NVME_ID_CNS_CTRL:
> -		return nvmet_execute_identify_ctrl(req);
> +		switch (req->cmd->identify.csi) {
> +		case NVME_CSI_NVM:
> +			return nvmet_execute_identify_ctrl(req);
> +		}

Is it missing to add the default branch here ?

> +		break;
>   	case NVME_ID_CNS_NS_ACTIVE_LIST:
> -		return nvmet_execute_identify_nslist(req);
> +		switch (req->cmd->identify.csi) {
> +		case NVME_CSI_NVM:
> +			return nvmet_execute_identify_nslist(req);
> +		default:
> +			break;
> +		}
> +		break;
>   	case NVME_ID_CNS_NS_DESC_LIST:
> -		return nvmet_execute_identify_desclist(req);
> +		if (nvmet_handle_identify_desclist(req) == true)
> +			return;
> +		break;
>   	}
>   
>   	nvmet_req_cns_error_complete(req);
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 146909486b8f..ac53a1307ce4 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -692,6 +692,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>   
>   	uuid_gen(&ns->uuid);
>   	ns->buffered_io = false;
> +	ns->csi = NVME_CSI_NVM;
>   
>   	return ns;
>   }
> @@ -887,10 +888,14 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>   		return ret;
>   	}
>   
> -	if (req->ns->file)
> -		return nvmet_file_parse_io_cmd(req);
> -
> -	return nvmet_bdev_parse_io_cmd(req);
> +	switch (req->ns->csi) {
> +	case NVME_CSI_NVM:
> +		if (req->ns->file)
> +			return nvmet_file_parse_io_cmd(req);
> +		return nvmet_bdev_parse_io_cmd(req);
> +	default:
> +		return NVME_SC_INVALID_IO_CMD_SET;
> +	}
>   }
>   
>   bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
> @@ -1112,6 +1117,17 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
>   	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
>   }
>   
> +static inline bool nvmet_css_supported(u8 cc_css)
> +{
> +	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
> +	case NVME_CC_CSS_NVM:
> +	case NVME_CC_CSS_CSI:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>   static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   {
>   	lockdep_assert_held(&ctrl->lock);
> @@ -1131,7 +1147,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   
>   	if (nvmet_cc_mps(ctrl->cc) != 0 ||
>   	    nvmet_cc_ams(ctrl->cc) != 0 ||
> -	    nvmet_cc_css(ctrl->cc) != 0) {
> +	    !nvmet_css_supported(nvmet_cc_css(ctrl->cc))) {
>   		ctrl->csts = NVME_CSTS_CFS;
>   		return;
>   	}
> @@ -1182,6 +1198,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
>   {
>   	/* command sets supported: NVMe command set: */
>   	ctrl->cap = (1ULL << 37);
> +	/* Controller supports one or more I/O Command Sets */
> +	ctrl->cap |= (1ULL << 43);
>   	/* CC.EN timeout in 500msec units: */
>   	ctrl->cap |= (15ULL << 24);
>   	/* maximum queue entries supported: */
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index d4bcfeb570e5..4ca558b94955 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -83,6 +83,7 @@ struct nvmet_ns {
>   	struct pci_dev		*p2p_dev;
>   	int			pi_type;
>   	int			metadata_size;
> +	u8			csi;
>   };
>   
>   static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index edcbd60b88b9..c7ba83144d52 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1504,6 +1504,7 @@ enum {
>   	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
>   	NVME_SC_CMD_INTERRUPTED		= 0x21,
>   	NVME_SC_TRANSIENT_TR_ERR	= 0x22,
> +	NVME_SC_INVALID_IO_CMD_SET	= 0x2C,
>   
>   	NVME_SC_LBA_RANGE		= 0x80,
>   	NVME_SC_CAP_EXCEEDED		= 0x81,
> 

