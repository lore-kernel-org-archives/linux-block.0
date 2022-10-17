Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DACC4332F
	for <linux-block@archiver.kernel.org>; Mon, 17 Oct 2022 18:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJQSK7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQSK6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 14:10:58 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7446D9E9
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:10:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 78so11134704pgb.13
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=moxKXe7U1ebuMzqu7/cZGChet+W4gvv+t8NNPuSo720=;
        b=XY0kF2gzGSA1+uw3SMLARMefKSvfWCXE8ZiDDlepUNu99ZYVA3r/SBHgaqYw3Mg0ts
         v5stIB0KkLpixzZIq7wotGiIooIZkdJ8os3Fog1avvzZlUAHZaNIPp44b0Ma2DRd6E++
         TyZIIfFeO8+Tqs0V4KuNtdAU9PthXqnfCmA+lyzivuajvfgb97uVydZ+AVHmCD2yOLpC
         gAQAcItx1SOLPMykU+flvQoS3Ft0ss4HNZk+qcFVra96Itv7jZhD2LH8zN0DiHmm0yOC
         XrC6zoYfYSUqhFZdU8oL8HrKtop75wK1NnnfegOnIROCE9xQ0jvhr8TmOgNg8aBhHiwi
         1raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moxKXe7U1ebuMzqu7/cZGChet+W4gvv+t8NNPuSo720=;
        b=Xh2buXmKLaQk32g8boIjlK/j/eA+scFOQ8HK1oEKjmTKv/K+sRRvKB5/oXdV82fjJ8
         Y2jkN/xcTPdksa5QqbfPolpIQHXR9HqrmW3q7wDBlvnx7f/0j9aq0JA7jdwUhleNTLTv
         mUD2L7XLMtxDuoCOOLNJXpjcFyY2sZm/Az9/v2Ld8Jp3Nxmjv2RsQ6CO+N06o9OxNpPc
         NmXTvMKQwpPTYVmBKncAyw2QmokWldLOKVk3Pr6TvOk/gPnic//hp2Z5MSmKH4Clh3av
         j8hEChSCOWMLge6EM3/SFNn9lgCdsYgBwgXFw72ya3QqxO2quaZtj0HmYTXYAqnel2B6
         xMWw==
X-Gm-Message-State: ACrzQf0Q0camJEGgXOm2kvPQtcrrO2zDg4r52J6DWCSqkNZPYwXff30s
        ICKlId40sMNGWwH/6yaCWFEhinLXECK3TUPh
X-Google-Smtp-Source: AMsMyM57hkAdLilgEOnNj8HB9ePsvlL/RYriF/tFJYYUFcy9FcGFY4mlR4OXBdTCbRTwUrsYVAWftw==
X-Received: by 2002:a63:5a5e:0:b0:434:b739:206f with SMTP id k30-20020a635a5e000000b00434b739206fmr11694182pgm.82.1666030256660;
        Mon, 17 Oct 2022 11:10:56 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001830ed575c3sm6900180plh.117.2022.10.17.11.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:10:56 -0700 (PDT)
Message-ID: <b8319bd7-ff28-5c79-a024-de8a21acedba@kernel.dk>
Date:   Mon, 17 Oct 2022 11:10:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH cgroup/for-6.1-fixes] blkcg: Update MAINTAINERS entry
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <Y02aBVTCSggxKWXT@slm.duckdns.org>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y02aBVTCSggxKWXT@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/17/22 11:08 AM, Tejun Heo wrote:
> Josef wrote iolatency and iocost is missing from the files list. Let's add
> Josef as a maintainer and add blk-iocost.c to the files list.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


