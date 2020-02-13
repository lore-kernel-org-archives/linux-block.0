Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C46C352A4
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D8E222C2
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 01:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDyUKoU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgBMBUu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:20:50 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:36548 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbgBMBUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 20:20:50 -0500
Received: by mail-il1-f181.google.com with SMTP id b15so3521650iln.3
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 17:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHNas6UsXn7Nf8sBWZiCEeYXkSgWOiwfe+b1rjkowDU=;
        b=jDyUKoU12U5rX4bR742TJbOo0bcz8Ph6GJnr7yKk8hsnm8+zh0h8WvzQ+5/ExuJJd9
         K1V4U05uH/IE3a/IloM1LlHZ2XAMM+pHD7V2kTN5M1H8cHTKl04gYepCTbPBfi8MCa4G
         b4K/LiyRKLaEblX1V1Zx7K3Nyf1SMqGCvBE1/i5O+QmifHakisvf5o/4JttKOW7dByQb
         rtal656EZxAH4RilPS1U01l8EV6J4SQTj/FFMZult3+yzr4b2eH82B9ef0TuGCjtLQsS
         RZgRDpQvcEwX000bTGLxMoxtMNlLTvTTn6LkbNaS7Ek1GNGnVG+37SxBY357R4saWJ4O
         6IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHNas6UsXn7Nf8sBWZiCEeYXkSgWOiwfe+b1rjkowDU=;
        b=BALCzl4iYAT4qKH+Iwnk1+omHvgu71p+S75t2ZCaMrOsEWbPtuLUuErrBEEg5zQjQQ
         ExhSNRj87t/yeFZPEfK5biQtzc5xDHvVaxcWwrtJvMl/p9tD1UqnA9baC1E0eM4/Q6iq
         mu09M0dIkUy4DLMfvqMsfsOXmpmgluMvRyomSA1Us+ao0NmUbAH+oGgMbJo1Ie00aGLW
         cgK4VOcZQCN7oK09J+velu2NFAwgz4QL3+pwywYEYY2iIWS8sLHEo7pofDKiKSSXhazg
         SCLfQWm3svAPMROWxaftaPXLm+4QSX9o13Z3gQtdss1pcRTQtdpd4z6a5P3SHA3w+8Mu
         fkuQ==
X-Gm-Message-State: APjAAAXnv93Ytvk4ctwnOJvCKnP1c8879cLi2K7knitiXdiWuO0cyYre
        Pn4A1y5TBgWaq409mJjQ2Gy5EkPbm+ji5nHmcdeDIA==
X-Google-Smtp-Source: APXvYqyNpvHvjqpaaZba0hZuyG5sXWzOSR2xDWNUcLL2J13F009UDLsF4Rm3JnE6GLQT48KmEBZIr1Uk+FTKLg2QnvE=
X-Received: by 2002:a05:6e02:df2:: with SMTP id m18mr13577866ilj.56.1581556849306;
 Wed, 12 Feb 2020 17:20:49 -0800 (PST)
MIME-Version: 1.0
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200212230652.GA145444@mit.edu>
In-Reply-To: <20200212230652.GA145444@mit.edu>
From:   Salman Qazi <sqazi@google.com>
Date:   Wed, 12 Feb 2020 17:20:38 -0800
Message-ID: <CAKUOC8UwjUyX1Ou-Gad29-DsyYHMtmLjwV9_0ghGUx=ys_drbA@mail.gmail.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 3:07 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> This is a problem we've been strugging with in other contexts.  For
> example, if you have the hung task timer set to 2 minutes, and the
> system to panic if the hung task timer exceeds that, and an NFS server
> which the client is writing to crashes, and it takes longer for the
> NFS server to come back, that might be a situation where we might want
> to exempt the hung task warning from panic'ing the system.  On the
> other hand, if the process is failing to schedule for other reasons,
> maybe we would still want the hung task timeout to go off.
>
> So I've been meditating over whether the right answer is to just
> globally configure the hung task timer to something like 5 or 10
> minutes (which would require no kernel changes, yay?), or have some
> way of telling the hung task timeout logic that it shouldn't apply, or
> should have a different timeout, when we're waiting for I/O to
> complete.

The problem that I anticipate in our space is that a generous timeout
will make impatient people reboot their chromebooks, losing us
information
about hangs.  But, this can be worked around by having multiple
different timeouts.  For instance, a thread that is expecting to do
something slow, can set a flag
to indicate that it wishes to be held against the more generous
criteria.  This is something I am tempted to do on older kernels where
we might not feel
comfortable backporting io_uring.

>
> It seems to me that perhaps there's a different solution here for your
> specific case, which is what if there is a asynchronous version of
> BLKSECDISCARD, either using io_uring or some other interface?  That
> bypasses the whole issue of how do we modulate the hung task timeout
> when it's a situation where maybe it's OK for a userspace thread to
> block for more than 120 seconds, without having to either completely
> disable the hung task timeout, or changing it globally to some much
> larger value.

This is worth evaluating.

Thanks,

Salman

>
>                                         - Ted
