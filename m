Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D63C19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 18:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbiHGSpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSpX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 14:45:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8E210EE
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 11:45:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso12625061pjq.0
        for <linux-block@vger.kernel.org>; Sun, 07 Aug 2022 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=eQt1kg8EcaWTWGzydG+NN0DWHYWcmYFFjlzGWtVlLLk=;
        b=8RuByZd9OJUSI7rjo+BOQRlYKQRYxsP/1ViGZg+jhlTvq1ltDhJwWo+BZ6Kcat2RjV
         dyOHEf30Bujf06X86OAxjkPUaVf+vnVoSdNxUNpAVaa+8+OBvPZadeUzUXXsvYPLBrI7
         p43Kgm4E0dXHtof/gGJdIMwEtdhK48jzRqkeSvHDEEIE5o8iRMys4NO86e9QxkRJhnqS
         2eSl24o0BtqhzJv+F/5Q9iT/nCcxWTXXpRgqgYwJxLlZXg6su8DFM3/Ai1C3qWmHt2wP
         kbb5qDfvaaGBgCdt3rMqm/5uMxM2mOf7B9quFdkpRP7bbwbTRIpMHbj+ZMDRmhfzFMej
         IRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eQt1kg8EcaWTWGzydG+NN0DWHYWcmYFFjlzGWtVlLLk=;
        b=XKPf2UGuiqmrhMY/K8ce82kq3i853XQEWV9Qc0R5xju74pybTQ/r3S8yLZzgtnDk/i
         WAJSjisF0r/3Xn/qZWq81jFDHhDYxO8w5O/Tc8xP9dh6cYvgjxywU7xKvhzwyJdj5yJV
         OfsP35tQQ0Cn+K72pmZvzUJ59lvnWnlkgbVFT/Ux58ZXtw1Dq5dnYy7MLHLt1WoIMn5b
         NaCjGZNkj0vTLNLtJk3nqIObRMK0icFOVp6PgNHVG3Q2AH+Y8qQtC74LtaVsKL4n+WH6
         Z26G7uV0Cuv3Uik4ZZAeqrwxf2cXFaZPhrkfjntB6qBcevVCGplAnM/4OvizfaF5g1ia
         UFVw==
X-Gm-Message-State: ACgBeo3wFvb2X1OYEsKvE66iPMYExmQLpsidmfwU0966fGwh4wJ2csvk
        DGj8qdBRar+Rt2nJs616UELvDV14Ln104w==
X-Google-Smtp-Source: AA6agR6dvAtna4vRPmouEj3NJfTiGOVwc+PrBgc3WawSL9/4Ucdf+g8LcF8gVMoI//28ULsqAeBeTg==
X-Received: by 2002:a17:903:2291:b0:16e:cf55:5c72 with SMTP id b17-20020a170903229100b0016ecf555c72mr15645616plh.121.1659897921094;
        Sun, 07 Aug 2022 11:45:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j17-20020a170902da9100b0016efbccf2c0sm7004113plx.56.2022.08.07.11.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 11:45:20 -0700 (PDT)
Message-ID: <a59f6328-b81a-c529-7553-2bef94f9b5a2@kernel.dk>
Date:   Sun, 7 Aug 2022 12:45:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] block: enable bio caching use for passthru IO
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org
References: <20220806152004.382170-1-axboe@kernel.dk>
 <CGME20220806152012epcas5p41ebe594bc59a4a0ac0733ea1c052f241@epcas5p4.samsung.com>
 <20220806152004.382170-3-axboe@kernel.dk> <20220807180855.GA30655@test-zns>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220807180855.GA30655@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/22 12:08 PM, Kanchan Joshi wrote:
> On Sat, Aug 06, 2022 at 09:20:03AM -0600, Jens Axboe wrote:
>> bdev based polled O_DIRECT is currently quite a bit faster than
>> passthru on the same device, and one of the reaons is that we're not
>> able to use the bio caching for passthru IO.
>>
>> If REQ_POLLED is set on the request, use the fs bio set for grabbing a
>> bio from the caches, if available. This saves 5-6% of CPU over head
>> for polled passthru IO.
> 
> For passthru path, bio is always freed in the task-context (and not in
> irq) so must this be tied to polled-io only?

Right, that's why it's tied to polled. If polling gets cleared, then it
will be freed normally on completion rather than inserted into the
cache.

I do have patches for irq bio caching too, that'll work fine with
io_uring:

https://git.kernel.dk/cgit/linux-block/commit/?h=perf-wip&id=ab3d4371227a34a5561e4d594a17baaad03bf1b7

I'll post that too, would be nice if we can figure out a clean way to do
this. I have posted it before, iirc.

-- 
Jens Axboe

