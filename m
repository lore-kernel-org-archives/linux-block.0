Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E8BC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 18:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8538861105
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 18:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDBSa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 14:30:26 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45915 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbhDBSaU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Apr 2021 14:30:20 -0400
Received: by mail-pg1-f171.google.com with SMTP id j34so2023039pgj.12;
        Fri, 02 Apr 2021 11:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRkD1TJOSJMcMv2UCmJTMCJhp0vcI/x373113VjrgTM=;
        b=n+QCCnHFWAsw5tt2dSCT5Khm87fAzK05mhUKu2q6HA0lHcy7AlTHlFvS/2LmOyGwni
         FQDi+env3RiEt4UiAML7iDK5BAhOSLrzwMxOQwUUAYYKeS/uEhSFkrdz8E6zj/SaAJ1L
         d3MMjFgRDr4T2nl2PLFVdwe3Em2NUDBnl+DPB3Z0FONxpJB9aN5O7p3NF5nGt5/iQ7Sm
         /dyN91cWsApqRE8GAN+UUdx2/TleUk4ScEvODMoLQFk4FF4mQvMlSJux3vlLJeu9ILcV
         N7ApUQ1hMEDwKFRG1Dg12CL2WNezzppZOLfuqlFZRYFKVT2Ca5TG7r4sPDIzJYTN1x4H
         O92Q==
X-Gm-Message-State: AOAM530aI3TIRYjAPPQpG+yjrCXHQvnUxAhwHYtk0lzLP3/f6tPjSD9g
        yIuB4+DwDFTL3D/vhtRGzaQ=
X-Google-Smtp-Source: ABdhPJxYdv8/EDpCAQoe5gyEnTs18oyjAWzFJvJGO9nu1+gnu5+bcLkDpIMfk459EHLAMDM3lBhoig==
X-Received: by 2002:a62:8f4a:0:b029:20a:448e:7018 with SMTP id n71-20020a628f4a0000b029020a448e7018mr13037098pfd.62.1617388218342;
        Fri, 02 Apr 2021 11:30:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gw20sm8272518pjb.3.2021.04.02.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 11:30:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CB79A404D5; Fri,  2 Apr 2021 18:30:16 +0000 (UTC)
Date:   Fri, 2 Apr 2021 18:30:16 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210402183016.GU4332@42.do-not-panic.com>
References: <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGbNpLKXfWpy0ZZa@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 02, 2021 at 09:54:12AM +0200, Greg KH wrote:
> On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > As for the syfs deadlock possible with drivers, this fixes it in a generic way:
> > 
> > commit fac43d8025727a74f80a183cc5eb74ed902a5d14
> > Author: Luis Chamberlain <mcgrof@kernel.org>
> > Date:   Sat Mar 27 14:58:15 2021 +0000
> > 
> >     sysfs: add optional module_owner to attribute
> >     
> >     This is needed as otherwise the owner of the attribute
> >     or group read/store might have a shared lock used on driver removal,
> >     and deadlock if we race with driver removal.
> >     
> >     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> No, please no.  Module removal is a "best effort",

Not for live patching. I am not sure if I am missing any other valid
use case?

> if the system dies when it happens, that's on you. 

I think the better approach for now is simply to call testers / etc to
deal with this open coded. I cannot be sure that other than live
patching there may be other valid use cases for module removal, and for
races we really may care for where userspace *will* typically be mucking
with sysfs attributes. Monitoring my systems's sysfs attributes I am
actually quite surprised at the random pokes at them.

> I am not willing to expend extra energy
> and maintance of core things like sysfs for stuff like this that does
> not matter in any system other than a developer's box.

Should we document this as well? Without this it is unclear that tons of
random tests are sanely nullified. At least this dead lock I spotted can
be pretty common form on many drivers.

> Lock data, not code please.  Trying to tie data structure's lifespans
> to the lifespan of code is a tangled mess, and one that I do not want to
> add to in any form.

Driver developers will simply have to open code these protections. In
light of what I see on LTP / fuzzing, I suspect the use case will grow
and we'll have to revisit this in the future. But for now, sure, we can
just open code the required protections everywhere to not crash on module
removal.

  Luis
