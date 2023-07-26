Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D60C0015E
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 08:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjGZIuz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 04:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjGZIu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 04:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E4661AE
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 01:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88EFB6179B
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 08:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A5BC433C7;
        Wed, 26 Jul 2023 08:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690361029;
        bh=sICoJFcle9xLziXFbYqiVRwKkTrLwhwRs8b3J374cCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MAsWUZ+SJkqefeHY3jzlmkDQ1ovbSHHfmMx+xQUn9z3yxg+ggPp08AGs3WVDSk8IZ
         1aS8qsAu5n7eZdu91HEfAmXzIu3k1Uadqxm0td9eTgB6A540kOsfwy0z1i+HRbKBob
         yLVZd5mEjH66poi0bGvRG9PPpgYFiqq3l88t8f4s/ipF1ee+6mzy+t9W/GQ20KACAl
         J3FN7T2UV/D40sNpi0cJzflUZTIdk4Kv9n2t9fpjrZofKY+pS0CYh/4nlJ6WqMG+D8
         hThUft3rYo25jnmWqmtyVVNLF+RVdzabQ9QNvaJBSFcE+F9J5SuU0K4KH9de+PCxxQ
         F23SKXQWgp1/A==
Message-ID: <c3e8d288-f463-0708-a815-240cc6a90f43@kernel.org>
Date:   Wed, 26 Jul 2023 17:43:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] block/null_blk: Support disabling zone write
 locking
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        Dan Carpenter <error27@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230726005742.303865-1-bvanassche@acm.org>
 <20230726005742.303865-4-bvanassche@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230726005742.303865-4-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/23 09:57, Bart Van Assche wrote:
> Add a new configfs attribute for disabling zone write locking. The test
> script below reports 250 K IOPS with no I/O scheduler, 6 K IOPS with
> mq-deadline and write locking enabled and 123 K IOPS with mq-deadline
> and write locking disabled. This shows that disabling write locking
> results in about 20 times more IOPS for this particular test case.
> 
>     #!/bin/bash
> 
>     for mode in "none 0" "mq-deadline 0" "mq-deadline 1"; do
>         set +e
>         for d in /sys/kernel/config/nullb/*; do
>             [ -d "$d" ] && rmdir "$d"
>         done
>         modprobe -r null_blk
>         set -e
>         read -r iosched no_write_locking <<<"$mode"
>         modprobe null_blk nr_devices=0
>         (
>             cd /sys/kernel/config/nullb
>             mkdir nullb0
>             cd nullb0
>             params=(
>                 completion_nsec=100000
>                 hw_queue_depth=64
>                 irqmode=2                # NULL_IRQ_TIMER
>                 max_sectors=$((4096/512))
>                 memory_backed=1
>                 no_zone_write_lock="${no_write_locking}"
>                 size=1
>                 submit_queues=1
>                 zone_size=1
>                 zoned=1
>                 power=1
>             )
>             for p in "${params[@]}"; do
>                 echo "${p//*=}" > "${p//=*}"
>             done
>         )
>         udevadm settle
>         dev=/dev/nullb0
>         [ -b "${dev}" ]
>         params=(
>             --direct=1
>             --filename="${dev}"
>             --iodepth=64
>             --iodepth_batch=16
>             --ioengine=io_uring
>             --ioscheduler="${iosched}"
>             --gtod_reduce=1
>             --hipri=0
>             --name=nullb0
>             --runtime=30
>             --rw=write
>             --time_based=1
>             --zonemode=zbd
>         )
>         fio "${params[@]}"
>     done
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/null_blk/main.c     | 2 ++
>  drivers/block/null_blk/null_blk.h | 1 +
>  drivers/block/null_blk/zoned.c    | 3 +++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 864013019d6b..5c0578137f51 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -424,6 +424,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
>  NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
> +NULLB_DEVICE_ATTR(no_zone_write_lock, bool, NULL);
>  NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
>  NULLB_DEVICE_ATTR(no_sched, bool, NULL);
>  NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
> @@ -569,6 +570,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
>  	&nullb_device_attr_zone_max_active,
>  	&nullb_device_attr_zone_readonly,
>  	&nullb_device_attr_zone_offline,
> +	&nullb_device_attr_no_zone_write_lock,
>  	&nullb_device_attr_virt_boundary,
>  	&nullb_device_attr_no_sched,
>  	&nullb_device_attr_shared_tag_bitmap,
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index 929f659dd255..b521096bcc3f 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -117,6 +117,7 @@ struct nullb_device {
>  	bool memory_backed; /* if data is stored in memory */
>  	bool discard; /* if support discard */
>  	bool zoned; /* if device is zoned */
> +	bool no_zone_write_lock;
>  	bool virt_boundary; /* virtual boundary on/off for the device */
>  	bool no_sched; /* no IO scheduler for the device */
>  	bool shared_tag_bitmap; /* use hostwide shared tags */
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 55c5b48bc276..31c8364a63e9 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -96,6 +96,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  
>  	spin_lock_init(&dev->zone_res_lock);
>  
> +	if (dev->no_zone_write_lock)
> +		blk_queue_flag_set(QUEUE_FLAG_NO_ZONE_WRITE_LOCK, q);

This patch look OK, but there is no patch introducing
QUEUE_FLAG_NO_ZONE_WRITE_LOCK... Patch 1 only introduced REQ_NO_ZONE_WRITE_LOCK.

So the series as is will not compile.

> +
>  	if (dev->zone_nr_conv >= dev->nr_zones) {
>  		dev->zone_nr_conv = dev->nr_zones - 1;
>  		pr_info("changed the number of conventional zones to %u",

-- 
Damien Le Moal
Western Digital Research

