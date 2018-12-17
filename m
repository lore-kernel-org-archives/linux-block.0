Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C3C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D7620874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XQt65IKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeLQMzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:55:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37286 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeLQMzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:55:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so4588823pgb.4
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 04:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jpUM4Wjl/vp4XdWAynTuKL5ySXeJT8yPr1Z6mxBZEeo=;
        b=XQt65IKLvsM1fGHyC5C0sfE/4ewAlI7E+Wwm6lim8xAoelgXidDeRQXEK0VmsW5EC6
         HQ5SDzZ1vg3w4XzfDeFFVJ2TZaKT24OCNQX7aoCWqUW4OsRV8dJWlYbPi7TJaq6UB/AN
         tXtvCalvS4p2/9d1sxIAj2Y1KIwfO+3zst54sGHSrbhWwP+RQJCtWlxva534n0jYR4Cl
         womBPhhaetV9HLGbMZ0DafZN9tDt9i6RR7pLb2KwazWtFnGlXZ0OIM3kzvPlcJPel7RN
         Qi0/Dedr9NBHI/CWcfvG6WG05lcfyBy0lQDygWAYAnXZOR9vPIho7b0tI/dXt6K3x8bp
         SKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jpUM4Wjl/vp4XdWAynTuKL5ySXeJT8yPr1Z6mxBZEeo=;
        b=dDQ2TcLNKMnONwxwLN1dw/vCCkqNCYlUrXUkNgg+mxlnrzINRcWiISlI5wtjAJgj+m
         CSGovS8Xg0Uz4dBH/yWSfHFl4pDyYzAfGf9IdkQJrlJRooAFZ/KWzJViake5cjjIzSII
         dtTrdzizlSxB+zSKmX5aIBSBetezWOQ5HbvMIs5k8DodNH2BFuhd1ngQ3Fy8ePtPc8T4
         bdc3MPSsQ9GWMF9/uvrNWDwi9sUO40fD9YtjnsDxsAls0k9qNx/LtCFHMOeyZ5Ry79BX
         dQGAw+CNrKDLRp9Q4IjTnQ/ccRWj8xmEv4EqGnG+C1UunwlZCrzNfmvR/FHOR8eTs61f
         Kp8g==
X-Gm-Message-State: AA+aEWZR7k4hVRGMlmnION7d1OMTbg9yhWtS900hXtIwrk3orZtE4/WW
        8UK76TiG8uG2X0fiakBAWcVfFA==
X-Google-Smtp-Source: AFSGD/VCAKdOjeEiNJaGymmiCRDdowff3uiMCMGrJOMxdy+QD8yKzlK9YJ8E5EjVr8yiUewh5PKkOw==
X-Received: by 2002:a62:e704:: with SMTP id s4mr6887396pfh.124.1545051336310;
        Mon, 17 Dec 2018 04:55:36 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a73sm20379016pfa.7.2018.12.17.04.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:55:34 -0800 (PST)
Subject: Re: [PATCH V3 3/3] blk-mq: fix dispatch from sw queue
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20181217120844.8131-1-ming.lei@redhat.com>
 <20181217120844.8131-4-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe4133ec-7dfa-255c-9c24-af448446bf23@kernel.dk>
Date:   Mon, 17 Dec 2018 05:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217120844.8131-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 5:08 AM, Ming Lei wrote:
> When requst is added to rq list of sw queue(ctx), the rq may be from
> different type of hctx, especially after multi queue mapping is introduced.
> 
> So when dispach request from sw queue via blk_mq_flush_busy_ctxs() or
> blk_mq_dequeue_from_ctx(), one request belonging to other queue type of
> hctx can be dispatch to current hctx in case that read queue or poll queue
> is enabled.
> 
> This patch fixes this issue by introducing per-queue-type list.

Looks good, just one comment:

> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d1ed096723fb..0973a91eb1dd 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -12,14 +12,16 @@ struct blk_mq_ctxs {
>  	struct blk_mq_ctx __percpu	*queue_ctx;
>  };
>  
> +struct blk_mq_ctx_list {
> +	spinlock_t		lock;
> +	struct list_head	rq_list;
> +}  ____cacheline_aligned_in_smp;
> +
>  /**
>   * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
>   */
>  struct blk_mq_ctx {
> -	struct {
> -		spinlock_t		lock;
> -		struct list_head	rq_list;
> -	}  ____cacheline_aligned_in_smp;
> +	struct blk_mq_ctx_list  list[HCTX_MAX_TYPES];

Let's not make that use 3 cachelines. There is no good reason to split
these across cachelines, if we have heavy traffic to multiple of these,
then we're not going very fast anyway. So just make it:

	struct {
		spinlock_t		lock;
		struct list_head	rq_list[HCTX_MAX_TYPES];
	}  ____cacheline_aligned_in_smp;

-- 
Jens Axboe

