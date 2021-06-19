Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774ADC2B9F4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 06:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569B5611CD
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 06:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhFSGre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhFSGre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 02:47:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F32611CC;
        Sat, 19 Jun 2021 06:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624085123;
        bh=gZApFMXHDsp6CryFssz+iSa+yhSULSfzKkNakx0NpTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=18OavBaXa0wDz7TianJR07Bd8ET0qABW0QQcdwp8P87KhuPc3X+7D1wUUFQAMPhkb
         CCfwbhCF4Ct8wS2wa4iW9xUDARiUOGVMNE4sNaquifeF7rOxPcORcKH+elRPG9JtPC
         MHqN+Y9x8dHp08p4rGfp24iizbd/ElOmlZjgyKYE=
Date:   Sat, 19 Jun 2021 08:44:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     hch@infradead.org, axboe@kernel.dk, desmondcheongzx@gmail.com,
        linux-block@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        Shuah Khan <skhan@linuxfoundation.org>,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com,
        vigneshr@ti.com
Subject: Re: [PATCH v2] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YM2STfTN5AupWlSa@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 19, 2021 at 10:05:44AM +0900, Tetsuo Handa wrote:
> syzbot is reporting circular locking problem at blk_request_module() [1],
> for blk_request_module() is calling probe function with major_names_lock
> held while major_names_lock is held during module's __init and __exit
> functions.
> 
>                                          loop_exit() {
>                                            mutex_lock(&loop_ctl_mutex);
>   blk_request_module() {
>     mutex_lock(&major_names_lock);
>     loop_probe() {
>       mutex_lock(&loop_ctl_mutex); // Blocked by loop_exit()
>       mutex_unlock(&loop_ctl_mutex);
>     }
>     mutex_unlock(&major_names_lock);
>                                            unregister_blkdev() {
>                                              mutex_lock(&major_names_lock); // Blocked by blk_request_module()
>                                              mutex_unlock(&major_names_lock);
>                                            }
>                                            mutex_unlock(&loop_ctl_mutex);
>   }
>                                          }
> 
> Based on an assumption that a probe callback passed to __register_blkdev()
> belongs to a module which calls __register_blkdev(), drop major_names_lock
> before calling probe function by holding a reference to that module which
> contains that probe function. If there is a module where this assumption
> does not hold, such module can call ____register_blkdev() directly.
> 
>   blk_request_module() {
>     mutex_lock(&major_names_lock);
>     // Block loop_exit()
>     mutex_unlock(&major_names_lock);
>     loop_probe() {
>       mutex_lock(&loop_ctl_mutex);
>       mutex_unlock(&loop_ctl_mutex);
>     }
>     // Unblock loop_exit()
>   }
>                                          loop_exit() {
>                                            mutex_lock(&loop_ctl_mutex);
>                                            unregister_blkdev() {
>                                              mutex_lock(&major_names_lock);
>                                              mutex_unlock(&major_names_lock);
>                                            }
>                                            mutex_unlock(&loop_ctl_mutex);
>                                          }
> 
> Note that regardless of this patch, it is up to probe function to
> serialize module's __init function and probe function in that module
> by using e.g. a mutex. This patch simply makes sure that module's __exit
> function won't be called when probe function is about to be called.

module init functions ARE serialized.

> 
> While Desmond Cheong Zhi Xi already proposed a patch for breaking ABCD
> circular dependency [2], I consider that this patch is still needed for
> safely breaking AB-BA dependency upon module unloading. (Note that syzbot
> does not test module unloading code because the syzbot kernels are built
> with almost all modules built-in. We need manual inspection.)
> 
> By doing kmalloc(GFP_KERNEL) in ____register_blkdev() before holding
> major_names_lock, we could convert major_names_lock from a mutex to
> a spinlock. But that is beyond the scope of this patch.
> 
> Link: https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb [1]
> Link: https://lkml.kernel.org/r/20210617160904.570111-1-desmondcheongzx@gmail.com [2]
> Reported-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com>
> ---
>  block/genhd.c         | 36 +++++++++++++++++++++++++++---------
>  include/linux/genhd.h |  8 +++++---
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 9f8cb7beaad1..9577c70a6bd3 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -169,6 +169,7 @@ static struct blk_major_name {
>  	int major;
>  	char name[16];
>  	void (*probe)(dev_t devt);
> +	struct module *owner;

The module owner should not matter here.


>  } *major_names[BLKDEV_MAJOR_HASH_SIZE];
>  static DEFINE_MUTEX(major_names_lock);
>  
> @@ -197,7 +198,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
>   * @major: the requested major device number [1..BLKDEV_MAJOR_MAX-1]. If
>   *         @major = 0, try to allocate any unused major number.
>   * @name: the name of the new block device as a zero terminated string
> - * @probe: allback that is called on access to any minor number of @major
> + * @probe: callback that is called on access to any minor number of @major
> + * @owner: the owner of @probe function (i.e. THIS_MODULE or NULL).

This feels wrong.

>   *
>   * The @name must be unique within the system.
>   *
> @@ -214,8 +216,8 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
>   *
>   * Use register_blkdev instead for any new code.
>   */
> -int __register_blkdev(unsigned int major, const char *name,
> -		void (*probe)(dev_t devt))
> +int ____register_blkdev(unsigned int major, const char *name,
> +			void (*probe)(dev_t devt), struct module *owner)

That's just a crazy naming scheme, please no.

>  {
>  	struct blk_major_name **n, *p;
>  	int index, ret = 0;
> @@ -255,6 +257,7 @@ int __register_blkdev(unsigned int major, const char *name,
>  
>  	p->major = major;
>  	p->probe = probe;
> +	p->owner = owner;
>  	strlcpy(p->name, name, sizeof(p->name));
>  	p->next = NULL;
>  	index = major_to_index(major);
> @@ -277,7 +280,7 @@ int __register_blkdev(unsigned int major, const char *name,
>  	mutex_unlock(&major_names_lock);
>  	return ret;
>  }
> -EXPORT_SYMBOL(__register_blkdev);
> +EXPORT_SYMBOL(____register_blkdev);

That's crazy.

>  
>  void unregister_blkdev(unsigned int major, const char *name)
>  {
> @@ -676,14 +679,29 @@ void blk_request_module(dev_t devt)
>  {
>  	unsigned int major = MAJOR(devt);
>  	struct blk_major_name **n;
> +	void (*probe_fn)(dev_t devt);
>  
>  	mutex_lock(&major_names_lock);
>  	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
> -		if ((*n)->major == major && (*n)->probe) {
> -			(*n)->probe(devt);
> -			mutex_unlock(&major_names_lock);
> -			return;
> -		}
> +		if ((*n)->major != major || !(*n)->probe)
> +			continue;
> +		if (!try_module_get((*n)->owner))
> +			break;

So you just fail?  Are you sure that is ok?


> +		/*
> +		 * Calling probe function with major_names_lock held causes
> +		 * circular locking dependency problem. Thus, call it after
> +		 * releasing major_names_lock.
> +		 */
> +		probe_fn = (*n)->probe;
> +		mutex_unlock(&major_names_lock);

So you save a pointer off and then unlock?  Why does that lock matter?

> +		/*
> +		 * Assuming that unregister_blkdev() is called from module's
> +		 * __exit function, a module refcount taken above allows us
> +		 * to safely call probe function without major_names_lock held.
> +		 */
> +		probe_fn(devt);
> +		module_put((*n)->owner);

So you are trying to keep the module in memory while the probe is call,
ok.  But module removal is not an issue, you remove modules at your own
risk.  As syzbot isn't even testing this, why is this an issue?


> +		return;
>  	}
>  	mutex_unlock(&major_names_lock);
>  
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 6fc26f7bdf71..070b73c043e6 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -277,10 +277,12 @@ extern void put_disk(struct gendisk *disk);
>  
>  #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
>  
> -int __register_blkdev(unsigned int major, const char *name,
> -		void (*probe)(dev_t devt));
> +int ____register_blkdev(unsigned int major, const char *name,
> +			void (*probe)(dev_t devt), struct module *owner);
> +#define __register_blkdev(major, name, probe) \
> +	____register_blkdev(major, name, probe, THIS_MODULE)

This just feels wrong, you should only need 1 level deep of __ at most.

thanks,

greg k-h
