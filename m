Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE8C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFA6218A3
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fu6MSQRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeLRSIv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:08:51 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:41086 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRSIu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:08:50 -0500
Received: by mail-io1-f65.google.com with SMTP id s22so13479242ioc.8
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=anlqaLUju00Y1MzB9rgdJz8dGoTv7VemKf0EE6JIKzg=;
        b=fu6MSQRIB2cchbtD05k/R4mQUcUm8EDIARl73nuL5QcgIfUoSrn7pvNRvZgpJKi0tg
         MVkBR6yfTPyWpyRj+PYIjjyngD6vQMNJMuq4te8CUotrN8lAk3hUIKAJeyb/k4If1G3n
         4mIiJ8y4S0J7DV+JpI1ciT5ArAHOm5Wdh2xw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=anlqaLUju00Y1MzB9rgdJz8dGoTv7VemKf0EE6JIKzg=;
        b=mhVghw7LJg5BciMJ6tr1YDH5ZInmTFLL4ESim8xpDAXBqKdpyvuL/FZONuzmMG6xkf
         g6ntO/Us7m0V7kn90cDDHRY4SGNH/ouqScNrO8Jptlsm2QVrvfc9O2Nx8LIuNkTJmGfS
         rsdEZVTnhs1QNm807QCcc72yi1+sAlahmlgMO860icogmHa/z+BM+jiopUWG9l8gh8RV
         sTQdnzJib5arkW46dep+vgVTu38WAFVbN0UPYqPnaPPArKDK/mmeAdDyytWfXnKSXhc+
         hS3QrYHjadwW8OLqfxlATAOyiCqmtjJcLDORG0WBghtEl1KzEKPofTUimdncHDHivd2t
         1bGg==
X-Gm-Message-State: AA+aEWZj6xMfh/YOJJ9VT8WBx2lDtJBelbvMt6Vh3s3DPlUUAOMBk6B4
        f9AuNn81PoNhigEpR4y2qsxnFe2crQJ6tz+gxGP4eg==
X-Google-Smtp-Source: AFSGD/XhyqYRm7bPf6XbvTi5XTlFajBeSDTJtKfCad9og38jLP7ZA2IXyomWCFNOTuvrDi1jsp7wMvt6jbVgf8JjLC8=
X-Received: by 2002:a5e:9511:: with SMTP id r17mr1963676ioj.224.1545156529631;
 Tue, 18 Dec 2018 10:08:49 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org> <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
 <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com> <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
 <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com> <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
In-Reply-To: <04e2f9e8-79fa-f1cb-ab23-4a15bf3f64cc@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTtuNko6E02tULaIEHowzteDaHmgFdiSnEAolTOMIBv4s1RgHH+RzfAtR0fm4CpRS/1qOfSVdQ
Date:   Tue, 18 Dec 2018 23:38:45 +0530
Message-ID: <a9186c0c84f31623a544d73ce9a779d6@mail.gmail.com>
Subject: RE: [PATCH V2] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 12/18/18 10:48 AM, Kashyap Desai wrote:
> >>
> >> On 12/18/18 10:08 AM, Kashyap Desai wrote:
> >>>>>
> >>>>> Other block drivers (e.g. ib_srp, skd) do not need this to work
> >>>>> reliably.
> >>>>> It has been explained to you that the bug that you reported can be
> >>>>> fixed by modifying the mpt3sas driver. So why to fix this by
> >>>>> modifying the block layer? Additionally, what prevents that a race
> >>>>> condition occurs between the block layer clearing
> >>>>> hctx->tags->rqs[rq->tag] and
> >>>>> scsi_host_find_tag() reading that same array element? I'm afraid
> >>>>> that this is an attempt to paper over a real problem instead of
> >>>>> fixing the root
> >>>> cause.
> >>>>
> >>>> I have to agree with Bart here, I just don't see how the mpt3sas
> >>>> use case is special. The change will paper over the issue in any
> >>>> case.
> >>>
> >>> Hi Jens, Bart
> >>>
> >>> One of the key requirement for iterating whole tagset  using
> >>> scsi_host_find_tag is to block scsi host. Once we are done that, we
> >>> should be good. No race condition is possible if that part is taken
> >>> care.
> >>> Without this patch, if driver still receive scsi command from the
> >>> hctx->tags->rqs which is really not outstanding.  I am finding this
> >>> hctx->tags->is
> >>> common issue for many scsi low level drivers.
> >>>
> >>> Just for example <fnic> - fnic_is_abts_pending() function has below
> >>> code -
> >>>
> >>>         for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
> >>>                 sc = scsi_host_find_tag(fnic->lport->host, tag);
> >>>                 /*
> >>>                  * ignore this lun reset cmd or cmds that do not
> >>> belong to
> >>>                  * this lun
> >>>                  */
> >>>                 if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
> >>> lr_sc)))
> >>>                         continue;
> >>>
> >>> Above code also has similar exposure of kernel panic like <mpt3sas>
> >>> driver while accessing sc->device.
> >>>
> >>> Panic is more obvious if we have add/removal of scsi device before
> >>> looping through scsi_host_find_tag().
> >>>
> >>> Avoiding block layer changes is also attempted in <mpt3sas> but our
> >>> problem is to convert that code common for non-mq and mq.
> >>> Temporary to unblock this issue, We have fixed <mpt3sas> using
> >>> driver internals scsiio_tracker() instead of piggy back in
> >>> scsi_command.
> >>
> >> For mq, the requests never go out of scope, they are always valid. So
> >> the key question here is WHY they have been freed. If the queue gets
> >> killed, then one potential solution would be to clear pointers in the
> >> tag map belonging to that queue. That also takes it out of the hot
> >> path.
> >
> > At driver load whenever driver does scsi_add_host_with_dma(), it
> > follows below code path in block layer.
> >
> > scsi_mq_setup_tags
> >   ->blk_mq_alloc_tag_set
> >           -> blk_mq_alloc_rq_maps
> >                      -> __blk_mq_alloc_rq_maps
> >
> > SML create two set of request pool. One is per HBA and other is per
> > SDEV. I was confused why SML creates request pool per HBA.
> >
> > Example - IF HBA queue depth is 1K and there are 8 device behind that
> > HBA, total request pool is created is 1K + 8 * scsi_device queue
> > depth. 1K will be always static, but other request pool is managed
> > whenever scsi device is added/removed.
> >
> > I never observe requests allocated per HBA is used in IO path. It is
> > always request allocated per scsi device is what active.
> > Also, what I observed is whenever scsi_device is deleted, associated
> > request is also deleted. What is missing is - "Deleted request still
> > available in
> > hctx->tags->rqs[rq->tag]."
>
> So that sounds like the issue. If the device is deleted and its requests
> go away,
> those pointers should be cleared. That's what your patch should do, not do
> it
> for each IO.

At the time of device removal,  it requires reverse traversing.  Find out if
each requests associated with sdev is part of hctx->tags->rqs() and clear
that entry.
Not sure about atomic traverse if more than one device removal is happening
in parallel.  May be more error prone. ?

Just wondering both the way we will be removing invalid request from array.
Are you suspecting any performance issue if we do it per IO ?

Kashyap

>
>
> --
> Jens Axboe
