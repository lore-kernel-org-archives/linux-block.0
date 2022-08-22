Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85851C28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 20:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiHVUju (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 16:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiHVUju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 16:39:50 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66A1CFD5;
        Mon, 22 Aug 2022 13:39:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 67so3288540pfv.2;
        Mon, 22 Aug 2022 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rpRXm32JMSjeboYdITDaHmCAgmE5CbbiM22eZOi9Edg=;
        b=ZkpuO5y5hcDfnmgonTjQ/FVdH4Y46UiSHCK1DxYrxnp0jiL4ITMYphAT1AwUQMotxP
         dfCexCquIcuiVwvBMtVDli/3jY6mHM+azfv0xF7KmqBW4WuOposxjWC8+xDT4/SHBRls
         qagHwQ3LYJ/zQ5FHogOqFvh7HsaT95zFyQDjGnu8+ubr/L5g2UYb4soLY8lIAIGERtN/
         WLvs/ix0/DXibv0QWUdmFzpWlIUbal87ByInWQHcZZzn+W1AD6o76hIx/Tf3wci0UrYt
         0M3FpM2ljrqVSbcuG5fIqRTy+SozJpgl5e6GjJK4j7mGqPf8+nAC/2IxdEip+irocb/m
         OMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rpRXm32JMSjeboYdITDaHmCAgmE5CbbiM22eZOi9Edg=;
        b=vqO4imLr87moUesCZMJLj5PHfKsxnRB5l4DU/MJrl3o+vSMXg8MCLzxQJSQmHrhQjJ
         Ci4K5WMWGuU1SIv1AQZ31xgKtLgoDNKGoYOkPn7ZraPAmERUGuinNjwiZze0mMnKrs6I
         wpU/eYnXi09At8V8yEIy/InP4Kwm4ben40fpzeShOfayxkdFWXSdUY3em+WcrxK2lq/Y
         2Czd4I+WYeyITd6hJoIfFEg8xBgYH1VFXh5x1WTWP2ioH6dGQxTeSQnZPse7/uHHQmpS
         0u88jEWUp+4I/OIR2M7ORPAHRNmPH5ZbXCfD7VLVEU1Qf9xmEHYWBfFG7Kd77WmiD3m1
         jPnQ==
X-Gm-Message-State: ACgBeo19frz+dMwIvXIU8U2ZTC4w5AIEtuGZUtzQy/M2R0r7BQD1JVTT
        ZkB1J6e7zIHaaeKU12lckKjPpEu23gE=
X-Google-Smtp-Source: AA6agR5XVcsftWtELZW65yLYrYojUGXbBPVl+FYCKfpd19XNJKlpI8mrQQH6DUBxaR5blGHagmA+Mg==
X-Received: by 2002:a63:fb4a:0:b0:429:8605:6ebf with SMTP id w10-20020a63fb4a000000b0042986056ebfmr18104600pgj.225.1661200788952;
        Mon, 22 Aug 2022 13:39:48 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:642a:8878:46a3:c3df? ([2001:df0:0:200c:642a:8878:46a3:c3df])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79ae5000000b0052db82ad8b2sm7813533pfp.123.2022.08.22.13.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:39:48 -0700 (PDT)
Message-ID: <3aca03ae-f01f-962d-b552-d6efd1cd47df@gmail.com>
Date:   Tue, 23 Aug 2022 08:39:43 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
 <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
 <2669426.mvXUDI8C0e@lichtvoll.de>
 <6fa2c159-e7c7-2d2c-04b5-54c2b2c9a24e@gmail.com>
 <023b3e08-8782-cde9-4eda-ea419d461bf4@kernel.dk>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <023b3e08-8782-cde9-4eda-ea419d461bf4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

will do - just waiting to hear back what needs to be done regarding 
backporting issues raised by Geert.

Cheers,

     Michael

On 23/08/22 01:57, Jens Axboe wrote:
> On 8/21/22 5:46 AM, Michael Schmitz wrote:
>> Martin,
>>
>> Am 22.08.2022 um 08:59 schrieb Martin Steigerwald:
>>> Michael Schmitz - 26.07.22, 05:58:40 CEST:
>>>> Am 26.07.2022 um 15:40 schrieb Jens Axboe:
>>>>> On 7/25/22 7:53 PM, Michael Schmitz wrote:
>>>>>> Hi Jens,
>>>>>>
>>>>>> there's been quite a bit of review on this patch series back in the
>>>>>> day (most of that would have been on linux-m68k IIRC; see Geert's
>>>>>> Reviewed-By tag), and I addressed the issues raised but as you say,
>>>>>> it did never get merged.
>>>>>>
>>>>>> I've found a copy of the linux-block repo that has these patches,
>>>>>> will see if I can get them updated to apply to current
>>>>>> linux-block.>
>>>>> Thanks, please do resend them and we can get them applied.
>>>> Will do - running final compile tests.
>>> Just reminding. Did this go in meanwhile?
>> Not yet, at last count.
>>
>> Christoph had reviewed v8 and I've addressed his comments in v9.
>> Should have added his Reviewed-by tag for both patches perhaps, not
>> just patch 1.
>>
>> Shall I resend v9 with that omission rectified, Jens?
> Yes please, thanks.
>
