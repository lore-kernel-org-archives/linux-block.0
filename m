Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F322AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB4E60F9D
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhJZKMi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhJZKMh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 06:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635243013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fzNlXBdS3jJEZwynZmSNC+43pShH53Fc4Nxf7hO6thA=;
        b=ixZXrFhBtMU1q9f14JZHVolEIxCeYHFMMt7Nnw8CcIfxiahZA0GiaY96xtRByfawm4Rmw+
        CECJApExJ0UUUz/dtXSeAyl695M+hKWQMdcHBHFO5l3sAeFc0i9udocIJWXIEBRIgWlXVO
        UYVJKHAswZHJh5RSZdwPoTCIHqv7lyI=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-qnYVXkowPVWsRMce2js0Fg-1; Tue, 26 Oct 2021 06:10:12 -0400
X-MC-Unique: qnYVXkowPVWsRMce2js0Fg-1
Received: by mail-yb1-f198.google.com with SMTP id m81-20020a252654000000b005c135d4efdeso19968128ybm.22
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 03:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fzNlXBdS3jJEZwynZmSNC+43pShH53Fc4Nxf7hO6thA=;
        b=ftgw9UPuCnp2YwiJUWZNGsH1WZYijVjXhyj+QTCS47VOsGjNaDFYu6Zbvk8QKALW8E
         JqxdtvHJhpzh3GpuhlH9yd8Q848DattaWbwtYqdgNEAt9cUNHjz3PjNuR6DqCFBPmgD8
         5Sm4qMPJwvrW9zTO3KARZ188dV9I3e9sL0cAqvzXZ84WQ90xTZz/UaUvqcIFJN1vA6Ty
         kO/vAYmMrJ1D1yjCCayyYeULMDHz/ik2D4u89sOVRkfvIjK7M80q3myZMnBz0H0C20oF
         5JT8161d3Ass5WyMaBGjsULrD4m1NkpKhVnowy0FwDuLbiqzShdXYfmgLojZPq6SuoUS
         3RNw==
X-Gm-Message-State: AOAM530apQqP7Ifu4VS1KM297pg3aWZvX8I7Cgm8Oj5wO4TP+qNwxMjc
        /UXurUht7FEjmcpSOhTATpzyrWg6aGN/2flTGZxrRkNxleuLhlbzt5wh81N0tmRkK+9ZjBMYZvZ
        3P10ghoq2Pm5CxBtTIr3JI20XM4+u6+d6CCVLlI8=
X-Received: by 2002:a25:8002:: with SMTP id m2mr1081793ybk.308.1635243012009;
        Tue, 26 Oct 2021 03:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz58R5490mPmIZ9CzqmrBp7+eLgqjZK5unR2Fm8iYzfVwxa+fZ57iMySRYJ+AiMM/cx3aGOfdRThMG3jD3uw2c=
X-Received: by 2002:a25:8002:: with SMTP id m2mr1081778ybk.308.1635243011860;
 Tue, 26 Oct 2021 03:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9w7_thDw-DN11GaoA+HH9YVAMHmrAZhi_rA24xhbTYOA@mail.gmail.com>
 <YXdWx2oDmKJBRsBa@T590>
In-Reply-To: <YXdWx2oDmKJBRsBa@T590>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 26 Oct 2021 18:10:00 +0800
Message-ID: <CAHj4cs9YqxNv0HVtjBWay6hvhPn2Q71SS+iLq+taJe=g9feKvA@mail.gmail.com>
Subject: Re: [bug report] WARNING: CPU: 109 PID: 739473 at block/blk-stat.c:218
 blk_free_queue_stats+0x3c/0x80
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        skt-results-master@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

The warning was fixed, thanks.

On Tue, Oct 26, 2021 at 9:16 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Tue, Oct 19, 2021 at 12:13:22PM +0800, Yi Zhang wrote:
> > Hello
> > Below WARNING was triggered with blktests block/001 on ppc64le/aarch64
> > during CKI tests, pls help check it, thanks.
> >
> >   Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> >             Commit: b199567fe754 - Merge branch 'for-5.16/bdev-size'
> > into for-next
> >
>
> Hello Yi,
>
> Can you try the following patch?
>
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 80943c123c3e..45143af78d90 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -589,16 +589,6 @@ void del_gendisk(struct gendisk *disk)
>          * Prevent new I/O from crossing bio_queue_enter().
>          */
>         blk_queue_start_drain(q);
> -       blk_mq_freeze_queue_wait(q);
> -
> -       rq_qos_exit(q);
> -       blk_sync_queue(q);
> -       blk_flush_integrity();
> -       /*
> -        * Allow using passthrough request again after the queue is torn down.
> -        */
> -       blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
> -       __blk_mq_unfreeze_queue(q, true);
>
>         if (!(disk->flags & GENHD_FL_HIDDEN)) {
>                 sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
> @@ -621,6 +611,18 @@ void del_gendisk(struct gendisk *disk)
>                 sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
>         pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
>         device_del(disk_to_dev(disk));
> +
> +       blk_mq_freeze_queue_wait(q);
> +
> +       rq_qos_exit(q);
> +       blk_sync_queue(q);
> +       blk_flush_integrity();
> +       /*
> +        * Allow using passthrough request again after the queue is torn down.
> +        */
> +       blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
> +       __blk_mq_unfreeze_queue(q, true);
> +
>  }
>  EXPORT_SYMBOL(del_gendisk);
>
>
>
> --
> Ming
>


-- 
Best Regards,
  Yi Zhang

