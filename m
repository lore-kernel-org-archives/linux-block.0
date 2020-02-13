Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2DC352A4
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C8921739
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 01:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbKK3eHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgBMBYd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:24:33 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35968 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbgBMBYd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 20:24:33 -0500
Received: by mail-ot1-f45.google.com with SMTP id j20so4011357otq.3
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PILiMPIWP83o9BEbVPcc2wkT+EgjSJOcxDjVmVXRxQ4=;
        b=VbKK3eHv0jEZv+wG5KpbnI+nM5uIG95ROVb5rMd+HdMnBiiloxF3M2au9YKpNlMvH3
         HX7AJll9ycYr+HTlyWJcvPNGwpm+O+QBAONVVfsQNkontupQ94WNAdKrExlHzC2/Ri+v
         bqhIYD2mo9AbtO1Gi2XcQxcJNXn1iynTWrEa8nJttq3QPbX1JgMynf1VXNPRRc0ZoGrP
         6/H6eqa+ALrZ11hbuNORzH4xwlJxImKe/Pe/K9RI83dJGi9g/rRyaV12RbUdWmn9xO93
         yid562ZhiigWEUUE7BBedZWIJwWrNf+UgeMAsyz5m42OXRW66L4H0b0eVUHfioHsXR04
         B1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PILiMPIWP83o9BEbVPcc2wkT+EgjSJOcxDjVmVXRxQ4=;
        b=WtEzbimTxNoqK9Nc1X+gTc0j4jnb0X62zZoSuhMtVhBeuTvQOwkQRuWR/hmFlUbcyy
         UgKTw+MKJPSKM5SZXBeuVxZTaYk0xS0sOJWjxcCju47mdPpPXnHT4aAMWddTmXOwfJSs
         R294322cvOnyvA3vEQfPMHRTSCcA+VbRSdITJIfHwdehKy4OdsNxQsyI/IfW/JfclhML
         H2BSSua8icVqxcc5jPR5761Tnu6hjaVFma2FxNj4G4pqpwrjhgBvdpLTWIuaZqIkykMO
         U42WV6ITAs3OYEWJx3XSC/YYRq/gF7ItD07REnoBMjOuM27UlH0rM4fWjAJd0+S/Qbjr
         PjFg==
X-Gm-Message-State: APjAAAWGY8Yui6y21tFlYcrnjsChsWzdPepRW1qucqMt/OEQn7rcNAzx
        hKa8BGObaV8UdPkIj1PsC0BlkNX+d/TLdLAoVNcZvQ==
X-Google-Smtp-Source: APXvYqyxb54hnCS3lFIqw5xbxKQtpV/D8VX7T2q4SiMXZ9DPJBX2YlSEIb4y3hV6TTULD7kKC0IdHQiVeth+Nvi6JpA=
X-Received: by 2002:a9d:7f83:: with SMTP id t3mr7941193otp.63.1581557072210;
 Wed, 12 Feb 2020 17:24:32 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200212230652.GA145444@mit.edu> <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
In-Reply-To: <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Wed, 12 Feb 2020 17:24:19 -0800
Message-ID: <CAJmaN=kYvGWs=e_ee-DgRs2yW1UFgypKGxOTW2u1MSz1zkmHgQ@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Salman Qazi <sqazi@google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 5:20 PM Salman Qazi <sqazi@google.com> wrote:
>
> On Wed, Feb 12, 2020 at 3:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > This is a problem we've been strugging with in other contexts.  For
> > example, if you have the hung task timer set to 2 minutes, and the
> > system to panic if the hung task timer exceeds that, and an NFS server
> > which the client is writing to crashes, and it takes longer for the
> > NFS server to come back, that might be a situation where we might want
> > to exempt the hung task warning from panic'ing the system.  On the
> > other hand, if the process is failing to schedule for other reasons,
> > maybe we would still want the hung task timeout to go off.
> >
> > So I've been meditating over whether the right answer is to just
> > globally configure the hung task timer to something like 5 or 10
> > minutes (which would require no kernel changes, yay?), or have some
> > way of telling the hung task timeout logic that it shouldn't apply, or
> > should have a different timeout, when we're waiting for I/O to
> > complete.
>
> The problem that I anticipate in our space is that a generous timeout
> will make impatient people reboot their chromebooks, losing us
> information
> about hangs.  But, this can be worked around by having multiple
> different timeouts.  For instance, a thread that is expecting to do
> something slow, can set a flag
> to indicate that it wishes to be held against the more generous
> criteria.  This is something I am tempted to do on older kernels where
> we might not feel
> comfortable backporting io_uring.

I was going to reply along the same lines when I got distracted by a
mtg.  If anything I'd like to see a LOWER hung task timeout, generally
speaking.  And maybe that means having more operations be asynchronous
like Ted suggests (I'm generally a fan of that anyway).

[snipped good suggestion about async interface]

Jesse
