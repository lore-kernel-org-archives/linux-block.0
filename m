Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17066108F
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKBNHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhKBNG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 09:06:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C82FC061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 06:04:20 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id ay20so4203416qkb.7
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dn4BqaMm8E/Ym9b6CTx4iFhLLdRskhG8/BnMWQZMYiA=;
        b=CV7GUn5h7t+R98AniHQ+e3FbXFOMEsvZSd1hvuNMLgjeEftTO6nejnTl8CX3JEks84
         BrapEDNZbfWvf92QCz0OUemnwTATzFp37+VH//NuzccwImZ92esGMPDXXoqCuNIynyNX
         nyo3+OojZlZreduNyWOMdGQjy6xy2QhhQBbv10q8vmkX0R6az/sP1MXcB89v7TeiMEss
         2cKH6f+rR5UqoGtizvM0KK/8l1nLerqgDl2QbZ6ozhAF9GREznf2k99QroLvyvq7si5W
         kzi7SJOc/AObDiez/X8TwMNpd05WjseQc8SLwlzFMBH1kqlL3Z6P6cqVkzIuVl56U+of
         AzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dn4BqaMm8E/Ym9b6CTx4iFhLLdRskhG8/BnMWQZMYiA=;
        b=PghWfPAZZQOe5dcYE8Vx0WLA/rM+ef8fogv+hEMfUbBjfcAHW7BBafyTHEN45udTBL
         kETF1hqItHCHEaN+s8lyhjJcPqmdvauPyry+dfAPOyLkC7TkdSyOk2XEqogS0eOmLIFX
         ejG25Rs7/7vZfhVJ60xIE6ShvqPd5JYn19HLznE8g5dGnymyTgiNTcSNPXGRC0X6OUCA
         1tcldOCb41AZrlkMQ+uWBE7K12frnEf71TfNZh9jFwAkEieIhmJarHe8m3rY1XiS7raE
         70Vv9cVVaeICQIfMtwvDuqbJ2MiDDQNL8QarPGbl4GB8TOaIFWYwgEBuLy/BApZvS85i
         IJsA==
X-Gm-Message-State: AOAM533oqrDClP4YnlKTZBNpDE0g//ZkDMQUNI3LR7QLYhMAz5h23TwJ
        UYUar+d/rntjB8CJdLOibIXOPg==
X-Google-Smtp-Source: ABdhPJwM+zF/tlJ4BLYeH2ZKxc5LHh/BOCcEJcjNkHrZZDYjDhcr8F0U+JBW/PrHDJZEppOhOYYJqg==
X-Received: by 2002:a05:620a:4015:: with SMTP id h21mr28584785qko.300.1635858259569;
        Tue, 02 Nov 2021 06:04:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u185sm11980615qkd.48.2021.11.02.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 06:04:19 -0700 (PDT)
Date:   Tue, 2 Nov 2021 09:04:16 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4 0/4] Fix hungtask when nbd_config_put and sanity
 check for first_minor
Message-ID: <YYE3UK//36MbVzC3@localhost.localdomain>
References: <20211102015237.2309763-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102015237.2309763-1-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 02, 2021 at 09:52:33AM +0800, Ye Bin wrote:
> This patchset include two patchsets as follows:
> 1. Fix hungtask when nbd_config_put
> https://patchwork.kernel.org/project/linux-block/list/?series=573381
> 2. nbd: fix sanity check for first_minor
> https://lore.kernel.org/linux-block/20211021122936.758221-1-yukuai3@huawei.com/
> 
> I have consulted with Yu Kuai, and his modification has also been confirmed by him.
> 
> Ye Bin (2):
>   nbd: Fix incorrect error handle when first_minor is illegal in
>     nbd_dev_add
>   nbd: Fix hungtask when nbd_config_put
> 
> Yu Kuai (2):
>   nbd: fix max value for 'first_minor'
>   nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
> 
>  drivers/block/nbd.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 

Perfect, thanks guys, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series,

Josef
