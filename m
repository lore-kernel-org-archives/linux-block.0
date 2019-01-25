Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E9DC282C3
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99014218D9
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nte6YsOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfAYBdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:33:40 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:51954 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYBdk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 20:33:40 -0500
Received: by mail-wm1-f52.google.com with SMTP id b11so5207902wmj.1;
        Thu, 24 Jan 2019 17:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3PrFfJzPsH1K1KiPaFwGgF0/fRm4WIlvUQX7JuAjIxs=;
        b=Nte6YsOf4opIaRHe/kBGnB8gC2N/67MKgkzdSQyHdwRf+seZCzaztyxvQ4OYTbx6rW
         1C5NDrUWIGTjpH/g87/z3YRkadaC55262G0h1SQuwrWduwF8f8+QOX3JQgLSiSC53rel
         EHZy7kCnvVNHaPDlx5eRqx57trVUMGWAt5ddjPMKiKiWKCRGC+/zyZl88wR2i7r9wLsa
         txBiYcKktFHQaYJkLTHCVe+X/T/ZUTfrBu5lXR8Q5mZBRJsC+mBIWNL1Na+JI3xsra+p
         7yvKBfYsJRTuYCRkZN9le7kLHF/1Uw2Bwb1xauJi58vlO8HUToCa2E1E+mhG06VijjVx
         FFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PrFfJzPsH1K1KiPaFwGgF0/fRm4WIlvUQX7JuAjIxs=;
        b=nGCmlL9aViPhgelgH9IP6pTq+DmdOP1PiEPAtTvwHCUl5IFKmzn6gyY8N1fr8OI0Lz
         hzoM7Gl5R6aLw9nPmLWFQcbfu0C4Q7d7HMFMRDVUkqRh71qQ+ZxmqIi7YSPP6V1IOAJC
         gutR+T+6iw1lyxAxv6nJICIvTzw3Ta/pOvRQFo8G6ddS6lyjrYxmtjPif3hdKTsaj7e2
         4Yk8RAMEh7X25MpUJOTkLBoHJwqjvxVISDzp9GqRR10nbYepG+sfwV2m2vENHggcNB+m
         3yoHPsef/EBLBmcP4JGjEoKIWNlWVUCPo1Bos1xE/3h8QcjVq9aPnuhGvO31MzyNfQLF
         wRVA==
X-Gm-Message-State: AJcUukcDKixR0PYb8kpWDVArCf7a1HdlEYW7upLHvF2G1+Yo61R+ztSH
        THyI06V0u2AW6++yrjTl/lkrk8w2ynD5b5YqHTw=
X-Google-Smtp-Source: ALg8bN7gZF8i0MjlX3Dv34wVT3QTGStsQnJSBJfYhJBembM2Q5xW0+0FJRMAc1yNe86dgOCdQmPMD1VTcl9Jm5yDvNQ=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr4961560wmd.67.1548380017519;
 Thu, 24 Jan 2019 17:33:37 -0800 (PST)
MIME-Version: 1.0
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com> <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
In-Reply-To: <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 25 Jan 2019 09:33:24 +0800
Message-ID: <CACVXFVOzwaZyJFaOJw3K-FQUHeYGWNx8sPr8kqJzCV59Rd6sqg@mail.gmail.com>
Subject: Re: fsync hangs after scsi rejected a request
To:     Florian Stecker <m19@florianstecker.de>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 8:45 AM Florian Stecker <m19@florianstecker.de> wrote:
>
>
>
> On 1/22/19 4:22 AM, Ming Lei wrote:
> > On Tue, Jan 22, 2019 at 5:13 AM Florian Stecker <m19@florianstecker.de> wrote:
> >>
> >> Hi everyone,
> >>
> >> on my laptop, I am experiencing occasional hangs of applications during
> >> fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS
> >> which spans two partitions on the same SSD (one of them used to contain
> >> a Windows, but I removed it and added the partition to the BTRFS volume
> >> instead). Also, the problem only occurs when an I/O scheduler
> >> (mq-deadline) is in use. I'm running kernel version 4.20.3.
> >>
> >>   From what I understand so far, what happens is that a sync request
> >> fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a
> >> "Non-NCQ command" and can not be queued together with other commands.
> >> This propagates up into blk_mq_dispatch_rq_list(), where the call
> >>
> >> ret = q->mq_ops->queue_rq(hctx, &bd);
> >>
> >> returns BLK_STS_DEV_RESOURCE. Later in blk_mq_dispatch_rq_list(), there
> >> is the piece of code
> >>
> >> needs_restart = blk_mq_sched_needs_restart(hctx);
> >> if (!needs_restart ||
> >>          (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> >>          blk_mq_run_hw_queue(hctx, true);
> >> else if (needs_restart && (ret == BLK_STS_RESOURCE))
> >>          blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> >>
> >> which restarts the queue after a delay if BLK_STS_RESOURCE was returned,
> >> but somehow not for BLK_STS_DEV_RESOURCE. Instead, nothing happens and
> >> fsync() seems to hang until some other process wants to do I/O.
> >>
> >> So if I do
> >>
> >> - else if (needs_restart && (ret == BLK_STS_RESOURCE))
> >> + else if (needs_restart && (ret == BLK_STS_RESOURCE || ret ==
> >> BLK_STS_DEV_RESOURCE))
> >>
> >> it fixes my problem. But was there a reason why BLK_STS_DEV_RESOURCE was
> >> treated differently that BLK_STS_RESOURCE here?
> >
> > Please see the comment:
> >
> > /*
> >   * BLK_STS_DEV_RESOURCE is returned from the driver to the block layer if
> >   * device related resources are unavailable, but the driver can guarantee
> >   * that the queue will be rerun in the future once resources become
> >   * available again. This is typically the case for device specific
> >   * resources that are consumed for IO. If the driver fails allocating these
> >   * resources, we know that inflight (or pending) IO will free these
> >   * resource upon completion.
> >   *
> >   * This is different from BLK_STS_RESOURCE in that it explicitly references
> >   * a device specific resource. For resources of wider scope, allocation
> >   * failure can happen without having pending IO. This means that we can't
> >   * rely on request completions freeing these resources, as IO may not be in
> >   * flight. Examples of that are kernel memory allocations, DMA mappings, or
> >   * any other system wide resources.
> >   */
> > #define BLK_STS_DEV_RESOURCE    ((__force blk_status_t)13)
> >
> >>
> >> In any case, it seems wrong to me that ret is used here at all, as it
> >> just contains the return value of the last request in the list, and
> >> whether we rerun the queue should probably not only depend on the last
> >> request?
> >>
> >> Can anyone of the experts tell me whether this makes sense or I got
> >> something completely wrong?
> >
> > Sounds a bug in SCSI or ata driver.
> >
> > I remember there is hole in SCSI wrt. returning BLK_STS_DEV_RESOURCE,
> > but I never get lucky to reproduce it.
> >
> > scsi_queue_rq():
> >          ......
> >          case BLK_STS_RESOURCE:
> >                  if (atomic_read(&sdev->device_busy) ||
> >                      scsi_device_blocked(sdev))
> >                          ret = BLK_STS_DEV_RESOURCE;
> >
>
> OK, please tell me if I understand this right now. What is supposed to
> happen is
>
> - request 1 is being processed by the device
> - request 2 (sync) fails with STS_DEV_RESOURCE because request 1 is
> still being processed
> - request 2 is put into hctx->dispatch inside blk_mq_dispatch_rq_list *
> - queue does not get rerun because of STS_DEV_RESOURCE
> - request 1 finishes
> - scsi_end_request calls blk_mq_run_hw_queues
> - blk_mq_run_hw_queue finds request 2 in hctx->dispatch **
> - runs request 2

Right, it is one typical case if the hw queue depth is 2.

>
> However, what happens for me is that request 1 finishes earlier, so that
> ** is executed before *, and finds an empty hctx->dispatch list.
>
> At least this is consistent with what I see.
>
>  > All in-flight request may complete between reading 'sdev->device_busy'
>  > and setting ret as 'BLK_STS_DEV_RESOURCE', then this IO hang may
>  > be triggered.
>  >
>
> More accurate would be: between reading sdev->device_busy and doing
> list_splice_init(list,&hctx->dispatch) inside blk_mq_dispatch_rq_list.

Exactly.

>
> I'm not sure how the SCSI driver can do anything about this except
> returning BLK_STS_RESOURCE instead (which I guess would not be a great
> solution), as basically everything else happens inside blk-mq. Or what
> do you have in mind?

Not have a better idea yet, :-(

thanks,
Ming Lei
