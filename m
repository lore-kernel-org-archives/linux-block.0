Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C60AC4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 19:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23904239EB
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 19:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgLQTOd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgLQTOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 14:14:33 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54096C061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 11:13:53 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m23so13822034ioy.2
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 11:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F+fqETV9+5PMLoTgRR9fxptdGr85yylUcLLVNM3Upcg=;
        b=bkjg79/gu/zxs4iO5gAzv6sNtloiaruMK91q7MYtfffUGFzJMMLC2AlXXeIOMpaR2j
         7tLRfzDRiZDMbq7Cgcj9mI2tW/gDcKh/ie/GBw/I30rhhIeo6p2bgtG/krDRsN3Jrl9d
         RfXwtaNAELfreeyev7zjsGCrBZBSV9jGe+NCUZ+HaZBIzkWbCZjsFn/LPNOsg0VOXFpL
         AmS6QUyVoJP4nXgMPFO6ksJPS6MqTdOUDQTEc5mGGMmr52sM8JQ/gx8WQmeX0gOPKr7s
         ZcIOWo8RmngX7lgOm1tqP+v/jN/30vRACPlXe3WmamYdqKoe3ur2rzpP5D3meKH3bL3p
         PSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F+fqETV9+5PMLoTgRR9fxptdGr85yylUcLLVNM3Upcg=;
        b=eH2GE9M0VJHT6eqvve/Xz8gQ7CkFvJQqNFDzGfDTw6gt0JQUisDPkfUJtvMroOwX+U
         Ydqajq358cp8W4fJ4v1MnAmCZB9GilMjXiCkZVLtW51zEwlFEMTr0D9bSy3jmxy6qXm3
         he7zvFfbsCOQGRDdNu8yzFIDyXMvHq9ggC/hvSVv8NCIQYuhEqGgYXrPefxSCUyXXnmq
         dfdlOM3PmT/J1Bfv/LZOpBQA5xj4gv2BokLhRHPlJhz+vX/9MrIOvnBSyNAxfhR7rOV2
         yFwvTeLAYqDykgWKYx7wEB+wds8faRMSw5JH7i7WICPI2szmD7GMFVb1YflY854UR59S
         jkmw==
X-Gm-Message-State: AOAM532rznmTNp6gAwA+A4COHnA4gldJ+uOCOqqqi4ZWRhwcQ3A0JBpW
        nZ+zNZNvnulNGwgnHWoUgxUmJTI7ob0nlQ==
X-Google-Smtp-Source: ABdhPJycZGWxHO4XeYDH0t7WN7cby2HkA4OvvpbffoCNds29oDC/vEq/pRfr0AjErMAhpGS22cEK/g==
X-Received: by 2002:a05:6602:1608:: with SMTP id x8mr566858iow.72.1608232432602;
        Thu, 17 Dec 2020 11:13:52 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y5sm3728634ilh.24.2020.12.17.11.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 11:13:52 -0800 (PST)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
 <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
 <20201217184154.hn5pjiaasti3m7e7@beryllium.lan>
 <277c5421-d6ac-63a5-9dd2-c72e0a77fb8d@kernel.dk>
 <119d2c73-05cd-7c90-f2be-8ed83ce95e3d@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <039d7e61-215c-2e10-19ea-f6018a0f9031@kernel.dk>
Date:   Thu, 17 Dec 2020 12:13:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <119d2c73-05cd-7c90-f2be-8ed83ce95e3d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 12:07 PM, Daniel Wagner wrote:
> On 17.12.20 19:46, Jens Axboe wrote:
>> On 12/17/20 11:41 AM, Daniel Wagner wrote:
>>> On Thu, Dec 17, 2020 at 11:22:58AM -0700, Jens Axboe wrote:
>>>> Not only slightly hidden, b4 gets me v2 as well. Which isn't surprising,
>>>> since it's just a patch in a reply. I'll fix it up, but would've been
>>>> great if a v3 series had been posted, or at least a v3 of patch 3 in
>>>> that thread sent properly.
>>>
>>> Yep.
>>>
>>> BTW, if you like you can add my
>>>
>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>
>> To the series, or just that one patch?
> 
> to the series but if I am late for this, it's also okau if I miss out to 
> the party :)

Well, had to update #3 anyway, so done.

-- 
Jens Axboe

