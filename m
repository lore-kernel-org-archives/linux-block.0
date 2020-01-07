Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA83C33C9E
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 11:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C492073D
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 11:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAGLk1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:40:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbgAGLk0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 06:40:26 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C8CDDE3AC312FE33E8A7;
        Tue,  7 Jan 2020 19:40:20 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 19:40:11 +0800
Subject: Re: [PATCH] block: make sure last_lookup set as NULL after part
 deleted
To:     Ming Lei <ming.lei@redhat.com>
CC:     Yufen Yu <yuyufen@huawei.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <hch@lst.de>,
        <zhengchuan@huawei.com>, <yi.zhang@huawei.com>,
        <paulmck@kernel.org>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>
References: <20200102012314.GB16719@ming.t460p>
 <c12da8ca-be66-496b-efb2-a60ceaf9ce54@huawei.com>
 <20200103041805.GA29924@ming.t460p>
 <ea362a86-d2de-7dfe-c826-d59e8b5068c3@huawei.com>
 <20200103081745.GA11275@ming.t460p>
 <82c10514-aec5-0d7c-118f-32c261015c6a@huawei.com>
 <20200103151616.GA23308@ming.t460p>
 <582f8e81-6127-47aa-f7fe-035251052238@huawei.com>
 <20200106081137.GA10487@ming.t460p>
 <747c3856-afa4-0909-dae2-f3b23aa38118@huawei.com>
 <20200106100547.GA15256@ming.t460p>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <762e1d7b-af3e-93f4-c744-ecd8ae8946e8@huawei.com>
Date:   Tue, 7 Jan 2020 19:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200106100547.GA15256@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020/1/6 18:05, Ming Lei wrote:
> On Mon, Jan 06, 2020 at 05:41:45PM +0800, Hou Tao wrote:
>> Hi,
>>
[snipped]

>> Yes. The solution you proposed also adds an invocation of percpu_ref_tryget_live()
>> in the fast path. Not sure which one will have a better performance. However the
>> reason we prefer the index caching is the simplicity instead of performance.
> 
> No, hd_struct_try_get() and hd_struct_get() is always called once for one IO, the
> patch I proposed changes nothing about this usage.
> 
> Please take a close look at the patch:
> 
> https://lore.kernel.org/linux-block/5cc465cc-d68c-088e-0729-2695279c7853@huawei.com/T/#m8f3e6b4e77eadf006ce142a84c966f50f3a9ae26
> 
> which just moves hd_struct_try_get() from blk_account_io_start() into
> disk_map_sector_rcu(), doesn't it?
> 
Yes, you are right. And a little suggestion for your patch:

@@ -283,8 +289,9 @@ void delete_partition(struct gendisk *disk, int partno)
 	if (!part)
 		return;

+	get_device(disk_to_dev(disk));
 	rcu_assign_pointer(ptbl->part[partno], NULL);
-	rcu_assign_pointer(ptbl->last_lookup, NULL);
+
 	kobject_put(part->holder_dir);
 	device_del(part_to_dev(part));

Could we move the call of get_device() into add_partition, and that will make the assignment of
disk to p->disk in add_partition() be natural ?

Maybe there is no need to add a new disk field in hd_struct, because the kobject of gendisk
is already the parent of hd_struct. But make use of part->__dev.parent after the calling
of device_del() is a bad_idea.

Regards,
Tao


> 
> Thanks,
> Ming
> 
> 
> .
> 

