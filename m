Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55248C2BA16
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 15:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21AB0206F8
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 15:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YUPehTBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgDCPsN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:48:13 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40642 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390784AbgDCPsN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 11:48:13 -0400
Received: by mail-qk1-f196.google.com with SMTP id z15so2235701qki.7
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3SpUySae/VsXCjRY3XWWqnugqthUBEDYud/syB3xOgc=;
        b=YUPehTBOR7/xLu41qUjwkoNOixxplXeO/8kGx0TNMLVCTFYs7aYJXzT2cWH3mWKIXp
         0WPC7smtZNTlXK0VMpgmZShtK8qIkas8f1wgX7JyRG9ymxBRJEIoZwmdAQlkxVqrXVXw
         yuRwkwJzd7+E7mYwbmpOulWpe4+uCga0LeggxdmysmzFcl2Z44m9tAP9mPXt3i998bR5
         MJL/tr8UQXyU/JGSqFmiFcIWDGlHuyqOdjVCTdDFRXrXjv65zuk4X4DXxVuQRwFzqY+0
         ZbAf+mNiv+aoFVAnmVkyY5QPHgqLI7xI4lult+LOsWELPEctrFhUFMnDtVM8nR6qPVLG
         cVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3SpUySae/VsXCjRY3XWWqnugqthUBEDYud/syB3xOgc=;
        b=BJLL3D3OkEU4NtMQ0BxQCBZFV2bhyAZRCd2xsda3YP6uM7i99iykEnMIBOWkR2+kek
         97CwnGiWVwmn3Uv2ZQi3lw3h5dmt6GIYr+RxcEdDs2RgBVDEUa2ZemMg748JnQD5Lokh
         aqpy+7HQw7NoqELCXvLfocqLJpiQh3DNUZy8mTXLMUDeKkaKsjlyLbYaFNVQBnrXPf6m
         PLrip2ngnBlDSXJmhpy1DTVzKzfhmth4KSI2cEo4OFgJHNDtnfs2ITaqoHCOwSY1qS+y
         phZT2PmVH6TCCeinYt0iiX3QtP4QhiWO6JZoektl39jCR9fT429X2dpy8gKRQIgJ3Z3J
         sT9g==
X-Gm-Message-State: AGi0PuZQn/8nbVv3lgsthXuxJ6kYsCrFRDQDXnW2vVf/qNC5fQfQyFCh
        KmVnvJ0nD9qPGQAN50LJACENfA==
X-Google-Smtp-Source: APiQypKT+0DknujDcCjzS1PACiAIGzRvdLTYReyXUMKf3l8bsBKyfLkVJYHDKb45rP3wEsdymxxm4Q==
X-Received: by 2002:a37:4ec1:: with SMTP id c184mr9361893qkb.0.1585928890501;
        Fri, 03 Apr 2020 08:48:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::da28])
        by smtp.gmail.com with ESMTPSA id w30sm7081523qtw.21.2020.04.03.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:48:09 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:48:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        mgorman@suse.de, Steven Rostedt <rostedt@goodmis.org>,
        mingo@redhat.com, Linux MM <linux-mm@kvack.org>,
        linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
Message-ID: <20200403154808.GB69203@cmpxchg.org>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
 <20200326143102.GB342070@cmpxchg.org>
 <CALOAHbCe9msQ+7uON=7iXnud-hzDcrnz_2er4PMQRXtNLM2BSQ@mail.gmail.com>
 <20200331151103.GB2089@cmpxchg.org>
 <CALOAHbAG=ehtwveu8DkQLkdeQEu7U3XA+LK4p_A7URQ0bW68=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAG=ehtwveu8DkQLkdeQEu7U3XA+LK4p_A7URQ0bW68=Q@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 01, 2020 at 09:22:24AM +0800, Yafang Shao wrote:
> On Tue, Mar 31, 2020 at 11:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Fri, Mar 27, 2020 at 09:17:59AM +0800, Yafang Shao wrote:
> > > On Thu, Mar 26, 2020 at 10:31 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> With the newly added facility,  we can know when these events occur
> and how long each event takes.
> Then we can use these datas to generate a Latency Heat Map[1] and to
> compare whether these latencies match with the application latencies
> recoreded in its log - for example the slow query log in mysql. If the
> refault latencies match with the slow query log, then these slow
> queries are caused by these workingset refault.  If the refault
> latencies don't match with slow query log, IOW much smaller than the
> slow query log, then  the slow query log isn't caused by the
> workingset refault.

Okay, you want to use it much finer-grained to understand individual
end-to-end latencies for your services, rather than "the system is
melting down and I want to know why." That sounds valid to me.

> > > > Can you elaborate a bit how you are using this information? It's not
> > > > quite clear to me from the example in patch #2.
> > > >
> > >
> > > From the traced data in patch #2, we can find that the high latencies
> > > of user tasks are always type 7 of memstall , which is
> > > MEMSTALL_WORKINGSET_THRASHING,  and then we should look into the
> > > details of wokingset of the user tasks and think about how to improve
> > > it - for example, by reducing the workingset.
> >
> > That's an analyses we run frequently as well: we see high pressure,
> > and then correlate it with the events.
> >
> > High rate of refaults? The workingset is too big.
> >
> > High rate of compaction work? Somebody is asking for higher order
> > pages under load; check THP events next.
> >
> > etc.
> >
> > This works fairly reliably. I'm curious what the extra per-event
> > latency breakdown would add and where it would be helpful.
> >
> > I'm not really opposed to your patches it if it is, I just don't see
> > the usecase right now.
> >
> 
> As I explained above, the rate of these events can't give us a full
> view of the memory pressure. High memory pressure may not caused by
> high rate of vmstat events, while it can be caused by low rate of
> events but with high latencies.  Latencies are the application really
> concerns, that's why PSI is very useful for us.
> 
> Furthermore, there're some events are not recored in vmstat. e.g.
> 
> typf of memstall                                           vmstat event
> 
> MEMSTALL_KSWAPD                                pageoutrun, {pgscan,
> pgsteal}_kswapd
> MEMSTALL_RECLAIM_DIRECT                {pgscan,steal}_direct
> MEMSTALL_RECLAIM_MEMCG                /* no event */
> MEMSTALL_RECLAIM_HIGH                     /* no event */
> MEMSTALL_KCOMPACTD                         compact_daemon_wake
> MEMSTALL_COMPACT                              compact_{stall, fail, success}
> MEMSTALL_WORKINGSET_REFAULT     workingset_refault
> MEMSTALL_WORKINGSET_THRASH      /* no event */
> MEMSTALL_MEMDELAY                           /* no event */
> MEMSTALL_SWAPIO                                 pswpin
> 
> After we add these types of memstall, we don't need to add these
> missed events one by one.

I'm a bit concerned about the maintainability of these things. It
makes moving code around harder, and it forces somebody who has no
interest in this debugging facility to thing about the categories.

And naming them is hard even for somebody who does care. I'm not a fan
of MEMSTALL_MEMDELAY, for example because it's way too
non-descript. The distinction between MEMSTALL_WORKINGSET_REFAULT and
MEMSTALL_WORKINGSET_THRASH is dubious as well.

These are recipes for bit rot and making the code harder to hack on.

I see two options to do this better: One is to use stack traces as
identifiers instead of a made-up type. The other is to use the calling
function as the id (see how kmalloc_track_caller() utilizes _RET_IP_).

bpftrace can use the stack as a map key. So this should already work
without any kernel modifications, using @start[tid, kstack]?
