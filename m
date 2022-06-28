Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FEEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 14:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346446AbiF1Opm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbiF1Opm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 10:45:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6112C101
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:45:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id u20so13075257iob.8
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qxdIfi7m+FKVSEMBxI9xOlO+HVkq93lINQlUiXOhq6Q=;
        b=VhfjEv3vWzQnceECge8zXoy8IvgKitGNqxZYUzwJPD2UXYowj/z/UPLEMJ6jrohbiS
         N5lsbBgVnDfoDvtarm3i2hGLoYvDmBUGElkb9UBE/BbgGag0c5EUoXp7HF2pWBifnwOc
         6+KGwkYIOUTp+rqhVo9/EMP+3+zxmQ3JexCtdvhDMOr2L3YtBcAVgj2Ps78OVDHK2r2g
         P1xY93MILB+YvE0C8FvytyY+nZeP3O7kyTpL0vESbJ6p7OvtjzWfHZ/zjBLNXbLptTIF
         USns0/En432oLvJJxwYC6pqGO9DIFgTWa0UuYd/EDuxzDRU3jjeSqmJboVvfri8hVWTc
         cXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qxdIfi7m+FKVSEMBxI9xOlO+HVkq93lINQlUiXOhq6Q=;
        b=JgT/j5jJ/AUVH8OtHPJGna7Oj8qfyhqFd88Gi8cSV5R12Jl6G7cd+7ZOSih8g7pOWQ
         50kNm3ucQM5qGDl12+mUGkm1yS2VaMwP6Ci6Pg8b+tlpzJUNyjv2lkhuSk0JfpZ+RNTY
         z8B6fTcLpM8yUfaBy4Z5ovuQ9NRgkQ5m+J35ezZrYMhmdAgtZRFje73pUEqyjVY291e7
         4UfRar52ZGpQS/nPdc4lVhDfwpPQxagwv+nj2FQXaqxxzOzLYqVfAoZROLI5l4F9dtjS
         gCjfwcRo0h/TuEDJUeqiZ8DZRdgmgB+1HOHyb4xH6MavVaxZ+x0Ii0Lj6xVt6VubrN73
         7d0g==
X-Gm-Message-State: AJIora/iytlsPVMxrzE52xDlvPkrh2KcMR1KEmCcWbTJue2gt6ZZqj0U
        9QOxK04GwdBDg0hdRnAkVgbTpw==
X-Google-Smtp-Source: AGRyM1tuBEQS4RXFt18GcrnbVHFSXfxRNJsst6Qk2NCqpXCAO/bBirTsMmDmU4/Jyxwn3MPX3RmcJw==
X-Received: by 2002:a05:6638:418c:b0:33c:8f69:8e5e with SMTP id az12-20020a056638418c00b0033c8f698e5emr7357424jab.193.1656427539838;
        Tue, 28 Jun 2022 07:45:39 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r2-20020a92d442000000b002da7f0ca821sm3763982ilm.68.2022.06.28.07.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 07:45:39 -0700 (PDT)
Message-ID: <f9255ed5-e10a-90cb-5f7b-8638a42bf27d@kernel.dk>
Date:   Tue, 28 Jun 2022 08:45:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] blk-cgroup: factor out blkcg_iostat_update()
Content-Language: en-US
To:     Jason Yan <yanaijie@huawei.com>, tj@kernel.org, jack@suse.cz,
        hch@lst.de
Cc:     linux-block@vger.kernel.org
References: <20220628144921.2190275-1-yanaijie@huawei.com>
 <20220628144921.2190275-2-yanaijie@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628144921.2190275-2-yanaijie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/22 8:49 AM, Jason Yan wrote:
> To reduce some duplicated code, factor out blkcg_iostat_update(). No
> functional change.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  block/blk-cgroup.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 764e740b0c0f..60d205ec213e 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -846,6 +846,21 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
>  	}
>  }
>  
> +static inline void blkcg_iostat_update(struct blkcg_gq *blkg,
> +	struct blkg_iostat *cur, struct blkg_iostat *last)
> +{
> +	struct blkg_iostat delta;
> +	unsigned long flags;
> +
> +	/* propagate percpu delta to global */
> +	flags = u64_stats_update_begin_irqsave(&blkg->iostat.sync);
> +	blkg_iostat_set(&delta, cur);
> +	blkg_iostat_sub(&delta, last);
> +	blkg_iostat_add(&blkg->iostat.cur, &delta);
> +	blkg_iostat_add(last, &delta);
> +	u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> +}
> +

Please kill the inline.

-- 
Jens Axboe

