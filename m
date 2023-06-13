Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37830C7EE29
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 13:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbjFMNQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242263AbjFMNQM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 09:16:12 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B991AA
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:16:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f80cbc37c5so4740915e9.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662170; x=1689254170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uwyanm7aPiwT2URnmQPNCsZAs5PazOw3dHtU2QXV4w=;
        b=YdeppAtrQK5a6wlYwWVY2+fwWrapSiAI2FrKFwF5I2m6FPEEn6tbGplMCBF2ldZ+vl
         kD3VAEE3iL/jQ/YHIt9+yItEGWnLTuH6XXSqDpa32seMyKJsTnLfirrSIJzxeB1D5xc2
         DZigJfQqqSZQgZnacC3tCdS+NmMDOE/hPXfRQMjgOfSUmaFy+r2mKfys26lTsn+JyMX9
         7WMPkrakqFwfCJn5KkpeZ9qtQaxjplDdnY0zO1POyblljvRGtDouak9dTmN8kafwUYHd
         8tiHopF8h29aXOq9349SEYRNJPQNC8m+wvBt8D/3XVimee6uNA+Mq9wYhQGLu0x+9hzK
         yYNA==
X-Gm-Message-State: AC+VfDzcQ4e/ib2raYbtLVFWnldp4VWqZ1oSjtMpeWRqpASlXfbJ2J0c
        BwHulxXCErB2uMy0jeK1rFk=
X-Google-Smtp-Source: ACHHUZ4/nkf99jwi3l8QGzyAoS9Xa2Z1rJW5PmAhphkmb+ZabgH0B7a9IPE7v21nmrimuicMRIimVQ==
X-Received: by 2002:a05:600c:198c:b0:3f7:f2df:4e3e with SMTP id t12-20020a05600c198c00b003f7f2df4e3emr10021578wmq.3.1686662169762;
        Tue, 13 Jun 2023 06:16:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bcd18000000b003f8cdb1414esm1679025wmj.8.2023.06.13.06.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:16:09 -0700 (PDT)
Message-ID: <1dfd132b-cf6e-6097-1977-2450b324ebf0@grimberg.me>
Date:   Tue, 13 Jun 2023 16:16:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] nvme: core: unquiesce io queues when removing
 namespaces
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-2-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230613005847.1762378-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> When error recovery is interrupted by controller removal, the controller
> is left as quiesced, then IO hang can be caused.
> 
> Fix the issue by unquiescing controller unconditionally when removing
> namespaces.
> 
> Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
> Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..4ef5eaecaa75 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4692,6 +4692,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_mpath_clear_ctrl_paths(ctrl);
>   
> +	/*
> +	 * Unquiesce io queues so any pending IO won't hang, especially
> +	 * those submitted from scan work
> +	 */
> +	nvme_unquiesce_io_queues(ctrl);
> +

Looks fine, but I think that the removal of the unquiesce from
the condition below (CTRL_DEAD) should be done in this patch.

>   	/* prevent racing with ns scanning */
>   	flush_work(&ctrl->scan_work);
>   
