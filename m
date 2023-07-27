Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BDC0015E
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 14:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjG0O6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jul 2023 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjG0O6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jul 2023 10:58:21 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A34EF2
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:57:34 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7659cb9c42aso86831985a.3
        for <linux-block@vger.kernel.org>; Thu, 27 Jul 2023 07:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690469853; x=1691074653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP07akpCQjmMIwXcUEYhyRveLa+yD/aWHNIEKHhYFEs=;
        b=Fh4iUYZL8iOrGpc//sdzGZoc+ymh9EypsqznAX9mv66cU4dA02XyvQQ13bVhdZ0r+Q
         FXysiWRGfwm7OIUqro9KKT7y0B9YNr+20lgfs4EqzbVmn9+9p/uE39jTRoGWfLP3KYMh
         mJDG2Oa1NvVVEqjkGV3TKwvgByOE+pa1E5GXpkUXmUXTUko7D90/ZC0+uZm0xI+KJdPf
         NxWmTcGlI7jOZ//pKeZlE1QhhSS2QxkP/iZIx+nPGx5XUaOQMtn8ki4YGM4VLn3T01MD
         PtTwrUqMDRRxg9Jo6D7qhj4UyiAX+vPFafh4UQg/nYtjpoXkiwgxnYtFOevihn+KHQdK
         l3Lw==
X-Gm-Message-State: ABy/qLZ753cp+eZSCWK1nB6HoH5iobyj1ajsfaL74qMrlvua0w0jV83h
        DBTSkAM+Hh1ycCRVEkYjihOx
X-Google-Smtp-Source: APBJJlFEzloiPRqwkyzK+fQhDRtucqMH1nAQ8qGdSpCUNzXj8k+aObkoUbZ0NUe9eAm8PjuNOlQBJQ==
X-Received: by 2002:ae9:f448:0:b0:76c:6f89:48c3 with SMTP id z8-20020ae9f448000000b0076c6f8948c3mr157656qkl.78.1690469853391;
        Thu, 27 Jul 2023 07:57:33 -0700 (PDT)
Received: from localhost ([37.19.196.190])
        by smtp.gmail.com with ESMTPSA id pe19-20020a05620a851300b0076768dfe53esm453683qkn.105.2023.07.27.07.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 07:57:32 -0700 (PDT)
Date:   Thu, 27 Jul 2023 10:57:31 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Ken Raeburn <raeburn@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        vdo-devel@redhat.com, tj@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v2 00/39] Add the dm-vdo deduplication and compression
 device mapper target.
Message-ID: <ZMKF24poWyKdeRHO@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
 <ZLa086NuWiMkJKJE@redhat.com>
 <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
 <87cz0e9rkn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cz0e9rkn.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 26 2023 at  7:32P -0400,
Ken Raeburn <raeburn@redhat.com> wrote:

> 
> An offline discussion suggested maybe I should've gone into a little
> more detail about how VDO uses its work queues.
> 
> VDO is sufficiently work-intensive that we found long ago that doing all
> the work in one thread wouldn't keep up.
> 
> Our multithreaded design started many years ago and grew out of our
> existing design for UDS (VDO's central deduplication index), which,
> somewhat akin to partitioning and sharding in databases, does scanning
> of the in-memory part of the "database" of values in some number (fixed
> at startup) of threads, with the data and work divided up based on
> certain bits of the hash value being looked up, and performs its I/O and
> callbacks from certain other threads. We aren't splitting work to
> multiple machines as database systems sometimes do, but to multiple
> threads and potentially multiple NUMA nodes.
> 
> We try to optimize for keeping the busy case fast, even if it means
> light usage loads don't perform quite as well as they could be made to.
> We try to reduce instances of contention between threads by avoiding
> locks when we can, preferring a fast queueing mechanism or loose
> synchronization between threads. (We haven't kept to it strictly, but
> we've mostly tried to.)
> 
> In VDO, at the first level, the work is split according to the
> collection of data structures to be updated (e.g., recovery journal vs
> disk block allocation vs block address mapping management).
> 
> For some data structures, we split the structures further based on
> values of relevant bit-strings for the data structure in question (block
> addresses, hash values). Currently we can split the work N ways for many
> small values of N but it's hard to change N without restarting. The
> processing of a read or write operation generally doesn't need to touch
> more than one "zone" in any of these sets (or two, in a certain write
> case).
> 
> Giving one thread exclusive access to the data structures means we can
> do away with the locking. Of course, with so many different threads
> owning data structures, we get a lot of queueing in exchange, but we
> depend on a fast, nearly-lock-free MPSC queueing mechanism to keep that
> reasonably efficient.
> 
> There's a little more to it in places where we need to preserve the
> order of processing of multiple VIOs in a couple different sections of
> the write path. So we do make some higher-level use of the fact that
> we're adding work to queues with certain behavior, and not just turning
> loose a bunch of threads to contend for a just-released mutex.
> 
> Some other bits of work like computing the hash value don't update any
> other data structures, and not only would be amenable to kernel
> workqueue conversion with concurrency greater than 1, but such a
> conversion might open up some interesting options, like hashing on the
> CPU or NUMA node where the data block is likely to reside in cache. But
> for now, using one work management mechanism has been easier than two.
> 
> The experiment I referred to in my earlier email with using kernel
> workqueues in VDO kept the same model of protecting data structures by
> making them exclusive to specific threads (or in this case,
> concurrency-1 workqueues) to serialize all access and using message
> passing; it didn't change everything over to using mutexes instead.
> 
> I hope some of this helps. I'm happy to answer further questions.
> 
> Ken
> 

Thanks for the extra context, but a _big_ elephant in the room for
this line of discussion is that: the Linux workqueue code has
basically always been only available for use by GPL'd code.  Given
VDO's historic non-GPL origins, it seems _to me_ that an alternative
to Linux's workqueues had to be created to allow VDO to drive its
work.  While understandable, I gave guidance 6 years ago that VDO
engineering should work to definitively reconcile if using Linux
workqueues viable now that VDO has been GPL'd.

But it appears there wasn't much in the way of serious effort put to
completely converting to using Linux workqueues.  That is a problem
because all of the work item strategy deployed by VDO is quite
bespoke.  I don't think the code lends itself to being properly
maintained by more than a 1 or 2 engineers (if we're lucky at this
point).

And while I appreciate that the prospect of _seriously_ converting
over to using Linux workqueues is itself destabilizing and challenging
effort: it seems that it needs to be done to legitimately position the
code to go upstream.

I would like to see a patch crafted that allows branching between the
use of Linux and VDO workqueues. Initially have a dm-vdo modparam
(e.g. use_vdo_wq or vice-versa: use_linux_wq).  And have a wrapping
interface and associated data struct(s) that can bridge between work
being driven/coordinated by either (depending on disposition of
modparam).

This work isn't trivial, I get that. But it serves to clearly showcase
shortcomings, areas for improvement, while pivoting to more standard
Linux interfaces that really should've been used from VDO's inception.

Is this work that you feel you could focus on with urgency?

Thanks,
Mike
