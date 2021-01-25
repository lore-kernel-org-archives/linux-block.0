Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E7CC433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 21:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0B420708
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 21:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbhAYVPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 16:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbhAYVPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 16:15:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05900C061574
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 13:14:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so8415563plg.13
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qRHVlys2zAjjxBtjE+T6wwnyF8H38Om4NwqdpPjEWwM=;
        b=XJ6Etu3MXGdkNqFWNxmgTkstn5En/9aC8l8yyMUXyYE3wCP9zGyS2+HSQJ1I0mwg63
         1iigcIsBBPA/wvpReIFCrkTxffBIgLQ0eTlgAl3USfTYLmMl+dFPLwOrED/C+Xxdtrc9
         0YfFifIVT0hCyBp0W2XVYhLuNWiYWsjlO2W2AnUDLkODBTsusnyoNCKtMQN60UB7Y+VD
         rZbG0Fh8LevhgLJk43X6VXrrLQ6l0rX7awWPrdGAUYqgVzd5cSpFd0d1jm4PfkBwuCjX
         BSq5KEn9OYAZY+LZrMjK8ZU8SoBm+cAr2PkM3EGg1yuypLHblRFwzA03nmRkNKBSQV5N
         cC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRHVlys2zAjjxBtjE+T6wwnyF8H38Om4NwqdpPjEWwM=;
        b=qbDy+0O6dKPHt8c5IqRscythyEQH4enUVxopkAK5zLQxbgna8Ge7jvWvblk4Y/iH2J
         8JncRa98SctnCiroQVvPP5/P1qRizQUOoM7T4sj2t0HfCTyGrSblyTeY5Ue0OwHd9ayN
         v7gQYJ2XJGkWWTKvIMr7Ib+mq4iuow+g81law1WyzphoYJ9+hBzOizUec/HyBtOsYjVi
         B54GmuPCV5X7LvSbQzDe4qOfX0R/acXVl96ITO1RSD2RhOFoAazVYzf8KfswtWZZQdyA
         T5csTwFrikw2fxmLJGQVM9OHQao3sw4Y//xUniMhLrZzADQJP1BcvVTl9AIZFmJAFESx
         9t6g==
X-Gm-Message-State: AOAM532iXPuuXrZqiVFosN4DLZy0LCY0F1p1Fxjj8OkPBKMw6HVVj0Rn
        imIJn/xzWLFqaFM0Zqrkxa6lkA==
X-Google-Smtp-Source: ABdhPJyu4y6/35DKByDjoOtf3OGFpY5YYhLb7LjvpjQwqZaT4/kHlkcBWKXiBbFTRzB5pEth1NfUJg==
X-Received: by 2002:a17:90a:c907:: with SMTP id v7mr2207890pjt.0.1611609274381;
        Mon, 25 Jan 2021 13:14:34 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id r14sm18607214pgi.27.2021.01.25.13.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:14:33 -0800 (PST)
Subject: Re: [PATCH 0/2] Resource-managed blk_ksm_init()
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Satya Tangirala <satyat@google.com>
References: <20210121082155.111333-1-ebiggers@kernel.org>
 <CAPDyKFrLn_4Csxc6BeRR0-zY+_RQuNqNSF9SmKk3Bx2WFJJ_Ag@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d03dda2-adaf-a44a-922d-f3770e3da8f4@kernel.dk>
Date:   Mon, 25 Jan 2021 14:14:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrLn_4Csxc6BeRR0-zY+_RQuNqNSF9SmKk3Bx2WFJJ_Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 5:50 AM, Ulf Hansson wrote:
> + Jens, Martin, James
> 
> 
> On Thu, 21 Jan 2021 at 09:23, Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> This patchset adds a resource-managed variant of blk_ksm_init() so that
>> drivers don't have to worry about calling blk_ksm_destroy().
>>
>> This was suggested during review of my patchset which adds eMMC inline
>> encryption support
>> (https://lkml.kernel.org/linux-mmc/20210104184542.4616-1-ebiggers@kernel.org/T/#u).
>> That patchset proposes a second caller of blk_ksm_init().  But it can
>> instead use the resource-managed variant, as can the UFS driver.
>>
>> My preference is that patch #1 be taken through the MMC tree together
>> with my MMC patchset, so that we don't have to wait an extra cycle for
>> the MMC changes.  Patch #2 can then go in later.
> 
> Sure, I can pick patch #1 through my mmc tree, but need an ack from
> Jens to do it. Or whatever he prefers.

Or we can take it through the block tree, usually the easiest as
it's the most likely source of potential conflicts. And that's true
for both of them, as long as the SCSI side signs off on patch 2/2.


-- 
Jens Axboe

