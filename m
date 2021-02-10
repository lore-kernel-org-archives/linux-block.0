Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76EAC433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 16:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7460D64E7E
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 16:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhBJQlr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhBJQjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 11:39:44 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F218C06174A
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 08:39:04 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e7so2413195ile.7
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 08:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JV4Ql9KQvz2aQzVgMYltIdHx2mjwmlHNpDGI0MR+TO4=;
        b=k8PSQF9m04mzFOs+Ko82ihv/AVrehPpQDFAx2TxGHFhAU7+EYNNE3GF5uiErDrhL84
         WYj3fDnOgadhkXP9L8L9WYVUlWt1omqEr4fqYg/IO3rSkAVRZnvvhFGPXQ779qMpX7Mx
         jykI09prfeDNI+sTGI15ImDpydSmWQhfy9SvZeuz723dOMedeHLyx4STjo0L+Ptws0r0
         gL6nOu96rOfxkoTrUKERr320ZDybsx+CQgLQJjYeuByLUq7poUXMRaP+ON+Oebe9vHNW
         FfSGRTIY/oY7lHj3MVVKzHSxNgD+I/GJM9OZOy+pZl5tt8fYFn0UFn0E93R0STCqv57p
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JV4Ql9KQvz2aQzVgMYltIdHx2mjwmlHNpDGI0MR+TO4=;
        b=DJ+AHzozLKroUhVqbKmqOspuXU6fACHZTzPUEnD1Ou+2rTplYj1rnNDqv/QTEArVJ3
         8RftAefH4ZgW6PTB1mIwm9gDtxsf3SNgKnJyLOcI1NDtEA7wEOqVOLDKHXvQsOSmnCL4
         ElpVDneAwiJvkA+84H0lW2QwWHjr+wkn/mc16s90z133qZll2VKGabGk2TSrTewC4JTa
         ofgRumJDnhGn2AA46bj+OCxhDGgqxWytEoDf8FkeCJZ2Fg8eQfWRYbA1R5TT5ccLdOjU
         xa0ULEagOU0dFQNY8ItajhNTiI+T1Zh/WXwHr36dxwpHOgyz00vPfgOYAic/2JZ4GU7x
         9wxg==
X-Gm-Message-State: AOAM533vDrhB2BqwhylpCMCebmv/ePQQ2WMAxCCnaBtCaaKg2Rq1r2e8
        lHqrHBi7/sG4rymViYqIWRVWvQ==
X-Google-Smtp-Source: ABdhPJw1merUBFK9auBoXl06LixxbdwajQJcJD3Jz93k8Zq2oCcy2VpISqLU1+xUe0ziW9c0U8hReg==
X-Received: by 2002:a05:6e02:1ca2:: with SMTP id x2mr1826237ill.243.1612975143608;
        Wed, 10 Feb 2021 08:39:03 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n194sm1163801iod.25.2021.02.10.08.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 08:39:03 -0800 (PST)
Subject: Re: [PATCH] nbd: Convert to DEFINE_SHOW_ATTRIBUTE
To:     winndows@163.com, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <1612595455-4050-1-git-send-email-winndows@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f50c63c-adbb-a89d-9188-e77bd5e6dd32@kernel.dk>
Date:   Wed, 10 Feb 2021 09:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612595455-4050-1-git-send-email-winndows@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/21 12:10 AM, winndows@163.com wrote:
> From: Liao Pingfang <winndows@163.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Applied, thanks.

-- 
Jens Axboe

