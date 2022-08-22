Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E4EC32774
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 13:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiHVN5G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 09:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbiHVN5E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 09:57:04 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE339B91
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 06:57:03 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n202so2820764iod.6
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ib/uMymF5+XNmj9CnV9csDPHB6vvJCiiK11Zzs0//Jo=;
        b=EDuQ4buGleTcKfvCw23coExOvCbUAzI8sUpMSc4dQ611CttUzIghSxMgt73tGKhS8D
         6pvoGLZmgOPxftVCyWqsCgyG3O4mnwSiM5U0KN56tQuPWD+VjtCwlJTUVxhJm2C+AF9N
         66HmhomZXPeJQPwRyvekEEf2WVaRct9lHVYdjjsReInfbrBgqdPCmaV8JvufpFzrzoi1
         iCSU1a3bzQzTN65fdZPL/yBNLpjAGZ5AtEMJp7LIFo4hkBaKVkLxj+Anf3aiPgzcRyG+
         vxKb2KRVqDnLAGhzxaoBViA6uiPS4h1z2UG3i5OIBoeFS7JETiC8+E3lQzmfqFrCQg6/
         EjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ib/uMymF5+XNmj9CnV9csDPHB6vvJCiiK11Zzs0//Jo=;
        b=NZWPjSyOMRzlS+Oy8xCDQX5ezPgi1xxxO5aUV+y0IEX7roMI6JygbWEkxnMR/6aXE8
         MYVVeRknXDsR9HIbzNt3viOmhbi3S8hY3wP3Au6BZr83mIqNwBaWRfA1zyG28qRwP7la
         DH+I6cYm8y0rnVX1EDqZHQSUdtps8csWHm21ny6uk/nCuXnHyHNrS88BKkk0XhAtZIIs
         /cjeiScksRzRjqGs88RVZHgWHwfmd5eI/iC88zKVo4rPb8OohA71KSYNIlMxHKrlKM2n
         c5ukBmD9/241vZLJK7RyfXc78Yd92UsYUsI7hi2zxO7mUr7pRVFamBPSpi7AXk+d4d9+
         8N9A==
X-Gm-Message-State: ACgBeo2DXXXuAjKrJzH0sFR+GOd2DGdd0YsIzlevGCHmZRRmmnBbmJ5z
        DLrZMKwKM9HDFJaWsf4iFsxDvH3bROV+0g==
X-Google-Smtp-Source: AA6agR4GjGKcDPdckeO5eL5nzbL557wMJa/3RRxLuXSRhxI4wUMIsTWmjqOnMzKW5fVgalt/4DO2ow==
X-Received: by 2002:a05:6638:440b:b0:344:c317:82e6 with SMTP id bp11-20020a056638440b00b00344c31782e6mr9258900jab.21.1661176622733;
        Mon, 22 Aug 2022 06:57:02 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z16-20020a05660217d000b0067c47eb46desm5931177iox.47.2022.08.22.06.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 06:57:02 -0700 (PDT)
Message-ID: <023b3e08-8782-cde9-4eda-ea419d461bf4@kernel.dk>
Date:   Mon, 22 Aug 2022 07:57:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
 <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
 <2669426.mvXUDI8C0e@lichtvoll.de>
 <6fa2c159-e7c7-2d2c-04b5-54c2b2c9a24e@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6fa2c159-e7c7-2d2c-04b5-54c2b2c9a24e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/22 5:46 AM, Michael Schmitz wrote:
> Martin,
> 
> Am 22.08.2022 um 08:59 schrieb Martin Steigerwald:
>> Michael Schmitz - 26.07.22, 05:58:40 CEST:
>>> Am 26.07.2022 um 15:40 schrieb Jens Axboe:
>>>> On 7/25/22 7:53 PM, Michael Schmitz wrote:
>>>>> Hi Jens,
>>>>>
>>>>> there's been quite a bit of review on this patch series back in the
>>>>> day (most of that would have been on linux-m68k IIRC; see Geert's
>>>>> Reviewed-By tag), and I addressed the issues raised but as you say,
>>>>> it did never get merged.
>>>>>
>>>>> I've found a copy of the linux-block repo that has these patches,
>>>>> will see if I can get them updated to apply to current
>>>>> linux-block.>
>>>> Thanks, please do resend them and we can get them applied.
>>>
>>> Will do - running final compile tests.
>>
>> Just reminding. Did this go in meanwhile?
> 
> Not yet, at last count.
> 
> Christoph had reviewed v8 and I've addressed his comments in v9.
> Should have added his Reviewed-by tag for both patches perhaps, not
> just patch 1.
> 
> Shall I resend v9 with that omission rectified, Jens?

Yes please, thanks.

-- 
Jens Axboe
