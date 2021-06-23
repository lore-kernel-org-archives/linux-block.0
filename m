Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10ABC4743C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899A2611AD
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 16:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFWQyD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 12:54:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWQyD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 12:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C96D961166;
        Wed, 23 Jun 2021 16:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624467105;
        bh=nVgeAOUNGeqBWN4ZRfg//uEYGi/XZ90Vb0JXYww56ZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wV6ZkBOPKiknmUC+UepPTw2Q3Dt8Lki9RPVKNGANeMC6mInvk+oyeJ/7X1D9Zr+i1
         ax+HedtUYkVBVsaLi5nRglxF90VqNZnoxNSrSMzQZGtcldcG3+OhF53rpdQbxkJgdR
         gcnjkyu+pb1M4a5vDyxl+HxNS8BXRl1PZSdUyWpA=
Date:   Wed, 23 Jun 2021 18:51:42 +0200
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
Message-ID: <YNNmnrjpOGGVXsP2@kroah.com>
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
> kernfs / sysfs is in not struct device specific, it has no semantics for
> modules or even devices. The aspect of kernfs which deals with locking
> a struct kernfs_node is kernfs_get_active(). The refcount there of
> importance is the call to atomic_inc_unless_negative(&kn->active).
> 
> struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)                   
> {                                                                               
> 	if (unlikely(!kn))
> 		return NULL;                                                    
> 
> 	if (!atomic_inc_unless_negative(&kn->active))                           
> 		return NULL;                                                    
> 
> 	if (kernfs_lockdep(kn))
> 		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);               
> 	return kn;                                                              
> }
> 
> BTW this was also precisely where I had suggested to extend the
> kernfs_node with an optional kn->owner and if set we try_module_get() to
> prevent the deadlock case if the module exit routine also happens to use
> a lock also used by a sysfs attribute store/read.
> 
> The flow would be (from a real live gdb crash backtrace from an original
> bug report from a customer):
> 
> write system call -->
>   ksys_write ()
>     vfs_write() -->
>       __vfs_write() -->
>        kernfs_fop_write() (note now this is kernfs_fop_write_iter()) -->
>          sysfs_kf_write() -->
>            dev_attr_store() -->
> 	     null reference
> 
> The dereference is because the dev_attr_store() call which we are
> modifying
> 
> LINE-001 static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,                                                                                         
> LINE-002 const char *buf, size_t count)                                                                                                                 
> LINE-003 {
> LINE-004	struct device_attribute *dev_attr = to_dev_attr(attr);
> LINE-005	struct device *dev = kobj_to_dev(kobj);
> LINE-006	ssize_t ret = -EIO;
> LINE-007
> LINE-008	if (dev_attr->store)
> LINE-009		ret = dev_attr->store(dev, dev_attr, buf, count);
> 	...
> 	}
> 
> The race happens because a sysfs store / read can be triggered, the CPU
> could be preempted after LINE-008, and the ->store is gone by LINE-009.
> This begs the question if kernfs_fop_write_iter() or sysfs protects this
> somehow? Let's see.
> 
> For kernfs we have:
> 
> static ssize_t kernfs_fop_write_iter(struct kiocb *iocb, struct iov_iter *iter) 
> {
> 	struct kernfs_open_file *of = kernfs_of(iocb->ki_filp);
> 	...
> 	mutex_lock(&of->mutex);
> 	if (!kernfs_get_active(of->kn)) {
> 		mutex_unlock(&of->mutex);
> 		len = -ENODEV;
> 		goto out_free;
> 	}
> 
> 	ops = kernfs_ops(of->kn);
> 	if (ops->write)
> 		len = ops->write(of, buf, len, iocb->ki_pos);
> 	else
> 		len = -EINVAL;
> 
> 	kernfs_put_active(of->kn);
> 	mutex_unlock(&of->mutex);
> 	...
> }
> 
> And the write call here is a syfs calls:
> 
> static ssize_t sysfs_kf_write(struct kernfs_open_file *of, char *buf,           
> 			      size_t count, loff_t pos)                         
> {                                                                               
> 	const struct sysfs_ops *ops = sysfs_file_ops(of->kn);                   
> 	struct kobject *kobj = of->kn->parent->priv;                            
> 
> 	if (!count)                                                             
> 		return 0;                                                       
> 
> 	return ops->store(kobj, of->kn->priv, buf, count);                      
> }           
> 
> As we have observed already, the active reference obtained through
> kernfs_get_active() was for the struct kernfs_node. Sure, the
> ops->write() is valid, in this case it sysfs_kf_write().
> 
> sysfs isn't doing any active reference check for the kobject device
> attribute as it doesn't care for them. So syfs calls
> dev_attr_store(), but the dev_attr_store() is not preventing the device
> attribute ops to go fishing, and we destroy them while we're destroying
> the device on module removal.

Ah, but sysfs _should_ be doing this properly.

I think the issue is that when we store the kobject pointer in kernfs,
it is NOT incremented.  Look at sysfs_create_dir_ns(), if we call
kobject_get(kobj) right before we call kernfs_create_dir_ns(), and then
properly clean things up later on when we remove the sysfs directory
(i.e. the kobject), it _should_ fix this problem.

Then, we know, whenever show/store/whatever is called, when we cast out
of kernfs the private pointer to a kobject, that the kobject really is
still alive, so we can use it properly.

Can you try that, it should be a much "simpler" change here.

thanks,

greg k-h
