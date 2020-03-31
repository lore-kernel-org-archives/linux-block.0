Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD6FC43331
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C34B20848
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 15:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="wAFNN/UM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgCaPLH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:11:07 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:45185 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCaPLG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 11:11:06 -0400
Received: by mail-qv1-f66.google.com with SMTP id g4so10980796qvo.12
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cL08A4+kp0Y65AGLtqIoipG3SABzeYJkBubqqjwQrYg=;
        b=wAFNN/UMuvu+vH9ES4W5SFNAVQYgWw45te05ekS4MQu7vEn7mxRosfgjeRbU3HiEAq
         hUnlFE/DdeULkB891pVk8cdhRoYRQZSTgsAVDJP6Pg/ZtPIN2xPS+7aCiX/i9kpstFZC
         nI3k03KbtEY+bcIQriZyQl90tTpaRsfj9nIEafKhQ1sxNc1fu3xTpgYwPDmQNRO9MpC+
         BTqrNwSsj9qOUOdsTvZcPfw35IbXlLcCKCARpsi4Y/nSexlhABrVoP5pWvOPRHZFpltY
         76ctavOq5D/flZ8NBqsajomS/yb4+k8cLYxHZLXCIIRGpFZm38okEgNvLePyq2IPU0WQ
         5Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cL08A4+kp0Y65AGLtqIoipG3SABzeYJkBubqqjwQrYg=;
        b=O7BQMo48hQaZM9i72m2PpzbAagrcUlVlsFkyA2yg7+i39EsDifCPrqYX4e0LqNC3xV
         Y5crQf3yZajP2sIEeccXDJncvrYS8depx3dJGHGtFKA6xMorMFCTlE4NcBWfVXsxt89r
         hsXO+pkzokzuq+Wg/P8e5fCd7OSNpPU2Fn18CiXRchXVY1MI+wx/UqlwyL0HFDXdVkLk
         pXHYBXmS2nUWPHqdKyfibNDg+S+lcgrRP0iO5OHgIqafTArUeGJwm1CONyiSUDAapuwU
         pq49UWXkCku4u4KYHzLPAPmB9vsRDvbH+PnITaDHRt8JOle9JBSzdRUNcETNBr+n6Y67
         QeXA==
X-Gm-Message-State: ANhLgQ2SeapQmbAk7AgQKOHunngBj2qJ/sgB4Jhff6rhXfojn3hptxAH
        jLm3ylgQEmpr2LgPjP5L7PeVNw==
X-Google-Smtp-Source: ADFU+vt3LCjS0xkXV3rjTOBSJRA2OF5NbQ3lYcpN2wK4TAg1p0cskQb+ade5qXppPN1vNqf2ot/j1A==
X-Received: by 2002:ad4:4364:: with SMTP id u4mr16331097qvt.58.1585667465461;
        Tue, 31 Mar 2020 08:11:05 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t43sm13933859qtc.14.2020.03.31.08.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:11:04 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:11:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
Message-ID: <20200331151103.GB2089@cmpxchg.org>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
 <20200326143102.GB342070@cmpxchg.org>
 <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 27, 2020 at 09:17:59AM +0800, Yafang Shao wrote:
> On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
> > > PSI gives us a powerful way to anaylze memory pressure issue, but we can
> > > make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> > > Especially with ebpf we can flexiblely get more details of the memory
> > > pressure.
> > >
> > > In orderc to achieve this goal, a new parameter is added into
> > > psi_memstall_{enter, leave}, which indicates the specific type of a
> > > memstall. There're totally ten memstalls by now,
> > >         MEMSTALL_KSWAPD
> > >         MEMSTALL_RECLAIM_DIRECT
> > >         MEMSTALL_RECLAIM_MEMCG
> > >         MEMSTALL_RECLAIM_HIGH
> > >         MEMSTALL_KCOMPACTD
> > >         MEMSTALL_COMPACT
> > >         MEMSTALL_WORKINGSET_REFAULT
> > >         MEMSTALL_WORKINGSET_THRASHING
> > >         MEMSTALL_MEMDELAY
> > >         MEMSTALL_SWAPIO
> >
> > What does this provide over the events tracked in /proc/vmstats?
> >
> 
> /proc/vmstat only tells us which events occured, but it can't tell us
> how long these events take.
> Sometimes we really want to know how long the event takes and PSI can
> provide us the data
> For example, in the past days when I did performance tuning for a
> database service, I monitored that the latency spike is related with
> the workingset_refault counter in /proc/vmstat, and at that time I
> really want to know the spread of latencies caused by
> workingset_refault, but there's no easy way to get it. Now with newly
> added MEMSTALL_WORKINGSET_REFAULT, I can get the latencies caused by
> workingset refault.

Okay, but how do you use that information in practice?

> > Can you elaborate a bit how you are using this information? It's not
> > quite clear to me from the example in patch #2.
> >
> 
> From the traced data in patch #2, we can find that the high latencies
> of user tasks are always type 7 of memstall , which is
> MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
> details of wokingset of the user tasks and think about how to improve
> it - for example, by reducing the workingset.

That's an analyses we run frequently as well: we see high pressure,
and then correlate it with the events.

High rate of refaults? The workingset is too big.

High rate of compaction work? Somebody is asking for higher order
pages under load; check THP events next.

etc.

This works fairly reliably. I'm curious what the extra per-event
latency breakdown would add and where it would be helpful.

I'm not really opposed to your patches it if it is, I just don't see
the usecase right now.
