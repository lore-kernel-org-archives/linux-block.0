Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7CFC433EF
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 12:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiEUMVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiEUMVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 08:21:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4A1FA5C
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:21:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id v10so9825845pgl.11
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gfHmtlCQtYvyaOp3BTWx/NwfcevCZ/dQvENt+OCB6OU=;
        b=i1Z7sKvKg/r7Fu90Re3JGKGo4OH8g8Rh6cF/OLtxysHA/ntRqQvqKVSVq2oF1hT6L4
         cNnY4wBcAg9kqs771D/Xc0PAxFm6ZZUDIHEvQjJlLqiY3ZTF1MkvntDJylyJoP3yjEBy
         aEgkl0OIh0MepffoSk4c1rEgxTlrxXHO0w8y7AoWrX0RPPOstSM83S7ponJCoxe2/3Fk
         cwTavtZmoY0/bOt2sJHHNhlb66apetZalZEVahMDSTFRMRHJpK3IFC3Iowh6/6VEjb2O
         U9kKXX8EL0eVtbcvNrYJg2Z3WKlp5dK6tZVXG5aOLhqu829Yw3YQXHKun68AuCwVTcgC
         vCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gfHmtlCQtYvyaOp3BTWx/NwfcevCZ/dQvENt+OCB6OU=;
        b=E8w3IKiuMGQHkAPbqGBrb09qA18P5rqyAB4iOkVBx9LbzxCCSh4VBMFuHNI0uV1crK
         Ntgmg/tp5pRfScLKKfq2kpuqL9NUBRBvpwdpkxkMC00p9wmKivmix8/bUOM4B258QSeY
         jBJJQvCu1SuXgbfVGyxBsUUZ6OUqdeOC9+85wmExPkrTHk31uRa7p0+SsyAISieJSQsU
         fKyoETSQddhzrtwFrJW34FwW90zRB7nwnBiwc6wbJEM/cc+LRKYVnafe5EYamkoTQMay
         AkY/yjlC53+9NVNHeB1GWwA3nd/7kzRvKgJOnwcG8iCryHA4B6UQNa96rZ5Fyoill7sU
         QoVA==
X-Gm-Message-State: AOAM530ecnFvk6N1J0WWqsQEUpj59TYBVYapFF7di8gCXiT56bLJMDIE
        aYUtxCp+yffkQ3/yPDwd+tuDZQ==
X-Google-Smtp-Source: ABdhPJw+5j9W+uGqvyx64pvj2Pi9VtZZrzR4LWDDdBMSzozlbeja1Pr6gXBE/S71yWDyxP7HGY8Qjg==
X-Received: by 2002:a63:3c05:0:b0:3f2:6ea8:aff2 with SMTP id j5-20020a633c05000000b003f26ea8aff2mr12765049pga.340.1653135689908;
        Sat, 21 May 2022 05:21:29 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t71-20020a63784a000000b003db610ebdd0sm1403982pgc.65.2022.05.21.05.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 May 2022 05:21:29 -0700 (PDT)
Message-ID: <d5a90a08-1ac6-587a-e900-0436bd45543a@kernel.dk>
Date:   Sat, 21 May 2022 06:21:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next v5 0/3] support concurrent sync io for bfq on a
 specail occasion
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, paolo.valente@linaro.org
Cc:     jack@suse.cz, tj@kernel.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220428120837.3737765-1-yukuai3@huawei.com>
 <d50df657-d859-79cf-c292-412eaa383d2c@huawei.com>
 <61b67d5e-829c-8130-7bda-81615d654829@huawei.com>
 <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <81411289-e13c-20f5-df63-c059babca57a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/21/22 1:22 AM, yukuai (C) wrote:
> 在 2022/05/14 17:29, yukuai (C) 写道:
>> 在 2022/05/05 9:00, yukuai (C) 写道:
>>> Hi, Paolo
>>>
>>> Can you take a look at this patchset? It has been quite a long time
>>> since we spotted this problem...
>>>
>>
>> friendly ping ...
> friendly ping ...

I can't speak for Paolo, but I've mentioned before that the majority
of your messages end up in my spam. That's still the case, in fact
I just marked maybe 10 of them as not spam.

You really need to get this issued sorted out, or you will continue
to have patches ignore because folks may simply not see them.

-- 
Jens Axboe

