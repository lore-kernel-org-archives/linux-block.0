Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4891C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 15:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiJSPbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiJSPbh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 11:31:37 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF34E27B1F
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 08:24:32 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id l145so1699957ybl.0
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a50Sl6Y7oXbp/PbRU6wwFOKAQcgLlChD+njiyUUoAVM=;
        b=h70JsGS/Zoz8vPmb1ANnoBkMX44g+sxyVOW52S1JD2OZF2n48IxQu5ncLP3M8qRf/h
         xDBej6UyND7l7rJPQ8i9fjPeQEpcHRKWWQE1+bH9XElFOLZ5VatiL4lNG2FwKSNdP560
         UYsXdOZbEIAM94O26kGuqZxoT4hZVPt8WjSVB6BF48sajh5wk3DWAEfEhO1zWv8OgvSG
         x5K1KidB/krzoG80jSGgoN5JaW9/bc4oE5mUIzLWa+300n71CLDvV3Z0ji7UmGh6gGEQ
         hRtYYmCzt/S+xdVfTpf5t5lqDUw4nzl8f7GrpR1bpF3IjVcv6ULWT13ehDh+rL+2OLGA
         IeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a50Sl6Y7oXbp/PbRU6wwFOKAQcgLlChD+njiyUUoAVM=;
        b=2f+B4kXEWa8OOu/QKhv7v6O/UFKUY2nAgn/NYKRXS6puxNqU5HpcQlkEG+Kl3/OGuM
         mmBqAFa5hacQXcuawdqN0ktgCBKJFvfDSLGwLILK7lYcQhXqqcix6UTf/4qruon+AgZN
         Qa3zj07V11A6Z7WPIzoIeD0lFi8kQx3TYoWhVezMjv/3tegeCSHN2aELl8mSB9p9P7H5
         w37T3j0KMZU+fqrOwouh0I9TzFB81t4W2oQY1poBvxeQTpC1hoFNrgqVdFtjCYf1kOK6
         6UOnXhD2E/EP1HbPHTIv1JUTGt/f5cAP3BvDnYdu4fnmD8uHsAfJw1gzPgFtBZb1Sevb
         AbMA==
X-Gm-Message-State: ACrzQf28ROMuJEemEo+LeT51XN71KhT329r33k1HHc5bnVLMQdCgCiQV
        EVrxRUh/QeUtGE/Tr+kPxvz6Xb9hm4nG2w==
X-Google-Smtp-Source: AMsMyM6B5kzgMH+hjBQB6K/IjDP4ra47FP0SDKRR1abufpFyGdTGCrUkGGL0gb5vu740LTrzGbEJww==
X-Received: by 2002:a05:6830:3703:b0:65f:c2ff:c526 with SMTP id bl3-20020a056830370300b0065fc2ffc526mr4166999otb.302.1666192109330;
        Wed, 19 Oct 2022 08:08:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w15-20020a9d70cf000000b00661abb66319sm7067181otj.37.2022.10.19.08.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:08:29 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:08:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 6.0 517/862] sbitmap: Avoid leaving waitqueue in invalid
 state in __sbq_wake_up()
In-Reply-To: <20221019083312.840347737@linuxfoundation.org>
Message-ID: <9edd6656-e1af-e1fa-123a-115c3ba7b1ae@google.com>
References: <20221019083249.951566199@linuxfoundation.org> <20221019083312.840347737@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 19 Oct 2022, Greg Kroah-Hartman wrote:

> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 48c033314f372478548203c583529f53080fd078 ]
> 
> When __sbq_wake_up() decrements wait_cnt to 0 but races with someone
> else waking the waiter on the waitqueue (so the waitqueue becomes
> empty), it exits without reseting wait_cnt to wake_batch number. Once
> wait_cnt is 0, nobody will ever reset the wait_cnt or wake the new
> waiters resulting in possible deadlocks or busyloops. Fix the problem by
> making sure we reset wait_cnt even if we didn't wake up anybody in the
> end.
> 
> Fixes: 040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
> Reported-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20220908130937.2795-1-jack@suse.cz
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I have no authority on linux-block, but I'll say NAK to this one
(and 479/862), and let Jens and Jan overrule me if they disagree.

This was another of several 6.1-rc1 commits which had given me lost
wakeups never suffered before; was not tagged Cc stable; and (unless I've
missed it on lore) never had AUTOSEL posted to linux-block or linux-kernel.

Hugh

> ---
>  lib/sbitmap.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1f31147872e6..bb1970ad4875 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -605,6 +605,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  	struct sbq_wait_state *ws;
>  	unsigned int wake_batch;
>  	int wait_cnt;
> +	bool ret;
>  
>  	ws = sbq_wake_ptr(sbq);
>  	if (!ws)
> @@ -615,12 +616,23 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  	 * For concurrent callers of this, callers should call this function
>  	 * again to wakeup a new batch on a different 'ws'.
>  	 */
> -	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> +	if (wait_cnt < 0)
>  		return true;
>  
> +	/*
> +	 * If we decremented queue without waiters, retry to avoid lost
> +	 * wakeups.
> +	 */
>  	if (wait_cnt > 0)
> -		return false;
> +		return !waitqueue_active(&ws->wait);
>  
> +	/*
> +	 * When wait_cnt == 0, we have to be particularly careful as we are
> +	 * responsible to reset wait_cnt regardless whether we've actually
> +	 * woken up anybody. But in case we didn't wakeup anybody, we still
> +	 * need to retry.
> +	 */
> +	ret = !waitqueue_active(&ws->wait);
>  	wake_batch = READ_ONCE(sbq->wake_batch);
>  
>  	/*
> @@ -649,7 +661,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  	sbq_index_atomic_inc(&sbq->wake_index);
>  	atomic_set(&ws->wait_cnt, wake_batch);
>  
> -	return false;
> +	return ret;
>  }
>  
>  void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
> -- 
> 2.35.1
> 
> 
> 
> 
