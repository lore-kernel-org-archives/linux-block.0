Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED518C10F14
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B75214DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEOotsYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDSCga (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:36:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36083 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSCga (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 22:36:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so817759wrw.3;
        Thu, 18 Apr 2019 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvFkCUw7QgU+VlTVR4t2XeBfOtLRTqEWd7kdLqmQplE=;
        b=dEOotsYPxaT0Bp8DcgHjRIKATjdLpqsgI6oQDJxl2l9W0eM06wrK/j7TRf+Sy3+5+K
         AfZxCMdnN8UDAcMctaphulqx/y+okVMTaXDjS5+mEotNHs9xMDkisI3ZMQecG5Wtog6X
         7cvuuvoG6OAPMGUpIGYbPnFO94omBHTHD/1WpQAiTwL+/4NHIX4NKN0e6fdimNz3vReE
         7mSHF/vNAHtt3ye7K6c66Hn0+xD4lgnwg/AJoKVtGgnR3GSnsjj1moOuY7btxU8DLG9Y
         x8tDkdTcxUz+UIJfVMdDtxrbXem5zf30H+xVXzWY+ITU0sBuQfqsv2LfeG2q6GYoHoHd
         LSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvFkCUw7QgU+VlTVR4t2XeBfOtLRTqEWd7kdLqmQplE=;
        b=GVCMdyfL8xZWXxXBYliXpo4L9Xk7QHcqJpcdZSFDSOTIfq/4fj/Zw0fjtreOmdelfF
         /R6CLxlDAf+GEsW6HEwid7JnczA5mmDkhRMTXXex00wD5ldBXWev9FKf7d+JqDEvB5SP
         cF8sZtOKPl4s0J94Dh4GpOaP85tpvJ+K3TzjMED5bZ2IuDSTNJx5j912og/lQXnKYQUP
         VemKNisdx1wug8zwPHnOyXBECnsidSv2Yb15pvHu3MSBexI5oh4hQWmJoMuzEyb+f/35
         F2tcPfRA7qDXqozjU2l7e9nuvysnysC3DdwiJb7Xvq/InyZueFUhupvgKJMT/f3Fgmi/
         KxTQ==
X-Gm-Message-State: APjAAAXxfO1TYjSad1d3aHu+mQc6D36Vui12Y39YpOEMhp7opMziNRKx
        S5ASt88MZQOva8hQ5zfo7Q+ge8NZ5oha9ensAxA=
X-Google-Smtp-Source: APXvYqwR7J2NK3nvoe7agSE8OYddQznMj1bip391XjMEu84MvaxAgKv3qzvarAYzcOX4eQVKajgAnUonF9cdJIbZyCs=
X-Received: by 2002:adf:d081:: with SMTP id y1mr941955wrh.283.1555641388907;
 Thu, 18 Apr 2019 19:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net> <20190415205242.GA6380@lst.de>
 <20190415210731.GA32723@roeck-us.net> <20190416063356.GA25763@lst.de>
 <20190416170847.GA5531@roeck-us.net> <20190416171011.GA4611@lst.de>
 <20190416175108.GA9550@roeck-us.net> <20190417052723.GA23019@lst.de>
 <20190417215904.GA23015@roeck-us.net> <CACVXFVPvz0H_vN1tafNGyk2E+gkoM0q6ab8Gt=J0fuhW3MGj8A@mail.gmail.com>
In-Reply-To: <CACVXFVPvz0H_vN1tafNGyk2E+gkoM0q6ab8Gt=J0fuhW3MGj8A@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 19 Apr 2019 10:36:17 +0800
Message-ID: <CACVXFVPaV8MHvLTxuGVsWxaPiDhbkr2E3PhuCxsjxGt31TfQfA@mail.gmail.com>
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page call
To:     Guenter Roeck <linux@roeck-us.net>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 19, 2019 at 10:27 AM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Thu, Apr 18, 2019 at 5:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Apr 17, 2019 at 07:27:24AM +0200, Christoph Hellwig wrote:
> > > Now that I've fixed the sparc32 iommu code in another thread:  can
> > > you send me your rootfs and qemu arm command line for the failing
> > > one?  I have a hard time parsing your buildbot output.
> >
> > FWIW: mmc_blk_data_prep() calls blk_rq_map_sg() with a large offset value.
> > The old code translated this into:
> >
> > blk_bvec_map_sg(q=c77a0000 len=13824 offset=18944)
> >   sg_set_page(sg=c6015000 p=c7efd180 l=13824 o=2560)
> >
> > The new code leaves offset unchanged:
> >
> > blk_bvec_map_sg(q=c76c0528 len=13824 offset=18944)
> >   sg_set_page(sg=c6035000 p=c7f2af00 l=13824 o=18944)
> >
> > Traceback:
> >
> > [<c065e3d4>] (blk_rq_map_sg) from [<c0ca1444>] (mmc_blk_data_prep+0x1b0/0x2c8)
> > [<c0ca1444>] (mmc_blk_data_prep) from [<c0ca15ac>] (mmc_blk_rw_rq_prep+0x50/0x178)
> > [<c0ca15ac>] (mmc_blk_rw_rq_prep) from [<c0ca48bc>] (mmc_blk_mq_issue_rq+0x290/0x878)
> > [<c0ca48bc>] (mmc_blk_mq_issue_rq) from [<c0ca52e4>] (mmc_mq_queue_rq+0x128/0x234)
> > [<c0ca52e4>] (mmc_mq_queue_rq) from [<c066350c>] (blk_mq_dispatch_rq_list+0xc8/0x5e8)
> > [<c066350c>] (blk_mq_dispatch_rq_list) from [<c06681a8>] (blk_mq_do_dispatch_sched+0x60/0xfc)
> > [<c06681a8>] (blk_mq_do_dispatch_sched) from [<c06688b8>] (blk_mq_sched_dispatch_requests+0x134/0x1b0)
> > [<c06688b8>] (blk_mq_sched_dispatch_requests) from [<c0661f08>] (__blk_mq_run_hw_queue+0xa4/0x138)
> > [<c0661f08>] (__blk_mq_run_hw_queue) from [<c03622a0>] (process_one_work+0x218/0x510)
> > [<c03622a0>] (process_one_work) from [<c0363230>] (worker_thread+0x44/0x5bc)
> >
> > This results in bad data transfers, which ultimately causes the crash.
>
> There are several bugs related with kmap(sg_page(sg)), such as:
>
> sdhci_kmap_atomic()
> tmio_mmc_kmap_atomic()
> wbsd_map_sg()

Cc mmc maillist:

Looks there are more such bad uses:

au1xmmc_send_pio()
au1xmmc_receive_pio()
mmc_spi_data_do()
sdricoh_request()

However, seems tifm_sd.c notices this issue, see tifm_sd_transfer_data().

Thanks,
Ming Lei
