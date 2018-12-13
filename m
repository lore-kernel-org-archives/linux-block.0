Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E001FC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57820851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 15:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeLMPTm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:19:42 -0500
Received: from opengridcomputing.com ([72.48.214.68]:47178 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbeLMPTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 10:19:42 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 8731A2267C;
        Thu, 13 Dec 2018 09:19:41 -0600 (CST)
Subject: Re: [PATCH v2 2/6] nvme-core: allow __nvme_submit_sync_cmd to poll
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-3-sagi@grimberg.me>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <cfb3f950-b0ce-62f7-7888-a511592fa693@opengridcomputing.com>
Date:   Thu, 13 Dec 2018 09:19:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181213063819.13614-3-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> Pass poll bool to indicate that we need it to poll. This prepares us for
> polling support in nvmf since connect is an I/O that will be queued
> and has to be polled in order to complete.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c    | 13 ++++++++-----
>  drivers/nvme/host/fabrics.c | 10 +++++-----
>  drivers/nvme/host/nvme.h    |  2 +-
>  3 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f90576862736..eb1c10b0eaf0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -713,7 +713,7 @@ EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>  int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		union nvme_result *result, void *buffer, unsigned bufflen,
>  		unsigned timeout, int qid, int at_head,
> -		blk_mq_req_flags_t flags)
> +		blk_mq_req_flags_t flags, bool poll)
>  {
>  	struct request *req;
>  	int ret;
> @@ -730,7 +730,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  			goto out;
>  	}
>  
> -	blk_execute_rq(req->q, NULL, req, at_head);
> +	if (poll)
> +		blk_execute_rq_polled(req->q, NULL, req, at_head);
> +	else
> +		blk_execute_rq(req->q, NULL, req, at_head);
>  	if (result)
>  		*result = nvme_req(req)->result;
>  	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> @@ -747,7 +750,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		void *buffer, unsigned bufflen)
>  {
>  	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, 0, false);
>  }
>  EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
>  
> @@ -1058,7 +1061,7 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>  	c.features.dword11 = cpu_to_le32(dword11);
>  
>  	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
> -			buffer, buflen, 0, NVME_QID_ANY, 0, 0);
> +			buffer, buflen, 0, NVME_QID_ANY, 0, 0, false);
>  	if (ret >= 0 && result)
>  		*result = le32_to_cpu(res.u32);
>  	return ret;
> @@ -1703,7 +1706,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  	cmd.common.cdw10[1] = cpu_to_le32(len);
>  
>  	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
> -				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
> +				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0, false);
>  }
>  EXPORT_SYMBOL_GPL(nvme_sec_submit);
>  #endif /* CONFIG_BLK_SED_OPAL */
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 19ff0eae4582..d93a169f6403 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -159,7 +159,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>  	cmd.prop_get.offset = cpu_to_le32(off);
>  
>  	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, 0, false);
>  
>  	if (ret >= 0)
>  		*val = le64_to_cpu(res.u64);
> @@ -206,7 +206,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>  	cmd.prop_get.offset = cpu_to_le32(off);
>  
>  	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, 0, false);
>  
>  	if (ret >= 0)
>  		*val = le64_to_cpu(res.u64);
> @@ -252,7 +252,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>  	cmd.prop_set.value = cpu_to_le64(val);
>  
>  	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +			NVME_QID_ANY, 0, 0, false);
>  	if (unlikely(ret))
>  		dev_err(ctrl->device,
>  			"Property Set error: %d, offset %#x\n",
> @@ -406,7 +406,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  
>  	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
>  			data, sizeof(*data), 0, NVME_QID_ANY, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> +			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
>  	if (ret) {
>  		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
>  				       &cmd, data);
> @@ -468,7 +468,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>  
>  	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
>  			data, sizeof(*data), 0, qid, 1,
> -			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> +			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
>  	if (ret) {
>  		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
>  				       &cmd, data);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8e0ec365ce8d..75ed640a5ef0 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -444,7 +444,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		union nvme_result *result, void *buffer, unsigned bufflen,
>  		unsigned timeout, int qid, int at_head,
> -		blk_mq_req_flags_t flags);
> +		blk_mq_req_flags_t flags, bool flag);


Shouldn't the above be 'bool poll'?


Reviewed-by: Steve Wise <swise@opengridcomputing.com>

