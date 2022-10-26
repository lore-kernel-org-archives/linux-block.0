Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C734C38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiJZMwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiJZMwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:52:32 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145FF07F8
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:52:28 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id w14so1881954wru.8
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMX25NFeojUzl7wweYcmWjYVH+c9Jz/n1YntA1yElaE=;
        b=sDlFLhDo1s99D+7lC59t6PHsNk0SraJ/TAYykZwOosNj3qWSPA/hnCxu0p9O9/EUZk
         FAUH5G8FXeVLtkgifZdBoSACmtC2bT1PPQmRy6TwK2BMMwvqTSUZJ8Nv+sLXX88Eqlgb
         iSLOHNF2eWebJ4Ioz9m/8sJU2kC/f35TOq5aRP/q0hjIdbp990C0whmp7HjFGK9K6Opk
         9eLw6WoXfrENaVLmfGJjSuysoT8cR5xEh9U6F8TgLAveIJOlB8Y1/PQRo0gjonEeJBkl
         X20Fk/I1qT9NFL2K9d5f7SwJPiE42ddESYpFRh48T0rfVe4TlRUO6ax+kx0kRxcQoRW+
         VVOQ==
X-Gm-Message-State: ACrzQf17H1uYA+if6sP/H0lAYoT1Cu5MYuR4u2F55Sdb+szdu5qih320
        cI7KF1SlUdL6ElO+deeizec=
X-Google-Smtp-Source: AMsMyM7YhzNq7Sr4UbWF18bzQw4syqt03+a1XNQZSWLb73Wv/6I7YX+1Rkf0AiUir8G3JFU7wJoUVg==
X-Received: by 2002:adf:f743:0:b0:236:7309:1209 with SMTP id z3-20020adff743000000b0023673091209mr9791475wrp.14.1666788747515;
        Wed, 26 Oct 2022 05:52:27 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t11-20020adfdc0b000000b002365254ea42sm5266202wri.1.2022.10.26.05.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:52:26 -0700 (PDT)
Message-ID: <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
Date:   Wed, 26 Oct 2022 15:52:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 07/17] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-8-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> We never rescan namespaces after marking them dead, so this check is dead
> now.

scan_work can still run, I'd keep this one.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2ec838e608509..99eabbe7fac98 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4333,10 +4333,6 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
> -	if (test_bit(NVME_NS_DEAD, &ns->flags))
> -		goto out;
> -
> -	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
>   		dev_err(ns->ctrl->device,
>   			"identifiers changed for nsid %d\n", ns->head->ns_id);
