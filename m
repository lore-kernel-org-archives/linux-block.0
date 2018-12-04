Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C926AC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D12081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="StzBLaSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9D12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbeLDSSv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:18:51 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33331 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbeLDSSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 13:18:51 -0500
Received: by mail-io1-f54.google.com with SMTP id t24so14451778ioi.0
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 10:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=w3utUibT/wQw1dcCIBVOyHjVMd2llJ58gnXim0FVhvU=;
        b=StzBLaSr9dHCE93JehUdUd6g0CM4HTvtPgXO85Sj8CtMfPpAks5g28B0VxLU7RdSYQ
         OBrcKk6kUALCAG9rfKABscSokpBK69+xGoQJL0stCYeUFvNwr16+40H6muoQwNBVOmW9
         nrIyvfKaMhas4Df8qXSOixFytBwEhDtujukvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=w3utUibT/wQw1dcCIBVOyHjVMd2llJ58gnXim0FVhvU=;
        b=kpv9hUR2V6bsLHahV+Jyax9RZegxXDvIern9+whtyZDKy4lhVjLPlIfGAVyKDbGhfE
         H4ObKB5M1zo/OL4yOygvvOPC88qZOoGUtkdMEUulej6REd99Dup9TBxdkePOkd/XQOtT
         Ty0DvV6iH2IwTe/I0344tEJai1qlshVca4kcWB3aKEHHj+5lHrAc3WrYVAtZnyiG5+IJ
         Wcecvu9XlpRgWhJNy+R7mA6uElHIjpsj7thif43P7/nkrz0TwPmTS5xi+MDtrHOmgMp5
         vuCGnfM8Aq8pEuTr5hJATAejcsg1cY8rjGaPPUDtDIXg3CHJCa83O8rpv5GAoDvXxK1e
         n5NQ==
X-Gm-Message-State: AA+aEWYrjukOVKKWUDyisfi5v5beVse685wRB47+wKJsch+P+ZVL7FVc
        B1B9gZT6nqiPQ9SdF96DNR98LcuBqte3KXRMRG37qA==
X-Google-Smtp-Source: AFSGD/U3hjiTYpPChuaSJEkv4KYxuUCnp3kbh/ynbNaHXf+7YQHIOLJKIF3Gv12Qs6UAjIAbFtiMqqHhkGZZqWX6oO0=
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr17698182iof.172.1543947530225;
 Tue, 04 Dec 2018 10:18:50 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: +ADw-CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe+AF8-pkFVGJg73v0Wp7O38A+AEA-mail.gmail.com+AD4-
         +ADw-7e8e1fe2-9f91-a370-a98c-43cdad1f6e8e+AEA-acm.org+AD4-
         +ADw-d56ddf2b485c13445fff5f9c36dd3c87+AEA-mail.gmail.com+AD4- +ADw-1543943674.185366.194.camel+AEA-acm.org+AD4-
In-Reply-To: <1543943674.185366.194.camel@acm.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQEyvrdX27HdOCj1DHPKEZclYJ8CJQEQPyI2ApGcuBQCAxrAOaaFU6ww
Date:   Tue, 4 Dec 2018 23:48:48 +0530
Message-ID: <ce2cdcee7e8d8e21cc8398a882b9d6e3@mail.gmail.com>
Subject: RE: +AFs-PATCH+AF0- blk-mq: Set request mapping to NULL in blk+AF8-mq+AF8-put+AF8-driver+AF8-tag
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -----Original Message-----
> From: Bart Van Assche [mailto:bvanassche@acm.org]
> Sent: Tuesday, December 4, 2018 10:45 PM
> To: Kashyap Desai; linux-block; Jens Axboe; Ming Lei; linux-scsi
> Cc: Suganath Prabu Subramani; Sreekanth Reddy; Sathya Prakash Veerichetty
> Subject: Re: [PATCH] blk-mq: Set request mapping to NULL in
> blk_mq_put_driver_tag
>
> On Tue, 2018-12-04 at 22:17 +0530, Kashyap Desai wrote:
> > + Linux-scsi
> >
> > > > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > > > index 9497b47..57432be 100644
> > > > --- a/block/blk-mq.h
> > > > +++ b/block/blk-mq.h
> > > > @@ -175,6 +175,7 @@ static inline bool
> > > > blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
> > > >   static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx
> *hctx,
> > > >                          struct request *rq)
> > > >   {
> > > > +    hctx->tags->rqs[rq->tag] = NULL;
> > > >       blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
> > > >       rq->tag = -1;
> > >
> > > No SCSI driver should call scsi_host_find_tag() after a request has
> > > finished. The above patch introduces yet another race and hence can't
> > > be
> > > a proper fix.
> >
> > Bart, many scsi drivers use scsi_host_find_tag() to traverse max tag_id
> > to
> > find out pending IO in firmware.
> > One of the use case is -  HBA firmware recovery.  In case of firmware
> > recovery, driver may require to traverse the list and return back
> > pending
> > scsi command to SML for retry.
> > I quickly grep the scsi code and found that snic_scsi, qla4xxx, fnic,
> > mpt3sas are using API scsi_host_find_tag for the same purpose.
> >
> > Without this patch, we hit very basic kernel panic due to page fault.
> > This
> > is not an issue in non-mq code path. Non-mq path use
> > blk_map_queue_find_tag() and that particular API does not provide stale
> > requests.
>
> As I wrote before, your patch doesn't fix the race you described but only
> makes the race window smaller.
Hi Bart,

Let me explain the issue. It is not a race, but very straight issue.  Let's
say we have one scsi_device /dev/sda and total IO submitted + completed are
some number 100.
All the 100 IO is *completed*.   Now, As part of Firmware recovery, driver
tries to find our outstanding IOs using scsi_host_find_tag().
Block layer will return all the 100 commands to the driver but really those
100 commands are not outstanding. This patch will return *actual*
outstanding commands.
If scsi_device /dev/sda is not removed in OS, driver accessing scmd of those
100 commands are safe memory access.

Now consider a case where scsi_device /dev/sda is removed and driver
performs firmware recovery. This time driver will crash while accessing scmd
(randomly based on memory reused.).

Along with this patch, low level driver should make sure that all request
queue at block layer is quiesce.

If you want an example of how to use
> scsi_host_find_tag() properly, have a look at the SRP initiator driver
> (drivers/infiniband/ulp/srp). That driver uses scsi_host_find_tag()
> without
> triggering any NULL pointer dereferences.

I am not able to find right context from srp, but I check the srp code and
looks like that driver is getting scmd using scsi_host_find_tag() for live
command.

> The approach used in that driver
> also works when having to support HBA firmware recovery.
>
> Bart.
