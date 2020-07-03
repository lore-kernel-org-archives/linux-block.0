Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DB0C433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 02:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5284020747
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 02:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGCCE5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:04:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbgGCCE5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 22:04:57 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E3FE886D27728ACDE6B7;
        Fri,  3 Jul 2020 10:04:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.226) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Jul 2020
 10:04:51 +0800
Subject: Re: [PATCH] loop: change to punch hole if zero range is not supported
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20200702015401.51199-1-luoshijie1@huawei.com>
 <20200702165721.GS7625@magnolia>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <b8886596-8f05-41b5-eefe-9f2058577285@huawei.com>
Date:   Fri, 3 Jul 2020 10:04:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200702165721.GS7625@magnolia>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.179.226]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/7/3 0:57, Darrick J. Wong wrote:
> On Wed, Jul 01, 2020 at 09:54:01PM -0400, Shijie Luo wrote:
>> We found a problem when excuting these operations.
>>
>> $ cd /tmp
>> $ qemu-img create -f raw test.img 10G
>> $ mknod -m 0660 /dev/loop0 b 7 0
>> $ losetup /dev/loop0 test.img
>> $ mkfs /dev/loop0
>>
>> Here is the error message.
>>
>> [  142.364823] blk_update_request: operation not supported error,
>>   dev loop0, sector 20971392 op 0x9:(WRITE_ZEROES) flags 0x1000800
>>   phys_seg 0 prio class 0
>> [  142.371823] blk_update_request: operation not supported error,
>>   dev loop0, sector 5144 op 0x9:(WRITE_ZEROES) flags 0x1000800
>>   phys_seg 0 prio class 0
>>
>> The problem is that not all filesystem support zero range (eg, tmpfs), if
>>   filesystem doesn 't support zero range, change to punch hole to fix it.
> NAK, ZERO_RANGE requires[1] that "Within the specified range, blocks are
> preallocated for the regions that span the holes in the file."
> PUNCH_HOLE has the opposite effect, and does not qualify as a
> replacement.
>
> --D
>
> [1] https://man7.org/linux/man-pages/man2/fallocate.2.html

Thanks for your reply, I know the difference between ZERO_RANGE and 
PUNCH_HOLE,

but it's hard to provide ZERO_RANGE operation for all filesystem. Maybe 
the formatting

tools should not trigger a NOUNMAP request in this situation.

>> Fixes: efcfec579f613 ("loop: fix no-unmap write-zeroes request behavior")
>> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
>> ---
>>   drivers/block/loop.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index c33bbbfd1bd9..504e658adcaf 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -450,6 +450,13 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>>   	}
>>   
>>   	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>> +
>> +	if ((ret == -EOPNOTSUPP) && (mode & FALLOC_FL_ZERO_RANGE)) {
>> +		mode &= ~FALLOC_FL_ZERO_RANGE;
>> +		mode |= FALLOC_FL_PUNCH_HOLE;
>> +		ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
>> +	}
>> +
>>   	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
>>   		ret = -EIO;
>>    out:
>> -- 
>> 2.19.1
>>
> .
>

