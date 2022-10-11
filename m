Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43944C433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJKQ0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 12:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiJKQ0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 12:26:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E159B864
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 09:26:07 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id 137so7025589iou.9
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcuXX3q54AIQQlX1+hQrsBzqHD7HfWkF6TuzwcEC6yc=;
        b=yKWNjStLhM+J8LWSuTFi0G+YgK5GH1jgvNcS5zMhandAOdcWvvP7UfBaO6WVPFtHzK
         /ypSm6T44wYn0/uteX6Bwg8JVH3etMj2AzSO5l2CmV3Tu28ytMKNfHTwPbqh5iVlEyef
         cI0S9DF8xyc8a/SPiQCF8TrynoEfzZZRx3eYvPoF1CPe9jhL0RYizx75w6IXPe8itZOM
         TQiQB8naYiQS6CAPLnLoHLgrtIeRQ91pq8v5xB3XGeNYITARVXGr6UlQhYDibO7Qk9Yt
         x3KuYQ7efRv5MR/wX5KTk+EUflkQfB8ZmqK1SaXPP7v7pPbatMyplkhLBDOIGaje1+AL
         N2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcuXX3q54AIQQlX1+hQrsBzqHD7HfWkF6TuzwcEC6yc=;
        b=LLpbY5ZQG9lIoZ3grMeq7n7BY5jBUiP5G1WHDw7Bel66/N2ggtvp9SqNVg9gvSEibX
         xEC1Tv7fLWYAlZWsrTNcafkM+4+Aaxm8kHIvR0M6PEHzA07AP0q96UtTX23pzOX7cfmn
         9cl1+Kn+JRztI4J1Z2mhZSO+oZ1AUk9kr4cge/qgMngdgmKTHqtFKK+niTfoJb0Z611n
         tlBXuiZnQVOeAb0o3Wc0XQU9S8LcsWRHCdscgqvme/LNHCleqRo7SB/bcmvu4xYqoB2W
         zLvI9Tiw+JHDdbMYRcNUWcJodsi6uiX01E4aduU1HTn2R3xCrnQ5oM3AkpI4ga86fCWO
         Q+JQ==
X-Gm-Message-State: ACrzQf2Nzl8ocLYAuFtpQBXlOYxtwAtZFATzUrVfiFyi6X4w2CKhMA0N
        Jwy7BtIgyRcIImXINgRgx4wSwQ==
X-Google-Smtp-Source: AMsMyM7sNHjwSDvWOU6zdxTPQoesPx6zJH1N9XQoI1cI1aUpuo7/2H2TzJx3FWWqSIx+kLUnqpAOSA==
X-Received: by 2002:a05:6638:3044:b0:35b:ac10:53be with SMTP id u4-20020a056638304400b0035bac1053bemr12879227jak.17.1665505566388;
        Tue, 11 Oct 2022 09:26:06 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c3-20020a0290c3000000b00363b8ef4bc5sm2375329jag.71.2022.10.11.09.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:26:05 -0700 (PDT)
Message-ID: <eb59cf48-03c8-7ce9-7e00-4b824cef150d@kernel.dk>
Date:   Tue, 11 Oct 2022 10:26:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block, bfq: remove unused variable for bfq_queue
Content-Language: en-US
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/10/22 7:29 AM, Yuwei Guan wrote:
> it defined in d0edc24, but there's nowhere to use it,
> so remove it.

A few things wrong with this patch:

1) It's whitespace damaged, and hence will not apply directly.
2) It should have a fixes tag, and the sha used should be 12
    chars. 8 is too short.

Can you resend it?

> Disclaimer?The information transmitted is intended only for the person
> or entity to which it is addressed and may contain confidential and/or
> privileged material. Any review, retransmission, dissemination or
> other use of, or taking of any action in reliance upon, this
> information by persons or entities other than the intended recipient
> is prohibited. If you received this in error , please contact the
> sender and delete the material from any computer .

And please get rid of this, it's just spam and doesn't apply on a public
mailing list.

-- 
Jens Axboe
