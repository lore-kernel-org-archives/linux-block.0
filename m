Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BCAC43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 12:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235564AbiFUMQx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiFUMQx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 08:16:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0315837
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 05:16:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u12so27048301eja.8
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuCCB2tSIlzehgEJIfEy11XJmTOAX94q7884Wj5lNy0=;
        b=O4CcfQOqLNZIlMt2LfbZl1yqRccLQEWrJaKdY2UjR8iyV9tMQc+vfGf3Z0Tx1WMQ00
         sj52QovqG3Jckl+Xy+bJG+HxVocBGZyISJt5HYxws1J0/F35mOpd9At3z2SE3rdR6R0i
         o/GZgW6PFhGX6+dZKA24q/IIe4VtaV5Me78WOsP7dTnDd7Tsd47BmQHUIdx8Q5QUk5Jt
         dhIjkDicHi6FIkWUjoDJoMgimnqm2VXhkD6+PtZuZ+QKqf+Tmmga0G+PiWgPYyjeE7uL
         4syYIezYjbeRcAQOMJaaz4A9bv09TpONturSZj1Ka2RhW27YNidgjFy1fsnVeJYfQVFa
         SpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuCCB2tSIlzehgEJIfEy11XJmTOAX94q7884Wj5lNy0=;
        b=fo6zo/zMsd9JrF93D2WC9EiOV62Srvc2+zaL6bzA2MFbFp+QVvg0Km6AhaUCdhU8ZT
         0Xrwe6cCRjgSQ4ZBlKISWRh7veZSIy4egYzkOjOTV/A21oAmAR9rwQIMc1ylXmHBaptE
         0Cio3Tgh2YasJnSv6JyCrqt48yFPpMkaRpOJBK3ide+jZ4+efrhTEgm1WeMd7MXxWUhW
         /hCOJ2/3LX2BkePlGCHYUS8qwJgJ+BIaDG0P+RDYk3MsDb/jgv22hkbE3yOLMYZnR73G
         KFoWBJKiiKz4sNa6NqV1CViP31uXBRPJ85BeIVA/A+cR9f+S4k/M8FxXVUv0IIgVsnpU
         a59g==
X-Gm-Message-State: AJIora9uDp2PJt+57UACHt5GUcTarkk6KHBunsXqSkclnkx3hjZvMG1/
        83NvEJnmrqYRd3CCFeHfS97MKE3JHEdG3n5ZJWG49Q==
X-Google-Smtp-Source: AGRyM1uzMM/n/vfai0rrYqKRUGKT263AYRo8TucmO7Ybmo+f7m4fHIxi7xSk2MdcMoGF/Fx4r3pLtjz07ygNGUujVO4=
X-Received: by 2002:a17:906:d7bc:b0:70a:99ef:d0b8 with SMTP id
 pk28-20020a170906d7bc00b0070a99efd0b8mr26055852ejb.624.1655813810046; Tue, 21
 Jun 2022 05:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-1-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 21 Jun 2022 14:16:39 +0200
Message-ID: <CAMGffEmXohRXYg0twM5yxb1pdHhwRy9AkN8myj-mh6KnRgG1Vg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] reduce the size of rnbd_clt_dev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:49 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Hi,
>
> The struct rnbd_clt_dev added some members (wc, fua and max_hw_sectors
> etc) which are used to set up gendisk and request_queue, but seems only
> map scenario need to setup them since rnbd_client_setup_device is not
> called from remap path.
>
> Previously, pahole reports.
>
>         /* size: 272, cachelines: 5, members: 29 */
>         /* sum members: 259, holes: 4, sum holes: 13 */
>         /* last cacheline: 16 bytes */
>
> After the series, it changes to
>
>         /* size: 224, cachelines: 4, members: 17 */
>         /* last cacheline: 32 bytes */
>
> Please review.
>
> Thanks,
> Guoqing
Hi Guoqing,

Thanks for the patchset, I had a brief look, in general I like the
idea, will run a regression test. and sort out the details.

Thanks!
Jinpu
