Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7FC33CAD
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10DF2081E
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 11:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoo2zPQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgAMLFE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:05:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgAMLFD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 06:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578913502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LEHXgkhJ8pPH8e10XArdPGNvW/iZvMmKPNjc2LR34xs=;
        b=Zoo2zPQUsvv6+28mp0cF09NQVS0GKgpbKw+BUZSmVjLqpLlAkUwbKtvbDHNEyHp1mVn8XB
        MUlk3usvLHe+zbt0cSBw7RXKVTejWBFiw17y/dlFVzp1x0rkVXvNDBqpSFgz8wy1rXjGs4
        SZUl8Vc+T5ZT4vOPRKV2kL3ZeuvO/LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-OiiZe9bONmGbjzi_qzWBYA-1; Mon, 13 Jan 2020 06:04:59 -0500
X-MC-Unique: OiiZe9bONmGbjzi_qzWBYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 042271B18BDE;
        Mon, 13 Jan 2020 11:04:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CBB95C1BB;
        Mon, 13 Jan 2020 11:04:50 +0000 (UTC)
Date:   Mon, 13 Jan 2020 19:04:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        npiggin@suse.de, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
Subject: Re: [PATCH] brd: check parameter validation before register_blkdev
 func
Message-ID: <20200113110003.GA13011@ming.t460p>
References: <342ee238-0e7c-c213-eecc-7062f24985cc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <342ee238-0e7c-c213-eecc-7062f24985cc@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 10, 2020 at 01:10:20PM +0800, Zhiqiang Liu wrote:
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
> Here, we add brd_check_par_valid func to check parameter
> validation before register_blkdev func.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/block/brd.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index df8103dd40ac..3a4510b2c24f 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -330,16 +330,16 @@ static const struct block_device_operations brd_fops = {
>  /*
>   * And now the modules code and kernel interface.
>   */
> -static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
> -module_param(rd_nr, int, 0444);
> +static unsigned int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
> +module_param(rd_nr, uint, 0444);
>  MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
> 
>  unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
>  module_param(rd_size, ulong, 0444);
>  MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
> 
> -static int max_part = 1;
> -module_param(max_part, int, 0444);
> +static unsigned int max_part = 1;
> +module_param(max_part, uint, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
> 
>  MODULE_LICENSE("GPL");
> @@ -468,10 +468,25 @@ static struct kobject *brd_probe(dev_t dev, int *part, void *data)
>  	return kobj;
>  }
> 
> +static inline int brd_check_par_valid(void)
> +{
> +	if (unlikely(!rd_nr))
> +		rd_nr = 1;
> +
> +	if (unlikely(!max_part))
> +		max_part = 1;
> +
> +	if (rd_nr * max_part > MINORMASK)
> +		return -EINVAL;
> +
> +	return 0;
> +
> +}
> +
>  static int __init brd_init(void)
>  {
>  	struct brd_device *brd, *next;
> -	int i;
> +	int i, ret;
> 
>  	/*
>  	 * brd module now has a feature to instantiate underlying device
> @@ -488,11 +503,15 @@ static int __init brd_init(void)
>  	 *	dynamically.
>  	 */
> 
> +	ret = brd_check_par_valid();
> +	if (ret) {
> +		pr_info("brd: invalid parameter setting!!!\n");
> +		return ret;
> +	}
> +

The max supported partition number is 256, see __alloc_disk_node().
So even though one bigger number is passed to alloc_disk(), at most
256 partitions are allowed on that disk. Maybe you can apply the
following way to avoid the issue:

	disk->first_minor       = i * disk->minors;

However, looks 'rd_nr' still needs to be validated(rd_nr < 2 ^ 23).

Thanks,
Ming

