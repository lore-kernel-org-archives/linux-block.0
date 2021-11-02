Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E177C433EF
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802AE60524
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhKBNuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhKBNuV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 09:50:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F83C061714
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 06:47:46 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p204so13953294iod.8
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYLr180cTiWjRvDNvlNKrrbZQDKddNg2j5og6m/a3Wg=;
        b=C8sgyogpb7S/zIyRNkQR8kXgB4dYl/anFHzpUCr65K0l02Z2k4Xz9zDxlxXBx55j9v
         yd3rt8fzpfIIECBwsNB3ueFkJmlHey6GwupwDBkJolafi3+JCy7tL6bLnzL8Q9dOERWY
         pixiOU+WhgOz5O5dE9/9sPl2E8YAlu7kEOuRC2DiUKPLcXQ7nBPSzgxmfkwBmQgiF82P
         Y+dWqQAW85iDmv5LfCXT8agkrE1pJ72mFOabfIB8INL0ATg9oIdBfv5/yS2mOytTHyS+
         D/RGdJ2H8RqyNVv6uYHGr1H268+nn4EF8lZdrz5WV69m2TcVYHZcjG+WlQsbaRbNQtJW
         zBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYLr180cTiWjRvDNvlNKrrbZQDKddNg2j5og6m/a3Wg=;
        b=N5j+1v7x3H6EcU4s0qyHJH+ID3d4b+MW3cIflCRrzx+FUIKg6sSWEA6tf8nvOGv/z+
         Ps8SoWhN0/Ugo8vhfOaMhVTR8ZYAZjGMqGceBA5FPh0Trh/qtm9XHIKCi3SKjUY6GB4/
         apDbRe1kkI9z4a03y43zlDktAr9/wL4TXqcCCbMhpxeiGrol0elycJy8tjbTcIN58xW2
         5zUsIIAceThAQeJwvpY/A2qsWWUA1oYIK5LVcRRR0orMFQvVYVGhyaYPHg86rRpBuA7h
         BLWeV7WvEXymasfcPSyQYmyWE7cRGZC3f6bjYgMQdfsgIxaDnAXtAwryBVs4KPdu7pp7
         gl1Q==
X-Gm-Message-State: AOAM531OvB4bNcEP3cu9dacIc7uYCK+tTMnTGOp2bftSHa87JeBhl8mH
        W3czEU29n6kOzIoku0qT32gBcBdTs69B9A==
X-Google-Smtp-Source: ABdhPJzqzv3QuaeZ98dxosnFKdCDZIblc4VN+p+04DIY9fgeQRG65VXjMdBlUNEKGBEFSoQZJtydog==
X-Received: by 2002:a5e:941a:: with SMTP id q26mr936836ioj.208.1635860865433;
        Tue, 02 Nov 2021 06:47:45 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id d5sm6314873iow.46.2021.11.02.06.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:47:45 -0700 (PDT)
Subject: Re: [PATCH 3/3] blk-mq: update hctx->nr_active in
 blk_mq_end_request_batch()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20211102133502.3619184-1-ming.lei@redhat.com>
 <20211102133502.3619184-4-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <922449db-73a7-efaf-52ef-d386edf77953@kernel.dk>
Date:   Tue, 2 Nov 2021 07:47:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211102133502.3619184-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 7:35 AM, Ming Lei wrote:
> In case of shared tags and none io sched, batched completion still may
> be run into, and hctx->nr_active is accounted when getting driver tag,
> so it has to be updated in blk_mq_end_request_batch().
> 
> Otherwise, hctx->nr_active may become same with queue depth, then
> hctx_may_queue() always return false, then io hang is caused.
> 
> Fixes the issue by updating the counter in batched way.
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: f794f3351f26 ("block: add support for blk_mq_end_request_batch()")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 15 +++++++++++++--
>  block/blk-mq.h | 12 +++++++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 07eb1412760b..0dbe75034f61 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -825,6 +825,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>  	struct blk_mq_hw_ctx *cur_hctx = NULL;
>  	struct request *rq;
>  	u64 now = 0;
> +	int active = 0;
>  
>  	if (iob->need_ts)
>  		now = ktime_get_ns();
> @@ -846,16 +847,26 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
>  		rq_qos_done(rq->q, rq);
>  
>  		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
> -			if (cur_hctx)
> +			if (cur_hctx) {
> +				if (active)
> +					__blk_mq_sub_active_requests(cur_hctx,
> +							active);
>  				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
> +			}
>  			nr_tags = 0;
> +			active = 0;
>  			cur_hctx = rq->mq_hctx;
>  		}
>  		tags[nr_tags++] = rq->tag;
> +		if (rq->rq_flags & RQF_MQ_INFLIGHT)
> +			active++;

Are there any cases where either none or all of requests have the flag set, and
hence active == nr_tags?

Apart from that, the patch looks conceptually good.

-- 
Jens Axboe

