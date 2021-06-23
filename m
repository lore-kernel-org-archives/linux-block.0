Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88D4C4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D247D61164
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 08:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFWIfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 04:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhFWIfN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 04:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B49D66112D;
        Wed, 23 Jun 2021 08:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624437176;
        bh=4sn8WqZijDYpxiuDqKDq6MKI/sEkghiCWQfDl6JYqrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GbYqSZtbYinAzslu+VRVH6zxki0aFVWoiHzllbc0M/T5rj5FBJJwo4cwwuw31ddhB
         ezL78WptrfOLgk709+WWNTYjqNE7coKUgQERdF7TbU4P3adVvYqLFBbEJ59bipEXAx
         qLS8ionKOOjyQNxaj3M5XwAYUSWK+lkkBGJqcaxU=
Date:   Wed, 23 Jun 2021 10:32:53 +0200
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
Message-ID: <YNLxtbzOm3/whYHc@kroah.com>
References: <20210623003630.274804-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623003630.274804-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 05:36:30PM -0700, Luis Chamberlain wrote:
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
> 
> This v3 is the same as v2, but since the I got an email asking me to
> clarify the differences between the first iteration and the second, this
> v3 just describes what I did not explain in the v2. Namely:
> 
>   * I removed the checks from get_device() calls as suggested
>   * The functions which are now being used outside of bus.c have
>     forwared declarations stuffed into base.h
> 
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

No need to test for this, right?

> +		bus = bus_get(dev->bus);
> +		if (!bus)
> +			goto out;

How can this happen?

> +	}
> +
> +	dev_attr = to_dev_attr(attr);

Why did you move this call to way down here?  It's fine in the first
line of the function above as-is.

>  	if (dev_attr->show)
>  		ret = dev_attr->show(dev, dev_attr, buf);
>  	if (ret >= (ssize_t)PAGE_SIZE) {
>  		printk("dev_attr_show: %pS returned bad count\n",
>  				dev_attr->show);
>  	}
> +
> +	bus_put(bus);

You are incrementing the bus, which is nice, but I do not understand why
it is needed.  What is causing the bus to go away _before_ the devices
are going away?  Busses almost never are removed from the system, and if
they are, all devices associated with them are removed first.  So I do
not think you need to increment anything with that here.

But step back, what prevented the kobject from decrementing between the
call to dev_attr_show() and the first line of the function?

The kobject needs to be incremented before show is called, right?  Or
does kernfs handle this properly already?  I don't have the time at the
moment to dig into this, but maybe this isn't an issue?  Look at how
sysfs handles the kobject lookups for kernfs nodes to see if all is sane
there, maybe there isn't an issue?

thanks,

greg k-h
