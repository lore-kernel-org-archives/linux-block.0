Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A21C433ED
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB88A613C0
	for <linux-block@archiver.kernel.org>; Tue, 13 Apr 2021 10:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245302AbhDMKyl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbhDMKyk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:54:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DBDC061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:54:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id mh2so3617663ejb.8
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kWM6YWNw3sQhkBrGWvR8Yt+o+cd1hxdL2Pb6mH6ok+g=;
        b=UeC2bcUTGYwxKp3JQVhGg3kAN8lLguvIhfDLnRVoqf4wh+bbiDukYGK0lGLtzEr7LY
         8w/NzMotvf0DfR/Fb7OLD5nloHvLBI7G7dR48q6FnKnWQMl04B4XiXoXS9ZPl4T0kBY8
         t5kWgTf5Xqg7PfFMYogmSDUQpfY3epNjgAu/odEn3JMTNZG4os4hiWvytrPAWRVnCLpe
         jN4PgJStr8h8/hecpUB1iQ89XglijD8cg5zbCftBb+CrcMATuCO4tdaPOLzAkXy1O3Ue
         NqrmK4FhDE01sk+vVLeXKt5WJGgTvCXglY7/m4yrGKP3CIBgDDFpl+5YS5DcO6HHiq1U
         Jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kWM6YWNw3sQhkBrGWvR8Yt+o+cd1hxdL2Pb6mH6ok+g=;
        b=rc9Wa5CojG4BQ3Z3h+0F1sj5+Zji/uRYhDxpLigdqwPJGIRVOEhODNvfMBy9OEx2Tk
         WM+EflHkHdlps6Uq9lcLHxp2SOGGHTcAB9L8LKXt7FTzSpIHahyvgVxeQZ2+XejdJi+O
         wOXFVXs9RliWaSD5PA0hPDjtYxxmYt6hH+xNE2SH/3l8MjxAblrpD+oLT91feawNAUbQ
         agubsbl5wXaumfLanNyC8XzLcwAhLLT2EJZm39EYzKTRy2CUGZ1qu8xHv7I9xi2Jjjqs
         C+RgZ1239bTLciyoyFvDdH0nhqpYsdAo6E2AVyBHz480jsDql2mbKeJPmwaM1V3jcjXn
         WJJw==
X-Gm-Message-State: AOAM531TskDSkTNp8wSvpUPuUl+lHkthi9yWYgWtcLxpSXjCXbQukxgV
        tZBJLahWd9HYE2fcg7SsraWAISJCXqRPCB70CCA=
X-Google-Smtp-Source: ABdhPJxfo6D5gIm697PZkk6Yornq7nPxIYMhVfpMxTmc71hNXm7N7sEvx0go6+WqL3rEe1mWgSEWUg==
X-Received: by 2002:a17:907:2d0c:: with SMTP id gs12mr17800725ejc.443.1618311260212;
        Tue, 13 Apr 2021 03:54:20 -0700 (PDT)
Received: from [10.0.0.62] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id cy5sm9259959edb.46.2021.04.13.03.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 03:54:19 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: Return the correct return value
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     linux-block@vger.kernel.org
References: <1618213134-21099-1-git-send-email-tiantao6@hisilicon.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0e4c8c3e-921b-0e49-c671-647dc09692e4@lightnvm.io>
Date:   Tue, 13 Apr 2021 12:54:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618213134-21099-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/04/2021 09.38, Tian Tao wrote:
> When memdup_user returns an error, memdup_user has two different return
> values, use PTR_ERR to get the correct return value.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>   drivers/lightnvm/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 28ddcaa..42774be 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -1257,7 +1257,7 @@ static long nvm_ioctl_info(struct file *file, void __user *arg)
>   
>   	info = memdup_user(arg, sizeof(struct nvm_ioctl_info));
>   	if (IS_ERR(info))
> -		return -EFAULT;
> +		return PTR_ERR(info);
>   
>   	info->version[0] = NVM_VERSION_MAJOR;
>   	info->version[1] = NVM_VERSION_MINOR;
Thanks, Tian. It has been pulled.
