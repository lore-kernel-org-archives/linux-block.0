Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38CDC48BE6
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 08:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A655861153
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 08:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhFNI3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 04:29:05 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:42756 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhFNI3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 04:29:04 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lshvw-0003nA-QZ; Mon, 14 Jun 2021 08:27:01 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lshvu-0004j9-MJ; Mon, 14 Jun 2021 09:27:00 +0100
Subject: Re: [PATCH 2/2] ubd: use blk_mq_alloc_disk and blk_cleanup_disk
To:     Christoph Hellwig <hch@lst.de>,
        Richard Weinberger <richard@nod.at>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210614060759.3965724-1-hch@lst.de>
 <20210614060759.3965724-3-hch@lst.de>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <847f7608-1d11-1410-5394-b5aa5de9f45e@cambridgegreys.com>
Date:   Mon, 14 Jun 2021 09:26:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614060759.3965724-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 14/06/2021 07:07, Christoph Hellwig wrote:
> Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
> request_queue allocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/um/drivers/ubd_kern.c | 44 ++++++++++++--------------------------
>   1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index f508d45f7a69..0b86aa1b12f1 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -825,7 +825,6 @@ static void ubd_device_release(struct device *dev)
>   {
>   	struct ubd *ubd_dev = dev_get_drvdata(dev);
>   
> -	blk_cleanup_queue(ubd_dev->queue);
>   	blk_mq_free_tag_set(&ubd_dev->tag_set);
>   	*ubd_dev = ((struct ubd) DEFAULT_UBD);
>   }
> @@ -865,17 +864,12 @@ static const struct attribute_group *ubd_attr_groups[] = {
>   	NULL,
>   };
>   
> -static int ubd_disk_register(int major, u64 size, int unit,
> -			     struct gendisk **disk_out)
> +static void ubd_disk_register(int major, u64 size, int unit,
> +			      struct gendisk *disk)
>   {
> -	struct gendisk *disk;
> -
> -	disk = alloc_disk(1 << UBD_SHIFT);
> -	if(disk == NULL)
> -		return -ENOMEM;
> -
>   	disk->major = major;
>   	disk->first_minor = unit << UBD_SHIFT;
> +	disk->minors = 1 << UBD_SHIFT;
>   	disk->fops = &ubd_blops;
>   	set_capacity(disk, size / 512);
>   	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
> @@ -889,9 +883,6 @@ static int ubd_disk_register(int major, u64 size, int unit,
>   	disk->private_data = &ubd_devs[unit];
>   	disk->queue = ubd_devs[unit].queue;
>   	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
> -
> -	*disk_out = disk;
> -	return 0;
>   }
>   
>   #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
> @@ -903,6 +894,7 @@ static const struct blk_mq_ops ubd_mq_ops = {
>   static int ubd_add(int n, char **error_out)
>   {
>   	struct ubd *ubd_dev = &ubd_devs[n];
> +	struct gendisk *disk;
>   	int err = 0;
>   
>   	if(ubd_dev->file == NULL)
> @@ -927,32 +919,24 @@ static int ubd_add(int n, char **error_out)
>   	if (err)
>   		goto out;
>   
> -	ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
> -	if (IS_ERR(ubd_dev->queue)) {
> -		err = PTR_ERR(ubd_dev->queue);
> +	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
> +	if (IS_ERR(disk)) {
> +		err = PTR_ERR(disk);
>   		goto out_cleanup_tags;
>   	}
> +	ubd_dev->queue = disk->queue;
>   
> -	ubd_dev->queue->queuedata = ubd_dev;
>   	blk_queue_write_cache(ubd_dev->queue, true, false);
> -
>   	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
>   	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
> -	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, &ubd_gendisk[n]);
> -	if(err){
> -		*error_out = "Failed to register device";
> -		goto out_cleanup_tags;
> -	}
> -
> -	err = 0;
> -out:
> -	return err;
> +	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
> +	ubd_gendisk[n] = disk;
> +	return 0;
>   
>   out_cleanup_tags:
>   	blk_mq_free_tag_set(&ubd_dev->tag_set);
> -	if (!(IS_ERR(ubd_dev->queue)))
> -		blk_cleanup_queue(ubd_dev->queue);
> -	goto out;
> +out:
> +	return err;
>   }
>   
>   static int ubd_config(char *str, char **error_out)
> @@ -1055,7 +1039,7 @@ static int ubd_remove(int n, char **error_out)
>   	ubd_gendisk[n] = NULL;
>   	if(disk != NULL){
>   		del_gendisk(disk);
> -		put_disk(disk);
> +		blk_cleanup_disk(disk);
>   	}
>   
>   	err = 0;
> 

This does not build for me when applied to master:


arch/um/drivers/ubd_kern.c: In function ‘ubd_add’:
arch/um/drivers/ubd_kern.c:922:9: error: implicit declaration of function ‘blk_mq_alloc_disk’; did you mean ‘blk_mq_alloc_request’? [-Werror=implicit-function-declaration]
   disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
          ^~~~~~~~~~~~~~~~~
          blk_mq_alloc_request
arch/um/drivers/ubd_kern.c:922:7: warning: assignment to ‘struct gendisk *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
   disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
        ^
arch/um/drivers/ubd_kern.c: In function ‘ubd_remove’:
arch/um/drivers/ubd_kern.c:1042:3: error: implicit declaration of function ‘blk_cleanup_disk’; did you mean ‘blk_cleanup_queue’? [-Werror=implicit-function-declaration]
    blk_cleanup_disk(disk);

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
