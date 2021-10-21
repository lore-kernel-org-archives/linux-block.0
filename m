Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 23:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1F61362
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 23:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUXxO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJUXxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 19:53:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976BC061764;
        Thu, 21 Oct 2021 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DtBjhtMrujyY2DKwNIYQXsIF5iJYJCec4RHft5e6GAw=; b=g7ZanBeX/DNUkfStQQNwEl9ya4
        ejv6LtO3pz1TBhGUkVMTkJ/3BcgzyM3L/Om5cIF/+2l3Y+z/uL0G/9dMlkGBg1QFQMytl+Ou0Hjsy
        V17k2IHsA9plSG/fxYrCbsncIlg0nWuAHsk2u79rUGdbr/KLIlhIbSgeyyixDg+4N3MVfZ7KsSf6f
        JZQaCpQtHl/PspXQEaYLvWZITLJcGe1YJlT3sPVEiEWc07Zl0w8f+tyCa0vPRLlMkRhOKjRigKQmj
        swUMr2IuJ4rklPhrOKHEdR6YYtS+si31je8COsPE5M1gaMUSW/mgRkp/fVVhLVjju0IrSOojTeYfr
        OL33xSDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdhpn-009KDd-Tv; Thu, 21 Oct 2021 23:50:55 +0000
Date:   Thu, 21 Oct 2021 16:50:55 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/4] zram: don't fail to remove zram during unloading
 module
Message-ID: <YXH836VvSpnBnvuK@bombadil.infradead.org>
References: <20211020015548.2374568-1-ming.lei@redhat.com>
 <20211020015548.2374568-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020015548.2374568-3-ming.lei@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 09:55:46AM +0800, Ming Lei wrote:
> When zram module is started to be unloaded, no one should use all zram
> disks at that time. But disk's show() or store() attribute method may be
> running, this way is expected because device_del()(called from
> del_gendisk) will drain all pending show()/store().

How about:

----------
When the zram module is being unloaded, no one should be using the
zram disks. However even while being unloaded the zram module's
sysfs attributes might be poked at to re-configure the zram module.
This is expected, and kernfs ensures that these operations complete
before device_del() completes.
----------

> But reset_store() may set ->claim which will fail zram_remove(), when
> this happens, the zram device will be leaked and the warning of 'Error:
> Removing state 63 which has instances left.' is triggered during
> unloading module.

Note: the "Removing state 63 which has instances left" does not
necessarily mean the struct zram is leaked. It just means that the per
cpu struct zcomp instances are leaked, given the CPU hotplug removal
callback is in charge of cleaning them up. That this gave us a hint that
we do in fact leak a struct zram device as well is separate from what
the message means, but I do agree it should be *that* because as you
noted, LTP does not yet try to make spaghetti with hot_add_show().

So, how about:

----------
When the reset sysfs op (reset_store()) gets called the zram->claim will
be set, and this prevents zram_remove() from removing a zram device. If one
is unloading the module and one races to run the reset sysfs op we end
up leaking the struct zram device. We learned about this issue through
the error "Error: Removing state 63 which has instances left". While
this just means the any of the per cpu struct zcomp instances are
leaked when we're removing the CPU hotplug multistate callback, the
test case (running LTP zram02.sh twice in different terminals) that
allows us to reproduce this issue only mucks with reseting the devices,
not hot_add_show(). Setting zram->claim will prevent zram_remove() from
completing successfully, and so on module removal zram_remove_cb() does
not tell us when it failed to remove the full struct zram device and
it leaks.
----------

This begs the question, should we not then also make zram_remove_cb()
chatty on failure?

> Fixes the issue by not failing zram_remove() if ->claim is set, and
> we actually need to do nothing in case that zram_reset() is running
> since del_gendisk() will wait until zram_reset() is done.

Sure this all looks like a reasonable alternative to the issue without
using a generic lock. It does beg the questions if this suffices for
the other oddball sysfs ops, but we can take that up with time.

> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

In so far as the code is concerned:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
