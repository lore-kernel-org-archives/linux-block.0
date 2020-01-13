Return-Path: <SRS0=JObX=3C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB293C33CAD
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 12:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB28C2080D
	for <linux-block@archiver.kernel.org>; Mon, 13 Jan 2020 12:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgAMMzc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:55:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbgAMMzc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jan 2020 07:55:32 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DF64D5A19E236C3B78D8;
        Mon, 13 Jan 2020 20:55:29 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 20:55:19 +0800
Subject: Re: [PATCH] brd: check parameter validation before register_blkdev
 func
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <npiggin@suse.de>, Mingfangsen <mingfangsen@huawei.com>,
        Guiyao <guiyao@huawei.com>, zhangsaisai <zhangsaisai@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>
References: <342ee238-0e7c-c213-eecc-7062f24985cc@huawei.com>
 <20200113110003.GA13011@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <a1036173-7e6d-8ad6-774c-df4b912146c8@huawei.com>
Date:   Mon, 13 Jan 2020 20:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113110003.GA13011@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/1/13 19:04, Ming Lei wrote:
> On Fri, Jan 10, 2020 at 01:10:20PM +0800, Zhiqiang Liu wrote:
>>
>> In brd_init func, rd_nr num of brd_device are firstly allocated
>> and add in brd_devices, then brd_devices are traversed to add each
>> brd_device by calling add_disk func. When allocating brd_device,
>> the disk->first_minor is set to i * max_part, if rd_nr * max_part
>> is larger than MINORMASK, two different brd_device may have the same
>> devt, then only one of them can be successfully added.
>> when rmmod brd.ko, it will cause oops when calling brd_exit.
>>
>> Follow those steps:
>>   # modprobe brd rd_nr=3 rd_size=102400 max_part=1048576
>>   # rmmod brd
>> then, the oops will appear.
>>
>> Oops log:
>> [  726.613722] Call trace:
>> [  726.614175]  kernfs_find_ns+0x24/0x130
>> [  726.614852]  kernfs_find_and_get_ns+0x44/0x68
>> [  726.615749]  sysfs_remove_group+0x38/0xb0
>> [  726.616520]  blk_trace_remove_sysfs+0x1c/0x28
>> [  726.617320]  blk_unregister_queue+0x98/0x100
>> [  726.618105]  del_gendisk+0x144/0x2b8
>> [  726.618759]  brd_exit+0x68/0x560 [brd]
>> [  726.619501]  __arm64_sys_delete_module+0x19c/0x2a0
>> [  726.620384]  el0_svc_common+0x78/0x130
>> [  726.621057]  el0_svc_handler+0x38/0x78
>> [  726.621738]  el0_svc+0x8/0xc
>> [  726.622259] Code: aa0203f6 aa0103f7 aa1e03e0 d503201f (7940e260)
>>
>> Here, we add brd_check_par_valid func to check parameter
>> validation before register_blkdev func.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  drivers/block/brd.c | 33 ++++++++++++++++++++++++++-------
>> +static inline int brd_check_par_valid(void)
>> +{
>> +	if (unlikely(!rd_nr))
>> +		rd_nr = 1;
>> +
>> +	if (unlikely(!max_part))
>> +		max_part = 1;
>> +
>> +	if (rd_nr * max_part > MINORMASK)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +
>> +}
>> +
>>  static int __init brd_init(void)
>>  {
>>  	struct brd_device *brd, *next;
>> -	int i;
>> +	int i, ret;
>>
>>  	/*
>>  	 * brd module now has a feature to instantiate underlying device
>> @@ -488,11 +503,15 @@ static int __init brd_init(void)
>>  	 *	dynamically.
>>  	 */
>>
>> +	ret = brd_check_par_valid();
>> +	if (ret) {
>> +		pr_info("brd: invalid parameter setting!!!\n");
>> +		return ret;
>> +	}
>> +
> 
> The max supported partition number is 256, see __alloc_disk_node().
> So even though one bigger number is passed to alloc_disk(), at most
> 256 partitions are allowed on that disk. Maybe you can apply the
> following way to avoid the issue:
> 
> 	disk->first_minor       = i * disk->minors;
> 
> However, looks 'rd_nr' still needs to be validated(rd_nr < 2 ^ 23).
> 

Thanks for your reply.
As you said, minors is limited to DISK_MAX_PARTS in __alloc_disk_node when
calling alloc_disk in brd_alloc func. We can set: disk->first_minor = i * disk->minors
as your suggestion.
As for 'rd_nr', I think we should make sure that 'disk->first_minor' should be not
larger than MINORMASK.

->add_disk
  ->device_add_disk
    ->__device_add_disk
      ->blk_alloc_devt
	->MKDEV

If rd_nr > MINORMASK / min(max_part, DISK_MAX_PARTS), two different brd_device may have the same devt
by calling MKDEV in blk_alloc_devt func. For example, MKDEV(1, 0) is equal to MKDEV(1, MINORMASK + 1).
So we should check both rd_nr and max_part as follows,

    static inline int brd_check_par_valid(void)
    {
            if (unlikely(!rd_nr))
                    rd_nr = 1;

            if (unlikely(!max_part))
                    max_part = 1;

            if (max_part > DISK_MAX_PARTS)
                    max_part = DISK_MAX_PARTS;

            if (rd_nr > MINORMASK / max_part)
                    return -EINVAL;

            return 0;
    }

I will send the v2 patch.




