Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD7C433B4
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 20:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4200B61158
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 20:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhDGUSL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232929AbhDGUSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Apr 2021 16:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617826678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQknNtkrD3GHg+E4N/uth2eOy0S3ZwiKhVq/VQGmwhM=;
        b=MzWFZc7DTswGljIlCW6cGoU9iHl4xLVC0pKWF4IA1niBW469xcJAp23wlHvE2IL7/mtIqL
        zhuBi0veWGEHGJgftarbkivJa/zH0i/hqWjuijquPxDk0o0q5upuGsXjxTI7p/rQVLvgKX
        Na20vTpkWdsSFgjcbtq/9pBiHR3cZVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-_Ff8sjcSNDalXMd_Kh6KAw-1; Wed, 07 Apr 2021 16:17:53 -0400
X-MC-Unique: _Ff8sjcSNDalXMd_Kh6KAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7A07881276;
        Wed,  7 Apr 2021 20:17:50 +0000 (UTC)
Received: from treble (ovpn-119-205.rdu2.redhat.com [10.10.119.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A275610AE;
        Wed,  7 Apr 2021 20:17:48 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:17:46 -0500
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
Message-ID: <20210407201746.ueijmegmpbyq5quv@treble>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGbNpLKXfWpy0ZZa@kroah.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
> No, please no.  Module removal is a "best effort", if the system dies
> when it happens, that's on you.  I am not willing to expend extra energy
> and maintance of core things like sysfs for stuff like this that does
> not matter in any system other than a developer's box.

So I mentioned this on IRC, and some folks were surprised to hear that
module unloading is unsupported and is just a development aid.

Is this stance documented anywhere?

If we really believe this to be true, we should make rmmod taint the
kernel.

-- 
Josh

