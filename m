Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93562C433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513F92250E
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 18:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbhAKSQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 13:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389561AbhAKSQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 13:16:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7EC061795;
        Mon, 11 Jan 2021 10:15:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i24so716089edj.8;
        Mon, 11 Jan 2021 10:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RcqeDQE5LH6fB8dKfgjP3DrZ9mN0XGhWSFEEnVxfPPA=;
        b=Q1oOEB13Vdab2t3qwH8Zwl05Ng6pBt2qINhmY3XojRUsq2UuxwBZ0II2OqOaSRmynn
         nRtgPruahcr+LSQX0HuLn9BdXu9wAKrJJT0NSsyJhhLrqpKxaEBIxlnnHe/TV63uwVw9
         m3ABg1HXuu7GDDjdA9S78T59C9YJAcVrpRxIq2UZr25qcUTKgkpcHRq32tFB2GyzwTNn
         VsSVg/zh3PCsa9r0QCUTaV+mk0iZk4gJgRDRmhv/laSNTX4zUvoYFIH4Raxj98ZmZ/cW
         0u7jYbdci3CVsGamDshB8OyIUKZhXq9bw4CbyOsmAdgMxrVRt82NIMH5suCp4asoceJY
         uL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RcqeDQE5LH6fB8dKfgjP3DrZ9mN0XGhWSFEEnVxfPPA=;
        b=plbhDxh/7MJ4gEfYVisqvAPRVJ6LlTBWykT/lQYlEx4dMrxx5r2E5mbNzR2+CBimse
         k1/+D9L6RL9vx6KCTuoe9g4IVLJ+Nv2sXzGNTOFB9lhA5HJEakQP/hA1zer4RaQEZiaZ
         tdj6p7c6vg35kJrstu4Bgz+z75f/kAYCOgXhovbVVjrkDjIDOO5CWmTB9IfkJrPOBKl2
         pF8eT8NhSVHei6pUXxOPjvTq8/eIScyFAvO2isF8VDB8CVwYoj4k0bzZJaDhEBb1OYhj
         4BjSmfePJoXmPbXMa3gG9E24qaowH9M20V6X3NGfGUp+63++mZbbONpLonSCJxw1xf7l
         DKcA==
X-Gm-Message-State: AOAM532I2CtIDZVJ275touMNM/ShTuKaDAbnZ4eoZIVZkHqJo0/aJnVg
        w3JOwNevEhVaa7aBLqd+lL+P0+JDUF7L+a4ofA==
X-Google-Smtp-Source: ABdhPJxSKTIJIOYWpNVP5ohJgBgBTu87uL/BXE8BXfqusJA8HocWzSfztjJiiBKcH+VYM30fnvze1mg6lpuQ3bXOZuI=
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr443744edk.201.1610388939997;
 Mon, 11 Jan 2021 10:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20201112140752.1554-1-rach4x0r@gmail.com> <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me> <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me> <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me> <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
 <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me> <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
 <CAKeUqKK3yykq8LNv1CCHZTHSz1=bzBaCwVQmi6bhpbYzqVJsqQ@mail.gmail.com>
In-Reply-To: <CAKeUqKK3yykq8LNv1CCHZTHSz1=bzBaCwVQmi6bhpbYzqVJsqQ@mail.gmail.com>
From:   Rachit Agarwal <rach4x0r@gmail.com>
Date:   Mon, 11 Jan 2021 13:15:28 -0500
Message-ID: <CAKeUqKJKXP8iJY1x=wXc7Vz+qQPhP=MaUmy71x2f2H_YdHf_8w@mail.gmail.com>
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jaehyun Hwang <jaehyun.hwang@cornell.edu>,
        Qizhe Cai <qc228@cornell.edu>,
        Midhul Vuppalapati <mvv25@cornell.edu>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        Rachit Agarwal <ragarwal@cornell.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Resending the last message] Happy 2021 everyone!

> Dear all:
>
> Hope you are all well.
>
> Sagi and I were wondering if you have any additional feedback on the
> updated patch? (@Ming?) We have been receiving a lot of
> interest/questions from industry on incorporation of i10 in the
> kernel. If people do not have additional feedback, it would be nice to
> move this forward.
>
> Looking forward to hearing from you!
> ~Rachit
>
> On Sat, Nov 28, 2020 at 12:49 AM Rachit Agarwal <rach4x0r@gmail.com> wrot=
e:
> >
> >
> >
> > On Fri, Nov 13, 2020 at 4:56 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>
> >>
> >> >>>> But if you think this has a better home, I'm assuming that the gu=
ys
> >> >>>> will be open to that.
> >> >>>
> >> >>> Also see the reply from Ming. It's a balancing act - don't want to=
 add
> >> >>> extra overhead to the core, but also don't want to carry an extra
> >> >>> scheduler if the main change is really just variable dispatch batc=
hing.
> >> >>> And since we already have a notion of that, seems worthwhile to ex=
plore
> >> >>> that venue.
> >> >>
> >> >> I agree,
> >> >>
> >> >> The main difference is that this balancing is not driven from devic=
e
> >> >> resource pressure, but rather from an assumption of device specific
> >> >> optimization (and also with a specific optimization target), hence =
a
> >> >> scheduler a user would need to opt-in seemed like a good compromise=
.
> >> >>
> >> >> But maybe Ming has some good ideas on a different way to add it..
> >> >
> >> > So here's another case - virtualized nvme. The commit overhead is
> >> > suitably large there that performance suffers quite a bit, similarly=
 to
> >> > your remote storage case. If we had suitable logic in the core, then=
 we
> >> > could easily propagate this knowledge when setting up the queue. The=
n it
> >> > could happen automatically, without needing a configuration to switc=
h to
> >> > a specific scheduler.
> >>
> >> Yes, these use-cases share characteristics. I'm not at all opposed to
> >> placing this in the core. I do think that in order to put something li=
ke
> >> this in the core, the bar needs to be higher such that an optimization
> >> target cannot be biased towards a workload (i.e. needs to be adaptive)=
.
> >>
> >> I'm still not sure how we would build this on top of what we already
> >> have as it is really centered around device being busy (which is not
> >> the case for nvme), but I didn't put enough thought into it yet.
> >>
> >
> > Dear all:
> >
> > Thanks, again, for the very constructive decisions.
> >
> > I am writing back with quite a few updates:
> >
> > 1. We have now included a detailed comparison of i10 scheduler with Kyb=
er with NVMe-over-TCP (https://github.com/i10-kernel/upstream-linux/blob/ma=
ster/i10-evaluation.pdf). In a nutshell, when operating with NVMe-over-TCP,=
 i10 demonstrates the core tradeoff: higher latency, but also higher throug=
hput. This seems to be the core tradeoff exposed by i10.
> >
> > 2. We have now implemented an adaptive version of i10 I/O scheduler, th=
at uses the number of outstanding requests at the time of batch dispatch (a=
nd whether the dispatch was triggered by timeout or not) to adaptively set =
the batching size. The new results (https://github.com/i10-kernel/upstream-=
linux/blob/master/i10-evaluation.pdf) show that i10-adaptive further improv=
es performance for low loads, while keeping the performance for high loads.=
 IMO, there is much to do on designing improved adaptation algorithms.
> >
> > 3. We have now updated the i10-evaluation document to include results f=
or local storage access. The core take-away here is that i10-adaptive can a=
chieve similar throughput and latency at low loads and at high loads when c=
ompared to noop, but still requires more work for lower loads. However, giv=
en that the tradeoff exposed by i10 scheduler is particularly useful for re=
mote storage devices (and as Jens suggested, perhaps for virtualized local =
storage access), I do agree with Sagi -- I think we should consider includi=
ng it in the core, since this may be useful for a broad range of new use ca=
ses.
> >
> > We have also created a second version of the patch that includes these =
updates: https://github.com/i10-kernel/upstream-linux/blob/master/0002-iosc=
hed-Add-i10-I-O-Scheduler.patch
> >
> > As always, thank you for the constructive discussion and I look forward=
 to working with you on this.
> >
> > Best,
> > ~Rachit
> >
