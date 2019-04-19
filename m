Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E4AC10F14
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B483A214DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 02:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHZtbm7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDSC15 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Apr 2019 22:27:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfDSC15 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Apr 2019 22:27:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so5309267wrm.4
        for <linux-block@vger.kernel.org>; Thu, 18 Apr 2019 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HM75p0vRcQZv2Fm9RkquTRhL5I8rbeaTSmGQefit3SQ=;
        b=WHZtbm7c523fodkOzzn9onn8okLjR3gOaDcZVBOJIPsFpREqxBuIdWdhRfZin58Sxu
         95Tv3nQrEmk17xHREDkDQrPG3XRdgyL4TMlKg6RMtdgv5H1qJt4/zzEUve4PA28eGj3W
         dzNpmHaamThSFKofaZbqrQPIejeSPBX77+94dZfy2JVdA6V7kbaNyOkVUtt24Xkz2s5Z
         c+uBOQVC8Jaf6gmhBFcdxBsmXCkXJfQ7+84lNUy65YWyOG7+cwfuYo80BjGHEqlByfEu
         RW1piXLRXKIPARfoEY+sAQDS/B6E0U2oD/aWLOnCcaC1nmkEW66971VzCAAM8Kt1cmyx
         T6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HM75p0vRcQZv2Fm9RkquTRhL5I8rbeaTSmGQefit3SQ=;
        b=NjwzNLZS1NOk5HscYBTQ0nSs16r4HG+D5OiclIMYehAv8SI5WIvkj3zzyIlB/4/sLZ
         wk7NSJMEz6Rnhq7D3aEuMSYR6OtT6uyLEuYjrmDzGHGX033yF+/taLkexNqO+WB0hyfr
         +Ht2LEzFYxHs/KugNJfP8bku6QNykzaBWX/QpUgrtYXLEblAsQ1qwbV2p/OQ/95DXFDx
         xx2ZYcQy5ujvj1gN4Wc4eb0ALW5KrdbWWehtvDMkI1luPpz5Qe82wBWpcslPrlmYb56o
         SNfMD0W6pLWyF++4uYdGcG8ZbaVGLjoYBP/9JJYPloYj/uKjD7lpFi3ITAvaLzXDl+A5
         mtKw==
X-Gm-Message-State: APjAAAWlAS5MFAQDOTZ01rKRhmc0/p0vjBUIFhOC5t0tjFza8D5/wRqe
        hiTg5xX1kfRH+/BrPB0nEomqX8014z6Horsy/mMmn4nFK73f9Q==
X-Google-Smtp-Source: APXvYqwQQOTLYRUTDBPu3L40z+lca8tiDPXMI4kpyw3VaWoKVZad/zP/GsCIQV+SXaLW5qLZqihHykmPMkUQYN5omYA=
X-Received: by 2002:adf:b60a:: with SMTP id f10mr934057wre.116.1555640875877;
 Thu, 18 Apr 2019 19:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190408104641.4905-1-hch@lst.de> <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net> <20190415205242.GA6380@lst.de>
 <20190415210731.GA32723@roeck-us.net> <20190416063356.GA25763@lst.de>
 <20190416170847.GA5531@roeck-us.net> <20190416171011.GA4611@lst.de>
 <20190416175108.GA9550@roeck-us.net> <20190417052723.GA23019@lst.de> <20190417215904.GA23015@roeck-us.net>
In-Reply-To: <20190417215904.GA23015@roeck-us.net>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 19 Apr 2019 10:27:44 +0800
Message-ID: <CACVXFVPvz0H_vN1tafNGyk2E+gkoM0q6ab8Gt=J0fuhW3MGj8A@mail.gmail.com>
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page call
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 18, 2019 at 5:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Apr 17, 2019 at 07:27:24AM +0200, Christoph Hellwig wrote:
> > Now that I've fixed the sparc32 iommu code in another thread:  can
> > you send me your rootfs and qemu arm command line for the failing
> > one?  I have a hard time parsing your buildbot output.
>
> FWIW: mmc_blk_data_prep() calls blk_rq_map_sg() with a large offset value.
> The old code translated this into:
>
> blk_bvec_map_sg(q=c77a0000 len=13824 offset=18944)
>   sg_set_page(sg=c6015000 p=c7efd180 l=13824 o=2560)
>
> The new code leaves offset unchanged:
>
> blk_bvec_map_sg(q=c76c0528 len=13824 offset=18944)
>   sg_set_page(sg=c6035000 p=c7f2af00 l=13824 o=18944)
>
> Traceback:
>
> [<c065e3d4>] (blk_rq_map_sg) from [<c0ca1444>] (mmc_blk_data_prep+0x1b0/0x2c8)
> [<c0ca1444>] (mmc_blk_data_prep) from [<c0ca15ac>] (mmc_blk_rw_rq_prep+0x50/0x178)
> [<c0ca15ac>] (mmc_blk_rw_rq_prep) from [<c0ca48bc>] (mmc_blk_mq_issue_rq+0x290/0x878)
> [<c0ca48bc>] (mmc_blk_mq_issue_rq) from [<c0ca52e4>] (mmc_mq_queue_rq+0x128/0x234)
> [<c0ca52e4>] (mmc_mq_queue_rq) from [<c066350c>] (blk_mq_dispatch_rq_list+0xc8/0x5e8)
> [<c066350c>] (blk_mq_dispatch_rq_list) from [<c06681a8>] (blk_mq_do_dispatch_sched+0x60/0xfc)
> [<c06681a8>] (blk_mq_do_dispatch_sched) from [<c06688b8>] (blk_mq_sched_dispatch_requests+0x134/0x1b0)
> [<c06688b8>] (blk_mq_sched_dispatch_requests) from [<c0661f08>] (__blk_mq_run_hw_queue+0xa4/0x138)
> [<c0661f08>] (__blk_mq_run_hw_queue) from [<c03622a0>] (process_one_work+0x218/0x510)
> [<c03622a0>] (process_one_work) from [<c0363230>] (worker_thread+0x44/0x5bc)
>
> This results in bad data transfers, which ultimately causes the crash.

There are several bugs related with kmap(sg_page(sg)), such as:

sdhci_kmap_atomic()
tmio_mmc_kmap_atomic()
wbsd_map_sg()

Thanks,
Ming Lei
