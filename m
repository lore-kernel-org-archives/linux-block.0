Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DFC2D0E8
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67B920735
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 02:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efO09LaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgDDCzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 22:55:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44596 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgDDCzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 22:55:20 -0400
Received: by mail-il1-f194.google.com with SMTP id j69so9366308ila.11;
        Fri, 03 Apr 2020 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/GSiXHRl4dofFNbOAtNMPylFu49nhTT6CSicdQWJaI=;
        b=efO09LaUfSIK5axgkCEl5IKkOWZXHGIh52uBx+UyOOiNV1/XQ5uRRmiR02MfO+n7KI
         DOXcMQkyAa6ZDqbSXmoCF0cFCgJulXkXq5+bxFv+ooy4w7cneNMXPdbs32eRIzi0mX6h
         vI+k7wgM5E696NUzveZcTKaHhnfpG/gWRwHPsM24NqUZN1RYZNxPEG582Fu3e6sojul+
         zOzkNKooC/2hn+5MSCzWIfXUrMHDO3UZwsNXk0bkz2gBcgtol6SoV7VPSQsIVNnkB4hF
         stu/zg3b74eNHEIpG5W6Kr7uA5Y5le77LybPy5YJtmVkhCCaCVcrSNBo9ZW8RC+pLQkG
         cBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/GSiXHRl4dofFNbOAtNMPylFu49nhTT6CSicdQWJaI=;
        b=rmKF41EyY8ndMi4HozsiR334hI9/qxCz2XuLalkBoSLXQg9uUWI0cSAqGguei0jhYC
         5UeYSdXhD/eNAVPRWvtb0RkVcFg49tVLsE2WRZUjcI1N2eNt48ztaGOC4Dje6eX3ZMMv
         lIMc5SLZByUadMJeVLjJ1Lpquy/VsAPDcj0MSPOKCl8bwbu+Tp0M5KDg3M/BIHALNJC/
         MqGgKzBRvlNT41PldDFGCnehSTsQLpSTzZA5i2tbCTnn5CuVaTRBiFxhHAE9ia+rhzdt
         e+O5Ut2YNTg61vAttR1YR6YOim8JqHWFzTN5xrPBLmu8kUm5vBqtP1a99WYkK6glH/Z4
         BYRw==
X-Gm-Message-State: AGi0PuaW5wn4qaobFl+ZldiChHFa3byMQPrzBa1GSy7bAEJnU/lYGeyB
        o0L8UVEfM+7Vx9W6umKNk4lLQizBEuLm739Hm9I=
X-Google-Smtp-Source: APiQypKMkpO+oiW32MXjJHNwe7B81gmonNreOAGrfLDk/e3eWodCpY7uoaNvSfB+8NxfBtVia3u7oFpElIy6C8cw+7A=
X-Received: by 2002:a05:6e02:811:: with SMTP id u17mr11414585ilm.93.1585968918595;
 Fri, 03 Apr 2020 19:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
 <20200326143102.GB342070@cmpxchg.org> <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
 <20200331151103.GB2089@cmpxchg.org> <CALOAHbAG=ehtwveu8DkQLkdeQEu7U3XA+LK4p_A7URQ0bW68=Q@mail.gmail.com>
 <20200403154808.GB69203@cmpxchg.org>
In-Reply-To: <20200403154808.GB69203@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 4 Apr 2020 10:54:42 +0800
Message-ID: <CALOAHbAffyX5JMxahMAaHSV7A2pC4WxR93gUjfuBZG+CnE8PdA@mail.gmail.com>
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

On Fri, Apr 3, 2020 at 11:48 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 01, 2020 at 09:22:24AM +0800, Yafang Shao wrote:
> > On Tue, Mar 31, 2020 at 11:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > On Fri, Mar 27, 2020 at 09:17:59AM +0800, Yafang Shao wrote:
> > > > On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > With the newly added facility,  we can know when these events occur
> > and how long each event takes.
> > Then we can use these datas to generate a Latency Heat Map[1] and to
> > compare whether these latencies match with the application latencies
> > recoreded in its log - for example the slow query log in mysql. If the
> > refault latencies match with the slow query log, then these slow
> > queries are caused by these workingset refault.  If the refault
> > latencies don't match with slow query log, IOW much smaller than the
> > slow query log, then  the slow query log isn't caused by the
> > workingset refault.
>
> Okay, you want to use it much finer-grained to understand individual
> end-to-end latencies for your services, rather than "the system is
> melting down and I want to know why." That sounds valid to me.
>

Right, individual end-to-end latencies are very important for the
latency sensitive services.

> > > > > Can you elaborate a bit how you are using this information? It's not
> > > > > quite clear to me from the example in patch #2.
> > > > >
> > > >
> > > > From the traced data in patch #2, we can find that the high latencies
> > > > of user tasks are always type 7 of memstall , which is
> > > > MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
> > > > details of wokingset of the user tasks and think about how to improve
> > > > it - for example, by reducing the workingset.
> > >
> > > That's an analyses we run frequently as well: we see high pressure,
> > > and then correlate it with the events.
> > >
> > > High rate of refaults? The workingset is too big.
> > >
> > > High rate of compaction work? Somebody is asking for higher order
> > > pages under load; check THP events next.
> > >
> > > etc.
> > >
> > > This works fairly reliably. I'm curious what the extra per-event
> > > latency breakdown would add and where it would be helpful.
> > >
> > > I'm not really opposed to your patches it if it is, I just don't see
> > > the usecase right now.
> > >
> >
> > As I explained above, the rate of these events can't give us a full
> > view of the memory pressure. High memory pressure may not caused by
> > high rate of vmstat events, while it can be caused by low rate of
> > events but with high latencies.  Latencies are the application really
> > concerns, that's why PSI is very useful for us.
> >
> > Furthermore, there're some events are not recored in vmstat. e.g.
> >
> > typf of memstall                                           vmstat event
> >
> > MEMSTALL_KSWAPD                                pageoutrun, {pgscan,
> > pgsteal}_kswapd
> > MEMSTALL_RECLAIM_DIRECT                {pgscan,steal}_direct
> > MEMSTALL_RECLAIM_MEMCG                /* no event */
> > MEMSTALL_RECLAIM_HIGH                     /* no event */
> > MEMSTALL_KCOMPACTD                         compact_daemon_wake
> > MEMSTALL_COMPACT                              compact_{stall, fail, success}
> > MEMSTALL_WORKINGSET_REFAULT     workingset_refault
> > MEMSTALL_WORKINGSET_THRASH      /* no event */
> > MEMSTALL_MEMDELAY                           /* no event */
> > MEMSTALL_SWAPIO                                 pswpin
> >
> > After we add these types of memstall, we don't need to add these
> > missed events one by one.
>
> I'm a bit concerned about the maintainability of these things. It
> makes moving code around harder, and it forces somebody who has no
> interest in this debugging facility to thing about the categories.
>
> And naming them is hard even for somebody who does care. I'm not a fan
> of MEMSTALL_MEMDELAY, for example because it's way too
> non-descript. The distinction between MEMSTALL_WORKINGSET_REFAULT and
> MEMSTALL_WORKINGSET_THRASH is dubious as well.
>

Agree with you that the naming is not good.

> These are recipes for bit rot and making the code harder to hack on.
>
> I see two options to do this better: One is to use stack traces as
> identifiers instead of a made-up type. The other is to use the calling
> function as the id (see how kmalloc_track_caller() utilizes _RET_IP_).
>
> bpftrace can use the stack as a map key. So this should already work
> without any kernel modifications, using @start[tid, kstack]?
>

If we don't make any kernel modifications, it is not easy to get
whehter the psi_memstall_{enter, leave} is nested or not.
The nested psi_memstall_{enter, leave} may make some noises.
Seems the first option is better. With _RET_IP_ we can also get the caller.
So how about adding tracepoints for psi_memstall_{enter, leave} as bellow ?

@@ -904,7 +904,7 @@ void psi_memstall_enter(unsigned long *flags, enum
memstall_types type)
          if (*flags)
                return;

 +         trace_psi_memstall_enter(_RET_IP_);

@@ -944,7 +943,7 @@ void psi_memstall_leave(unsigned long *flags, enum
memstall_types type)
        if (*flags)
                return;

+       trace_psi_memstall_leave(_RET_IP_);

Thanks
Yafang
