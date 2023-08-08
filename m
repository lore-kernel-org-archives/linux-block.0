Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D1C001DB
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 22:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjHHWHd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 18:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHHWHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 18:07:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C57E51
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 15:07:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6878db91494so1094959b3a.0
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691532452; x=1692137252;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdoK3lz2v7joaiVM4Dv26kN02gWbDjAywas/BLFU0po=;
        b=sFDwinSMAd4xZuJtlpQK8cBqRf5iuyLXPxwqcYDXnpV2047QtaeDeo1eGdobX1u6Jf
         0hkChx2+gtVtrG3MVtlF3AfOgWWw+Lk3v2+i8ychr6/42n4oPeIcwI5L/7gD1IRVddOa
         r2CqxRJC0wJDsARmD/a33u3nNPCsj7KS87LCYtbJ4z4oPFvpvmwiKLQNdv0M/cBrOosW
         93deveyFU7oRnL0R2gvcm3dc1zx94mbi2pomJWjQLb/lUtNo1Wb2u2UQ9nmQQgRcP/jS
         sr4J5CP3GTtOIWCvxy+hMYL5ZZj5Nu311VVDvUVzS37O1ZfAPjmXnmiBiQNhXtQ9f+WB
         dHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691532452; x=1692137252;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdoK3lz2v7joaiVM4Dv26kN02gWbDjAywas/BLFU0po=;
        b=LAjHO0nfgtwEaujDzfa8nj85fcoYkm0SN6d7hthc18OR9R7AQ/JtOOM5SdK5n+bo64
         ZcBEfkeKMVi6rvoxQIx7VwQATvVL+qjkluV96UkJZAZg4wi/ASN2AS4mUl9J22+vp8JE
         dme03beKl4utucuaDEpAoj7IHmpgDdNxivhI+J/dEZHRrV3V5eMJb4+NSLuqZXESbqgB
         mQDtjlKdMh/zG2INOAOZglZKGJQv9AWMP84tvnsNWSaC391KcKdB5vDXgHn058lCyP+y
         HSeioN2fv5HFpnUivwOiNPbczi7cxHXmJINMhJcfM6iyqf3+JF9lKhYDjQjNRKRMK2S3
         +6iQ==
X-Gm-Message-State: AOJu0YyFDwUxT86Wf4jYsmTsl0ArhUf3jfybet8WDIltQrIQ2Yoo90pr
        XP9NN7JmejrxpaA+jFzdvz1u+A==
X-Google-Smtp-Source: AGHT+IEMzBtC+4YKTpv85q37xbKiOELDlnBApZzEEFMbI2XoVdD3wUG7nmLnRd3+cNgKZQ77SZbcgA==
X-Received: by 2002:a05:6a00:1948:b0:687:874c:7ce0 with SMTP id s8-20020a056a00194800b00687874c7ce0mr844681pfk.1.1691532451740;
        Tue, 08 Aug 2023 15:07:31 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b006871bea2eeesm8586916pfa.34.2023.08.08.15.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 15:07:31 -0700 (PDT)
Message-ID: <a41bb3a8-26f8-0f7a-d4ec-23df60358b00@kernel.dk>
Date:   Tue, 8 Aug 2023 16:07:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/2] block: don't make REQ_POLLED imply REQ_NOWAIT
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org
References: <20230808171310.112878-1-axboe@kernel.dk>
 <20230808171310.112878-3-axboe@kernel.dk>
 <6184fb8b-288d-e21d-2a01-dd2a3fef3104@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6184fb8b-288d-e21d-2a01-dd2a3fef3104@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 3:58?PM, Bart Van Assche wrote:
> On 8/8/23 10:13, Jens Axboe wrote:
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index c4f5b5228105..11984ed29cb8 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -791,7 +791,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
>>   static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
>>   {
>>       bio->bi_opf |= REQ_POLLED;
>> -    if (!is_sync_kiocb(kiocb))
>> +    if (kiocb->ki_flags & IOCB_NOWAIT)
>>           bio->bi_opf |= REQ_NOWAIT;
>>   }
> 
> The implementation of bio_set_polled() is short and that function has
> only one caller. Has it been considered to inline that function into
> its caller?

I think it should probably just go away, but wanted to leave that for a
non-functional cleanup (which can wait for 6.6).

-- 
Jens Axboe

