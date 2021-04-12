Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAF3C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 05:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6961207
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 05:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhDLFgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhDLFgA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 01:36:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98368C061574
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 22:35:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so18205198eju.1
        for <linux-block@vger.kernel.org>; Sun, 11 Apr 2021 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9whVOjYLNtz/N21mjeKtcvhO5IVOCd2iAu/rBorEB8=;
        b=doh5Eo4wZ9Hm8tN8np3R/2fkACpxz9WKI+S63Jvg7PZXJs1wWmrFiykiccocODAVJz
         QXwTKSTYf58zm+5T14iQHu7HQ4STzZBMj1KoRgMYnSwz36rPdXf3Ki9p/mpPX+bc1D0A
         6rFG2Uv3gUauw52/2nGHNExJFRFcRWS4G+XiXLhiPeO3QQ1us7LOWfHUzz+3LAW6urez
         I3LljSkkv1P29vFsDMDbfXeiZ9k8XuhEnquQW6pmTrYZfaI54gFY+TNCUL6z9fRFpLds
         GJoDlVJDiJgt4wriPbZl2idmx2LobjeQhADpyt96D2W2u+jV6v5K57Zh5g3DIJgw2YtV
         VRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9whVOjYLNtz/N21mjeKtcvhO5IVOCd2iAu/rBorEB8=;
        b=dja82H93TI4uONkiy355OZD4mDoBynB3XVzqM2tqhkavRjLA6x3T/z3TYrgIXZ5Hvo
         P8P2OUPfogQIDG+KUZPdHxjg5NEhuWoXuLqb2wTN7s7U1cfXb+swx4HBEe8VIx0dlCVw
         JILpWkfoPfRzwGghPPDXIoCYBT0aSyvw2OGkj4UnP5WfUrH2t3/dzmDPR2GU54UJfxBb
         r+dxbjE6ilsTNdMUEv50iAy5VMB0tV4U1h5ZdI9triueZRTYtghxHX0L5JdxO2AQyPnQ
         sJCwFyIraVJXBaq/p2Hq81sI5UqZOrgmmeahsIphBwbB4LXmyz40JHJKA9OH2pdk3afN
         nZJQ==
X-Gm-Message-State: AOAM531jz3oVck10NTxB7m9jvIsQjwMamG9Qp0npD0lspBLGOkJEYQrW
        J+5QBUDLuM+qOYRNGZZcK1jqKMuRPNnlccebpB2jj4ql090=
X-Google-Smtp-Source: ABdhPJyS/CFuvyuLubgivS0yA5o0TCKBtuNYKedcR3zizntArGO261T0PSbh7Q1RdFXR1ffyo8PsP1NzO4EjrIyo4r4=
X-Received: by 2002:a17:906:fb81:: with SMTP id lr1mr222748ejb.62.1618205741381;
 Sun, 11 Apr 2021 22:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210409160305.711318-1-haris.iqbal@ionos.com> <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
In-Reply-To: <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 12 Apr 2021 07:35:30 +0200
Message-ID: <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 9, 2021 at 11:03 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/9/21 10:03 AM, Md Haris Iqbal wrote:
> > Hi Jens,
> >
> > This version fixes the long lines in the code as per Christoph's comment.
>
> I'd really like to see some solid justification for the addition,
> though. I clicked the v1 link and it's got details on what you get out
> of it, but not really the 'why' of reasoning for the feature. I mean,
> you could feasibly have a blktrace based userspace solution. Just
> wondering if that has been tried, I know that's what we do at Facebook
> for example.
>
Hi Jens,

Thanks for the reply.
For the use case of the additional stats, as a cloud provider, we
often need to handle report from the customers regarding
performance problem in a period of time in the past, so it's not
feasible for us to run blktrace, customer workload could change from
time to time, with the additional stats, we gather through all metrics
using Prometheus, we can navigate to the period of time interested,
to check if the performance matches the SLA, it also helps us to find
the user IO pattern,  we can more easily reproduce.

We do use blktrace from time to time too if it's not too late (when IO
pattern has not changed.)

Thanks!
Jack
