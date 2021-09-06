Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07664C433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86AA60F43
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 03:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhIFDFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbhIFDFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Sep 2021 23:05:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64805C061575
        for <linux-block@vger.kernel.org>; Sun,  5 Sep 2021 20:04:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so3054961plo.10
        for <linux-block@vger.kernel.org>; Sun, 05 Sep 2021 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZGF2zuT/IfwjlCiNlmF3KBmCpKmmu4YQ08OMojkPnNs=;
        b=zMXlHYmM544wB8J8z/xn6rmKqVg4M7bwBlHaK46+3UbjE9izzXWhDn0TRdnm4+PgmF
         tQO979ysqOWZ7HVk3QEjAwv938G+DVUzWnpIi3venPPEhTLUEJYgmbVO0BnURbVmyZ5I
         1mEvcWPNfEBDetRN/SKdx1W34lAsQvaddqd7xavnL3W+elrZnc9tiLXbwO0dSzfluEiv
         Q0t9x/c6rJ2tXXTo6F744gFKTDbFEzuAKOin6uqTOr8pIpR/RKRpWEyabVuSA3x0hC7V
         c7kZ6zgcmPMDtdJVt17/LM2RGf9y7BmJyAAZdshIEFhmY+Jf/Kgmw4QqSLJlhzCjGfhh
         FHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZGF2zuT/IfwjlCiNlmF3KBmCpKmmu4YQ08OMojkPnNs=;
        b=QyYt11dD2pdBNxq3paRfnfj9JkgFXw2uuKftuwheY4d3CZ2csumt7ZTLAl3oySB4OG
         W3qCUsC53NS+hPvMHR4QtGqojPxcltb/kCyVeT5mqSqA2zF+nOgjICykxLp1yn7n5wwa
         3R4px3o9ZiF3n04iN9+fT8S70WRdkOh0Ut0tDrNlhPyrTrMP7TPmMMoOjzTJmP7aTvG+
         eAVvNuzM88KhtEtCkU2dLmiKv+SPSuHTvz48jFlwVV1eRVEzqRK7ejsTmJJ/aqw9aL2x
         K4vW9QboeODlwvxku2T1mRzhDa41MB6NzRgRBkEwa9vfmUUegE9cZ+AMU/RS40RSCXIM
         WKoQ==
X-Gm-Message-State: AOAM531Cve2kttvqWSbghEK6oAaGe6QuPpS0mcZfroAXhscE7DO0/tlk
        DAwQiHOCuY5CyrIQf1fvJrMTXtdYH641oA==
X-Google-Smtp-Source: ABdhPJzapQs79H4XwgEDiI8WQ4k0n4gfxLF1psjjotY8xH+gRutuLQTEYoqBZUFP1aR80NX1DOkpSQ==
X-Received: by 2002:a17:90a:c908:: with SMTP id v8mr11928513pjt.196.1630897458806;
        Sun, 05 Sep 2021 20:04:18 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d13sm5591786pfn.114.2021.09.05.20.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 20:04:18 -0700 (PDT)
Subject: Re: [PATCH] block/mq-deadline: Move dd_queued() to fix defined but
 not used warning
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210830091128.1854266-1-geert@linux-m68k.org>
 <caf2449c-e86d-195d-3635-9be49159166a@kernel.dk>
 <20210906125605.658fe211@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0592ddf-306a-a833-785f-750a601487dd@kernel.dk>
Date:   Sun, 5 Sep 2021 21:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210906125605.658fe211@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/21 8:56 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Thu, 2 Sep 2021 06:35:47 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/30/21 3:11 AM, Geert Uytterhoeven wrote:
>>> If CONFIG_BLK_DEBUG_FS=n:
>>>
>>>     block/mq-deadline.c:274:12: warning: ‘dd_queued’ defined but not used [-Wunused-function]
>>>       274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>>> 	  |            ^~~~~~~~~
>>>
>>> Fix this by moving dd_queued() just before the sole function that calls
>>> it.  
>>
>> Applied, thanks.
> 
> Can we get this to Linus ASAP as he has now made warnings fatal, so
> this is causing lots of build failures.

Sure, it's actually the only branch I haven't sent off yet today. Will
do so now.

-- 
Jens Axboe

