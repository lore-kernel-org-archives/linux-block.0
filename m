Return-Path: <SRS0=dDIv=CZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD4C433E2
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BD621D7D
	for <linux-block@archiver.kernel.org>; Wed, 16 Sep 2020 20:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7HmLMEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIPU5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:57:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728557AbgIPU5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Sep 2020 16:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600289839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T2z0xaw4n1apOBRbxLfmZryNVeN7v7GM4po9OZNaTCM=;
        b=G7HmLMEbeS375UHnz9hiP5HQXPuquH0zqFjYYrnzeAPNIU1cWqCZ7TXsZiYo4zs/N2t9Zn
        9+Mg8v4de3r9T5EXds5lEenoZ+0iaLi5vWi54Yf6+DnZsuqyvDqtLwomVukmtvHrZJeEQJ
        ZAzUXpNoKNcqAbRlbDSe7ffQCGlmc7U=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-K7nVn61uMCqK_7Cx-9H1Fg-1; Wed, 16 Sep 2020 16:57:17 -0400
X-MC-Unique: K7nVn61uMCqK_7Cx-9H1Fg-1
Received: by mail-oi1-f199.google.com with SMTP id k7so3408217oif.22
        for <linux-block@vger.kernel.org>; Wed, 16 Sep 2020 13:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2z0xaw4n1apOBRbxLfmZryNVeN7v7GM4po9OZNaTCM=;
        b=L5cFQmkFg9ib6WFQ25leT4RuG3wrQIJi2lIQsgqtwtpMLB3sJji5lBQ+qncNVkhls5
         hGfm90Ro1ZKjtRMG98Y6+pdywzcvf6fNLBjhcowAF9TWbl++6GDRZmS6j8U0+FrQvzNo
         ncwkq+v+dR6FA8UN/bRJFw/XiBxBslErESQHNa3jIuiBTQ0Up4YPN7fHq7qpCDw8G6Aa
         S0eo65tJGC/d81cMu3iSvCWBAsYPcv7ye7SqX1DaLFgdX0xd+vBd9hr+DgXpUFJo5/WE
         s0GhZCOlswZPgQuZO1jOFi09/X1tDkH5XcDc591G8SX++njHwdDcPvlEb9HuQKZCvof6
         BysA==
X-Gm-Message-State: AOAM532nnLy5xz2fpLZOym3QUsfAHXCoB7T8rsGb4tYmzFvAOBRz3bQv
        4PhPC6e7tt7dodnqAVCT9wirRVu2+TsddIRnMmLlOWeZygfPtvtvHpwIg126uEVATYbMRub8Aj0
        CL20rEgfkw6EQM2K8/SXpKmocK9o5MGjRPxhyt7o=
X-Received: by 2002:aca:f0d:: with SMTP id 13mr4212497oip.124.1600289836608;
        Wed, 16 Sep 2020 13:57:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy79QPaJdKNXZPuSsmML+TfUxBRrig87HQvsDKJ+P7yf+qdWVgOzQ00E/BCncaMzGZCaB69ieP4jieDG3aLiY=
X-Received: by 2002:aca:f0d:: with SMTP id 13mr4212493oip.124.1600289836440;
 Wed, 16 Sep 2020 13:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200916111712.4011701-1-yuyufen@huawei.com>
In-Reply-To: <20200916111712.4011701-1-yuyufen@huawei.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Wed, 16 Sep 2020 16:57:05 -0400
Message-ID: <CA+RJvhxa4gyOOQBp7wYKxDfGWb6-xgGy68afBbEjYB00yaACaA@mail.gmail.com>
Subject: Re: [PATCH] block: remove redundant mq check
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Should we go ahead and change !q->mq_ops to !queue_is_mq(q) in
queue_attr_visible() as well in this patch?  It seems to be left over
or missed from when the queue_is_mq() helper was initially introduced.

Reviewed-by: John Pittman <jpittman@redhat.com>

On Wed, Sep 16, 2020 at 3:32 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> elv_support_iosched() will check queue_is_mq() for us. So, remove
> the redundant check to clean code.
>
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  block/elevator.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/elevator.c b/block/elevator.c
> index f0db80fec5a4..b564129a9f2d 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -616,7 +616,7 @@ int elevator_switch_mq(struct request_queue *q,
>
>  static inline bool elv_support_iosched(struct request_queue *q)
>  {
> -       if (!q->mq_ops ||
> +       if (!queue_is_mq(q) ||
>             (q->tag_set && (q->tag_set->flags & BLK_MQ_F_NO_SCHED)))
>                 return false;
>         return true;
> @@ -764,7 +764,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
>  {
>         int ret;
>
> -       if (!queue_is_mq(q) || !elv_support_iosched(q))
> +       if (!elv_support_iosched(q))
>                 return count;
>
>         ret = __elevator_change(q, name);
> --
> 2.25.4
>

