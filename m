Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483FFC433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 13:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7AE64E44
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 13:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBVNjs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 08:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhBVNil (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 08:38:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDCC061574
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 05:38:00 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id ds5so1261689pjb.2
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A28ruaG1E5XH1ounkckduaEM2BAsibkE/W35Fopta6M=;
        b=hFMQ+wMuNXiye1ZXWjg0JnkCC5n+Vit4tHMj6urb5bwJ64yoxzhgSoBo8+bW9WMWpp
         8PTlt5EqTEbneHBLYGk2NeOROd6tcNUNkGDy1JJiFQ54c6WW/JHArOFPiVyzW9WtL/Aj
         eLwtzSh+X8F23FbyYLyg22NSsUUpf6qL1uvWYMeVt0xPqqPqbV1/GvK44Sb2xfq4fZ8K
         EISxkwPO24ajnAZRUehoih7UEeX7v1yCtnB8rTIdeHIyUzmyt0u89fTJS8/1S62PmlZm
         njcdaOn80iZfAmJ+LGDMCN9RmB/9yXLmU/QJLQXb/OqNo6+RLd7G7EI9I5vpECuy+Vyn
         8uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A28ruaG1E5XH1ounkckduaEM2BAsibkE/W35Fopta6M=;
        b=fOitmz0vu4QW8dcPO+GX2sCK449VN539J4AXAeX06vTg/0heLYfIpc5bjbI4aELRfk
         AcX21l3a4UpztABm71LLXcDZvLdtuo83fU1etzeoyhTK+3jvSOP4XwFw2b+xVEy1Ybhg
         k3HdkESL5q3C7BQXLzEc3oZpovQo1N9ZGtbZpkY1qjCmjOfY7CWAlDNSN59SeK6EXXVn
         gn4d4MDufE3ukWLMly7Dd2tnwkaMniVFDNxsKOXxXyre/e7p6fAn/hlDL32Iw9Hga8FA
         w+uJcWcYALwbmo1Kgl5GAsMXadsVWiXflYgnaOekp0bt6bZoHaEt4fYp24ePWAZjDjvd
         RihQ==
X-Gm-Message-State: AOAM532fSHPlqhl0HG10HMCxpJB6RFAVXlSIKD1PCvmSpn9B/V+c5yPi
        VWNJKbmTmfJ4I90+q6EmQZ/bWA==
X-Google-Smtp-Source: ABdhPJw2CbiYyhyEnpDI2Q6hckTmsdEZUV8ULwPafxlgrf/9FBoLJ+s0yX3lvyl4p1CAB7L6SZml1Q==
X-Received: by 2002:a17:90a:9e9:: with SMTP id 96mr23186041pjo.80.1614001080329;
        Mon, 22 Feb 2021 05:38:00 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o13sm18973545pgv.40.2021.02.22.05.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:38:00 -0800 (PST)
Subject: Re: [PATCH V3 0/5] blktrace: few cleanup
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, rostedt@goodmis.org, mingo@redhat.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, hare@suse.de, colyli@suse.de,
        tj@kernel.org, rdunlap@infradead.org, jack@suse.cz, hch@lst.de
References: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eed70407-11be-d4e6-0f3f-86ff01ec0c94@kernel.dk>
Date:   Mon, 22 Feb 2021 06:37:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222052959.23155-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/21 10:29 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> These are few cleanups for the block trace.

Applied, thanks.

-- 
Jens Axboe

