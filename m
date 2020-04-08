Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88DFC2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18D2206F7
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 12:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdpGNQx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgDHMZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:25:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42326 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgDHMZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 08:25:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id x66so2499985qkd.9
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/+C7faJfFzDXZ30HbyRyv/q1F5p09B4+qKmQEP1uWPA=;
        b=SdpGNQx8DHUqAsF1MJaLyXe0tkrtzoiteojRHGbcNFYeDvkwLMtXwespbbQp7lgiwP
         jAZzEuEwhuNDpMYm8ye7q9OfH44J8gVqzDsFKuEz2MnRSoqTn9lBwQ5XT7mFpXYZc+/C
         JRfrfUGkakraI2QJyIGE9qZM+nrsTCs3azn1uNg+JaGKO1va20UTEPwxomsnSyyyUjpm
         5Z1DQIU7d4VR0dsMD582TsYnCZK23wj26dSj3sijb3eR6F9Eu6huo6+wrWA1o6RyoZcN
         wOJFQHRhuQhBQSAWDSwKqYAy8CfHsy14bmDbXoRlsLL0LuUaB15w++wnDaAPcd1tKuE1
         HBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/+C7faJfFzDXZ30HbyRyv/q1F5p09B4+qKmQEP1uWPA=;
        b=HirI/EPBUXUFAkxouFVQHszy+024E+6jfYZe24E9r2c7YU4xb1P1wJNcm7HSqnSvp0
         vQxducIRL/lFcLFh2aP5wubWvRMwMRoIBlmmvvWXj4AgCemUKTwHbUwN8/TfF0Z19R2w
         3sGpljEqhGpvwYdlXFj0ThPkvlU+swp9DcLlbIOxNGEdG3rdOHbHebmUj4iFT6iqLV20
         xJ8jI5vq0h+3PYGafelLAPuPpl/SF7ADOvSctivpn1xQo1KmGdjIgnQT7T3cz26juVpL
         q8+yMjQJ/06FyRKu46uZB2DBWsDmZsrFw/1xt4Ixoi8SCG//yVGvgIlDJ7llUz31blcc
         Yo+A==
X-Gm-Message-State: AGi0PuacF4T7a6v/S+I8j1lH6x/y8PTntadu2Ai6kqpzKszGV2opsRg2
        az0Foj3LtpN4ZcPrXD4BakHzoRS4VjPHd1/hYmA=
X-Google-Smtp-Source: APiQypJ+V8K5STa5JwzV+xtqzfsEuKxTSnSacnPB8kqE2QO5FoX6rSwBkoPak0B9aFcYfrQDLhxV0gpKvCnmjsSrvYw=
X-Received: by 2002:a37:8b04:: with SMTP id n4mr7310012qkd.222.1586348743001;
 Wed, 08 Apr 2020 05:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
In-Reply-To: <cover.1586199103.git.zhangweiping@didiglobal.com>
From:   Weiping Zhang <zwp10758@gmail.com>
Date:   Wed, 8 Apr 2020 20:25:31 +0800
Message-ID: <CAA70yB7mNEt+H5xd+hpeRDLXDi+V+Qmuvuy27wJ63dtmcKDpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Fix potential kernel panic when increase hardware queue
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Weiping Zhang <zhangweiping@didiglobal.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=
=887=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=883:36=E5=86=99=E9=81=93=EF=
=BC=9A
>
> Hi,
>
> This series do some improvement base on V2, and also fix two memleaks.
> And V2 import a regression for blktest/block/test/029, this test case
> will increase and decrease hardware queue count quickly.
>
>
> Memleak 1:
>
> __blk_mq_alloc_rq_maps
>         __blk_mq_alloc_rq_map
>
> if fail
>         blk_mq_free_rq_map
>
> Actually, __blk_mq_alloc_rq_map alloc both map and request, here
> also need free request.
>
> Memleak 2:
> When driver decrease hardware queue, set->nr_hw_queues will be changed
> firstly in blk_mq_realloc_tag_set_tags or __blk_mq_update_nr_hw_queues,
> then blk_mq_realloc_hw_ctxs and blk_mq_map_swqueue, even
> blk_mq_free_tag_set have no chance to free these hardware queue resource,
> because they iterate hardware queue by
> for (i =3D 0; i < set->nr_hw_queues; i++).
>
> Patch1~3: rename some function name, no function change.
> Patch4: fix first memleak.
> Patch5: fix prev_nr_hw_queues issue, need be saved before change.
> Patch6: alloc map and request to fix potential kernel panic.
>
Update patch description:
Patch1~3: rename some function name, no function change.
Patch4: fix first memleak.
Patch5: fix prev_nr_hw_queues issue, need be saved before change.
Patch6: add nr_allocated_map_rqs to struct blk_mq_tag_set to record how
may rq and maps were allocated for this tag set, and also fix memleak2.

Patch7: fix kernel panic when update hardware queue count > cpu count,
when use multiple maps. Patch7's commit message has more detail information
about this issue.

>
> Changes since V2:
>  * rename some functions name and fix memleak when free map and requests
>  * Not free new allocated map and request, they will be relased when tags=
et gone
>
> Changes since V1:
>  * Add fix for potential kernel panic when increase hardware queue
>
> Weiping Zhang (7):
>   block: rename __blk_mq_alloc_rq_map
>   block: rename __blk_mq_alloc_rq_maps
>   block: rename blk_mq_alloc_rq_maps
>   block: free both map and request
>   block: save previous hardware queue count before udpate
>   block: refactor __blk_mq_alloc_rq_map_and_requests
>   block: alloc map and request for new hardware queue
>
>  block/blk-mq.c         | 49 ++++++++++++++++++++++++++++++------------
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 36 insertions(+), 14 deletions(-)
>
> --
> 2.18.1
>
