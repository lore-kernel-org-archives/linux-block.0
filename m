Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB9C28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 07:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiHVHEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 03:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiHVHEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 03:04:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3F17044
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 00:03:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cb8so7279357qtb.0
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=h4xDRqYCiaGRv1ItVhiQ+mh8fznESfcIxmJt6SE9yb8=;
        b=Uj6YwMEAbO2HqM/XvyubHVb/BgQj6iJ/Xx/jPDMvoccLyDV2sE9VdHmRvLVAos6U7A
         SFXoEPEyGsFTvz+FepzlXj8B80e/+310EmrBEX0omod2t8DqK10JZc3iUrJ1t0m6y+zM
         QoHoMUjHxcx7kiMWPRIaIpeblh+KUpJfuLnrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=h4xDRqYCiaGRv1ItVhiQ+mh8fznESfcIxmJt6SE9yb8=;
        b=m787hafu737f7zox3K349EwRpecbAF1AGs5+/aP24mUEk+O2xuoLxSSra/gZmTzL7g
         2FEnIPTQdreYE9TsLTVV6Qps7KJd98GPwjOMitgsk5AszCpOhS3h3O/ebMvkIQYWbJtt
         /AhD0FrHuGURervKD5Re/79QcMo5ceX6ZXFwvFC7w65Bww0t/7BygHulybnsouJw0jZp
         1QS4etholb4Q9Nq5sXEm4maZTUWDXV9TfHI4pMKEfI1Let7ybKcGCo2yMUdCR6uBaO6M
         Tu99Wdwg7jrlGK+AfIXikeCkuZm6HurZDluJSeVDgbrzlW26rOjNrNNIZzdIPcu9W6J5
         VLZw==
X-Gm-Message-State: ACgBeo3q51QjSJ5M8cv1vGnNzDYpbcsMkqEKQSNe4CQYp1QpATWRvUIg
        bxerBXh6YcggUZl1z4b+ha0aCBH4sBSYk8dh
X-Google-Smtp-Source: AA6agR5X0rvTq1QT8RG+cu8Wf/Y/yA9V48AjKg+YoDA4co0VgclNZUUyW1oLChFWXP1v3yFauUXV/Q==
X-Received: by 2002:a05:622a:1710:b0:343:77f7:15d0 with SMTP id h16-20020a05622a171000b0034377f715d0mr14377924qtk.248.1661151828603;
        Mon, 22 Aug 2022 00:03:48 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a410500b006b640efe6dasm10853427qko.132.2022.08.22.00.03.48
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 00:03:48 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3376851fe13so234609217b3.6
        for <linux-block@vger.kernel.org>; Mon, 22 Aug 2022 00:03:48 -0700 (PDT)
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr1399542ywa.515.1661151827783; Mon, 22
 Aug 2022 00:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
 <CAFNWusbavuD9vMuTjV0fEFjTCnMCd1+HPkUC+GsF2FYewrDJ_Q@mail.gmail.com>
 <CAPBb6MW0Ou8CcWCD-n+9-B0daiviP1Uk9A9C0QBp=B2oFECF3w@mail.gmail.com> <CAFNWusYr_3FjZtALxjq8ty=-FvWqzW=j1K7Mynuz0W9Vh8tD5A@mail.gmail.com>
In-Reply-To: <CAFNWusYr_3FjZtALxjq8ty=-FvWqzW=j1K7Mynuz0W9Vh8tD5A@mail.gmail.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Aug 2022 16:03:36 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV74xgOKUBfej3etF4ZDuVEHhGciCwYyzOBfOBY27v2qg@mail.gmail.com>
Message-ID: <CAPBb6MV74xgOKUBfej3etF4ZDuVEHhGciCwYyzOBfOBY27v2qg@mail.gmail.com>
Subject: Re: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Kim Suwan <suwan.kim027@gmail.com>
Cc:     linux-block@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Suwan, apologies for taking so long to come back to this.

On Tue, Aug 2, 2022 at 11:50 PM Kim Suwan <suwan.kim027@gmail.com> wrote:
>
> Hi Alexandre
>
> On Tue, Aug 2, 2022 at 11:12 AM Alexandre Courbot <acourbot@chromium.org> wrote:
> >
> >  Hi Suwan,
> >
> > Thanks for the fast reply!
> >
> > On Tue, Aug 2, 2022 at 1:55 AM Kim Suwan <suwan.kim027@gmail.com> wrote:
> > >
> > > Hi Alexandre,
> > >
> > > Thanks for reporting the issue.
> > >
> > > I think a possible scenario is that request fails at
> > > virtio_queue_rqs() and it is passed to normal path (virtio_queue_rq).
> > >
> > > In this procedure, It is possible that blk_mq_start_request()
> > > was called twice changing request state from MQ_RQ_IN_FLIGHT to
> > > MQ_RQ_IN_FLIGHT.
> >
> > I have checked whether virtblk_prep_rq_batch() within
> > virtio_queue_rqs() ever returns 0, and it looks like it never happens.
> > So as far as I can tell all virtio_queue_rqs() are processed
> > successfully - but maybe the request can also fail further down the
> > line? Is there some extra instrumentation I can do to check that?
> >
>
> I'm looking at one more suspicious code.
> If virtblk_add_req() fails within virtblk_add_req_batch(),
> virtio_queue_rqs() passes the failed request to the normal path also
> (virtio_queue_rq). Then, it can call blk_mq_start_request() twice.
>
> Because I can't reproduce the issue on my vm, Could you test
> the below patch?
> I defer the blk_mq_start_request() call after virtblk_add_req()
> to ensure that we call blk_mq_start_request() after all the
> preparations finish.

Your patch seems to solve the problem! I am not seeing the warning
anymore and the block device looks happy.

Let me know if I can do anything else.

Cheers,
Alex.
