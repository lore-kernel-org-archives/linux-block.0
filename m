Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19993C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1ED20728
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 15:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NKfqO3cB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgENPeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 11:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgENPeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 11:34:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FEC061A0E
        for <linux-block@vger.kernel.org>; Thu, 14 May 2020 08:34:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u22so1284711plq.12
        for <linux-block@vger.kernel.org>; Thu, 14 May 2020 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pHBtRb+khIWZrefMw1X6pZevwAXg2al9wRn3xvVihy0=;
        b=NKfqO3cBoDTJpRGDur9/vcfgahx0lBedFqcgsjMK5GrbeaiqjKRKo69vkHmriZS2YU
         41ZEqi2d3AA/wTkGLGuHxDFYqqPbROqzoN6W3+cKiL295Y2PywCH80nC5qzvJooEBQzF
         gfb59SXnKKXMNi24xbx5OWXcIGgMND1y38Y8Diz+rgTR2BZLBDczGNu2karytqb+DHyi
         WgXg3n/PHRZikL+qMeQWro/Tmr34EPbgqMl7Lt6Xh9/w3LgSDcD8mQVCrgZ8VQF2TCwn
         IofsrNrRQrSnR64lPkQf37JEaxZBwr6y6+yApHCSytNjb6sQLDNwGEp+dlYiDiIjqg1y
         golw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pHBtRb+khIWZrefMw1X6pZevwAXg2al9wRn3xvVihy0=;
        b=oEykpaL/R0lpHJRwpr3PvhvY+5ymPaB7GieAVa8cKjw9iJSKtjYCHbmCQIuHoOzNpC
         5FCDLnfoHnYRZhS7FOd1TgSHH562ry42CDv1JmdBVGfabgalNvqjgPndWI9Fo1BLoQ0G
         xlilt3HUbxb6f0jWeqsgQLIWJjBCghXdURNj7h6XbFTc8iX34R8agVC64F8awAK8Vj1k
         rGuteDCcVirFBcGT9L9BpHL3/GBgJjrwtWW0X43B9PGWejSwqNLtiBeIfdun7oqCfE9F
         xJ6GP9cGfyf4sD0kwfjLbakHf8M1lXbomDMcwZ/vJZ9wuwfXWnQat3gE0QxecJnXhMCw
         8jtg==
X-Gm-Message-State: AOAM533LD8xN1KvGia2VKrgPkSQYNo+ImTPTRORg+5tmT0+Bn6GBlSPh
        fq88k8wTcNeWAKR3wqjso1Kwug==
X-Google-Smtp-Source: ABdhPJxQeND4OmYcB5YLpPsjAyico6RefXvZ40FYUlf8Ik8uL8AM1uknT2uGEy9hWNhk3iyew0TVrA==
X-Received: by 2002:a17:90a:358c:: with SMTP id r12mr10677883pjb.161.1589470459745;
        Thu, 14 May 2020 08:34:19 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:85e7:ddeb:bb07:3741? ([2605:e000:100e:8c61:85e7:ddeb:bb07:3741])
        by smtp.gmail.com with ESMTPSA id k4sm2339675pgg.88.2020.05.14.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 08:34:18 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] iocost: don't let vrate run wild while
 there's no saturation signal
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, newella@fb.com
References: <20191015001811.GI18794@devbig004.ftw2.facebook.com>
 <20200514145114.GG16815@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3ea36e8-b888-4db0-0333-936523c98476@kernel.dk>
Date:   Thu, 14 May 2020 09:34:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514145114.GG16815@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/14/20 8:51 AM, Tejun Heo wrote:
> On Mon, Oct 14, 2019 at 05:18:11PM -0700, Tejun Heo wrote:
>> When the QoS targets are met and nothing is being throttled, there's
>> no way to tell how saturated the underlying device is - it could be
>> almost entirely idle, at the cusp of saturation or anywhere inbetween.
>> Given that there's no information, it's best to keep vrate as-is in
>> this state.  Before 7cd806a9a953 ("iocost: improve nr_lagging
>> handling"), this was the case - if the device isn't missing QoS
>> targets and nothing is being throttled, busy_level was reset to zero.
> ...
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Reported-by: Andy Newell <newella@fb.com>
>> Fixes: 7cd806a9a953 ("iocost: improve nr_lagging handling")
> 
> Jens, this one fell through the cracks. It still applies with only a small
> offset. Can you please apply?

Looks like it did, queued up for 5.8 now.

-- 
Jens Axboe

