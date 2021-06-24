Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F64C49EA6
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 18:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BFF613EE
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhFXSDl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXSDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 14:03:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2984C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 11:01:21 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id a133so6068615oib.13
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mgEK6fkda7s0f+x1W2YRcs0/TWFflEBvz/WgVOuAIHM=;
        b=mLS/LR6wS4rovw2VoDmsIOnwlDeJD5jjDVll+4mPEmRvUEFuoMMOCbVfw2pjA/KL3B
         5hah1KnlwiRI15xqWBbHSO4cJfgjj8mUJHLjET4BC/VYdarerbKIk8s0P5R9pJs2TXqK
         CJurnJsu2Hz4WTS/Y/YeoGkwNSws9c6PQvOCRybnWYZVEE0DVZH0FQjdBvHIf2HBZbCs
         2J/zBA70mdU3TGL25o3YgQpekPgxPtaXa9MwYIULh69eDS0FAGvaGG4u+v2kxVrfsccr
         EIMXCA37g+zmlwcalO0p4npNoF4DhOarXoOMyxcDdIIB1x1lhdXzyfS8hlG7RV8RFyaI
         q1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mgEK6fkda7s0f+x1W2YRcs0/TWFflEBvz/WgVOuAIHM=;
        b=kkGZI1pVMU4SCWGaD98nlmC6xXaKhiA4Kv433Zc7anH4I4U8h/xtcoVAJsWq77q2LM
         Kb/YVlVHSNtfTPLqUS3D1XsE75cMZxUJXLLQHy0iDYhBUrdn1zvdzZTQCO3/CmvMXzYk
         LFs3UeYxpw20KWd8t8l7VYTCvTNxPo0HbLrIrX0pzqFC/h1PjYC4oVXD61x+xjjHB+ww
         SCdZaqRkMi/J+qENMJ+uuoTuUGz6Bil4dcqjAzytXTXBzbyBIHbYxyhnMmf3tadGZqcL
         sKcot+ziDJsqGjzS+20W+6/tOy9AKo4OFlqhtflKgu+vyp/71UGqS6W7+KuzqOJARl1T
         Ia0g==
X-Gm-Message-State: AOAM532tlr3EabjQMadJtUejlO0LCukDPaFq+A3/uqwLXFWCMbvF19Pa
        3g4DB3YQ/dVLeqj7UWiX1dP9X4unQ5q6jA==
X-Google-Smtp-Source: ABdhPJxSryDsHBcA5GiAGtXzd5uKVfP7vWSIXf6vRQLdqW4vIBD302kpU6p2itaRv+aNStf2IC+reQ==
X-Received: by 2002:aca:b443:: with SMTP id d64mr4911217oif.68.1624557680858;
        Thu, 24 Jun 2021 11:01:20 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id f12sm804929ooh.38.2021.06.24.11.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 11:01:20 -0700 (PDT)
Subject: Re: minor cleanups to bdev_disk_changed
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210624123240.441814-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb50e293-18ac-9de2-4711-70e8d49d2e53@kernel.dk>
Date:   Thu, 24 Jun 2021 12:01:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210624123240.441814-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 6:32 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two patches to clean up bdev_disk_changed that got lost large merge
> window to avoid merge conflicts.

Applied, thanks.

-- 
Jens Axboe

