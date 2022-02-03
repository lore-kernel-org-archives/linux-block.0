Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F8C433EF
	for <linux-block@archiver.kernel.org>; Thu,  3 Feb 2022 03:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbiBCDS4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiBCDS4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Feb 2022 22:18:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA7C061714
        for <linux-block@vger.kernel.org>; Wed,  2 Feb 2022 19:18:55 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y17so1017379plg.7
        for <linux-block@vger.kernel.org>; Wed, 02 Feb 2022 19:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3MFICOy4pmqc1cBBH1XzKXE+gaG/J7AVvBM6X1IgygQ=;
        b=lHNRldIurTc65hBG7FEchbBdtgdnS+fd5BPfPiAS+oH5IKwFwbmqJZuxUcs0ORqhIl
         3a1RjAFk19Yl9arxUoBWMsgUwZHxV/ARdUxzbFGP+xFJn55dv6wyunYKxQWsVJeN2orE
         sI1EXZmBkMc6cjeBspH9qoCskDKvtuCkrI72/75KUi1UXXl6nX+rOj87uUBm85bNPlhq
         iiP0g3ZxShnjKUwscBcsWn0freh0ZgDoEBt8p830ebWnB4Ut5UhiZ5iUuMOCgDjKVPOR
         ypuxnrHCRTsKoYLj2B667jMa6Hf36+95g0hLBmSpNAUf4CA1o5KbtB1WBmjKS0XOdblN
         bkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3MFICOy4pmqc1cBBH1XzKXE+gaG/J7AVvBM6X1IgygQ=;
        b=SMc0ii91iPFlgb/XgkVuNiETKdDWiq00uHS8qBrJz0xDkaKwW42JHYfE5D2iLlFF8V
         /dOjo9Uu7hWMpaAUcVSixSYBh74cS0gPJgYZIfN0xaKL7rCSENSe9tlKec/LW4t1Xjhs
         708Cbza10GNHHf7leghEyMbHB85FtwSzCU3HKJULE1mz2UxF9/rLsJRTMEfqMFXr9haz
         zPw7ZMXn8SVme79TEdXnrysAJT5PBf/BpINkxulzNegstDWICqmnK5xJ7g2K897z6Sq2
         PyDwPqqmPIoUZlUcwoxP2OgnpsQssdqhQecO0QmZ42qlYjX8FupR6484pnEEB3B1pPFR
         DD4w==
X-Gm-Message-State: AOAM531JlsLaAsMPVxW+t11H0g+1uAW1dcPLLQYNb5u6KNzrvtNGOckS
        E9iTd9ODwoE0h58M8TVR83o=
X-Google-Smtp-Source: ABdhPJziSnN40dTUgmbk/y89s2jqE3HNSkYtJptS/CoUl+3bpWHwyut5o7RRL44hnok4zu9iOffs1Q==
X-Received: by 2002:a17:90a:c682:: with SMTP id n2mr11694450pjt.177.1643858335485;
        Wed, 02 Feb 2022 19:18:55 -0800 (PST)
Received: from [127.0.0.1] ([204.124.180.149])
        by smtp.gmail.com with ESMTPSA id s10sm14699622pfu.186.2022.02.02.19.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 19:18:55 -0800 (PST)
Message-ID: <48ceed79-47fb-ffc1-3f3e-ac40bfc16cfa@gmail.com>
Date:   Thu, 3 Feb 2022 11:18:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH] block/bfq_wf2q: correct weight to ioprio
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
References: <20220107065859.25689-1-gaoyahu19@gmail.com>
 <27914345-9CBD-4F3C-AB55-243208521B35@linaro.org>
From:   Yahu Gao <gaoyahu19@gmail.com>
In-Reply-To: <27914345-9CBD-4F3C-AB55-243208521B35@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2022/1/19 10:56 下午, Paolo Valente wrote:
>
>> Il giorno 7 gen 2022, alle ore 07:58, gaoyahu19@gmail.com ha scritto:
>>
>> From: Yahu Gao <gaoyahu19@gmail.com>
>>
>> The return value is ioprio * BFQ_WEIGHT_CONVERSION_COEFF or 0.
>> What we want is ioprio or 0.
>> Correct this by changing the calculation.
>>
>> Signed-off-by: Yahu Gao <gaoyahu19@gmail.com>
>>
> Thanks for spotting this error!
>
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
friendly ping...
>> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
>> index b74cc0da118e..709b901de3ca 100644
>> --- a/block/bfq-wf2q.c
>> +++ b/block/bfq-wf2q.c
>> @@ -519,7 +519,7 @@ unsigned short bfq_ioprio_to_weight(int ioprio)
>> static unsigned short bfq_weight_to_ioprio(int weight)
>> {
>> 	return max_t(int, 0,
>> -		     IOPRIO_NR_LEVELS * BFQ_WEIGHT_CONVERSION_COEFF - weight);
>> +		     IOPRIO_NR_LEVELS - weight / BFQ_WEIGHT_CONVERSION_COEFF);
>> }
>>
>> static void bfq_get_entity(struct bfq_entity *entity)
>> -- 
>> 2.15.0
>>
