Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A148FC48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8207661380
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 08:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhFNIY6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:24:58 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:42732 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNIY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 04:24:58 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lshrx-0003mW-V4; Mon, 14 Jun 2021 08:22:54 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lshrv-0004ab-Hf; Mon, 14 Jun 2021 09:22:53 +0100
Subject: Re: [PATCH 1/2] ubd: remove the code to register as the legacy IDE
 driver
To:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210614060759.3965724-1-hch@lst.de>
 <20210614060759.3965724-2-hch@lst.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <5a9207a0-91e9-d843-9968-2db26946be73@cambridgegreys.com>
Date:   Mon, 14 Jun 2021 09:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614060759.3965724-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 14/06/2021 07:07, Christoph Hellwig wrote:
> With the legacy IDE driver long deprecated, and modern userspace being
> much more flexible about dev_t assignments there is no reason to fake
> a registration as the legacy IDE driver in ubd.  This registeration
> is a little problematic as it registers the same request_queue for
> multiple gendisks, so just remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c | 106 +++++--------------------------------
>   1 file changed, 12 insertions(+), 94 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 8e0b43cf089f..f508d45f7a69 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -125,9 +125,7 @@ static const struct block_device_operations ubd_blops = {
>   };
>   
>   /* Protected by ubd_lock */
> -static int fake_major = UBD_MAJOR;
>   static struct gendisk *ubd_gendisk[MAX_DEV];
> -static struct gendisk *fake_gendisk[MAX_DEV];
>   
>   #ifdef CONFIG_BLK_DEV_UBD_SYNC
>   #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 1, .c = 0, \
> @@ -197,54 +195,19 @@ struct ubd {
>   /* Protected by ubd_lock */
>   static struct ubd ubd_devs[MAX_DEV] = { [0 ... MAX_DEV - 1] = DEFAULT_UBD };
>   
> -/* Only changed by fake_ide_setup which is a setup */
> -static int fake_ide = 0;
> -static struct proc_dir_entry *proc_ide_root = NULL;
> -static struct proc_dir_entry *proc_ide = NULL;
> -
>   static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
>   				 const struct blk_mq_queue_data *bd);
>   
> -static void make_proc_ide(void)
> -{
> -	proc_ide_root = proc_mkdir("ide", NULL);
> -	proc_ide = proc_mkdir("ide0", proc_ide_root);
> -}
> -
> -static int fake_ide_media_proc_show(struct seq_file *m, void *v)
> -{
> -	seq_puts(m, "disk\n");
> -	return 0;
> -}
> -
> -static void make_ide_entries(const char *dev_name)
> -{
> -	struct proc_dir_entry *dir, *ent;
> -	char name[64];
> -
> -	if(proc_ide_root == NULL) make_proc_ide();
> -
> -	dir = proc_mkdir(dev_name, proc_ide);
> -	if(!dir) return;
> -
> -	ent = proc_create_single("media", S_IRUGO, dir,
> -			fake_ide_media_proc_show);
> -	if(!ent) return;
> -	snprintf(name, sizeof(name), "ide0/%s", dev_name);
> -	proc_symlink(dev_name, proc_ide_root, name);
> -}
> -
>   static int fake_ide_setup(char *str)
>   {
> -	fake_ide = 1;
> +	pr_warn("The fake_ide option has been removed\n");
>   	return 1;
>   }
> -
>   __setup("fake_ide", fake_ide_setup);
>   
>   __uml_help(fake_ide_setup,
>   "fake_ide\n"
> -"    Create ide0 entries that map onto ubd devices.\n\n"
> +"    Obsolete stub.\n\n"
>   );
>   
>   static int parse_unit(char **ptr)
> @@ -296,20 +259,8 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
>   			return err;
>   		}
>   
> -		mutex_lock(&ubd_lock);
> -		if (fake_major != UBD_MAJOR) {
> -			*error_out = "Can't assign a fake major twice";
> -			goto out1;
> -		}
> -
> -		fake_major = major;
> -
> -		printk(KERN_INFO "Setting extra ubd major number to %d\n",
> -		       major);
> -		err = 0;
> -	out1:
> -		mutex_unlock(&ubd_lock);
> -		return err;
> +		pr_warn("fake major not supported any more\n");
> +		return 0;
>   	}
>   
>   	n = parse_unit(&str);
> @@ -917,7 +868,6 @@ static const struct attribute_group *ubd_attr_groups[] = {
>   static int ubd_disk_register(int major, u64 size, int unit,
>   			     struct gendisk **disk_out)
>   {
> -	struct device *parent = NULL;
>   	struct gendisk *disk;
>   
>   	disk = alloc_disk(1 << UBD_SHIFT);
> @@ -928,24 +878,17 @@ static int ubd_disk_register(int major, u64 size, int unit,
>   	disk->first_minor = unit << UBD_SHIFT;
>   	disk->fops = &ubd_blops;
>   	set_capacity(disk, size / 512);
> -	if (major == UBD_MAJOR)
> -		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
> -	else
> -		sprintf(disk->disk_name, "ubd_fake%d", unit);
> -
> -	/* sysfs register (not for ide fake devices) */
> -	if (major == UBD_MAJOR) {
> -		ubd_devs[unit].pdev.id   = unit;
> -		ubd_devs[unit].pdev.name = DRIVER_NAME;
> -		ubd_devs[unit].pdev.dev.release = ubd_device_release;
> -		dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
> -		platform_device_register(&ubd_devs[unit].pdev);
> -		parent = &ubd_devs[unit].pdev.dev;
> -	}
> +	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
> +
> +	ubd_devs[unit].pdev.id   = unit;
> +	ubd_devs[unit].pdev.name = DRIVER_NAME;
> +	ubd_devs[unit].pdev.dev.release = ubd_device_release;
> +	dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
> +	platform_device_register(&ubd_devs[unit].pdev);
>   
>   	disk->private_data = &ubd_devs[unit];
>   	disk->queue = ubd_devs[unit].queue;
> -	device_add_disk(parent, disk, ubd_attr_groups);
> +	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
>   
>   	*disk_out = disk;
>   	return 0;
> @@ -1001,17 +944,6 @@ static int ubd_add(int n, char **error_out)
>   		goto out_cleanup_tags;
>   	}
>   
> -	if (fake_major != UBD_MAJOR)
> -		ubd_disk_register(fake_major, ubd_dev->size, n,
> -				  &fake_gendisk[n]);
> -
> -	/*
> -	 * Perhaps this should also be under the "if (fake_major)" above
> -	 * using the fake_disk->disk_name
> -	 */
> -	if (fake_ide)
> -		make_ide_entries(ubd_gendisk[n]->disk_name);
> -
>   	err = 0;
>   out:
>   	return err;
> @@ -1126,12 +1058,6 @@ static int ubd_remove(int n, char **error_out)
>   		put_disk(disk);
>   	}
>   
> -	if(fake_gendisk[n] != NULL){
> -		del_gendisk(fake_gendisk[n]);
> -		put_disk(fake_gendisk[n]);
> -		fake_gendisk[n] = NULL;
> -	}
> -
>   	err = 0;
>   	platform_device_unregister(&ubd_dev->pdev);
>   out:
> @@ -1188,14 +1114,6 @@ static int __init ubd_init(void)
>   	if (register_blkdev(UBD_MAJOR, "ubd"))
>   		return -1;
>   
> -	if (fake_major != UBD_MAJOR) {
> -		char name[sizeof("ubd_nnn\0")];
> -
> -		snprintf(name, sizeof(name), "ubd_%d", fake_major);
> -		if (register_blkdev(fake_major, "ubd"))
> -			return -1;
> -	}
> -
>   	irq_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
>   				       sizeof(struct io_thread_req *),
>   				       GFP_KERNEL
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
