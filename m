Return-Path: <SRS0=JlK2=XS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F9AC04EBF
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45AA20835
	for <linux-block@archiver.kernel.org>; Mon, 23 Sep 2019 11:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbfIWLnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Sep 2019 07:43:45 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35308 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726146AbfIWLnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 07:43:45 -0400
X-IronPort-AV: E=Sophos;i="5.64,539,1559512800"; 
   d="scan'208";a="402978736"
Received: from unknown (HELO hadrien) ([65.39.69.237])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 13:43:42 +0200
Date:   Mon, 23 Sep 2019 13:43:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Alexey Dobriyan <adobriyan@gmail.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: sched: make struct task_struct::state 32-bit
In-Reply-To: <d529c390-546e-a8a4-f475-c3ee41f97645@arm.com>
Message-ID: <alpine.DEB.2.21.1909231340090.2227@hadrien>
References: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com> <7e3e784c-e8e6-f9ba-490f-ec3bf956d96b@web.de> <0c4dcb91-4830-0013-b8c6-64b9e1ce47d4@arm.com> <32d65b15-1855-e7eb-e9c4-81560fab62ea@arm.com> <alpine.DEB.2.21.1909231228200.2272@hadrien>
 <d529c390-546e-a8a4-f475-c3ee41f97645@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >> // FIXME: match functions that do something with state_var underneath?
> >> // How to do recursive rules?
> >
> > You want to look at the definitions of called functions?  Coccinelle
> > doesn't really support that, but there are hackish ways to add that.  How
> > many function calls would you expect have to be unrolled?
> >
>
> I wouldn't expect more than a handful (~5). I suppose this has to do with
> injecting some Python/Ocaml code? I have some examples bookmarked but
> haven't gotten to stare at them long enough.

You can look at iteration.cocci, but it's a bit complex.

You could match definitions of functions that do what you are interested
in, then store the names of these functions in a list (python/ocaml), and
then look for calls to those functions.  Something like

identifier fn : script:ocaml() { in_my_list fn };

> >> // Fixup local variables
> >> @depends on patch && state_access@
> >> identifier state_var = state_access.state_var;
> >> @@
> >> (
> >> - long
> >> + int
> >> |
> >> - unsigned long
> >> + unsigned int
> >> )
> >> state_var;
> >>
> >> // Fixup function parameters
> >> @depends on patch && state_access@
> >> identifier fn;
> >> identifier state_var = state_access.state_var;
> >> @@
> >>
> >> fn(...,
> >> - long state_var
> >> + int state_var
> >> ,...)
> >> {
> >> 	...
> >> }
> >>
> >> // FIXME: find a way to squash that with the above?
> >
> > I think that you can make a disjunction on a function parameter
> >
> > fn(...,
> > (
> > - T1 x1
> > + T2 x2
> > |
> > - T3 x3
> > + T4 x4
> > )
> > , ...) { ... }
> >
>
> My attempt at this gives me "minus: parse error", which is why I went
> with the split.

OK, the split is probably not a major catastrophe...

julia

>
> Something simple like this works:
> ---
> virtual patch
> virtual report
>
> @@
> identifier fn;
> identifier p;
> @@
>
> fn(...,
> - long
> + int
> p
> ,...)
> {
> 	...
> }
> ---
>
> but this doesn't:
> ---
> virtual patch
> virtual report
>
> @@
> identifier fn;
> identifier p;
> @@
>
> fn(...,
> (
> - long p
> + int p
> |
> - unsigned long p
> + unsigned int p
> )
> ,...)
> {
> 	...
> }
> ---
>
> > julia
> >
>
