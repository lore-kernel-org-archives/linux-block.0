Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F0C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 22:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F3A6113E
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 22:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFVWLu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 18:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVWLu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 18:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 452BF60FEE;
        Tue, 22 Jun 2021 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624399773;
        bh=7V34Ihn758HO093MwCoetl0OMiD6JevkPMH/EyONWvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaerkYQyk+y4RJslGoZu1J1PqtU6+3/+edIHDCAzF0aPwL2PpHo1jwJM76BlLaPQk
         rtnYVzMjV98+VuYGhbcWEPR9fpOff+1BwcnKABdjWXQ3z/WDkKRrGsn9uvl+srGHRR
         GVSdJi/c8TfcJ2DBJ1IgOMbbGyv6cl+ovvjFZ1jA=
Date:   Wed, 23 Jun 2021 00:09:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        axboe@kernel.dk, mbenes@suse.com, jpoimboe@redhat.com,
        tglx@linutronix.de, keescook@chromium.org, jikos@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/base/core: refcount kobject and bus on device
 attribute read / store
Message-ID: <YNJfm6k/vBCz7AjG@kroah.com>
References: <20210622215738.3936687-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622215738.3936687-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 02:57:38PM -0700, Luis Chamberlain wrote:
> It's possible today to have a device attribute read or store
> race against device removal. When this happens there is a small
> chance that the dereference for the private data area of the driver
> is NULL.
> 
> Let's consider the zram driver as an example. Its possible to run into
> a race where a sysfs knob is being used, we get preempted, and a zram
> device is removed before we complete use of the sysfs knob. This can happen
> for instance on block devices, where for instance the zram block devices
> just part of the private data of the block device.
> 
> For instance this can happen in the following two situations
> as examples to illustrate this better:
> 
>         CPU 1                            CPU 2
> destroy_devices
> ...
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
> idr_for_each(zram_remove_cb
>   zram_remove
>   ...
>   kfree(zram)
>                                  down_read(&zram->init_lock);
> 
>         CPU 1                            CPU 2
> hot_remove_store
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
>   zram_remove
>     kfree(zram)
>                                  down_read(&zram->init_lock);
> 
> To ensure the private data pointer is valid we could use bdget() / bdput()
> in between access, however that would mean doing that in all sysfs
> reads/stores on the driver. Instead a generic solution for all drivers
> is to ensure the device kobject is still valid and also the bus, if
> a bus is present.
> 
> This issue does not fix a known crash, however this race was
> spotted by Minchan Kim through code inspection upon code review
> of another zram patch.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/base.h |  2 ++
>  drivers/base/bus.c  |  4 ++--
>  drivers/base/core.c | 36 ++++++++++++++++++++++++++++++++----
>  3 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index e5f9b7e656c3..3f95b125b667 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -127,6 +127,8 @@ static inline void auxiliary_bus_init(void) { }
>  
>  struct kobject *virtual_device_parent(struct device *dev);
>  
> +extern struct bus_type *bus_get(struct bus_type *bus);
> +extern void bus_put(struct bus_type *bus);
>  extern int bus_add_device(struct device *dev);
>  extern void bus_probe_device(struct device *dev);
>  extern void bus_remove_device(struct device *dev);
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 36d0c654ea61..21c80d7d6433 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -39,7 +39,7 @@ static struct kset *system_kset;
>  static int __must_check bus_rescan_devices_helper(struct device *dev,
>  						void *data);
>  
> -static struct bus_type *bus_get(struct bus_type *bus)
> +struct bus_type *bus_get(struct bus_type *bus)
>  {
>  	if (bus) {
>  		kset_get(&bus->p->subsys);
> @@ -48,7 +48,7 @@ static struct bus_type *bus_get(struct bus_type *bus)
>  	return NULL;
>  }
>  
> -static void bus_put(struct bus_type *bus)
> +void bus_put(struct bus_type *bus)
>  {
>  	if (bus)
>  		kset_put(&bus->p->subsys);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4a8bf8cda52b..f69aa040b56d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2042,28 +2042,56 @@ EXPORT_SYMBOL(dev_driver_string);
>  static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
>  			     char *buf)
>  {
> -	struct device_attribute *dev_attr = to_dev_attr(attr);
> -	struct device *dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr;
> +	struct device *dev;
> +	struct bus_type *bus = NULL;
>  	ssize_t ret = -EIO;
>  
> +	dev = get_device(kobj_to_dev(kobj));
> +	if (dev->bus) {
> +		bus = bus_get(dev->bus);
> +		if (!bus)
> +			goto out;
> +	}
> +
> +	dev_attr = to_dev_attr(attr);
>  	if (dev_attr->show)
>  		ret = dev_attr->show(dev, dev_attr, buf);
>  	if (ret >= (ssize_t)PAGE_SIZE) {
>  		printk("dev_attr_show: %pS returned bad count\n",
>  				dev_attr->show);
>  	}
> +
> +	bus_put(bus);
> +out:
> +	put_device(dev);
> +
>  	return ret;
>  }
>  
>  static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,
>  			      const char *buf, size_t count)
>  {
> -	struct device_attribute *dev_attr = to_dev_attr(attr);
> -	struct device *dev = kobj_to_dev(kobj);
> +	struct device_attribute *dev_attr;
> +	struct device *dev;
> +	struct bus_type *bus = NULL;
>  	ssize_t ret = -EIO;
>  
> +	dev = get_device(kobj_to_dev(kobj));
> +	if (dev->bus) {
> +		bus = bus_get(dev->bus);
> +		if (!bus)
> +			goto out;
> +	}
> +
> +	dev_attr = to_dev_attr(attr);
>  	if (dev_attr->store)
>  		ret = dev_attr->store(dev, dev_attr, buf, count);
> +
> +	bus_put(bus);
> +out:
> +	put_device(dev);
> +
>  	return ret;
>  }
>  
> -- 
> 2.30.2
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
