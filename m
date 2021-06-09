Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A2C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A0261375
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhFIPpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFIPpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:45:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188CC061574
        for <linux-block@vger.kernel.org>; Wed,  9 Jun 2021 08:43:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x19so5603956pln.2
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z8LtuiS2tzEpXTSP+uxll3VftE+3H1wCsbrsl83cEAs=;
        b=rEx/WU5P6jExj+zmsbzqK6Pf0KkmlK2tNcMGQm5YUGWItEMmGJf1oHsKx0O/B+TcvT
         dTO0kPYJMWwRAwAU5PuFG9SSg55BRarap6Ca+Cf0NrzY7pxNO6xrxroOjDFHR3rrXbz2
         LsjYs5u4CcwOZl1XtdTmtFpzY/n/PbFCptg6wsCNd2km2gII2oHGbF2OSzCWJgJFi0P0
         Cl0RVpcX3xSpBP5aXWHC2RtNDGLvvCXTc8B0D1z4zDwmtbUYaY4S/8oOpKsOx9TW7Ynn
         vrcA+4zIyYrzLqY8YeS4+oO9pbj/3O3n5vOMcjmmzNy8QAaEVGTuCgItLiOviEatV246
         vO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z8LtuiS2tzEpXTSP+uxll3VftE+3H1wCsbrsl83cEAs=;
        b=rDdr5ydfggTpiEG6dt0VR6ip2kF2y2STHBZG0DGQjpH9qHbNXUt3qwSFod4slGEkb+
         gq3EZUSK/0YWvWhMycdoHhZOrt9XFdxQye+wc3PcyHXv9x9Zjmt3nnBgZD0hPcixNVUh
         jtVmKitSXsh6WbWI+MAspvEW+RTEgMjGHH5pwSsUj5QjHZR1H86wZMH+pLi5PHAIsHpx
         bBkbNhFNr5sYCUQbU87olJ2viJxEG29vp7DquEiaceRlCkJjr6ICTT4T7atYZiLXUexs
         9lG7RLH0M+sLDff0uAjf2yLKfOdzkaHGklBJXpcpmqLcAAsugudIrubRe7IV+kqSl1rP
         ZvYg==
X-Gm-Message-State: AOAM532oz154gYDBalI8h6Ku9YN3r16yhiiFhC2VzRyJaOADXmeAL9qB
        58Vs4tqZdV7TNtBMISBAARDinZwYGrDfDQ==
X-Google-Smtp-Source: ABdhPJyLmm8IaiZtTyeYgMzfVp17Xz0Y54yT1KGpPCspVZJ3m+f58cgJ603CAFCbHepU8uSOqALW9g==
X-Received: by 2002:a17:90a:80c5:: with SMTP id k5mr11378900pjw.129.1623253390993;
        Wed, 09 Jun 2021 08:43:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id r92sm5808414pja.6.2021.06.09.08.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:43:10 -0700 (PDT)
Subject: Re: [PATCH 1/1] z2ram: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609122739.14151-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <648ec864-e70e-b845-7204-e5424fa9e609@kernel.dk>
Date:   Wed, 9 Jun 2021 09:43:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609122739.14151-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:27 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

