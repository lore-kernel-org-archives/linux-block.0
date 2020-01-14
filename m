Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B76FC33CB1
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 11:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA1624676
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 11:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgANLjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:39:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgANLjK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 06:39:10 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A2D74577847DCCF09A04;
        Tue, 14 Jan 2020 19:39:07 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 19:38:57 +0800
Subject: Re: [PATCH V2] brd: check parameter validation before register_blkdev
 func
To:     Ming Lei <ming.lei@redhat.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>, Guiyao <guiyao@huawei.com>,
        zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <8b32ff09-74aa-3b92-38e4-aab12f47597b@huawei.com>
 <20200114091456.GA22268@ming.t460p> <20200114094550.GA18268@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <1b0e6cc5-784b-e8fa-bb00-2f0a016c37fd@huawei.com>
Date:   Tue, 14 Jan 2020 19:38:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114094550.GA18268@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/1/14 17:45, Ming Lei wrote:
> On Tue, Jan 14, 2020 at 05:16:57PM +0800, Ming Lei wrote:
>> On Mon, Jan 13, 2020 at 09:43:23PM +0800, Zhiqiang Liu wrote:
>>> In brd_init func, rd_nr num of brd_device are firstly allocated
>>> and add in brd_devices, then brd_devices are traversed to add each
>>> brd_device by calling add_disk func. When allocating brd_device,
>>> the disk->first_minor is set to i * max_part, if rd_nr * max_part
>>> is larger than MINORMASK, two different brd_device may have the same
>>> devt, then only one of them can be successfully added.
>>
>> It is just because disk->first_minor is >= 0x100000, then same dev_t
>> can be allocated in blk_alloc_devt().
>>
>> 	MKDEV(disk->major, disk->first_minor + part->partno)
>>
>> But block layer does support extended dynamic devt allocation, and brd
>> sets flag of GENHD_FL_EXT_DEVT too.
>>
>> So I think the correct fix is to fallback to extended dynamic allocation
>> when running out of consecutive minor space.
>>
>> How about the following approach?
>>
>> And of course, ext devt allocation may fail too, but that is another
>> generic un-solved issue: error handling isn't done for adding disk.
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index a8730cc4db10..9aa7ce7c9abf 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -398,7 +398,16 @@ static struct brd_device *brd_alloc(int i)
>>  	if (!disk)
>>  		goto out_free_queue;
>>  	disk->major		= RAMDISK_MAJOR;
>> -	disk->first_minor	= i * max_part;
>> +
>> +	/*
>> +	 * Clear .minors when running out of consecutive minor space since
>> +	 * GENHD_FL_EXT_DEVT is set, and we can allocate from extended devt
>> +	 */
>> +	if ((i * disk->minors) & ~MINORMASK)
>> +		disk->minors = 0;
>> +	else
>> +		disk->first_minor	= i * disk->minors;
>> +
>>  	disk->fops		= &brd_fops;
>>  	disk->private_data	= brd;
>>  	disk->flags		= GENHD_FL_EXT_DEVT;
> 
> But still suggest to limit 'max_part' <= 256, and the name is actually
> misleading, which just reserves consecutive minors.
> 
> However, I don't think it is a good idea to add limit on device number.
> 

Thanks for your patient replyI will resend the v3 patch as your suggestion.
Changes in v3:
	1)clear .minors when running out of consecutive minor space in brd_alloc.
	2)remove limit of rd_nr


