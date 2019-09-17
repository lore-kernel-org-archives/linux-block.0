Return-Path: <SRS0=pu/s=XM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABBFC4CEC9
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE92171F
	for <linux-block@archiver.kernel.org>; Tue, 17 Sep 2019 15:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="jdDgDADt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfIQPwm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:52:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51269 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfIQPwm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 11:52:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so4130352wme.1
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKP299nn9dAVscWnwEGtfjquUeakNIYf9tui2aZbZM0=;
        b=jdDgDADtN8x3yMOTTXEl9p6of/mhIZcOuq9lDQNLJcyuXfxihEU4kmzF2DeCj3kQcG
         S0ug0mzOtlb/Q7emX2Apa9kF62FVkKObR8J8SrA7J1xJNb0/n6K/jdht9LXmqko5ENrP
         ZzUEiVrKILWSr9+l/tn/pxMxtVtCPxeECujoaFGm5FnCzVFbwDRK3/W3JDH8D+jFteIw
         3/ETBijHdcvNoG933pa6SSs9a0MNM9ZEO6Il/U746bYeateMui/HpGXZD0dc0uMgHOtm
         sCv+06raWPUJw2NH/teoQp+SSM6CJ92nDDXX384+/qypnbECAtweqmMIye5iKsztRoos
         trHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKP299nn9dAVscWnwEGtfjquUeakNIYf9tui2aZbZM0=;
        b=EIpRY7Nc8VeZxBjUKz9a0WtHz7ZUxMJSHPBsaELRkTaW3aEkvrMAPXkr44pgt+kSi1
         y3q4xJAhcBOUc52hMRYQPasO6mLCS4+aK1HmpPlMpARMSzZKOjWztDtQAKLv8aSh/MPc
         H5oZmmT2MfiiLqt3gx7rIkIpzMnyGrvOkJpYb8zib3+G1koPIMqAzfef6xtVMAWyQWJT
         MKken4rMmFsxuRdIkk3yrFT2BxEzOLi3z1Hf+ujiN0NdMlnKBm+EqhAh+kLG7MgEsOXx
         1OhKV7taRuLE/XP81p4tAMXP4c/G36zToah8GeQQ/vUDKYT8ykM6oYgrEftpQsKHQVnn
         Z8ng==
X-Gm-Message-State: APjAAAW0TravYCMXWzq4Gt8zuCPBLdzr73dwDmRjeDmr49LjOLMMquou
        Vk0M6AEFZ90gVqazLhjeX9JV8TvxdHAKStUpA/jb7g==
X-Google-Smtp-Source: APXvYqy4g+sPWDvtjuzHam2AP/YjYBLiMEbmD1GTZF1aE6eRxGVi944aZKF9bVr2VAzVelcad2qvz8kSYFdA3tCFMmU=
X-Received: by 2002:a1c:4384:: with SMTP id q126mr4559194wma.153.1568735558937;
 Tue, 17 Sep 2019 08:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-16-jinpuwang@gmail.com>
 <4fbad80b-f551-131e-9a5c-a24f1fa98fea@acm.org> <CAMGffEnVFHpmDCiazHFX1jwi4=p401T9goSkes3j1AttV0t1Ng@mail.gmail.com>
 <20190916052729.GB18203@unreal> <25bd79e1-9523-8354-873a-0ff1db92659a@acm.org>
 <20190917154150.GE18203@unreal>
In-Reply-To: <20190917154150.GE18203@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 17 Sep 2019 17:52:27 +0200
Message-ID: <CAMGffEmK6Crv9e1NWXxo8P2mGVfhVKZ_uZRx6_P63Uts1vu2NQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/25] ibnbd: private headers with IBNBD protocol
 structs and helpers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 17, 2019 at 5:42 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Sep 16, 2019 at 06:45:17AM -0700, Bart Van Assche wrote:
> > On 9/15/19 10:27 PM, Leon Romanovsky wrote:
> > > On Sun, Sep 15, 2019 at 04:30:04PM +0200, Jinpu Wang wrote:
> > > > On Sat, Sep 14, 2019 at 12:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > > > +/* TODO: should be configurable */
> > > > > > +#define IBTRS_PORT 1234
> > > > >
> > > > > How about converting this macro into a kernel module parameter?
> > > > Sounds good, will do.
> > >
> > > Don't rush to do it and defer it to be the last change before merging,
> > > this is controversial request which not everyone will like here.
> >
> > Hi Leon,
> >
> > If you do not agree with changing this macro into a kernel module parameter
> > please suggest an alternative.
>
> I didn't review code so my answer can be not fully accurate, but opening
> some port to use this IB* seems strange from my non-sysadmin POV.
> What about using RDMA-CM, like NVMe?
Hi Leon,

We are using rdma-cm, the port number here is same like addr_trsvcid
in NVMeoF, it controls which port
rdma_listen is listening on.

Currently, it's hardcoded, I've adapted the code to have a kernel
module parameter port_nr in ibnbd_server, so it's possible
to change it if the sysadmin wants.

Thanks,
-- 
Jack Wang
Linux Kernel Developer
Platform Engineering Compute (IONOS Cloud)
