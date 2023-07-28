Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E778C0015E
	for <linux-block@archiver.kernel.org>; Fri, 28 Jul 2023 14:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbjG1OuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jul 2023 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjG1OuC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 10:50:02 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BB44209
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 07:49:10 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a37909a64eso1747880b6e.1
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 07:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555749; x=1691160549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjrvcJKebeEwg9LTzLTjWACkgonOIQA7bC9s/xETMO8=;
        b=BT/8mcNKEgYCSLnput+tNonHf4kfjoWmdSFiUGOjGhd1rC4T4dcuc1eaiPUIDsuu7m
         Yqpp6BJGxNvl5w3c4FZqMSVChntK5K01IFA98vc0JSLFwrB2hBHIfH4mG6eYssd9ZODj
         GbXNvJZ2GKThUCzhRrRtlWLHq1PL/raYgHfC/b4++9fCBu1ACBJRfI0S9KuIQaSVdfki
         WJbBJqHNuJ4+HIS30tHtzU3ykCMlSAsOos5bK5gSaeItmT9F3VR9TCnfDWJOudcgwolJ
         FUdy31UuqUQTbkrtwYHWWROTmXQszjrLi64kWaWZgyxT265ImJjLLiQ3c6SxZGhWU1E8
         qmWg==
X-Gm-Message-State: ABy/qLZMf+mElv0QyGpjb5TmhC+/vkv9y+iz3iB1r1F/MwvoBWgBD+l+
        RQ/LHjEOKAGghuhpDnx2X0UCSvFcjXCyL4LAxg==
X-Google-Smtp-Source: APBJJlGlkWiCzOmra139l12mk7kimCXAWMjL9VN0DfWLIroxj7ZxsY565yQSDv3HLOAwVY0HSwwYBQ==
X-Received: by 2002:a05:6358:2808:b0:138:dd09:8679 with SMTP id k8-20020a056358280800b00138dd098679mr3175670rwb.2.1690555749491;
        Fri, 28 Jul 2023 07:49:09 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0063d0f1db105sm1309899qvm.32.2023.07.28.07.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:49:09 -0700 (PDT)
Date:   Fri, 28 Jul 2023 10:49:07 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Ken Raeburn <raeburn@redhat.com>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com, ebiggers@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2 00/39] Add the dm-vdo deduplication and compression
 device mapper target.
Message-ID: <ZMPVY5wW9GTIwlLZ@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <ZLa086NuWiMkJKJE@redhat.com>
 <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
 <87cz0e9rkn.fsf@redhat.com>
 <ZMKF24poWyKdeRHO@redhat.com>
 <874jloa18b.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jloa18b.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 28 2023 at  4:28P -0400,
Ken Raeburn <raeburn@redhat.com> wrote:

> 
> Mike Snitzer <snitzer@kernel.org> writes:
> > Thanks for the extra context, but a _big_ elephant in the room for
> > this line of discussion is that: the Linux workqueue code has
> > basically always been only available for use by GPL'd code.  Given
> > VDO's historic non-GPL origins, it seems _to me_ that an alternative
> > to Linux's workqueues had to be created to allow VDO to drive its
> > work.  While understandable, I gave guidance 6 years ago that VDO
> > engineering should work to definitively reconcile if using Linux
> > workqueues viable now that VDO has been GPL'd.
> 
> Yes, initially that was a significant reason.
> 
> More recently, when we've tried switching, the performance loss made it
> appear not worth the change. Especially since we also needed to ship a
> usable version at the same time.
> 
> > But it appears there wasn't much in the way of serious effort put to
> > completely converting to using Linux workqueues. That is a problem
> > because all of the work item strategy deployed by VDO is quite
> > bespoke.  I don't think the code lends itself to being properly
> > maintained by more than a 1 or 2 engineers (if we're lucky at this
> > point).
> 
> By "work item strategy" are you referring to the lower level handling of
> queueing and executing the work items? Because I've done that. Well, the
> first 90%, by making the VDO work queues function as a shim on top of
> the kernel ones instead of creating their own threads. It would also
> need the kernel workqueues modified to support the SYSFS and ORDERED
> options together, because on NUMA systems the VDO performance really
> tanks without tweaking CPU affinity, and one or two other small
> additions. If we were to actually commit to that version there might be
> additional work like tweaking some data structures and eliding some shim
> functions if appropriate, but given the performance loss, we decided to
> stop there.

There needs to be a comprehensive audit of the locking and the
granularity of work.  The model VDO uses already requires that
anything that needs a continuation is assigned to the same thread
right?  Matt said that there is additional locking in the rare case
that another thread needs read access to an object.

Determining how best to initiate the work VDO requires (and provide
mutual exclusion that still allows concurrency is the goal). Having a
deep look at this is needed.
 
> Or do you mean the use of executing all actions affecting a data
> structure in a single thread/queue via message passing to serialize
> access to data structures instead of having a thread serially lock,
> modify, and unlock the various different data structures on behalf of a
> single I/O request, while another thread does the same for another I/O
> request? The model we use can certainly make things more difficult to
> follow. It reads like continuation-passing style code, not the
> straight-line code many of us are more accustomed to.
> 
> "Converting to using Linux workqueues" really doesn't say the latter to
> me, it says the former. But I thought I'd already mentioned I'd tried
> the former out. (Perhaps not very clearly?)

The implicit locking of the VDO thread assignment model needs to be
factored out.  If 'use_vdo_wq' is true then the locking operations are
a noop. But if Linux workqueues are used then appropriate locking
needed.

FYI, dm-cache-target.c uses a struct continuation to queue a sequence
of work.  Can VDO translate its ~12 stages of work into locking a vio
and using continuations to progress through the stages?  The locking
shouldn't be overbearing since VDO is already taking steps to isolate
the work to particular threads.

Also, just so you're aware DM core now provides helpers to shard a
data structures locking (used by dm-bufio and dm-bio-prison-v1).  See
dm_hash_locks_index() and dm_num_hash_locks().

> > I would like to see a patch crafted that allows branching between the
> > use of Linux and VDO workqueues. Initially have a dm-vdo modparam
> > (e.g. use_vdo_wq or vice-versa: use_linux_wq).  And have a wrapping
> > interface and associated data struct(s) that can bridge between work
> > being driven/coordinated by either (depending on disposition of
> > modparam).
> 
> If we're talking about the lower level handling, I don't think it would
> be terribly hard.
> 
> > This work isn't trivial, I get that. But it serves to clearly showcase
> > shortcomings, areas for improvement, while pivoting to more standard
> > Linux interfaces that really should've been used from VDO's inception.
> >
> > Is this work that you feel you could focus on with urgency?
> >
> > Thanks,
> > Mike
> 
> I think so, once we're clear on exactly what we're talking about...

I'm talking about a comprehensive audit of how work is performed.  And
backfilling proper locking by factoring out adequate protection that
allows conditional use of locking (e.g. IFF using linux workqueues).

In the end, using either VDO workqueue or Linux workqueues must pass
all VDO tests.

Mike
