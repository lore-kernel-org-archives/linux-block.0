Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C650AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 05:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiFNFfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFNFfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 01:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 578F02935C
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655184941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gdpv0IQN8rDztJ37DpZmHyHSMHKTiRLPhoUNEIkjZ8o=;
        b=VKXguUKzKcQvlX3rQoUhRMKVEsU3zptDdwzYyEL8rgUy8Dkh6PHcWKymK2YDZIf/3+7SrK
        Nh0B4mhvIhZ3hnOMU/6p2LBBM0dC0PleZQpIfGyBXj5iWo+Zh1SvJ/bH6ZUUIKbgFJQwZP
        jv8lO6RzgiMw5P0hFfoRdJZGhyiz9wI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-hjnuDO9dMaCKX9felqkYCA-1; Tue, 14 Jun 2022 01:35:39 -0400
X-MC-Unique: hjnuDO9dMaCKX9felqkYCA-1
Received: by mail-pj1-f71.google.com with SMTP id y1-20020a17090a390100b001e66bb0fcefso7592756pjb.0
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 22:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gdpv0IQN8rDztJ37DpZmHyHSMHKTiRLPhoUNEIkjZ8o=;
        b=a78zc7EKagqNlIEZS49/RuGYXkAYOsSSFvZ2yIjDW2xhUA7rQ4I9Mnkra7W6fNzHCI
         LNBJ5lHoJbPoE4ZXzIn9YUw3Sw6/mw4eAmLeZgLk546MMKSYWs2utKoR+10mqBgYfq04
         ciiDksyP02VVrZpCl/+oc17+G9WRg6vzdDisL5iSec7k2qYXD0uSqFhLQje9t7Pdo5xd
         AZz77OyVzSzKXh5hrsHW8YLUWCPiv/sHfVgCHuxeU7Py98y23Dy2bbBqj/qxXa5du1/L
         aFKRaOC9Nii2x9FAvM3K0nWs/VCpMkevLUUiuK0Dv5kH5XuNMctDOBZbm3NEWAsMc3aj
         hjDg==
X-Gm-Message-State: AOAM5324yyK6hKBHN4+38eVkfPj0+yG9fAAEfXXXwcCJdBbrcS332G1d
        h8bOAMLbt1kgWR75s9I/Q4SvZQt7h9wWCXmCkgdMXGzwptpldar82juhkn1Erok63pUlbkrNUc+
        DEEC9upN0kA6PoAH/himCKzNdj7uGksgTy4vi5Mg=
X-Received: by 2002:a63:341:0:b0:3fc:824e:86bf with SMTP id 62-20020a630341000000b003fc824e86bfmr3051965pgd.140.1655184937833;
        Mon, 13 Jun 2022 22:35:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGudJ5XREv8F44TihPnlz/ghBHhworo5J64YHspGEpCPwBdut0h7AHhpnKpaB4pmJcElCY4osFImu9ufrz69U=
X-Received: by 2002:a63:341:0:b0:3fc:824e:86bf with SMTP id
 62-20020a630341000000b003fc824e86bfmr3051947pgd.140.1655184937517; Mon, 13
 Jun 2022 22:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8iJPnQ+zGHNTapR9HWMk9nBXUPbhYi5k-vKZf4qRmz_A@mail.gmail.com>
 <YqavC8hwLXwPVnor@T590> <CAHj4cs8y5HHYjr0FtWm1AmkEY=ZqOL4OmgzrWBEhbRpu5V8dWA@mail.gmail.com>
 <YqdIWcgnEylFuSci@T590>
In-Reply-To: <YqdIWcgnEylFuSci@T590>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 14 Jun 2022 13:35:25 +0800
Message-ID: <CAHj4cs-66nWX_8HvN4_j8QmrTKA9tXNrdfejPagaDNOzNTGs_A@mail.gmail.com>
Subject: Re: [bug report] kmemleak observed from blktests on latest linux-block/for-next
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 13, 2022 at 10:23 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Mon, Jun 13, 2022 at 09:08:11PM +0800, Yi Zhang wrote:
> > Hi Ming
> >
> > The kmemleak also can be reproduced on 5.19.0-rc2, pls try to enable
> > nvme_core multipath and retest.
> >
> > # cat /sys/module/nvme_core/parameters/multipath
> > Y
> >
>
> OK, I can understand the reason now since rqos is only removed for blk-mq queue,
> then rqos allocated for bio queue is leaked, see disk_release_mq().
>
> The following patch should fix it:

Hi Ming
The kmemleak was fixed by this change, feel free to add

Tested-by: Yi Zhang <yi.zhang@redhat.com>

>
> diff --git a/block/genhd.c b/block/genhd.c
> index 556d6e4b38d9..6e7ca8c302aa 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1120,9 +1120,10 @@ static const struct attribute_group *disk_attr_groups[] = {
>         NULL
>  };
>
> -static void disk_release_mq(struct request_queue *q)
> +static void disk_release_queue(struct request_queue *q)
>  {
> -       blk_mq_cancel_work_sync(q);
> +       if (queue_is_mq(q))
> +               blk_mq_cancel_work_sync(q);
>
>         /*
>          * There can't be any non non-passthrough bios in flight here, but
> @@ -1166,8 +1167,7 @@ static void disk_release(struct device *dev)
>         might_sleep();
>         WARN_ON_ONCE(disk_live(disk));
>
> -       if (queue_is_mq(disk->queue))
> -               disk_release_mq(disk->queue);
> +       disk_release_queue(disk->queue);
>
>         blkcg_exit_queue(disk->queue);
>
>
> Thanks,
> Ming
>


-- 
Best Regards,
  Yi Zhang

