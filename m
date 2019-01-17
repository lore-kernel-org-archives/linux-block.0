Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A0C43444
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F72A20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 01:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qHtTFLa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfAQBdU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:33:20 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:36965 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfAQBdT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 20:33:19 -0500
Received: by mail-pf1-f179.google.com with SMTP id y126so3963224pfb.4
        for <linux-block@vger.kernel.org>; Wed, 16 Jan 2019 17:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9X+68BLdNwJ9g4OWDPH4HVUNoCdQCeFh2E4sXogpdOU=;
        b=qHtTFLa3JA0LTNlBEK5burTyeFIwgTzN055abfj1Bo5a/05JHxpdyCmEbvHfQdonY4
         sQb6og1GMXP/3kFyl1zsspPEoQCPr3VxqedfRoSBWi5iOUNQBui7TRznaNypFmqi6UJC
         hAiWfukz+GAbJHR3S1xu+4DuocvgNyTqj2ecrP74y+tkRsTTbeAvLa7ERT74evCpwp/O
         dJw4HXYi2ohytY/KzicpPGetqogf93BAZGHCrHI4SxOAGoby6JdGXSJHLZ+o2h+8XMfa
         ZuKr550JEYoouuOi6RXaQJv2lzQKjADMMmQdy0lyftuaVQK3gcOpOOyEeLDGDDLX32F4
         0FNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9X+68BLdNwJ9g4OWDPH4HVUNoCdQCeFh2E4sXogpdOU=;
        b=W8L0LFiXsN9rZ6Vf9ukvhug772DFkUZYG2RHusTOsJwfwBOS1nr2tyiRoMHlMwIr7t
         DC9O6Cbn/duZT61W4SlAxTGP7QU2lxOVXYupKoGs+8lrS8DO3z8GSU6K/8l3YzqPtfZs
         8mW9b6LiiZloGM2UG+YIyy1yKV2TWJkByZF1M78cC+Dk+C8fQCDk5tzFLXy5F1EUB0Ax
         tsex7srZtnx3G9KFAjzb7WRx4v3/t065/5mY9FNALiKcKuKqul3gYS+7aZgnMuSB/hPb
         9CT5ZRv3mvU8yXz00eDwIZasgoB6UdjazdTGrjwRHh80aGwA/VHJ8JhNDkINLLO9Hn0A
         /2pA==
X-Gm-Message-State: AJcUukfA4dvBsgvuUe5uw04DuJuQZUFI2VW1nL8mKy6KVpwkCQk4wDk9
        AX+afVoj3bupKc/bG+YfrjbqU0oMie56Hg==
X-Google-Smtp-Source: ALg8bN44GH4jg42MS252Epkzq3/ru2i5i8xFFeYsGkIdaC6bchsyYTwLBK6aIgi2zgX9xeb6JUtjLA==
X-Received: by 2002:a62:6f88:: with SMTP id k130mr12845605pfc.234.1547688797214;
        Wed, 16 Jan 2019 17:33:17 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p7sm91711pfa.22.2019.01.16.17.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 17:33:16 -0800 (PST)
Subject: Re: [patch] io_uring: don't allow duplicate registrations
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
References: <x497ef4hzuj.fsf@segfault.boston.devel.redhat.com>
 <9965e26b-1490-7a18-e112-0d2318b8b23f@kernel.dk>
 <x4936pshxxp.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9e265baf-d66a-f633-d01a-31b99af42264@kernel.dk>
Date:   Wed, 16 Jan 2019 18:33:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x4936pshxxp.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/16/19 6:31 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/16/19 5:50 PM, Jeff Moyer wrote:
>>> Hi, Jens,
>>>
>>> It looks to me like calling io_uring_register more than once (for either
>>> IORING_REGISTER_BUFFERS or IORING_REGISTER_FILES) will leak the
>>> references taken in previous calls.
>>
>> Oops, thanks for that. Let's make it -EBUSY though, everything ends up
>> being -EINVAL and that sometimes makes it hard for an application to
>> figure out wtf is going on.
> 
> Sounds good.
> 
>> I also added -EINVAL for unregister when not already setup.
> 
> Yep, I saw that.

Changed it to -ENXIO, that's more descriptive.

-- 
Jens Axboe

