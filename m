Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A0C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 20:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJDUWa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 16:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJDUW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 16:22:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137E5A3C9
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 13:22:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o13so2719927ilc.7
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TelNLcm9wRWpRvZM6ui9GLROotn2S175JYIk0nIBYMU=;
        b=STF3cKzsEkNyiAc2Pp9U+acmfSoO9o9FviqJOu5GTx9ayQmChbBcWmh+30RVpI7ku1
         3TL9xHH/yeYsbts5GKYStMrmZKBWoSqUJcVo11VwATX5RUVZC8A84OMxJDVx14e+TRyI
         Nc+HPgOgpPIBtZ4N/ayYZN5MY7PKYBMkYHaKG8si2vVDgHorKdMRnlRkTc5LJuSWNLfA
         ReTIaqinJjqbLriC4pJucVuZlJspXBnej4Kw62tHQBPCt8yHRBKVJ2fJ+gnTO01TNopW
         IcSDYEs8muyxhocv8GCeFfIU+TsX6iI9/F+ON1DBd60ziUqQ2AcEFN1X6qCb6CqkKSym
         QqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TelNLcm9wRWpRvZM6ui9GLROotn2S175JYIk0nIBYMU=;
        b=qdzjAm7K3pLBTqKazYSaN0klCEodaDti6bVbijvmx55WkGNyE4BWxBUAJau6x/DXE4
         VWkOdEAMrFP6aMbJFaJ7XqD6l3k6WUzSVOS5KYhGbhrj5hDpBRNepfWLAbwbpVsKeNxq
         w0+qqS7KuT06xgQbhcT68HCoNLYmCQkeKmVALBGofECP5jJV4TzdkMOzqVFKOno4fFm2
         zU+uYLsGywagNHcohIKI59/+zkW0eDzkxzsihjxBZ0gRm18l4s+kbjZY/93XPs1D/L2O
         sc27JfBNnq7DIYGMj6As8qk1qzMblyapPxDQdD+JUVakoUwEPYTHdh7052lto2Mpgkeg
         wYYQ==
X-Gm-Message-State: ACrzQf1i6UVCcDQuMQ0KyiknDA8619cyN5JB2Viy3tNJ+9x5hj6ca2oZ
        r5p+m3c8fgJst3HdEIvtlhlMNgkfnsrExw==
X-Google-Smtp-Source: AMsMyM7nWfSuZ2bMHjHDOTAjPo4J9MaV6oNis+zZcdekiEkjOufbVl2foV4BfKsvvXRRUaad2rpNmg==
X-Received: by 2002:a05:6e02:194e:b0:2f8:fa94:9da1 with SMTP id x14-20020a056e02194e00b002f8fa949da1mr12747955ilu.102.1664914943271;
        Tue, 04 Oct 2022 13:22:23 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x2-20020a026f02000000b003583ae37f40sm5508319jab.153.2022.10.04.13.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:22:22 -0700 (PDT)
Message-ID: <736d9e73-8f19-cc21-375e-140e4ab61383@kernel.dk>
Date:   Tue, 4 Oct 2022 14:22:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] block: allow specifying default iosched in config
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     linux-block@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-kernel@vger.kernel.org
References: <20220926220134.2633692-1-khazhy@google.com>
 <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
In-Reply-To: <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/4/22 10:42 AM, Jens Axboe wrote:
> On Mon, 26 Sep 2022 15:01:34 -0700, Khazhismel Kumykov wrote:
>> Setting IO scheduler at device init time in kernel is useful, and moving
>> this option into kernel config makes it possible to build different
>> kernels with different default schedulers from the same tree.
>>
>> Order deadline->none->rest to retain current behavior of using "none" by
>> default if mq-deadline is not enabled.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: allow specifying default iosched in config
>       commit: ad9d3da2d07e0b2966e3ced843a0e2229410e26a

I'm going to drop this one for now since we still have
active discussion on it and it's very late (actually too late)
to be debating 6.1.

-- 
Jens Axboe


