Return-Path: <SRS0=N2dH=5O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E3AC43331
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 03:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449A4206DB
	for <linux-block@archiver.kernel.org>; Sun, 29 Mar 2020 03:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQaDg0k6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgC2DBd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 Mar 2020 23:01:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgC2DBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 23:01:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so16782796wrs.3
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 20:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lnvHlmuRhQDgbhidJay1W7MqRCYIekQtHxcuUYunGc=;
        b=fQaDg0k6NNEydB/Vwc6ZgcOr9ajs3qeROL8o4CVMWHnZ8xb9aNMq+R8DmFxIi+lHYR
         z9UI+48eAAXCeELACJs0zfc3/2XbMcoYBq/MRMabsI76SYF8lGsrpHI0RF2BzmmTDtQ0
         g88vUde84PiGG0/JGV2A6SKI0qDUMdLJda9fee7py044DgQJrIwYqAZ3iKVSexJFCP7Z
         HQfptT23QpaPweLz6VULdPyD3RYWKET0BrCuJ+oKynRoouh+9b+1bVGnmDAukNOzjW0+
         8vyJzOiFNP59YEBKe6HcqL952a+Esa/BBPGH2AzJZu2fTv1jN6lblMsyLD8EtulwA3xP
         6KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lnvHlmuRhQDgbhidJay1W7MqRCYIekQtHxcuUYunGc=;
        b=bR/4QElP8c2Y0Dq4AiCBbIaZDVYS7Tc814CISAmIH9w0rH2IaXN5dDAKkwhR05h6+G
         uJUN5gK43D3/Se6Nn28PDTM6GCmf0HtvtzUn3CC/dy70LoMOjxWSXsT79tZD4utjyCO3
         md9Vxs5xh/WZHwF81kxrtA6EM/dJVIlItbJDhprZtaiKCmQUwK8A4hztFPB3OJbaDk0Z
         jZ/MTpLgtVRTfY793fcjBvXH+/C6b0PKzrnc4HwLJjb/hhWvgbxg78QNJ+Winm9deMZF
         Xl8zS/3t7hQEqJ9RGd9k2HSZfW4zC37s+H4XElyGknoCrR5XnKZtWAh9M6QRthW/DDL4
         H5bA==
X-Gm-Message-State: ANhLgQ0o1bYE6Nmw7owivCwKqQ66Mh4Si0RRracSz1KpnoX4UjH6UMpf
        7luOHM1WW/Cbjp6h+xYm8/D1MsAp+/7jEx2kF8w=
X-Google-Smtp-Source: ADFU+vu5Dqu6Zgyd4KVxIX4B2sh8GgdQB0nnr4vbkA1gIb1fJ6uacc8qBLVRgembols/s/FlJqniWUhihsy9sih0V2w=
X-Received: by 2002:a5d:6742:: with SMTP id l2mr8031333wrw.124.1585450891310;
 Sat, 28 Mar 2020 20:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com> <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com> <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com> <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com> <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
In-Reply-To: <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sun, 29 Mar 2020 11:01:19 +0800
Message-ID: <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To:     Tokunori Ikegami <ikegami.t@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 8:57 PM Tokunori Ikegami <ikegami.t@gmail.com> wrote:
>
> Hi,
>
> On 2020/03/28 11:11, Ming Lei wrote:
> > On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
> >> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> >>> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> >>>> On 2020/03/24 9:02, Keith Busch wrote:
> >>>>> We didn't have 32-bit max segments before, though. Why was 16-bits
> >>>>> enough in older kernels? Which kernel did this stop working?
> >>>> Now I am asking the detail information to the reporter so let me
> >>>> update later.  That was able to use the same command script with the
> >>>> large data length in the past.
> >>> I have just confirmed the detail so let me update below.
> >>>
> >>> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> >>> 64bit).
> >>> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> >>> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> >>> (Ubuntu 64bit).
> >>> So the original 20,531,712 length failure issue seems already resolved.
> >>>
> >>> I tested the data length 0x10000000 (268,435,456) and it is failed
> >>> But now confirmed it as failed on all the above kernel versions.
> >>> Also the patch fixes only this 0x10000000 length failure issue.
> >> This is actually even more confusing. We do not support 256MB transfers
> >> within a single command in the pci nvme driver anymore. The max is 4MB,
> >> so I don't see how increasing the max segments will help: you should be
> >> hitting the 'max_sectors' limit if you don't hit the segment limit first.
> > That looks a bug for passthrough req, because 'max_sectors' limit is only
> > checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
> > like the following seems required:
> >
> > diff --git a/block/blk-map.c b/block/blk-map.c
> > index b0790268ed9d..e120d80b75a5 100644
> > --- a/block/blk-map.c
> > +++ b/block/blk-map.c
> > @@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
> >          struct bio_vec bv;
> >          unsigned int nr_segs = 0;
> >
> > +       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
> > +                       queue_max_hw_sectors(rq->q))
> > +               return -EINVAL;
> > +
>
> I have just confirmed about the max_hw_sectors checking below.
> It is checked by the function blk_rq_map_kern() also as below.
>
>      if (len > (queue_max_hw_sectors(q) << 9))
>          return -EINVAL;

The above check doesn't take rq->__data_len into account.

Thanks,
Ming Lei
