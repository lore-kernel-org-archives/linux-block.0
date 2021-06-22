Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88029C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671676134F
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFVQu7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFVQu6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:50:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B8D6128C;
        Tue, 22 Jun 2021 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624380521;
        bh=798ay9uKjUb5WJzPr3Cmuso2OTDJMjuepaqKjCLtgWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bq/vGoapL80URwXHtTLjEeiLcjZTZ9n97j4RLkUaT4WkqyTABvvLfcX8P3MhhS0Yg
         VkxPYtVBIHgmoliqhNwgk6YwtMYVVfE/Ym1Z5XtuYNnw060m1++4/CL9JVnujfLL+m
         QueE2T4DqzYEmQCKieqaEAySQQ6UutQh99mnCLiQ=
Date:   Tue, 22 Jun 2021 18:48:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drivers/base/core: refcount kobject and bus on
 device attribute read / store
Message-ID: <YNIUZ3YZvB6rem4V@kroah.com>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233651.597220-1-mcgrof@kernel.org>
 <YNGVUk18pmTFZqAB@kroah.com>
 <20210622164402.d62je6pajcplkfuy@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622164402.d62je6pajcplkfuy@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:44:02AM -0700, Luis Chamberlain wrote:
> On Tue, Jun 22, 2021 at 09:46:26AM +0200, Greg KH wrote:
> > On Mon, Jun 21, 2021 at 04:36:51PM -0700, Luis Chamberlain wrote:
> > > It's possible today to have a device attribute read or store
> > > race against device removal. When this happens there is a small
> > > chance that the derefence for the private data area of the driver
> > > is NULL.
> > > 
> > > Let's consider the zram driver as an example. Its possible to run into
> > > a race where a sysfs knob is being used, we get preempted, and a zram
> > > device is removed before we complete use of the sysfs knob. This can happen
> > > for instance on block devices, where for instance the zram block devices
> > > just part of the private data of the block device.
> > > 
> > > For instance this can happen in the following two situations
> > > as examples to illustrate this better:
> > > 
> > >         CPU 1                            CPU 2
> > > destroy_devices
> > > ...
> > >                                  compact_store()
> > >                                  zram = dev_to_zram(dev);
> > > idr_for_each(zram_remove_cb
> > >   zram_remove
> > >   ...
> > >   kfree(zram)
> > >                                  down_read(&zram->init_lock);
> > > 
> > >         CPU 1                            CPU 2
> > > hot_remove_store
> > >                                  compact_store()
> > >                                  zram = dev_to_zram(dev);
> > >   zram_remove
> > >     kfree(zram)
> > >                                  down_read(&zram->init_lock);
> > > 
> > > To ensure the private data pointer is valid we could use bdget() / bdput()
> > > in between access, however that would mean doing that in all sysfs
> > > reads/stores on the driver. Instead a generic solution for all drivers
> > > is to ensure the device kobject is still valid and also the bus, if
> > > a bus is present.
> > > 
> > > This issue does not fix a known crash, however this race was
> > > spotted by Minchan Kim through code inspection upon code review
> > > of another zram patch.
> > > 
> > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  drivers/base/base.h |  2 ++
> > >  drivers/base/bus.c  |  4 ++--
> > >  drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++----
> > >  3 files changed, 42 insertions(+), 6 deletions(-)
> > 
> > Please make this an independent patch of the zram mess  and I will be
> > glad to consider it for the driver core tree then.
> 
> What do you mean by making it independent?
> 
> The patch does not depend on the zram changes, and so, this can
> be merged separately as-is.

Great, then make it a 1/1 patch.  Putting it as patch 3 here means I can
not take it as our tools pull in the full series.

thanks,

greg k-h
