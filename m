Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86951C433EF
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 17:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D18161002
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 17:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhKJRvj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 12:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhKJRvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 12:51:33 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC008C061220
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 09:48:23 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g17so8340360ybe.13
        for <linux-block@vger.kernel.org>; Wed, 10 Nov 2021 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNHVVa6gv7z3dFlgEcituEPBx6aIWi4uliGKTG3gzjI=;
        b=qLmXdLt4YOVMgrzsS5BXEUYiJevmzqMjguHecWqoDcWTEsy74/p4NvsXb/LRZFkqGJ
         KhCWxNDSNHskY6KB2iMjRPfe5Y3fqFyPGxIytmN+X0UAayfYz6lOPXpDfqtRvdGdHmzi
         FtF0aZ5WCHIP3ioTdmDGtdqhYagHRZjSY8+p0rMVnVsMSfymyS/fXWqdGZnsf42PNfgE
         mNQw8LAQCVeiTEquV2CIvo9/bLSPNT0zxilW25HhKQu21qKwI/DTvxEWCzOQidlHTyY3
         RL5T2R6A2hNmaBfGnO3ZDvB7UGeuWCeqOy7HkG1FKg7y+9C69m7/xZJGTyPrdXquocIS
         NFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNHVVa6gv7z3dFlgEcituEPBx6aIWi4uliGKTG3gzjI=;
        b=qpl204yhuybxRbI53dLFCY2++liZA307AT+beYKA3xM/nWsUBQ0S3S/3hy1NMijKZi
         iQkhhPkOvIxh6fr9sIqD7uWEWa1i8mkMaTxANTYsMzNtufCorMG5mJAUHLVeELGcNXTW
         4UAgMvHb3dhT+IBj4DAt2rfuJzTilg0PUUA30ZFd+BpqTwAwDQvWB/fELzwIiuXO2gOL
         PvEHqQCpLKFPywVZdxRp1P9EpO7hE1k+d87nbTkTBDpbc2HqXEyk+8JJ5jmod2fJ+q2M
         khI95uRSgdmeee6iFVEPwL7AbhDwAV81KK06hVNaBAxWq4YfO56Wb4Y9alEYu38KuDij
         tJhg==
X-Gm-Message-State: AOAM531GFqMe7xs5tLWMrpKZrhh6Z/hZqsZdnbLmJT8I7axx2VNbt5Hz
        mBBWcvOxXFX41ANTX+H6sqmCyVJxr2d6lQ/QHl89Gg==
X-Google-Smtp-Source: ABdhPJzrykT3dyEuXyJOwpTgNgF1rS/2Zem47Hc09Yaees7H87Arp4lp7y5GOAaNmY0j3HE0mpPOPMhKiENFNoOsu3w=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr1047967ybv.487.1636566502780;
 Wed, 10 Nov 2021 09:48:22 -0800 (PST)
MIME-Version: 1.0
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
 <20211110161402.GB174703@worktop.programming.kicks-ass.net> <1fd2d97b-7c83-3a82-ada3-46ec5025c3b1@kernel.org>
In-Reply-To: <1fd2d97b-7c83-3a82-ada3-46ec5025c3b1@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 10 Nov 2021 09:48:10 -0800
Message-ID: <CAJuCfpFP2VP_t_tP27w=k4HDhm=jv=G2C56mM_kbs6wqux+DhA@mail.gmail.com>
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory pressure
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, hannes@cmpxchg.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 10, 2021 at 8:46 AM Georgi Djakov <djakov@kernel.org> wrote:
>
>
> On 10.11.21 18:14, Peter Zijlstra wrote:
> > On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
> >> @@ -21,7 +19,18 @@ enum psi_task_count {
> >>       * don't have to special case any state tracking for it.
> >>       */
> >>      NR_ONCPU,
> >> -    NR_PSI_TASK_COUNTS = 4,
> >> +    NR_BLK_CGROUP_THROTTLE,
> >> +    NR_BIO,
> >> +    NR_COMPACTION,
> >> +    NR_THRASHING,
> >> +    NR_CGROUP_RECLAIM_HIGH,
> >> +    NR_CGROUP_RECLAIM_HIGH_SLEEP,
> >> +    NR_CGROUP_TRY_CHARGE,
> >> +    NR_DIRECT_COMPACTION,
> >> +    NR_DIRECT_RECLAIM,
> >> +    NR_READ_SWAPPAGE,
> >> +    NR_KSWAPD,
> >> +    NR_PSI_TASK_COUNTS = 16,
> >>   };
> >>
> >
> >> @@ -51,9 +80,20 @@ enum psi_states {
> >>      PSI_MEM_FULL,
> >>      PSI_CPU_SOME,
> >>      PSI_CPU_FULL,
> >> +    PSI_BLK_CGROUP_THROTTLE,
> >> +    PSI_BIO,
> >> +    PSI_COMPACTION,
> >> +    PSI_THRASHING,
> >> +    PSI_CGROUP_RECLAIM_HIGH,
> >> +    PSI_CGROUP_RECLAIM_HIGH_SLEEP,
> >> +    PSI_CGROUP_TRY_CHARGE,
> >> +    PSI_DIRECT_COMPACTION,
> >> +    PSI_DIRECT_RECLAIM,
> >> +    PSI_READ_SWAPPAGE,
> >> +    PSI_KSWAPD,
> >>      /* Only per-CPU, to weigh the CPU in the global average: */
> >>      PSI_NONIDLE,
> >> -    NR_PSI_STATES = 7,
> >> +    NR_PSI_STATES = 18,
> >>   };
> >
> > Have you considered what this does to psi_group_cpu's size and layout
> > and the impact thereof on performance?
>
> Thanks, i will definitely add some numbers in case there are no other
> major arguments against this RFC patch.

Please CC me too in the future postings.
Thanks,
Suren.

>
> BR,
> Georgi
>
