Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC0C433ED
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 21:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02806115B
	for <linux-block@archiver.kernel.org>; Fri,  9 Apr 2021 21:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhDIVEE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Apr 2021 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhDIVEC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Apr 2021 17:04:02 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854BAC061762
        for <linux-block@vger.kernel.org>; Fri,  9 Apr 2021 14:03:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h20so3350574plr.4
        for <linux-block@vger.kernel.org>; Fri, 09 Apr 2021 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DWhpxp+p4pToPW6LRtWDFpBaNDFTc1oQ9cV5eZeWzw=;
        b=B6TxdpqrDx+bjsByI+GVG9DtVKSvhEe2jw5+j+Q/ZqG1M31CXIrJLFMwZfDQBEzghe
         hOB0WA77RUarwGLaNqhD5KvGQE4hZh+TbvRh2L9fFXqXIdOEf9V3VQnFU+uGylA+kGwG
         Zg5OjHiRiA98PHetm4FRfwKdE5lYreFxCPvXr6DY75P0j9vQyOYCUIO+wkP1vD75YxYt
         Evri8cPFT/6BXPa1v2IaMMwXRL74V+UKL/0WMl9OHXVCbvb/290rbrkPctaXHj7nQIRa
         1DTHkeE8Z0nfDAyHvon8HZG3OUtqp0REFT78+scgUSnw89U9FEkKNSsKa9h5cxxqBzZW
         FinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DWhpxp+p4pToPW6LRtWDFpBaNDFTc1oQ9cV5eZeWzw=;
        b=my63Q6aHV50b6R2TDrY6bdnGAMFq9pvylqrv/dZVdOeeP+JjX2NdgsFChu41ArY9N5
         Favj7t9XOMbdeESJ8DNk5nRMlBivVMGJHZ/VhvoKMOXr0PdZZS6bA+SRTCjJHPVwYOFw
         e6ug3DQ1AowNTDtb0rt9j5DUIqW/A3brIgxWcExv0v7t3bsOsXEM4w3/6OF9m/pfIVnx
         2+gtO3cRG128NtkL23WL7u6cCAOIzcMo6Jx2RQXkKvnZobjxlshRqLi/MXNZ4XvzYcS9
         shbF+IQq84Xwps+oJNy+nFwP9J7vWbacbSbQkv+k6XfQSNx+/YS5lRHGoOqbQXOy7ztl
         WsiQ==
X-Gm-Message-State: AOAM533a53nDCUU1TsofxIz+wFXySyJDJqlU+oZ/0RiQviPuNQ72tJ6W
        Hc6kQwHDsWnSdwkQVJr4nINp7pchfxeZJQ==
X-Google-Smtp-Source: ABdhPJykpr/ZH1N1sFKC+YHmWjtta5tKSDUOppKR1rJzB52yXnb3LNNzwxPPvm5ymi9Wa6TPMoUSCA==
X-Received: by 2002:a17:902:bb96:b029:e6:23d:44ac with SMTP id m22-20020a170902bb96b02900e6023d44acmr14275597pls.50.1618002193432;
        Fri, 09 Apr 2021 14:03:13 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id g21sm3100712pjl.28.2021.04.09.14.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 14:03:12 -0700 (PDT)
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-block@vger.kernel.org, jinpu.wang@ionos.com,
        danil.kipnis@ionos.com
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
Date:   Fri, 9 Apr 2021 15:03:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210409160305.711318-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/9/21 10:03 AM, Md Haris Iqbal wrote:
> Hi Jens,
> 
> This version fixes the long lines in the code as per Christoph's comment.

I'd really like to see some solid justification for the addition,
though. I clicked the v1 link and it's got details on what you get out
of it, but not really the 'why' of reasoning for the feature. I mean,
you could feasibly have a blktrace based userspace solution. Just
wondering if that has been tried, I know that's what we do at Facebook
for example.

-- 
Jens Axboe

