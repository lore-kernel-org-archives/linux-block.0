Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11926C10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8652133D
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 23:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MT6bM/DA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDIX3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 19:29:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46878 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfDIX3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 19:29:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id z17so703398qts.13
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 16:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDKs8S/NxQFSLJxSxNTCaGjwgnaZkKKjEAe46+Of4TU=;
        b=MT6bM/DAOGwi24qkU+6aDRQZeiARjRSA9SgJ8Pd4B/uNNVAMD+AN5+T2X/KI7tL6Hp
         T6+XrYP/ZvkbyssRM0yUDmI7jR28Yk470AYlNxxz/BB32GFUhO5+HDIVniY86eScw4Y+
         wuT9ydph63MpLrndkJKfYIbtYcJJwJAr0/OQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDKs8S/NxQFSLJxSxNTCaGjwgnaZkKKjEAe46+Of4TU=;
        b=J+G3lQNX+hx4zpYB8+NNIgcbZOO46j8ZrCaA3J7UoCKgLgXpnfHko6l8JKxstEXCh1
         1/1YeucJVpv8Qs9Pi8w7oCyUFPJgE3UMmZEI6gW/POkO6NUceKY6xGgCHe/P5Yg67fJi
         e97WGJilchVESV+qVVf3ku6wHCf9CE40sHb4rcSVdd2CTkt69LdSnOAWvGs9PylfOYBe
         66xEG3d3CGNN8RSywHD+sZf6iZUSPFpWv2BpeU/5U1NX4OnAO0RAnNKyMIoku0in1mT3
         Ye1eNFCqyq7MQm/X89wBgo2iHXD4O6GddYUYTI65RUAwxex5S8Ifr7BLtxNdHBjDzTp2
         hdzw==
X-Gm-Message-State: APjAAAVnfhD/po/svqddYJqvBMx6lC1EaIcxBM6LcB9+Xz/tCsUWiqws
        C8uniayKLDybPkHbUMcjOgGh7EIyI1P8fepdfNy+bw==
X-Google-Smtp-Source: APXvYqxJxNzeZ6Gg8tPU+rLsE5pdnp2fX1S9iyZYyEPTHGqNPKn/sefjboeFDJGUen+aPFk64hQGvTELbWhCpeyiL1U=
X-Received: by 2002:ac8:316b:: with SMTP id h40mr31884645qtb.39.1554852580959;
 Tue, 09 Apr 2019 16:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <1554846371-33660-1-git-send-email-jalee@purestorage.com>
 <CAJX3CthodX6+G1agGR==ZTbc6J0gg55ca+ABQ7hmy3TPT+dsDw@mail.gmail.com> <1554848074.161891.18.camel@acm.org>
In-Reply-To: <1554848074.161891.18.camel@acm.org>
From:   Jaesoo Lee <jalee@purestorage.com>
Date:   Tue, 9 Apr 2019 16:29:29 -0700
Message-ID: <CAJX3Cti2+3Wnn=pbkc9s-xgxCVw9q3EHPG04Yfasv50r=7ppQQ@mail.gmail.com>
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

Let me comment in line.

On Tue, Apr 9, 2019 at 3:14 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2019-04-09 at 14:53 -0700, Jaesoo Lee wrote:
> > When SCSI blk-mq is enabled, there is a bug in handling errors in scsi_queue_rq.
> > Specifically, the bug is not setting result field of scsi_request correctly when
> > the dispatch of the command has been failed. Since the upper layer code
> > including the sg_io ioctl expects to receive any error status from result field
> > of scsi_request, the error is silently ignored and this could cause data
> > corruptions for some applications. This commit also fixes another bug that the
> > result field is not initialized when scsi_request is allocated.
> >
> > Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
> > ---
> >  block/scsi_ioctl.c      | 1 +
> >  drivers/scsi/scsi_lib.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
> > index 533f4ae..f2d7979 100644
> > --- a/block/scsi_ioctl.c
> > +++ b/block/scsi_ioctl.c
> > @@ -723,6 +723,7 @@ void scsi_req_init(struct scsi_request *req)
> >         req->cmd = req->__cmd;
> >         req->cmd_len = BLK_MAX_CDB;
> >         req->sense_len = 0;
> > +       req->result = 0;
> >  }
> >  EXPORT_SYMBOL(scsi_req_init);
>
> What makes you think that this assignment is necessary?
>

Actually, I discovered this before fixing this bug and we might not
see this problem anymore once this bug is fixed.

Previously, since we are not setting scsi_req(req)->result in
scsi_queue_rq, I found that the application could receive another
DID_TRANSPORT_DISRUPTED host_status again if the same 'struct request'
is allocated for the IO.

Please let me know if I need to remove this change.

> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 2018967..af1488d 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1699,6 +1699,7 @@ static blk_status_t scsi_queue_rq(struct
> > blk_mq_hw_ctx *hctx,
> >                         ret = BLK_STS_DEV_RESOURCE;
> >                 break;
> >         default:
> > +               scsi_req(req)->result = DID_NO_CONNECT << 16;
> >                 /*
> >                  * Make sure to release all allocated ressources when
> >                  * we hit an error, as we will never see this command
>
> What leads you to the conclusion that (ret != BLK_STS_OK &&
> ret != BLK_STS_RESOUCE) means that there is a connectivity issue?

I found this is what we are doing for legacy queue case; I referred to
scsi_prep_return() and scsi_kill_request() code where we always
returning DID_NO_CONNECT.

However, I think proper return code handling should be something like:

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2018967..21e516e 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1699,6 +1699,10 @@ static blk_status_t scsi_queue_rq(struct
blk_mq_hw_ctx *hctx,
                        ret = BLK_STS_DEV_RESOURCE;
                break;
        default:
+               if (unlikely(!scsi_device_online(sdev)))
+                       scsi_req(req)->result = DID_NO_CONNECT << 16;
+               else
+                       scsi_req(req)->result = DID_ERROR << 16;
                /*
                 * Make sure to release all allocated ressources when
                 * we hit an error, as we will never see this command

>
> Thanks,
>
> Bart.

Thanks,

Jaesoo.
