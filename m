Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15442C77B60
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC1T2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC1T2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:28:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B5D30FD
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:28:12 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-544f7c176easo249554437b3.9
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680031691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YujjpUZD+Q1jEde3/ZaCZtJJBkVmO1XlOY4kEzyMtns=;
        b=PhhYKJhXpGjlraKgnxTA1ox1zCuQDINg4H+NjqECLIwcVewsJ2UmF/XldtrOxzUW8F
         FtkMxK9XYIcC/gvDvo1cxA29U3ULWGCBaajKqJk4rgMHA4ss0Alf25G8t46R7Lp02Xut
         O+DxLHWvNCJdltEaU/xNOPwle2JDPTEN6cuVv0Zhrr8Lkz33KxXfau2W3yTNNCA9y3Xp
         LQiDdGk9NrgkoMvxC8Ehixwa8p3N51flc75mRDOp0exVkF6k6E4Hs69JMi+L3/TWelEW
         6mlpBQZHrXZuZqhCm7o9gUs274DyVLH9j018hTkghuZN3NqPxQMPN2+CHF+Zi2aGJdO3
         GnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680031691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YujjpUZD+Q1jEde3/ZaCZtJJBkVmO1XlOY4kEzyMtns=;
        b=46ztzdBQOJiUGL53mnGxLTKy2JQlACP87rrsSgE1pzNvGDDS7hizO6SZslbcWeb6BU
         RWYSqoxcCM+z26rcrwzZM/rfCFSTqENfW9XeFVqvxriCVXgl/NP639WdHeD0A7JW9GiR
         rAapUZIjTVKGiwg1COTESGWjteCsqBZF383MZ+XDeJWGd+laF2i7srbvFLJxfTOG2iuP
         IFJGwxfa44quJdLcituKurQ0fzGh8HK9D13N2RjFGee6pMgF5lWwt97CKd5Idxs0On14
         dk9lGWJiRiJMXVAZWqy7zjIdHPdKdg4ifU7CqfrWRqkYXnms0zc6MtxvA/MfToTAayJ5
         /aew==
X-Gm-Message-State: AAQBX9eEp5QNAJQ3/KSQCMCRRuLt4VxJ+zwq4NXEOLMrdxDodJ6Dmn/x
        iIwE0tUJb2p49X8jp1BdJFwadHP3E2VybWwDuvOz/A==
X-Google-Smtp-Source: AKy350as29FZcp4Hu0tcOiv3iwZMMe8Tutrvh0MvK9Mp8FSELCYsBga7jimfk6sxXcp6Bx7kDkhWcd+YkT9zVUBO2h4=
X-Received: by 2002:a81:ac46:0:b0:544:6828:3c09 with SMTP id
 z6-20020a81ac46000000b0054468283c09mr8104683ywj.0.1680031691214; Tue, 28 Mar
 2023 12:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com> <20230328141523.txyhl7wt7wtvssea@google.com>
 <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
In-Reply-To: <CAJD7tkYo=CeXJPUi_KxjzC0QCxC2qd_J2_FQi_aXh7svD8u60A@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 12:28:00 -0700
Message-ID: <CALvZod4Gsngc6MjXdk4s5+ePVjsgcVppdRmsQovN6gSrxzdbfA@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 11:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
> > > +     if (atomic_xchg(&stats_flush_ongoing, 1))
> >
> > Have you profiled this? I wonder if we should replace the above with
> >
> >         if (atomic_read(&stats_flush_ongoing) || atomic_xchg(&stats_flu=
sh_ongoing, 1))
>
> I profiled the entire series with perf and I haven't noticed a notable
> difference between before and after the patch series -- but maybe some
> specific access patterns cause a regression, not sure.
>
> Does an atomic_cmpxchg() satisfy the same purpose? it's easier to read
> / more concise I guess.
>
> Something like
>
>     if (atomic_cmpxchg(&stats_flush_ongoing, 0, 1))
>
> WDYT?
>

No, I don't think cmpxchg will be any different from xchg(). On x86,
the cmpxchg will always write to stats_flush_ongoing and depending on
the comparison result, it will either be 0 or 1 here.

If you see the implementation of queued_spin_trylock(), it does the
same as well.
