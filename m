Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D89C3A59E
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EE21726
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="spaP4VWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfHPPMg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:12:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37858 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfHPPMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 11:12:36 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so6832423iog.4
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YuqhzAOotFlJJ+JGT4X00VewlHM+EBqkIgPZ06dmKIY=;
        b=spaP4VWpJEN8MiRhYjzCjbcDYMJyVThVCmHMMLjphY4k/4BjvwldiAxe1mZgAGqhFj
         ppT9DGncjOZQMxQw4YdXkq6AiQLMkb1r5EvsyMSf4u3hdeCYruuRRkidj4L3t1jeVuZd
         SR2EDa14WMDwdec55vFX9a8oI/Pc3nZckzLM7J545NEONCAEzzZcqQjDUNAUwmgfU97Y
         Ba/In/s1HWiB6uFvUM+Dw2x4H6UMeoM8IPeXtfL4711lrfUbFg92XgUXk2Xg7lJ/2MQ1
         NkL8uv5Wz8SdXSD0WRU+Gpj5WBc81hWnx3RJXWuYQq0tyyyptcyTbfMNaRb3DTuBMXdn
         SC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YuqhzAOotFlJJ+JGT4X00VewlHM+EBqkIgPZ06dmKIY=;
        b=Sq3kExrvmXLphPpovfxMLrtB62MXBuXLc3t6L4NZe8DFbOWblFbVUIG9oLX7ZSNmRL
         cB7b9kaHJNwdvf/eZRpANCUnH/CHElkaCUTIPAZD4hh7r85ZCH4D8nuYN2ivEzNqd36e
         MhV28cSQxLmBfXC+jKeqG9AXFluaC/+okFA+atCpL1tj0Iu6bpQWUXWac5xnU1YtQJ92
         295BcDHTTWIm8fx5CJodglzhgHqoELrSAIoJ//SHQjpsBNexahSDFxlyg/ZOe+0h4U0I
         dxTcyCCQsD5DufS8Lap6f1Pwjk6Ui3XycSQgYqMDvvKfuvYuOHh+M+FxJvf79UqGMafX
         F0MA==
X-Gm-Message-State: APjAAAWu1sWjEdh+4UTrNSIrNi6RC/elsHtdxvHnyR79iB1dZoY6N8u4
        6tHOYRhX4+ys+LmM1CP4mnAMmA==
X-Google-Smtp-Source: APXvYqwhR1qd2Q1b39cMr4h7RNgFKYgffpKLNQDVCt9p89pHPRD6svMydf7dE2AL+6qRBKvp8Tpq7w==
X-Received: by 2002:a02:7f54:: with SMTP id r81mr2065705jac.129.1565968355657;
        Fri, 16 Aug 2019 08:12:35 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c18sm3738538iod.19.2019.08.16.08.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:12:34 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: remove blk_mq_hw_sysfs_cpus
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>
References: <20190816074849.7197-1-ming.lei@redhat.com>
 <5baa0c28-6e12-5a61-0254-de0e49cf1596@kernel.dk>
 <20190816145435.GA3424@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b0f1017-ea52-a155-fc05-e22006813105@kernel.dk>
Date:   Fri, 16 Aug 2019 09:12:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816145435.GA3424@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 8:54 AM, Greg KH wrote:
> On Fri, Aug 16, 2019 at 08:20:42AM -0600, Jens Axboe wrote:
>> On 8/16/19 1:48 AM, Ming Lei wrote:
>>> It is reported that sysfs buffer overflow can be triggered in case
>>> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
>>> blk_mq_hw_sysfs_cpus_show().
>>>
>>> This info isn't useful, given users may retrieve the CPU list
>>> from sw queue entries under same kobject dir, so far not see
>>> any active users.
>>>
>>> So remove the entry as suggested by Greg.
>>
>> I think that's a bit frivolous, there could very well be scripts or
>> apps that use it. Let's just fix the overflow.
> 
> As no one really knows what the format is (and the patch to fix the
> overflow changes the format of the file), I would say that it needs to
> just be dropped as it is not an example of what you should be doing in
> sysfs.

It's a list of CPUs, I think the format is quite self explanatory?

But in any case, I'm not 100% opposed to removing it, it's just not
one of those things that should be done on a whim.

-- 
Jens Axboe

