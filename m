Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D854C433FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJTNak (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJTNai (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:30:38 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E192160236
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:30:35 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id y10so14943403wma.0
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKojxPlDMMLq/R5KbOnWiU0CR1Dux2GzEEVHTEbFsDI=;
        b=fKFQU0kBFArjQuXMaG7lYUE0ulLU6nESdtgnRnGh2+8BlvmtxxqGeGZ/+31NaeMtJR
         pkzeRHu+J5nyGUl5Gl9H8B5bBC95AZQ4XM069l8NVohSApII4KJl1T4Z0MRgvOVD16oP
         RKVMk+FAy9Q8VvjvjkcJ2+8JwKhMiKX/s06Gj3Jv/xUaEtmAqDd6XO6TOfF5wVyUlkrJ
         y28F5icOC2hKk4ic6mUZGty/OYHNNcIX6Ad+I2BuPEH7aGqk0bb9Ns0Rs3Vc1vh8vtri
         KRHlp8T89Pko+ypZpByQoJorZzbu2D0D3cIlbEheU6urGzzHG7EniDPL0Wyfh4Qqb9/q
         VIag==
X-Gm-Message-State: ACrzQf1EMRhVikodbMbAY4aGmxjv9pyrvDSrY/AWuXJn9knYQwBUuBkh
        J+NgMTPG+ikLGdoYOyZ0NaqD8m3qzJA=
X-Google-Smtp-Source: AMsMyM6WgG5OBBMTp6bmksHwmHjgE0Cb6tSezWSfJVyn7oUXB0ls76DBvacNRiFuxGK2xfmQU22zYA==
X-Received: by 2002:a05:600c:4588:b0:3c6:f8b2:dd34 with SMTP id r8-20020a05600c458800b003c6f8b2dd34mr13615571wmo.178.1666272623338;
        Thu, 20 Oct 2022 06:30:23 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b00228d6bc8450sm19557838wrn.108.2022.10.20.06.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:30:22 -0700 (PDT)
Message-ID: <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
Date:   Thu, 20 Oct 2022 16:30:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/20/22 13:56, Christoph Hellwig wrote:
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

Looking at it now, I'm not sure I understand the need for this flag. It
seems to make nvme_kill_queues reentrant safe, but the admin queue
unquiesce can still end up unbalanced under reentrance?

How is this not broken today (or ever since quiesce/unquiesce started
accounting)? Maybe I lost some context on the exact subtlety of how
nvme-pci uses this interface...

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
