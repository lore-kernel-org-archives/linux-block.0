Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB5C10F14
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46D8205ED
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HraNh7Hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDSCpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:45:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCpK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 22:45:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so5348190wrl.1
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MHoclruLBeb8ynRH/D7AJwrTwSppsg0v0YPIUM+s0s=;
        b=HraNh7Hq/ETp56L+gl3L/BSTCcR7wzc9kLu+ZVhf9kYdHIQSWHHEuFfH9Ncvg5MFTA
         rtXPaiIRk4M/BA2/iVZbBgDNzgVcWHGoSO6NzlaIC1u5a5ZAa59p5mMsd729lf3Y1W1U
         Jtn8Nx6+q3RTMUm8/gkZnXBpqXZfwNKKVDP5uKN+Vk1b178uw6t10OgnDCR6Fq04gsfL
         yEjdz+tjMgmLk2s1xIZgG1F2xN7aoX8IYwqcTl9TW4PgXVdhhAVvsh9Om9NVWnn2Yd/y
         eoafe5xWHJksPjWDucWZK2pdrXsZZx+/Pqnmf8/HCwpo35e75EJZAb2ms7QYb6PsP5Nb
         GTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MHoclruLBeb8ynRH/D7AJwrTwSppsg0v0YPIUM+s0s=;
        b=fXMbNx/CX8GJffiMNMKzr3gj5VjPDmT673Lyirpl7g5gdkvr7gxKA9B0wEYfDwqGHq
         z+U9BohanvoA4VQ8CQgaXfGusc+VPqa/AyS6Z5ahmuzXrUuF8FPu2I7P1IGglvOI6/nm
         hDwQISu6WZ8+Wik4nZ/SzgI3IRKUkmIXJ2dHxi1WE1clDKRBNPSMMRNLdijGHkghvHi5
         OEecVhBwLDV7YSfuMcBCbcfjQHtgT3ntwP0k6xLtiUzbrvC3+t5UYddr0EoFlRtdrV18
         3E/mfIHEVBs9apZJghb9NhX+nOCSn6AgUDJ6ZpeSiCUxXyCoV1jVP6hVg84BuDokoH8X
         Fq7w==
X-Gm-Message-State: APjAAAV4trvL0kwTsh1imfUCXl306m2mxbgcUS5v0rd4cIyMHOLrWg45
        50l2iWbWzbVp0Cj9UmB9lOo9+8xj0DzVhnAYsY0=
X-Google-Smtp-Source: APXvYqyA2oV+dwBI0e0MKbW867Cgm71YzIsToNzuISWokPYCQwxSqYPD+ypf+tgroUIBvYCovwq0rdF/+2pEW5Sc1WQ=
X-Received: by 2002:adf:b60a:: with SMTP id f10mr970028wre.116.1555641909044;
 Thu, 18 Apr 2019 19:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190419023127.71085-1-houtao1@huawei.com>
In-Reply-To: <20190419023127.71085-1-houtao1@huawei.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 19 Apr 2019 10:44:57 +0800
Message-ID: <CACVXFVMWDq1hCnpHi2UJxxqd-vL0_a+HwGSxF4cqkEcCG_KLpg@mail.gmail.com>
Subject: Re: [PATCH] block: kill all_q_node in request_queue
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 19, 2019 at 10:42 AM Hou Tao <houtao1@huawei.com> wrote:
>
> all_q_node has not been used since commit 4b855ad37194 ("blk-mq: Create
> hctx for each present CPU"), so remove it.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/blkdev.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5c58a3b2bf00..317ab30d2904 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -548,7 +548,6 @@ struct request_queue {
>         struct rcu_head         rcu_head;
>         wait_queue_head_t       mq_freeze_wq;
>         struct percpu_ref       q_usage_counter;
> -       struct list_head        all_q_node;
>
>         struct blk_mq_tag_set   *tag_set;
>         struct list_head        tag_set_list;
> --
> 2.16.2.dirty
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
