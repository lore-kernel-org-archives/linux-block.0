Return-Path: <SRS0=MX1A=5N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A962C43331
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 02:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102082076B
	for <linux-block@archiver.kernel.org>; Sat, 28 Mar 2020 02:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFaLKsO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgC1CML (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:12:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgC1CMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 22:12:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id e9so2890950wme.4
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/DOwGlq77kSeP4sy4KWSZr4DI/jrj8vkZIgJxq2wxQ=;
        b=sFaLKsO0B1asOYx6CZzraFrL8vCx/JKwHn8CzUlYAq2cex+3Qr1n3ZAj3v01GJI6hR
         7wVRC/D8xXWYyoNqRBfd0VVgCOIbIereEVqM+NTTmO3CnqQFmTfgjjnAm5Z6c7O5fq2q
         bTPTM+wsYxfk9iuDMiktlq5xTK/n8In6GVz2X43LfNlDvwZ8X1/d+wI6Y+RoQbS58Bv5
         XIVMLnHkUsThgIzrSUgMYFjJpyyBWOci3e3dfQnYUyeCyRNfv7rsTiwIrFI/IbzaWf0d
         jUUeQDTOxi9aPICgrMaA06srZGN/5dTtypeMVfFzQH5EHRgmcgWX6A58lrs09oGZLxio
         9J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/DOwGlq77kSeP4sy4KWSZr4DI/jrj8vkZIgJxq2wxQ=;
        b=FLf6EJPIAGbFtk6J7ea+b5UMrpYKHjnRm9a3VHXZ0PFSCek6m6BAGcHrOFPYu9sQEv
         pgjc8C8OxKZf2wKryZnPPDMOx+mFIR2cqnEPo5DJgZ41J3x/AtKlFFdxsCBJWVcPqRl4
         nHcZpWX9+6z1ATB38x7iYGarcWJgqIUOogJ//OpjimLiRbskjMsraWtJDA0gAQ6lmqx9
         yfkXsDWpHLl9wEPItbyCmRUMZn2WP4GTG5IdxQJCBpn2PmASpvkOPC7rzy/Nron4an+x
         UOY7BK0F22Bd5Js2ZpvVJryuEm15CQHeZU4lPiJQPUhcToYvlDmXiS38Ugh5hxu3wony
         qPqw==
X-Gm-Message-State: ANhLgQ0EKd7oJ22ZnsIG0yvuNSer+90mc09qQ87dglbk6ECNGOCH2djT
        rJpueTHAZ+hHgZft17bTdEvftNsCS0Z9lWQPBlM=
X-Google-Smtp-Source: ADFU+vuabhaHXmflsA/2lDMhKPUJLSaV8Pmr1H1oT2n52e77OAV9Vl6OQd+eI84i5QJN+qyP96N0v+9h/rBxBJSYLnA=
X-Received: by 2002:a05:600c:10ce:: with SMTP id l14mr1732074wmd.161.1585361529430;
 Fri, 27 Mar 2020 19:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200323182324.3243-1-ikegami.t@gmail.com> <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com> <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com> <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Sat, 28 Mar 2020 10:11:57 +0800
Message-ID: <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To:     Keith Busch <kbusch@kernel.org>
Cc:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 2:18 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> > On 2020/03/25 1:51, Tokunori Ikegami wrote:
> > > On 2020/03/24 9:02, Keith Busch wrote:
> > > > We didn't have 32-bit max segments before, though. Why was 16-bits
> > > > enough in older kernels? Which kernel did this stop working?
> > > Now I am asking the detail information to the reporter so let me
> > > update later.  That was able to use the same command script with the
> > > large data length in the past.
> >
> > I have just confirmed the detail so let me update below.
> >
> > The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> > 64bit).
> > Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> > But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> > (Ubuntu 64bit).
> > So the original 20,531,712 length failure issue seems already resolved.
> >
> > I tested the data length 0x10000000 (268,435,456) and it is failed
> > But now confirmed it as failed on all the above kernel versions.
> > Also the patch fixes only this 0x10000000 length failure issue.
>
> This is actually even more confusing. We do not support 256MB transfers
> within a single command in the pci nvme driver anymore. The max is 4MB,
> so I don't see how increasing the max segments will help: you should be
> hitting the 'max_sectors' limit if you don't hit the segment limit first.

That looks a bug for passthrough req, because 'max_sectors' limit is only
checked in bio_add_pc_page(), not done in blk_rq_append_bio(), something
like the following seems required:

diff --git a/block/blk-map.c b/block/blk-map.c
index b0790268ed9d..e120d80b75a5 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -22,6 +22,10 @@ int blk_rq_append_bio(struct request *rq, struct bio **bio)
        struct bio_vec bv;
        unsigned int nr_segs = 0;

+       if (((rq->__data_len + (*bio)->bi_iter.bi_size) >> 9) >
+                       queue_max_hw_sectors(rq->q))
+               return -EINVAL;
+


Thanks,
Ming Lei
