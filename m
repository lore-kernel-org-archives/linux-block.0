Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD67C433EF
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243099AbhKZSjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbhKZShP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 13:37:15 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D496EC07E5F6
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 10:10:11 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e144so12378366iof.3
        for <linux-block@vger.kernel.org>; Fri, 26 Nov 2021 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
        b=P8Ix0b+8pqLzJ0JCQMU2IsK8LUujjsUrb3I7IY1MpjfctmRfdlJ4p5tQIRJzkm1aOz
         NEkeOe/Fpw0bltwzcwIBsjrvsMFs+atSgWqaJBoi1ve+1El4o+XCYCZk7ONPmcUPhr0Q
         VY2Y363OEpPx+MVKPTIo7svhG2nMbqSLtYfjGO7290AYp504mY/rhBkFJqwLmxNGmdCC
         IR6hV7/8/Ng6R2bTvHJ81I08OFXyRyKS6gBHjJKWfVSk5khiZDKwJlCNGwfwUBkXrYO0
         yr6CtDeMftUyZMd+0437LW51xaN8/Ora/MppBtTIvenEiWXu06d1T0X1om2tC4k/M9DP
         NNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7CM3ybXkX6FdnmkDgtC04LvePrjVXFwUyZ4uxrkvxw=;
        b=H9FZ+vM+jFRRlMSP9OwE24Btf8iNDDPBWSnl97UjdKveHfLhSjXuopOq5Td34zT0gu
         V4DY+1Zvz3cnAbyLI/8yRp9oLF1EKTa5vgn+AgcULmTgj8a4d2drD9z2puVF9B8cG1UR
         ZA7kjFceSmqEJVMVQsx69wN0tZT1lnBiZm439juM8CxwzpTx600TyqzZGMINweNPrbrw
         HNSpvJUjG1GiVPCjvQCpO2STI+0Ak4vTCkxcSG3nOa1VkE1lhTjAST0Qu6ond3fg+xsL
         6UZHnRhHlT949L4R2s/y4IRGn0u/2xekBDqBbZfh/5358TWQXAWX+xUp2+5QW1LO4wgu
         XnqQ==
X-Gm-Message-State: AOAM531SyBalKYJsn7VeUb6qEhAm04ZTv3HL9NMkGD0g7gDsirR/Y/vD
        4lBsup/Pt7fmnCjUyg14iRX7fw==
X-Google-Smtp-Source: ABdhPJxGCB354MvIlJjaIRBZzlJPUUDQyfSJlCoz2hhDCkTQKLQVSnsDHVTgVFm+cuSMnozo2m/8Xw==
X-Received: by 2002:a05:6638:3014:: with SMTP id r20mr20589348jak.146.1637950211126;
        Fri, 26 Nov 2021 10:10:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d137sm3510617iof.16.2021.11.26.10.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 10:10:10 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
Date:   Fri, 26 Nov 2021 11:10:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/21 10:58 AM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>> Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
>> it for you?
> 
> Since it's related to writeback throttling, is there anything I can try to
> taunt it? I was thinking "iozone" or "bonnie++", but if there's something
> better, let me know.

I'd just do what you usually do, that's usually the best way to gain
confidence in the fix. But it's related to writeback throttling _and_
racing with eg iostats grabbing a reference to the request, so it would
be more likely to trigger with a heavier combination of those two.

That said, I'm pretty confident in the fix, so if you'd just use it for
a day or two, then with the previous amount of hangs you saw on -rc2 it
should provide a good level of confidence in it.

-- 
Jens Axboe

