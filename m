Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053DC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCBB2082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DImgXLqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCBB2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLESEo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:04:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35236 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLESEo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 13:04:44 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so21642603itp.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zQqYYZ+zuNyePUIjvkO4RjucnvwXuTy9eM9x8ocBYE0=;
        b=DImgXLqS0DKdnuWmfik5R/RFnaZyFQG30TosRAQl8KJv59wCqDRxOa3XqQen6w/gEJ
         kHWS8m7E8ffdGYkquFWiB5bdk15WgFeEXQsxwyvYLFEBfgbWwkdGXqe22Tu/nj4pvbQi
         JvmsdCALfqWi++OfD1wg3nhFfTWf2kXxlOhr+OsPMd5k9Yrwg8g2anaebOAd7sLE/2m8
         Gyd66BMOSAhqvHr8y5yhfMl3Cz2Lx1t/0ed4nuJwxW4rueOAVRGF6lNM0CYOePOv16TV
         GvCmL2ZUOqhgcdVGEjHIwi22/8WivaqolyuliHc8N5JBFXrqE920SsAK8cSHBXww5i4P
         f7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zQqYYZ+zuNyePUIjvkO4RjucnvwXuTy9eM9x8ocBYE0=;
        b=lkC8KZaJeo6Vz54sz+4wGPZNkenRtulijyonO1JOPbSXL/l4eUY4jQZV6rhwSf7/Y0
         H9xHC3GI7dV9QIFUaX4vJZZlFgzbHskWYTIPwzlwMW9Fjuypv3U4YbLWTDc2oE2MZQL6
         4rdVTe1l6m3X3ekYZPUrqlkeR4SOqSyeYc0g3hNIQgqvj/LR4+MkC+YvoDRQWIYMBfx6
         m1ETtn2nSw0uKuStXMTTOeKtSMDAWFcxmrs8XN6BnmXUXKwQPDEJscV/osvsFDJJe+oy
         ogl6VLOP1BfJnM0xNRUyur5V176yX+XjfqcQyXg7IrqwCUaXRp5L8CGsfa64Kv52ZYkr
         HU4w==
X-Gm-Message-State: AA+aEWaWs5JEYAfdt7bS2xaHe+KasfhT8tIAeDcl0M4uh1MdncchAJaF
        qV1vigZU+UR3DifC3qdvOWd+2d0Htg8=
X-Google-Smtp-Source: AFSGD/UwZjGjfhdMpOIQfDSk7E59T09R+IhdldHhlC61WQ16YbN/W+57x1mU9thty1fdXVW1jl8xnA==
X-Received: by 2002:a02:84e1:: with SMTP id f88mr16768509jai.107.1544033082154;
        Wed, 05 Dec 2018 10:04:42 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f21sm6937241itc.14.2018.12.05.10.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:04:41 -0800 (PST)
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
 <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
 <20181205174942.GA9838@redhat.com>
 <eb184c39-9d60-0fa3-0d27-7af2f78d601e@kernel.dk>
 <20181205180347.GA9966@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <779ca97e-3353-5fd0-9899-73de8a0b2cad@kernel.dk>
Date:   Wed, 5 Dec 2018 11:04:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205180347.GA9966@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 11:03 AM, Mike Snitzer wrote:
> On Wed, Dec 05 2018 at 12:54pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 12/5/18 10:49 AM, Mike Snitzer wrote:
>>> On Wed, Dec 05 2018 at 12:30pm -0500,
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> There's also no need to pass in the cpu, if we're not running with
>>>> preempt disabled already we have a problem. 
>>>
>>> Why should this be any different than the part_stat_* interfaces?
>>> __part_stat_add(), part_stat_read(), etc also use
>>> per_cpu_ptr((part)->dkstats, (cpu) accessors.
>>
>> Maybe audit which ones actually need it? To answer the specific question,
>> it's silly to pass in the cpu, if we're pinned already. That's true
>> both programatically, but also for someone reading the code.
> 
> I understand you'd like to avoid excess interface baggage.  But seems to
> me we'd be better off being consistent, when extending the percpu
> portion of block core stats, and then do an incremental to clean it all
> up.

The incremental should be done first in that case, it'd be silly to
introduce something only to do a cleanup right after.


-- 
Jens Axboe

