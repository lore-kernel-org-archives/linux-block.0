Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E70C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DF92151B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IH9T6tw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgLAS6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:58:35 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53426 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAS6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 13:58:35 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201201185743euoutp01aaf603beed4432f500919229ad4bc388~MrLWjDvCx1964519645euoutp01m
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 18:57:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201201185743euoutp01aaf603beed4432f500919229ad4bc388~MrLWjDvCx1964519645euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606849063;
        bh=rFWUXYFnA0jTn5ywLIwp+F/g/RhR+mR4Amvt6uMaKSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IH9T6tw/r6lVGQHn/caWjxaMQS6iwq+/Ktr3iwBQgN4RpWPy5qldqL+XAHWbO62U6
         v3/j5GfAt8C4Dc0DAaGMElv2cMQVUT1Y4oub/S1jTCc5heKE5RlJVn9RfYkcdk9KC/
         +jipfPLPI/NWjkh3NmPnW+T1XDk4XSfSYO22u1BM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201201185734eucas1p1e17bcfd494462d442fca6a80dcd2065d~MrLOCJ4n20436204362eucas1p11;
        Tue,  1 Dec 2020 18:57:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.53.45488.D1296CF5; Tue,  1
        Dec 2020 18:57:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201201185732eucas1p2054b7c8a6ef26acf82e31657a6f619cc~MrLM4BWfw3021630216eucas1p2T;
        Tue,  1 Dec 2020 18:57:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201201185732eusmtrp1fc3f83ca092f1dfa473c7947d03930a7~MrLM3bl9P1000810008eusmtrp1R;
        Tue,  1 Dec 2020 18:57:32 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-15-5fc6921dd56e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 85.F7.16282.C1296CF5; Tue,  1
        Dec 2020 18:57:32 +0000 (GMT)
Received: from localhost (unknown [106.210.248.142]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201201185732eusmtip205b3e94ebfcd467ac9aeceec0e0df73f~MrLMtKqbr0412404124eusmtip2c;
        Tue,  1 Dec 2020 18:57:32 +0000 (GMT)
Date:   Tue, 1 Dec 2020 19:57:32 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201201140348.GA5138@localhost.localdomain>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZduznOV3ZScfiDf73WFmsXH2UyWLSoWuM
        FntvaVvMX/aU3eJXJ7fFutfvWRzYPHbOusvucf7eRhaPTas62Tw2L6n32H2zgc3j8ya5ALYo
        LpuU1JzMstQifbsErozfh00KjjtXrD5wir2B8bB5FyMnh4SAiUT/xrmsXYxcHEICKxglJn2e
        xw7hfGGU6Jy3E8r5zCixpmMrC0zLg10zWCASyxkljvxtYYNwXjJKTDw5kR2kikVARaK1Zyoz
        iM0mYCXxe+MHsG4RAXWJJQ+WMYLYzAJFEnO6e4BqODiEBewlGv6zgYR5BVwl5t0+wQRhC0qc
        nPkErJUTaMzSQwvAdkkInOCQ+L9jN9RFLhILZrdD2cISr45vYYewZSROT+5hgdiVIfGl4QQr
        RNxRYtvvuewgeyUE+CRuvBWEKOGTmLRtOjNEmFeio00IwlSVmPeVG6JRWmJfwx42CNtD4vCh
        R4jwWfd7CtsERplZSK6ehWQxhG0l0fmhCcqWl2jeOpt5FtAKZqC5y/9xQJiaEut36S9gZFvF
        KJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmEhO/zv+dQfjilcf9Q4xMnEwHmKU4GBWEuFl
        +XckXog3JbGyKrUoP76oNCe1+BCjNAeLkjjvrq1r4oUE0hNLUrNTUwtSi2CyTBycUg1MGxZu
        azovm9lt+Lf+2kzdx9bapz4qS52QFtq0PcqpirMiKf6ZpxjT1dSam9NM+5JlYhz+/hN8c9JQ
        OPr31ekHUx42Xfm0vfhWqZ1J3r+P4muYDAUmJH8wFGh8tKm2RFLEjnlj6rHM1848k+91TtW4
        PCfIYqqAJKtl8CsL9bnnDU/PVGGcFHWmh1ct2X/2lf9azzqiHxS7fNNndloYO9FPPNV2omnl
        aq+LXSF6wZx9R0WqFj1Z1dUoddF8yZPNXxUvqHStvCvct0mQm+PQFOc2jrfh/rMnJ++fILvQ
        eNZ++6WiV+/n1qZ3TAhX/L4m0fZZm4LFrra1C10m76iVOXSTc3+/6+kAxyUeC1/8CrilxFKc
        kWioxVxUnAgAzKVo/ZMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xe7oyk47FG7xfp2OxcvVRJotJh64x
        Wuy9pW0xf9lTdotfndwW616/Z3Fg89g56y67x/l7G1k8Nq3qZPPYvKTeY/fNBjaPz5vkAtii
        9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DI+vlzP
        XHDDoaJh/yvmBsaPJl2MnBwSAiYSD3bNYOli5OIQEljKKLHjYStzFyMHUEJa4vIXVYgaYYk/
        17rYIGqeM0p8mN3IDJJgEVCRaO2ZCmazCVhJ/N74gQXEFhFQl1jyYBkjiM0sUCQxp7sHbKaw
        gL1Ew382kDCvgKvEvNsnmCBmfmaU2H15EjNEQlDi5MwnLBC9ZhLzNj8E62UGumf5Pw6IsLxE
        89bZYOWcQGuXHlrANoFRcBaS7llIumchdM9C0r2AkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+
        7iZGYERtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMLL8u9IvBBvSmJlVWpRfnxRaU5q8SFGU2BI
        TGSWEk3OB8Z0Xkm8oZmBqaGJmaWBqaWZsZI4r8mRNfFCAumJJanZqakFqUUwfUwcnFINTP5/
        3DWuqa0u/GYqfefAkV/HMqOl93okB1jfSPzgcPG/JNtqNkex/LUNc1Q6DbSLFkw5JTVj1e0q
        id4NrWFb1ugn+DuXrPz5lHFWg/NkIV/BLSFncx0jbTsX+1eVLNGTYdf3LTB8zD6xseFAjKek
        oZUY35Ty9A/W5c7K6juvhPcZyngIzWzb7CzTWLGi7ecDrcLuvSw9jVNm9fY3mjFmrotIfbil
        XHjxBwOZHSw3nhVKVigoZ7u1rDHW2bT25KXUpttyeRcm86a1y1cKrW5SbPqv/7PS4q9j1Fp/
        x1I1/aaXqt/1ZgimW0pP27xc69DZY2xOwXKm/wu0NhR8mPXroYvSwc8zNRmzZmg8aVZiKc5I
        NNRiLipOBADAWcPAMQMAAA==
X-CMS-MailID: 20201201185732eucas1p2054b7c8a6ef26acf82e31657a6f619cc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----LkNG-TPHYSBfDE9jPplB8AKC_s9ES4xCokgna438ZFnziyS4=_79df3_"
X-RootMTR: 20201201140354eucas1p1940891b47ca0c03ea46603393c844f61
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201201140354eucas1p1940891b47ca0c03ea46603393c844f61
References: <20201201125610.17138-1-javier.gonz@samsung.com>
        <20201201125610.17138-5-javier.gonz@samsung.com>
        <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
        <20201201140348.GA5138@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------LkNG-TPHYSBfDE9jPplB8AKC_s9ES4xCokgna438ZFnziyS4=_79df3_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 01.12.2020 23:03, Minwoo Im wrote:
>Hello,
>
>On 20-12-01 13:56:10, javier@javigon.com wrote:
>> From: Javier González <javier.gonz@samsung.com>
>>
>> Create a char device per NVMe namespace. This char device is always
>> initialized, independently of whether thedeatures implemented by the
>> device are supported by the kernel. User-space can therefore always
>> issue IOCTLs to the NVMe driver using this char device.
>>
>> The char device is presented as /dev/nvmeXcYnZ to follow the hidden
>> block device. This naming also aligns with nvme-cli filters, so the char
>> device should be usable without tool changes.
>>
>> Signed-off-by: Javier González <javier.gonz@samsung.com>
>> ---
>>  drivers/nvme/host/core.c | 144 +++++++++++++++++++++++++++++++++++----
>>  drivers/nvme/host/nvme.h |   3 +
>>  2 files changed, 132 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 2c23ea6dc296..9c4acf2725f3 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -86,7 +86,9 @@ static DEFINE_MUTEX(nvme_subsystems_lock);
>>
>>  static DEFINE_IDA(nvme_instance_ida);
>>  static dev_t nvme_ctrl_base_chr_devt;
>> +static dev_t nvme_ns_base_chr_devt;
>>  static struct class *nvme_class;
>> +static struct class *nvme_ns_class;
>>  static struct class *nvme_subsys_class;
>>
>>  static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>> @@ -497,6 +499,7 @@ static void nvme_free_ns(struct kref *kref)
>>  	if (ns->ndev)
>>  		nvme_nvm_unregister(ns);
>>
>> +	cdev_device_del(&ns->cdev, &ns->cdev_device);
>>  	put_disk(ns->disk);
>>  	nvme_put_ns_head(ns->head);
>>  	nvme_put_ctrl(ns->ctrl);
>> @@ -1696,15 +1699,15 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
>>  	return ret;
>>  }
>>
>> -static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>> -		unsigned int cmd, unsigned long arg)
>> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
>> +			   unsigned long arg)
>>  {
>>  	struct nvme_ns_head *head = NULL;
>>  	void __user *argp = (void __user *)arg;
>>  	struct nvme_ns *ns;
>>  	int srcu_idx, ret;
>>
>> -	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
>> +	ns = nvme_get_ns_from_disk(disk, &head, &srcu_idx);
>>  	if (unlikely(!ns))
>>  		return -EWOULDBLOCK;
>>
>> @@ -1741,6 +1744,18 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>>  	return ret;
>>  }
>>
>> +static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>> +		      unsigned int cmd, unsigned long arg)
>> +{
>> +	return __nvme_ns_ioctl(bdev->bd_disk, cmd, arg);
>> +}
>> +
>> +static long nvme_cdev_ioctl(struct file *file, unsigned int cmd,
>> +			    unsigned long arg)
>> +{
>> +	return __nvme_ns_ioctl((struct gendisk *)file->private_data, cmd, arg);
>> +}
>> +
>>  #ifdef CONFIG_COMPAT
>>  struct nvme_user_io32 {
>>  	__u8	opcode;
>> @@ -1782,10 +1797,8 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
>>  #define nvme_compat_ioctl	NULL
>>  #endif /* CONFIG_COMPAT */
>>
>> -static int nvme_open(struct block_device *bdev, fmode_t mode)
>> +static int __nvme_open(struct nvme_ns *ns)
>>  {
>> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
>> -
>>  #ifdef CONFIG_NVME_MULTIPATH
>>  	/* should never be called due to GENHD_FL_HIDDEN */
>>  	if (WARN_ON_ONCE(ns->head->disk))
>> @@ -1804,12 +1817,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>>  	return -ENXIO;
>>  }
>>
>> +static void __nvme_release(struct nvme_ns *ns)
>> +{
>> +	module_put(ns->ctrl->ops->module);
>> +	nvme_put_ns(ns);
>> +}
>> +
>> +static int nvme_open(struct block_device *bdev, fmode_t mode)
>> +{
>> +	struct nvme_ns *ns = bdev->bd_disk->private_data;
>> +
>> +	return __nvme_open(ns);
>> +}
>> +
>>  static void nvme_release(struct gendisk *disk, fmode_t mode)
>>  {
>>  	struct nvme_ns *ns = disk->private_data;
>>
>> -	module_put(ns->ctrl->ops->module);
>> -	nvme_put_ns(ns);
>> +	__nvme_release(ns);
>>  }
>>
>>  static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>> @@ -1821,6 +1846,26 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>>  	return 0;
>>  }
>>
>> +static int nvme_cdev_open(struct inode *inode, struct file *file)
>> +{
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>> +	int ret;
>> +
>> +	ret = __nvme_open(ns);
>> +	if (!ret)
>> +		file->private_data = ns->disk;
>> +
>> +	return ret;
>> +}
>> +
>> +static int nvme_cdev_release(struct inode *inode, struct file *file)
>> +{
>> +	struct nvme_ns *ns = container_of(inode->i_cdev, struct nvme_ns, cdev);
>> +
>> +	__nvme_release(ns);
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>>  static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
>>  				u32 max_integrity_segments)
>> @@ -2303,6 +2348,14 @@ static const struct block_device_operations nvme_bdev_ops = {
>>  	.pr_ops		= &nvme_pr_ops,
>>  };
>>
>> +static const struct file_operations nvme_cdev_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.open		= nvme_cdev_open,
>> +	.release	= nvme_cdev_release,
>> +	.unlocked_ioctl	= nvme_cdev_ioctl,
>> +	.compat_ioctl	= compat_ptr_ioctl,
>> +};
>> +
>>  #ifdef CONFIG_NVME_MULTIPATH
>>  static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
>>  {
>> @@ -3301,6 +3354,9 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
>>  {
>>  	struct gendisk *disk = dev_to_disk(dev);
>>
>> +	if (dev->class == nvme_ns_class)
>> +		return ((struct nvme_ns *)dev_get_drvdata(dev))->head;
>
>I think it would be better if it can have inline function
>nvme_get_ns_from_cdev() just like nvme_get_ns_from_dev().

Good point. Will add that.

>
>> +
>>  	if (disk->fops == &nvme_bdev_ops)
>>  		return nvme_get_ns_from_dev(dev)->head;
>>  	else
>> @@ -3390,7 +3446,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
>>  };
>>
>>  static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
>> -		struct attribute *a, int n)
>> +	       struct attribute *a, int n)
>
>Unrelated changes for this patch.
>
>>  {
>>  	struct device *dev = container_of(kobj, struct device, kobj);
>>  	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
>> @@ -3432,6 +3488,11 @@ const struct attribute_group *nvme_ns_id_attr_groups[] = {
>>  	NULL,
>>  };
>>
>> +const struct attribute_group *nvme_ns_char_id_attr_groups[] = {
>> +	&nvme_ns_id_attr_group,
>> +	NULL,
>> +};
>> +
>>  #define nvme_show_str_function(field)						\
>>  static ssize_t  field##_show(struct device *dev,				\
>>  			    struct device_attribute *attr, char *buf)		\
>> @@ -3824,6 +3885,36 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
>>
>> +static int nvme_alloc_chardev_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
>> +{
>> +	char cdisk_name[DISK_NAME_LEN];
>> +	int ret = 0;
>
>Unnecessary initialization for local variable.
>
>> +
>> +	device_initialize(&ns->cdev_device);
>> +	ns->cdev_device.devt = MKDEV(MAJOR(nvme_ns_base_chr_devt),
>> +				     ns->head->instance);
>> +	ns->cdev_device.class = nvme_ns_class;
>> +	ns->cdev_device.parent = ctrl->device;
>> +	ns->cdev_device.groups = nvme_ns_char_id_attr_groups;
>> +	dev_set_drvdata(&ns->cdev_device, ns);
>> +
>> +	sprintf(cdisk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
>> +			ctrl->instance, ns->head->instance);
>
>In multi-path, private namespaces for a head are not in /dev, so I don't
>think this will hurt private namespaces (e.g., nvme0c0n1), But it looks
>like it will make a little bit confusions between chardev and hidden blkdev.
>
>I don't against to update nvme-cli things also even naming conventions are
>going to become different than nvmeXcYnZ.

Agree. But as I understand it, Keith had a good argument to keep names
aligned with the hidden bdev. It is also true that in that comment he
suggested nesting the char device in /dev/nvme

Keith, would you mind looking over this? Thanks!


------LkNG-TPHYSBfDE9jPplB8AKC_s9ES4xCokgna438ZFnziyS4=_79df3_
Content-Type: text/plain; charset="utf-8"


------LkNG-TPHYSBfDE9jPplB8AKC_s9ES4xCokgna438ZFnziyS4=_79df3_--
