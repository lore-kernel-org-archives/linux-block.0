Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBE8C433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76F9B20679
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAZWAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbhAZUQb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:16:31 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDBEC061573
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:15:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o16so2563058pgg.5
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=06+ubIgKMIeLEqYAAy1hLMJ9omPIgHFObEcRyFWsADI=;
        b=Utr+B5OAzdKhhz5EGabcKcobLEE6Jc49WHmq9EekPmZkliRbYSCmycJJ4k/3972jS/
         mtzxx518O4DPgHlhiSq6Lod24kJISggu6C9sFHaxoAzU1kZGJ+6cVDCznE2V8h56MmwW
         VxA58fMR8VR9AIsOkwvLgn5SLJPxJcFD1zwAB0toQTE0UCXyE+9ZtmyMkncYlwmiF8rM
         w5fcwy01eV4TIcTMCgSUW65SlALAHm8iJWfSBOKxwAllByh4hgccYiCs3UOp4KbHAATH
         lVPryd4G/JWFjMnWzQhsBS65H35+BcA2YEMH5rdFchoMTCrM+jFABYJu2UG3ESCRGiZh
         6Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06+ubIgKMIeLEqYAAy1hLMJ9omPIgHFObEcRyFWsADI=;
        b=kj9UfKRMAJGVBs0v3ExtLlCal/91XnNlWJijcoOvKCO4rDWznjL732tQetj4x2wLd8
         RyXpU4yQwVBtQ1S+198BLFWgyKWL2rnAVnX7kQd/R76HiAltLybdi1UeLXEiIK83QfOM
         oyH83FZcP/soZH4WCqgyFhjBKjhKhbymhpjJxFq5f+UcCskZDA7f2Fei54JmqhgnWSs+
         66P41H20hjQvbjdvi3kGNueV+NGjy4yxlsC8YT9qRybMLQIYIgRPiYEEXyHbITe1FPjg
         b0eatf6NwtksJap3otpXRrowJc7HZ7uKF1HCs0AoO3NzN+m2qPdjyD3r8qZxEUgQ/xDx
         4eDw==
X-Gm-Message-State: AOAM532Ir287Ln0xn9DSBxd4erKnMCcW9AxxmXsYkla620z2GfAJWRit
        KZ3J10N4pItXsxBWy1F9Rtvx2w==
X-Google-Smtp-Source: ABdhPJx/1yUxPh2gfLhOqBFgIvxnIWgvc5XMNUWEeCV8wEDO4gdFudTA2m4bCmTT0WPGjuYhDK1NiQ==
X-Received: by 2002:a63:171d:: with SMTP id x29mr7237046pgl.168.1611692150816;
        Tue, 26 Jan 2021 12:15:50 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id z6sm8474406pfr.133.2021.01.26.12.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:15:50 -0800 (PST)
Subject: Re: [PATCH] rsxx: remove redundant NULL check
To:     Yang Li <abaci-bugfix@linux.alibaba.com>, josh.h.morris@us.ibm.com
Cc:     pjk1939@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1611222202-114248-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f70a87c9-8319-45cb-b105-296bbdbe3115@kernel.dk>
Date:   Tue, 26 Jan 2021 13:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611222202-114248-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 2:43 AM, Yang Li wrote:
> Fix below warnings reported by coccicheck:
> ./drivers/block/rsxx/dma.c:948:3-8: WARNING: NULL check
> before some freeing functions is not needed.

Applied, thanks.

-- 
Jens Axboe

