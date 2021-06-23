Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD6BC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D348861026
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWQQ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 12:16:57 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:45729 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFWQQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 12:16:56 -0400
Received: by mail-pj1-f42.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso1673119pjb.4;
        Wed, 23 Jun 2021 09:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qc9ZU4x5fck6ND4TKf+J1mR/42R39eBlW/ngWT8FK2c=;
        b=anvbxG7lHXxUTkj4KZYfiDkqG6cRwyKUSL1fz7o15XFH3FE63abfuP+afqis7OXIuh
         a2lfWP4MRNYmgsVfeYK62EuNte+xTEQukydDt1FiCOLf4DM6HU5TFK4IAW3aWyfETpCi
         Gbs7CEEu41WQt9SQT+zZfauoMiTsvadXN9gqBa3TAxbMIkOYJvM2lt5gw2fJ5c86WsVl
         hjz9oJDZAkRK9J/eM/qKz0F7w8BdWKZMiyhQY6DeHseTIoJXWp/lyeagebuoiFtPUXDN
         TIT2aOPj6Iu4RE6CDEJUuSur2aVa2X4bXuuRIVzQVqQCdiHNTiBu+layVl0byQaHhCqT
         Ao0g==
X-Gm-Message-State: AOAM530BIMf7bjBpwCjMrbMyHlfuQO9FQmI7mHLVLo9Bmd7pO/TKjHFT
        YMosDeygGZaNlFETRgHZ4b4=
X-Google-Smtp-Source: ABdhPJzK/5WH0Ma9bjHKCcxGEhzynubQSsq8mUx3VmN7acPLHu09eT6xarhh+knNollJK2nPIC5EXQ==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr551474pjb.52.1624464878244;
        Wed, 23 Jun 2021 09:14:38 -0700 (PDT)
Received: from garbanzo ([191.96.121.71])
        by smtp.gmail.com with ESMTPSA id y1sm364052pfe.72.2021.06.23.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:14:37 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:14:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <20210623161434.qraapo4xaprte7bs@garbanzo>
References: <20210623003630.274804-1-mcgrof@kernel.org>
 <YNLxtbzOm3/whYHc@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNLxtbzOm3/whYHc@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 23, 2021 at 10:32:53AM +0200, Greg KH wrote:
> On Tue, Jun 22, 2021 at 05:36:30PM -0700, Luis Chamberlain wrote:
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 4a8bf8cda52b..f69aa040b56d 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2042,28 +2042,56 @@ EXPORT_SYMBOL(dev_driver_string);
> >  static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
> >  			     char *buf)
> >  {
> > -	struct device_attribute *dev_attr = to_dev_attr(attr);
> > -	struct device *dev = kobj_to_dev(kobj);
> > +	struct device_attribute *dev_attr;
> > +	struct device *dev;
> > +	struct bus_type *bus = NULL;
> >  	ssize_t ret = -EIO;
> >  
> > +	dev = get_device(kobj_to_dev(kobj));
> > +	if (dev->bus) {
> 
> No need to test for this, right?

dev_uevent() checks for dev->bus, so I thought that was a clear
indication this isn't always set.

> 
> > +		bus = bus_get(dev->bus);
> > +		if (!bus)
> > +			goto out;
> 
> How can this happen?

device_add() calls bus_add_device(), and the bus_add_device()
implementation seems to have a check for the bus returned from bus_get() as
well?

> > +	}
> > +
> > +	dev_attr = to_dev_attr(attr);
> 
> Why did you move this call to way down here?  It's fine in the first
> line of the function above as-is.

I had done that when I had the device kobject reference incremented.
I'll move it back up.

> >  	if (dev_attr->show)
> >  		ret = dev_attr->show(dev, dev_attr, buf);
> >  	if (ret >= (ssize_t)PAGE_SIZE) {
> >  		printk("dev_attr_show: %pS returned bad count\n",
> >  				dev_attr->show);
> >  	}
> > +
> > +	bus_put(bus);
> 
> You are incrementing the bus, which is nice, but I do not understand why
> it is needed.  What is causing the bus to go away _before_ the devices
> are going away?  Busses almost never are removed from the system, and if
> they are, all devices associated with them are removed first.  So I do
> not think you need to increment anything with that here.

You tell me. It was your suggestion as a replacement for the type
specific lock, in the zram case, its a block device so I was using
bdgrab().

> But step back, what prevented the kobject from decrementing between the
> call to dev_attr_show() and the first line of the function?
> 
> The kobject needs to be incremented before show is called, right?  Or
> does kernfs handle this properly already? 

kernfs / sysfs is in not struct device specific, it has no semantics for
modules or even devices. The aspect of kernfs which deals with locking
a struct kernfs_node is kernfs_get_active(). The refcount there of
importance is the call to atomic_inc_unless_negative(&kn->active).

struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)                   
{                                                                               
	if (unlikely(!kn))
		return NULL;                                                    

	if (!atomic_inc_unless_negative(&kn->active))                           
		return NULL;                                                    

	if (kernfs_lockdep(kn))
		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);               
	return kn;                                                              
}

BTW this was also precisely where I had suggested to extend the
kernfs_node with an optional kn->owner and if set we try_module_get() to
prevent the deadlock case if the module exit routine also happens to use
a lock also used by a sysfs attribute store/read.

The flow would be (from a real live gdb crash backtrace from an original
bug report from a customer):

write system call -->
  ksys_write ()
    vfs_write() -->
      __vfs_write() -->
       kernfs_fop_write() (note now this is kernfs_fop_write_iter()) -->
         sysfs_kf_write() -->
           dev_attr_store() -->
	     null reference

The dereference is because the dev_attr_store() call which we are
modifying

LINE-001 static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,                                                                                         
LINE-002 const char *buf, size_t count)                                                                                                                 
LINE-003 {
LINE-004	struct device_attribute *dev_attr = to_dev_attr(attr);
LINE-005	struct device *dev = kobj_to_dev(kobj);
LINE-006	ssize_t ret = -EIO;
LINE-007
LINE-008	if (dev_attr->store)
LINE-009		ret = dev_attr->store(dev, dev_attr, buf, count);
	...
	}

The race happens because a sysfs store / read can be triggered, the CPU
could be preempted after LINE-008, and the ->store is gone by LINE-009.
This begs the question if kernfs_fop_write_iter() or sysfs protects this
somehow? Let's see.

For kernfs we have:

static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter) 
{
	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
	...
	mutex_lock(&of->mutex);
	if (!kernfs_get_active(of->kn)) {
		mutex_unlock(&of->mutex);
		len = -ENODEV;
		goto out_free;
	}

	ops = kernfs_ops(of->kn);
	if (ops->write)
		len = ops->write(of, buf, len, iocb->ki_pos);
	else
		len = -EINVAL;

	kernfs_put_active(of->kn);
	mutex_unlock(&of->mutex);
	...
}

And the write call here is a syfs calls:

static ssize_t sysfs_kf_write(struct kernfs_open_file *of, char *buf,           
			      size_t count, loff_t pos)                         
{                                                                               
	const struct sysfs_ops *ops = sysfs_file_ops(of->kn);                   
	struct kobject *kobj = of->kn->parent->priv;                            

	if (!count)                                                             
		return 0;                                                       

	return ops->store(kobj, of->kn->priv, buf, count);                      
}           

As we have observed already, the active reference obtained through
kernfs_get_active() was for the struct kernfs_node. Sure, the
ops->write() is valid, in this case it sysfs_kf_write().

sysfs isn't doing any active reference check for the kobject device
attribute as it doesn't care for them. So syfs calls
dev_attr_store(), but the dev_attr_store() is not preventing the device
attribute ops to go fishing, and we destroy them while we're destroying
the device on module removal.

In the zram case, the abstraction is worse given the device attributes
are are created on behalf of the driver as group attributes.  The zram
disksize_store() for instance will use:

static inline struct zram *dev_to_zram(struct device *dev)                      
{                                                                               
	return (struct zram *)dev_to_disk(dev)->private_data;                   
} 

static ssize_t disksize_store(struct device *dev,
			      struct device_attribute *attr,
			      const char *buf, size_t len)     
{                                  
	...
	struct zram *zram = dev_to_zram(dev);
	...
}

Nothing is preventing an active block group sysfs attribute from going
fishing, in the dev_to_disk() is the struct gendisk, and that can get
free'd on module exit while the sysfs attribute is about to be poked.

> I don't have the time at the
> moment to dig into this, but maybe this isn't an issue?  Look at how
> sysfs handles the kobject lookups for kernfs nodes to see if all is sane
> there, maybe there isn't an issue?

The deadlock issue I noted and am fixing with the zram driver was one
real live situation a customer reported, however a null dereference
illustrated above turned out to also be in the logs of the same bug
report, just that it happened in other situations, so what Minchan
claimed as theoretical actually indeed was a real issue and I hope
that the above illustrates this better.

  Luis
