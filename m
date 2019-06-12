Return-Path: <SRS0=leUH=UL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B2DC31E44
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 01:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5626820673
	for <linux-block@archiver.kernel.org>; Wed, 12 Jun 2019 01:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9u6kwyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405897AbfFLBmu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:42:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40556 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405767AbfFLBmu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 21:42:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so4763779wmj.5
        for <linux-block@vger.kernel.org>; Tue, 11 Jun 2019 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ts5DRXbEi+maUPGct5eWYbiCXXe/ctoo9dtJH57rBLA=;
        b=l9u6kwyyDuNfcl0Yt37IiyICxwDEWEhnYbmdos0sd9ukA2RPk3Z4YXDuzyVP+LfAnd
         MDFNJS6skQazZLK2DSFDw9oxRYBKh83WI3+d35+8o8X3LE7NjQaeK574UYXhQaOpuGDg
         xtIxhJ2o9nDpssh/6l3hT5OJaS7mKuWtlE5nrEz2gb56FxXSAK1Tich87PoYusMyPIZI
         fXqzyT1ts0P7NQxNblNC4cEM1ehJKYGGhGEA+gvR27S9xFuNws+mBFEMZ+Pa/01KMIYH
         rpnzZtfwDb7WuKg54L/9E+Mv5b6dyrah4PgYAgU7xnQpxDoCsN1yuCp8AJLXVzaPpHDJ
         Qu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ts5DRXbEi+maUPGct5eWYbiCXXe/ctoo9dtJH57rBLA=;
        b=qh6vzQWaIBFC+eXyQBIcqzMR89cCJhAOO1lcXza3gj1y9NXSsfZztqFRUebNap2zOf
         /VOPEHmcoD+LP4OnD3h6FbzURWxEsvKxBi5Fa3lMK4CyAwwQo7t/3lLSzd4z9RvK90az
         4erx5NIyygGc8icTE1N2TK0O9Ktprv34yrPoIBw/ilbKs0MTqSReIxk1ksROMIrSzyUi
         0IrlMaF2lvDEsSPhgY3QMSNYMyoiBREYPhZ+7uzPw3+Q1vXBZbZ5XyGRLT9BcuZsP4L2
         MlzzsHMys+u6MEyU3YyBp/jBBv8G2usOj9PJHbP81OsDmQxd9OjhF+rj3hSMEtYUwARp
         hH0A==
X-Gm-Message-State: APjAAAX7DRwtU4lIyNBUWpQJK8YMVr9bCg2NPuLt463WYTRXCy/j+O0t
        9RBycVNvkQz7+PgMVyodYLPPO8wLqOWC1KP5Q2s=
X-Google-Smtp-Source: APXvYqx8+PYLkvEZotO6BfhHklCO4/pQ26pRw6QCLSrMNGFjNQ+npvhQgvOHoWFhKJyzTMVz+AaagwcWin4q3ZuQA8Y=
X-Received: by 2002:a1c:9a53:: with SMTP id c80mr18653432wme.173.1560303768457;
 Tue, 11 Jun 2019 18:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190604072340.12224-1-damien.lemoal@wdc.com>
In-Reply-To: <20190604072340.12224-1-damien.lemoal@wdc.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 12 Jun 2019 09:42:35 +0800
Message-ID: <CACVXFVPHLd7BtQ_Jh+YYYHjOSqC1i2ZfikYstfshQQBwmO6Uvw@mail.gmail.com>
Subject: Re: [PATCH] block: force select mq-deadline for zoned block devices
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 4, 2019 at 3:24 PM Damien Le Moal <damien.lemoal@wdc.com> wrote:
>
> In most use cases of zoned block devices (aka SMR disks), the
> mq-deadline scheduler is mandatory as it implements sequential write
> command processing guarantees with zone write locking. So make sure that
> this scheduler is always enabled if CONFIG_BLK_DEV_ZONED is selected.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  block/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/Kconfig b/block/Kconfig
> index 1b220101a9cb..2466dcc3ef1d 100644
> --- a/block/Kconfig
> +++ b/block/Kconfig
> @@ -73,6 +73,7 @@ config BLK_DEV_INTEGRITY
>
>  config BLK_DEV_ZONED
>         bool "Zoned block device support"
> +       select MQ_IOSCHED_DEADLINE
>         ---help---
>         Block layer zoned block device support. This option enables
>         support for ZAC/ZBC host-managed and host-aware zoned block devices.
> --
> 2.21.0
>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
