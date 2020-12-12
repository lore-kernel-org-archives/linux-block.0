Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5F6C4361B
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 18:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C49222571
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 18:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbgLLSOt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Dec 2020 13:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgLLSOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Dec 2020 13:14:49 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED5C0613CF
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 10:14:09 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id j1so6415128pld.3
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FWL4wQoGlY0BxMk5F/0WonbWq2wEWoSFd3bD5RoUIlw=;
        b=XjG0PvBD9hJymGpwLHwTvbj4vyy+6TkbCzmG4cFevCfTxrfYS8qd+FPI5tuZJ5NV8U
         mQT96I63c6KM0g1RuNXl44wCoremHWBW5tCyHcaWtCM08D6bhx3yqthw+atznKIJn9d8
         IjY0Udos4OHYjC7YhnDgRNjpGi5hdfLFKmlMjNx1Uom0O9RzKeSbmCeil0q0oaMRvau5
         6BPWUsdFeQesQatKBuXC3yeLkFGvKnNXi3eS488RAQoai0x2LrjmRS3hSyTmXtlINTx9
         JmyxAq8seBc9sNQjLwmGat+ht7MoQe/B3x/yQh1qribTPR6TUkSg+pdgi3FZkSfs9yEc
         12pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FWL4wQoGlY0BxMk5F/0WonbWq2wEWoSFd3bD5RoUIlw=;
        b=ayIUfpGKHTYmXaz1Mix+1UvxNYB29HOEdOPYcZaLgG8Kk52YDfPxE3tTprwN/t9MQi
         ltQnFz1WIG35IjRNueVOfGdMwX8EQkVjLAq1HWmG1uofWLP9laKnKHczysEhEJetnrkO
         9ckiYBmMKRcTiYGlqK4fdSH3EhN3ySQ8I/2vVVY1Fvr9wCjUP9CY74Gx5N/sj2qchKQR
         z1o1yb4nMxJC3ZxAtGBI8zLMD2MozPSzusRbwZrPsiXHK80+VcP9+tvYeusB5G1i/5Y+
         dkwWZuCuWKU1UAqJqKjlVfPWEVTUCQZW7snmNzPzzjX3gSvbzySWsJNG4KPvUgWnVGVj
         jYUg==
X-Gm-Message-State: AOAM533thD4ZWcTAPogSh45HcPEe8KmroNtnlxFK2Gqx4pRehWlZtwDn
        j+4togtVgsrtUSNX2pNxJwKdkQ==
X-Google-Smtp-Source: ABdhPJzqLJp9VmRmtaKbHGqiP6srHzYbiUe5A886DEctNbWA8Imo2Nfgp2jmileSnvUV9pYTAYtbeQ==
X-Received: by 2002:a17:902:6b:b029:da:725b:fcea with SMTP id 98-20020a170902006bb02900da725bfceamr16271516pla.16.1607796848490;
        Sat, 12 Dec 2020 10:14:08 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x28sm14550837pff.182.2020.12.12.10.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 10:14:07 -0800 (PST)
Subject: Re: [PATCH 0/3] blk-mq: trivial helper and fixes comments
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af283a24-0ece-0e8c-e57b-a29d64f0ab75@kernel.dk>
Date:   Sat, 12 Dec 2020 11:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/20 8:20 AM, Minwoo Im wrote:
> Hello,
> 
> This patch set contains:
>   - Introduce a helper to allocate tagset tags for the first time
>     without 'realloc' keyword that used to be taken.
>   - Fixes for comments need to be updated.
> 
> Please have a look.

Applied, thanks.

-- 
Jens Axboe

