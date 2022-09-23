Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64948C04A95
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiIWV35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIWV3u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 17:29:50 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6482ED4B
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 14:29:48 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id r136-20020a4a378e000000b004755953bc6cso242758oor.13
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 14:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=ZGsHfCz0vcFr7tUGQ1YmYn/WTXvbxQ/j0IzGjWxyxBw=;
        b=I0aBEbvgjLil0ywPPi6Ss08ZtLCUNNMs3cN1rzPH1Z5uZIXD54xYdyBRbtSdAIIQsX
         vaZouOQ9T1QumiTC3NDHrTvWjJMWeEWpH+OnpplHEVevfIWJdQnjFz6l8RrSgKjgA5mb
         l0jTr0Vd1DfuBJzhajfHxNR1bKUs6Lq/hXbPH/tHyr5pZ+XiHJPFmB6BKXmd9uAPkSTt
         VCo/iqiNzCTeNGPd/IQrfCbzegNKym5AqfjjqBUiYKgKnlZ9cgFP2Zn+QP/F7hnQGX1h
         38TRWe0xZvw/58iiGuVR+gNj/Pa4pzua3bT0zChkr7ZtNJHk2zlOQz2lZnDEYUnNh0+Z
         GthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZGsHfCz0vcFr7tUGQ1YmYn/WTXvbxQ/j0IzGjWxyxBw=;
        b=6Z4qit8RoehYSIqPx0xxwIXRGzK77PzrW3MJ0DzFadem7dZu9eX8wa7Ygn2q4VFqbP
         XAqiadDW5C6UgwCgvlXi2cZMxZrUQuByjxoU+1Gp8g4SGdxGDrdJEuWir5+j6YpW2ZJs
         +kOum9bSvDiA2p62VfZxNBjBQBxfHbqdZg5Esm7mkhG/zN+rCc4E3ZLUz8hvYfpXLfcS
         1Iw3VmnGFce+C7UyP1ildu5cr3Qn6lYQ+7ByQQjpg+t+8j6OGjJMsNc6qMgwfjAHX1Am
         ltYayRwWWX96gcmBC/e4Ll8tNd3XgHHCT6mgH/IExQl6vcghPPeCRpQcU0mJrJlvUR5S
         3Naw==
X-Gm-Message-State: ACrzQf1hGgKB/86rhxYVS/iiKT1cZ9Ru97jsppp6+438nRHtzVv4zSzY
        n4ev4WyAhK8NyavMWN5TFbMcdA==
X-Google-Smtp-Source: AMsMyM50XCi7LDTMNO4C0MWoUV/IYyF9t3ZMdSltCTg0JhEoxE8L1v+wfcY/UTC7XDhMwKaC5HYxNQ==
X-Received: by 2002:a05:6820:1505:b0:476:994:186e with SMTP id ay5-20020a056820150500b004760994186emr4276566oob.28.1663968587374;
        Fri, 23 Sep 2022 14:29:47 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t23-20020a056870609700b0012c21a64a76sm5230776oae.24.2022.09.23.14.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 14:29:46 -0700 (PDT)
Date:   Fri, 23 Sep 2022 14:29:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Keith Busch <kbusch@kernel.org>
cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] sbitmap: fix lockup while swapping
In-Reply-To: <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
Message-ID: <391b1763-7146-857-e3b6-dc2a8e797162@google.com>
References: <aef9de29-e9f5-259a-f8be-12d1b734e72@google.com> <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com>
 <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 23 Sep 2022, Keith Busch wrote:

> Does the following fix the observation? Rational being that there's no reason
> to spin on the current wait state that is already under handling; let
> subsequent clearings proceed to the next inevitable wait state immediately.

It's running fine without lockup so far; but doesn't this change merely
narrow the window?  If this is interrupted in between atomic_try_cmpxchg()
setting wait_cnt to 0 and sbq_index_atomic_inc() advancing wake_index,
don't we run the same risk as before, of sbitmap_queue_wake_up() from
the interrupt handler getting stuck on that wait_cnt 0?

> 
> ---
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 624fa7f118d1..47bf7882210b 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -634,6 +634,13 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  
>  	*nr -= sub;
>  
> +	/*
> +	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> +	 * callers can see valid wait_cnt in old waitqueue, which can cause
> +	 * invalid wakeup on the old waitqueue.
> +	 */
> +	sbq_index_atomic_inc(&sbq->wake_index);
> +
>  	/*
>  	 * When wait_cnt == 0, we have to be particularly careful as we are
>  	 * responsible to reset wait_cnt regardless whether we've actually
> @@ -660,13 +667,6 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  	 * of atomic_set().
>  	 */
>  	smp_mb__before_atomic();
> -
> -	/*
> -	 * Increase wake_index before updating wait_cnt, otherwise concurrent
> -	 * callers can see valid wait_cnt in old waitqueue, which can cause
> -	 * invalid wakeup on the old waitqueue.
> -	 */
> -	sbq_index_atomic_inc(&sbq->wake_index);
>  	atomic_set(&ws->wait_cnt, wake_batch);
>  
>  	return ret || *nr;
> --
