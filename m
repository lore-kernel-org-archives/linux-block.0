Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7646C54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 20:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjA0ULA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjA0UKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 15:10:46 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A892914C
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 12:10:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 5so6128540plo.3
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 12:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCpGCS/OXeh7kYIrLqMAqyzZU6U0iWsXPrIDck1yl4Q=;
        b=COEuRwnZJeTT8Co7vP68ncETJxbQLPH3GL04G1l4xtc63Ci7eG+N0f+/2YFHeMBD7x
         4eGGkPJ+XjN1GOtuK0cGDhBn+/PVNG9Y+tEuOjZSrgJNnMnpcfp5RoNSJAJkiBl28aaF
         lFFPh7iOrLVR+Fhpn0Maam7MFveM7j4k2BPH+QfcrWLWhtnL002SwNczYu26N4pNjBx9
         K30t9T2hSJ2k/sSlHZgz4qmJfX4W36AdPYARXp6KRm4JryEMJXwx1BlrF2f6kMNs+841
         sRs16HWRnMCHKY7XAUWOib0j+nlA+ujPX6XdCsgqNqo5rDXhQOKWoGrBrliXuHOvhLEg
         tkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCpGCS/OXeh7kYIrLqMAqyzZU6U0iWsXPrIDck1yl4Q=;
        b=VK3UlgwCrDA/UZ4/5G16334a1JVvu+7RdFE40Qb8tvyBFhq40I402wOQN9cor7PTFa
         Z1+88q65AMXs66A2C0a0EfQlCR5kztiUhoWBg2rXVDCqiaSxrIlBOfbLRN4Z2ylS/E8h
         9mumLBk1U8uFgh32eMtibM346Odz3JZnx77SehgJ0rHaoYHsqykDsxKnvJJu0nU6AdE4
         veeFUcuz21MwsWIqwLxnuV4EtVsJuzNiDAwmMeJlPVAojSb6p2Ztou/QPvIPpklwkPgu
         u1eXUSI64D7+ApF2zWYgAa8nzoEng/MYrd+G5SAAOCJ/MQAbP6DQ2yS2q6eg7SS4RXJp
         ragQ==
X-Gm-Message-State: AFqh2ko9h5dnPxTGXGR2MpJGomOcxLUpylzAFit5Cq1mTB5q7tVYhj7/
        ldPEEqNjK1XrTHVOVkITzJedLOOXv0qewzWX
X-Google-Smtp-Source: AMrXdXue43UUcDKwZjZdhWr+oBt+sdwXQSo5OBklKDMWMoPNfYRjlup1uXivGzXJ5OIlbz0SonbxTQ==
X-Received: by 2002:a17:902:7611:b0:192:5a90:b047 with SMTP id k17-20020a170902761100b001925a90b047mr10038582pll.3.1674850210540;
        Fri, 27 Jan 2023 12:10:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a760a00b0022bbbba9801sm5295775pjk.37.2023.01.27.12.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:10:09 -0800 (PST)
Message-ID: <3ba1adc6-4fb4-036c-8eca-91f549471c49@kernel.dk>
Date:   Fri, 27 Jan 2023 13:10:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] block: Default to build the BFQ I/O scheduler
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230127154339.157460-1-ulf.hansson@linaro.org>
 <5743fb1b-eb4b-d169-a467-ee618bcd75f5@kernel.dk>
 <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPDyKFqFrB4h21F0901nBp-mpiP70nObOrCpRA0ZRfOD_kD5ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/23 8:58 AM, Ulf Hansson wrote:
> On Fri, 27 Jan 2023 at 16:48, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/27/23 8:43 AM, Ulf Hansson wrote:
>>> Today BFQ is widely used and it's also the default choice for some of the
>>> single-queue-based storage devices. Therefore, let's make it more
>>> convenient to build it as default, along with the other I/O schedulers.
>>>
>>> Let's also build the cgroup support for BFQ as default, as it's likely that
>>> it's wanted too, assuming CONFIG_BLK_CGROUP is also set, of course.
>>
>> This won't make much of a difference, when the symbols are already in
>> the .config. So let's please not. It may be a 'y' for you by default,
>> but for lots of others it is not. Don't impose it on folks.
> 
> This isn't about folkz, but HW. :-)

Is it everybody? No, it's a subset. Everybody adding a new driver wants
to default to y/m, and it's almost always wrong.

> I was thinking that it makes sense for the similar reason to why kyber
> and deadline are being built as default. Or are there any particular
> other reasons to why we build those in as default, but not BFQ?

deadline arguably makes sense as it's simple, and we should have one
default scheduler. kyber probably does not need to be default y. But
at least that one doesn't pull in other dependencies.

-- 
Jens Axboe


