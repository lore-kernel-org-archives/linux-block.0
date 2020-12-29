Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD2C433E0
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 23:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE2921D1B
	for <linux-block@archiver.kernel.org>; Tue, 29 Dec 2020 23:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL2Xne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Dec 2020 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL2Xnd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 18:43:33 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49495C06179B
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 15:42:53 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id q22so8741780pfk.12
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4Bj8R3CBvSLLqXZEXLAtLCkJF2/pgC4QbS3Flo515I=;
        b=fTTuZB7iU/GntjPlkOkOnWlss20rQLQ9sHuSinM6jGXWjrI/XIl2bE9MDwZc0HMmng
         c/5MpRxMYQcBv9tSJmRKUB6ZdknSOBVf8YpbhMobb2khk5HdD8I9zMS6jYJZXFY5lA1f
         mNUQdO2w5lcfL+q3Qy/syqG15KJQJow24ZELXVBo367bQEPRgGgQDF89y2mZ7WKq0iQ2
         lK3X4ZY7ELHnGKPGhhGUmzM3s2+dF99WOqap6H5LdlLtwRYXTBASVZpG9NgQwR1J7lwl
         vknzbe4iHWMxMxh1MMS/qPVm5xhjprbLEneTofPZdeCXAHkeUq8pU7LligkIzM0JA1rP
         ytsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4Bj8R3CBvSLLqXZEXLAtLCkJF2/pgC4QbS3Flo515I=;
        b=MBaGUCfbvw7Ki45VRJpuufArkP0RGXOZVARzqjvbf1/sn8zbzXy9G4g/3APFLtxLzZ
         sMrY7Zrmw6jW0XzuWzLCODeI3yJ3PsXo0doO3Q/DTZLFxWkEa0/hlstby4IV2efTT7QN
         HoUdcMvljykqfTcL6F4njxVsRPxDpTU6Igtg+xYG147zuqYLN2GN+EBfKHv99Vaje/Sj
         j1llKVoKK7npA2SMKxA8iJR3DHr5ETpGPQylDxkhEM8/UjsjE8WzpZ3JlOBItRDGFGyQ
         S7AEzbUX1WkKeUp4hfTijxO5qdTdLwy+XQWysSLpyufpYUvgdXHdONmq3bNCz1hXL1Pt
         fklA==
X-Gm-Message-State: AOAM530Jkbo+uBBVI9z22DhcUewP7ysbvrCwO8Q7Ai0ZS26DoZyjRDFf
        04n746y/XcmNRb6DbVYn577eJAahKf1dew==
X-Google-Smtp-Source: ABdhPJzspcMDHWJuLnzSJYt8zopcP6WTzV7PbdwkVQnDnz5XY+EQYIwMMEmOpy3OVcMOhtvftKO/mg==
X-Received: by 2002:a62:5e44:0:b029:1a4:daae:e765 with SMTP id s65-20020a625e440000b02901a4daaee765mr46537636pfb.8.1609285372176;
        Tue, 29 Dec 2020 15:42:52 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id t1sm14595051pfq.154.2020.12.29.15.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:42:51 -0800 (PST)
Subject: Re: [PATCH -next] aoe: Use kzalloc for allocating only one thing
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     justin@coraid.com
References: <20201229135120.23537-1-zhengyongjun3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da043bd3-8446-d0bc-bbbc-b3996afce4b8@kernel.dk>
Date:   Tue, 29 Dec 2020 16:42:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229135120.23537-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/29/20 6:51 AM, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>           ...)
> // </smpl>

Should probably fix up that missing set of () while at it.

-- 
Jens Axboe

