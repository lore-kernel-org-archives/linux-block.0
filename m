Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C53FC433E6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7370E2076C
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 03:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChXd0Ebn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGPDTX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgGPDTV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 23:19:21 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BFC061755;
        Wed, 15 Jul 2020 20:19:21 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c16so4517845ioi.9;
        Wed, 15 Jul 2020 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnZOL6HRqScQnYHTHjj8Lsq7JLhMkooWzCSxNal6lJg=;
        b=ChXd0EbnTGIYNSJ4QMMTQkoXexH8r/VaQw4m2Uo3H4eoG69eUJKMaoi6tbBn0zMzev
         mYLkKxah5c18A8N2icjH3YYRg1IKfLwoRc3uDjfMuhdIl0/DbKTkKB0KGHzRE0hvEVNQ
         3JoU9S2ibRhJlcaORQIU/9xthgJHkzV3Fqby19y0MWafr2+GMkK/ly63JljsUFyX9lfr
         NlKnqmySE+Zzsmaw5QMuKJHcDGPzW4/YWVNq/7LMZz+tRyZghq6WEx8PvTUtsefLcNTR
         QuUbpdYfg3WEoLViEchqhOIKxK1EKmLzCRg9TPbAMQVGpzHuxtlwzylTI21tmesdCODX
         NfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnZOL6HRqScQnYHTHjj8Lsq7JLhMkooWzCSxNal6lJg=;
        b=DuoNAlyIxy7/l9twMha8/yXk2iRxrekQcHE1BsLA4zJ3Y/T3lXxfvSMCL1H/3bIqvj
         fus9Uxwuwtnol/VUFrlqJXt8xTUhPVp2n/rhUgISZHQ5FG2/ZYTbbKNSy8a4ni4lTnrq
         CauKmF6dihd2rOC3f5uiRTSrd3GoKAZ2gHSepusuUcS6YRjm4v1s8+Ehzvuo4JZEP6ga
         7PLZ+rkvBiNJ4vaIlLFfZ1prVS9CwgbCWcPfQYYOmpJDcz+m2xw7gpfMnIJOYZkCezLp
         vaLyF+H+eclqlmXMzt9b9aLeO3l+rAVe+jkodrJRU1DemA/Pt5/fdr6wD+5ME0Y92/qH
         iSXQ==
X-Gm-Message-State: AOAM531cuC/3wlpUgJjMstbeXoD732dXX4T+49zoXrHi6sw3MeLlZDR3
        JT2fXKa4JisRFakaWgxSHAQjDiWIPyRgm12kDcA=
X-Google-Smtp-Source: ABdhPJykR1pPQktU6DP4xptM8uEyTeohejJ218u/CEGWCWchdeOMVNbjY5zKD2r8UwquIQt7p4UfGUYGyWe20LRC7kg=
X-Received: by 2002:a02:a797:: with SMTP id e23mr2800056jaj.81.1594869560712;
 Wed, 15 Jul 2020 20:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com> <CALvZod6Yn=_fYEM+xN3a+4W2e5CCLkvMXZg_txD3j+dZieX-CQ@mail.gmail.com>
In-Reply-To: <CALvZod6Yn=_fYEM+xN3a+4W2e5CCLkvMXZg_txD3j+dZieX-CQ@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 16 Jul 2020 11:18:44 +0800
Message-ID: <CALOAHbB_Koc8MTCqEg5Ev8mccqCGrBvPieCg+aeogn2PDuKFeg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] psi: enhance psi with the help of ebpf
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 12:36 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Hi Yafang,
>
> On Tue, Mar 31, 2020 at 3:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > PSI gives us a powerful way to anaylze memory pressure issue, but we can
> > make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> > Especially with ebpf we can flexiblely get more details of the memory
> > pressure.
> >
> > In orderc to achieve this goal, a new parameter is added into
> > psi_memstall_{enter, leave}, which indicates the specific type of a
> > memstall. There're totally ten memstalls by now,
> >         MEMSTALL_KSWAPD
> >         MEMSTALL_RECLAIM_DIRECT
> >         MEMSTALL_RECLAIM_MEMCG
> >         MEMSTALL_RECLAIM_HIGH
> >         MEMSTALL_KCOMPACTD
> >         MEMSTALL_COMPACT
> >         MEMSTALL_WORKINGSET_REFAULT
> >         MEMSTALL_WORKINGSET_THRASH
> >         MEMSTALL_MEMDELAY
> >         MEMSTALL_SWAPIO
> > With the help of kprobe or tracepoint to trace this newly added agument we
> > can know which type of memstall it is and then do corresponding
> > improvement. I can also help us to analyze the latency spike caused by
> > memory pressure.
> >
> > But note that we can't use it to build memory pressure for a specific type
> > of memstall, e.g. memcg pressure, compaction pressure and etc, because it
> > doesn't implement various types of task->in_memstall, e.g.
> > task->in_memcgstall, task->in_compactionstall and etc.
> >
> > Although there're already some tracepoints can help us to achieve this
> > goal, e.g.
> >         vmscan:mm_vmscan_kswapd_{wake, sleep}
> >         vmscan:mm_vmscan_direct_reclaim_{begin, end}
> >         vmscan:mm_vmscan_memcg_reclaim_{begin, end}
> >         /* no tracepoint for memcg high reclaim*/
> >         compcation:mm_compaction_kcompactd_{wake, sleep}
> >         compcation:mm_compaction_begin_{begin, end}
> >         /* no tracepoint for workingset refault */
> >         /* no tracepoint for workingset thrashing */
> >         /* no tracepoint for use memdelay */
> >         /* no tracepoint for swapio */
> > but psi_memstall_{enter, leave} gives us a unified entrance for all
> > types of memstall and we don't need to add many begin and end tracepoints
> > that hasn't been implemented yet.
> >
> > Patch #2 gives us an example of how to use it with ebpf. With the help of
> > ebpf we can trace a specific task, application, container and etc. It also
> > can help us to analyze the spread of latencies and whether they were
> > clustered at a point of time or spread out over long periods of time.
> >
> > To summarize, with the pressure data in /proc/pressure/memroy we know that
> > the system is under memory pressure, and then with the newly added tracing
> > facility in this patchset we can get the reason of this memory pressure,
> > and then thinks about how to make the change.
> > The workflow can be illustrated as bellow.
> >
> >                    REASON         ACTION
> >                  | compcation   | improve compcation    |
> >                  | vmscan       | improve vmscan        |
> > Memory pressure -| workingset   | improve workingset    |
> >                  | etc          | ...                   |
> >
>
> I have not looked at the patch series in detail but I wanted to get
> your thoughts if it is possible to achieve what I am trying to do with
> this patch series.
>
> At the moment I am only interested in global reclaim and I wanted to
> enable alerts like "alert if there is process stuck in global reclaim
> for x seconds in last y seconds window" or "alert if all the processes
> are stuck in global reclaim for some z seconds".
>
> I see that using this series I can identify global reclaim but I am
> wondering if alert or notifications are possible. Android is using psi
> monitors for such alerts but it does not use cgroups, so, most of the
> memstalls are related to global reclaim stall. For cgroup environment,
> do we need for add support to psi monitor similar to this patch
> series?
>

Hi Shakeel,

We use the PSI tracepoints in our kernel to analyze the individual
latency caused by memory pressure, but the PSI tracepoints are
implemented with a new version as bellow:
    trace_psi_memstall_enter(_RET_IP_);
    trace_psi_memstall_leave(_RET_IP_);
And then using the _RET_IP_ to identify the specific PSI type.

If the _RET_IP_ is at try_to_free_mem_cgroup_pages(), then it means
the pressure caused by the memory cgroup, IOW, the limit of memcg is
reached and it has to do memcg reclaim. Otherwise we can consider it
as global memory pressure.
try_to_free_mem_cgroup_pages
    psi_memstall_enter
        if (static_branch_likely(&psi_disabled))
            return;
        *flags = current->in_memstall;
         if (*flags)
             return;
         trace_psi_memstall_enter(_RET_IP_);  <<<<< memcg pressure


-- 
Thanks
Yafang
