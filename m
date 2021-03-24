Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E631C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A81619D5
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhCXM5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbhCXM4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:56:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FEDC0613DE
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v2so14571222pgk.11
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BRsabgXq1j/oZODFUT1sBBvOqEOBW7MpFRgZymkaaUA=;
        b=A99XLQZDgZ/5k/F3KdS2TsU8Q4orPYziYZf2YsYkzLzMn1xb9ZEnAQkE3CSnhoR4Vg
         N/tFuW4/K9C4XwdQb2BVjcywh7QQNtf63Kw/lqkcv4bEzdO/qL2jMWPccS6lLuAhEYw6
         ykfbZPWc7DHxJKksBDJjK54Ci/zfV0cPJsUBD09g1bvXloVxDnAHlxRaeQuLzajRETqJ
         VNpbMHiNSRZPdpbkQ7Z5uF3c/lTnDqrgW0TNfvzpZtdAwtOSUqKVzmyb4dIifOv5XNLs
         5rHX/BTaT8oEfz0+SABgAc8tTDikOJdpZ+E72T/x2NC3M1yvw0Rjk0PZG6Yhxt6cMsss
         1+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BRsabgXq1j/oZODFUT1sBBvOqEOBW7MpFRgZymkaaUA=;
        b=pLp1F696y3uR9JGD7sLwNYzkvyq8xqgKMBuNmjdm35LcSISi+R6weXgz3Q30lxXgjq
         TEjR6L07p5zPe7SFXYheR5gZ0OLbbJ6HaNuAc2EIrLeghYcs8LqBRGYEn7rxbj7osEyv
         fyByMWZ2xz5JKIm3FQ9tpJTifuKqgEF5t4eaBADjl62fW2VCN2PDeewnNGHMc6mFdGXD
         ulG79KJx2V3iCW6ak8t31R7gr401UgUwCEucbK3jvE2o8dfskzZih0XilMc+CcbUMXHp
         JIXpGpfoqlT1G9mRW3OoXqv2GgNrMAkzk8LoR7Ja2wcwdEmLXsMiRveI00bsr9KTDMtl
         jdyg==
X-Gm-Message-State: AOAM530tNuqdUshFxm0r8a/ThTV7Z4H93/MPl8vq7Zc+Z3i+9jhLLNo0
        AyNy/tpK7/IIfa+PT3ZE71SxGw==
X-Google-Smtp-Source: ABdhPJwzi7PJ15TKf4jgmeDypTlfdkL9JMx3c0LopfpPKhKT3B5q/LG3ho9qNjsB2tXxMmy8LUTF6A==
X-Received: by 2002:aa7:9a1a:0:b029:1ee:ea41:9a2b with SMTP id w26-20020aa79a1a0000b02901eeea419a2bmr2923986pfj.42.1616590594380;
        Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id i10sm3175415pgo.75.2021.03.24.05.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 05:56:34 -0700 (PDT)
Subject: Re: [PATCH] rsxx: remove extraneous 'const' qualifier
To:     Arnd Bergmann <arnd@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210323215753.281668-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a13867ce-8fee-8e26-5179-7255e9527229@kernel.dk>
Date:   Wed, 24 Mar 2021 06:56:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210323215753.281668-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 3:57 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The returned string from rsxx_card_state_to_str is 'const',
> but the other qualifier doesn't change anything here except
> causing a warning with 'clang -Wextra':
> 
> drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
> static const char * const rsxx_card_state_to_str(unsigned int state)

Applied, thanks Arnd.

-- 
Jens Axboe

