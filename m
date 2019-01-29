Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF69C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6566821852
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AKFez0lR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfA2Pyw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:54:52 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33191 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfA2Pyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:54:52 -0500
Received: by mail-io1-f68.google.com with SMTP id t24so16738738ioi.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=70VXhSVFTqbfaoMFgcagL7YuqvG/9Er/tNILE+A6WeI=;
        b=AKFez0lR5tXNJmRKHaDtAWMT+pKHV9TELyLRnM2gY97C2g5HuyH0Rc3KFBQoHgmpcc
         0AQoj4Kuh7T3zhAu9B0TykRKKG8VPeq4tLhghCi4tYwxtWOzr5vHg1LEmURp5YS7iAP/
         YpuJRrvZ+gcTCPwYG9yCtY6Xdp0MNZOOc2Zvkqedll06y6BkQZNxG5lvQHExRje1KC35
         lxjZmcbW/na7Id/K+2BMahXY/ieHlwOv2vwxHc4qgFxppuN5Lx7qdy+4/etqqfT9TH3u
         tY+DWYsOJKY2aX3fT+EEip1JzXEZW9RXD4xxY/kgBwj5SxOu28PTylQSeiBFTBokV0Cb
         8GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=70VXhSVFTqbfaoMFgcagL7YuqvG/9Er/tNILE+A6WeI=;
        b=BOhSV74CycatxUWMaJtivB3BS0dt73r0sR6MG5vdUIEecXCsfAmaHN9x+tZDSJNeJ7
         UTPbM8WowNqmaZmlyo9ED1UPvCxf12NXvN4wMurj5oLTwB0cOpv044/Ar+vdDrA1wVJH
         kG8bOS/eSGpks4FwqGcW72Ls4YpsTqBheZPu+b/uyYT+V/1U/UpD4LBSSEL4nH+1SrbK
         PRSitFtuQrgthnal1a8baKGoUoq37+FpHa9uZQuxWDxJdUIIJ8kFP9cgPHvbpIZ+dMph
         GLDu/p7cTWdMx8bUc7skIHMITLpoWdgY7J/77jZdU0l6MSzw+SNd4YKuu3mSx6SjRQ0p
         YeEg==
X-Gm-Message-State: AHQUAubFg+UxgWfIPWQsMrhpjXCGBe/Gbez/1gyPSH9tikig7Tdf15qO
        txi7S3sJ77UlePBz3lR3Xr3JQQ==
X-Google-Smtp-Source: AHgI3IbPvivaNO6uE9fVGgKJNI5QDvINeibotZq8X9gwICZfY9sqJHVP1nKZHSIyHKSbhafHKf66Cw==
X-Received: by 2002:a6b:3bc8:: with SMTP id i191mr16498732ioa.23.1548777291797;
        Tue, 29 Jan 2019 07:54:51 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x21sm15182533iob.84.2019.01.29.07.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:54:50 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <87tvhrpsqg.fsf@oldenburg2.str.redhat.com>
 <74fd3127-75f1-3a48-d3cb-a8f6c9bd0b74@kernel.dk>
 <CAG48ez0PPWP7GU5kinzejN1B3invrcxCZT2fkpnHxMK2F0pj6A@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <41d1cd0c-8a0b-73a8-32a2-c5ef31425fae@kernel.dk>
Date:   Tue, 29 Jan 2019 08:54:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0PPWP7GU5kinzejN1B3invrcxCZT2fkpnHxMK2F0pj6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 8:38 AM, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 2:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/29/19 5:12 AM, Florian Weimer wrote:
>>> * Jens Axboe:
>>>
>>>> +#define IORING_MAX_ENTRIES  4096
>>>
>>> Where does this constant come from?  Should it really be exposed to
>>> userspace?
>>
>> Seems pretty handy for the application to know what the limit is?
> 
> The running kernel version might be different from the kernel version
> whose headers the userspace code was compiled with. So if this is a
> limit that might change at some point in the future, and you think
> userspace wants to know the limit, some other API might be better.

Probably best to just kill it, we'll error in io_uring_register() if
it's exceeded anyway.


-- 
Jens Axboe

