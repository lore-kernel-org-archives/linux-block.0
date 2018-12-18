Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F15EC43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D5621850
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g5JXItjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeLRRsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:48:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54338 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeLRRsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:48:38 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so5455270ita.4
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=uwoKdaEd9lQZngGotbLjWtqT8BNX3aoI7jvE58WsIJs=;
        b=g5JXItjMFyvQygMKodNGwCpxvX1AJD51GbmdEcK5dwjIPc+VKumx9lnrKvys81JE1k
         A1dA6DXFKVk3X8wVgZK8TKQDMPSA70iEsoRfA2oR03RvAhfqDGEi+3smKuUaa08Sxv+U
         sFImuWzMUPdbijkoOQhFqd/ZlAdsiifrxCiV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=uwoKdaEd9lQZngGotbLjWtqT8BNX3aoI7jvE58WsIJs=;
        b=Z0Du4XDNlucOhLhF+1cesKB7xfq/wdr3+P3xcY83kcEd76Q/GLyyLnyvvTPs4cPFL/
         a3aVnTpAWw+XGjia9+8gopZY/rNeq1EEo3c1XquEg+ca8vuRVSdOpOLLByXzkV/SqNbv
         sJdP+KmVOjIDg4Gf2ZjqJGwOSSiFwZcYrj4bt0s6QjpoMU8r9AK17mSygmxLDsABmIov
         jgYfQdrY8uJIAixLxaM7KhwUZGKwqtht0CiEWBGtOJgtJjcJWnAaD4/DeDyDaKlsY0GL
         W6kbUZLEkRr5O3GDyvMoKZ3zzXyg1QGlgM2bu2e8/3T5VGfekIHzToTHRrROCmfC9j0z
         luag==
X-Gm-Message-State: AA+aEWbtD1iQ832F8zNiOX8+jitY//K9iQaIrh3pp6Qe3Gp4yDQHBjlW
        cknXYElsa3V51z5sm6KVOwkNyrkSqfBTOGkcXiFtjg==
X-Google-Smtp-Source: AFSGD/Wf6hOEZYGjik/5fyrYJMm+aZ8LOGDSGLTjWYGr3xKrv3XI/wVUTsf/umtliMXyOoeKEjgATCLy5qAISkHiJ6Q=
X-Received: by 2002:a02:b424:: with SMTP id i33mr17607574jaj.37.1545155317511;
 Tue, 18 Dec 2018 09:48:37 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org> <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
 <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com> <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
In-Reply-To: <9d1601bd-5b28-23f8-2a36-8fc100323422@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTtuNko6E02tULaIEHowzteDaHmgFdiSnEAolTOMIBv4s1RgHH+Rzfo8sRG6A=
Date:   Tue, 18 Dec 2018 23:18:33 +0530
Message-ID: <e5049f63c7aadd11f64b8027f352a014@mail.gmail.com>
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

>
> On 12/18/18 10:08 AM, Kashyap Desai wrote:
> >>>
> >>> Other block drivers (e.g. ib_srp, skd) do not need this to work
> >>> reliably.
> >>> It has been explained to you that the bug that you reported can be
> >>> fixed by modifying the mpt3sas driver. So why to fix this by
> >>> modifying the block layer? Additionally, what prevents that a race
> >>> condition occurs between the block layer clearing
> >>> hctx->tags->rqs[rq->tag] and
> >>> scsi_host_find_tag() reading that same array element? I'm afraid
> >>> that this is an attempt to paper over a real problem instead of
> >>> fixing the root
> >> cause.
> >>
> >> I have to agree with Bart here, I just don't see how the mpt3sas use
> >> case is special. The change will paper over the issue in any case.
> >
> > Hi Jens, Bart
> >
> > One of the key requirement for iterating whole tagset  using
> > scsi_host_find_tag is to block scsi host. Once we are done that, we
> > should be good. No race condition is possible if that part is taken
> > care.
> > Without this patch, if driver still receive scsi command from the
> > hctx->tags->rqs which is really not outstanding.  I am finding this is
> > common issue for many scsi low level drivers.
> >
> > Just for example <fnic> - fnic_is_abts_pending() function has below
> > code -
> >
> >         for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
> >                 sc = scsi_host_find_tag(fnic->lport->host, tag);
> >                 /*
> >                  * ignore this lun reset cmd or cmds that do not belong
> > to
> >                  * this lun
> >                  */
> >                 if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
> > lr_sc)))
> >                         continue;
> >
> > Above code also has similar exposure of kernel panic like <mpt3sas>
> > driver while accessing sc->device.
> >
> > Panic is more obvious if we have add/removal of scsi device before
> > looping through scsi_host_find_tag().
> >
> > Avoiding block layer changes is also attempted in <mpt3sas> but our
> > problem is to convert that code common for non-mq and mq.
> > Temporary to unblock this issue, We have fixed <mpt3sas> using driver
> > internals scsiio_tracker() instead of piggy back in scsi_command.
>
> For mq, the requests never go out of scope, they are always valid. So the
> key
> question here is WHY they have been freed. If the queue gets killed, then
> one
> potential solution would be to clear pointers in the tag map belonging to
> that
> queue. That also takes it out of the hot path.

At driver load whenever driver does scsi_add_host_with_dma(), it follows
below code path in block layer.

scsi_mq_setup_tags
  ->blk_mq_alloc_tag_set
          -> blk_mq_alloc_rq_maps
                     -> __blk_mq_alloc_rq_maps

SML create two set of request pool. One is per HBA and other is per SDEV. I
was confused why SML creates request pool per HBA.

Example - IF HBA queue depth is 1K and there are 8 device behind that HBA,
total request pool is created is 1K + 8 * scsi_device queue depth. 1K will
be always static, but other request pool is managed whenever scsi device is
added/removed.

I never observe requests allocated per HBA is used in IO path. It is always
request allocated per scsi device is what active.
Also, what I observed is whenever scsi_device is deleted, associated request
is also deleted. What is missing is - "Deleted request still available in
hctx->tags->rqs[rq->tag]."

IF there is an assurance that all the request will be valid as long as hctx
is available, this patch is not correct. I posted patch based on assumption
that request per hctx can be removed whenever scsi device is removed.

Kashyap

>
> --
> Jens Axboe
