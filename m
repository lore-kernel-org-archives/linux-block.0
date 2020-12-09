Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28907C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1367238EB
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 09:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgLIJRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 04:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgLIJRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 04:17:19 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C9C0613D6
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 01:16:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id dk8so766901edb.1
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 01:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=udImeOyopR6lKcri/5XEEUcYqPTE+FQlxvMzQAlhsfU=;
        b=vKk2LJLVoo/f7CceJHDSRilhBANlh+e/wINNi3QCldXHlHeXQqbabWeoOPIJg56Pie
         /iY1I6MxINZ/+727sMSvyjb6SCu2kLXbOIRkOf6x8RXlzt6NwuE2x2yCqecCZXqf/nL5
         mVsEQnq3CEwWGhq443jayVBtta1KjNpGNBatvm4nfZ6bNjF4Ctlk85P4UWjHxjOvmQVO
         W+gBjwCW5hCxIm0SYc/Qgkm6Bq0XBKDjWrftKvO8TO5pRZ7e3HHj4jFVpUgmicmtnbUm
         8AK+yMYd6k34jocVoElM1JLAQFYn4IhOZ668G67fbvTg3yrZQxApWpt80x6wMlZpnEKS
         yCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=udImeOyopR6lKcri/5XEEUcYqPTE+FQlxvMzQAlhsfU=;
        b=I9s03oZisdbbQGlnFl4BRirUEm8s3HJpa/4GcsJGCqQd1mHVZxxBCHRHwzYszrkEgF
         DBoAp8+EMIfud6O34q93pExjlUkC5fcVlXUoziF1TWe7xxUxFW2vgrBfxdy58VquPUKw
         YUpcLf31u/XSJW5hqYrb3eQpHFHTzawsbmp4Wu9sXGFfbHoW//D9ObmsIQ5PY459happ
         31YqI5IR9p8dpPovU/kUM1fjCPwnnF8N1rmA8S8ItDYZpv1IU95QfdM3OszqS97MqqOP
         YKQiBBrZF5sqKoFGlYe/J5S9t5vhnJV1NMsJyzMSK5OXT4jYdvJVO9ypNQtQlgPZc8tf
         3wrw==
X-Gm-Message-State: AOAM531vsKQEdAZ8e2WK8UAjTnY9RnbKgnl/bmpWtQzW2G9OF+Mq2Y/L
        Z294DV+68KljCZwuTv7rcfjpIg==
X-Google-Smtp-Source: ABdhPJy0H5iRcjQAbbMA5JxnGNd1eAPAnQfg7wbllmKdUB4JqkBOK+CIIgrkHlPxfH07M/Tbwvu/gg==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr1127552eds.328.1607505397434;
        Wed, 09 Dec 2020 01:16:37 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id h16sm882131eji.110.2020.12.09.01.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:16:36 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:16:36 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201209091636.5jrexhqmjmqwyqaz@mpHalley>
References: <20201208132934.625-1-javier.gonz@samsung.com>
 <20201208142151.GA4108@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201208142151.GA4108@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08.12.2020 15:21, Christoph Hellwig wrote:
>A bunch of nitpicks (mostly naming as usual, sorry..):

No worries. Thanks for taking the time.

>
>> +static int __nvme_ns_ioctl(struct gendisk *disk, unsigned int cmd,
>> +			   unsigned long arg)
>>  {
>
>What about nvme_disk_ioctl instead as that is what it operates on?

Sure.

>
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
>
>No need for the cast.
>
>Also can we keep all the char device methods together close to the
>struct file_operations declaration?  I just prefer to keep the code
>a little grouped.

Perfect.

>
>> -static int nvme_open(struct block_device *bdev, fmode_t mode)
>> +static int __nvme_open(struct nvme_ns *ns)
>>  {
>> -	struct nvme_ns *ns = bdev->bd_disk->private_data;
>> -
>>  #ifdef CONFIG_NVME_MULTIPATH
>>  	/* should never be called due to GENHD_FL_HIDDEN */
>>  	if (WARN_ON_ONCE(ns->head->disk))
>> @@ -1846,12 +1859,24 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>>  	return -ENXIO;
>>  }
>>
>> +static void __nvme_release(struct nvme_ns *ns)
>> +{
>> +	module_put(ns->ctrl->ops->module);
>> +	nvme_put_ns(ns);
>> +}
>
>nvme_ns_open and nvme_ns_release?

ok.

>
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
>
>No need for the local ns variable in both cases.

ok.
>
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
>
>Do we need the ->private_data assignment at all?  I think the ioctl
>handler could just grab it directly from i_cdev.

Mmmm. Good point. I'll try that.

>
>> +	sprintf(cdisk_name, "nvme%dn%dc", ctrl->instance, ns->head->instance);
>
>And the most important naming decision is this.  I have two issues with
>naming still:
>
> - we aready use the c for controller in the hidden disk naming.  Although
>   that is in a different position, but I think this not super intuitive.
> - this is missing multipath support entirely, so once we want to add
>   multipath support we'll run into issues.  So maybe use something
>   based off the hidden node naming?  E.g.:
>
>	sprintf(disk_name, "nvme-generic-%dc%dn%d", ctrl->subsys->instance,
>		ctrl->instance, ns->head->instance);

Perfect. Sounds like a good compromise to still keep the original hidden
disk. Keith is happy too, so we have a plan.

>> +	/* When the device does not support any of the features required by the
>> +	 * kernel (or viceversa), hide the block device. We can still rely on
>> +	 * the namespace char device for submitting IOCTLs
>> +	 */
>
>Normal kernel comment style is the opening
>
>	/*
>
>on its own line.

OK.

>
>>  	if (nvme_update_ns_info(ns, id))
>> -		goto out_put_disk;
>> +		disk->flags |= GENHD_FL_HIDDEN;
>
>I don't think we can do this based on all the error returns.  I think
>we'll have to move the flags manipulation into nvme_update_ns_info to
>also cover the revalidate case.

Ok.

I am working on the multipath part. I'll send a V3 with all these
comments and then a follow-up patch with multipath.


