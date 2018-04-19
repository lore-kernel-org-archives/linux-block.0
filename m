Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40911 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeDSRHX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Apr 2018 13:07:23 -0400
MIME-Version: 1.0
In-Reply-To: <CANFzKepsGq0EHX4GPtC0RZOWqVf2fTJ6uA2WH-SZNsBuwMJ5KA@mail.gmail.com>
References: <CANFzKepsGq0EHX4GPtC0RZOWqVf2fTJ6uA2WH-SZNsBuwMJ5KA@mail.gmail.com>
From: Anatoliy Glagolev <glagolig@gmail.com>
Date: Thu, 19 Apr 2018 10:07:21 -0700
Message-ID: <CANFzKer6QDaJALX3LKPF2DV6LgczTh-efQe9+zeK8BuxTWFt1A@mail.gmail.com>
Subject: Re: [PATCH] bsg referencing bus driver module
To: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

+linux-block

On Tue, Apr 17, 2018 at 1:05 PM, Anatoliy Glagolev <glagolig@gmail.com> wrote:
> Description: bsg_release may crash while decrementing reference to the
> parent device with the following stack:
>
> [16834.636216,07] Call Trace:
>                              ...   scsi_proc_hostdir_rm
> [16834.641944,07]  [<ffffffff8141723f>] scsi_host_dev_release+0x3f/0x130
> [16834.647740,07]  [<ffffffff813e4f82>] device_release+0x32/0xa0
> [16834.653423,07]  [<ffffffff812dc6c7>] kobject_cleanup+0x77/0x190
> [16834.659002,07]  [<ffffffff812dc585>] kobject_put+0x25/0x50
> [16834.664430,07]  [<ffffffff813e5277>] put_device+0x17/0x20
> [16834.669740,07]  [<ffffffff812d0334>] bsg_kref_release_function+0x24/0x30
> [16834.675007,07]  [<ffffffff812d14a6>] bsg_release+0x166/0x1d0
> [16834.680148,07]  [<ffffffff8119ba2b>] __fput+0xcb/0x1d0
> [16834.685156,07]  [<ffffffff8119bb6e>] ____fput+0xe/0x10
> [16834.690017,07]  [<ffffffff81077476>] task_work_run+0x86/0xb0
> [16834.694781,07]  [<ffffffff81057043>] exit_to_usermode_loop+0x6b/0x9a
> [16834.699466,07]  [<ffffffff81002875>] syscall_return_slowpath+0x55/0x60
> [16834.704110,07]  [<ffffffff8172d615>] int_ret_from_sys_call+0x25/0x9f
>
> if the parent driver implementing the device has unloaded. To address
> the problem, taking a reference to the parent driver module.
>
> Note: this is a follow-up to earlier discussion "[PATCH] Waiting for
> scsi_host_template release".
>
> ---
>  block/bsg.c                      | 31 +++++++++++++++++++++++++++----
>  drivers/scsi/scsi_transport_fc.c |  3 ++-
>  include/linux/bsg.h              |  5 +++++
>  3 files changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/block/bsg.c b/block/bsg.c
> index b9a5361..0aa7d74 100644
> --- a/block/bsg.c
> +++ b/block/bsg.c
> @@ -798,7 +798,8 @@ found:
>   return bd;
>  }
>
> -static struct bsg_device *bsg_get_device(struct inode *inode, struct
> file *file)
> +static struct bsg_device *bsg_get_device(struct inode *inode, struct
> file *file,
> + struct bsg_class_device **pbcd)
>  {
>   struct bsg_device *bd;
>   struct bsg_class_device *bcd;
> @@ -814,6 +815,7 @@ static struct bsg_device *bsg_get_device(struct
> inode *inode, struct file *file)
>
>   if (!bcd)
>   return ERR_PTR(-ENODEV);
> + *pbcd = bcd;
>
>   bd = __bsg_get_device(iminor(inode), bcd->queue);
>   if (bd)
> @@ -829,22 +831,34 @@ static struct bsg_device *bsg_get_device(struct
> inode *inode, struct file *file)
>  static int bsg_open(struct inode *inode, struct file *file)
>  {
>   struct bsg_device *bd;
> + struct bsg_class_device *bcd;
>
> - bd = bsg_get_device(inode, file);
> + bd = bsg_get_device(inode, file, &bcd);
>
>   if (IS_ERR(bd))
>   return PTR_ERR(bd);
>
>   file->private_data = bd;
> + if (bcd->parent_module) {
> + if (!try_module_get(bcd->parent_module)) {
> + bsg_put_device(bd);
> + return -ENODEV;
> + }
> + }
>   return 0;
>  }
>
>  static int bsg_release(struct inode *inode, struct file *file)
>  {
> + int ret;
>   struct bsg_device *bd = file->private_data;
> + struct module *parent_module = bd->queue->bsg_dev.parent_module;
>
>   file->private_data = NULL;
> - return bsg_put_device(bd);
> + ret = bsg_put_device(bd);
> + if (parent_module)
> + module_put(parent_module);
> + return ret;
>  }
>
>  static unsigned int bsg_poll(struct file *file, poll_table *wait)
> @@ -977,6 +991,14 @@ EXPORT_SYMBOL_GPL(bsg_unregister_queue);
>  int bsg_register_queue(struct request_queue *q, struct device *parent,
>         const char *name, void (*release)(struct device *))
>  {
> + return bsg_register_queue_ex(q, parent, name, release, NULL);
> +}
> +EXPORT_SYMBOL_GPL(bsg_register_queue);
> +
> +int bsg_register_queue_ex(struct request_queue *q, struct device *parent,
> +          const char *name, void (*release)(struct device *),
> +          struct module *parent_module)
> +{
>   struct bsg_class_device *bcd;
>   dev_t dev;
>   int ret;
> @@ -1012,6 +1034,7 @@ int bsg_register_queue(struct request_queue *q,
> struct device *parent,
>   bcd->queue = q;
>   bcd->parent = get_device(parent);
>   bcd->release = release;
> + bcd->parent_module = parent_module;
>   kref_init(&bcd->ref);
>   dev = MKDEV(bsg_major, bcd->minor);
>   class_dev = device_create(bsg_class, parent, dev, NULL, "%s", devname);
> @@ -1039,7 +1062,7 @@ unlock:
>   mutex_unlock(&bsg_mutex);
>   return ret;
>  }
> -EXPORT_SYMBOL_GPL(bsg_register_queue);
> +EXPORT_SYMBOL_GPL(bsg_register_queue_ex);
>
>  static struct cdev bsg_cdev;
>
> diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
> index 24eaaf6..c153f80 100644
> --- a/drivers/scsi/scsi_transport_fc.c
> +++ b/drivers/scsi/scsi_transport_fc.c
> @@ -4064,7 +4064,8 @@ fc_bsg_hostadd(struct Scsi_Host *shost, struct
> fc_host_attrs *fc_host)
>   blk_queue_rq_timed_out(q, fc_bsg_job_timeout);
>   blk_queue_rq_timeout(q, FC_DEFAULT_BSG_TIMEOUT);
>
> - err = bsg_register_queue(q, dev, bsg_name, NULL);
> + err = bsg_register_queue_ex(q, dev, bsg_name, NULL,
> + shost->hostt->module);
>   if (err) {
>   printk(KERN_ERR "fc_host%d: bsg interface failed to "
>   "initialize - register queue\n",
> diff --git a/include/linux/bsg.h b/include/linux/bsg.h
> index 7173f6e..fe41e83 100644
> --- a/include/linux/bsg.h
> +++ b/include/linux/bsg.h
> @@ -12,11 +12,16 @@ struct bsg_class_device {
>   struct request_queue *queue;
>   struct kref ref;
>   void (*release)(struct device *);
> + struct module *parent_module;
>  };
>
>  extern int bsg_register_queue(struct request_queue *q,
>        struct device *parent, const char *name,
>        void (*release)(struct device *));
> +extern int bsg_register_queue_ex(struct request_queue *q,
> +         struct device *parent, const char *name,
> +         void (*release)(struct device *),
> +         struct module *parent_module);
>  extern void bsg_unregister_queue(struct request_queue *);
>  #else
>  static inline int bsg_register_queue(struct request_queue *q,
> --
> 1.9.1
