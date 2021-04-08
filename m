Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBABC433B4
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 01:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907AB61157
	for <linux-block@archiver.kernel.org>; Thu,  8 Apr 2021 01:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhDHBiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 21:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhDHBiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 21:38:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99202C061760;
        Wed,  7 Apr 2021 18:37:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617845873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1BCSKnRJSmnulmmzbhuhAMxM+/DLB/JexNDahjWLa0=;
        b=xuBVbUs3z9Bnm4bh7y9nkiDZwIYlBMsdlf/6VTYRSMuAlVZIGT30/+gSx4OxNMrEjqJHZE
        xOZql7/EzwQ3Y+kiHFxsy1M/BW9vCBJM8GZIkWYbJOgraCd78LABhQjhtzMS4wTNU9ENog
        e/XToar/ufqgQPiR0KCkgltsSa2NpDG2evP0RNHiQCWzZSVJ9PnAes/twUtA+MluCXKrXG
        Ihn+GcTTrVGdEi45YqHiCHvqVvYVT8TsYyuf5rOYwvsOqGv3mRMLgbxhBq0RD5VO+eHjEJ
        1Gq/PJUw95nSgYoZFg3YSsdyWGF9zOA2YvNSBCYr+aYScGTgLvioiQYr4SaY1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617845873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a1BCSKnRJSmnulmmzbhuhAMxM+/DLB/JexNDahjWLa0=;
        b=HsoOFep9I3XJmkK8n7opatm/BF8jqrGSOa/mmqXOAoutNdwnOvBIxNs8ojSoJtK5Q0DM3e
        vjFwUgr3XEOO5MCg==
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug multistate
In-Reply-To: <YGbNpLKXfWpy0ZZa@kroah.com>
References: <YEbjom8FIclEgRYv@google.com> <20210310212128.GR4332@42.do-not-panic.com> <YErOkGrvtQODXtB0@google.com> <20210312183238.GW4332@42.do-not-panic.com> <YEvA1dzDsFOuKdZ/@google.com> <20210319190924.GK4332@42.do-not-panic.com> <YFjHvUolScp3btJ9@google.com> <20210322204156.GM4332@42.do-not-panic.com> <YFkWMZ0m9nKCT69T@google.com> <20210401235925.GR4332@42.do-not-panic.com> <YGbNpLKXfWpy0ZZa@kroah.com>
Date:   Thu, 08 Apr 2021 03:37:53 +0200
Message-ID: <87blap4kum.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greg,

On Fri, Apr 02 2021 at 09:54, Greg KH wrote:
> On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
>> As for the syfs deadlock possible with drivers, this fixes it in a generic way:
>> 
>> commit fac43d8025727a74f80a183cc5eb74ed902a5d14
>> Author: Luis Chamberlain <mcgrof@kernel.org>
>> Date:   Sat Mar 27 14:58:15 2021 +0000
>> 
>>     sysfs: add optional module_owner to attribute
>>     
>>     This is needed as otherwise the owner of the attribute
>>     or group read/store might have a shared lock used on driver removal,
>>     and deadlock if we race with driver removal.
>>     
>>     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>
> No, please no.  Module removal is a "best effort", if the system dies
> when it happens, that's on you.  I am not willing to expend extra energy
> and maintance of core things like sysfs for stuff like this that does
> not matter in any system other than a developer's box.
>
> Lock data, not code please.  Trying to tie data structure's lifespans
> to the lifespan of code is a tangled mess, and one that I do not want to
> add to in any form.
>
> sorry,

Sorry, but you are fundamentaly off track here. This has absolutely
nothing to do with module removal.

The point is that module removal is the reverse operation of module
insertion. So far so good.

But module insertion can fail. So if you have nested functionalities
which hang off or are enabled by moduled insertion then any fail in that
sequence has to be able to roll back and clean up properly no matter
what.

Which it turn makes modules removal a reverse operation of module
insertion.

If you think otherwise, then please provide a proper plan how nested
operations like sysfs - not to talk about more complex things like multi
instance discovery which can happen inside a module insertion sequence
can be properly rolled back.

Just declaring that rmmod is evil does not cut it. rmmod is the least of
the problems. If that fails, then a lot of rollback, failure handling
mechanisms are missing in the setup path already.

Anything which cannot cleanly rollback no matter whether the fail or
rollback request happens at insertion time or later is broken by design.

So either you declare module removal as disfunctional or you stop making
up semantically ill defined and therefore useless claims about it.

Your argument in:

 https://lore.kernel.org/linux-block/YGbNpLKXfWpy0ZZa@kroah.com/

 "Lock data, not code please.  Trying to tie data structure's lifespans
  to the lifespan of code is a tangled mess, and one that I do not want to
  add to in any form"

is just useless blurb because the fundamental purpose of discovery code
is to create the data structures which are tied to the code which is
associated to it.

Please stop this 'module removal' is not supported nonsense unless you
can prove a complete indepenence of module init/discovery code to
subsequent discovered entities depending on it.

Thanks,

        tglx

