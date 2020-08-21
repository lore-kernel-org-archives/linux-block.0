Return-Path: <SRS0=euq6=B7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4EBC433DF
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 15:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0664120578
	for <linux-block@archiver.kernel.org>; Fri, 21 Aug 2020 15:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sS2Hezml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHUPFN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUPFM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 11:05:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6780DC061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 08:05:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id s1so2002469iot.10
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oCXEIhO8enmfuquBTHpXrl5mntHYBzmrFCPEFUdX5AY=;
        b=sS2HezmllAN89PNCHFdxoh+3zxbie556jDIP4QZv70QBd6Iy/0KbmT1YUXc2+kjNwc
         v2B0IDj9D8jzFi9+E3PWmUzghHl/GsC2nxquqPpNS6nK1TwKL8guMlCG+b+bYdtGhkS2
         WjAAr5sfiLcrSMD79cIGpMohQCClUqa5riGAWTsfMTnwQXjb2yCWivMHig2jQhztGlZN
         kfXLX7R4JyUFgx/dDMZ2Cywh4Qpa88H8UwU1xKZzabYATYixX4yfP+4youtez09xrBoX
         KkFAVGlCQ0ArYSH9mgV/Xwsig1vydJTcJcfA/3YpUu5MD8IQbTJeB1HkVlpYkCGEjBOb
         LMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oCXEIhO8enmfuquBTHpXrl5mntHYBzmrFCPEFUdX5AY=;
        b=YiaL6m4byLZl7bGDbxLrNa2XPdr60wVPHMD9gwSBr+OGChCJiNW5plGFTw26PaH9lT
         rUGURk2UWjaWqnKr4whp9PYruoAFLKUTL6dF7qTkkY8IpdVi2Nasea9pHwjZoqVmiqWR
         MgttSa71O/ZmETAJt/aqwHR/DSoBIT5rwlX4XzODygv+jbih4nBpV2kP8Ksi/AX2VBkH
         SlhAU2IweaEemNCx+j6Xqr5SYtFWPeKlCwTCaoXZoIt27toC6bxCB56ch9Lp6ofc5JZs
         d6c1Plea4nv23tZlqfOc9tJhuWYUI9bAbZzA7CLUP9ES2RmR4s7us2ZN1Q+JdCtW/S7w
         ipcg==
X-Gm-Message-State: AOAM533aRmXW3BrLMOVyVI4smP5WpU4nU2kg5EJ88YnGDk7zetoNj6xK
        DTqYrZUuGKBVj1aUXIA1OFHB2g==
X-Google-Smtp-Source: ABdhPJzMJYnTUMg0svXWw9SZg/uh1ry3LZbP9NkYF0XGYKwJtIASIHJe/yT8xJkl1tce6OFozcQv7g==
X-Received: by 2002:a5d:88da:: with SMTP id i26mr2669241iol.158.1598022310733;
        Fri, 21 Aug 2020 08:05:10 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f18sm1382182ilj.24.2020.08.21.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:05:10 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20200820030248.2809559-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdada1a7-2460-7067-d42f-a6dfa94ddaee@kernel.dk>
Date:   Fri, 21 Aug 2020 09:05:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820030248.2809559-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/20 9:02 PM, Ming Lei wrote:
> @@ -699,24 +696,21 @@ void blk_mq_complete_request(struct request *rq)
>  }
>  EXPORT_SYMBOL(blk_mq_complete_request);
>  
> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> +static void hctx_unlock(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
>  		rcu_read_unlock();
>  	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> +		percpu_ref_put(&hctx->queue->dispatch_counter);
>  }
>  
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> -	__acquires(hctx->srcu)
> +static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
>  {
>  	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
>  		rcu_read_lock();
> +		return true;
>  	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> +		return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
>  }

I don't mind the !flags checking, since this is (by far) the hot path.
I would make it look like:

static inline bool hctx_lock(struct blk_mq_hw_ctx *hctx)
{
	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
		rcu_read_lock();
		return true;
	}

	return percpu_ref_tryget_live(&hctx->queue->dispatch_counter);
}

to make that perfectly clear. You can do the same for the unlock side so
they at least look identical in terms of locking.

Not too many comments on the rest, I think this is a nice cleanup too,
and getting rid of the srcu usage is a nice win on the BLOCKING side.

-- 
Jens Axboe

