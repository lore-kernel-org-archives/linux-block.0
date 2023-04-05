Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE513C76188
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237302AbjDEIDD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 04:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbjDEIDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 04:03:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E505261
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 01:02:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t10so138820711edd.12
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 01:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680681758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEwjzYcWs+Nq2B13OiqxRc4o61ZYX+Tx79hgu5r8M58=;
        b=RPHLXw9sSgwpHJr/+l3qfC5nPoEvslH4Vlvp7ZohRVeJUYUwEgpmuvPKwY6/LAXZ4c
         UOr2vNt2IlvzNfCaVQTdzSrG/5hklqwq4qvvOX5tzuKA2xdV4XLARc3NBhi1qSAOQjD1
         cAmoZtTp54aqHRdSbkkOPSuSe2DuJuiQ60d3rrjhRuEDjbeDCiCtdJofsgfVpbUXlEjX
         CQZYdJCMd59NPSp5JXIV8SyRsgFDebBJEr+pQBUnYDWZ3fuQ/FuyH+8DnTaPmUf7AJD/
         oDSYlI8G38WcKprwnEqQcqTjojvsHbIsQB/2aZR84YGGUdCVPwVqmG5BIFmMQrVLugm6
         fcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEwjzYcWs+Nq2B13OiqxRc4o61ZYX+Tx79hgu5r8M58=;
        b=cxOLPnT+JTT+FKJ4KCEVNq4TcWiHKDlY/cJU+PnWn7obAvVOnWe3gEzvWxkxdx9KIc
         autQOWNRh0AUWRWNEEF40Pspwb9kB79bq/2xNtkfJBlL/V8gYuaKueW2Uh54x6F/XLaJ
         KGgVpFgtNpv+wp44xCU8AdEJNm408wNG6cSy0hhUsCL/TiqSVry8x0Bp+t18Y58YZ9rD
         HbnPXpM6Mj52F3KTqNSpLSK83IfYcIIALj5HWruUiRPeLV8ALbw8CbEx89nwInQuRmuD
         JBVX8eQhusRzf1jDoswnqlpH0EsbfU+N5Pm18l7fB4apWpDe40oF3KHrhHRK2r5LVizg
         6U5w==
X-Gm-Message-State: AAQBX9frlB5FgsfIG9zMuJS3MMe85ENA4lc1J+YsR8Mj8bJAWGiq+szz
        PozLXj7qHSZXHe712oPxY314wuB7yte24NBFM1pSPQ==
X-Google-Smtp-Source: AKy350bXpxYlvw6dqDC/3+ZE/o8/JBMCNfQUvuJlpr105khYN6b3g46OQoameMWIodO45GVOZYCuDafAJ9j07z3+Rb4=
X-Received: by 2002:a17:907:2075:b0:947:72cd:9325 with SMTP id
 qp21-20020a170907207500b0094772cd9325mr1212514ejb.15.1680681758108; Wed, 05
 Apr 2023 01:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
 <20230330191801.1967435-7-yosryahmed@google.com> <20230404165305.ffs7uscqpndnfytn@blackpad>
 <CAJD7tkb-0rXL9V2TX-Ax-3OkwJPYx_GaOT4D=VCA60riit+dOw@mail.gmail.com> <20230405080047.5omnatjbwz46f3y5@blackpad>
In-Reply-To: <20230405080047.5omnatjbwz46f3y5@blackpad>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Apr 2023 01:02:01 -0700
Message-ID: <CAJD7tkZ=o42N_45LxRPg=oOg56Lqn-wqT_0JJUPPoKOB+ig2JQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 5, 2023 at 1:00=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> On Tue, Apr 04, 2023 at 11:09:02AM -0700, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > IIUC there are multiple places where we can sleep in this path, we can
> > sleep waiting for a page to be read from disk, we can sleep during
> > allocating the page to read into, and IIUC the allocations on the
> > fault path can even run into reclaim, going into the vmscan code. So
> > there are precedents, but I am not sure if that's enough argument.
>
> I expect it'd depend on the proportion of the slow/fast paths.
> OK, let's see how it turns out in wider population.

Agreed. It also depends on the number of memcgs and how much the
periodic flusher is keeping up. I think no amount of testing will
cover all or even most workloads.

>
> Thanks,
> Michal
