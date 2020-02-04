Return-Path: <SRS0=vwZl=3Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C2C2D0B1
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 11:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530392087E
	for <linux-block@archiver.kernel.org>; Tue,  4 Feb 2020 11:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgBDLSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:18:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgBDLSi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Feb 2020 06:18:38 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1844E1A56B88039184FB;
        Tue,  4 Feb 2020 19:18:33 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 19:18:27 +0800
Subject: Re: [PATCH V5] brd: check and limit max_part par
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, Guiyao <guiyao@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>
References: <3f053491-d8c1-7092-58d1-85afaa2e68df@huawei.com>
 <20200204085218.GA19922@ming.t460p>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <9ca2aa6a-6d61-16e3-678c-b91fd28b0b88@huawei.com>
Date:   Tue, 4 Feb 2020 19:18:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200204085218.GA19922@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/2/4 16:52, Ming Lei wrote:
> On Tue, Feb 04, 2020 at 10:44:18AM +0800, Zhiqiang Liu wrote:
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
>> Here, we add brd_check_and_reset_par func to check and limit max_part par.
>>
>> --
>> V4->V5:(suggested by Ming Lei)
>>  - make sure max_part is not larger than DISK_MAX_PARTS
>>
>> V3->V4:(suggested by Ming Lei)
>>  - remove useless change
>>  - add one limit of max_part
>>
>> V2->V3: (suggested by Ming Lei)
>>  - clear .minors when running out of consecutive minor space in brd_alloc
>>  - remove limit of rd_nr
>>
>> V1->V2:
>>  - add more checks in brd_check_par_valid as suggested by Ming Lei.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>  drivers/block/brd.c | 27 +++++++++++++++++++++++----
>>  1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index df8103dd40ac..6b9db3f63cb7 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -389,11 +389,12 @@ static struct brd_device *brd_alloc(int i)
>>  	 *  is harmless)
>>  	 */
>>  	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
>> -	disk = brd->brd_disk = alloc_disk(max_part);
>> +	disk = brd->brd_disk = alloc_disk(((i * max_part) & ~MINORMASK) ?
>> +			0 : max_part);
>>  	if (!disk)
>>  		goto out_free_queue;
>>  	disk->major		= RAMDISK_MAJOR;
>> -	disk->first_minor	= i * max_part;
>> +	disk->first_minor	= i * disk->minors;
> 
> As I told you, the above change isn't needed, otherwise:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Sorry for missing that. I will remove these in v6 patch.
Thanks for your patience.


