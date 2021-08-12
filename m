Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D5C4320A
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F27610A3
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhHLOxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbhHLOxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 10:53:23 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF3C0613D9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 07:52:57 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t128so10759325oig.1
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pSujOi0O+xDmuzKXFBHwC0crGS/A/pfV6LGkL8BeDG0=;
        b=a9OWExA5mhPX1PpKJDMKYmPNi3BPhxrmZwFsLoBnlpOgXcpWc7A0yvS1mlpOhX1k+6
         NGOyRGeroQ/SToTAqOIThQ8UQO4umU5bWwxWKH8PB2A0Ff8xvN9i/o/WTWwbt6kPkGZi
         9rleBoNXUyiC1WblCcea3/Sw+WbZrEyfGZmlCNBmYgmKZV+upkC2NP39j90v2mOv4fyO
         M3at1vBX0uwoWuptiSE8f30A3Z3pZkazz5H/0Ob2cjCdBfOaJ/xaAcXl525sGm/gdm8h
         UnARM/ZVROSWBxSrxPffhlZJ6m6ECMqxjWU9abOJPKo0yl67DxUU/d1IQi4YbqB1cS8u
         jb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSujOi0O+xDmuzKXFBHwC0crGS/A/pfV6LGkL8BeDG0=;
        b=E0gvYvF4Vab6tR/QTK7PUpadbBGgpMwhMEsWU/peOLmT9K9oYlywQN2kCpwvykfi1c
         50wtxcUU/W7/UlZJlZnVdaLddyejVvkv7wO1qdVoUxPZ2YChvXjUvc8X3gFw6N1bDiIM
         dlWHCTvcITNrGhhWKxHFUHS7LQ11MYKsLA1l8mwNr6TuJSTsZIHuS9ftEAueTKS8EkqH
         C8vylKMq9+C9irqwyx9sA7fK/uOYVy2xHH7WHVNKLphtWdj2C7ni5kOcTK2L0G9/te9j
         t1SXUw3GqUrwXMIY9UEH/O89HP4polYjA8PFm+njL3fqiI2m4xSV+CCmtNzAT5APw839
         bg4w==
X-Gm-Message-State: AOAM531AM27O4ExG/vcwVp5zBhGWb5TEYzYL5m69PiXImf5pYV+uBij+
        aE6EsVmHEYvuLgbCeku8FLc9WbepQ8crTvGo
X-Google-Smtp-Source: ABdhPJwyPZ5o608iMR+/qClTlJxA5wcfGnhbXnD5DlTcVbH3yiQT5t8fbiAbmwtuTsQWMX+xi2esbQ==
X-Received: by 2002:a05:6808:209e:: with SMTP id s30mr2718429oiw.177.1628779977048;
        Thu, 12 Aug 2021 07:52:57 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l7sm650322otk.79.2021.08.12.07.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 07:52:56 -0700 (PDT)
Subject: Re: [PATCH 2/6] fs: add kiocb alloc cache flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
References: <20210811193533.766613-1-axboe@kernel.dk>
 <20210811193533.766613-3-axboe@kernel.dk> <YRTFqraI8vckPjRV@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b8eb8f25-a539-eb74-e841-c2b024930f46@kernel.dk>
Date:   Thu, 12 Aug 2021 08:52:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YRTFqraI8vckPjRV@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 12:54 AM, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 01:35:29PM -0600, Jens Axboe wrote:
>> If this kiocb can safely use the polled bio allocation cache, then this
>> flag must be set.
> 
> Looks fine, but it might be worth to define the semantics a little bit
> better.

Sure, I'll expand that explanation a bit.

-- 
Jens Axboe

