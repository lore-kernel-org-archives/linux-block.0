Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92335C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 14:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 772F660FDA
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbhJOOUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237167AbhJOOUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 10:20:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91CC061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:18:44 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r19so41303377lfe.10
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pSoDhJU19HMoffYhJWbjwcdxOuKto3dXo2tN3/DI/gI=;
        b=QCuXqIHQVZqBipx+++f1KDwhmR97WTh+dbOkREButJLKezizShTE2jPxwMWMXoytqO
         rhVugJqqz/gpeSfEsRynYMjB1H3KKkr1OK+H6QD24dZd2npSBvGUsJ6MNesf4vXjOu+o
         7fyFH3WZDnMg18y4jgEc5qcST+rj/+pvgUNZTsUEWzXTrd3sVeIhuoFuzztCPu8L5KAQ
         RdkiueiyKx5ksekTFtPnoZKJn5Lpnkt/Y5jxWAPrZVPhCMvrPMr/Zlv7C5jwYIbwRj7c
         P7olvmMoMHyywuCkmV86S48OL8gGAnfgkyHDEISJU3eiYtbPHIBKd9IfCOoaXVo4QOge
         mRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSoDhJU19HMoffYhJWbjwcdxOuKto3dXo2tN3/DI/gI=;
        b=6YLtupGm87+eppeK51CzgwpuCbW391y7A79yMdYDBAE7S1o9j4ElrPoCwRR+DyOPKy
         o7BQ0h3ulz43fnm09yD7yttsIokfsQaRNjx9fO+OSVk94mlyk4KVh6RIvJuEqSyQAMzc
         /8klITeah3M1fkLKRoaR19wbHFmRy6RtglY37w/2d4XTbNqNeuSoSq5jm7DDomvRlvbC
         X03EWaICiwrzGAredZ95p0CLl/EOKU9WP7glTbAkw63if2bkwLisW8iJ3TAaUhCdwlmx
         IbTBVpfz/6YriPaI7tJGVDfja/CKc09jMmheYJ3vHnpyoggzVjGVJyXeH5/jhTxjz1xi
         FG0A==
X-Gm-Message-State: AOAM530pTkpeP6KT0k0UEE3hsy8goaFqY7qWsdL9QQ+FLL4N5dD9Qfdt
        D9eavF9dZFZhoVe0sX7WKjc=
X-Google-Smtp-Source: ABdhPJyAsoDgiK2K9uZ+D9dGmIHxtxE4dQxUyYYJowTqd6FJKpB8r5+8vxAlmyoYb+vVx8E+mB4gkA==
X-Received: by 2002:ac2:5f96:: with SMTP id r22mr11863747lfe.266.1634307520808;
        Fri, 15 Oct 2021 07:18:40 -0700 (PDT)
Received: from localhost (80-62-117-201-mobile.dk.customer.tdc.net. [80.62.117.201])
        by smtp.gmail.com with ESMTPSA id d9sm524356lfs.183.2021.10.15.07.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:18:40 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:18:39 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] block: only check previous entry for plug merge
 attempt
Message-ID: <20211015141839.hlc4zjtvdpl75o2a@quentin>
References: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 12:34:21PM -0600, Jens Axboe wrote:
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index f390a8753268..575080ad0617 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c

Even though the code is self-documenting, the current description on top
of this function is now outdated with this change. 

- * Determine whether @bio being queued on @q can be merged with a request
- * on %current's plugged list.  Returns %true if merge was successful,
+ * Determine whether @bio being queued on @q can be merged with the previous
+ * request on %current's plugged list.  Returns %true if merge was successful,
  * otherwise %false.

> @@ -1089,32 +1089,22 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>  {
>  	struct blk_plug *plug;
>  	struct request *rq;
> -	struct list_head *plug_list;
>  
>  	plug = blk_mq_plug(q, bio);
> -	if (!plug)
> +	if (!plug || list_empty(&plug->mq_list))
>  		return false;
>  
Regards,
Pankaj Raghav
