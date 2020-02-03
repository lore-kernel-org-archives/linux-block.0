Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DB1C33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC75020658
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 12:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWWeKH5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBCM0T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:26:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23454 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgBCM0T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Feb 2020 07:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580732778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1G3DiOYC0S4Ba+SCWCudiO7SLYfZsEB+L93ae7aN88g=;
        b=MWWeKH5BEDhzlifBHskqs7MNTqdhrdsducnkx6yPlyjFSgD6HVzI3X3zzm0cVZUdsuykuU
        ZqlMQPGrX2Zntl9pRRaJnBmVJEHCmdQx29FenVcO4ErABnKkYNIW2i1f8CeRuscOFO2DLh
        NPjddRlB89lQa91QZiVhJG/F68AqMIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-hmNPL9KLPyeBBu-orpI8Qg-1; Mon, 03 Feb 2020 07:26:14 -0500
X-MC-Unique: hmNPL9KLPyeBBu-orpI8Qg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DA213E6;
        Mon,  3 Feb 2020 12:26:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03DE310841A3;
        Mon,  3 Feb 2020 12:26:06 +0000 (UTC)
Date:   Mon, 3 Feb 2020 20:26:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
Subject: Re: [PATCH V4] brd: check and limit max_part par
Message-ID: <20200203122005.GB31450@ming.t460p>
References: <76ad8074-c2ba-4bb3-3e8b-3a4925999964@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ad8074-c2ba-4bb3-3e8b-3a4925999964@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 21, 2020 at 12:04:41PM +0800, Zhiqiang Liu wrote:
> 
> In brd_init func, rd_nr num of brd_device are firstly allocated
> and add in brd_devices, then brd_devices are traversed to add each
> brd_device by calling add_disk func. When allocating brd_device,
> the disk->first_minor is set to i * max_part, if rd_nr * max_part
> is larger than MINORMASK, two different brd_device may have the same
> devt, then only one of them can be successfully added.
> when rmmod brd.ko, it will cause oops when calling brd_exit.
> 
> Follow those steps:
>   # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
>   # rmmod brd
> then, the oops will appear.
> 
> Oops log:
> [  726.613722] Call trace:
> [  726.614175]  kernfs_find_ns+0x24/0x130
> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
> [  726.615749]  sysfs_remove_group+0x38/0xb0
> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
> [  726.617320]  blk_unregister_queue+0x98/0x100
> [  726.618105]  del_gendisk+0x144/0x2b8
> [  726.618759]  brd_exit+0x68/0x560 [brd]
> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
> [  726.620384]  el0_svc_common+0x78/0x130
> [  726.621057]  el0_svc_handler+0x38/0x78
> [  726.621738]  el0_svc+0x8/0xc
> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
> 
> Here, we add brd_check_and_reset_par func to check and limit max_part par.
> 
> --
> V3->V4:(suggested by Ming Lei)
>  - remove useless change
>  - add one limit of max_part
> 
> V2->V3: (suggested by Ming Lei)
>  - clear .minors when running out of consecutive minor space in brd_alloc
>  - remove limit of rd_nr
> 
> V1->V2: add more checks in brd_check_par_valid as suggested by Ming Lei.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/block/brd.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index df8103dd40ac..4684f95e3369 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -389,11 +389,12 @@ static struct brd_device *brd_alloc(int i)
>  	 *  is harmless)
>  	 */
>  	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
> -	disk = brd->brd_disk = alloc_disk(max_part);
> +	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
> +			0 : max_part);
>  	if (!disk)
>  		goto out_free_queue;
>  	disk->major		= RAMDISK_MAJOR;
> -	disk->first_minor	= i * max_part;
> +	disk->first_minor	= i * disk->minors;

The above change isn't necessary.

>  	disk->fops		= &brd_fops;
>  	disk->private_data	= brd;
>  	disk->queue		= brd->brd_queue;
> @@ -468,6 +469,25 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
>  	return kobj;
>  }
> 
> +static inline void brd_check_and_reset_par(void)
> +{
> +	if (unlikely(!max_part))
> +		max_part = 1;
> +
> +	if (max_part > DISK_MAX_PARTS) {
> +		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
> +			DISK_MAX_PARTS, DISK_MAX_PARTS);
> +		max_part = DISK_MAX_PARTS;
> +	}
> +
> +	/*
> +	 * make sure 'max_part' can be divided exactly by (1U << MINORBITS),
> +	 * otherwise, it is possiable to get same dev_t when adding partitions.
> +	 */
> +	if ((1U << MINORBITS) % max_part != 0)
> +		max_part = 1UL << fls(max_part);
> +}

You should move the above change before capping it to DISK_MAX_PARTS
since  1UL << fls() may increase 'max_part'.


Thanks, 
Ming

