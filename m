Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D676C282C0
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609022089F
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 03:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZTHg7UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfAVDWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:22:17 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54207 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfAVDWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 22:22:17 -0500
Received: by mail-wm1-f41.google.com with SMTP id d15so12675416wmb.3;
        Mon, 21 Jan 2019 19:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJ57jCHwd7NhWqt7UD6XbEjwleQOMP8p5GKXJMK3+vQ=;
        b=BZTHg7UZ951eMg4H2fXHHqGDrC1e87MAZhHF3mj3efVQLR26hvfto26jDvFsjCd5yF
         ayiz+WSvW2YE/DXg1NUCpaH5+jVBLHnun6TqU9ijkDObLo44aArMdJnUifQKY/WPkmVX
         iFenMENCRs5U0PJYxSrX+uGUOSCNNbdWdNuNPWZ88KQZZ9zJD5So73qxXu54YCgISDCC
         8Koztw2tnNG3wSSVhDft5dtpI7/fCiEUxIlIi4pjI4ZXoXfPegsXopHm7sCIkQkbSi0H
         EaEyp2FvCNEc64nSdH2j6CX/LXFR+0GSgivc66jSxzNP1a9ThYp2kbd4n7Bgc/2gV/NT
         Qd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJ57jCHwd7NhWqt7UD6XbEjwleQOMP8p5GKXJMK3+vQ=;
        b=Z/HRX5EGcemH4uUCpeAIhzpLsoBBqYIGhtUAOGHw1lokz+VEMIjMXXDKhFSDrDNjGN
         5+gdhE8dqd8uQ+eV5Tv56XXxFpbf9BrKtCQjC08T4hGrQYYFaOeSI/b+8aoPEj0D7wHW
         59x4J1wD3J9O3y7RjMYkomkd4E6secgRyWArK1/147VVZZBnP/VVN8MBflrWMZKqW0zs
         ZnEOR7WsuDnbLlzjrk8Nc1TQufiglZK3sIqP997D+GIcky7bWMRTszgPI3fUS6NwpoYB
         KDvXjWqjjt0HzF26fPuchyGlMLmbmSB+3ecMbhi8D/Z05wghkw7QPxN/1dsEuePvVmQg
         x4cA==
X-Gm-Message-State: AJcUukfPDzPPhAYfXolmlPRoc6sQlw96//r/hTkLIvLeQrz+jTwqkNCI
        vAmcYlAluc3kGROTaMNBVCoU8noCi8HCxdz5zyK4kr29CpE=
X-Google-Smtp-Source: ALg8bN4xC6rV62e98vDJv/yCXDfXe2zaVzvlYQrHYZDDrC9FDZZmYnUSV1+mbZ/EYershb6H+8sQtVTIWbWfLBgr4Qc=
X-Received: by 2002:a1c:2007:: with SMTP id g7mr1603726wmg.79.1548127334787;
 Mon, 21 Jan 2019 19:22:14 -0800 (PST)
MIME-Version: 1.0
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
In-Reply-To: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 22 Jan 2019 11:22:02 +0800
Message-ID: <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 22, 2019 at 5:13 AM Florian Stecker <m19@florianstecker.de> wrote:
>
> Hi everyone,
>
> on my laptop, I am experiencing occasional hangs of applications during
> fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS
> which spans two partitions on the same SSD (one of them used to contain
> a Windows, but I removed it and added the partition to the BTRFS volume
> instead). Also, the problem only occurs when an I/O scheduler
> (mq-deadline) is in use. I'm running kernel version 4.20.3.
>
>  From what I understand so far, what happens is that a sync request
> fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a
> "Non-NCQ command" and can not be queued together with other commands.
> This propagates up into blk_mq_dispatch_rq_list(), where the call
>
> ret = q->mq_ops->queue_rq(hctx, &bd);
>
> returns BLK_STS_DEV_RESOURCE. Later in blk_mq_dispatch_rq_list(), there
> is the piece of code
>
> needs_restart = blk_mq_sched_needs_restart(hctx);
> if (!needs_restart ||
>         (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>         blk_mq_run_hw_queue(hctx, true);
> else if (needs_restart && (ret == BLK_STS_RESOURCE))
>         blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>
> which restarts the queue after a delay if BLK_STS_RESOURCE was returned,
> but somehow not for BLK_STS_DEV_RESOURCE. Instead, nothing happens and
> fsync() seems to hang until some other process wants to do I/O.
>
> So if I do
>
> - else if (needs_restart && (ret == BLK_STS_RESOURCE))
> + else if (needs_restart && (ret == BLK_STS_RESOURCE || ret ==
> BLK_STS_DEV_RESOURCE))
>
> it fixes my problem. But was there a reason why BLK_STS_DEV_RESOURCE was
> treated differently that BLK_STS_RESOURCE here?

Please see the comment:

/*
 * BLK_STS_DEV_RESOURCE is returned from the driver to the block layer if
 * device related resources are unavailable, but the driver can guarantee
 * that the queue will be rerun in the future once resources become
 * available again. This is typically the case for device specific
 * resources that are consumed for IO. If the driver fails allocating these
 * resources, we know that inflight (or pending) IO will free these
 * resource upon completion.
 *
 * This is different from BLK_STS_RESOURCE in that it explicitly references
 * a device specific resource. For resources of wider scope, allocation
 * failure can happen without having pending IO. This means that we can't
 * rely on request completions freeing these resources, as IO may not be in
 * flight. Examples of that are kernel memory allocations, DMA mappings, or
 * any other system wide resources.
 */
#define BLK_STS_DEV_RESOURCE    ((__force blk_status_t)13)

>
> In any case, it seems wrong to me that ret is used here at all, as it
> just contains the return value of the last request in the list, and
> whether we rerun the queue should probably not only depend on the last
> request?
>
> Can anyone of the experts tell me whether this makes sense or I got
> something completely wrong?

Sounds a bug in SCSI or ata driver.

I remember there is hole in SCSI wrt. returning BLK_STS_DEV_RESOURCE,
but I never get lucky to reproduce it.

scsi_queue_rq():
        ......
        case BLK_STS_RESOURCE:
                if (atomic_read(&sdev->device_busy) ||
                    scsi_device_blocked(sdev))
                        ret = BLK_STS_DEV_RESOURCE;

All in-flight request may complete between reading 'sdev->device_busy'
and setting ret as 'BLK_STS_DEV_RESOURCE', then this IO hang may
be triggered.

Thanks,
Ming Lei
