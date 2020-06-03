Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6009DC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 11:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE3A20679
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 11:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFCLd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:33:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47150 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgFCLd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 07:33:28 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1jgReA-00026l-BH
        for linux-block@vger.kernel.org; Wed, 03 Jun 2020 11:33:26 +0000
Received: by mail-ua1-f70.google.com with SMTP id b6so995085uap.5
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 04:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=viWYkVa597+lkhfe/lqw69DI7OYxv7dleAG5yZlXtxg=;
        b=VJFHG5qnEDTlEa4J/DgiGt+STXSuOV0dMHc8g6Yslyr47Cv7ZZsAQirsfI41d7M9Ku
         kLPXcID/J82Q+XsJU0ELaLbt9HW9Oh87QWaM2D1chZNE2nMGPjt+nwCkOREc1IC7wqyO
         J0qHk34KgWdpLuuUETHDUK8ldlWKZL+n7nk3eC5tW7m3b2lfbRpH6ulliBV4eSNjKKV2
         v9qhZUu4td+A0ybotpi2lI+mMwNVIfs+z4QKnaWjfdyNWAA1+y2e6Ap87wq2dX8hCGDn
         Q/8vvm/AMJ+C2cJAd/m5TgjKdzM4k3c/KuSrpSoaOLoW1FtIRbT3UkYSjmrhvOne4qH7
         +9WQ==
X-Gm-Message-State: AOAM530M0u40MWDACW3KEnEXYXyN1UsysFX4OuSmbd0XbBawykJ943C+
        oHa+UrYyPI8SskYSlN2DGL7f7aB0OamdT4wYRzDSJYctIT6Y/yka3uv6QHq7wQ5wXZP1rjFbYMv
        uwK3Qfxdk4eG+RbQZqIKOVYA/Pj08nRLoB5DMoC5NmXccU/zdQ3J3W5St
X-Received: by 2002:a67:f982:: with SMTP id b2mr5105646vsq.202.1591184005346;
        Wed, 03 Jun 2020 04:33:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2L95Hcwr+KERSxUoaVamz4ousfBtZICWCrSqLfm4qD2f/+vD8L2dRRmdvxOiqAxm7Nk0Gl2262x1kbsdsTv8=
X-Received: by 2002:a67:f982:: with SMTP id b2mr5105631vsq.202.1591184005085;
 Wed, 03 Jun 2020 04:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200601005520.420719-1-mfo@canonical.com> <20200601073440.GD1181806@T590>
 <CAO9xwp0mibE5_cpq4qaGtJBMBbouUf+jmJEQv7jF5DiL71CCjg@mail.gmail.com>
In-Reply-To: <CAO9xwp0mibE5_cpq4qaGtJBMBbouUf+jmJEQv7jF5DiL71CCjg@mail.gmail.com>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 3 Jun 2020 08:33:14 -0300
Message-ID: <CAO9xwp07aQ_hDCS-MKwqy8h0w3ZyHwbeku2w6OussWO6wxKVhw@mail.gmail.com>
Subject: Re: [PATCH] block: check for page size in queue_logical_block_size()
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 1, 2020 at 10:47 AM Mauricio Faria de Oliveira
<mfo@canonical.com> wrote:
>
> Hi Ming,
>
> (sorry, re-sending in plain text; previous reply had HTML by mistake,
> and bounced in linux-block.)
>
> On Mon, Jun 1, 2020 at 4:34 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Sun, May 31, 2020 at 09:55:20PM -0300, Mauricio Faria de Oliveira wrote:
> > > It's possible for a block driver to set logical block size to
> > > a value greater than page size incorrectly; e.g. bcache takes
> > > the value from the superblock, set by the user w/ make-bcache.
> > >
> > > This causes a BUG/NULL pointer dereference in the path:
> > >
> > >   __blkdev_get()
> > >   -> set_init_blocksize() // set i_blkbits based on ...
> > >      -> bdev_logical_block_size()
> > >         -> queue_logical_block_size() // ... this value
> > >   -> bdev_disk_changed()
> > >      ...
> > >      -> blkdev_readpage()
> > >         -> block_read_full_page()
> > >            -> create_page_buffers() // size = 1 << i_blkbits
> > >               -> create_empty_buffers() // give size/take pointer
> > >                  -> alloc_page_buffers() // return NULL
> > >                  .. BUG!
> > >
> > > Because alloc_page_buffers() is called with size > PAGE_SIZE,
> > > thus it initializes head = NULL, skips the loop, return head;
> > > then create_empty_buffers() gets (and uses) the NULL pointer.
> > >
> > > This has been around longer than commit ad6bf88a6c19 ("block:
> > > fix an integer overflow in logical block size"); however, it
> > > increased the range of values that can trigger the issue.
> > >
> > > Previously only 8k/16k/32k (on x86/4k page size) would do it,
> > > as greater values overflow unsigned short to zero, and queue_
> > > logical_block_size() would then use the default of 512.
> > >
> > > Now the range with unsigned int is much larger, and one user
> > > with an (incorrect) 512k value, which happened to be zero'ed
> > > previously and work fine, hits the issue -- the zero is gone,
> > > and queue_logical_block_size() does return 512k (> PAGE_SIZE)
> >
> > There is only very limited such potential users(loop, virtio-blk,
> > xen-blkfront), so could you fix the user instead of working around
> > queue_logical_block_size()?
> >
>
> Thanks for reviewing.
>
> I can take a look at that, sure, but think the current approach may
> still be useful? as it prevents the current, and future potential
> users too.
>

Please disregard this patch.

Giving this more thought, it's not a good idea to "prevent" any issues
here -- that would actually mask them.
It's probably better to let current issues break, to identify and fix
them (e.g., this), and especially future issues, to hit/fix before
landing.

Thanks,

> Cheers,
>
> > thanks,
> > Ming
> >
>
>
> --
> Mauricio Faria de Oliveira



-- 
Mauricio Faria de Oliveira
