Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9FAC43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8453020BED
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy3d+uVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbgDABXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:23:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36720 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbgDABXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:23:02 -0400
Received: by mail-io1-f66.google.com with SMTP id n10so9847470iom.3;
        Tue, 31 Mar 2020 18:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2QHlAG4R2a3GsBY1Sh9yeXpBxrWZUKwyn4p8dfZUCs=;
        b=hy3d+uVWn9fBJjcef03m/QD3vQIZruQ5Af9+40C1Mcybj3hYYW6OtnmNQ6K0Hv1aAf
         F3+do+pXWHYNusCQv7vpnxT3natkYX6QxYaCc7zJu1EC1skVIIx90eEQlw/t2z/kMYjR
         HYRxlMlJNZwltiYoW/WwlzDoxi9elcsxQFbXCM+II/ON9tahA72/PLhZ0w3w03oWYLKx
         +Zzj/SzRSANY0Kh1WciHZiZxfrHZNUhubzoE6IqAugYnttlQXeT0p6Q9SQ04z9EUDMEf
         DB6CmvhhLRnG1gK2nUHGV/iZdOVvVgDJY4BVON6sTQ5dQbxVnix+1S1cJmZj8qJApNiv
         gexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2QHlAG4R2a3GsBY1Sh9yeXpBxrWZUKwyn4p8dfZUCs=;
        b=bKgF7EJg5wGcKxxDGrDK6vs/mR9w1oSAQ0Dqg/tORd8XExbAAnIqpVJ0bAYyEDc7lM
         TywgKeGOMPJrrlhH4MJSeSCHWPbqUq0GNfgJ1cM36kEapimqaGVAGli2RBHDlLGLvZO+
         8V3x8jZ25Iq62bi/PRVZK29ZOYsIMxOeE2ka7xiUcBAe7wJkzoXfRJmp1SWch/NMTidl
         TpB32WMXIM3Lt02aF37CKSG3gKHZctkmSXu5GWeCDLObVH4fTUAe25MDNvimJCd0mj8z
         HnzcFOWFZC9rfBkGH4MfgEu2N+nNmPveQZebt38DTh7c582NbOnZBEX++jzHJDZBiiHG
         KckA==
X-Gm-Message-State: ANhLgQ32DGwQrYAw1rnLgB6Ugx0+bDGPUIBb8sAasBL/64TAJyNIrIdm
        nwfvLxa9d2Xts+1Kmw46MJNcmfVtSlRYVmat20w=
X-Google-Smtp-Source: ADFU+vua/Mghg3wP2uz1d4+N70EOBTxAQsg9C+j/cD+lu2bR+th4xx/nLCk8XZ+P+5+zM8C5J7zXhb5i/jj3kAVC0OI=
X-Received: by 2002:a6b:7903:: with SMTP id i3mr9107365iop.66.1585704181384;
 Tue, 31 Mar 2020 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
 <20200326143102.GB342070@cmpxchg.org> <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
 <20200331151103.GB2089@cmpxchg.org>
In-Reply-To: <20200331151103.GB2089@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 1 Apr 2020 09:22:24 +0800
Message-ID: <CALOAHbAG=ehtwveu8DkQLkdeQEu7U3XA+LK4p_A7URQ0bW68=Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 31, 2020 at 11:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Mar 27, 2020 at 09:17:59AM +0800, Yafang Shao wrote:
> > On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
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
> > > >         MEMSTALL_WORKINGSET_THRASHING
> > > >         MEMSTALL_MEMDELAY
> > > >         MEMSTALL_SWAPIO
> > >
> > > What does this provide over the events tracked in /proc/vmstats?
> > >
> >
> > /proc/vmstat only tells us which events occured, but it can't tell us
> > how long these events take.
> > Sometimes we really want to know how long the event takes and PSI can
> > provide us the data
> > For example, in the past days when I did performance tuning for a
> > database service, I monitored that the latency spike is related with
> > the workingset_refault counter in /proc/vmstat, and at that time I
> > really want to know the spread of latencies caused by
> > workingset_refault, but there's no easy way to get it. Now with newly
> > added MEMSTALL_WORKINGSET_REFAULT, I can get the latencies caused by
> > workingset refault.
>
> Okay, but how do you use that information in practice?
>

With the newly added facility,  we can know when these events occur
and how long each event takes.
Then we can use these datas to generate a Latency Heat Map[1] and to
compare whether these latencies match with the application latencies
recoreded in its log - for example the slow query log in mysql. If the
refault latencies match with the slow query log, then these slow
queries are caused by these workingset refault.  If the refault
latencies don't match with slow query log, IOW much smaller than the
slow query log, then  the slow query log isn't caused by the
workingset refault.

High rate of refaults may not cause high pressure, if the backing
device is fast enough. While the latencies of refaults give us a
direct relationship with memory pressure.

[1]. http://www.brendangregg.com/HeatMaps/latency.html

> > > Can you elaborate a bit how you are using this information? It's not
> > > quite clear to me from the example in patch #2.
> > >
> >
> > From the traced data in patch #2, we can find that the high latencies
> > of user tasks are always type 7 of memstall , which is
> > MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
> > details of wokingset of the user tasks and think about how to improve
> > it - for example, by reducing the workingset.
>
> That's an analyses we run frequently as well: we see high pressure,
> and then correlate it with the events.
>
> High rate of refaults? The workingset is too big.
>
> High rate of compaction work? Somebody is asking for higher order
> pages under load; check THP events next.
>
> etc.
>
> This works fairly reliably. I'm curious what the extra per-event
> latency breakdown would add and where it would be helpful.
>
> I'm not really opposed to your patches it if it is, I just don't see
> the usecase right now.
>

As I explained above, the rate of these events can't give us a full
view of the memory pressure. High memory pressure may not caused by
high rate of vmstat events, while it can be caused by low rate of
events but with high latencies.  Latencies are the application really
concerns, that's why PSI is very useful for us.

Furthermore, there're some events are not recored in vmstat. e.g.

typf of memstall                                           vmstat event

MEMSTALL_KSWAPD                                pageoutrun, {pgscan,
pgsteal}_kswapd
MEMSTALL_RECLAIM_DIRECT                {pgscan,steal}_direct
MEMSTALL_RECLAIM_MEMCG                /* no event */
MEMSTALL_RECLAIM_HIGH                     /* no event */
MEMSTALL_KCOMPACTD                         compact_daemon_wake
MEMSTALL_COMPACT                              compact_{stall, fail, success}
MEMSTALL_WORKINGSET_REFAULT     workingset_refault
MEMSTALL_WORKINGSET_THRASH      /* no event */
MEMSTALL_MEMDELAY                           /* no event */
MEMSTALL_SWAPIO                                 pswpin

After we add these types of memstall, we don't need to add these
missed events one by one.

Thanks
Yafang
