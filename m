Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493AAC32793
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 02:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbiHWCoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbiHWCoE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 22:44:04 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544125A2C4
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 19:44:03 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h22so9450028qtu.2
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 19:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tZOc80YqXReLRj3XwKQICtZOCu5oz6GBClY7zU+fdCI=;
        b=HwinV7FVcpJhc+iWyLyx+yozmkQ7f2ItJwEaujApX5+O/73Wi5QEYngSt3p2hnyAKM
         OuG+EaR+ezddTE1xNbCgyAGU9v+2Z+Nw45PuaGZUAI7XizPWq56u2AiFKGvXtYcee/Yn
         1E/gn+HdwnA8D0egSprswrwMb4eFOao+6+1ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tZOc80YqXReLRj3XwKQICtZOCu5oz6GBClY7zU+fdCI=;
        b=5xSd39Anf7AdJtyOLtggFbBlpg3MLBcmtKsAfhqpQL6BtN936MaaPZbKnd2WS42zvf
         2no2Nkc6azTDLl3A5qO1RPaP+YQlylNs1eg3arqVTbMaCfzRdwHBw2LqHnK9jxKcdhS7
         tPNfwx9MHIRRZ/8MahoDtlMY93GPkSeHA7k7J1mpzJuqCtOrzz/OwZER3BuIx1OtINeW
         5IgHTKrKTdv2Cq6fRDhuU21/e0C8ejfelO/rZrFvIUYEO9TPQmpEWsiVF4i9aZKAAAq3
         r2DCCUi8e9qt82l1eCFnom+3h5VjU6aT25+Q2LJtJNamWx044Bscy9BLRDukI6GIzymi
         Tdzg==
X-Gm-Message-State: ACgBeo3UAYWUQ+i2nCdPzP/QPe9bRIQjYMDNtvhCExZzysaSpIZpJ+sH
        2xeB0fZG3QPLruzE0Tgt63dc3QtthPyoOs3I
X-Google-Smtp-Source: AA6agR6Ubo8aP0wWOXco1LuX8fUrzgBK3OL3k3d62Smsaz48gGC5ZuOHwfpnsEDWZRHB0rhCHaO1jg==
X-Received: by 2002:a05:622a:1302:b0:344:8a9d:817d with SMTP id v2-20020a05622a130200b003448a9d817dmr17947954qtk.339.1661222642433;
        Mon, 22 Aug 2022 19:44:02 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id c13-20020ac8054d000000b00343681ee2e2sm9936280qth.35.2022.08.22.19.44.01
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 19:44:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-3375488624aso315680097b3.3
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 19:44:01 -0700 (PDT)
X-Received: by 2002:a25:7616:0:b0:695:9024:1c23 with SMTP id
 r22-20020a257616000000b0069590241c23mr10851291ybc.177.1661222641337; Mon, 22
 Aug 2022 19:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
 <CAFNWusbavuD9vMuTjV0fEFjTCnMCd1+HPkUC+GsF2FYewrDJ_Q@mail.gmail.com>
 <CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com>
 <CAFNWusYr_3FjZtALxjq8ty=-FvWqzW=j1K7Mynuz0W9Vh8tD5A@mail.gmail.com>
 <CAPBb6MV74xgOKUBfej3etF4ZDuVEHhGciCwYyzOBfOBY27v2qg@mail.gmail.com> <CAFNWusYobFdqaEj12ND7Ee9pT+GRxPQwYNEEAG1LMEXCgUQjDA@mail.gmail.com>
In-Reply-To: <CAFNWusYobFdqaEj12ND7Ee9pT+GRxPQwYNEEAG1LMEXCgUQjDA@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 23 Aug 2022 11:43:50 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVG62C6vTPjQWzRkrqHMX1GZzWKyoFrqF1Cf1HLvpJV0Q@mail.gmail.com>
Message-ID: <CAPBb6MVG62C6vTPjQWzRkrqHMX1GZzWKyoFrqF1Cf1HLvpJV0Q@mail.gmail.com>
Subject: Re: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Kim Suwan <suwan.kim027@gmail.com>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Suwan,

On Tue, Aug 23, 2022 at 1:23 AM Kim Suwan <suwan.kim027@gmail.com> wrote:
>
> Hi Alexandre,
>
> On Mon, Aug 22, 2022 at 4:03 PM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> > Hi Suwan, apologies for taking so long to come back to this.
> >
> > On Tue, Aug 2, 2022 at 11:50 PM Kim Suwan <suwan.kim027@gmail.com> wrote:
> > >
> > > Hi Alexandre
> > >
> > > On Tue, Aug 2, 2022 at 11:12 AM Alexandre Courbot <acourbot@chromium.org> wrote:
> > > >
> > > >  Hi Suwan,
> > > >
> > > > Thanks for the fast reply!
> > > >
> > > > On Tue, Aug 2, 2022 at 1:55 AM Kim Suwan <suwan.kim027@gmail.com> wrote:
> > > > >
> > > > > Hi Alexandre,
> > > > >
> > > > > Thanks for reporting the issue.
> > > > >
> > > > > I think a possible scenario is that request fails at
> > > > > virtio_queue_rqs() and it is passed to normal path (virtio_queue_rq).
> > > > >
> > > > > In this procedure, It is possible that blk_mq_start_request()
> > > > > was called twice changing request state from MQ_RQ_IN_FLIGHT to
> > > > > MQ_RQ_IN_FLIGHT.
> > > >
> > > > I have checked whether virtblk_prep_rq_batch() within
> > > > virtio_queue_rqs() ever returns 0, and it looks like it never happens.
> > > > So as far as I can tell all virtio_queue_rqs() are processed
> > > > successfully - but maybe the request can also fail further down the
> > > > line? Is there some extra instrumentation I can do to check that?
> > > >
> > >
> > > I'm looking at one more suspicious code.
> > > If virtblk_add_req() fails within virtblk_add_req_batch(),
> > > virtio_queue_rqs() passes the failed request to the normal path also
> > > (virtio_queue_rq). Then, it can call blk_mq_start_request() twice.
> > >
> > > Because I can't reproduce the issue on my vm, Could you test
> > > the below patch?
> > > I defer the blk_mq_start_request() call after virtblk_add_req()
> > > to ensure that we call blk_mq_start_request() after all the
> > > preparations finish.
> >
> > Your patch seems to solve the problem! I am not seeing the warning
> > anymore and the block device looks happy.
>
> Good news! Thanks for the test!
>
> > Let me know if I can do anything else.
>
> Could you test one more patch?
> I move blk_mq_start_request(req) before spinlock() to reduce time
> holding the lock within virtio_queue_rq().
> If it is ok, I will send the patch.

Yup, it seems to be happy with this patch as well. Thanks!

Cheers,
Alex.
