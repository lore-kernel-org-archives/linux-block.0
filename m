Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6CC48BC2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E9261075
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWQa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 12:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWQa0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 12:30:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F38EA6112D;
        Wed, 23 Jun 2021 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624465688;
        bh=pXQvDTlh7AxJ1xcJDWRJuLPfRjb/pFSHA7IOibiex28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXkvIQXWIo1Bk+IwK1I4UP5FloMgszcrdvs5K41xYF6hOxPVJvcRmh8Lnax5mB1d1
         SfFzjh9ZC+Pq/Tz2YjHYX3aOYaaFTqU7/OahK0EcxWgymypVsUI1TOWxIOKQQQ5q4N
         4rwjSEMEKQP0hxPJi83M8alR/a88Y9VkfnpEXdSo=
Date:   Wed, 23 Jun 2021 18:28:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <YNNhFdw++Auk+1Wg@kroah.com>
References: <20210623003630.274804-1-mcgrof@kernel.org>
 <YNLxtbzOm3/whYHc@kroah.com>
 <20210623161434.qraapo4xaprte7bs@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623161434.qraapo4xaprte7bs@garbanzo>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23, 2021 at 09:14:34AM -0700, Luis Chamberlain wrote:
> On Wed, Jun 23, 2021 at 10:32:53AM +0200, Greg KH wrote:
> > On Tue, Jun 22, 2021 at 05:36:30PM -0700, Luis Chamberlain wrote:
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 4a8bf8cda52b..f69aa040b56d 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -2042,28 +2042,56 @@ EXPORT_SYMBOL(dev_driver_string);
> > >  static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
> > >  			     char *buf)
> > >  {
> > > -	struct device_attribute *dev_attr = to_dev_attr(attr);
> > > -	struct device *dev = kobj_to_dev(kobj);
> > > +	struct device_attribute *dev_attr;
> > > +	struct device *dev;
> > > +	struct bus_type *bus = NULL;
> > >  	ssize_t ret = -EIO;
> > >  
> > > +	dev = get_device(kobj_to_dev(kobj));
> > > +	if (dev->bus) {
> > 
> > No need to test for this, right?
> 
> dev_uevent() checks for dev->bus, so I thought that was a clear
> indication this isn't always set.
> 
> > 
> > > +		bus = bus_get(dev->bus);
> > > +		if (!bus)
> > > +			goto out;

The point is that even if dev->bus is NULL, then bus_get(NULL) is NULL.
That's the only way that bus_get() can return NULL, which means this
check too is not needed.

> > >  	if (dev_attr->show)
> > >  		ret = dev_attr->show(dev, dev_attr, buf);
> > >  	if (ret >= (ssize_t)PAGE_SIZE) {
> > >  		printk("dev_attr_show: %pS returned bad count\n",
> > >  				dev_attr->show);
> > >  	}
> > > +
> > > +	bus_put(bus);
> > 
> > You are incrementing the bus, which is nice, but I do not understand why
> > it is needed.  What is causing the bus to go away _before_ the devices
> > are going away?  Busses almost never are removed from the system, and if
> > they are, all devices associated with them are removed first.  So I do
> > not think you need to increment anything with that here.
> 
> You tell me. It was your suggestion as a replacement for the type
> specific lock, in the zram case, its a block device so I was using
> bdgrab().

I did?  Sorry, I do not remember, but this is not a lock, nor does it
protect anything.

I'll respond to the rest later...

greg k-h
