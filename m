Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B218C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6614B20772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 18:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zRNio4Wt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgGBSij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGBSij (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 14:38:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0E0C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 11:38:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gc9so6306643pjb.2
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6AIxUfWesqVTIVZwRsSBeuaSBvzLAiGbT6IoV06t0o8=;
        b=zRNio4WtQ62ONrby1MckVrsvPJ1FeBc98HbZptJGFJqT8u878Ly4njokAd517/IzXN
         od/4LYFt7PCq1kFN6vko62HCaDMSuY2fPouPuXM/1FfyNiH3DNBdd5qpHZa/NgKt/grg
         9awJUoMM/ciMLKgmJ1JIMuWB/L5fFB3mkMlaT8ZfVgq2t8X9L6WcBPC32Rnhh+375TQt
         Exu0eoIapvSbP2z8oD9ixBtSW37UfFBp+sua0fBj8GiaWaVVbCAqmJnbxzlZCNT+tZFD
         RF7G/LuFZatnPWf4A2vMf4ShisSM157RwoFAfVkWxor2sk0lNuEoSwqBWV3Xx+1T4tOE
         zUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AIxUfWesqVTIVZwRsSBeuaSBvzLAiGbT6IoV06t0o8=;
        b=qYuMzcyo1f/iRAMxxSWX2yyTQcLJ/LCnNR0lfLYJ/CDl5PR+kbQ6CaCi5iAXLEv4+L
         hIxdo7M8oCgt+7fqRWjMmZ7NWaRXYfJL2urQJgVFIelH2n4m4KsKO5kIouzkst1AOoFn
         WzBG4aKdtgciG+CFaUMeAAfAjLCQ205suFgFt4/OcDnTD+C2e7rgN0DhD751jb0t8/j+
         9mIph1MUtFw2iffw1FvbejNIksmi9gxL414SPMg61q/S7xiLXnM4frU9jcS+AkxlFXNs
         Tk0kj0iluFPUA1WKhQZqHCjutI17p7PwSEY0wDGEj+JACRYphnm2ZWNH692XtKFOKAc8
         /iWQ==
X-Gm-Message-State: AOAM531AVN5qTVBrhmq6EOBj0gyVpBz21hVyLcxvbJqvYGVcohzAm+z0
        OhtIorpuiJsMOR95vdEfacMBvzToItn/kg==
X-Google-Smtp-Source: ABdhPJxttNPbE2YNRAqhs5lEj1I7YptMKwoMbFtuvwVQPJe0Pz9P6xZYdK12DFM9jrQ/3cXLZQWXTw==
X-Received: by 2002:a17:902:7c09:: with SMTP id x9mr28200651pll.27.1593715118586;
        Thu, 02 Jul 2020 11:38:38 -0700 (PDT)
Received: from [10.174.189.217] ([204.156.180.104])
        by smtp.gmail.com with ESMTPSA id 202sm9323177pfw.84.2020.07.02.11.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 11:38:37 -0700 (PDT)
Subject: Re: [PATCH -next v2] block: make function __bio_integrity_free()
 static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     linux-block@vger.kernel.org
References: <20200702053543.29293-1-weiyongjun1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0fa5d527-5a2e-5dc8-0847-7ff450d99a02@kernel.dk>
Date:   Thu, 2 Jul 2020 12:38:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702053543.29293-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 11:35 PM, Wei Yongjun wrote:
> Fix sparse build warning:
> 
> block/bio-integrity.c:27:6: warning:
>  symbol '__bio_integrity_free' was not declared. Should it be static?

Applied, thanks.

-- 
Jens Axboe

