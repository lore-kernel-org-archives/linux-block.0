Return-Path: <SRS0=yryn=7L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB57C433DF
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5545620897
	for <linux-block@archiver.kernel.org>; Fri, 29 May 2020 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UfpPyJER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgE2Wb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 May 2020 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgE2Wb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 18:31:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853FC08C5C9
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:31:27 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ci21so2103699pjb.3
        for <linux-block@vger.kernel.org>; Fri, 29 May 2020 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjRinKG47cv+WRJraubcFr3U+Lvq7r9h5cI3It3kttE=;
        b=UfpPyJERqsDe0JeKh9kSCBp1UTomNGawgMihS00FGfwEgSzyJ5mY48/zDioK7R+d15
         Ishc4RUMdsNXqZ49Vsh3SO4RypCg+aIGZEGAIkCehakLilDYiaghS0LnbRpBlkinlq4t
         ZoOYxy1+qkq2efTePIweOqdQVcHT9vZ6T0VHB7AaNEB/hir1hZEpAvQywakJyiK0ZfiG
         JbYT8CAfVcy3FMa4KSAKsvO8K9ZQqpMu9m/TABzjE7Dkk+cwLqVCRjbl6TPQCEtf6S20
         RGxElV0oXP9F6ZuvnT08yozs+NAl5Rjh4ZPylzE0ao5Kn27kLcZS6VhfeDkpH2fDpPdo
         Hdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjRinKG47cv+WRJraubcFr3U+Lvq7r9h5cI3It3kttE=;
        b=Kp30Erv3ZnUTUV5N5daP8Sz+WWTBfqDCVvXIdzKt1/t5+Dh4IHT8vK/JfHj5/gJDCl
         4S6k77NIYdu35T/s9b/RDkHHxLYpV+3tuZwEBsgXZtNmew7FRkMoMmKiVWadlXMN7aZ7
         vslcXpQl5QcHcwOZk2KyKsDeDFQ2fs4IODICuvKlziOhuHPxIMuj1+wmhMGxoFDdrEbR
         rHQJCcs/a2WT+AFyQ3TnB70Qwsz4Ro78fuxwZKYBYW8HLR6mvA/hQuef+Hk7fGkoasIB
         eqmwF/eSdiBBc6yYWCV8d4sjGpwbIVef5zGZ97cjUhurr20n1WRVhqwdb8ZFsiAnfjcx
         4vEg==
X-Gm-Message-State: AOAM532n1qOG8epzrbLWbpkPRDdK3KCyV8T4B7LMJDJaNlsuCEiUUA17
        xGXxS4ZLKxzFqG5fTAvAcfmXZVkKLdm68g==
X-Google-Smtp-Source: ABdhPJx+LDltheLujHCj6OjRNHFrDJs2kyFM5F0DpaJNY7XAidtunKk7hpeBbIqw3CYI2WKBpkIkJw==
X-Received: by 2002:a17:902:7618:: with SMTP id k24mr10843832pll.167.1590791486481;
        Fri, 29 May 2020 15:31:26 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b5sm349612pju.50.2020.05.29.15.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 15:31:25 -0700 (PDT)
Subject: Re: [PATCH 0/4] cleanup for blk-wbt and blk-throttle
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
References: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97c85845-e678-e9f3-87e3-7cd9d5b66d17@kernel.dk>
Date:   Fri, 29 May 2020 16:31:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508220015.11528-1-guoqing.jiang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/8/20 4:00 PM, Guoqing Jiang wrote:
> Hi,
> 
> Find some functions can be removed since there is no caller of them when
> read the code.
> 
> Thanks,
> Guoqing   
> 
> Guoqing Jiang (4):
>   blk-throttle: remove blk_throtl_drain
>   blk-throttle: remove tg_drain_bios
>   blk-wbt: remove wbt_update_limits
>   blk-wbt: rename __wbt_update_limits to wbt_update_limits
> 
>  block/blk-throttle.c | 63 --------------------------------------------
>  block/blk-wbt.c      | 16 +++--------
>  block/blk-wbt.h      |  4 ---
>  block/blk.h          |  2 --
>  4 files changed, 4 insertions(+), 81 deletions(-)

Thanks applied, missed this originally. Nice diffstat!

-- 
Jens Axboe

