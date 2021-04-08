Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8509C433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A739D61153
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 13:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhDHNiL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231255AbhDHNiK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Apr 2021 09:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617889079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vwxcW1h/5LZWVNg1SVvZqjvaa5GJzxBi2E86aCQB4CQ=;
        b=FK1AZFABKhzKIYI8oAFu3f1Elc6YbNMS9PdHH2IhYZ9HejBPrylDyEQBazreUatXebIKX0
        /eYTlrbCoeM64F94EMuhKLfpl6WQRIVhEKk3N/PSImyW/Q8aRkPLLYccIGPmPQ0qKUbi1h
        TRZGlAQPz36+zixcDebhKOQrbt86d7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-HCvB5gdyNG2AA93GUYykDQ-1; Thu, 08 Apr 2021 09:37:55 -0400
X-MC-Unique: HCvB5gdyNG2AA93GUYykDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8734310054F6;
        Thu,  8 Apr 2021 13:37:53 +0000 (UTC)
Received: from treble (ovpn-112-2.rdu2.redhat.com [10.10.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57C4B19D9B;
        Thu,  8 Apr 2021 13:37:51 +0000 (UTC)
Date:   Thu, 8 Apr 2021 08:37:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210408133748.li3oqjl2torpdlwo@treble>
References: <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
 <YGbNpLKXfWpy0ZZa@kroah.com>
 <20210407201746.ueijmegmpbyq5quv@treble>
 <YG6gLd9bnDsXhrNx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YG6gLd9bnDsXhrNx@kroah.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 08, 2021 at 08:18:21AM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 03:17:46PM -0500, Josh Poimboeuf wrote:
> > On Fri, Apr 02, 2021 at 09:54:12AM +0200, Greg KH wrote:
> > > On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> > > > As for the syfs deadlock possible with drivers, this fixes it in a generic way:
> > > > 
> > > > commit fac43d8025727a74f80a183cc5eb74ed902a5d14
> > > > Author: Luis Chamberlain <mcgrof@kernel.org>
> > > > Date:   Sat Mar 27 14:58:15 2021 +0000
> > > > 
> > > >     sysfs: add optional module_owner to attribute
> > > >     
> > > >     This is needed as otherwise the owner of the attribute
> > > >     or group read/store might have a shared lock used on driver removal,
> > > >     and deadlock if we race with driver removal.
> > > >     
> > > >     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > 
> > > No, please no.  Module removal is a "best effort", if the system dies
> > > when it happens, that's on you.  I am not willing to expend extra energy
> > > and maintance of core things like sysfs for stuff like this that does
> > > not matter in any system other than a developer's box.
> > 
> > So I mentioned this on IRC, and some folks were surprised to hear that
> > module unloading is unsupported and is just a development aid.
> > 
> > Is this stance documented anywhere?
> > 
> > If we really believe this to be true, we should make rmmod taint the
> > kernel.
> 
> My throw-away comment here seems to have gotten way more attention than
> it deserved, sorry about that everyone.
> 
> Nothing is supported for anything here, it's all "best effort" :)
> 
> And I would love a taint for rmmod, but what is that going to help out
> with?

I'm having trouble following this conclusion.  Sure, we give our best
effort, but if "nothing is supported" then what are we even doing here?

Either we aim to support module unloading, or we don't.

If we do support it, "best effort" isn't a valid reason for nacking
fixes.

If we don't support it, but still want to keep it half-working for
development purposes, tainting on rmmod will make it crystal clear that
the system has been destabilized.

-- 
Josh

