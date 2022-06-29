Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB92C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 17:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiF2RJm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiF2RJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 13:09:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9A1A05E
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:09:41 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id z14so15952360pgh.0
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BRlFSY3RcZGjJVS37U+/qAAOyAVpT0eHP66vIYM+VxM=;
        b=mUgCm92j6+jdQPHq4+S5nT9Gjlb5xzKnbXn593YsZvihyPClEeiN03LsfHQKXRod6O
         csUK+QqMrLHILwrhXKFS3rSBhfQv5+YTa8qxQD323ydkFQiiCuGUzOBKwuoYwtDzJAVX
         0lwzdz+V3ytChuj/bSvNbk9hs2Ycaeoaq29UqvjNHv6Yy/UaSg0CM6/LW3lHD+ayVzf6
         k2T+HyBqf4PM/zpiXJ99tSwi3VakhBnRNFt53GV1yF6400IzRDPYdvFn6Ftd/Rxddwbz
         IhYgxbn++6GIMa/3Nb/xUUqXHKdi84zyC8jIRZa1tvyNThyabcdcZj4npWZETjscxmrV
         3K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BRlFSY3RcZGjJVS37U+/qAAOyAVpT0eHP66vIYM+VxM=;
        b=sjwSzKI7Bn4umvd8Pi1xDDh0NVoeHkrf/JEEBy+A2P4T3jmqvrYzGhtDN9fzkg3g9a
         dYWPfXgrxng8vuZW5CK2asYm7/q/1GWjQyEqUc3ZyiMGZEYoTCtM2SrhtSDwYKdI0sIl
         lXF0q5Ho1g7lGATMhcqo6Pf4WL2+dC1X0vM3vxq1HJp3Hmek6lNbtA+vusMiPMjKeEtz
         r61uu10+FrqfKOZO6bTlLv1vMhsSnXRgnTZyxBtTwv7aa4gh7yCyT/9Ce0mKgFN0i3yQ
         RxTGLyD3W3VteGTycaX5HzvNr0ytn3dPqGZJxA4tHZWZA9FC6VqRQgdvn/uK/XiGM6ex
         oodA==
X-Gm-Message-State: AJIora+leOtA/yEGsSTHX1lRgb3Axo2MTHa/n4pN5HNk+VS5mEbp/1x+
        uAJSWmQ+cbiFJdzQO/yesrvo+A==
X-Google-Smtp-Source: AGRyM1vFZ32NqQnHpj5sp008/9h1HWxMYSAL3+U8H/5dNcZ0ciFRsb2LkaKX0Fcep5Bux4MYg+T5uA==
X-Received: by 2002:a63:5c6:0:b0:410:ac39:6f26 with SMTP id 189-20020a6305c6000000b00410ac396f26mr3673214pgf.483.1656522581075;
        Wed, 29 Jun 2022 10:09:41 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n11-20020a170903404b00b0016a12571537sm11499714pla.299.2022.06.29.10.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:09:40 -0700 (PDT)
Message-ID: <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
Date:   Wed, 29 Jun 2022 11:09:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, tj@kernel.org, jack@suse.cz,
        hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20220629070917.3113016-1-yanaijie@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220629070917.3113016-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 1:09 AM, Jason Yan wrote:
> Two duplicated code segment refactors. No functional change.
> 
> v2->v3: Fix indentation and add review tags.
> v1->v2: Remove inline keyword of blkcg_iostat_update().
> 
> Jason Yan (2):
>   blk-cgroup: factor out blkcg_iostat_update()
>   blk-cgroup: factor out blkcg_free_all_cpd()
> 
>  block/blk-cgroup.c | 73 ++++++++++++++++++++++++----------------------
>  1 file changed, 38 insertions(+), 35 deletions(-)

Like I told Yu, stop using the huawei email until your MTA
misconfiguration issues are fixed. They end up in spam and risk getting
lost. This series was one of them.

-- 
Jens Axboe

