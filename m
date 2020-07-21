Return-Path: <SRS0=rrL6=BA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18ECC433E0
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 01:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC9C20658
	for <linux-block@archiver.kernel.org>; Tue, 21 Jul 2020 01:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R7UZH/Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgGUBvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUBvc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 21:51:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D00C061794
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 18:51:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so9534696pld.12
        for <linux-block@vger.kernel.org>; Mon, 20 Jul 2020 18:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDLZpj88ubd7Z5NRJAkzisTo4dFuOKZtnFia32Rxw/c=;
        b=R7UZH/Axeh3CNLLkCOn5UiCt2MHcSSMs53l+e05pIWjXelA+M0Bg4RLxIaY0Agkhnz
         tJvoyCO429hfINxjDCV1oFEijqA41iXxpJEYH99mbbkEXxx4qHwrsXemMhRyJt8zr1Nv
         Pfge6TKGmdmvaDPgjBe8KiDcIVIaNTuiDz/ue+zUzdJZsWUZKjjCBG1lgnEqTVzag59f
         TdlHnz8lRzeixWhNeQFjTq/GibNya5OWdMJE9+LELii8GLzpP04BenjIA/DdG1E0teou
         jzqdYFpOPOZsn/fyGcMAIrBLpC5aRuyakmqdODwlw4+Av49FzTYhZIOqrJ+7xp7sY723
         zQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDLZpj88ubd7Z5NRJAkzisTo4dFuOKZtnFia32Rxw/c=;
        b=WlX2XmY91OrP4RoHNfQBIXRbb3xCmh5NA+3/YZxaW0j02SJzULvd5s7SbxYnHGdAW7
         4asubZIRZWV/9b0FvHwtFGkdGVEPLLBWf8yLTIm8kWLJ/EytKKpL91mPuzyOCtuM8meH
         mLoy9cVKFO3cTvgqqIB931g4fPH3escea9DL6aPCnPRt4tS1BstoB8QRnEwNQ+sC+Hkh
         9QDlWpCN23LxtQh48WFlA3O3VHudE/8haG/EtYbhPjVGPJhsjk1OInta7mu4+KfOLMcq
         Q1SH23tYd+hZCmKY6G49hTbToc8j40Ut+lxwCyFq37tOGOcMSBQ/jq9y7Agq4d0qcl+n
         yYFA==
X-Gm-Message-State: AOAM532YmVlvITxK3oqjiWNiA96+PQhYLYx8l8x45bP0ZBYvTY0ZIWIv
        szhawq7FO9Ha+fbVjWUTdfTjmV6D0hZGkw==
X-Google-Smtp-Source: ABdhPJyx40Q6tooy8Faxm2UxryDCnszbtCkQpxWCpH5jb5aBZ6SQ1BulEszP+yAoWpzdWiEVadElvg==
X-Received: by 2002:a17:90b:1292:: with SMTP id fw18mr2189469pjb.3.1595296291702;
        Mon, 20 Jul 2020 18:51:31 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t184sm18988605pfd.49.2020.07.20.18.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 18:51:30 -0700 (PDT)
Subject: Re: [PATCH v2] block: delete unused Kconfig
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org
References: <1595233988-28342-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <c889122c-890e-405b-8f93-0affd2882c6b@kernel.dk>
 <f24171eb-b1f8-746d-d379-4478ebe9ad70@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87ab9c56-74a7-8874-6373-453970a89b7f@kernel.dk>
Date:   Mon, 20 Jul 2020 19:51:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f24171eb-b1f8-746d-d379-4478ebe9ad70@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/20/20 7:50 PM, Jiufei Xue wrote:
> 
> 
> On 2020/7/20 下午11:49, Jens Axboe wrote:
>> On 7/20/20 2:33 AM, Jiufei Xue wrote:
>>> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
>>> ---
>>>  block/Kconfig | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/block/Kconfig b/block/Kconfig
>>> index 9357d73..d52c9bc 100644
>>> --- a/block/Kconfig
>>> +++ b/block/Kconfig
>>> @@ -146,7 +146,6 @@ config BLK_CGROUP_IOLATENCY
>>>  config BLK_CGROUP_IOCOST
>>>  	bool "Enable support for cost model based cgroup IO controller"
>>>  	depends on BLK_CGROUP=y
>>> -	select BLK_RQ_IO_DATA_LEN
>>>  	select BLK_RQ_ALLOC_TIME
>>>  	help
>>>  	Enabling this option enables the .weight interface for cost
>>
>> What's the difference between v1 and v2? A commit message would
>> also be nice...
>> Sorry for the confusion. I have misspelled *unused* in patch v1.

Ah I see. Can you send a v3 that has a simple commit message at least?

-- 
Jens Axboe

