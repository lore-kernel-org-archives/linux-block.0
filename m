Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06EC43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4D2086B
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 20:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="pKeDYJBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeK1HzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:55:19 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38042 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeK1HzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 02:55:18 -0500
Received: by mail-yw1-f65.google.com with SMTP id i20so9753641ywc.5
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 12:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8EayIIQWTFx0c37zWInHhP6HleJro5a8LupDFmxjB0=;
        b=pKeDYJBv2gbVoklzE6z8yMA0To5dT4sn5karSi/DmNZkxtnq/VlAL+HJM1Y4QcIgPM
         YzQtrxD9JPj2PPdNeKvZUdIUq3goWlacexWDbhzpbf0gSxUGGx5ciW2h4jdUe4ecGAhR
         Eb9FBYjvV8hBiS4Q8UiiWq36Q9qXbOm0S5b5isV3OUIxvsWeW2ov52gM0+w3jQ9iIz8Q
         RAiXt4Nurnhn0fwHs3M8Mc9ZOCe+7xzWV1fVjYDs3fdg/OqUph3Wdys8NFy1rdm0J0uo
         syo+wmDtlJzukrs7iAGUjyHpUwunL/F0+BueBXMgz0SC1VmIxBbVE8wdu5ao+07hPj0e
         Vh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8EayIIQWTFx0c37zWInHhP6HleJro5a8LupDFmxjB0=;
        b=Hbk89odKrSl9vP04V9UxWyjNfv5UQUPlCOvZnJ6kb7WtUygjtYsiCrzcocnLeQHwR3
         p9DXmENdJ9+Inp4eA+3E41uvRu9wTT2hnGxrKEvgXNbUijoVASjJh5L6zF4/Cy9qkHkJ
         A+IXVGAizj7lHW8MV34ddhsD3eiNn1HuqdNLpfDzVXZJBbaJVaGO0R3naAWOjSjM//go
         S5jv6EDZksV28bV05A1hpEF0gBd/DS3AMhP5JgKqq/L143uVhdGtVc51brXeSBESQHiy
         KPM38HEW9q1+GpyEQz6oQqWsdLeVo0jMR/cx9EqEIz7Km/gMemvqta9p73PcG31YJNCd
         ytCw==
X-Gm-Message-State: AA+aEWZbqpbyu4vJcWPALm4XGwsHT9x04WBT6FldhztuDUe8vbBcTseq
        yAEvT23nTkOLu7JexTtU0pmLZxthULsAAw==
X-Google-Smtp-Source: AFSGD/W0bKyed0AjabxO0fdpq/hC6lkj+e6gb/m/2k0fG0hUHuHSKpeEQWPnDZ9MK4kMDpLVqRzqWQ==
X-Received: by 2002:a81:3d12:: with SMTP id k18mr22364334ywa.38.1543352169518;
        Tue, 27 Nov 2018 12:56:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id k80sm1370680ywe.61.2018.11.27.12.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:56:08 -0800 (PST)
Date:   Tue, 27 Nov 2018 15:56:07 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] blkcg: update blkg_lookup_create() to do locking
Message-ID: <20181127205606.762oz6kaoe2kfexv@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-3-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-3-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:35PM -0500, Dennis Zhou wrote:
> To know when to create a blkg, the general pattern is to do a
> blkg_lookup() and if that fails, lock and do the lookup again, and if
> that fails finally create. It doesn't make much sense for everyone who
> wants to do creation to write this themselves.
> 
> This changes blkg_lookup_create() to do locking and implement this
> pattern. The old blkg_lookup_create() is renamed to
> __blkg_lookup_create().  If a call site wants to do its own error
> handling or already owns the queue lock, they can use
> __blkg_lookup_create(). This will be used in upcoming patches.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---
>  block/blk-cgroup.c         | 30 +++++++++++++++++++++++++++---
>  block/blk-iolatency.c      |  2 +-
>  include/linux/blk-cgroup.h |  4 +++-
>  3 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 63d226a084cd..b1ec98eeeae0 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -249,7 +249,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>  }
>  
>  /**
> - * blkg_lookup_create - lookup blkg, try to create one if not there
> + * __blkg_lookup_create - lookup blkg, try to create one if not there
>   * @blkcg: blkcg of interest
>   * @q: request_queue of interest
>   *
> @@ -262,8 +262,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
>   * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
>   * dead and bypassing, returns ERR_PTR(-EBUSY).
>   */
> -struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> -				    struct request_queue *q)
> +struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
> +				      struct request_queue *q)
>  {
>  	struct blkcg_gq *blkg;
>  
> @@ -293,6 +293,30 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
>  	}
>  }
>  
> +/**
> + * blkg_lookup_create - find or create a blkg
> + * @blkcg: target block cgroup
> + * @q: target request_queue
> + *
> + * This looks up or creates the blkg representing the unique pair
> + * of the blkcg and the request_queue.
> + */
> +struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
> +				    struct request_queue *q)
> +{
> +	struct blkcg_gq *blkg = blkg_lookup(blkcg, q);
> +
> +	if (unlikely(!blkg)) {
> +		spin_lock_irq(&q->queue_lock);
> +
> +		blkg = __blkg_lookup_create(blkcg, q);
> +
> +		spin_unlock_irq(&q->queue_lock);

No extra spaces here please, otherwise you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
