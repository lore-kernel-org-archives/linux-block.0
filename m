Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F31EC433DB
	for <linux-block@archiver.kernel.org>; Sun, 31 Jan 2021 15:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6F564E24
	for <linux-block@archiver.kernel.org>; Sun, 31 Jan 2021 15:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhAaPQg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhAaPGw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Jan 2021 10:06:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B450DC061756
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 07:06:08 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q131so9822666pfq.10
        for <linux-block@vger.kernel.org>; Sun, 31 Jan 2021 07:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RhAfW3bOZ/JfCqopnjfz8hQSvqyWBPdhdc6w/zDiwfc=;
        b=IuEYztJTmZOs0kVtPjKiHZTmlePgiPP90jNwlu7kB0YG9jG1mKAoE771JYPnoB+d3s
         7qYP8K7lWDPtq9EOszLpt9J17q0um0JnaJuFIWJy9UcWwyBJQjfZ1EP3NWWnN7C5U+d1
         C8UepgnzBNj+bK8L0ipZFYzLtAcgC2CKj1WpmSe8kqzByWUL1OBceXEGDaTsY1VKLE9D
         lP/6IehcIgj4OYhEacOjra0NC0R4BCqBczxMGbpKb+SxfPRPvQRW6XNPqxeyOdErN5JT
         Xp1jnN+1wjwAxsumwoIbJ0Ft+loZsWg7EojlasfXNk/+T3/IJLu2Xvp/T4+KrTx0YtL7
         49bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RhAfW3bOZ/JfCqopnjfz8hQSvqyWBPdhdc6w/zDiwfc=;
        b=LisR/LCssQiBtMqBT32mnqrvQZNJ3HOtaMRydWHTby0Q546n5MjUZEcyfGpZXheQYn
         kVqwP0rk9bo1mAJs5Uk+mvprh8WZCjWgbkHZZ/yuOGezpSUAHtgmKetqyJWY2wrVmCGW
         1BEVcFNd4SH9g6dMryfYbLup3zCOfnhx/K6PvXnuIrrshX9E966irkuUNAWByslo27yo
         FJk35wgba/xs+RodwvnR6DiMJQnwSqlXbe3d6YFQ5bsgdqAWUWGREoYtYSu9Urr8YUJQ
         XGYUaz3uZwnMqIlCpZH3Oji/L3pXXZRgzGxCrxaagT+2ro2MlBH8IwMXTHPKmajgwNkC
         rL4w==
X-Gm-Message-State: AOAM530nA4ExQc79+mG7admCa+KAF7TRSy8H5I7QRHFnaEoSoO60IoMO
        r8PcG8Di9MjoW139CvPx69i1Efv8b/UJhg==
X-Google-Smtp-Source: ABdhPJwIrY3pQVuft9bDOjJNjgrxQ/cadRkh846SmN1+jYXqxUz3/NqaB3dVRUWbkzUeNQQTZX3MkQ==
X-Received: by 2002:a63:1c42:: with SMTP id c2mr13354451pgm.304.1612105568223;
        Sun, 31 Jan 2021 07:06:08 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c17sm14357248pfi.88.2021.01.31.07.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 07:06:07 -0800 (PST)
Subject: Re: [PATCH 06/29] drbd: Avoid comma separated statements
To:     Joe Perches <joe@perches.com>, Jiri Kosina <trivial@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1598331148.git.joe@perches.com>
 <1c8081264d82101d7837220c5ee221c307da5d91.1598331148.git.joe@perches.com>
 <5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8a2099ab-9b25-d79c-f421-0a3a2ca15720@kernel.dk>
Date:   Sun, 31 Jan 2021 08:06:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5deee552f4bcfd81c6dc6ec3e8139c0c4ba27d31.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/21 11:57 AM, Joe Perches wrote:
> On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
>> Use semicolons and braces.
> 
> ping?

Queued for 5.12.

-- 
Jens Axboe

