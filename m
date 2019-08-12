Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815E2C31E40
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 10:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E50320842
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 10:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHLKZt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:25:49 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34112
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727678AbfHLKZt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 06:25:49 -0400
X-IronPort-AV: E=Sophos;i="5.64,377,1559512800"; 
   d="scan'208";a="316182877"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 12:25:45 +0200
Date:   Mon, 12 Aug 2019 12:25:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Alexander Popov <alex.popov@linux.com>
cc:     Julia Lawall <julia.lawall@lip6.fr>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jikos@kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mukesh Ojha <mojha@codeaurora.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr
Subject: Re: [PATCH] floppy: fix usercopy direction
In-Reply-To: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
Message-ID: <alpine.DEB.2.21.1908121210570.3718@hadrien>
References: <20190326220348.61172-1-jannh@google.com> <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com> <alpine.DEB.2.21.1908091555090.2946@hadrien> <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 9 Aug 2019, Alexander Popov wrote:

> On 09.08.2019 16:56, Julia Lawall wrote:
> > On Fri, 9 Aug 2019, Alexander Popov wrote:
> >> On 27.03.2019 1:03, Jann Horn wrote:
> >>> As sparse points out, these two copy_from_user() should actually be
> >>> copy_to_user().
> >>
> >> I also wrote a coccinelle rule for detecting similar bugs (adding coccinelle
> >> experts to CC).
> >>
> >>
> >> virtual report
> >>
> >> @cfu@
> >
> > You can replace the above line with @cfu exists@.  You want to find the
> > existence of such a call, not ensure that the call occurs on every
> > control-flow path, which is the default.
>
> Thanks Julia, I see `exists` allows to drop `<+ +>`, right?

Exists is more efficient when it is possible.  It just finds the existence
of a path that has the property rather than collecting information about
all paths.  It is related to <+... ...+> because for that there has to
exist at least one match.  You could probably do something like

... when any
copy_from_user
... when any

Then with exists you will consider each call one at a time.

>
> > Do you want this rule to go into the kernel?
>
> It turned out that sparse already can find these bugs.

If sparse is already doing this, then perhaps that's sufficient.  Someone
just has to be running it :)

julia

> Is this rule useful anyway? If so, I can prepare a patch.
>
> >> identifier f;
> >> type t;
> >> identifier v;
> >> position decl_p;
> >> position copy_p;
> >> @@
> >>
> >> f(..., t v@decl_p, ...)
> >> {
> >> <+...
> >> copy_from_user@copy_p(v, ...)
> >> ...+>
> >> }
> >>
> >> @script:python@
> >> f << cfu.f;
> >> t << cfu.t;
> >> v << cfu.v;
> >> decl_p << cfu.decl_p;
> >> copy_p << cfu.copy_p;
> >> @@
> >>
> >> if '__user' in t:
> >>   msg0 = "function \"" + f + "\" has arg \"" + v + "\" of type \"" + t + "\""
> >>   coccilib.report.print_report(decl_p[0], msg0)
> >>   msg1 = "copy_from_user uses \"" + v + "\" as the destination. What a shame!\n"
> >>   coccilib.report.print_report(copy_p[0], msg1)
> >>
> >>
> >> The rule output:
> >>
> >> ./drivers/block/floppy.c:3756:49-52: function "compat_getdrvprm" has arg "arg"
> >> of type "struct compat_floppy_drive_params __user *"
> >> ./drivers/block/floppy.c:3783:5-19: copy_from_user uses "arg" as the
> >> destination. What a shame!
> >>
> >> ./drivers/block/floppy.c:3789:49-52: function "compat_getdrvstat" has arg "arg"
> >> of type "struct compat_floppy_drive_struct __user *"
> >> ./drivers/block/floppy.c:3819:5-19: copy_from_user uses "arg" as the
> >> destination. What a shame!
>
