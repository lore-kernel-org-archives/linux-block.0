Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA4D64E02
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhA2ALo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2ALj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 19:11:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A774CC061573
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 16:10:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cq1so4824383pjb.4
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 16:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RJgZGCYHw8mwAiuW9c9CpuogAGF20CsIjY7Z9Xte6a8=;
        b=gHfTeR121m6AaZrP9fdS/XYY7m/kgYToOc7v9YXa+CTx+NL0CuqCbg+q7jyT0thm7n
         HUcpziVkZGzWvDw7ee0PkvUxwHZOB5pGGZ4nGvtSZ14eNQu0a6VepqWxhleIb78lFAJ1
         lzksx88bS/ZfACmu2432gd+nuRFTZMaNdX99kFcyRjrhJSmirwcaFJpZypY2mQEZQURs
         vIXA7n/T7o9iGUHuQMWqA2AW4pbXkAVgMc/pA56leXbfynVlSZ9S3TFcvVkn3C2dW0m7
         +ZZE0ZkICcuHw9VOApfLhFss1Z2JJhVtDX0X8yuZUMWgEO1dBHlwI3Hgr4XRk998FiCc
         jdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJgZGCYHw8mwAiuW9c9CpuogAGF20CsIjY7Z9Xte6a8=;
        b=KCcArMojs4SNRAnSzq+rgtyz240FUc6Jvx7KPL/+y7hCKdhCJ9lsYT3AtenoEIxSAq
         UKCWOd+SVM1nLS6hhwh2aXM0ohhBxTGe+lUA9v5JaGAqK3pirUvhMyM+m/R7osLvg9ZL
         kDzgrF3nk3O39TLb1tx2EJ3zwBTgbkXy5/HECQs0+H8rSXAWZQWFi9OqgfWBcUDtp/2j
         /5e4g3iP33zD8ap/2wyEbv1RIDpfarcJ2BiZRoEBgYpYb2jvXSpbJq+c2tFgBWtdiu1I
         ggeZXh0mltNkRgOm2LxzYmJJchpxkrHrZNMOXB3dXwAx4iUsVNJl6bRBcRCFIBUFWRkQ
         9jKw==
X-Gm-Message-State: AOAM5335u4pN9WdZ9/ppCCGfF6LLLZU1qp8BmqlA4fnQ6s3zpSHXSMka
        3jNPtKVJlfi2S53PTGyCIfR/LLFHgv3pJg==
X-Google-Smtp-Source: ABdhPJxxb6SvENpVtufvCXQX+7Wsi7WcPMSDZ7sFjM0B7m53souou0roJyavMmWjT3+bBaJB1v82dA==
X-Received: by 2002:a17:90a:e16:: with SMTP id v22mr1788472pje.73.1611879058703;
        Thu, 28 Jan 2021 16:10:58 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j16sm6004057pjj.18.2021.01.28.16.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 16:10:57 -0800 (PST)
Subject: Re: [PATCH] null_blk: cleanup zoned mode initialization
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20210112034453.1220131-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75908f7e-7d30-4e90-c187-c473a14f0f2a@kernel.dk>
Date:   Thu, 28 Jan 2021 17:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112034453.1220131-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 8:44 PM, Damien Le Moal wrote:
> To avoid potential compilation problems, replaced the badly written
> MB_TO_SECTS macro (missing parenthesis around the argument use) with
> the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()
> to calculate the total number of zones of a zoned device, simplifying
> the code.

Sorry missed this, applide for 5.11.

-- 
Jens Axboe

