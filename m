Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1264C433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF28064E12
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 19:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBVTiv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 14:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhBVTit (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 14:38:49 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0F2C061786
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:38:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e7so11902416ile.7
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lCpqEV3eW8CcyGSmXvovayWJLt4fKp6FGKh4rVVK4UQ=;
        b=0s6MksYdEfGF0ZiiNsEafPdAgPr0ygnxD+aBaBry+AlmjnJwzoKo5loodzunHaCYBd
         pOa0yzaJk/zc85HljsBFIx/kKQW7Bwwtz1Dq70hY8wJ0nMtqmqgXm1o3YsmEHRD99sxC
         +wT576ok11KhJEINoGZYaoB59TweOua7g86d+Nz8ChFxPSws8qQ55ymOVf66M/D2rr6J
         fYyWTz3cPluKLhlJLgNjHmxr6a52Yp4aAtT4/1wN5Eih/xPknK8OYXmlC4Fax8lkRVzY
         sYiDb93Y7ErLN9EblEcuiHW8qyBXiElBCA6+PHd/Tuz5r0gY5rFdbn0lL4KhyUEV6dvG
         7Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCpqEV3eW8CcyGSmXvovayWJLt4fKp6FGKh4rVVK4UQ=;
        b=mn5yrC+mQxMDAdJ9aYQ0tliskPAq8ngDO9PJRCTMatYZ5Obv7DOfAQBeqJCdU8OQa0
         IkAZYpzEEs5KbB9QyVtGRO5WFEgJqEG6yPG9VqgVxmDatW33jnWJ3rwPKHUwNvZb0+3n
         ec5cV5MKHIbd79CmUKLrRU7A89Pz0XO6axgVK0xh3wHjI28/pyBHLvSUqpy7bZrBiTUm
         IbbVKiM7oYg0AX+262jE/6L5c1O/OiYjrXejyw00ZA52hA8nSTrlov1vAVlexOp8IeWg
         G7NF4rAKBceJOzE8NjuAwfGKAKJ0o8iiEOSaxOWbWDANyw7W6ei/Qt6RdjGOew8fg2ft
         VRYA==
X-Gm-Message-State: AOAM533orpmQme9UoNHFs+Vlu4HPMUjfwVuyCCHb/XPMBisEs0vkeieI
        kYzVRlRjbV0vf3BV5EzXSKNTzA==
X-Google-Smtp-Source: ABdhPJzhF7sCROPKsaZ5xG0H1UsTGfn1Cgg6gr+MFUVNyhC49BkqhWuGUImqQ0L8J9LD1DcIPcxYiQ==
X-Received: by 2002:a05:6e02:586:: with SMTP id c6mr9184545ils.106.1614022688906;
        Mon, 22 Feb 2021 11:38:08 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j1sm11850949ilu.78.2021.02.22.11.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 11:38:08 -0800 (PST)
Subject: Re: [PATCH v2] kyber: introduce kyber_depth_updated()
To:     Yang Yang <yang.yang@vivo.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     onlyfever@icloud.com
References: <20210205091311.129498-1-yang.yang@vivo.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f94990f-2732-547a-09f4-42d5a6ab77d7@kernel.dk>
Date:   Mon, 22 Feb 2021 12:38:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205091311.129498-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/21 2:13 AM, Yang Yang wrote:
> Hang occurs when user changes the scheduler queue depth, by writing to
> the 'nr_requests' sysfs file of that device.
> 
> The details of the environment that we found the problem are as follows:
>   an eMMC block device
>   total driver tags: 16
>   default queue_depth: 32
>   kqd->async_depth initialized in kyber_init_sched() with queue_depth=32
> 
> Then we change queue_depth to 256, by writing to the 'nr_requests' sysfs
> file. But kqd->async_depth don't be updated after queue_depth changes.
> Now the value of async depth is too small for queue_depth=256, this may
> cause hang.
> 
> This patch introduces kyber_depth_updated(), so that kyber can update
> async depth when queue depth changes.

Applied, thanks.

-- 
Jens Axboe

