Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56EAC38A2D
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiJZMtT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbiJZMtL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:49:11 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF315EC1CE
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:49:09 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w14so1866974wru.8
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OuWhWTANesBuaVz9a5G8CeCa16HNfzUwXxQUSd7rH4=;
        b=VO1X7ae3CnObRKDBKpmF7kjzPResexB82GaEsV9Zd3sVMMnnG1HguQHdnwfKNJKeO7
         o3TqcrzVpK3rjGSzLIkEIC3wtNEG6aYyT57/VFwhXpz8BGbKpP1wwfLVkaNCGBlrZ/tp
         l8YbznZKjenOOeba0M9R7zP9QOGjAJia6LXACAPC5Hm1hNDdXEdz2bA3Fe3OB05arNOB
         XE1qSL0dGg6kLttRDo7FVD3RgbrjbWShYd4xSTekesDKlNe+UYpo+N4xLCXtvpW2z/Lp
         +Ot83li0lXZ0vOPHg8uLZN5MUD4DEreHJBLnB5hGARLtv7xO9ReilIgdn2Hu9A7hO7UZ
         svyw==
X-Gm-Message-State: ACrzQf2DfRQ0SlKLTUZBLkk3R4/OddidQYFcIsSV4cdZ8j90+FJ8GOil
        Xe+jf0tVbrD3A2OCLwtUKiyqqsXMeZY=
X-Google-Smtp-Source: AMsMyM6unar3omaVFyALulU/QQJJuXjmpkKZLYF8CSt1Q78QYL7KykC0lEZMXqQdlGZJ0uiWcq1yiA==
X-Received: by 2002:a5d:6d06:0:b0:232:b56c:e5c3 with SMTP id e6-20020a5d6d06000000b00232b56ce5c3mr27511859wrq.506.1666788548517;
        Wed, 26 Oct 2022 05:49:08 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d4c90000000b0022afcc11f65sm5329244wrs.47.2022.10.26.05.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:49:07 -0700 (PDT)
Message-ID: <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
Date:   Wed, 26 Oct 2022 15:49:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/17] nvme-pci: don't warn about the lack of I/O queues
 for admin controllers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-4-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Admin controllers never have I/O queues, so don't warn about that fact.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 51513d263d77a..ec034d4dd9eff 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2917,7 +2917,8 @@ static void nvme_reset_work(struct work_struct *work)
>   			nvme_dbbuf_set(dev);
>   			nvme_unfreeze(&dev->ctrl);
>   		} else {
> -			dev_warn(dev->ctrl.device, "IO queues lost\n");
> +			if (dev->ctrl.cntrltype != NVME_CTRL_ADMIN)
> +				dev_warn(dev->ctrl.device, "IO queues lost\n");

I have a feeling that we have quite a few other messages that are
irrelevant for admin controllers. And I wander what device you have that
presents an admin controller, but looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
