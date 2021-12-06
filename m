Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C31EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 16:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbhLFQhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbhLFQhG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 11:37:06 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB4C061354
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 08:33:36 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c3so13646415iob.6
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sKLdLKV0Vy4dcKePFjNOsWO+DAsBQeLawcQze2lYbWM=;
        b=Cu1rnEC6GiVIqaj1QKNBSnq6+OkPUkxEEm5FsZyZpmyv5vALUYoksXz4R7ScEyG97t
         AfdVC+HVaFCZw6aVaNrfbss6wOacCu9Mlc5+qyDhuzo78sCXVZkn+/N2R01T2C1n2/h+
         tuvTDcGBqTxLUKEnc/kvQtrr3IOcTfzQbX2XzoMi1V1noxW+cMnW4CoWcfJCJ27pRc66
         zZ4ZJnK5HmYAfD68eJnyjJHf6GL4cl74kkwyJNlSidgda4c/fUOwdihaFzEfte36wnOj
         /Ac9SyglIoGZM55uoyGo8jw9lP387u381U4vmDi5qVM4xAninP1M4w3qXGoTDkpVyXxo
         X+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKLdLKV0Vy4dcKePFjNOsWO+DAsBQeLawcQze2lYbWM=;
        b=eYQOPsNzWBac0HLRW/km6PYQQhDp30H2UMipkjLXZPHPqQdYyZAlTzRIQ4a34IcrXI
         kHORLwdxjWC7Ie03eY6G/4U1YIRokNyqvnYeL4swSJJxOdMHlO3Z4FbNZZdJnkSoIz9D
         3LUnyzHz16PJMjMM0FSXTTVF/u/XRAufdO2DMxR+qyjsNainsDZmnj2tTVG5+5fg8DAG
         quShSmmSp0p53hdYe7MVJaRIFx1JgFqSmexm/tkOaXAeXqzsOJhbSOrwawxPCLa5tITj
         qwciDV8U0u8sI18ZJglwlU89OquLn8Kaqb9wFDm32SZARP72KmeRrk3SZm9TEZJZys2+
         DYMg==
X-Gm-Message-State: AOAM530A9ckhamhoBFvjUartu3iGorAmX5ZiTTUuAZdGIxiM4JpOYFCe
        DXoXZcahVrLE6DFyfWzc8YHRsQ==
X-Google-Smtp-Source: ABdhPJxtWXMpeas7aF8YYKJyjVk5+wyXHoFj12CWNeGa/Lirgl5LfKrEFlbnWAlsx0+m5Ih5V3Hhbw==
X-Received: by 2002:a02:6d4f:: with SMTP id e15mr43480868jaf.55.1638808415909;
        Mon, 06 Dec 2021 08:33:35 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r18sm6578114ilh.59.2021.12.06.08.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 08:33:35 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk> <Ya2+buqfKSFHWVvu@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05f538ae-d0fc-c557-54a0-06a035ad06b2@kernel.dk>
Date:   Mon, 6 Dec 2021 09:33:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Ya2+buqfKSFHWVvu@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/21 12:40 AM, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 02:45:44PM -0700, Jens Axboe wrote:
>> This enables the block layer to send us a full plug list of requests
>> that need submitting. The block layer guarantees that they all belong
>> to the same queue, but we do have to check the hardware queue mapping
>> for each request.
>>
>> If errors are encountered, leave them in the passed in list. Then the
>> block layer will handle them individually.
>>
>> This is good for about a 4% improvement in peak performance, taking us
>> from 9.6M to 10M IOPS/core.
> 
> This looks pretty similar to my proposed cleanups (which is nice), but
> back then you mentioned the cleaner version was much slower.  Do you
> know what brought the speed back in this version?

Yes, it has that folded in and tweaked on top. Current version seems
to be fine.

-- 
Jens Axboe

