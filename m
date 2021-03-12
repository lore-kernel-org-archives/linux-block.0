Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA16C433E0
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8681664F80
	for <linux-block@archiver.kernel.org>; Fri, 12 Mar 2021 20:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhCLUY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhCLUYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 15:24:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542BDC061574
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:24:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p21so16593078pgl.12
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0rrz1OkFnDG76ppSWsMYGxkmvRNkriiw8EQXDC7K90U=;
        b=MjDYsUyPBGgpS+I0/bYEa8L6Sr9ip/qfqAO6wyPehjrfrnloMnpvPMy5fu5uCOp4rd
         lPZi+Hf/AUIFiAQ8E1cTtKFFjyKae9Sm2sXbO/YO0wgDpGaejP3KXzzHEhp/1pwd3lvI
         LKoN3w36Qu90GVRSStMfAB350F54Yvcfiu9vYohzxAWM7SOKpj/7Qq08eeBNZXp74+SF
         bN4N99A4YkqyQMYuJZW3RSCC3dxS5pUz8VCxgHdjt2oWVvDFCH+LxYLmiEps5Ep23ebs
         Fq1w3F7f5YF+RsG/46VXL7CtLBXNx35lvlkufDhei2MXbeV8WuBCnfbtc1SWXyiE1YY0
         RyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0rrz1OkFnDG76ppSWsMYGxkmvRNkriiw8EQXDC7K90U=;
        b=liDe5b5eXMv+pl8LMx83W2lECVYXSMEZRf1OfqVCUD1BgttOjHYe804yarg4YcrqoN
         tm1D11ZgRgzY9NzHZgwMwyhIabhhm+aafih1YQLSjgY8AiQF/7NY5c/6+IxItr9bjdgX
         A+si8anIOIVmz0UKR3FWVTNuw/l606na4pOIO73eRZzfbZLizoub0V6ZHxnIw0WGIBw3
         InvKb3Y6unJoim2hjwuYndBeHrz6kCjMz7y8MZUeS0gP+CT3LQkumAXMQdLSs1FRSa3+
         7u+SyHqNPxJASbra8yqJn0QiBLPGMeByUB2pTD1JFvlxJtJ5qbvz5n8kjLELIFI3UtIE
         pZQg==
X-Gm-Message-State: AOAM5319pt0MyRzCVHzFJnh7iVftOpSS0H1thmj0qF0NeVE+7AbV0anT
        yXaAZHnZrl8AIff5lbqh9zW47w==
X-Google-Smtp-Source: ABdhPJzdBAPae1dbHiJvNI/uxj63FFKd5pwOULA/kRE+ix1Jl1gjRIngIMQDQWaxqliEoCi0tzEViw==
X-Received: by 2002:a63:e808:: with SMTP id s8mr13357517pgh.101.1615580660920;
        Fri, 12 Mar 2021 12:24:20 -0800 (PST)
Received: from ?IPv6:2600:380:b46b:1540:2a49:5dda:db8:a2f8? ([2600:380:b46b:1540:2a49:5dda:db8:a2f8])
        by smtp.gmail.com with ESMTPSA id y4sm6234523pfn.67.2021.03.12.12.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:24:20 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.12
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YEszeMEAQyfTPgHH@infradead.org>
 <2a34717a-b5c5-0a3c-02b0-eb8a144aba15@kernel.dk>
 <20210312195932.GA2766489@infradead.org>
 <7d7e0f1d-649f-e977-f65a-e0a6ae69d327@kernel.dk>
 <20210312202033.GA2778279@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de1fcc6c-1e8e-e7c9-d04c-2128c2506f59@kernel.dk>
Date:   Fri, 12 Mar 2021 13:24:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312202033.GA2778279@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 1:20 PM, Christoph Hellwig wrote:
> On Fri, Mar 12, 2021 at 01:01:18PM -0700, Jens Axboe wrote:
>> On 3/12/21 12:59 PM, Christoph Hellwig wrote:
>>> On Fri, Mar 12, 2021 at 07:21:39AM -0700, Jens Axboe wrote:
>>>> On 3/12/21 2:25 AM, Christoph Hellwig wrote:
>>>>> The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:
>>>>>
>>>>>   block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12
>>>>
>>>> Pulled, thanks.
>>>
>>> I just sent you another one liner fixup on top of this directly.
>>
>> Where? I didn't receive any.
> 
> "[PATCH] nvme: fix the nsid value to print in nvme_validate_or_alloc_ns"
> 
> I just noticed it went into your facebook address as I copied and pasted
> from MAINTAINERS..

Yeah, that's why I didn't notice... In any case, I queued it up now.
Turns out I botched the pull request I had already sent out anyway,
so doing a v2 with that included.

-- 
Jens Axboe

