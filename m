Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 02:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiCVCPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 22:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiCVCPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 22:15:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793E2C659
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:13:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so907800pjq.2
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 19:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=/P5OxnbhR7ZamFX8YYhdx2mwWRK3X+/iFJvuu8S48vM=;
        b=NGSKX/X2mKuUyToosxIS5+0WGOeH6xO2NjvXT2cYuoflZZ/P/WiIXlGIQtN02Upp17
         A7DBJ8v/QjGQJul0eXdlJaG4ctmIcMT55c5YupMT198Na/PeRVZIvL45M1qECr6TP3Xo
         XL4XgFL+Doswxa6cUUhkLEZ9XeSbLVyFkUQXRf/SM2vEU97jDFug9Sa+UmfPMnotF5NC
         pUgjQQ5JqWncjm1j6jlWZwjuo6mBD0XMvS0NQUyIsYqt1GuQLFnLAG3ElL/jieTwbkcc
         BR4SunEIes66nKmKDLC3LqmJ2RMpAqIcjrAdFqirgf2g+KTXkT/E2tkDYkQ+/Iv27/I4
         PUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=/P5OxnbhR7ZamFX8YYhdx2mwWRK3X+/iFJvuu8S48vM=;
        b=RQ7pSlqWeskmkp993qkTamo7A8hYhb6KKzvOnmdy/ojO74nsZq6eZkMULD5hVoFWFF
         RxJOhUx+VkcFZI143mYD1FKK5PepHjyIfOchbqWBGVKhkebuit0crNGd0ChewztGLk0F
         nYZRvURFfGVzvBojS0bYBf6dIye5TdXR3pJQwkKbo27DpiX52rjrHxsIcO7gj8vQA7BJ
         uT4Xaj3SB2OkZK6ORBqpq0Vz3jcE/QXNoA3nMEurZ3PiENatVNXZLhuzi1a91I2KD3WZ
         nJe21bo4UcGT/pmcSklgNjl+h+IAYXa3USQF+pbCj8u/fgNWfnuQsXR332E6utT1Z020
         8sbg==
X-Gm-Message-State: AOAM532Uatq7V1ClnHJMZ78su2mXOQ0FbwewPgWmzhoDi0NN1i8C6aUj
        h/vu22zBXB3ALy+OCHTuPzHjINLoIjVYv+R9
X-Google-Smtp-Source: ABdhPJzplrucW/7UezO/Un55ans41N13Nr5a+oBs0xCS/lvmLB3S9aGEDvHKbAi1A5AC/7B0uXAkow==
X-Received: by 2002:a17:902:b590:b0:153:a243:3331 with SMTP id a16-20020a170902b59000b00153a2433331mr16410436pls.129.1647915191809;
        Mon, 21 Mar 2022 19:13:11 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k185-20020a6384c2000000b003821dcd9020sm11321713pgd.27.2022.03.21.19.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 19:13:11 -0700 (PDT)
Message-ID: <d28979ca-2433-01b0-a764-1288e5909421@kernel.dk>
Date:   Mon, 21 Mar 2022 20:13:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220308060529.736277-1-hch@lst.de>
 <20220308060529.736277-2-hch@lst.de>
 <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
In-Reply-To: <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/22 5:55 PM, Jens Axboe wrote:
> On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
>> This field is entirely unused now except for a tracepoint in f2fs, so
>> remove it.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] fs: remove kiocb.ki_hint
>       commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
> [2/2] fs: remove fs.f_write_hint
>       commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf

Upon thinking about the EINVAL solution a bit more, I do have a one
worry - if you're currently using write_hints in your application,
nobody should expect upgrading the kernel to break it. It's a fine
solution for anything else, but that particular point does annoy me.

So perhaps it is better after all to simply pretend we set the
hint just fine? That should always be safe.

What do you think?

-- 
Jens Axboe

