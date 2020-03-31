Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5809BC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF4D2071A
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZmmHUPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgCaOOG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:14:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40695 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCaOOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 10:14:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so26167273wro.7
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wWk4Yrept0mSEZI6KGf+NXqIHedOATOcRzI/MDQwpM=;
        b=cZmmHUPzBp3MvHQoD1lFelA9O6a5lqlh+IM5N+EMFiku8rVXWuRv+dGXFEJFLbVqZV
         9tN6Mdp2wEEhfB8N3vbsWoz4XJZFZzCaxasaej6qlF30vwbzlmls3ghtCWzWBIAjEwVC
         Jo0RRvCwsO1C9ys6im8TRsS6lHzUvc6dO2Gxk9+lPl/3CVqFyzq7OhbVDLF4uQdHUbIe
         QVNelgk3Wl17UAp1kjQiVDQk5P3x5jyaUZtvfvjYcUq/TQp3313u4pCcKxhPgeG9qCfl
         R6YQtg0atA0pGLx8Hw7bo5HiIQmfRaXLb9LPYb+0c8tsAboHeBllyZbExCYhuTIzW23B
         ueJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wWk4Yrept0mSEZI6KGf+NXqIHedOATOcRzI/MDQwpM=;
        b=OsV2KaIXANAJefZUS22jiyeDhjm0FVuPLY/aTT2RMeMqozBFW5QQxhdUFz2GqXBEuW
         APUg1DbP2yswBHCv6bzyZtg7EPC7pxamFAjXT6CdnPNvLWG0A1AmyLZumYMRXmXYad6L
         qvnPq6dQxURDOq9kr3kCiOm8l1PI44+KnxwImoirhFqX5SKkh4r131iOiwFKvWVcCHOH
         4Q2jwsmB+wOCaev7Ijb9A6lamxSE88Dc/5b6FeY6yp3oI2Wd5iK1gK+78dr01tHgVkt7
         LUjyjaDt94kYeQEWKJU4RkFYAhokez3cARZ3yVrj6hoFxEcIBnEX7QiwDBzG3QMkVYmg
         4Lng==
X-Gm-Message-State: ANhLgQ2AHxQXWBRQCOENd0XP/20/aQMD6F7e5EJxaICLgUPgYPC/UnRq
        D4eq5y81Z0/thqfOHvVZnpW/msKz9l5mkQvwAaY=
X-Google-Smtp-Source: ADFU+vsIjjp/cnq9WmdgsZufnmAgP7eDmy2MJoBW/vH5sPfR9sYga8uwHtvZFQeI0xr6XZV1swcpYL0X3eyOlj4Bse4=
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr19985554wrg.137.1585664043653;
 Tue, 31 Mar 2020 07:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com> <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com> <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com> <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com> <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com> <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
In-Reply-To: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
From:   Joshi <joshiiitr@gmail.com>
Date:   Tue, 31 Mar 2020 19:43:36 +0530
Message-ID: <CA+1E3rJV2-qig0mj9s1rVZo-iScXiPqiuLF+EDszET6vtounTw@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     Ming Lei <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ikegami,

Are you actually able to bump up the max segments with the original patch?
I did not notice the patch doing anything about NVME_MAX_SEGS, which
is set to 127 currently.

From pci.c -
/*
 * These can be higher, but we need to ensure that any command doesn't
 * require an sg allocation that needs more than a page of data.
 */
#define NVME_MAX_KB_SZ  4096
#define NVME_MAX_SEGS   127

> @@ -2193,7 +2193,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl
> *ctrl,
>
>  max_segments = min_not_zero(max_segments, ctrl-
> >max_segments);
>  blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> - blk_queue_max_segments(q, min_t(u32, max_segments,
> USHRT_MAX));
> + blk_queue_max_segments(q, min_t(u32, max_segments,
> UINT_MAX));
>  }

Since ctrl->max_segment is set to 127,  max_segments will not go beyond 127.

Thanks,

On Mon, Mar 30, 2020 at 2:46 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>
>
> On 2020/03/29 12:01, Ming Lei wrote:
> > On Sat, Mar 28, 2020 at 8:57 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
> >> Hi,
> >>
> >> On 2020/03/28 11:11, Ming Lei wrote:
> >>> On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >>>> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> >>>>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> >>>>>> On 2020/03/24 9:02, Keith Busch wrote:
> >>>>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
> >>>>>>> enough in older kernels? Which kernel did this stop working?
> >>>>>> Now I am asking the detail information to the reporter so let me
> >>>>>> update later.  That was able to use the same command script with the
> >>>>>> large data length in the past.
> >>>>> I have just confirmed the detail so let me update below.
> >>>>>
> >>>>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> >>>>> 64bit).
> >>>>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> >>>>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> >>>>> (Ubuntu 64bit).
> >>>>> So the original 20,531,712 length failure issue seems already resolved.
> >>>>>
> >>>>> I tested the data length 0x10000000 (268,435,456) and it is failed
> >>>>> But now confirmed it as failed on all the above kernel versions.
> >>>>> Also the patch fixes only this 0x10000000 length failure issue.
> >>>> This is actually even more confusing. We do not support 256MB transfers
> >>>> within a single command in the pci nvme driver anymore. The max is 4MB,
> >>>> so I don't see how increasing the max segments will help: you should be
> >>>> hitting the 'max_sectors' limit if you don't hit the segment limit first.
> >>> That looks a bug for passthrough req, because 'max_sectors' limit is only
> >>> checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> >>> like the following seems required:
> >>>
> >>> diff --git a/block/blk-map.c b/block/blk-map.c
> >>> index b0790268ed9d..e120d80b75a5 100644
> >>> --- a/block/blk-map.c
> >>> +++ b/block/blk-map.c
> >>> @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
> >>>           struct bio_vec bv;
> >>>           unsigned int nr_segs = 0;
> >>>
> >>> +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
> >>> +                       queue_max_hw_sectors(rq->q))
> >>> +               return -EINVAL;
> >>> +
> >> I have just confirmed about the max_hw_sectors checking below.
> >> It is checked by the function blk_rq_map_kern() also as below.
> >>
> >>       if (len > (queue_max_hw_sectors(q) << 9))
> >>           return -EINVAL;
> > The above check doesn't take rq->__data_len into account.
>
> Thanks for the comment and noted it.
> I have just confirmed the behavior on 5.6.0-rc7 as below.
> It works to limit the data length size 4MB as expected basically.
> Also it can be limited by the check existed below in ll_back_merge_fn().
>
>      if (blk_rq_sectors(req) + bio_sectors(bio) >
>          blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
>
> But there is a case that the command data length is limited by 512KB.
> I am not sure about this condition so needed more investigation.
>
> Regards,
> Ikegami
>


-- 
Joshi
