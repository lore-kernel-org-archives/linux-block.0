Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4EAC77B75
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 15:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbjELPZc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 11:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbjELPZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 11:25:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBD3AB1
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:25:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-760b6765f36so35761339f.0
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683905120; x=1686497120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NigXdKoC4rnIJbrfBOK60yvuOfKWjuB5CHbXl67Be6k=;
        b=HOExU0bmRukOSeFNKag5C4/WVJbPWjt9sWikwHmlKyC6mRP/d+BOuz7+ieZcUW5M4d
         Zo9Fxmg+tEMnDYFCqC1kOirFi/D+DJASsinchH4qGm//NJpmumqkY8+6+yxrLkwlBvZN
         A6NKd/r5Zj0sGGnuOKoEjCZkSMquA1UwVf8SbbI77nhm9inG6S0bTCwtQMQ003VPLmBh
         v4ipuMdh3ZO6X18Zrz1dn4Dwtzb1YO0HzzaokMOuiT6J50ORaCOmmLLzpmn/Yn2+VF7s
         UWyt9QWc5me830vbJJcuo7RjtF+gYutF1yru3UGK43L9QAHiLT+35uSNsMV/jRT60aIc
         wagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905120; x=1686497120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NigXdKoC4rnIJbrfBOK60yvuOfKWjuB5CHbXl67Be6k=;
        b=OQjRVkw2GIyUBT5eC7GPAVDljwNM1RB+WNpaEZwTO/LkUbgzm+98iGuIrX7oV7KHJR
         clLjqNg1M1JmyvGTdcAy+JkoO+htJD33mMg7faL/xGGLrUUei6UJ7VEcXWUrF0vMzjEI
         0TMJjnGLacwdr5HZTC4VLhMpUGZn8j8/13fink/eTDxmxoRzOioDFhnWNiZpKZI9jRGN
         7BbAB4rxJNJS1SaIrb8WaYPkfR0XAERS9yYKyFm+u0CsCJEtWslRCeCDo9tkA/i6+hhl
         niecFtzXbb+3iCeuUGTZzI4ihK1TivmccJqrgAIrtarnTcBE+uspQw77HMRvTGvbjEjw
         +bVg==
X-Gm-Message-State: AC+VfDx32nT0B+9kWar1hnYCMEPb7ehOiCWuk0zUkThZomGSsC06ybTj
        c60wm+0gdBVorXnrptcLgsMj/7EYWEP1n6+yvb0=
X-Google-Smtp-Source: ACHHUZ4egpN4aNq3XP/nvlTplmZ7+t3lwJI6S25aTA6icju+CtrM/UASBG65isa/7vlKXKQ2iQ3rnw==
X-Received: by 2002:a5e:a808:0:b0:76c:7342:dde6 with SMTP id c8-20020a5ea808000000b0076c7342dde6mr4325320ioa.0.1683905119683;
        Fri, 12 May 2023 08:25:19 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v4-20020a056638250400b0040f8b6933f0sm4741097jat.74.2023.05.12.08.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:25:19 -0700 (PDT)
Message-ID: <b745f17b-088c-a72c-00f2-3c0a13cdead5@kernel.dk>
Date:   Fri, 12 May 2023 09:25:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
 <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZF5ZB7QWPCF0ZKWN@ovpn-8-16.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 9:19 AM, Ming Lei wrote:
> On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
>> On 5/12/23 9:03?AM, Ming Lei wrote:
>>> Passthrough(pt) request shouldn't be queued to scheduler, especially some
>>> schedulers(such as bfq) supposes that req->bio is always available and
>>> blk-cgroup can be retrieved via bio.
>>>
>>> Sometimes pt request could be part of error handling, so it is better to always
>>> queue it into hctx->dispatch directly.
>>>
>>> Fix this issue by queuing pt request from plug list to hctx->dispatch
>>> directly.
>>
>> Why not just add the check to the BFQ insertion? That would be a lot
>> more trivial and would not be poluting the core with this stuff.
> 
> pt request is supposed to be issued to device directly, and we never
> queue it to scheduler before 1c2d2fff6dc0 ("block: wire-up support for
> passthrough plugging").
> 
> some pt request might be part of error handling, and adding it to
> scheduler could cause io hang.

I'm not suggesting adding it to the scheduler, just having the bypass
"add to dispatch" in a different spot.

Let me take a look at it... Do we have a reproducer for this issue?

-- 
Jens Axboe


