Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C15C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDMMzW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMMzV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 08:55:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16EE7D
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 05:55:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5312bd34so63304b3a.0
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681390520; x=1683982520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NQkteGrfO9CLa8AVUTotpV8CaVRldZqi2vBMVGaRV7c=;
        b=E5MlOITa2UnKNIUEqOoLpYsLF6hbP9vA3hlI/qscT2IZ5B405JfOI989qIZlRh663q
         T5pcuxoVxGizylhg/aZV36YDeoGWJRUgxCYt2vWSAZanQ4oQHg37AamBxvMBr4QYnYC0
         88y3nURlu0PQAHS58JIBXiWn3NPnNcgI2G3i/54CVGCTJqUYFlWXHMxMb7+bgAsDpnwi
         LIye9oiOGm5iplPs3edSAS1McEQq17J0LLprAVidO1l5JUXhIoBgJPhs4SpMbIp6MrQv
         R2B2p5XxHo30jnJWp2KPnZM7pSvzK245wk/30Q3kKIejRAcycOGFzKnwVjLpyPCzN2UE
         qG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681390520; x=1683982520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQkteGrfO9CLa8AVUTotpV8CaVRldZqi2vBMVGaRV7c=;
        b=ShBclbO43E0+1WPK/RwOmUqZRtHHrZZGTX3kZ/qwGYNUQxAQ1XK6i8oWGtLO8dEd8H
         r744Rz+fC0yes+c/AatXcpouqmrWD2T6Xor3bZS/JEMOH0B9QBJtY5XqNIxN4WnUKtRm
         yYB13qAJS9Ok/9qgdtoyibEmjddph0ZO1oYQNhEBhWOewf3ytzFLlJ8EjA8lfdcBSiWA
         4ksIb/vUCRqh6gfgZzPJwhtJDxz3xjIj1H6aDH8siI+ubzF+u7qz0BuylRCe0dR4lP4H
         WA+iZWxEP78pJRDiCWi294WGXeHQubfca/5jWriblMV/w6Gb7pGHAC3qb8NbmX+XPZlI
         R2QQ==
X-Gm-Message-State: AAQBX9er8G7xXS4LTECHz68LyaGxbD0SUc+JD5+bXeHmW+Kr+Dn1zCo4
        K9TMG4qRs2uxfrDaZw5bF56Okw==
X-Google-Smtp-Source: AKy350bSU61ZatvfqSFXjRtqqHUVn3uSgPynNxK1o44Dm2UC1TL6kjG0myaeSh+W2ZxLEpS1KhPtlA==
X-Received: by 2002:a17:902:ec8b:b0:1a0:53ba:ff1f with SMTP id x11-20020a170902ec8b00b001a053baff1fmr3197997plg.0.1681390520350;
        Thu, 13 Apr 2023 05:55:20 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001a240f053aasm1416466pln.180.2023.04.13.05.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 05:55:20 -0700 (PDT)
Message-ID: <01f05cb1-fb29-0181-f66f-4b400fec8306@kernel.dk>
Date:   Thu, 13 Apr 2023 06:55:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/5] blk-mq: cleanup __blk_mq_sched_dispatch_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
References: <20230413060651.694656-1-hch@lst.de>
 <20230413060651.694656-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230413060651.694656-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 12:06?AM, Christoph Hellwig wrote:
> __blk_mq_sched_dispatch_requests currently has duplicated logic
> for the cases where requests are on the hctx dispatch list or not.
> Merge the two with a new need_dispatch variable and remove a few
> pointless local variables.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-sched.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 06b312c691143f..f3257e1607a00c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -271,9 +271,7 @@ static int blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
>  
>  static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  {
> -	struct request_queue *q = hctx->queue;
> -	const bool has_sched = q->elevator;
> -	int ret = 0;
> +	bool need_dispatch = false;
>  	LIST_HEAD(rq_list);
>  
>  	/*
> @@ -302,23 +300,22 @@ static int __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
>  	 */
>  	if (!list_empty(&rq_list)) {
>  		blk_mq_sched_mark_restart_hctx(hctx);
> -		if (blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) {
> -			if (has_sched)
> -				ret = blk_mq_do_dispatch_sched(hctx);
> -			else
> -				ret = blk_mq_do_dispatch_ctx(hctx);
> -		}
> -	} else if (has_sched) {
> -		ret = blk_mq_do_dispatch_sched(hctx);
> -	} else if (hctx->dispatch_busy) {
> -		/* dequeue request one by one from sw queue if queue is busy */
> -		ret = blk_mq_do_dispatch_ctx(hctx);
> +		if (!blk_mq_dispatch_rq_list(hctx, &rq_list, 0)) 

There's some trailing whitespace here. Patch 5 also doesn't seem to
apply, but I'll see what that's about and comment there if there's a
concern.

-- 
Jens Axboe

