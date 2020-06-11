Return-Path: <SRS0=H7KM=7Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F7BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F27206FA
	for <linux-block@archiver.kernel.org>; Thu, 11 Jun 2020 01:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by9WJa5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKBzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFKBzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 21:55:02 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84FC08C5C1
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 18:55:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so4935843ljh.13
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2020 18:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z5t3/ZeuNNzEguGWotcdH8FnAdaer9Wb9odYorjYJX0=;
        b=by9WJa5MPO6Mq2YODW542ej/4X3lvVTrDciPVZw7nPOQQSdtAI0lazBAk5MJcxSeRu
         a8RkZbtqk7kYfrSE15aQTzINDvkqEyvHtEZA6d0iJgd403ZJbihL1jXykKbMFZF/QFxy
         IQSjSOaJaHIOAfk5UsKSKt3LCEsZAVzGbXN1RWHFj1mixXnw95y/ydnX2qaRTYnEDNGW
         L4eu8ZY29uvxiH4wfrdE9P7VACO40JS6ZDuu8F38I+7IFXnuNMufJ8SGa7yZXclU1Z3F
         1WojvMJDBJs7V1Ggv7iQgw2fnuM3lv/PYTRch6bkUSCZQVGEe199nzjUSNRbPojfZbRa
         Y7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z5t3/ZeuNNzEguGWotcdH8FnAdaer9Wb9odYorjYJX0=;
        b=lZYX4k7qnjEJQizFfg7Otmd2kfnk3PkyuV+GNOp1/peg0DU+QLcz6z9cPhLsv2k76D
         lnkN784mnDzZp57dA8NJYXoK5bbGai4ej/9nDOA8QTnqArdSth3jF2HQK8NFS+SdS93k
         +ipuk1iSFmHcqmYu0Qb2C6bA8lPhroDuwTGKtIE8wP1rO1mN6g+ozPGi1cod8qiZ6dpQ
         9AY2QkKnTQSEjS5EFKoJP8kH6V4vQ/Z2ss+zqSblpBTMJ2K1/iq3KF5sreE9ImkSGAFV
         o+3czSlbma535MRlctAzu3krU1I18cxM5BM2tV38iK79UTxHgo+j8IdI7O5P/5Linzfx
         E6xA==
X-Gm-Message-State: AOAM530xqfaOK/15ihzpR7q5hawY2CXIowxgKRiuVm0RjrytMbZpuuoU
        jhNEhJW8ECM3MxHqcazg6gTc5Vd+1CbIDDY+wUc=
X-Google-Smtp-Source: ABdhPJwwMMr6goPOxq9chnCtaB9YBI0vVnfuOGoxeSNi66KTBNs7jWnAEdv5xs1sjntPJlT0FHyS1TXd6R19eY3H0Zw=
X-Received: by 2002:a2e:8107:: with SMTP id d7mr3293960ljg.363.1591840499850;
 Wed, 10 Jun 2020 18:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <CACOAw_zf5HNDaFtaMBAFYDFQaQj6YaXADke8JGm=A7CYXiCN5w@mail.gmail.com>
 <BYAPR04MB49655E779DE03C5149CCBBB586800@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB49655E779DE03C5149CCBBB586800@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Thu, 11 Jun 2020 10:54:48 +0900
Message-ID: <CACOAw_ypXqpOHF9MgP5b-9jwNJDnJi7a-z6qU8yHMA7nr9_nnw@mail.gmail.com>
Subject: Re: Question about blkdev_issue_zeroout()
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Daeho Jeong <daehojeong@google.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> If I understand plugging correctly then when a process is going to wait
> on the I/O to finish (here submit_bio_wait(), the device is unplugged
> and request dispatching to the device driver is started. Does that mean
> we should finish plug before we wait ?

Oh, where should I find to unplug during submit_bio_wait() call? I
cannot find it. But, there is no stuck during the call, it's weird to
me. :( Could you explain to me?

2020=EB=85=84 6=EC=9B=94 11=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 10:35, =
Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> Daeho,
>
> On 6/8/20 8:05 PM, Daeho Jeong wrote:
> > Hi guys,
> >
> > When I looked into blkdev_issue_zeroout(), I found something that I
> > cannot understand there. In my understanding, all the submitted bio
> > will stay in the plug list during plugging. But, I found
> > submit_bio_wait() calling during the plugging. I guess the below
> > submit_bio_wait() might wait forever in the lower kernel version like
> > 4.14, because of plugging. If I am wrong, plz, correct me.
> >
> >       >>>  blk_start_plug(&plug); <<<
> >          if (try_write_zeroes) {
> >                  ret =3D __blkdev_issue_write_zeroes(bdev, sector, nr_s=
ects,
> >                                                    gfp_mask, &bio, flag=
s);
> >          } else if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
> >                  ret =3D __blkdev_issue_zero_pages(bdev, sector, nr_sec=
ts,
> >                                                  gfp_mask, &bio);
> >          } else {
> >                  /* No zeroing offload support */
> >                  ret =3D -EOPNOTSUPP;
> >          }
> >          if (ret =3D=3D 0 && bio) {
> >                  ret =3D submit_bio_wait(bio);
> >                  bio_put(bio);
> >          }
> >        >>> blk_finish_plug(&plug); <<<
> >
>
> If your analysis is correct then this is true for
> blkdev_issue_write_same() and blkdev_issue_discard() also ?
>
> If I understand plugging correctly then when a process is going to wait
> on the I/O to finish (here submit_bio_wait(), the device is unplugged
> and request dispatching to the device driver is started. Does that mean
> we should finish plug before we wait ?
>
> Just for a discussion following untested patch which unplugs before
> submit_bio_wait() in blk-lib.c and maintains the original behaviour :-
>
>  From 253ae720f721b2789d8fcde3861aeac6766b4836 Mon Sep 17 00:00:00 2001
> From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Date: Wed, 10 Jun 2020 18:23:19 -0700
> Subject: [PATCH] block: finish plug before submit_bio_wait()
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   block/blk-lib.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 5f2c429d4378..992de09b258d 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -104,13 +104,13 @@ int blkdev_issue_discard(struct block_device
> *bdev, sector_t sector,
>         blk_start_plug(&plug);
>         ret =3D __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, =
flags,
>                         &bio);
> +       blk_finish_plug(&plug);
>         if (!ret && bio) {
>                 ret =3D submit_bio_wait(bio);
>                 if (ret =3D=3D -EOPNOTSUPP)
>                         ret =3D 0;
>                 bio_put(bio);
>         }
> -       blk_finish_plug(&plug);
>
>         return ret;
>   }
> @@ -200,11 +200,11 @@ int blkdev_issue_write_same(struct block_device
> *bdev, sector_t sector,
>         blk_start_plug(&plug);
>         ret =3D __blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mas=
k, page,
>                         &bio);
> +       blk_finish_plug(&plug);
>         if (ret =3D=3D 0 && bio) {
>                 ret =3D submit_bio_wait(bio);
>                 bio_put(bio);
>         }
> -       blk_finish_plug(&plug);
>         return ret;
>   }
>   EXPORT_SYMBOL(blkdev_issue_write_same);
> @@ -381,11 +381,11 @@ int blkdev_issue_zeroout(struct block_device
> *bdev, sector_t sector,
>                 /* No zeroing offload support */
>                 ret =3D -EOPNOTSUPP;
>         }
> +       blk_finish_plug(&plug);
>         if (ret =3D=3D 0 && bio) {
>                 ret =3D submit_bio_wait(bio);
>                 bio_put(bio);
>         }
> -       blk_finish_plug(&plug);
>         if (ret && try_write_zeroes) {
>                 if (!(flags & BLKDEV_ZERO_NOFALLBACK)) {
>                         try_write_zeroes =3D false;
> --
> 2.27.0
>
