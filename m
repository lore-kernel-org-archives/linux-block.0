Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A733C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D4260FDA
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhH0QtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhH0QtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:49:00 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3619CC061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:48:11 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id l10so7611858ilh.8
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZdwQ3tPYyvghY0Q0/+2dagPNsyTb7jMQ+74TDzHetkU=;
        b=qO8Xg+JQFaABoBrI1Su/uCD6MkLVUd2w497oxf+N13itxpPUh48A6UZwH2ahUtPE4M
         Wav36X+PLkxQyph7abQ4/ij7OvTLt8lAJr3EnMfvp/p07q8PW3etlMN5Xd6Fv/srAhDz
         046hWqrU/sKKGhV5z/eqqLm7DohT8kaKYIDEg3Im6zArk6eb9gFqDnEMInw8UBIHEVI4
         vjsu4sbmk6KYA41qZsRNQyAV2Z2sLT5MuJtys+gxfA1GPLN7dY9BPIUsPyT1Km7nRfKz
         GZ8WUbgwt7sDbIUXxgtzWvKgcIpoDR4j3DI9EOusGoMHI5X+MDOJc4GDMER7ughk1SLK
         bZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZdwQ3tPYyvghY0Q0/+2dagPNsyTb7jMQ+74TDzHetkU=;
        b=i2b4Yyj7pLMcxj1TolQdsjAJlKs7E8dX8xkjysz8zuBzmpvJ+nMTutCtGM2Zp1gVuT
         vweDrDfYszHVdYXwGjTQMoujAhQx8oKVIsK6Q6WOTcohTkDatllCDtS8bJ/Zm81XTWlq
         GaU5j2dlTzE8RWPvPtIKvoZ/lCOzgu7Izgnusi7ZVWA95BV9pZ3B40MfIrvPmw36fmxt
         PJcodN5wuYQa/g1dDm1nJIey+pXwcgnXRFCH7sbvjVpQEsR/GG6g9J9Q4TaTNdA96axX
         KUHCJczn3roeB4lXV1bGBB4l4Fsn93/I0C2jc6nBJ/PhDycjKlqtdL+2FOCKrEKh7r6S
         3saA==
X-Gm-Message-State: AOAM5329mDNG8VFbL8bqv8lDYu3aUVnKhz/5g6L4af1IRMMPCBqHjAfp
        Vns7Qm08WW5bIZltkEzf91dT/bNU2HYFeA==
X-Google-Smtp-Source: ABdhPJwA3msZEIUtTeKG4RxjYhIqVHEnw8YXI8Y+PejIQyxS10BB4XaZp+R49NvOmhPcM8HJ6wAQog==
X-Received: by 2002:a05:6e02:1ca6:: with SMTP id x6mr6990934ill.86.1630082890214;
        Fri, 27 Aug 2021 09:48:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j6sm3509560iom.5.2021.08.27.09.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:48:09 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
 <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
 <20210827164051.GA26147@lst.de>
 <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk>
 <20210827164325.GA26364@lst.de>
 <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
 <20210827164637.GA26631@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk>
Date:   Fri, 27 Aug 2021 10:48:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827164637.GA26631@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:46 AM, Christoph Hellwig wrote:
> On Fri, Aug 27, 2021 at 10:43:53AM -0600, Jens Axboe wrote:
>> On 8/27/21 10:43 AM, Christoph Hellwig wrote:
>>> On Fri, Aug 27, 2021 at 10:42:59AM -0600, Jens Axboe wrote:
>>>> But what's the point? Why not just wait for 5.15, it's not like we're
>>>> in a mad dash to get it removed.
>>>
>>> Actually we kinda are :)
>>
>> Because?
> 
> It causes trouble by interacting with the actual loop driver people
> use in really weird ways, while beeing broken and not actually supported
> by userspace tools for about a decade.

I don't disagree with that, but that's not a new situation. Hence my
question on why there's this sudden mad rush to get it queued up for
removal, literally a few days before a kernel release.

-- 
Jens Axboe

