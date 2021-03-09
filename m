Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCDC433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 20:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C896522E
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 20:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCIU41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhCIU4T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 15:56:19 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F2C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 12:56:19 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e7so13437118ile.7
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 12:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BNwwShfJ99REridSMvDgWguNqA1PF7ZieDr3sKpJ4o0=;
        b=C6EeR0PkoONZaFODzmSUja3CjRpP9B28DJWDSx+ToLshGOGxOtmRUFypBChje0nELp
         W3J+fJ5ZOJA3khauf8G8Si1APY23Y+bOeQArIcvyO3Pi6nHt5UN79jafYGXJzD+/s0zo
         wrFA51aht5K7BohPaoaPlyfLCEdra+c5dRuNYkEui0VXO3ZPmTs5zh/L3fApPKXLsJIl
         i5SsAJ3UNRSZa2uxVT3yRtxamfyrieFlD5/GlCmRJfNynRxRUQnPfz9PZTpC1NaIBeTW
         3W4BBR0I4+ThOg4pTNzh+otO0PUWuwZoPLRXxoscutGP3aYuyce+4ytnsvrCltMDDNK4
         ir2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNwwShfJ99REridSMvDgWguNqA1PF7ZieDr3sKpJ4o0=;
        b=jt99pYc9GI/6Lu0KEW0mH5drgMtDhgcuwR0ZmlFBw90letpkPHx7yNd8GOzQH3bRZx
         kTF/Epmp0lJ8Ht9ZeTJjq+ywo0RDdwqTrcW28GpCqCoBseHi4DcmVLtedDS1fnIqmHA2
         3IS6/cdHrZcB57z0ERYZuvV+lLIK8Vce8G1AVMqoRmRGb6f/5C0f4uidVIn7YFNE9ShU
         XuR+DHmDxZ9/dFqywPGopKfIMC4o3jCvUZwTKSBQyEqa5VlmuOdl2qZqTRNsxvrtJwCe
         z32+6kqvqoAl77jTBiMHCQf0wkzp5mbQvwNTh9jfWWCXmgb++HJNU0KGljkwLeM43Gmt
         /oMw==
X-Gm-Message-State: AOAM530QOAevoNe5xkqpcaViP+uJoWqVaQAf2NPe+v+jCtvYGZf+NhCG
        wI8t/KJ08M/KTB8nsrdpQjQ1Tw==
X-Google-Smtp-Source: ABdhPJw1RmiX9LcUGimg1p+XrUjJZb/ZLQ/jT47ghEmT6E6E+AHrNeJigMegsln5rkka5BDgEZAZLg==
X-Received: by 2002:a05:6e02:ccf:: with SMTP id c15mr13923ilj.189.1615323379158;
        Tue, 09 Mar 2021 12:56:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s18sm8351758ilt.9.2021.03.09.12.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:56:18 -0800 (PST)
Subject: Re: [PATCH -next] umem: fix error return code in mm_pci_probe()
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     linux-block@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
References: <20210308123501.2573816-1-weiyongjun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <610194e5-47ec-8877-6897-53011fe2bcce@kernel.dk>
Date:   Tue, 9 Mar 2021 13:56:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308123501.2573816-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/8/21 5:35 AM, 'Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return negative error code -ENOMEM from the blk_alloc_queue()
> and dma_alloc_coherent() error handling cases instead of 0, as done
> elsewhere in this function.

Applied, thanks.

-- 
Jens Axboe

