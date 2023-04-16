Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237B7C77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDPS7X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDPS7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 14:59:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892C19B9
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 11:59:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6a50dd62cso567685ad.1
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681671560; x=1684263560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Osq3/xGJnLBS+77uU6cCC566r6Un+w4D9fG7F4UEIuA=;
        b=g1l1TRdwNSj1+eDVcneE5rqvH7Nn85oZfiuw7gBr+31BCAP05gMH3sLeM8PGNbYsvF
         LEj35tHO+LOeto/KLdt1UW1B8uqakduSujcgZmcITHruzyHkvHcZvkbGEcRZBnAQOhgG
         d1/TWP0tLIwICmLPNceemSgq6tB/ZKB9pIXr8SznDRC6b3GPrjfSyM4xQoIkah11fAQw
         sq8Yx1w/FRTt7AwCz9uTsognI1/B7EP6+rjNQOIZEp8xRA5/YL2I7Y76E1qajQhGdVIP
         L+2GscmaLoM94bIkXxskMT5kejdClmKjVfpeFKaAGoSn3MfLnHWzvph01wiFQXdPw1dl
         momA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681671560; x=1684263560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Osq3/xGJnLBS+77uU6cCC566r6Un+w4D9fG7F4UEIuA=;
        b=RTt2KDQjIinJfgfuFG3OEnJpjrtCl7LyesskKaZZbbm+sGFraD4WyOas/wk+VozGE5
         iJ4CAaWNx4BaZ3BCOciD8jMNdQOep37JuBK38tXuXZxlqZGiTkcgeW9+76XiLc66OOA8
         jz9aJckjJ6qffJ6dBJFE7h2NeTHgies8GYCyTzerZvrZwZMYjebivzDA8C2ata60XIWy
         SY8URD2ksXIBnOszd6x4uCTT8NoIP+O0g9qDRhELp4al+dfm9AyZ/DRCVoTRhOTfYHau
         wecsY1z1/Y3gZUCzD5iFaQFUUrij376EBNo8aS/5XACPxGuyWoW6IV9rjheq1w9ATJKW
         DdYg==
X-Gm-Message-State: AAQBX9dqmjpgzHcHaHfh3lggk1kDC+AS6DSaynfSp6Go/ML4W8nBOxXO
        w3Mg7oiw8j71BLKJtImmB7zfshk0BZfWyuEYZXs=
X-Google-Smtp-Source: AKy350Z6boMu1LU7Y9LzvtzADStpfQjmH157tHT4+MZzi6GOJPD3D0c/vtRa5SbKC5b/DIo4t46rBA==
X-Received: by 2002:a17:902:d505:b0:1a3:d7f5:5d41 with SMTP id b5-20020a170902d50500b001a3d7f55d41mr11185418plg.4.1681671560544;
        Sun, 16 Apr 2023 11:59:20 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0019f9fd5c24asm6149494pln.207.2023.04.16.11.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 11:59:19 -0700 (PDT)
Message-ID: <a0ed4257-db70-709e-badf-e337b77d548a@kernel.dk>
Date:   Sun, 16 Apr 2023 12:59:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] block: store bdev->bd_disk->fops->submit_bio state in
 bdev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20230414134848.91563-1-axboe@kernel.dk>
 <20230414134848.91563-3-axboe@kernel.dk> <ZDuNdUjnrfQF2D7E@infradead.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDuNdUjnrfQF2D7E@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/15/23 11:53 PM, Christoph Hellwig wrote:
> On Fri, Apr 14, 2023 at 07:48:48AM -0600, Jens Axboe wrote:
>> We have a long chain of memory dereferencing just to whether or not
>> this disk has a special submit_bio helper. As that's not necessarily
>> the common case, add a bd_submit_bio state in the bdev to avoid
>> traversing this memory dependency chain if we don't need to.
> 
> Do you have any numbers on how this helps?

I didn't run any numbers, but seems obvious to me that we don't want
to pull in 3 layers deep of pointer indirections when we can avoid
it.

>> +	bdev->bd_submit_bio = 0;
> 
> bd_submit_bio sounds like a function call, so I'd name this
> bd_has_submit_io.

Good point, I'll rename it.

> But maybe it might make more sense to just add a bit that this is
> a blk-mq backed device into bd_state as that might be handy in other
> places as well?

I'd rather just do that if needed.

-- 
Jens Axboe


