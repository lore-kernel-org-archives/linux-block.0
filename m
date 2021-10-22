Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC98EC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 00:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A75560FC0
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 00:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVAlC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232065AbhJVAlC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 20:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634863125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q0WvRu5x49aalmab5yHnAwNJkjFw2n62ujZXLrWG4Qk=;
        b=FQHokGfUog3dJdEdQ4X9Uwuze4/8qm7/dy/Uw+/kPPpIb1AmvxkFkf85iXACPWuORSrAEp
        ZaeEFrdwGC5bTAxia8TGlqvjJ+guVrNiumdRBVyrkSWZ0UCoLsf2evJ+6TLaIIZ7xxnoOm
        7lLTBBWqlzBov2ccUDBgiQNt1a+Ss9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-Dij6jtgkP0mjP8YheXqjwQ-1; Thu, 21 Oct 2021 20:38:41 -0400
X-MC-Unique: Dij6jtgkP0mjP8YheXqjwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 765A81006AA2;
        Fri, 22 Oct 2021 00:38:40 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6C605FC22;
        Fri, 22 Oct 2021 00:38:33 +0000 (UTC)
Date:   Fri, 22 Oct 2021 08:38:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH V2 2/4] zram: don't fail to remove zram during unloading
 module
Message-ID: <YXIIBPMdA547wy1b@T590>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <20211020015548.2374568-3-ming.lei@redhat.com>
 <YXH836VvSpnBnvuK@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXH836VvSpnBnvuK@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 04:50:55PM -0700, Luis Chamberlain wrote:
> On Wed, Oct 20, 2021 at 09:55:46AM +0800, Ming Lei wrote:
> > When zram module is started to be unloaded, no one should use all zram
> > disks at that time. But disk's show() or store() attribute method may be
> > running, this way is expected because device_del()(called from
> > del_gendisk) will drain all pending show()/store().
> 
> How about:
> 
> ----------
> When the zram module is being unloaded, no one should be using the
> zram disks. However even while being unloaded the zram module's
> sysfs attributes might be poked at to re-configure the zram module.

're-configure the zram module' is confused, and it should be zram
device.

> This is expected, and kernfs ensures that these operations complete
> before device_del() completes.

Otherwise, the above is pretty good, and I will take that in V3.

> ----------
> 
> > But reset_store() may set ->claim which will fail zram_remove(), when
> > this happens, the zram device will be leaked and the warning of 'Error:
> > Removing state 63 which has instances left.' is triggered during
> > unloading module.
> 
> Note: the "Removing state 63 which has instances left" does not
> necessarily mean the struct zram is leaked. It just means that the per
> cpu struct zcomp instances are leaked, given the CPU hotplug removal
> callback is in charge of cleaning them up. That this gave us a hint that
> we do in fact leak a struct zram device as well is separate from what
> the message means, but I do agree it should be *that* because as you
> noted, LTP does not yet try to make spaghetti with hot_add_show().
> 
> So, how about:
> 
> ----------
> When the reset sysfs op (reset_store()) gets called the zram->claim will
> be set, and this prevents zram_remove() from removing a zram device. If one
> is unloading the module and one races to run the reset sysfs op we end
> up leaking the struct zram device. We learned about this issue through
> the error "Error: Removing state 63 which has instances left". While
> this just means the any of the per cpu struct zcomp instances are
> leaked when we're removing the CPU hotplug multistate callback, the
> test case (running LTP zram02.sh twice in different terminals) that
> allows us to reproduce this issue only mucks with reseting the devices,
> not hot_add_show(). Setting zram->claim will prevent zram_remove() from
> completing successfully, and so on module removal zram_remove_cb() does
> not tell us when it failed to remove the full struct zram device and
> it leaks.
> ----------

commit log is for helping people to understand the change, and too long or
exposing too much details may not serve that purpose since we also talk with
code, and I believe the following words are clear enough for explaining the
problem, and it is short & straightforward, and won't make people terrified, :-)

	But reset_store() may set ->claim which will fail zram_remove(), when
	this happens, zram_reset_device() is bypassed, and zram->comp can't
	be destroyed, so the warning of 'Error: Removing state 63 which has
	instances left.' is triggered during unloading module.

> 
> This begs the question, should we not then also make zram_remove_cb()
> chatty on failure?

When zram_remove() is run from module unloading path, it shouldn't be
failed cause no one owns any zram disk since unloading module, that is
why I add WARN_ON_ONCE() in zram_remove_cb() for document benefit because
zram_remove() is called from two contexts. But it can be failed in case of
hot removing.

> 
> > Fixes the issue by not failing zram_remove() if ->claim is set, and
> > we actually need to do nothing in case that zram_reset() is running
> > since del_gendisk() will wait until zram_reset() is done.
> 
> Sure this all looks like a reasonable alternative to the issue without
> using a generic lock. It does beg the questions if this suffices for
> the other oddball sysfs ops, but we can take that up with time.

->claim is only set in reset_store(), so it is enough for avoiding
zram_remove failure during unloading module.

> 
> > Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> In so far as the code is concerned:
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for the review!

-- 
Ming

