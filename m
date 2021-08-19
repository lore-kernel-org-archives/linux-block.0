Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBFC4320A
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B334F60E93
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 15:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhHSPPp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Aug 2021 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhHSPPo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 11:15:44 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BDC061575
        for <linux-block@vger.kernel.org>; Thu, 19 Aug 2021 08:15:08 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n27so9059444oij.0
        for <linux-block@vger.kernel.org>; Thu, 19 Aug 2021 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tdmg6TTFQ/Ot8jb2adMxctxRWhiV2wL5JMi4BPla+4U=;
        b=1hSpz+5yXZtubJfQF4N8v8tl9W6NAL9aZbfe3iuPM2KeMIj7l6Lrv3Tabidov2rVhE
         TXrEngwakqnbSTvW45CugI7t97zP9MfIPVgr5cAHN9SsNdMKYShcLoztva5RjvvFoUj4
         wtCNA+vqDbN/8FzZkr9J7+Os1SIdNCGISHeGQd4tn+dX/qGmF8PiSCu3fkGNZfY0M+/O
         kVwSYwsFIhRyYxBeeQnl6nJ3l7fFFwk9KqRwb4dRpAz6RB09RFZsjBzoHZJ+hXZPbqDx
         RjH6DtKd4vlowRWSW12iS8G3y80SA/kDpXlcSnYew/FaNfFRXwETpefQWZwPf4UcFTLF
         vP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tdmg6TTFQ/Ot8jb2adMxctxRWhiV2wL5JMi4BPla+4U=;
        b=YsKLFf6AcKcSfl9EhNJ3OCju0jlo1ObD0+K+Lb0uo4mvHyXbusHkPnILLulrHYBWOt
         4RJ2y6z3CeDgRrGkUXyNsGtWMPFb4seFJyWHzDkS481h8NP/KNCsejJAtK/zxyaQcrnd
         IARhpNzQdoEsGu11NMzKV2xoVSYCiV03JYdqpll9h/MeKbGbm6SkcA91qVh+zXgnhlBS
         DUnp3Uo+MY24Luog7QQGVdYqRY+S/jxnQYPu8o2jm0JUXltyodcsympup5W/o5ruYriB
         372huqbEeNuL6g9QAtcUoHO0eDeLdZIu4bpjCn1RO95TuKKAa4mi3cuYiYMVDNf825VG
         nrvA==
X-Gm-Message-State: AOAM532+Z37wgeGfDpXwAH5N3b0fxWzSZgsdjmGPyouKZGIIEvXUjS6a
        Zw6gCPkiLPsOuAPSZCIRAoWtCA==
X-Google-Smtp-Source: ABdhPJyaieB8cT5A/g8uvMeiUBogH2EI0ASLSoldGHgceQUcAcMvDfxgQy6B6md0yraoPqLXxmUq2w==
X-Received: by 2002:a05:6808:cd:: with SMTP id t13mr2919899oic.111.1629386107801;
        Thu, 19 Aug 2021 08:15:07 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l13sm299001otp.29.2021.08.19.08.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 08:15:07 -0700 (PDT)
Subject: Re: [PATCH RFC] Enable bio cache for IRQ driven IO from io_uring
To:     Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
References: <3bff2a83-cab2-27b6-6e67-bdae04440458@kernel.dk>
 <20210819090150.GA11498@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ed3237b-573d-029a-4cc2-0b6cbc22e32a@kernel.dk>
Date:   Thu, 19 Aug 2021 09:15:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210819090150.GA11498@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/21 3:01 AM, Christoph Hellwig wrote:
> On Wed, Aug 18, 2021 at 10:54:45AM -0600, Jens Axboe wrote:
>> We previously enabled this for O_DIRECT polled IO, however io_uring
>> completes all IO from task context these days, so it can be enabled for
>> that path too. This requires moving the bio_put() from IRQ context, and
>> this can be accomplished by passing the ownership back to the issuer.
>>
>> Use kiocb->private for that, which should be (as far as I can tell) free
>> once we get to the completion side of things. Add a IOCB_PUT_CACHE flag
>> to tell the issuer that we passed back the ownership, then the issuer
>> can put the bio from a safe context.
>>
>> Like the polled IO ditto, this is good for a 10% performance increase.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Just hacked this up and tested it, Works For Me. Would welcome input on
>> alternative methods here, if anyone has good suggestions.
> 
> 10% performance improvement looks really nice, but I don't think we can
> just hardcode assumptions about bios in iomap->private.  The easiest
> would be to call back into the file systems for the freeing, but that
> would add an indirect call.

That's why it's an RFC - while it's not the prettiest, the ->ki_complete
assigner is also the one that sets IOCB_ALLOC_CACHE, and hence it's not
that hard to verify that it does IOCB_PUT_CACHE correctly too. That
said, I would prefer a better way of passing the bio back. There are
other optimizations that could be done if we do that. But I have no good
ideas on how to do the passing differently right now.

-- 
Jens Axboe

