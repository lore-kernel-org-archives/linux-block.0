Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85926C433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AAA64DE9
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 14:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbhBDO4C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhBDOzk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 09:55:40 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4553C0613D6
        for <linux-block@vger.kernel.org>; Thu,  4 Feb 2021 06:54:54 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e133so3445776iof.8
        for <linux-block@vger.kernel.org>; Thu, 04 Feb 2021 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PoCWo/IslUE/1ly6GZ9Q14bMcOcnUOn6YolVqWOYLq0=;
        b=dTeL8gcbeYkO2C5oSDTOeGqyOgTu1kJtX4Ko06b8NrygNPBC5ywTWFTTGFqo5ax9i+
         ZtNdXWwM3o0a2JXNidVnnShAlmEpJ+C/Iax8Q0y+0IwoVCZv5QW8qgzZhU+7KXN0DI5K
         4YfuEFrnfRYr1+heCcgPxVQ7tg8OCQlfmr529bPZsArQkWgfSNnjBprWD2ZyucmfNer/
         gHP1/OKNK7FhYl0ugCh2xk6wGO8SrRlpLqRULc3hUoIHQgBDqFO7vvHbgZgZe6BdtHXu
         X9yJ2YBtBmecbv4SCxS4acRre699TlS2xwe7zIXv1JtWPMRxTZJOyQ/SCQxWYZ59rlNO
         NMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PoCWo/IslUE/1ly6GZ9Q14bMcOcnUOn6YolVqWOYLq0=;
        b=UgrD9KBIsPdCarNgNaUDWwwaahE8zNT13M4owA7BmajIwtjB9r36/mxDI6bYyPq43i
         fy+F45oamHawIrnKnUFprPL05D60FvO2XzzdwzM6qHwytGI+cUw0VGSQ2CjNt1rVBiUt
         nNq7U2YRzYfYftnGwMEzR0vEUzKY6+AUFMVd5LyNIMAYTvYs7s4OPoXH0crqj986C1f7
         +Yq3bi/gTdDxxkVm6rkn6V0mDwkds/dpmmmTrNexWwFd7biEVrIZsBgTftDvNJGQK0D6
         KcviguDTARuw7e8p3kXGSGdjYzS10qhXokBUMWm2OHBw4u38i4CtEx0As0hcw+Ju2wRI
         HDEg==
X-Gm-Message-State: AOAM532atvMbWhP/NE9V376Dfbvh7ltDJ8pVV81zx4sRgI6b5uD73WX2
        Gy7Xv3pQ5E0AFfqo1n65dhrOxQ==
X-Google-Smtp-Source: ABdhPJx/BSvTfb12HtiZHfp2kjJMPDIRDmQ/KH1xApQ+P+cjq1ZeQizJrs0lygOmAU8xYFFOzu354g==
X-Received: by 2002:a02:6a50:: with SMTP id m16mr8268271jaf.129.1612450494133;
        Thu, 04 Feb 2021 06:54:54 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k10sm2704460ili.54.2021.02.04.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 06:54:53 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] block: Remove skd driver
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <3cb4ca54-b916-5793-0632-bd12ff9d0006@kernel.dk>
 <BL0PR04MB651463DB539857107251E174E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2332133d-9cf7-3692-f27b-83eae602c7cb@kernel.dk>
Date:   Thu, 4 Feb 2021 07:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR04MB651463DB539857107251E174E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/21 7:52 AM, Damien Le Moal wrote:
> On 2021/02/04 23:46, Jens Axboe wrote:
>> On 2/4/21 1:43 AM, Damien Le Moal wrote:
>>> Hi Jens,
>>>
>>> Instead of spending time fixing the skd driver to (at the very least)
>>> fix the call to set_capacity() with IRQ disabled, I am proposing to
>>> simply remove this driver. The STEC S1220 cards are EOL since 2014 and
>>> not supported by the vendor since several years ago. Given that these
>>> SSDs are very slow by today's NVMe standard, I do not think it is
>>> worthwhile to maintain this driver with newer kernel versions. I will
>>> keep addressing any problem that shows up with LTS versions.
>>>
>>> The first patch removes the skd driver and the second patch reverts
>>> commit 0fe37724f8e7 ("block: fix bd_size_lock use") as the skd driver
>>> was the one driver that needed this (not so nice) fix.
>>>
>>> Please let me know what you think about this.
>>
>> I'm fine with removing it. The 5.12 branch doesn't have the later
>> fix for the bd_size_lock issue, so could you just resend that once
>> the merge window opens and the block bits have gone in? In case I
>> forget...
> 
> OK. Will do.
> 
> Could you confirm if you received patch #1 ? It looks like the list server is
> dropping it likely because it is too big.

The list is a huge mess these days, including lore. So not sure what is
going on. I did receive it, but it wasn't on lore, hence probably only
because I was CC'ed on it.

-- 
Jens Axboe

