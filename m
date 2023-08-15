Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5564CC001B0
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 12:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjHOMks (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Aug 2023 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjHOMki (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Aug 2023 08:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED302F7
        for <linux-block@vger.kernel.org>; Tue, 15 Aug 2023 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692103189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fOoisqtD4tWSvw/NguWbEb9nx26NfioCD1H8k3AKHtA=;
        b=DGz1GmOjDkXa96rFyQ86t4lXsOvDuHxDuJQxptSIfLciNdmVEtLGxocTVWocdtGQNvtNnY
        0YMDq7MP8qh33lchLqiaBcToCnVbOLEkS1hNOcSbIR4vWe3tvFkkDSZVNG9OGoncbRnxIq
        ijNl5GhPIscGRMBWfKRAxNuMohZtRGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-AZVHXd0dPQilttig_KwY-g-1; Tue, 15 Aug 2023 08:39:45 -0400
X-MC-Unique: AZVHXd0dPQilttig_KwY-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BEC1185A78B;
        Tue, 15 Aug 2023 12:39:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEF31121314;
        Tue, 15 Aug 2023 12:39:42 +0000 (UTC)
Date:   Tue, 15 Aug 2023 20:39:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH -next] ublk: Switch to memdup_user_nul() helper
Message-ID: <ZNtyCQoso3RNMvwp@fedora>
References: <20230815114815.1551171-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815114815.1551171-1-ruanjinjie@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 15, 2023 at 07:48:14PM +0800, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding
> to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/block/ublk_drv.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 85a81ee556d5..fa7e6955eb3b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2743,14 +2743,9 @@ static int ublk_ctrl_uring_cmd_permission(struct ublk_device *ub,
>  	if (header->len < header->dev_path_len)
>  		return -EINVAL;
>  
> -	dev_path = kmalloc(header->dev_path_len + 1, GFP_KERNEL);
> -	if (!dev_path)
> -		return -ENOMEM;
> -
> -	ret = -EFAULT;
> -	if (copy_from_user(dev_path, argp, header->dev_path_len))
> -		goto exit;
> -	dev_path[header->dev_path_len] = 0;
> +	dev_path = memdup_user_nul(argp, header->dev_path_len);
> +	if (IS_ERR(dev_path))
> +		return PTR_ERR(dev_path);

Nice cleanup:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

