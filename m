Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C6C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932A1610D2
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhJNQNe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhJNQNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 12:13:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C964DC061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 09:11:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x1so4398997iof.7
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JplyWgiEtg/Tyyb7py2uwJijNKz3BF+p7nYuaiGFEMA=;
        b=Clkc61DWT4j5AZtpFpZ66TCXEP8kMoqq2C1MPSGsgKv5CUgWHtgUxhbUz0K1PmRGM9
         p6rQC03Ivq8b170qXlCepib3jAGMLgV6nklgoiy2mY7ZCgh2LNMkpjK8bqfaOkgG9ODa
         aMc4xi5iEzzkStmkMZ81bEnaK3vGGGIl3s3P46FOiqcubMTjXOHzISmHt8vxbgGs+4c+
         6cPDRWQT2uWWIQTOjuBO+TTszn2xJRlAs9EN4aN54fC/SuAiASlFU0ow/WzShRX0I4L2
         KlFaAoAiA89CMe4iFaFq0svMnHFj27jRAB7EaGpz1gw8VgiT3e6rP2RQBNNCfzunmMBh
         42/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JplyWgiEtg/Tyyb7py2uwJijNKz3BF+p7nYuaiGFEMA=;
        b=kY4ntmh1mvx3cIfJoR3NoqO4kxo0QVnhave5jFZ00QEIKxQy5TDHxolerIGr+2Izm+
         9oe9dRqbw7kIBzpO/vwWRSif2dGQxk7JHSUqhRtBqI2UC19qaJCfLu7r6ZWxU2EdkX15
         6OoY9UPzEjg6TV76U6yknlv0J6Z9GgVrxlmM+p0+ZGiI+0Aqc3Bk1ICCU3HRAamsTdUD
         iAX8F50lXh18b00zAYCWPY7TNz4BagWJd6OX6fjaJcC51F4if/Q/XcUe9Ets8gjOQY8n
         K65KNz/f/hEC0x2pyDMKQXYfAVMfTJSscaausDzQhJDluz+vLUkz3OW/AVwtDP1lu+b7
         oyfA==
X-Gm-Message-State: AOAM533jO2krMaVuigyeh9uPLpRb622mkj2HVHiC95H897pb833/FHq3
        vO/5VQVAdxMvwwjXaSLEQHp4hVOusksJIA==
X-Google-Smtp-Source: ABdhPJycIio6wkv0bX4uGz8Gzu148S80QTRhkMUO5rET3B+SkbbbBVVk1SLVRKxMnYP7h/9CLuwG6A==
X-Received: by 2002:a05:6638:3288:: with SMTP id f8mr2227074jav.45.1634227885999;
        Thu, 14 Oct 2021 09:11:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w11sm1383081ior.40.2021.10.14.09.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 09:11:24 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-7-axboe@kernel.dk> <YWffkZ2w/mhcJIAU@infradead.org>
 <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
 <YWhVz3HqwhnoiJpp@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c1b43ae1-868a-e3b2-9ccd-1187dce4a36e@kernel.dk>
Date:   Thu, 14 Oct 2021 10:11:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWhVz3HqwhnoiJpp@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 10:07 AM, Christoph Hellwig wrote:
> On Thu, Oct 14, 2021 at 09:30:57AM -0600, Jens Axboe wrote:
>>> Can we turn this into a normal for loop?
>>>
>>> 	for (req = rq_list_peek(&iob->req_list); req; req = rq_list_next(req)) {
>>> 		..
>>> 	}
>>
>> If you prefer it that way for nvme, for me the while () setup is much
>> easier to read than a really long for line.
> 
> I prefer the loop over the while loop.  My real preference would be
> a helper macro and do:
> 
> 	for_each_rq(req, &iob->req_list) {
> 
> as suggested last round.

Sure, I can turn it into a helper and use that.

-- 
Jens Axboe

