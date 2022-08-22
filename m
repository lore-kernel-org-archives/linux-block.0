Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE6C32772
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 07:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiHVHUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiHVHUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 03:20:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7B315710
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 00:20:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id t5so12636064edc.11
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=F0eTKf5DOX0wXYq76Nn5DVIrzBJZwnUOHLl3EuWXgp0=;
        b=XcXFtA08CzEybh9IuOMt4POK+MRhZWYHiy8GYmQuokYrWSh5GyGiBKGwN/mTm99FSQ
         dW2q4rSbM38XwJL8o35eRQfqa89YAjRBiQc3DBE/EBTtpfJlVYCPT1vF479oIsAjYuWv
         vMlEncBqdJSELOjOHHXfSZTTY+vpe/yk8QeCPIcXkUep8599qwCASa5jJVDNLgijFefb
         K/NV3p0wVj4OAI5fP2TD1PES9jg72/gdekvyEN9nMpxniGrMR+nNYoFWsvSPMXZTVBw8
         PFxoc1BOiclQf1Mkxx75bp8e4sX66hEEbD0fzKXapV5ummHrSZY22xkyjxOj8RRIz3Cm
         xWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=F0eTKf5DOX0wXYq76Nn5DVIrzBJZwnUOHLl3EuWXgp0=;
        b=R1m00KlcN37Qzc/m3UDbRCIlJS6Ml2FHVdVy76r0kbZdPTrRAxhz+wCvJCMPOuiHTB
         IVM3fzFXMSJYG/23NDxv4v0Z+XbwNQHM47V6YBivnN2LmOJwedwoLW95zETn6y+YerRl
         PXWIHlk6Ms8x5/QL7K2e5m7EtjUbne7ayfpU5WJd0dKhh79f75xJfX3/GFLSNIYl6+Zm
         njLfxZqP1BWc/CeAJSgToj9Ryg4HdoVm5lFgIGFdqIiWzUX5i1euuk7rx+4xX9zFrhR9
         5P3j+yeAPMfodM61qORdtggJ7Iep6BYCS2mCSu6nVgJel2J6jjql79mOCRHNJdnyS92e
         Q5Tw==
X-Gm-Message-State: ACgBeo0bmJXpPM9Y8rjU1k3qidecRPELufFv6Gg7jxMJlgbAholMJIeT
        dk+N/0/5ECrrena3dwkASsZlletGSxiLx8bUSFVSAurPFNk=
X-Google-Smtp-Source: AA6agR4eSgHqRi4IGOfcwIIp5HBgidkjj7suqzREoWZmCMt90FHMLp0HgdElpJXezVgo/kUxO00UtexYL8m7da6z4i4=
X-Received: by 2002:a50:9f44:0:b0:445:dfca:87da with SMTP id
 b62-20020a509f44000000b00445dfca87damr14776061edf.105.1661152848849; Mon, 22
 Aug 2022 00:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220822061745.152010-1-hch@lst.de>
In-Reply-To: <20220822061745.152010-1-hch@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 09:20:38 +0200
Message-ID: <CAMGffEkPi00R3EZTae8vAodt60Z0=jYYzP+NvRavk_Uzu-S6vg@mail.gmail.com>
Subject: Re: rnbd cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 22, 2022 at 8:17 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series has a few simple rnbd cleanups.
>
> Slightly related question:  why does rnbd send the max_hw_sectors value
> to the client given that it can't in any way be used by the client?
Hi Christoph,

Thanks for the cleanup, it all looks good.
Acked-by: Jack Wang <jinpu.wang@ionos.com>

Regarding the max_hw_sectors, you are right, client doesn't use it, we
should clean it up.

Thanks!


>
> Diffstat:
>  drivers/block/rnbd/Makefile       |    1
>  drivers/block/rnbd/rnbd-srv.c     |   92 +++++++++++++++-----------------------
>  drivers/block/rnbd/rnbd-srv.h     |    2
>  drivers/block/rnbd/rnbd-srv-dev.c |   43 -----------------
>  drivers/block/rnbd/rnbd-srv-dev.h |   64 --------------------------
>  5 files changed, 39 insertions(+), 163 deletions(-)
