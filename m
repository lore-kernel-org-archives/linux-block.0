Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D56C4332F
	for <linux-block@archiver.kernel.org>; Fri, 11 Nov 2022 17:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiKKRaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Nov 2022 12:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKRaS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Nov 2022 12:30:18 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D241A815
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 09:30:16 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s10so4021281ioa.5
        for <linux-block@vger.kernel.org>; Fri, 11 Nov 2022 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aXO456qaOP1M3JsJcts4UFcPXUKgBOMxL23ZB0rcMw4=;
        b=mLUwO6TqDtBXzrrFM3raYJ5s/voj/2CABngLl5kEgbmXx5H27xhERtZwmg/2tTy1rM
         P2syluaiRg3QUpYU3CGNrPSdu5kOIvRHN6hshAseVDet22qLw2jmTTD17V3YBIcMN7e/
         vcynmeB2okCNwyNupTEzsgv0iNhAxQFGhV5yueEaK3A6pZlwahElRJvLv2VNIsZwqHjY
         HeNrNvJminwUoL47a7e8n9lhSJ60MTkMgJPX+L2x3CsAFqGzkD03cggwk4gGkj9QqjPI
         8Fd13iKbnn6CEFTFfqHATv9+pdhQrylhr9B7IZpwgpumh/G1CfRHDGBO/flByLmaDWUk
         +CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aXO456qaOP1M3JsJcts4UFcPXUKgBOMxL23ZB0rcMw4=;
        b=1uLL3AkMV77VxVlZ4Bo8HzpPCtDANRi/fENAOTV+k5z/IA3fLPBFzpT435f057npGx
         7kyx5pMzqPwcWZIjBE6JMYLAjU7jQLMVG3Qb0ZFIKtRhF9kqKHT2v6aBMBMAN1y9P/EE
         iHHEjk2bjeINLx6JLujir3x0kVnT/C/gNMEKYzB2zAaZpAUZHgWMUogI5I43zMfqqeNN
         hnV5EavGoyixyTq4UUknKWYIvA/ZQxXbHOZKoluc0fipuVKjHALIjN60VKAqtku28cnH
         z5gYgj/YSEUCOOPeOSfkUUUNzsWsPR0/To0gHXfY62VJvLHZ+kyxbj40TdSygYOUjDMl
         209g==
X-Gm-Message-State: ANoB5pnqzrIsYXq44qjZ/3PFFrKJzQq+nOqSweGgZ1fgBJL0ViaNer/H
        Xop9hPhbWB0g68PHvE/TH/krYw==
X-Google-Smtp-Source: AA0mqf4kaujY5OpK6Ujxw29Abhy2Rzuycfz1mUU2y+kvw/dShqU187ciHHS5++sBtFImpPsluPd+/g==
X-Received: by 2002:a02:c4d3:0:b0:363:d7b3:7d4 with SMTP id h19-20020a02c4d3000000b00363d7b307d4mr1242067jaj.166.1668187815869;
        Fri, 11 Nov 2022 09:30:15 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u18-20020a02b1d2000000b00375f143b0c2sm924332jah.8.2022.11.11.09.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:30:15 -0800 (PST)
Message-ID: <db6872c6-5998-c8dd-f8b0-bc71aa7a532c@kernel.dk>
Date:   Fri, 11 Nov 2022 10:30:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v3 00/14] mm/block: add bdi sysfs knobs
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     clm@meta.com, willy@infradead.org, hch@infradead.org
References: <20221024190603.3987969-1-shr@devkernel.io>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221024190603.3987969-1-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/22 1:05 PM, Stefan Roesch wrote:
> At meta network block devices (nbd) are used to implement remote block
> storage. In testing and during production it has been observed that
> these network block devices can consume a huge portion of the dirty
> writeback cache and writeback can take a considerable time.
> 
> To be able to give stricter limits, I'm proposing the following changes:
> 
> 1) introduce strictlimit knob
> 
>   Currently the max_ratio knob exists to limit the dirty_memory. However
>   this knob only applies once (dirty_ratio + dirty_background_ratio) / 2
>   has been reached.
>   With the BDI_CAP_STRICTLIMIT flag, the max_ratio can be applied without
>   reaching that limit. This change exposes that knob.
> 
>   This knob can also be useful for NFS, fuse filesystems and USB devices.
> 
> 2) Use part of 1000 internal calculation
> 
>   The max_ratio is based on percentage. With the current machine sizes
>   percentage values can be very high (1% of a 256GB main memory is already
>   2.5GB). This change uses part of 1000 instead of percentages for the
>   internal calculations.
> 
> 3) Introduce two new sysfs knobs: min_bytes and max_bytes.
> 
>   Currently all calculations are based on ratio, but for a user it often
>   more convenient to specify a limit in bytes. The new knobs will not
>   store bytes values, instead they will translate the byte value to a
>   corresponding ratio. As the internal values are now part of 1000, the
>   ratio is closer to the specified value. However the value should be more
>   seen as an approximation as it can fluctuate over time.

Anyone have any concerns or input on this series? Would be nice to get
it moving forward, as we do have a need for it at Meta. Outside of that,
would be applicable for end-user use cases as well on the distro side.

-- 
Jens Axboe
