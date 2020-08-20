Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC67C433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDC42076E
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 04:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgHTEdf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:33:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgHTEdf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 00:33:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id p14so432416wmg.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 21:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QzgP2JdM0qPTwMe/jCkl+XDhscjZvcTxYrmimKytpw=;
        b=IGSqadWxtOx042LUVKjjJgA3lLtOvEYu/xzhSX8oGtREFql7TwEfClCZhHTAK3fybm
         su0FR9VjMsg2yEXPbqnp22Heh9qyM5WEiy1vBc4hyzxV9T/sWdSU6fh1PlVyhppzeWil
         o+1YxkSvkpRB+T32786tEopLkzOVl0HBc7pY1vlOQBlGMqMj2ZcArf9Z/osfPhOlPCtf
         yqQLJDCoMlKe1ydZsHG053SrrcDwGAsFyTAhgDISvFasI7Vj9LayomaqDZKjRaGo3t+1
         D9isgW4xSW43AVu6KEiyDaykjIMatje9CGm/9zQ1MphWp1zc2CokjhzHuEuQqO+hYCCM
         QYEA==
X-Gm-Message-State: AOAM532rsnU02tZlYoZ6bcNvViBQiQuwmswCI/KLLEVXL32P3xv2pOur
        0OfqH74ux19iRG6p0pso7dY=
X-Google-Smtp-Source: ABdhPJxNna9sxjd0eucObDI/+lTjzuC4I+s1tf5CTdLFslyf+qoHhipGX6OO8EZUZu53PxZo3lPpnw==
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr1469276wmh.136.1597898012996;
        Wed, 19 Aug 2020 21:33:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3? ([2601:647:4802:9070:7ced:8569:4373:1bd3])
        by smtp.gmail.com with ESMTPSA id x11sm1630207wrl.28.2020.08.19.21.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 21:33:32 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
References: <20200820035357.1634-1-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
Date:   Wed, 19 Aug 2020 21:33:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820035357.1634-1-lengchao@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> nvme_revalidate_disk translate return error to 0 if it is not a fatal
> error, thus avoid false remove namespace. If return error less than 0,
> now only ENOMEM be translated to 0, but other error except ENODEV,
> such as EAGAIN or EBUSY etc, also need translate to 0.
> Another reason for improving the error translation: If request timeout
> when connect, __nvme_submit_sync_cmd will return
> NVME_SC_HOST_ABORTED_CMD(>0). At this time, should terminate the
> connect process, but falsely continue the connect process,
> this may cause deadlock. Many functions which call
> __nvme_submit_sync_cmd treat error code(> 0) as target not support and
> continue, but NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both
> are cancled io by host, to fix this bug, we need set the flag:
> NVME_REQ_CANCELLED, thus __nvme_submit_sync_cmd will translate return
> error to INTR. This is conflict with error translation of
> nvme_revalidate_disk, may cause false remove namespace.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4..43ac8a1ad65d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2130,10 +2130,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
>   	 * Only fail the function if we got a fatal error back from the
>   	 * device, otherwise ignore the error and just move on.
>   	 */
> -	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
> -		ret = 0;
> -	else if (ret > 0)
> +	if (ret > 0 && (ret & NVME_SC_DNR))
>   		ret = blk_status_to_errno(nvme_error_status(ret));
> +	else if (ret != -ENODEV)
> +		ret = 0;
>   	return ret;

We really need to take a step back here, I really don't like how
we are growing implicit assumptions on how statuses are interpreted.

Why don't we remove the -ENODEV error propagation back and instead
take care of it in the specific call-sites where we want to ignore
errors with proper quirks?
