Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C2C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 12:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB52081C
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 12:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391349AbfEXMTc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 08:19:32 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44969 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391299AbfEXMTb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 08:19:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id z65so6840436oia.11
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 05:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A48UByz6j3pzrLGkPzvM30X3qSy6+3K8Bl/RjJK8BeM=;
        b=R3Hpvf4Jj9BvCQ4nxx5Idyz6WLSUL8qGp2NDHnL8AeydVMXcypg1ud3n1QDAd4RgQ5
         qob6dBXFEAihHYDlvVYs9P+1I/CI9/TcahDRfd3fxSEoF9AjPouYu9GU0xY3M8ZmHIbD
         Ye94wMgrrwsPGqgGnmpOu5kZCH9IhXf9/A9x2+4CfUHWuKHsbbybXe0I/SpF9r2D7FXb
         ACibaFtL8PGpjVshaj+Qo7oNmHWXMViVoGQxI2lV1VUEzTFzw9AmkIc+UrfLpNegy2Hl
         Gz+0KEkRpdAz1+JFQBnuYkanN59+pPvOLDp0R5U8wLk6tRltH6JR7obUx1SSCfIRCcVz
         VbzQ==
X-Gm-Message-State: APjAAAVTCx7fTvybZZUkP5hqMek1GY+l1uMrl5bcdk0KKOiiD78O+7Gt
        pd/9TngwBORLUadmFOqbS6M9f4fQdvGgBshVCEavyQ==
X-Google-Smtp-Source: APXvYqwxDqY6iylxOf0AivNykIN/m+xxUfKmxsBT1j1vZSCK3kK+bxFGoMOtW2fJbLMHVayKbhuuqMXKHIb5xsv2p50=
X-Received: by 2002:aca:5708:: with SMTP id l8mr6086312oib.68.1558700371098;
 Fri, 24 May 2019 05:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190523214939.30277-1-jpittman@redhat.com> <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 24 May 2019 08:19:20 -0400
Message-ID: <CA+RJvhyLihk0tgSG5nAVMGNgBQTPnOCv==A886L_ca3q1aqMPQ@mail.gmail.com>
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

Thanks Chaitanya for the review.  I was not sure what Jens would think
about the checkpatch warning, so I left it as it was so he could
decide.  I tried to model the value output after that old 'bio too
big' error.  Thanks again.

On Thu, May 23, 2019 at 9:17 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> I think it will be useful to print the information along with the error.
>
> Do we want to address the checkpatch warnings ?
>
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> #20: FILE: block/blk-core.c:1202:
> +               printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
>
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> #31: FILE: block/blk-core.c:1216:
> +               printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
>
> In either case,
>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> .
>
> On 5/23/19 2:49 PM, John Pittman wrote:
> > While troubleshooting issues where cloned request limits have been
> > exceeded, it is often beneficial to know the actual values that
> > have been breached.  Print these values, assisting in ease of
> > identification of root cause of the breach.
> >
> > Signed-off-by: John Pittman <jpittman@redhat.com>
> > ---
> >   block/blk-core.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 419d600e6637..af62150bb1ba 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >                                     struct request *rq)
> >   {
> >       if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq))) {
> > -             printk(KERN_ERR "%s: over max size limit.\n", __func__);
> > +             printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",
> > +                     __func__, blk_rq_sectors(rq),
> > +                     blk_queue_get_max_sectors(q, req_op(rq)));
> >               return -EIO;
> >       }
> >
> > @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct request_queue *q,
> >        */
> >       blk_recalc_rq_segments(rq);
> >       if (rq->nr_phys_segments > queue_max_segments(q)) {
> > -             printk(KERN_ERR "%s: over max segments limit.\n", __func__);
> > +             printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
> > +                     __func__, rq->nr_phys_segments, queue_max_segments(q));
> >               return -EIO;
> >       }
> >
> >
>
