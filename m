Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3575AC433B4
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5EC613BF
	for <linux-block@archiver.kernel.org>; Wed, 28 Apr 2021 15:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhD1Pxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Apr 2021 11:53:39 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37720 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbhD1Pww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 11:52:52 -0400
Received: by mail-pg1-f182.google.com with SMTP id p2so29577808pgh.4
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 08:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h/zzIdjrrUl2/UsHr5TrYaDhKtxFkcdK0O2dKUqUAKY=;
        b=AiaVUiyjwspVxQWN/zO2yWIaGRxUSD74tK1dSirpU+ziUP98/mzDUE4T6yOAbhKvfO
         z+U5lOewED4Wq2h3dRXt7ydJvZllNLIUEqXv+Sj+PqMb/Pf1LgBOoty6G32GLBvICdu/
         l2BwVk+UufA1ZHuEkTPuak1vl5fxUa0zMxXm3BQr1o0eDrEZsGRDuGSCVUA0gLTzC78R
         1HUawnZrcG+gzFuMG3jUBbhnB4AXIzMjb/yHCPecdQo8RR2xrsLiTCS+CqhGoNy4I1ZY
         1G05yjgsNjyaPsBfDwdSod3iO0rPxAzjby33VKPrKEt2CkwHeIcNIAwco4q3MrZovAZY
         dTrw==
X-Gm-Message-State: AOAM533Cph5Im/L3mN82qARbHWM3gazpF2CEOYxjLNeC37ho1k/PWfSp
        U4iUH9KMZh0jfEho+FvfdcI=
X-Google-Smtp-Source: ABdhPJz0qbFjLyXMAhWlltGK8rjKklwLlr9+2dkUYEbKgKgjvb7OPmRU1rKF7wCXQbHq0nsWxAFJew==
X-Received: by 2002:a63:a16:: with SMTP id 22mr27343770pgk.345.1619625125372;
        Wed, 28 Apr 2021 08:52:05 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id k8sm132821pfk.189.2021.04.28.08.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:52:04 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, yi.zhang@redhat.com
References: <c5f47617-f06a-d598-1794-118447e8e2b0@acm.org>
 <CGME20210428073921epcas1p2b161b5ccc9d7ec61c1200155da95c5b9@epcas1p2.samsung.com>
 <20210428072123.3155-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a1759842-eb14-e477-fdf6-b6844e5aa29f@acm.org>
Date:   Wed, 28 Apr 2021 08:52:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428072123.3155-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 12:21 AM, Changheun Lee wrote:
> Actually I don't know why NULL pointer dereference is occurred with Bart's
> patch in blk_rq_map_kern(). And same problem have not occured yet in my
> test environment with Bart's patch.
> Maybe I missed something, or missunderstood?

The call trace that I shared on the linux-block mailing list was
encountered inside a VM that has a SATA disk attached to it and also a
SATA CD-ROM. Does replicating that setup allow to reproduce the NULL
pointer dereference that I reported?

Bart.
