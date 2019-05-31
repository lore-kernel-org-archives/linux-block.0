Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29081C04AB6
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 17:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069EE26D3A
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 17:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfEaReW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 May 2019 13:34:22 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35613 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfEaReW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 May 2019 13:34:22 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so9987827otk.2
        for <linux-block@vger.kernel.org>; Fri, 31 May 2019 10:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utj/Uj4MSby6j0Vey/tEtiJwbJT2t49LmNuCGAFh3QU=;
        b=Lf3K1yIY8a3iKYkAedX+5zTNrcm5IFbKDZDEetlo90RnJZIJw3CNq6wviRx/tzbyCJ
         TDxPhhw45reeS3bplRXYBbUOX3GYxfHZyqDH7SgZrk23s6aRHsqtEDvmZ3SmSmwghKq7
         APuTan8/H0YXE+zZXMS8OTG9cbQIOaUwOKsW7V8kem+ApUx8e30f4iJblPbFKmEAzmud
         BF33Ru6lj7SNl3oaKRD6yiCSW7Ys1W1wWL0znDaoSNij5fMcWDLb6Z1ytwo1qkqgfJ7a
         vBBCD1ZlTxKBoPiWbLd+S2u/VHavZpzhgdTv+MbNnl7XQ8kiKexR0lcWy4aChWC47GPN
         up3g==
X-Gm-Message-State: APjAAAXBdY0iy1IDyBq1/I7xnn1hGikyRbNzadBZFibeTJilyJxtVLVD
        /asqwhcHQnPJhZli2XhAnTw3yVfWnXjtFa3ghZqHIEUb
X-Google-Smtp-Source: APXvYqwCe4c+3J1VYAT956IDjsIA7Df28iYm0P2J0s9QYEw2+iAxhgmK9xXZ1oGB2JvHGQQxwH5P4chQRmaqSYUcyps=
X-Received: by 2002:a9d:2f41:: with SMTP id h59mr1246897otb.359.1559324061573;
 Fri, 31 May 2019 10:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190523214939.30277-1-jpittman@redhat.com> <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CA+RJvhyLihk0tgSG5nAVMGNgBQTPnOCv==A886L_ca3q1aqMPQ@mail.gmail.com> <BYAPR04MB5749C6907333D8869917774186020@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749C6907333D8869917774186020@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 31 May 2019 13:34:10 -0400
Message-ID: <CA+RJvhyTYMGKg9Hn57Y9kkPU_fysHC6jF=ZTRyULE2OWirsA3Q@mail.gmail.com>
Subject: Re: [PATCH] block: print offending values when cloned rq limits are exceeded
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "djeffery@redhat.com" <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens.  Does this patch seem reasonable?

On Fri, May 24, 2019 at 12:51 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> Let's leave it to Jens.
>
> On 5/24/19 5:19 AM, John Pittman wrote:
> > Thanks Chaitanya for the review.  I was not sure what Jens would think
> > about the checkpatch warning, so I left it as it was so he could
> > decide.  I tried to model the value output after that old 'bio too
> > big' error.  Thanks again.
> >
> > On Thu, May 23, 2019 at 9:17 PM Chaitanya Kulkarni
> > <Chaitanya.Kulkarni@wdc.com> wrote:
> >>
> >> I think it will be useful to print the information along with the error.
> >>
> >> Do we want to address the checkpatch warnings ?
> >>
> >> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> >> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> >> #20: FILE: block/blk-core.c:1202:
> >> +               printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> >>
> >> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> >> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> >> #31: FILE: block/blk-core.c:1216:
> >> +               printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> >>
> >> In either case,
> >>
> >> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> .
> >>
> >> On 5/23/19 2:49 PM, John Pittman wrote:
> >>> While troubleshooting issues where cloned request limits have been
> >>> exceeded, it is often beneficial to know the actual values that
> >>> have been breached.  Print these values, assisting in ease of
> >>> identification of root cause of the breach.
> >>>
> >>> Signed-off-by: John Pittman <jpittman@redhat.com>
> >>> ---
> >>>    block/blk-core.c | 7 +++++--
> >>>    1 file changed, 5 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/block/blk-core.c b/block/blk-core.c
> >>> index 419d600e6637..af62150bb1ba 100644
> >>> --- a/block/blk-core.c
> >>> +++ b/block/blk-core.c
> >>> @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >>>                                      struct request *rq)
> >>>    {
> >>>        if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
> >>> -             printk(KERN_ERR "%s: over max size limit.\n", __func__);
> >>> +             printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> >>> +                     __func__, blk_rq_sectors(rq),
> >>> +                     blk_queue_get_max_sectors(q, req_op(rq)));
> >>>                return -EIO;
> >>>        }
> >>>
> >>> @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >>>         */
> >>>        blk_recalc_rq_segments(rq);
> >>>        if (rq->nr_phys_segments > queue_max_segments(q)) {
> >>> -             printk(KERN_ERR "%s: over max segments limit.\n", __func__);
> >>> +             printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> >>> +                     __func__, rq->nr_phys_segments, queue_max_segments(q));
> >>>                return -EIO;
> >>>        }
> >>>
> >>>
> >>
> >
>
