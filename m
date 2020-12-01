Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E38C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E71206A5
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBA+XFFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgLAOEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391486AbgLAOEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 09:04:32 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3015DC0613CF
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 06:03:52 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so1171241pfp.7
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LcmB8gL5LCoUpzUzQul2LXMgJlZvj2iPuh9c1EVINQg=;
        b=CBA+XFFrwGJcqS5hzVwfpqHwClWY38I4ibTwlp9VK7D/DBrW/AIosOtwAwQRrgRcV5
         asBQ3jxYjBebgRrNYlesQr5QhDthJ7ehf0UG8ZW2TFlbnFiABo6Axq9ewoGv585vvxht
         EqqaOsmb/wq0o85kiuwcHp38Hu3mFIJs1fo3jAT4v3RgGgDes74Jq1BxEefcoXXf+UJs
         TbSKI5LJQAOvZjRtB2AvAMwsy/23iaWuAT8/n52i0NYbVmwfzO/1oilq/kLiSHiLrox3
         qomObzuPUwdDJP/Qge8PD95sdi8mvbbizjCvmwAeZxVNB1L/C1Yctyc2amdb+U49VXt4
         V4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LcmB8gL5LCoUpzUzQul2LXMgJlZvj2iPuh9c1EVINQg=;
        b=dqZcuo2BVTxLCB3pRpfonv2Xjx0D4VfDr0rtaZLfqLkVxP4oMtNmgtY9iRkwNd0jKZ
         wKkFpf9blsYoPsAFQJ+Os3+J1MT77FaP3PNo9N8b6X6oE7H2ZiT2ysm3n8B6kfmr5LdB
         Rk8izD/qxdFQt1T9iUjVitQqnIzrC8jqg0oCpnRYsbswz1LU6HlxeCBwxe7hUTE4hON1
         Iv2shjzh01at7o8H1ypZMjfwbSvu+uaQ1H3tUC6Lv/QYYeOSQILdd3jAHCoPed7VvPGu
         1Afh3VQbWelH4JP6BadrOhAh4RH2OZZjcJvOpuW2sjJas5C1JfhnhFVIYjKcJDr/wkYK
         Yg7Q==
X-Gm-Message-State: AOAM530mL/zmhxuHHqvz/8dlVti+/4QnioRlrEnPUuYFm6TbXO+FgVt5
        jtt61iB4Yi2ldZnMSfJJiq8=
X-Google-Smtp-Source: ABdhPJx9XlxdpnPoE890IIitZNFRXuuOCJE78CaY8hvKol8lKZFsxj6uX1qFw8c+sAtDkjim17znXQ==
X-Received: by 2002:a63:505b:: with SMTP id q27mr2384589pgl.137.1606831431637;
        Tue, 01 Dec 2020 06:03:51 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id e21sm2937923pfd.107.2020.12.01.06.03.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 06:03:50 -0800 (PST)
Date:   Tue, 1 Dec 2020 23:03:48 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201140348.GA5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201125610.17138-5-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 20-12-01 13:56:10, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Create a char device per NVMe namespace. This char device is always
> initialized, independently of whether thedeatures implemented by the
> device are supported by the kernel. User-space can therefore always
> issue IOCTLs to the NVMe driver using this char device.
> 
> The char device is presented as /dev/nvmeXcYnZ to follow the hidden
> block device. This naming also aligns with nvme-cli filters, so the char
> device should be usable without tool changes.
> 
> Signed-off-by: Javier González <javier.gonz@samsung.com>
> ---
>  drivers/nvme/host/core.c | 144 +++++++++++++++++++++++++++++++++++----
>  drivers/nvme/host/nvme.h |   3 +
>  2 files changed, 132 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2c23ea6dc296..9c4acf2725f3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -86,7 +86,9 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
>  
>  static DEFINE_IDA(nvme_instance_ida);
>  static dev_t nvme_ctrl_base_chr_devt;
> +static dev_t nvme_ns_base_chr_devt;
>  static struct class *nvme_class;
> +static struct class *nvme_ns_class;
>  static struct class *nvme_subsys_class;
>  
>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
> @@ -497,6 +499,7 @@ static void nvme_free_ns(struct kref *kref)
>  	if (ns->ndev)
>  		nvme_nvm_unregister(ns);
>  
> +	cdev_device_del(&ns->cdev, &ns->cdev_device);
>  	put_disk(ns->disk);
>  	nvme_put_ns_head(ns->head);
>  	nvme_put_ctrl(ns->ctrl);
> @@ -1696,15 +1699,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
>  	return ret;
>  }
>  
> -static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
> -		unsigned int cmd, unsigned long arg)
> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
> +			   unsigned long arg)
>  {
>  	struct nvme_ns_head *head = NULL;
>  	void __user *argp = (void __user *)arg;
>  	struct nvme_ns *ns;
>  	int srcu_idx, ret;
>  
> -	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
> +	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
>  	if (unlikely(!ns))
>  		return -EWOULDBLOCK;
>  
> @@ -1741,6 +1744,18 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	return ret;
>  }
>  
> +static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
> +		      unsigned int cmd, unsigned long arg)
> +{
> +	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
> +}
> +
> +static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  struct nvme_user_io32 {
>  	__u8	opcode;
> @@ -1782,10 +1797,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
>  #define nvme_compat_ioctl	NULL
>  #endif /* CONFIG_COMPAT */
>  
> -static int nvme_open(struct block_device *bdev, fmode_t mode)
> +static int __nvme_open(struct nvme_ns *ns)
>  {
> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
> -
>  #ifdef CONFIG_NVME_MULTIPATH
>  	/* should never be called due to GENHD_FL_HIDDEN */
>  	if (WARN_ON_ONCE(ns->head->disk))
> @@ -1804,12 +1817,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>  	return -ENXIO;
>  }
>  
> +static void __nvme_release(struct nvme_ns *ns)
> +{
> +	module_put(ns->ctrl->ops->module);
> +	nvme_put_ns(ns);
> +}
> +
> +static int nvme_open(struct block_device *bdev, fmode_t mode)
> +{
> +	struct nvme_ns *ns = bdev->bd_disk->private_data;
> +
> +	return __nvme_open(ns);
> +}
> +
>  static void nvme_release(struct gendisk *disk, fmode_t mode)
>  {
>  	struct nvme_ns *ns = disk->private_data;
>  
> -	module_put(ns->ctrl->ops->module);
> -	nvme_put_ns(ns);
> +	__nvme_release(ns);
>  }
>  
>  static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> @@ -1821,6 +1846,26 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return 0;
>  }
>  
> +static int nvme_cdev_open(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +	int ret;
> +
> +	ret = __nvme_open(ns);
> +	if (!ret)
> +		file->private_data = ns->disk;
> +
> +	return ret;
> +}
> +
> +static int nvme_cdev_release(struct inode *inode, struct file *file)
> +{
> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
> +
> +	__nvme_release(ns);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
>  				u32 max_integrity_segments)
> @@ -2303,6 +2348,14 @@ static const struct block_device_operations nvme_bdev_ops = {
>  	.pr_ops		= &nvme_pr_ops,
>  };
>  
> +static const struct file_operations nvme_cdev_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= nvme_cdev_open,
> +	.release	= nvme_cdev_release,
> +	.unlocked_ioctl	= nvme_cdev_ioctl,
> +	.compat_ioctl	= compat_ptr_ioctl,
> +};
> +
>  #ifdef CONFIG_NVME_MULTIPATH
>  static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
>  {
> @@ -3301,6 +3354,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>  {
>  	struct gendisk *disk = dev_to_disk(dev);
>  
> +	if (dev->class == nvme_ns_class)
> +		return ((struct nvme_ns *)dev_get_drvdata(dev))->head;

I think it would be better if it can have inline function
nvme_get_ns_from_cdev() just like nvme_get_ns_from_dev().

> +
>  	if (disk->fops == &nvme_bdev_ops)
>  		return nvme_get_ns_from_dev(dev)->head;
>  	else
> @@ -3390,7 +3446,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
>  };
>  
>  static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
> -		struct attribute *a, int n)
> +	       struct attribute *a, int n)

Unrelated changes for this patch.

>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
>  	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
> @@ -3432,6 +3488,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
>  	NULL,
>  };
>  
> +const struct attribute_group *nvme_ns_char_id_attr_groups[] = {
> +	&nvme_ns_id_attr_group,
> +	NULL,
> +};
> +
>  #define nvme_show_str_function(field)						\
>  static ssize_t  field##_show(struct device *dev,				\
>  			    struct device_attribute *attr, char *buf)		\
> @@ -3824,6 +3885,36 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  }
>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>  
> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> +{
> +	char cdisk_name[DISK_NAME_LEN];
> +	int ret = 0;

Unnecessary initialization for local variable.

> +
> +	device_initialize(&ns->cdev_device);
> +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
> +				     ns->head->instance);
> +	ns->cdev_device.class = nvme_ns_class;
> +	ns->cdev_device.parent = ctrl->device;
> +	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
> +	dev_set_drvdata(&ns->cdev_device, ns);
> +
> +	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
> +			ctrl->instance, ns->head->instance);

In multi-path, private namespaces for a head are not in /dev, so I don't
think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
like it will make a little bit confusions between chardev and hidden blkdev.

I don't against to update nvme-cli things also even naming conventions are
going to become different than nvmeXcYnZ.
