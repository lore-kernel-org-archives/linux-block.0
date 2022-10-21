Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF7C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 02:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJUCtx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUCtu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:49:50 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289E44CE3
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:49:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtppW3CShzHv2F;
        Fri, 21 Oct 2022 10:49:39 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:49:47 +0800
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <22bbef32-b6a4-2a68-038e-9c906f2acc7e@huawei.com>
Date:   Fri, 21 Oct 2022 10:49:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-7-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> The NVME_NS_DEAD flag is only set in nvme_set_queue_dying, which is
> called in a loop over all namespaces in nvme_kill_queues.  Switch it
> to a controller flag checked and set outside said loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 16 +++++++---------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a74212a4f1a5f..fa7fdb744979c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4330,7 +4330,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
> -	if (test_bit(NVME_NS_DEAD, &ns->flags))
> +	if (test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
>   		goto out;
>   
>   	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
> @@ -4404,7 +4404,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   
>   	down_write(&ctrl->namespaces_rwsem);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
> +		if (ns->head->ns_id > nsid ||
> +		    test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
>   			list_move_tail(&ns->list, &rm_list);
>   	}
>   	up_write(&ctrl->namespaces_rwsem);
> @@ -5110,9 +5111,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
> -	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
> -		return;
> -
>   	blk_mark_disk_dead(ns->disk);
>   	nvme_start_ns_queue(ns);
>   }
> @@ -5129,14 +5127,14 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		nvme_set_queue_dying(ns);
> -
> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> +		list_for_each_entry(ns, &ctrl->namespaces, list)
> +			nvme_set_queue_dying(ns);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_kill_queues);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a29877217ee65..82989a3322130 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_FAILFAST_EXPIRED	= 0,
>   	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
>   	NVME_CTRL_STARTED_ONCE		= 2,
> +	NVME_CTRL_NS_DEAD     		= 3,
>   };
>   
>   struct nvme_ctrl {
> @@ -483,7 +484,6 @@ struct nvme_ns {
>   	unsigned long features;
>   	unsigned long flags;
>   #define NVME_NS_REMOVING	0
> -#define NVME_NS_DEAD     	1
>   #define NVME_NS_ANA_PENDING	2
>   #define NVME_NS_FORCE_RO	3
>   #define NVME_NS_READY		4
> 
