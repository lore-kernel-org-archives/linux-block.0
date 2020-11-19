Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0380C56201
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430FC24695
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 17:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUV5G90m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgKSRRv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 12:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgKSRRv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 12:17:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A3FC0613CF;
        Thu, 19 Nov 2020 09:17:50 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so7240172wrc.8;
        Thu, 19 Nov 2020 09:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AyiTrcyJm4Zi90FzgQEOotlLIRlz5XcC+YAbqlzEl/w=;
        b=RUV5G90mlsRgstfCBIItHAX8vPujzP1AaEyoTbS3zRCO2I3zEGPFh1/KaEHPQGLnBu
         2ELRULTBJVDoIvzpoJTGtR7LLONKu35u+LBWq3svQRAOhEnr3shSys9TXwqEjz22kzjg
         zuxdLTEFqeM1dlNRSNMBmobkW2BsoOvC9OrwUCuUfbqWgK2Wi7y9CbZ09BmnrOa2mBRh
         MruSvWFbGiqNItHNdt5PGkJarljXuK1r9OHQsovYQDq/tCk/cC7++fFAOoowaBmrCbhi
         Hpb1/rpGigoLocJ1sJhPPK+oFSyHWjTpRBWj6N8fJahPD/EBpQ1+CM2v4pJr0kh3wfJx
         Z78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AyiTrcyJm4Zi90FzgQEOotlLIRlz5XcC+YAbqlzEl/w=;
        b=SqbnGy0ul+jxFNyzmXPHbtmrV3XlDLujhXD2IWPZR/hBfPaT1ydQRsNYYKbuZOfzUC
         jVYkiuY519uvUWsG8VAIAouY68MK4fCFaH6i7xVrGGBXFQz5yla8ptFbHBZRecmBKkiG
         TMEtM4UXpPOz8ucX6QqnquXJ4FYWgVyrFfEsqRImvVmkuZdGbzOCWSteEpl8YupVkPV6
         oeEKb9Z3VKNyz56TzmkCg77Yh6UDrfQDOe7V0yYylAQNGB6MBPiv0UF4johbfoJsWY55
         xf3jSKJ5YFls63Yx+qGoh53bWS8m/989G+cCaKXvlGniCpAuRTLGKSTRpO+o4cTlV6rj
         czJA==
X-Gm-Message-State: AOAM5324gy6QbqzdYPNPrK3omH7VIkySHU1aI7ukhCm/x61C7fZL8c8D
        641yGW06VUjJDKRi2gMO7UQHr+pdgaHJBg==
X-Google-Smtp-Source: ABdhPJysLrAriSZOCdUdoziXnpetbfxIBxfEPi+pV6Vn1w6yccukiXKFU+0zLz8hifKIqRoqrHSczA==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr11919882wrv.95.1605806269150;
        Thu, 19 Nov 2020 09:17:49 -0800 (PST)
Received: from [192.168.1.23] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id a15sm658363wrn.75.2020.11.19.09.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:17:48 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
 <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
Date:   Thu, 19 Nov 2020 17:14:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/11/2020 16:46, Jens Axboe wrote:
> On 11/19/20 8:29 AM, Pavel Begunkov wrote:
>> The first patch optimises iov_iter_npages() for the bvec case, and the
>> second helps code generation to kill unreachable code.
>>
>> Pavel Begunkov (2):
>>   iov_iter: optimise iov_iter_npages for bvec
>>   iov_iter: optimise iter type checking
>>
>>  include/linux/uio.h | 10 +++++-----
>>  lib/iov_iter.c      | 10 +++++-----
>>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> Nice! Tested this and confirmed both the better code generation,
> and reduction in overhead in iov_iter_npages().

Thanks! Did you find t-put/etc. boost with your setup?

> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Pavel Begunkov
