Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C1AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jul 2022 06:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiGSGxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSGxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 02:53:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEA275C8
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 23:53:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-31e45527da5so32423487b3.5
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5KxztmCmMVHIN310A4ZHMWsumpUd/uei+99VlIfECo=;
        b=g45peOwJLERlzIw9j9Qr3FglyHx1ejYM46zmBvA/t4aMhMusgrlHHP7DtNqT3w8UDx
         +nBrmbn3AeWkJLwpUK3lBY+pXw5XeerP0NGTxCjRBjj8iozdPjAL8Jci7xtIVoqKdBHL
         fEUljn0PqIWZr/hPjTugMvYwnqskDlL10SVhxZ8CnPVRvTIxBC5x8rAXgDmSAduRjwo4
         vhYvaSwgrqv7mSpvQ5A7gKQbEfS+zIX/0XYSM/O/B+apqFIO+1NiJatid+NqnQIqIo7K
         L1w3wWiR2lvJZHwarcjfbBoMYr2KyA83S8A3w/tgFxGpzA8wF+Vuh0UAE5vn24mWyr64
         ig1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5KxztmCmMVHIN310A4ZHMWsumpUd/uei+99VlIfECo=;
        b=u7FqRbGykLbmIrm9OrZg0+64k2M5AqizYlfqM1kfTTZ/ai+wnb/ixBlZR0yH/FGW0r
         eo3uou2pExAgTclF4UAYRo43qMdOTYqst1jv7XiD265b+X+YSEiHngwjbctLVXa65tqv
         Go95ppL7W5ABG4nhz9VyuIq7kUjm5oTAluGJx8ROLN5CcFgrP4aCn9dde1T7zu39pZ/q
         1IdfzYvX9K9cYYz1+Y8JztP4aHVhu1Ry05ZUESIZ56gr0ibQ+L89xSWYFVXI/NMhnGuu
         ohTKUY+mMXrKixf/NxlD8F+/+oHaVfJ9pRyWbB+lfmaNtu2wmpUszJ5oz27blw56fKlO
         cy9w==
X-Gm-Message-State: AJIora8cD0b1swwPh7/+Z3QxNKJ1iEx9xvRb8dYzup8OzKv/zB8OMdMx
        IuBK1LmzP96g6jsOyopoNDNnzwdSlYrxKx5bKQe2h385RIykqPCJ
X-Google-Smtp-Source: AGRyM1vKSBqibQJYRQ+aqUzhML96/8AsNMD0slmFOO0+vHlS3+2F8QNM4+T5y938H9dnBSoBA29EmeNpgAcZLDGPnbA=
X-Received: by 2002:a0d:ca88:0:b0:31d:c7a:6ec3 with SMTP id
 m130-20020a0dca88000000b0031d0c7a6ec3mr35667468ywd.141.1658213626831; Mon, 18
 Jul 2022 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220718083646.67601-1-hanjinke.666@bytedance.com>
In-Reply-To: <20220718083646.67601-1-hanjinke.666@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 19 Jul 2022 14:53:09 +0800
Message-ID: <CAMZfGtVLkO6T-0n7fMBTvR84Ji8GhTO5==u9v+8f+dRkJhFHMA@mail.gmail.com>
Subject: Re: [PATCH] block: don't allow the same type rq_qos add more than once
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 4:37 PM Jinke Han <hanjinke.666@bytedance.com> wrote:
>
> From: hanjinke <hanjinke.666@bytedance.com>
>
> In our test of iocost, we encounttered some list add/del corrutions of
> inner_walk list in ioc_timer_fn.
> The resean can be descripted as follow:
>
> cpu 0                                           cpu 1
> ioc_qos_write                                   ioc_qos_write
>
> ioc = q_to_ioc(bdev_get_queue(bdev));
> if (!ioc) {
>         ioc = kzalloc();                        ioc = q_to_ioc(bdev_get_queue(bdev));
>                                                         if (!ioc) {
>                                                                 ioc = kzalloc();
>                                                                 ...
>                                                                 rq_qos_add(q, rqos);
>                                                          }
>         ...
>         rq_qos_add(q, rqos);
>         ...
> }
>
> When the io.cost.qos file is written by two cpu concurrently, rq_qos may
> be added to one disk twice. In that case, there will be two iocs enabled
> and running on one disk. They own different iocgs on their active list.
> In the ioc_timer_fn function, because of the iocgs from two ioc have the
> same root iocg, the root iocg's walk_list may be overwritten by each
> other and this lead to list add/del corrutions in building or destorying
> the inner_walk list.
>
> And so far, the blk-rq-qos framework works in case that one instance for
> one type rq_qos per queue by default. This patch make this explicit and
> also fix the crash above.
>
> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>

The change LGTM. Maybe it is better to add a Fixes tag here so that
others can easily know what Linux versions should be backported.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
