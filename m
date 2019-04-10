Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37EEC10F0E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1621741
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 00:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UWkdq37Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfDJACa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:02:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34542 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfDJACa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 20:02:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id k2so875829qtm.1
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLdSFW6vap/AlfW4ff+jd1l3oPHaNngIxDnrPx+vZzE=;
        b=UWkdq37Y2ej7euBtrpETD81d4b5ZQm8BH7hB5MlpoQqC/ZczOWyc1htWO8VA6inoZt
         3xsWbw1QzMygDiyJpt3bOEl32sg+W8Au8jDJZRadIj5AL5dFe2wHnUA79/l+YkF1j1JE
         NXnQNhTfEAFtym5QvEMM6Tc1GSoy8xcGI7LWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLdSFW6vap/AlfW4ff+jd1l3oPHaNngIxDnrPx+vZzE=;
        b=H//gPiAXHE8npG2WCwFVDTOmfp5Rrsy+l9fNnCa4VkRUA+o6fp8Ty5sDNVP3Q+u13z
         HqEF6B+KIbu2GyXottIn1I8P3lixLjuQNBMZ5/6MqY1wG+yZWx93d6pwfOCtR/mQdHwe
         VZ659CXlykSn/zh3UyJjMIfUDxUjmwRLuO9kcV2/Pdnq/ZCTpsKkylyNDaVtDuqT1V9a
         mrYuvMS75+s2tTJysr2Q8lQaxB7TfuLr0JjEvwDs57nu87zzRySU9vQ2Si22GPPec4/Q
         LLF3n34MhWAapI6R993yhmNZ5AWJVywa8pgeGcYJcXTKnGHr0C/qYxZ+3DQXsqWFB1l4
         TLOw==
X-Gm-Message-State: APjAAAUXG37FgGY/E+OJ/ilZG6rKugYzZTNs8i3JsV6/rY91UMowv6Cu
        sVLyfX2n7qnIa0LrxwgGF14LRWNdY8SSlWHlnprk9w==
X-Google-Smtp-Source: APXvYqzzkmlqwk/C7q2ySx2MOvXvPoU6G0H/9an5Ep07vtaHjAm+GCcl0DzXktPQlrxlDAT7fRlo59Fq6E9KfxfoJWo=
X-Received: by 2002:ac8:2684:: with SMTP id 4mr34732092qto.67.1554854548860;
 Tue, 09 Apr 2019 17:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
 <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com>
 <1554848074.161891.18.camel@acm.org> <CAJX3Cti2+3Wnn=pbkc9s-xgxCVw9q3EHPG04Yfasv50r=7ppQQ@mail.gmail.com>
 <1554853499.161891.22.camel@acm.org>
In-Reply-To: <1554853499.161891.22.camel@acm.org>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 17:02:18 -0700
Message-ID: <CAJX3CtgHxaBVQFFocNveKFL=2aDsazGG2qVd29tStAKRGwCPzw@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: set result when the command cannot be dispatched
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let me send v2 addressing your comments.

Thanks,

Jaesoo Lee.

On Tue, Apr 9, 2019 at 4:45 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2019-04-09 at 16:29 -0700, Jaesoo Lee wrote:
> > Let me comment in line.
> >
> > On Tue, Apr 9, 2019 at 3:14 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On Tue, 2019-04-09 at 14:53 -0700, Jaesoo Lee wrote:
> > > > When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
> > > > Specifically, the bug is not setting result field of scsi_request correctly when
> > > > the dispatch of the command has been failed. Since the upper layer code
> > > > including the sg_io ioctl expects to receive any error status from result field
> > > > of scsi_request, the error is silently ignored and this could cause data
> > > > corruptions for some applications. This commit also fixes another bug that the
> > > > result field is not initialized when scsi_request is allocated.
> > > >
> > > > Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
> > > > ---
> > > >  block/scsi_ioctl.c      | 1 +
> > > >  drivers/scsi/scsi_lib.c | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> > > > index 533f4ae..f2d7979 100644
> > > > --- a/block/scsi_ioctl.c
> > > > +++ b/block/scsi_ioctl.c
> > > > @@ -723,6 +723,7 @@ void scsi_req_init(struct scsi_request *req)
> > > >         req->cmd = req->__cmd;
> > > >         req->cmd_len = BLK_MAX_CDB;
> > > >         req->sense_len = 0;
> > > > +       req->result = 0;
> > > >  }
> > > >  EXPORT_SYMBOL(scsi_req_init);
> > >
> > > What makes you think that this assignment is necessary?
> > >
> >
> > Actually, I discovered this before fixing this bug and we might not
> > see this problem anymore once this bug is fixed.
> >
> > Previously, since we are not setting scsi_req(req)->result in
> > scsi_queue_rq, I found that the application could receive another
> > DID_TRANSPORT_DISRUPTED host_status again if the same 'struct request'
> > is allocated for the IO.
> >
> > Please let me know if I need to remove this change.
>
> Since SCSI LLDs have to set that result variable anyway if a request
> completes successfully I'd prefer not to add that assignment.
>
> > > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > > index 2018967..af1488d 100644
> > > > --- a/drivers/scsi/scsi_lib.c
> > > > +++ b/drivers/scsi/scsi_lib.c
> > > > @@ -1699,6 +1699,7 @@ static blk_status_t scsi_queue_rq(struct
> > > > blk_mq_hw_ctx *hctx,
> > > >                         ret = BLK_STS_DEV_RESOURCE;
> > > >                 break;
> > > >         default:
> > > > +               scsi_req(req)->result = DID_NO_CONNECT << 16;
> > > >                 /*
> > > >                  * Make sure to release all allocated ressources when
> > > >                  * we hit an error, as we will never see this command
> > >
> > > What leads you to the conclusion that (ret != BLK_STS_OK &&
> > > ret != BLK_STS_RESOUCE) means that there is a connectivity issue?
> >
> > I found this is what we are doing for legacy queue case; I referred to
> > scsi_prep_return() and scsi_kill_request() code where we always
> > returning DID_NO_CONNECT.
> >
> > However, I think proper return code handling should be something like:
> >
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 2018967..21e516e 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1699,6 +1699,10 @@ static blk_status_t scsi_queue_rq(struct
> > blk_mq_hw_ctx *hctx,
> >                         ret = BLK_STS_DEV_RESOURCE;
> >                 break;
> >         default:
> > +               if (unlikely(!scsi_device_online(sdev)))
> > +                       scsi_req(req)->result = DID_NO_CONNECT << 16;
> > +               else
> > +                       scsi_req(req)->result = DID_ERROR << 16;
> >                 /*
> >                  * Make sure to release all allocated ressources when
> >                  * we hit an error, as we will never see this command
>
> The above looks better to me than the original patch.
>
> Thanks,
>
> Bart.
