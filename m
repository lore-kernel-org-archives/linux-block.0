Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EEAC433E6
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DBE239D4
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 13:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbhAUN5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 08:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbhAUN5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 08:57:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AFAC0613ED
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 05:55:58 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i5so1415467pgo.1
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/a08dp79Xs1XwsKpDBNf3caoVWhir+wyUETQwU1GNxg=;
        b=U0moNAp99t3atjptt4L6uJVYc1+cd+VZOr3KmaFs1uGE/cQgm8XpY6ooTKtNmnCm4b
         rOHuUab4Zaia96Mky4AC4wVd8o27tVdj1yFkDobBRCZ6D0Qe776pk/NOlzte79OGmXLt
         yDI4S9l2UGrzoavMt8K0s5J2LZ2IRjWnubVAVQCERQERDxEkd6HENDVg4qRaNnpXxnaw
         bS2gHqxry+VKE3ROy93YAm5zcuH15/tj3bloTQOVA2Mon9MaputwPOHL1NggsNorwfKh
         asFM76B/HBcepkt2pvFrRxB0htN6MwnCQVP1HxhVRQYGrR729gMefh1bSiESZ5AxjaUB
         2AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/a08dp79Xs1XwsKpDBNf3caoVWhir+wyUETQwU1GNxg=;
        b=srBJH16thNffLn+mzQwqUgyaG6YzQO45jyeXVMHyEDgkAIfidyL+SUOPP687JBZtas
         wGc5vp6RqthcVgK2271Kw++uYBaG0PJ1Py9j4pxy48QpNHKu8MEkpLFRJ+OzbQDGkroO
         dtMbSkethjK6JhbCpkQphYGjS+xqsHP8Rbj6cc1NLpQeqJH1PRYil/5Jg+kObjP/44WX
         rO6rzME3rUtx5ZsbVdUcez3Dy/RpWctLIe3XZ3+IzU8oIiJEy/g7+IUD5nvNkaxpoKJa
         pzIouc43vLePq7Xn36YYvZRU1A8Iz4h6rnhCghSDCXkMJZPn9WHP6At0px/mNm0ZGDwb
         7BcQ==
X-Gm-Message-State: AOAM5312Hl8eMQ6jhr6iWHH0HpJNU/1d/dP2pzxInviUYV8LKihkP5aT
        8eKGTDwD/KQrb8IcKjG5QrZ2Yg==
X-Google-Smtp-Source: ABdhPJwDU+Y+IFK+npoNeio6kU5ulsKaxLIuxIGOWAyxDlB0kXesgjAWCsAWHP6p9Xb/lWqJAf5Gvw==
X-Received: by 2002:a63:703:: with SMTP id 3mr14436436pgh.272.1611237357718;
        Thu, 21 Jan 2021 05:55:57 -0800 (PST)
Received: from [10.225.164.3] ([129.253.240.67])
        by smtp.gmail.com with ESMTPSA id y6sm5688245pfn.123.2021.01.21.05.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 05:55:56 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Jens Axboe <axboe@kernel.dk>, Pan Bian <bianpan2016@163.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121072202.120810-1-bianpan2016@163.com>
 <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <474055ad-978a-4da5-d7f0-e2dc862b781c@lightnvm.io>
Date:   Thu, 21 Jan 2021 14:55:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21/01/2021 13.47, Jens Axboe wrote:
> On 1/21/21 12:22 AM, Pan Bian wrote:
>> The allocated page is not released if error occurs in
>> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
>> possible memory leak issue.
> Applied, thanks.
>
> General question for Matias - is lightnvm maintained anymore at all, or
> should we remove it? The project seems dead from my pov, and I don't
> even remember anyone even reviewing fixes from other people.
>
Hi Jens,

ZNS has superseded OCSSD/lightnvm. As a result, the hardware and 
software development around OCSSD have also moved on to ZNS. To my 
knowledge, there is not anyone implementing OCSSD1.2/2.0 commercially at 
this point, and what has been deployed in production does not utilize 
the Linux kernel stack.

I do not mind continuing to keep an eye on it, but on the other hand, it 
has served its purpose. It enabled the "Open-Channel SSD architectures" 
of the world to take hold in the market and thereby gained enough 
momentum to be standardized in NVMe as ZNS.

Would you like me to send a PR to remove lightnvm immediately, or should 
we mark it as deprecated for a while before pulling it?

Best, Matias


