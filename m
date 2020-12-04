Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E849DC433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C087322AAF
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgLDQmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 11:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgLDQmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 11:42:10 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD769C061A53
        for <linux-block@vger.kernel.org>; Fri,  4 Dec 2020 08:41:29 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id 2so2639598ilg.9
        for <linux-block@vger.kernel.org>; Fri, 04 Dec 2020 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bbjLPiru3Bmbs8YC5o6bnScdwwI8le+IHLdqyI3HFzc=;
        b=utp9pnAlDvIB30UPOeFQ15UL0n4xyvLz8w+XabOab/MmjSxNW8ec4ciKrB7EF90dOK
         kzXjHGizoxz+Ji+UKTrGrckESghLE3SV8doEcWWFzIvBdveu/zk2P7IqPDyOK9SUfotm
         QmH/KInv8OnDTr/HGtj/2lCIVdcUnjEI4SXtCRk2zh60xo7u9VXFQ5/Iv+fKUc876sXF
         r7i001rzNg8scNRWHK9ID2bwf/5Tf2pyiD6+kuixxcgOODbejsaZ8yTV+02nY/KRt2id
         rdZ5lRMLwCOvzsrZBBVf3XSNC5LaA1sJCFhaPRDXinpdR1J1kpNY0kAsKMkmDDjt3JUJ
         cnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bbjLPiru3Bmbs8YC5o6bnScdwwI8le+IHLdqyI3HFzc=;
        b=i/D2/u7QqSHS4I52L29/lRD6GBiYRnmSyNg+prz7842OMKJpkDIbh8tw4rc1MbQMgM
         7MaCmh3LC5yew0wtY2CTRvPOrMrUYjMGwPRtR0w9cSk3aPxHd5er6pfSc8ZTPolkSl/5
         6e9IHHJzD12l6Aiobzyj26ZADJRzsVaOZTCSMopeX9iH9RRWK6Jiws4Pw2/ziSaJ5FVA
         WSTcLNC1dTqO6JVyb3Id2WiW4Nr7nyWILVgmBWwA/gygjOSpyfgEdPSmIHUuFdesYggp
         m8O42+Q+UQpr8q64McW/LaYhbSS8Q7G+8Bg3x8mz1aoKKNjj+8fE60cFwM7IY5IHZB6P
         uU2Q==
X-Gm-Message-State: AOAM530cqwA9hD6oAiMw8DLNpL3+slgp0HpyWi+oZtYVcVp2ivJqxA4/
        TvgKL23KkRZERSFatSxiYuq6Gw==
X-Google-Smtp-Source: ABdhPJzOFoOAq1T8LecabplxdCelUAVtxQ9B1uzy/pcjO2/T2ddZGPg5ONZb4vrY4yFvR5VplkoYuw==
X-Received: by 2002:a92:d68d:: with SMTP id p13mr7495902iln.27.1607100089238;
        Fri, 04 Dec 2020 08:41:29 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q14sm1946982ils.79.2020.12.04.08.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 08:41:28 -0800 (PST)
Subject: Re: [PATCH for-next 0/8] update for rnbd
To:     Jack Wang <jinpu.wang@cloud.ionos.com>, linux-block@vger.kernel.org
Cc:     hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        danil.kipnis@cloud.ionos.com
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c4ab46b-1a36-d2ab-88b2-089af1173ddd@kernel.dk>
Date:   Fri, 4 Dec 2020 09:41:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 3:47 AM, Jack Wang wrote:
> Hi Jens,
> 
> Please consider to include following changes to next merge window.
> 
> Bugfix:
> - fix memleak when kobject_init_and_add fails.
> 
> features:
> - rnbd-clt to support mapping two devices with same name from
> different servers, and documentation
> - rnbd-srv: force_close devices from one client and documentation.
> 
> misc:
> - rnbd-clt: make path parameter optional
> - rnbd-clt: dynamically alloc buffer to reduce memory footprint.

Applied, thanks.

-- 
Jens Axboe

