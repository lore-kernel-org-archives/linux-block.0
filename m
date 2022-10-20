Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D7BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 20 Oct 2022 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJTNSn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 09:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJTNS2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 09:18:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738DB19D893
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:17:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so34159751wrp.10
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 06:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIE4tVkAl/8OtkJR94qMxzahBylE8N8vF8eOxMPkUwg=;
        b=HhBOaFEIiPdzrQ2VMPnM2u3OjFR6IwJrJ3x2gpO0QEG67JpQkI6lGyPaYYNYBnTD0W
         FYH15T+HkpP1jnthUb5cWPASoPv0qQqSwERNarw6PS7n/RudPQ+Xjs7GAYb0WGF/Slf7
         rkNN+Ls4wpDjmKE2rvNyLoiU8cSP3DadtgQh6cWXyt3Y4A+cLT4nF31t45cepZrX81Yt
         SW6jhUEtGVVm7Makys4yRcPHII2vuXJxyO1WPUt0AVHDsbR0RfcizxlVbHZLfitsh9XB
         VPLuovXUfTlT3rd4bPUTs9J176ny+QPDpIcT4BpOd2ekGCO9ClIvrwHb9VxEOvUMjaWM
         H3Tw==
X-Gm-Message-State: ACrzQf0z22cGG6Iv/lIzmqy06+fK7QQFr5+ly18iAG3P6+vNpLkIgrGy
        sPEvaeNqiXXfsH++flMdp0Y=
X-Google-Smtp-Source: AMsMyM5J+mYFaEbKwV+/XSzQKfWt6EmJQNjgkG3sHp/yWz21+2H1+HgE2q3N7AJSpbPK17XxATrYEA==
X-Received: by 2002:a5d:598d:0:b0:231:2304:3a5a with SMTP id n13-20020a5d598d000000b0023123043a5amr8734785wri.434.1666271450723;
        Thu, 20 Oct 2022 06:10:50 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4141000000b002238ea5750csm19907804wrq.72.2022.10.20.06.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:10:49 -0700 (PDT)
Message-ID: <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
Date:   Thu, 20 Oct 2022 16:10:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> This helper is pretty pointless now, and also in the way of per-tagset
> quiesce.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7fdb744979c..0ab3a18fd9f85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   		blk_mq_wait_quiesce_done(ns->queue->tag_set);
>   }
>   
> -/*
> - * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch.
> - */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> -{
> -	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
> -
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list)
> -			nvme_set_queue_dying(ns);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			blk_mark_disk_dead(ns->disk);
> +			nvme_start_ns_queue(ns);
> +		}

I have to say that I always found nvme_kill_queues interface somewhat
odd. its a core function that unquiesces the admin/io queues
assuming that they were stopped at some point by the driver.

If now there is no dependency between unquiesce and blk_mark_disk_dead,
maybe it would be a good idea to move the unquiescing to the drivers
which can pair with the quiesce itself, and rename it to
nvme_mark_namespaces_dead() or something?
