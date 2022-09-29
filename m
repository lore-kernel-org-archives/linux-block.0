Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21484C4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 10:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiI2KEq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbiI2KEn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 06:04:43 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB1B7E3
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 03:04:41 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id l8so605512wmi.2
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 03:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FxkvvAfnCGuvjtfPXgTbYWw1JYp05+ALMY/xnHuKfn0=;
        b=jZ4T9PnE2hVw7UrWQ7SdQ8WBTVk8nZGnr6tWPkIkz7BmCsgj929e2ChYERyZxtTW32
         xTqj+ieaZoFYyO/bAe1p7ZtppuczC7gsAUM2EoEL+zoWa1kp5N9ljtQBOefB90fUEidf
         xpZ8svqni6sFENw5IcvMhlN8lIX3F6ZqbRZ4aA+TRhQeThEHiY7lypQya1LtHvBQwEDv
         F3xXQfSzT9bbkbhRosOvlAwltALTs2nnHedmAj3fJSgr99Ij1UrTwnAxb4qUfWH/mBXW
         9TAsdglFsAtZmiyBNShNIk5VDS1+mR9nDb9AXZFkzkj1NNRbj+R/TFobT+h3qSEGZse3
         xVPw==
X-Gm-Message-State: ACrzQf3GIFLB1KOhY3sp8F6ETs6VNrOy0T6wqPOs1PgFCe/zyqQIazzu
        o7+Ic2bUY6llPNWRVQnlszE=
X-Google-Smtp-Source: AMsMyM57k7IedzBt41w5fiHirYHurQJaovvOKJvMNF2wKvGL2tmQAsGZmlTr71s472zMk4IVShz0CA==
X-Received: by 2002:a05:600c:35c5:b0:3b4:bf50:f84a with SMTP id r5-20020a05600c35c500b003b4bf50f84amr1630072wmq.22.1664445879778;
        Thu, 29 Sep 2022 03:04:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003b4924493bfsm5026382wmq.9.2022.09.29.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:04:39 -0700 (PDT)
Message-ID: <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
Date:   Thu, 29 Sep 2022 13:04:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
In-Reply-To: <20220928195510.165062-2-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/28/22 22:55, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete);
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/apple.c     |  2 +-
>   drivers/nvme/host/core.c      | 10 ++++++++++
>   drivers/nvme/host/fc.c        |  2 +-
>   drivers/nvme/host/multipath.c | 18 ++++++++++++++++++
>   drivers/nvme/host/nvme.h      | 12 ++++++++++++
>   drivers/nvme/host/pci.c       |  2 +-
>   drivers/nvme/host/rdma.c      |  2 +-
>   drivers/nvme/host/tcp.c       |  2 +-
>   drivers/nvme/target/loop.c    |  2 +-
>   9 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..6df4b8a5d8ab 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -763,7 +763,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			goto out_free_cmd;
>   	}
>   
> -	blk_mq_start_request(req);
> +	nvme_start_request(req);
>   	apple_nvme_submit_cmd(q, cmnd);
>   	return BLK_STS_OK;
>   
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bacfd014e3d..f42e6e40d84b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>   	nvme_end_req_zoned(req);
>   	nvme_trace_bio_complete(req);
>   	blk_mq_end_request(req, status);
> +	if (req->cmd_flags & REQ_NVME_MPATH)
> +		nvme_mpath_end_request(req);

I guess the order should probably be reversed, because after
blk_mq_end_request req may become invalid and create UAF?
