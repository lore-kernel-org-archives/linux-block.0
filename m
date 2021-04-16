Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412CC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92D6611AB
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 12:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbhDPMGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 08:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbhDPMGJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 08:06:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF16C06138F
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:05:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z22so8733139plo.3
        for <linux-block@vger.kernel.org>; Fri, 16 Apr 2021 05:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=53duoniRLlTsqGW5bX0atBzLc+S3mfJFAbdOwh1ig0Y=;
        b=XebPfasu1f3IBqtFL6POE5QmVzAHRsSQVt7c+rdKOs5np1YjkQXjRsHgvWFgJMF3iA
         rK4bKx8OazzVjStP27trdd2cyXDUVfB5WwN/t7kG5nbzeSi9uVhMzfIxmkuKukl+pr2E
         T0o/zFHD6PaydvQRcGLNNV1YoeXFapMFDL/skPDIfX81M8iVDM0RwYQ6t6UpClAruuch
         bOvuHaHnuk4SVX2i/KmO2wfJ7VX2wrIsCDsNiOyBugD9qFVrF8zk685nGlprCqrtRiae
         qVrZqOKBdfl2B/RpxarYoyiN+INVJpEYbZxAgGs8SFusptWa29IBnEM3VrvHmzwgEvee
         lYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53duoniRLlTsqGW5bX0atBzLc+S3mfJFAbdOwh1ig0Y=;
        b=gNG69HWzB+KWqcInq5N5ocnglXzyl4VhNwflbs/Tabh3JH7s0YFHu7Meeaii8RP2F2
         M01cRxaNfpmCke79+zYqVEtkPnK3VFd5EfqviHfa8CN02dauKtdQ6qGYeogDk2ao8F7h
         dxwuDST13ia7TUwcEfFA5kGhlOpiXw1UoZMELv896m/wCxUMEBhhp5BeubjpNAf3RsG+
         BZ/4UrzmfgPOeWnj1nCX3bTWAWMCYXBXS6gmN3JRczR4hHk2uTrfs6lss0s9uT1f3FUQ
         k2cfZX8Co+z+rdBwSpD8Ib2kf+DmRO+CekvpmwtWTwXsN09gaNcw4xPUrbMgI0i1YudQ
         ljoA==
X-Gm-Message-State: AOAM533aRpBYa2rHlxtS0J97BAuuKwHiVNdwIfn8PsAg+Ai7sb8FUIh1
        acI42pVqJ385GSZLmfDleZP06t6+hIz/Zg==
X-Google-Smtp-Source: ABdhPJzdFI0du4cM1vGt4YPtsF3WN6FdkKb3ZQOSkCs9vbf+YlEZ322C+4J6PyFeBFnbrOVvjmolBg==
X-Received: by 2002:a17:902:b908:b029:e9:4010:7fd3 with SMTP id bf8-20020a170902b908b02900e940107fd3mr9098400plb.55.1618574736699;
        Fri, 16 Apr 2021 05:05:36 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j20sm10911895pji.3.2021.04.16.05.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 05:05:36 -0700 (PDT)
Subject: Re: [PATCH 0/5] Another small set of cleanups for floppy driver
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210416083449.72700-1-efremov@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af78129d-66ac-3460-ae87-bee55ba634a3@kernel.dk>
Date:   Fri, 16 Apr 2021 06:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 2:34 AM, Denis Efremov wrote:
> Just a couple of patches to make checkpatch.pl a bit more happy.
> All these patches preserve original semantics of the code and only
> memset(), memcpy() patches change binary code.

Applied, thanks.

-- 
Jens Axboe

