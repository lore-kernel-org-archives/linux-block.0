Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F2C433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 04:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0F76113D
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 04:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhJUEEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 00:04:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhJUEEj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 00:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634788944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zqZR5Pqksvt2mjge07Hx3CYwH+m5LT2HlaOHVqFWmbY=;
        b=NGebaCBje3XuW88bw5RwvnkkOEFgRGtYlmeQjmgmfCFBDxILjYg8g6DpPnen85Yt+cdWBE
        323ZWSNx/BpWcJQqGXgdig//zD9+DiY9xZ+Z5Xr9rsx4IxgXnS4OQb6Iez+2XDbprGe+k/
        iT1H6EVPyVtghKAlwDfEAwWFD4aHXvE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-tpeDDo4ENMGG6Fn2WxoHdQ-1; Thu, 21 Oct 2021 00:02:22 -0400
X-MC-Unique: tpeDDo4ENMGG6Fn2WxoHdQ-1
Received: by mail-yb1-f199.google.com with SMTP id h185-20020a256cc2000000b005bdce4db0easo33960307ybc.12
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 21:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqZR5Pqksvt2mjge07Hx3CYwH+m5LT2HlaOHVqFWmbY=;
        b=O1pd8YAd1oT+GPK8ngvFDbftAlQZ4OwMzyRypat2sG8F9pdcRoqt3NopA2jGb/2DdR
         ymYb/fiRnKrWFCPrsWOfk8ul/np974Ih/T3e6JEugwko1Ax5zA/JVbejp70ldoG21E+Y
         35DZK1VpYoViJVf2v+KAnmBJMo/D7yv3brzgEp5JYm5aaqkpjNKz8Kcyo6NrZOCwFFaX
         G5bchKT/wnzEIz1J9BWXFo32N6oq4GPFvDWGZs7ttEZUQQxVe8g80pFt2V/pK0kcaKmv
         gPl6VZYtZCInI3OXw3yCuyNO9zNQ4NLfILOrahecx0KAEnTDwTrkFY6YWb352Sj+DQ7f
         nbLg==
X-Gm-Message-State: AOAM530zEwI71X/s7b535Z4kcZE5qFqBupjAXquI3nBW+ksju0P+3GIA
        Hb/ynjS7gVFlkQA/+0p+qQFI4/7+PQOBg+IkDtiDg7vgo23CgsCoZEKb8Qd0wLeQmdvN6CYbVI9
        k4m8VFaf4NiaFCdO+Lf/k8BAhcuhqUwqX1aYDRaI=
X-Received: by 2002:a25:cb03:: with SMTP id b3mr3750489ybg.138.1634788941825;
        Wed, 20 Oct 2021 21:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1OqGtotGJ/jQ9wN65VpDFQc4rItzSgKvGu1fzBNWnk5U1gJ+6z7o2JZTVOIIOcb2HByX6UB08bCkOi6XMEuU=
X-Received: by 2002:a25:cb03:: with SMTP id b3mr3750466ybg.138.1634788941608;
 Wed, 20 Oct 2021 21:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs80zAUc2grnCZ015-2Rvd-=gXRfB_dFKy=RTm+wRo09HQ@mail.gmail.com>
 <1b2ac8f7-495e-abeb-80de-3d72af2ac7e0@kernel.dk>
In-Reply-To: <1b2ac8f7-495e-abeb-80de-3d72af2ac7e0@kernel.dk>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 21 Oct 2021 12:02:10 +0800
Message-ID: <CAHj4cs92yZue+HRuBHv=QWmJk11_2z2SbMJ8Xzc9jzgvbFzD-A@mail.gmail.com>
Subject: Re: [bug report] kernel BUG at block/blk-mq.c:1042!
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 10:21 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 10/19/21 8:29 PM, Yi Zhang wrote:
> > Hello
> >
> > Below issue was triggered with blktests srp/ tests during CKI run on
> > linux-block/for-next, seems it was introduced from [2], and still can
> > be reproduced with [1]
> >
> > [1] 4ff840e57c84 Merge branch 'for-5.16/drivers' into for-next [2]
> > 59d62b58f120 Merge branch 'for-5.16/block' into for-next
>
> Can you see if this helps? I don't think that check is valid anymore,
> there are plenty of cases where queuelist may not be valid just yet,
> but it doesn't mean that it's an issue for requeue. The check is
> meant to catch someone doing requeue when the request is still
> inserted.
>

Yes, the issue was fixed with this patch, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8b05a8f9bb33..a71aeed7b987 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1053,7 +1053,6 @@ void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
>         /* this request will be re-inserted to io scheduler queue */
>         blk_mq_sched_requeue_request(rq);
>
> -       BUG_ON(!list_empty(&rq->queuelist));
>         blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
>  }
>  EXPORT_SYMBOL(blk_mq_requeue_request);
>
> --
> Jens Axboe
>


-- 
Best Regards,
  Yi Zhang

