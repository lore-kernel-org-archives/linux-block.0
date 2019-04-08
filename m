Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90213C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6477521473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H0KlnDP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfDHPFw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:05:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46673 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbfDHPFq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 11:05:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so7475511pgv.13
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Jkv18JdyywQcAMH+26JaXdx635APtj+ZQjab56XFoE=;
        b=H0KlnDP81c5QfmtGX2gRqoA5b3h9c7EBb7zQA6xOIf/vWpRMsII5sRI37Ryf49szAB
         lSs2mM2raciZT8erMpXwNSg4GQxgUwV+v+r3PDLZ1uqY6ziPsGfMz9MEsmT6WCbagEWl
         wTXv3OUyEKgYcIAXaQ3NVSNd04te6MHkEtJ/2kYQ6ICWhgtfxil8JvEdC/5y4vgsCe/C
         xZINgsBbZyroGZFabM4bfNT9xmGmHXRpSzUtWWOT0RFpW7/6myBpQdsYi3oUdjPC3fpD
         h9XjFL/HseXboQuVI9q69ng7B597L0RDYAB1ZveNKy5jm0M6/hfacW20fl4LBq9RfpBw
         eo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Jkv18JdyywQcAMH+26JaXdx635APtj+ZQjab56XFoE=;
        b=thSKHBvNb2Flum7pasm8AZ7rW5bQ47wg7ovF2Rq9hJgd4SIXx8VV7xvXj7w3RRDVr8
         5blSy51M+ndC56vYnrGJ4lf75tdBw4AMlss4/OAy2KuHJhonQKqcsqoiy5l+gdV0rt4g
         1u2qjCUYAajdMJvQH6K0oXM3BCsPW6x6SZ6djHWGN1ZnIxhNtW3bOWmrgCiZr1miWaqD
         c4m2xPkoEEoBqO165RqyrXQoIM7hM790yKrmKvQz35kQKIuhzXIt/s3ZTe61iz1eeWB5
         fUjbyqmS/k3boayChQWrTLW1RmzPxO1QZxAo56rrohhz04ZohpMQYr732KSKZ98sB2y+
         wVVQ==
X-Gm-Message-State: APjAAAUkexGJh12yrLR7KeY+wv5inVjek7RNJ2oT5rvY7V8aFrfFshp1
        6HaxQoEUczTkse2dhzO5bJp+Bw==
X-Google-Smtp-Source: APXvYqxCYPM25ukh86JVTxEEhzCynDUHfDyHIc+PoZ0h2w0mYdVRUjoZrAOtXi09pHG4fcBove16ag==
X-Received: by 2002:a63:d304:: with SMTP id b4mr28983553pgg.300.1554735922659;
        Mon, 08 Apr 2019 08:05:22 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 66sm56181877pfr.44.2019.04.08.08.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:05:21 -0700 (PDT)
Subject: Re: [PATCH 1/1] block, bfq: delete "bfq" prefix from cgroup filenames
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        lennart@poettering.net, mkoutny@suse.cz
References: <20190408143935.9062-1-paolo.valente@linaro.org>
 <20190408143935.9062-2-paolo.valente@linaro.org>
 <20190408144925.GA23021@linux-x5ow.site>
 <7B68DAA9-61D9-4AE0-9FA9-05C07C7FE408@linaro.org>
 <20190408150430.GB23021@linux-x5ow.site>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df1dfe5d-c763-91c2-4aca-25d4622c4820@kernel.dk>
Date:   Mon, 8 Apr 2019 09:05:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408150430.GB23021@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 9:04 AM, Johannes Thumshirn wrote:
> [+Cc Michal ]
> On Mon, Apr 08, 2019 at 04:54:39PM +0200, Paolo Valente wrote:
>>
>>
>>> Il giorno 8 apr 2019, alle ore 16:49, Johannes Thumshirn <jthumshirn@suse.de> ha scritto:
>>>
>>> On Mon, Apr 08, 2019 at 04:39:35PM +0200, Paolo Valente wrote:
>>>> From: Angelo Ruocco <angeloruocco90@gmail.com>
>>>>
>>>> When bfq was merged into mainline, there were two I/O schedulers that
>>>> implemented the proportional-share policy: bfq for blk-mq and cfq for
>>>> legacy blk. bfq's interface files in the blkio/io controller have the
>>>> same names as cfq. But the cgroups interface doesn't allow two
>>>> entities to use the same name for their files, so for bfq we had to
>>>> prepend the "bfq" prefix to each of its files. However no legacy code
>>>> uses these modified file names. This naming also causes confusion, as,
>>>> e.g., in [1].
>>>>
>>>> Now cfq has gone with legacy blk, so there is no need any longer for
>>>> these prefixes in (the never used) bfq names. In view of this fact, this
>>>> commit removes these prefixes, thereby enabling legacy code to truly
>>>> use the proportional share policy in blk-mq.
>>>>
>>>> [1] https://github.com/systemd/systemd/issues/7057
>>>
>>> Hmm, but isn't this a user-space facing interface and thus some sort of ABI?
>>> Do you know what's using it and what breaks due to this conversion?
>>>
>>
>> Yep, but AFAIK, the problem is exactly the opposite: nobody uses these
>> names for the proportional-share policy, or wants to use these names.  I'm
>> CCing Lennart too, in case he has some improbable news on this.
>>
>> So the idea is to align names to what people expect, possibly before
>> more confusion arises.
> 
> OK, crazy idea, not sure if Jens and Tejun will beat me for this, but
> symlinks?
> 
> This way we can a) keep the old files and b) have them point to the new (a.k.a
> cfq style) files.

I did consider that, and that would be doable. But honestly, I'm having a
hard time seeing what issue we are attempting to fix by doing this.

-- 
Jens Axboe

