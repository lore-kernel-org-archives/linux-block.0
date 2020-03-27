Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5709DC2D0EC
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 01:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E22D20857
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 01:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErC7gJ2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgC0BSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 21:18:38 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40835 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbgC0BSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 21:18:38 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so7338937ilr.7;
        Thu, 26 Mar 2020 18:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3J6Daz6wR+/gwmuLEW0pap6CJc1mq3+fsvcbg3bR/mk=;
        b=ErC7gJ2pSdXGWgCl+BtFEjg8ncyU3bi5/7A8vCLaivlvIDsV4Adn4H36vuvx5k7leJ
         peaeyGh1NgBbYWFinlmcXeNOapjSTXNQHIYNLTuWfaybzDx7x9uaBvu8Qw94qX0yTz2j
         b6nNbUHmhwxSHO5gDWNF/63yrpHERa5efATwGXedVrGdaW+cVWQF7QBi6s6+P3zt6RXT
         1yEHuXpGxK0AwTIvhzg3O2DVq/f8V569u0PRMHquwHGhfO9nLdkm+4Bi3OKEKpcDh6gG
         cLBz1qkxBpGkww6ydaNMRhb1lZmrgeWvEKz0rS4I0fLK8fQIdNkQsJ484vVuLTHCIJ/x
         ccpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3J6Daz6wR+/gwmuLEW0pap6CJc1mq3+fsvcbg3bR/mk=;
        b=HY2RczutdCoS/ytZv5nLYSM9BS7AtDpOCbRAlpObg2t7Nf900gtDnuZKgQf9yk6NaA
         5w+0QhkMn/O4Vv7mVJPoGCfLeLvrdV0FCHnuaRutsF9RHCDFBSAVjbYcihPG2hAm1EXE
         c9TyvNVTnDK0dqN/edQ2uqOBYBkNOEpPESXfB1qT6XPNvvt9RMC2m86n7WRgtL+8OIk0
         OwLsG+PYsXSlvuoVBdJBnKwLlfl940Vf5QZIfq7jqKacxjvpVvOf4BL9049dKDc5TB4B
         APpj2DF2pQtLhD37ZOM2w7KbLIaT93DATbiJx8MP0aFz/WfCWdgY44ttk4zScit0t0Jj
         wWhQ==
X-Gm-Message-State: ANhLgQ1KF6j6D2h/PA9bCCjOlWNUHZJxq6qdG6ePb6nW23Rs0RO5LZYi
        g+k4ECvIkbYoQ7Z5JZH/h9BmrSHRG2kfbDjxNcw=
X-Google-Smtp-Source: ADFU+vulu/vI3kwqdbc2oRSG/1hF43/XgdyXecjFY74DaUm2NhvhtICjXGqjbaiLtaI4Kb8iF9ezaarRO0kAiyYAnuk=
X-Received: by 2002:a92:7b10:: with SMTP id w16mr11322764ilc.93.1585271915967;
 Thu, 26 Mar 2020 18:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com> <20200326143102.GB342070@cmpxchg.org>
In-Reply-To: <20200326143102.GB342070@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 27 Mar 2020 09:17:59 +0800
Message-ID: <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
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

On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
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
> >         MEMSTALL_WORKINGSET_THRASHING
> >         MEMSTALL_MEMDELAY
> >         MEMSTALL_SWAPIO
>
> What does this provide over the events tracked in /proc/vmstats?
>

/proc/vmstat only tells us which events occured, but it can't tell us
how long these events take.
Sometimes we really want to know how long the event takes and PSI can
provide us the data
For example, in the past days when I did performance tuning for a
database service, I monitored that the latency spike is related with
the workingset_refault counter in /proc/vmstat, and at that time I
really want to know the spread of latencies caused by
workingset_refault, but there's no easy way to get it. Now with newly
added MEMSTALL_WORKINGSET_REFAULT, I can get the latencies caused by
workingset refault.

> Can you elaborate a bit how you are using this information? It's not
> quite clear to me from the example in patch #2.
>

From the traced data in patch #2, we can find that the high latencies
of user tasks are always type 7 of memstall , which is
MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
details of wokingset of the user tasks and think about how to improve
it - for example, by reducing the workingset.

BTW, there's some error in the definition of show_psi_memstall_type()
in patch #2 ( that's an old version), I will correct it.

To summarize, with the pressure data in /proc/pressure/memroy we know
that the system is under memory pressure, and then with the newly
added tracing facility in this patchset we can get the reason of this
memory pressure, and then thinks about how to make the change.
The workflow can be illustrated as bellow.

                                      REASON        ACTION
                                |    compaction  |  look into the
details of compaction |
Memory pressure -  |    vmscan        |  look into the details of vmscan       |
                                |    workingset   |  look into the
details of workingset   |
                                |     etc              |   ...
                                           |


Thanks

Yafang
