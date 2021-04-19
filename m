Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EBC433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2061104
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhDSGiY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 02:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSGiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 02:38:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F66C06174A
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 23:37:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n2so51086202ejy.7
        for <linux-block@vger.kernel.org>; Sun, 18 Apr 2021 23:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PDXy/9Y/FcTdSRegonFGq/cV3kr8MsnTdhmYheEH7w=;
        b=iZKKZqWXEwEJYuyS4GVwN97yAB9OMoCAKiyRWtMFiHPEj97aL44E14HjxSUYRec82t
         ueRfvDAPQeh20LZ3dn6o76QajV+8jCxbtrslt8IQAHhfr5yxCO8+JDFthvx9gynSZbMf
         enERyJ4MfDCTaVhoLtrHKLawLixVdDi+6J7/Zn3qYjIOA3hxM2acwenCChuw9rGexHF4
         3b0oBqdWJDpDmXC4fi5VfhEIP4jNizLqkbntjmc+zTlDU5I271IN3sOiETyKTXosj/Y+
         GYr0OJoiexP5Y/KMWkxqBKpeughCNURsnCScsYAcZ9pjYgtx6EsqSyDCSMiUDRpYG96c
         34rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PDXy/9Y/FcTdSRegonFGq/cV3kr8MsnTdhmYheEH7w=;
        b=aOAypXaO1ABiy+UhYkiVBrzkvxMiAmVJjxPEl+Z0boCqYXzH89v6qK2Q7rr3JERUT8
         jBVWJ2BftNFlZh6wJ7U70IsWNEMJb2UuFnj18h84m63o+iU5udVwGACgI2jd2m/luGNk
         tURhSr0Hg/OKKQahh7dhpJo+heBZgt9HLbyCzSkhqRLEQf7J/nv7rSCxg5pyJnCdJH8y
         7cE1fso5eGF2rzj8pt3jYlhkTYfZIQuyOlLzGiJ3p/V1Tr3+CxDz2qhU+KTJyZpfTheJ
         /Juo9WSQeIo+5n53Y44pkPfq4MjaIV4EZz78/AObcP3qturkgzrl5dwWUAnP6k0Tvfjk
         wkSw==
X-Gm-Message-State: AOAM531rAXrfh8VqKlSJDyKOXqPKP90Gb++mOygeceewukzlYXzw33NW
        Xaw4SLHSbYe2Dv4JMRKRpSby6YOLfvsnT0SAhP0p7g==
X-Google-Smtp-Source: ABdhPJyFH5TiK2kctLROT48iODF2bpqb94Bq8jbtU4QpWvrK7vjeNdfOSTNSqOZ0SP9cL44itLvVgRPHmJBCFP9ivgM=
X-Received: by 2002:a17:906:fca1:: with SMTP id qw1mr20094855ejb.478.1618814273733;
 Sun, 18 Apr 2021 23:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210409160305.711318-1-haris.iqbal@ionos.com>
 <ef59e838-4d7f-cab4-e1ac-26944cb7db75@kernel.dk> <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
In-Reply-To: <CAMGffE=ZdCUc_HABY3_F_aK6pqCt8maB4yi9Qu4gKoox6ub6QQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 19 Apr 2021 08:37:43 +0200
Message-ID: <CAMGffEmVhXepdmMJcb6F2jYOqO8OGgS0xeuUXpLPcWh+r1RxiA@mail.gmail.com>
Subject: Re: [PATCH V6 0/3] block: add two statistic tables
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 12, 2021 at 7:35 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Fri, Apr 9, 2021 at 11:03 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 4/9/21 10:03 AM, Md Haris Iqbal wrote:
> > > Hi Jens,
> > >
> > > This version fixes the long lines in the code as per Christoph's comment.
> >
> > I'd really like to see some solid justification for the addition,
> > though. I clicked the v1 link and it's got details on what you get out
> > of it, but not really the 'why' of reasoning for the feature. I mean,
> > you could feasibly have a blktrace based userspace solution. Just
> > wondering if that has been tried, I know that's what we do at Facebook
> > for example.
> >
> Hi Jens,
>
> Thanks for the reply.
> For the use case of the additional stats, as a cloud provider, we
> often need to handle report from the customers regarding
> performance problem in a period of time in the past, so it's not
> feasible for us to run blktrace, customer workload could change from
> time to time, with the additional stats, we gather through all metrics
> using Prometheus, we can navigate to the period of time interested,
> to check if the performance matches the SLA, it also helps us to find
> the user IO pattern,  we can more easily reproduce.
>
> We do use blktrace from time to time too if it's not too late (when IO
> pattern has not changed.)
>
> Thanks!
> Jack

Hi Jens,

A gentle ping!
