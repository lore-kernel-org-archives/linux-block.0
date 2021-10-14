Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFADC433F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0345560EBB
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhJNSQH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbhJNSQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:16:07 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D575C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:14:02 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id a8so4439858ilj.10
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 11:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OVScJM9eRU1p26vfMXjb3OEFo9Q6glJuesSt5Xq+wy4=;
        b=F9QT6MgRxiCfOfR8Yb48vjYCOP/wtWOtPpbSR5D3+CphNSkAeA77UQ0861LkpgGsbo
         jc8t1cPWXgULnPXtgVAx7TB9lqqvaad54tcqU5PB5fwULkUWFENY1aY06Y6o+0H8Ts8j
         WRaY3k6M9NmrdVhjg8ce0j6lewJ4MTEJMg9Nz00BrinftglDLJcGP4rHNvjlNwcaVg+N
         cTLLOuL+UPmsg0Vc5jq69xmxrY494q2T8pktIglbbynEW1Q14qa/tMkk4jLRDgYzgdsS
         2S6G2hMNhAPjRx9GrLYHeF4Yc9QQe8KH1Ms8jX2mJWpBA+Jjx2Prm9HzXzO6wROz0ixR
         PSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OVScJM9eRU1p26vfMXjb3OEFo9Q6glJuesSt5Xq+wy4=;
        b=D2CUCeHSEFKS0SXYGRCp9ds3oehw8fpZXdt84XBwPBti7Q/ZUgDctWDBWKT2JlAakW
         FTyPk4Ey34CkhhDG+M834QRriyX1Bx5xD1F+M/5NGQlR6hSraSL3597LWoJoDtKCLauG
         t32r9hMopV36i++dVmf+JJpyBWUexLJygV2RhNfnTMwgvQIP/2w8v8vZkMNWv6SDbSIn
         WzDDc0pTFYV0Jh1IoVTgLnQ5ZNUS9gzXbEVTrDXq0w3ZJAY5G0GCHOjsrdaDDjQfYjFt
         c9rFBItNT9PWX//UFSPy2cTkHPeEI1l6exJn/XJCGrCAveSNYofDiJweUhCOh7OITizB
         nscQ==
X-Gm-Message-State: AOAM531fTd7hM/CSYX8ysf8cvvAd+DhBxjoD/pQ/wBpDOhKIO8WZigqi
        GMEGNwCU1uz+NHNxJBcdn2exeWAYi38=
X-Google-Smtp-Source: ABdhPJyk/ZE/u4K/ARCCCm9+Wfdjjd0yCEQ2Nt+RrkvnzzliYMdwVFP5U+d1SH5wnNr0vRoURGXa7Q==
X-Received: by 2002:a05:6e02:17ce:: with SMTP id z14mr386606ilu.120.1634235241310;
        Thu, 14 Oct 2021 11:14:01 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u12sm1501847ioc.33.2021.10.14.11.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 11:14:00 -0700 (PDT)
Subject: Re: [PATCH 1/9] block: define io_batch structure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-2-axboe@kernel.dk> <YWfEALs4P+bGQtY9@infradead.org>
 <1db96336-fad5-b2bc-98c8-33336790e785@kernel.dk>
 <YWhVg94mX3RqV9Iz@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f70e30a9-27c2-8b33-c9ba-a3c85082c243@kernel.dk>
Date:   Thu, 14 Oct 2021 12:14:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWhVg94mX3RqV9Iz@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 10:06 AM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 09:50:10AM -0600, Jens Axboe wrote:
>> On 10/13/21 11:45 PM, Christoph Hellwig wrote:
>>> On Wed, Oct 13, 2021 at 10:54:08AM -0600, Jens Axboe wrote:
>>>> This adds the io_batch structure, and a helper for defining one on the
>>>> stack. It's meant to be used for collecting requests for completion,
>>>> with a completion handler defined to be called at the end.
>>>
>>> Isn't the name a little misleading given that it is all about
>>> completions?
>>
>> It is for completions, but I'd rather just keep it short for now.
> 
> I'd go for something like io_comp_batch or something like that at least.

OK, made it io_comp_batch.

>>> Also I wonder if this should be merged with the next patch as that's
>>> sortof a logical unit.
>>
>> Actually was like that before, I can fold them again.
> 
> I'm fine either way.  Merged just seems a little more logical.

I just folded it.

-- 
Jens Axboe

