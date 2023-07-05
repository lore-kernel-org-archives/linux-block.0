Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C0C0015E
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 22:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjGEWek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 18:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjGEWej (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 18:34:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13091732
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 15:34:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b87b9a8652so5995965ad.1
        for <linux-block@vger.kernel.org>; Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688596477; x=1691188477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yt7JosgSlDOLdt381GrLKtbGFlVzuv402zTByk7ztZs=;
        b=jbJyyj8IBYZO7h3KvD0MhrNfbYD1C6o2m8AS1iFhgMoYGpeE2CO8W6io9p6KMR/qI4
         jMzztjmdjaLxe54P2qH2Z+wsjUj4LMxJ89nuICUN1Cx7HEns03CL1cta4BeTqispW4Aj
         ZZS6t4M7l7BMD0BeFD98s5DE4K+SGppyUiJoBWyBYNyR54VoTMqQnyieQcogxVmrX3Mz
         86U432KDQqV1KGBcddJCAe2XYl9BtYDC3Rj8LwUA1IlF8h3rHo/lz+Q0AO1aqzbOEQtu
         Ra1I2wCGFSSes4VFr8g3hW/McfUO9OHFbZ3Fx7YG6rhAVTkJcMr1jLqnuFM2NBV5upNi
         r57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596477; x=1691188477;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yt7JosgSlDOLdt381GrLKtbGFlVzuv402zTByk7ztZs=;
        b=gjJfENpCm5tN/SDh3/y5wiY4Xr5ePEwcHEWm0cPLVGhFA2DnD/RWUVpBcobDo6e+Gq
         EOKDmlLyceFzHIbxbsvO6oZ1Gmo2gh7FgbvEsip/6WLVNpjPFT2U+ACO/pc5NDi9wGdK
         qNvdYvifbFLFfYmd4bX6vdY9JvsTVAHMuxQk1TCbr2rocZUtAnUHE/l1A392N8Rik3wr
         79X5dCjWQI8le0QfiM05b6nnsBIk4BoM96QPgfYcyJklnYdc1jibO5vhmyzG4tyRRYVV
         aAih/bdJ+KDeu1XBhFknVwlJKtqJyAscLCZmCcTEIqrKqFE6L4o1F2zbJ+PQ+qAAxIPd
         e0yQ==
X-Gm-Message-State: ABy/qLbYjMMTUStUYRGMcu5nB+eFfVJ1lJeOW/QAey86ScmLXkddB+JS
        1LTrY0Crlv+zhi0lV951HWb3Pw==
X-Google-Smtp-Source: APBJJlGpGzW3tWovGol5Vro55MJvY9GwPUaUGLe22952trfqqf3F6PxvpcqG8ucWsbmeeKwXhb/MQg==
X-Received: by 2002:a17:902:da83:b0:1b8:811:b079 with SMTP id j3-20020a170902da8300b001b80811b079mr444796plx.0.1688596477249;
        Wed, 05 Jul 2023 15:34:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c10c00b001b694140d96sm10514761pli.170.2023.07.05.15.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 15:34:36 -0700 (PDT)
Message-ID: <481c0e2a-320c-e53d-2a0e-ba5fa6ea4049@kernel.dk>
Date:   Wed, 5 Jul 2023 16:34:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/1] block: bugfix for Amiga partition overflow check
 patch
Content-Language: en-US
To:     Michael Schmitz <schmitzmic@gmail.com>, linux-block@vger.kernel.org
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <20230620201725.7020-1-schmitzmic@gmail.com>
 <20230704233808.25166-1-schmitzmic@gmail.com>
 <20230704233808.25166-2-schmitzmic@gmail.com>
 <a84267a2-e353-4401-87d0-e9fdcf4c81a0@kernel.dk>
 <6411e623-8928-3b83-4482-6c1d1b5b2407@gmail.com>
 <f61ba21f-a8a0-756c-2a41-b831a0302395@kernel.dk>
 <01cf1491-a9b3-2342-3fd6-f4cae212bc43@gmail.com>
 <49192b95-8fc8-7dcd-f062-a4876731e347@kernel.dk>
 <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1bed3177-4d1f-ae04-7ae2-353afb314cbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/5/23 4:25?PM, Michael Schmitz wrote:
> Hi Jens,
> 
> On 6/07/23 10:13, Jens Axboe wrote:
>>>> should be enough for it to go into stable from 5.2 and onwards.
>>> OK - I wasn't certain whether you wanted the Fixes or stable tag dropped.
>>>>> (Greg didn't seem to object to the Fixes: as such, just to the
>>>>> incorrect version prereq)
>>>> I think it's really confusing... A patch should only have a Fixes tag if
>>>> it's fixing a specific bug in that patch. Either it is, in which case
>>>> you would not need Cc stable at all since it's only in 6.5-rc, or it
>>> It is fixing a bug in b6f3f28f60. I should have checked whether the
>>> patch series had already gone to release, not just -rc, instead of
>>> just adding the stable tag out of caution.
>> But this is the confusion - if it's fixing a bug in b6f3f28f60, then why
>> is it marked as needing to get backported much further back, predating
>> that commit?
> 
> I see - it doesn't need to be backported that far back _alone_. It
> only needs to be applied after  b6f3f28f60 once that one has been
> backported.

OK I see - I think there's some serious misunderstandings here then :-)

It sounds like it fixes a bug in b6f3f28f60 alone, and it has no
business going into stable. The commit should _just_ be marked with it
fixing that. If someone were to backport that previous series, then
their tooling or diligence should notice this dependency and this
current commit should be picked as well.

There should be no Cc: stable on this patch at all, I'll fix it up.

-- 
Jens Axboe

