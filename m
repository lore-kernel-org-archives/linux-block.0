Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E8C433FE
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiJZMz7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiJZMz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:55:58 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69406DAC6C
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:55:57 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id y16so15716437wrt.12
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0crHdE2hZ9v6vZdx+/Bi6/efznl0nuytc8l/nV3BRY=;
        b=eZte/qDaEkPMb+Gvj/4mM3H2d7dH0Jx4IK+ja7nFzZnSbAYqU94rVo2N7/juIObL0U
         rBLr5p8rlryvRd/NkORCSrrYpOP9gmQP76VxsO6J5AB+xSLlxsg/QsEXQdIIV7pIciQe
         ml4Q1MlPUiU6tnM4v5b+oXmWgEA7ciq5cQO/wZp0D3DQiXIWah01/SlyYBrBqFV2fIqd
         YXSBRW2YbWjAHqd4Ehbu03levBxOJhSM+ZOmy/spLyqNyHvQjnUbNSoPV9UEgp+JnbBX
         A/DDX+7cVcCHgjjepK1JfMQUyq2nqZb5fy9WcsV4oBsn1quFwemswHORzq7z6hXVPMaK
         kIAw==
X-Gm-Message-State: ACrzQf1xww5tutymrilPlXD6XoVI9aHD4AfiKvH451i2T+CxFWgjsesm
        PhAJUAOokxNBnomdckJAph4=
X-Google-Smtp-Source: AMsMyM5RkIWFpdjuQfuwzSBjuJDQWcLER6jVaPYuEUh5BKRgzHF7Vet6+OIlHKVHeV9X4LXdwj6u0g==
X-Received: by 2002:a05:6000:1561:b0:22e:6c59:e347 with SMTP id 1-20020a056000156100b0022e6c59e347mr29585871wrz.519.1666788956039;
        Wed, 26 Oct 2022 05:55:56 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c338100b003a3170a7af9sm1811759wmp.4.2022.10.26.05.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:55:55 -0700 (PDT)
Message-ID: <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
Date:   Wed, 26 Oct 2022 15:55:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> When we have a non-present controller there is no reason to wait in
> marking the namespaces dead, so do it ASAP.  Also remove the superflous
> call to nvme_start_queues as nvme_dev_disable already did that for us.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ab54857cfd50..bef98f6e1396c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>   	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>   	pci_set_drvdata(pdev, NULL);
>   
> +	/*
> +	 * Mark the namespaces dead as we can't flush the data, and disable the
> +	 * controller ASAP as we can't shut it down properly if it was surprise
> +	 * removed.
> +	 */
>   	if (!pci_device_is_present(pdev)) {
>   		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
> +		nvme_mark_namespaces_dead(&dev->ctrl);

Don't you need to start the queues as well here?

>   		nvme_dev_disable(dev, true);
>   	}
>   
>   	flush_work(&dev->ctrl.reset_work);
>   	nvme_stop_ctrl(&dev->ctrl);
> -
> -	/*
> -	 * The dead states indicates the controller was not gracefully
> -	 * disconnected. In that case, we won't be able to flush any data while
> -	 * removing the namespaces' disks; fail all the queues now to avoid
> -	 * potentially having to clean up the failed sync later.
> -	 */
> -	if (dev->ctrl.state == NVME_CTRL_DEAD) {
> -		nvme_mark_namespaces_dead(&dev->ctrl);
> -		nvme_start_queues(&dev->ctrl);
> -	}
> -
>   	nvme_remove_namespaces(&dev->ctrl);
>   	nvme_dev_disable(dev, true);
>   	nvme_remove_attrs(dev);
