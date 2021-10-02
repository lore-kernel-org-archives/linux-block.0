Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB34C433F5
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 19:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205FB61452
	for <linux-block@archiver.kernel.org>; Sat,  2 Oct 2021 19:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhJBTDo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Oct 2021 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbhJBTDn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Oct 2021 15:03:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6DC0613EC
        for <linux-block@vger.kernel.org>; Sat,  2 Oct 2021 12:01:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id s20so15544470ioa.4
        for <linux-block@vger.kernel.org>; Sat, 02 Oct 2021 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/O7XZU6ko6L7U2pbYxXI47DbCcGOQTXwCmIH5eDYcdw=;
        b=JYn+c02o4xJTtv7UAM8Vcje/97A9gAr74fz+TEwNwN+7xdqPTxPB/DqfeNArROBKtK
         p2/xbGX3tc4UFioVkYhnDKuVTK4jkb7dS3oOwuVWm04jEBRRdopKdvt2GLChcQQDefOc
         Ix2gCstybmwtIil6QxjskZWOh+SnwSVFRmstZjdJxZXpr6BS3f0YauchY49b77CTjxMw
         c/9oZEnWH11V0QUT8fwhXISGOEDZ0CvbqMRvAJMGrwfT8emRWMlUKafdf+6MDh+IT3qz
         EEJGRnb9WqnCMHIx0enkcSyIDPXMQK17UmpQ7NF7McXUehXBiFPErd1umS4kgutpFfrQ
         MTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/O7XZU6ko6L7U2pbYxXI47DbCcGOQTXwCmIH5eDYcdw=;
        b=k+gRm75w1l+6uFFyhpWbtEKESwHoP2Z2qMx+eW56Yo8IALumNBtKbQOBZFEMl7IAar
         5Rk+PuyVd6wDuRs0oCsXAbFIlv+Wx4eD+td6LILFkIdApDXSr7LCFvNTIJZD6d+UqfXI
         kEysPROILccUFRzvaI1IHhPFbKA8oTVKChoUvioiLt23UOvrL61YCMm6vg64LO800gMv
         1Ze2V9wIMlIS/OyBqO2RSFZzOj3LLjthD2i6PPuhBQmTIfxughnU2ry61wouz3LHlg0B
         KEmomd4ufqKgIhQOfB8CwFXsedht+4+MuRqby1JZelJUh9yM+gRJHgqG+mXFiwwIZ4qa
         UQkQ==
X-Gm-Message-State: AOAM53016cu/jJberSuIX+Wub+MoNlnfvdxjGRyRQI8UzDTa5AFYxlwm
        MIscbgEqpWBI/7t0kAdJ+bWOijv/FGWVVw==
X-Google-Smtp-Source: ABdhPJwo/TJaIKLezqOHxjrgOW+d/5yOXzjDJbbYoxT3oqMCOHDIZabEV4dWSnuOn3wsPZahRgPMUw==
X-Received: by 2002:a5e:9602:: with SMTP id a2mr3313158ioq.189.1633201316971;
        Sat, 02 Oct 2021 12:01:56 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h23sm6511669ila.32.2021.10.02.12.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 12:01:56 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.15-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0ff68ebd-ae42-6b85-74bb-6ef114c948d0@kernel.dk>
 <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <76a03a8a-1a27-7388-e7ba-60a7d107fedb@kernel.dk>
Date:   Sat, 2 Oct 2021 13:01:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi2sX142TVRhhKZ=HgFzatZv2wt8yT=sR7r3Ob-p2d_hA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/21 12:06 PM, Linus Torvalds wrote:
> On Fri, Oct 1, 2021 at 7:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> - Add a quirk for Apple NVMe controllers, which due to their
>>   non-compliance broke due to the introduction of command sequences
>>   (Keith)
> 
> Pulled.

Great, thanks.

> Did we get confirmation that this fixes the issue for Aditya? I just
> remember seeing issues with some of the proposed patches, but I think
> there was an additional problem that was specific to the Apple M1, so
> I may be confused.

Yes, Aditya confirmed that applying it to 5.14.7 fixed the issue there.

-- 
Jens Axboe

