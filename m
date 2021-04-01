Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310FCC43461
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101866112F
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhDAR6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhDARzg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 13:55:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A6C05BD20
        for <linux-block@vger.kernel.org>; Thu,  1 Apr 2021 06:01:23 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jy13so2770752ejc.2
        for <linux-block@vger.kernel.org>; Thu, 01 Apr 2021 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKucwrvqnS4ht56NCdJBx9ixTsgm/R5Veio9TkNchd4=;
        b=vU5K+nMRwdzl1ovjDPA/LcNRYNCAK+kL3SOr5YE4ZFIgc2bgUQofJFw3K1pi8nCj/F
         5usKW5GoZ19gPKAuTc49VuOwyGi9u6ao6UbCdpVYGc8F47h7ELB+tD3TQoQkuA3O47kL
         x5OYsOLIzkX4tHnmQeQ3RgiVrNCzpxsF8l0Ic1GwaYD8SKOL1TKHFvfv1j+ECET85lun
         jxTE3qQy0/4whF7B8RWXot/WDWrAVWXsMSJ44NrXCRFULgLQr/d4rgfoQDYEtvVrLIqg
         wTF6OpHP7wxFFCort23WIr1aqPZn2bnlUQItRt4/H/fy3oA0cC4dnETDFnatvlS6u7rS
         rEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKucwrvqnS4ht56NCdJBx9ixTsgm/R5Veio9TkNchd4=;
        b=O2BVQa6vBGI0wIxg6ixiNhvSBJ7HT/3RFLAOCSuF9mRBbdud12k2XcTgCgc8gUJkfb
         WeJWsmaZcwGQ4bY2URQP+hMjePTrdiQ/XYDqEQnz4okt/fImtMugPme93044dEpj7a5D
         XRiMAb+hEt7DneQajnzsz0j8zBp2eTURl3rrYIX3UkMFCKl84/6GfqRGDyltee/8kReZ
         42paZVEs++HDftnmkxhM+OTI1IixDe2rXJ9pSITYYKK84pIXM6dFt/5V8qj1+Yc6wkxR
         dHW7pRrY4A5Og2COzxKep6/4LuaNokZREvGLGuWLEt49SZMae0w4AMvq/FwUCNZq2yy/
         QOEg==
X-Gm-Message-State: AOAM533WBUwOYt7k2O18lnNeHDiU1rkxPbGXFv4VxVMj+DH7V3VaC2PF
        mRmjIKCYpeDPdiH7RXnmUl4MhA==
X-Google-Smtp-Source: ABdhPJw0Q0FmAEQV3rWyMyG72YjzxQat9aGGgn5eiai9dSLSwA7qAsnC7lnjcZuTYBRQB3d8XNHq0Q==
X-Received: by 2002:a17:907:7683:: with SMTP id jv3mr8912633ejc.450.1617282082032;
        Thu, 01 Apr 2021 06:01:22 -0700 (PDT)
Received: from linux.fritz.box (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id k12sm3467494edo.50.2021.04.01.06.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:01:21 -0700 (PDT)
Subject: Re: [Drbd-dev] [PATCH] drbd: Fix a use after free in
 get_initial_state
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
References: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Message-ID: <cb0f43e4-bfde-ac77-5153-f2f3cbed0172@linbit.com>
Date:   Thu, 1 Apr 2021 15:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210401115753.3684-1-lyl2019@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/1/21 1:57 PM, Lv Yunlong wrote:
> In get_initial_state, it calls notify_initial_state_done(skb,..) if
> cb->args[5]==1. I see that if genlmsg_put() failed in
> notify_initial_state_done(), the skb will be freed by nlmsg_free(skb).
> Then get_initial_state will goto out and the freed skb will be used by
> return value skb->len.
> 
> My patch lets skb_len = skb->len and return the skb_len to avoid the uaf.
> 
> Fixes: a29728463b254 ("drbd: Backport the "events2" command")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>   drivers/block/drbd/drbd_nl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index bf7de4c7b96c..474f84675d0a 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -4905,6 +4905,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	struct drbd_state_change *state_change = (struct drbd_state_change *)cb->args[0];
>   	unsigned int seq = cb->args[2];
>   	unsigned int n;
> +	unsigned int skb_len = skb->len;
>   	enum drbd_notification_type flags = 0;
>   
>   	/* There is no need for taking notification_mutex here: it doesn't
> @@ -4915,7 +4916,7 @@ static int get_initial_state(struct sk_buff *skb, struct netlink_callback *cb)
>   	cb->args[5]--;
>   	if (cb->args[5] == 1) {
>   		notify_initial_state_done(skb, seq);
> -		goto out;
> +		return skb_len;
>   	}
>   	n = cb->args[4]++;
>   	if (cb->args[4] < cb->args[3])
> 

Thanks for the patch!

I think the problem goes even further: skb can also be freed in the 
notify_*_state_change -> notify_*_state calls below.

Also, at the point where we save skb->len into skb_len, skb is not 
initialized yet. Maybe it makes more sense to not return a length in the 
first place here, but an error code instead.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
