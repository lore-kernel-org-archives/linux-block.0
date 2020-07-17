Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14253C433DF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 01:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D092070E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 01:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUpHlW5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgGQBoZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQBoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 21:44:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041CC061755;
        Thu, 16 Jul 2020 18:44:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y2so8660281ioy.3;
        Thu, 16 Jul 2020 18:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QzsHeBtWdfPRJc72cjcNJ2eDpwrQoR+YjWmSQsKGCU=;
        b=TUpHlW5DHmCjWYFJ26FnI50sVyMu3sXI1wh3Cb/tZ4MumMTdK1cUrHVERMcZDmaeG0
         eumY6AF63FEZi3Bv42zAyCzl8lDFw3a/5HXSr4eIc7M9VX6NWGKXM8etA/hmBSRv2qsq
         s/MXpLja9oDT+SCOZIPtkq813R3xZm/XWeauu7xD1RhwGfFhTuIMXg0vEKAjfNeq5gZD
         WKpoKskIkFNxiZcwQRjhsmIHHUMCWNiV4ibO27IEV3ib/8dTYUe1ML4aJv8b6ZPgwdHh
         Hr2237S4OU/UNhnMpkE2moODtWC9BNGbUwGamJ2UzpxS/VUt2ywvz7w/UlEbO58FJclQ
         czag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QzsHeBtWdfPRJc72cjcNJ2eDpwrQoR+YjWmSQsKGCU=;
        b=esEtf2YmwflECScxEzOhcgbuHKVDHZdhoAqI/4aO3IGZKBwuphY20UtbtegIvaPC+h
         ulVg7BgcgfkNhJEFlSajn5HB7XQV7mIm421mMP3T98MkyFjvxz9NdiJ2IjTdMEcR3hi9
         CGx84yi1EL/6TE1v6kTEMN8U7T0C6XhMwcjKbmjE446Fo0ZzAo/kzIeTRxQPy0paaAm0
         YRpUoVqXOARQ6tGN2efdTOEQNSZueGmyUET6fBtpgAXUoRP1xMVU9/DJEbfe3Nez7kW4
         B48YrSNX63OO9t14DcdYBzDYmnvtMFLKou15FVOEFNxiH/KLNnntfZeme5g1wSs3pWw+
         eUvw==
X-Gm-Message-State: AOAM530zlPoSDjM44HUkp7tHySIntT7xFlakgYJ4jiv8E+o0NyBKv/Bn
        8Lb9U05O3POOmCC6gW5yD1llQt/fCVtEnmm3Wgdqt3DYn28=
X-Google-Smtp-Source: ABdhPJyZFH/Nv24e1GTUAjN9roKJWlI71UI6ebSWu/k9tEF0QIjoZgP3E1NE4EqeWwMzxE/GhRf8PvsrMBihz+BmUKc=
X-Received: by 2002:a02:3905:: with SMTP id l5mr8633273jaa.64.1594950264076;
 Thu, 16 Jul 2020 18:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <1585649077-10896-1-git-send-email-laoar.shao@gmail.com>
 <CALvZod6Yn=_fYEM+xN3a+4W2e5CCLkvMXZg_txD3j+dZieX-CQ@mail.gmail.com>
 <CALOAHbB_Koc8MTCqEg5Ev8mccqCGrBvPieCg+aeogn2PDuKFeg@mail.gmail.com> <CALvZod4D4H70XJYUcY=5NxHcRUff+17Qz2OegXVm8wnoZ1TfuA@mail.gmail.com>
In-Reply-To: <CALvZod4D4H70XJYUcY=5NxHcRUff+17Qz2OegXVm8wnoZ1TfuA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 17 Jul 2020 09:43:48 +0800
Message-ID: <CALOAHbBkQbw49T=22zdiK9BzEvy7fEmCmhhJh3mTkm3JvjsD_g@mail.gmail.com>
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

On Fri, Jul 17, 2020 at 1:04 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Jul 15, 2020 at 8:19 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Jul 16, 2020 at 12:36 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > Hi Yafang,
> > >
> > > On Tue, Mar 31, 2020 at 3:05 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > PSI gives us a powerful way to anaylze memory pressure issue, but we can
> > > > make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> > > > Especially with ebpf we can flexiblely get more details of the memory
> > > > pressure.
> > > >
> > > > In orderc to achieve this goal, a new parameter is added into
> > > > psi_memstall_{enter, leave}, which indicates the specific type of a
> > > > memstall. There're totally ten memstalls by now,
> > > >         MEMSTALL_KSWAPD
> > > >         MEMSTALL_RECLAIM_DIRECT
> > > >         MEMSTALL_RECLAIM_MEMCG
> > > >         MEMSTALL_RECLAIM_HIGH
> > > >         MEMSTALL_KCOMPACTD
> > > >         MEMSTALL_COMPACT
> > > >         MEMSTALL_WORKINGSET_REFAULT
> > > >         MEMSTALL_WORKINGSET_THRASH
> > > >         MEMSTALL_MEMDELAY
> > > >         MEMSTALL_SWAPIO
> > > > With the help of kprobe or tracepoint to trace this newly added agument we
> > > > can know which type of memstall it is and then do corresponding
> > > > improvement. I can also help us to analyze the latency spike caused by
> > > > memory pressure.
> > > >
> > > > But note that we can't use it to build memory pressure for a specific type
> > > > of memstall, e.g. memcg pressure, compaction pressure and etc, because it
> > > > doesn't implement various types of task->in_memstall, e.g.
> > > > task->in_memcgstall, task->in_compactionstall and etc.
> > > >
> > > > Although there're already some tracepoints can help us to achieve this
> > > > goal, e.g.
> > > >         vmscan:mm_vmscan_kswapd_{wake, sleep}
> > > >         vmscan:mm_vmscan_direct_reclaim_{begin, end}
> > > >         vmscan:mm_vmscan_memcg_reclaim_{begin, end}
> > > >         /* no tracepoint for memcg high reclaim*/
> > > >         compcation:mm_compaction_kcompactd_{wake, sleep}
> > > >         compcation:mm_compaction_begin_{begin, end}
> > > >         /* no tracepoint for workingset refault */
> > > >         /* no tracepoint for workingset thrashing */
> > > >         /* no tracepoint for use memdelay */
> > > >         /* no tracepoint for swapio */
> > > > but psi_memstall_{enter, leave} gives us a unified entrance for all
> > > > types of memstall and we don't need to add many begin and end tracepoints
> > > > that hasn't been implemented yet.
> > > >
> > > > Patch #2 gives us an example of how to use it with ebpf. With the help of
> > > > ebpf we can trace a specific task, application, container and etc. It also
> > > > can help us to analyze the spread of latencies and whether they were
> > > > clustered at a point of time or spread out over long periods of time.
> > > >
> > > > To summarize, with the pressure data in /proc/pressure/memroy we know that
> > > > the system is under memory pressure, and then with the newly added tracing
> > > > facility in this patchset we can get the reason of this memory pressure,
> > > > and then thinks about how to make the change.
> > > > The workflow can be illustrated as bellow.
> > > >
> > > >                    REASON         ACTION
> > > >                  | compcation   | improve compcation    |
> > > >                  | vmscan       | improve vmscan        |
> > > > Memory pressure -| workingset   | improve workingset    |
> > > >                  | etc          | ...                   |
> > > >
> > >
> > > I have not looked at the patch series in detail but I wanted to get
> > > your thoughts if it is possible to achieve what I am trying to do with
> > > this patch series.
> > >
> > > At the moment I am only interested in global reclaim and I wanted to
> > > enable alerts like "alert if there is process stuck in global reclaim
> > > for x seconds in last y seconds window" or "alert if all the processes
> > > are stuck in global reclaim for some z seconds".
> > >
> > > I see that using this series I can identify global reclaim but I am
> > > wondering if alert or notifications are possible. Android is using psi
> > > monitors for such alerts but it does not use cgroups, so, most of the
> > > memstalls are related to global reclaim stall. For cgroup environment,
> > > do we need for add support to psi monitor similar to this patch
> > > series?
> > >
> >
> > Hi Shakeel,
> >
> > We use the PSI tracepoints in our kernel to analyze the individual
> > latency caused by memory pressure, but the PSI tracepoints are
> > implemented with a new version as bellow:
> >     trace_psi_memstall_enter(_RET_IP_);
> >     trace_psi_memstall_leave(_RET_IP_);
> > And then using the _RET_IP_ to identify the specific PSI type.
> >
> > If the _RET_IP_ is at try_to_free_mem_cgroup_pages(), then it means
> > the pressure caused by the memory cgroup, IOW, the limit of memcg is
> > reached and it has to do memcg reclaim. Otherwise we can consider it
> > as global memory pressure.
> > try_to_free_mem_cgroup_pages
> >     psi_memstall_enter
> >         if (static_branch_likely(&psi_disabled))
> >             return;
> >         *flags = current->in_memstall;
> >          if (*flags)
> >              return;
> >          trace_psi_memstall_enter(_RET_IP_);  <<<<< memcg pressure
> >
>
> Thanks for the response. I am looking for 'always on' monitoring. More
> specifically defining the system level SLIs based on PSI. My concern
> with ftrace is its global shared state and also it is not really for
> 'always on' monitoring. You have mentioned ebpf. Is ebpf fine for
> 'always on' monitoring and is it possible to notify user space by ebpf
> on specific conditions (e.g. a process stuck in global reclaim for 60
> seconds)?
>

ebpf is fine for  'always on' monitoring  from my experience, but I'm
not sure whether it is possible to notify user space on specific
conditions.
Notifying user space would be a useful feature, so I think we can have a try.


-- 
Thanks
Yafang
