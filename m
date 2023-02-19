Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F789C05027
	for <linux-block@archiver.kernel.org>; Sun, 19 Feb 2023 20:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjBSUmQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Feb 2023 15:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjBSUmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2023 15:42:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DC18B1B
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 12:42:14 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id et7so4864450edb.9
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 12:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giAV7/gwhNy6lsn+U/loCG0yOuAMaU5qkyKD3xmE17k=;
        b=TUuHlYDLBtZ2yv2ZHeroQmzOss0KNca14Lrn2YEHNtL+UYSxx0vxYoTeYYDP71J+EI
         RvhGzg5l1Ax2B6rbXBKSlz/cSgDZEIU9X54TgVDJ2D4ALDtzbCWRI4Cn/wHsdLgBNK0S
         KlIV2QtI9EAQXmr6DQvHuvgXwd4zSs69XOTFMgu+mdm4uPnqxua4qOM++srlipng8/k4
         9niuYlvks4iwVlEWP++GgV9D1wvyiDqFnkr6rscPBU4pfgEuHpsh9/U7YILu7SkpHgn4
         hdxKAuWTZ3VntjwLkwKfeLFSaZdt2YG6YhbWSYxZ3gOe8aY8zCCSsJ85gK9gr+HKxAYU
         0PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giAV7/gwhNy6lsn+U/loCG0yOuAMaU5qkyKD3xmE17k=;
        b=4oEqnUKqCwFf5he15kZNKYefS9fR4WqVTM1hqtRLDVi9EA5nOxRXDHiMQQd+tnYAFa
         +2cmwrcHPQrVRlrKLX5eut3j1k0Vc0ctmequwt4U2O3gkALK22NSOrbq+xJ1mIbH42S/
         0lkHHm6ecfFSO11az5qCWshGRzHlem9LGDWoupIJq41XKGrs9e+t8ro1yH97eEq5tGEZ
         Yf3XZgR3brKw4dehY8WyqMGMv97P+iEunJr3npenOpn9ywD8EHcb/ZEjcrl/9Jp1EBZ2
         fGvanVCB5MPK/DLG+hX89QTZ9yizMYIKRuc5bBAuDlB3SEEv7Zpt1CfKuyU9KPvWB5O6
         zCiA==
X-Gm-Message-State: AO0yUKXY8GVAHrgFclTZ1e2/4Gb18oTzeLAIm6OgwysIhZcJRFFehhtC
        /3MYPDNBNScYY4hhyyWkE6s6t1/ZaPQpv+2ESriAZDFm
X-Google-Smtp-Source: AK7set8WrzUkYOq0Rx2v1L87treeO05EyLbXzThwZJoNzNfCBvBGA9OzCOgyqcPMyoIjlo+qgGZ6wZpJMOZwAuhEblw=
X-Received: by 2002:a17:906:edd7:b0:877:747d:4a90 with SMTP id
 sb23-20020a170906edd700b00877747d4a90mr3279004ejb.14.1676839332378; Sun, 19
 Feb 2023 12:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20230203024029.48260-1-qkrwngud825@gmail.com>
In-Reply-To: <20230203024029.48260-1-qkrwngud825@gmail.com>
From:   Juhyung Park <qkrwngud825@gmail.com>
Date:   Mon, 20 Feb 2023 05:42:00 +0900
Message-ID: <CAD14+f0GyxmufByg=WLFtMdkE+jRXu03_5RNc=dnsv8nO=EYEQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: remove more NULL checks after bdev_get_queue()
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, p.raghav@samsung.com,
        kch@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

A friendly bump here.
6.3's merge window is about to begin.

Thanks, regards

On Fri, Feb 3, 2023 at 11:41 AM Juhyung Park <qkrwngud825@gmail.com> wrote:
>
> bdev_get_queue() never returns NULL. Several commits [1][2] have been made
> before to remove such superfluous checks, but some still remained.
>
> For places where bdev_get_queue() is called solely for NULL checks, it is
> removed entirely.
>
> [1] commit ec9fd2a13d74 ("blk-lib: don't check bdev_get_queue() NULL check")
> [2] commit fea127b36c93 ("block: remove superfluous check for request queue in bdev_is_zoned()")
>
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> ---
>  block/blk-zoned.c       | 10 ----------
>  include/linux/blkdev.h  |  7 +------
>  kernel/trace/blktrace.c |  6 +-----
>  3 files changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 614b575be899..fce9082384d6 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -334,17 +334,12 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
>  {
>         void __user *argp = (void __user *)arg;
>         struct zone_report_args args;
> -       struct request_queue *q;
>         struct blk_zone_report rep;
>         int ret;
>
>         if (!argp)
>                 return -EINVAL;
>
> -       q = bdev_get_queue(bdev);
> -       if (!q)
> -               return -ENXIO;
> -
>         if (!bdev_is_zoned(bdev))
>                 return -ENOTTY;
>
> @@ -391,7 +386,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>                            unsigned int cmd, unsigned long arg)
>  {
>         void __user *argp = (void __user *)arg;
> -       struct request_queue *q;
>         struct blk_zone_range zrange;
>         enum req_op op;
>         int ret;
> @@ -399,10 +393,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
>         if (!argp)
>                 return -EINVAL;
>
> -       q = bdev_get_queue(bdev);
> -       if (!q)
> -               return -ENXIO;
> -
>         if (!bdev_is_zoned(bdev))
>                 return -ENOTTY;
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b9637d63e6f0..89dd9b02b45b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1276,12 +1276,7 @@ static inline bool bdev_nowait(struct block_device *bdev)
>
>  static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  {
> -       struct request_queue *q = bdev_get_queue(bdev);
> -
> -       if (q)
> -               return blk_queue_zoned_model(q);
> -
> -       return BLK_ZONED_NONE;
> +       return blk_queue_zoned_model(bdev_get_queue(bdev));
>  }
>
>  static inline bool bdev_is_zoned(struct block_device *bdev)
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 918a7d12df8f..e5e8963d6808 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -729,14 +729,10 @@ EXPORT_SYMBOL_GPL(blk_trace_startstop);
>   **/
>  int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>  {
> -       struct request_queue *q;
> +       struct request_queue *q = bdev_get_queue(bdev);
>         int ret, start = 0;
>         char b[BDEVNAME_SIZE];
>
> -       q = bdev_get_queue(bdev);
> -       if (!q)
> -               return -ENXIO;
> -
>         mutex_lock(&q->debugfs_mutex);
>
>         switch (cmd) {
> --
> 2.39.1
>
