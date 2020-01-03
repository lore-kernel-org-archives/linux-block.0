Return-Path: <SRS0=4w+H=2Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A4C32767
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5001E22522
	for <linux-block@archiver.kernel.org>; Fri,  3 Jan 2020 12:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgACMnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:43:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727508AbgACMnW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Jan 2020 07:43:22 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4939966E90F76C354A2D;
        Fri,  3 Jan 2020 20:43:20 +0800 (CST)
Received: from [10.173.221.193] (10.173.221.193) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 3 Jan 2020 20:43:11 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     "houtao (A)" <houtao1@huawei.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@lst.de" <hch@lst.de>, zhengchuan <zhengchuan@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
References: <20191231110945.10857-1-yuyufen@huawei.com>
 <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <5cc465cc-d68c-088e-0729-2695279c7853@huawei.com>
Date:   Fri, 3 Jan 2020 20:43:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <a9ce86d6-dadb-9301-7d76-8cef81d782fd@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.193]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/12/31 22:55, houtao (A) wrote:

> diff --git a/block/genhd.c b/block/genhd.c
> index 6e8543ca6912..179e0056fae1 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -279,7 +279,14 @@ struct hd_struct *disk_map_sector_rcu(struct gendisk *disk, sector_t sector)
>   		part = rcu_dereference(ptbl->part[i]);
> 
>   		if (part && sector_in_part(part, sector)) {
> -			rcu_assign_pointer(ptbl->last_lookup, part);
> +			struct hd_struct *old;
> +
> +			if (!hd_struct_try_get(part))
> +				break;
> +
> +			old = xchg(&ptbl->last_lookup, part);
> +			if (old)
> +				hd_struct_put(old);
>   			return part;
>   		}
>   	}
> @@ -1231,7 +1238,11 @@ static void disk_replace_part_tbl(struct gendisk *disk,
>   	rcu_assign_pointer(disk->part_tbl, new_ptbl);
> 
>   	if (old_ptbl) {
> -		rcu_assign_pointer(old_ptbl->last_lookup, NULL);
> +		struct hd_struct *part;
> +
> +		part = xchg(&old_ptbl->last_lookup, NULL);
> +		if (part)
> +			hd_struct_put(part);
>   		kfree_rcu(old_ptbl, rcu_head);
>   	}
>   }
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 98d60a59b843..441c1c591c04 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -285,7 +285,8 @@ void delete_partition(struct gendisk *disk, int partno)
>   		return;
> 
>   	rcu_assign_pointer(ptbl->part[partno], NULL);
> -	rcu_assign_pointer(ptbl->last_lookup, NULL);
> +	if (cmpxchg(&ptbl->last_lookup, part, NULL) == part)
> +		hd_struct_put(part);
>   	kobject_put(part->holder_dir);
>   	device_del(part_to_dev(part));
> 
This change will add more calling of hd_struct_try_get()/hd_struct_put()
when set last_lookup. Thus, Tao warried abort extra overhead.

We test the patch on a SSD disk by fio with config:
[global]
rw=randread
bs=4k
numjobs=2
ioengine=libaio
iodepth=32
direct=1
runtime=120
size=100G
group_reporting
time_based

[sda1]
filename=/dev/sda1

[sda2]
filename=/dev/sda2

[sda3]
filename=/dev/sda3

[sda4]
filename=/dev/sda4

Compared with the previous version, io bandwidth have no any degeneration.

Thanks,
Yufen





