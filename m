Return-Path: <SRS0=mNKb=VZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D3DC433FF
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2057206DD
	for <linux-block@archiver.kernel.org>; Sun, 28 Jul 2019 06:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhgttuqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfG1GEi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Jul 2019 02:04:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44130 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG1GEh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Jul 2019 02:04:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so26373312pfe.11
        for <linux-block@vger.kernel.org>; Sat, 27 Jul 2019 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9UJQpd0xn6j1q7EL5BQ2ZId3B9WOB9tdoXEx83FAk8=;
        b=KhgttuqZnVqBgUW6miCnZmipIGSAbMLoRII/z1dm+CcEgju01oHiMNllxbeLT8HEyQ
         vqKmUI4HDpUPUCQUoHuNzQea0AGmavOpiOP4xxF+aj0c2aALBdCMKd6KnMkf4HAFVRrH
         c52uKm4uqBK1q4kYjNr1sDqmpeSBHYmsIkRMbHX76SO9UAMK5ZfBF/9QDj12E1PNzI67
         +8BaT9HA80Uk1rLaM4n4rIpbuBjBLnFsfRn9Z/3e/QI65Mhf7+NImZj5ZN659fNPHox2
         6AIJQaUlch4JKD3P193sGfHsKQec/MrudR0uHl94Tf3t68spNGGqjBhiVcf8O1lyrAB+
         dtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9UJQpd0xn6j1q7EL5BQ2ZId3B9WOB9tdoXEx83FAk8=;
        b=BcUVmXOKiXJ4GbLzhK5LkwGE9s4XS3HHYLJaX00vGVpmkZ/eP4kZKddcMHeWcVZteR
         OrhRYAdT13kAghkR3yCccmsJIbLQNeBu+TqHiwYV8ctVWl/pV2hIO9t7+KCuBeJx2pSE
         l3gbSKoSc2kpWjd/eqnk+wyZDUs/jXt+FRTJcdL4ojkYpOZFqqgNzj/Wm1Xes8inGLsH
         emIQcsFBResvLrMKR2Gi6UGx7Ebf716QfAaRqgnQJX0km9qTzlDWV3mlonV4XyP3DjKk
         XTzAJknjywNg2LX6GmkZ4CImdfYHq6zbFIr/+ToFUWJaxNV1oNAoqbldABfh9uaevKyu
         fvPA==
X-Gm-Message-State: APjAAAVBo8cBOcgLCdEd6Fc3aYIoBbpCqDxSdSPg52jwwz1LR10R246y
        9z+JFGdwTTTRhYQ9MLqesn8=
X-Google-Smtp-Source: APXvYqySYw8m78mBnAW0diDNqW5o9C9RMxmCmS22J2eLNOuisEadAqzasdH8oyGhhzbK3UYkixKj0Q==
X-Received: by 2002:a17:90a:2385:: with SMTP id g5mr108383053pje.12.1564293877140;
        Sat, 27 Jul 2019 23:04:37 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id x26sm74821935pfq.69.2019.07.27.23.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 23:04:35 -0700 (PDT)
Date:   Sun, 28 Jul 2019 15:04:32 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 1/8] null_blk: add module parameter for REQ_OP_DISCARD
Message-ID: <20190728060432.GD24390@minwoo-desktop>
References: <20190711175328.16430-1-chaitanya.kulkarni@wdc.com>
 <20190711175328.16430-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190711175328.16430-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Chaitanya,

On 19-07-11 10:53:21, Chaitanya Kulkarni wrote:
> This patch adds a module parameter to configure the REQ_OP_DISCARD
> handling support when null_blk module is not memory-backed. This support
> is useful in the various scenarios such as examining REQ_OP_DISCARD path
> tests, blktrace and discard with priorities.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/block/null_blk_main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 99328ded60d1..20d60b951622 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -3,6 +3,7 @@
>   * Add configfs and memory store: Kyungchan Koh <kkc6196@fb.com> and
>   * Shaohua Li <shli@fb.com>
>   */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Maybe it casue other pr_ family prints "null_blk" twice, doesn't it?  If
so, can we have this change with the other pr_ family updated?

Thanks!
