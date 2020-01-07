Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE15C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 06:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1F2075A
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 06:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgAGGvQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:51:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbgAGGvQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jan 2020 01:51:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D1E82E8520BEA09CBB43;
        Tue,  7 Jan 2020 14:51:14 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.163) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 14:51:05 +0800
Subject: Re: [PATCH] blk-map: add kernel address validation in blk_rq_map_kern
 func
To:     Bob Liu <bob.liu@oracle.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <jens.axboe@oracle.com>, <namhyung@gmail.com>,
        <bharrosh@panasas.com>
CC:     Mingfangsen <mingfangsen@huawei.com>, <zhengbin13@huawei.com>,
        Guiyao <guiyao@huawei.com>, <ming.lei@redhat.com>
References: <239c8928-aea0-abe9-a75d-dc3f1b573ec5@huawei.com>
 <6b282b91-b157-5260-57d9-774be223998c@huawei.com>
 <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
From:   renxudong <renxudong1@huawei.com>
Message-ID: <bc469dc8-19b6-d979-c061-075e52a355b0@huawei.com>
Date:   Tue, 7 Jan 2020 14:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <91b13d6f-04b5-28b0-ea1b-d99564ecc898@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.163]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we issued scsi cmd, oops occurred. The call stack was as follows.
Call trace:
  __memcpy+0x110/0x180
  bio_endio+0x118/0x190
  blk_update_request+0x94/0x378
  scsi_end_request+0x48/0x2a8
  scsi_io_completion+0xa4/0x6d0
  scsi_finish_command+0xd4/0x138
  scsi_softirq_done+0x13c/0x198
  blk_done_softirq+0xc4/0x108
  __do_softirq+0x120/0x324
  run_ksoftirqd+0x44/0x60
  smpboot_thread_fn+0x1ac/0x1e8
  kthread+0x134/0x138
  ret_from_fork+0x10/0x18
  Since oops is in the process of scsi cmd done, we have not added oops 
info to the commit log.

On 2020/1/7 12:05, Bob Liu wrote:
> On 1/7/20 10:38 AM, Zhiqiang Liu wrote:
>> Friendly ping...
>>
>> On 2019/12/30 20:17, Zhiqiang Liu wrote:
>>> From: renxudong <renxudong1@huawei.com>
>>>
>>> Blk_rq_map_kern func is used to map kernel data to a request,
>>> in which kbuf par should be a valid kernel buffer. However,
>>> kbuf par is only checked whether it is null in blk_rq_map_kern func.
>>>
>>> If users pass a non kernel address to blk_rq_map_kern func in the
>>> non-aligned scenario, the invalid kbuf will be set to bio->bi_private.
>>> When the request is completed, bio_copy_kern_endio_read will be called
>>> to copy data to the kernel address in bio->bi_private. If the bi_private
>>> is not a valid kernel address, the system will oops. In this case, we
> 
> This patch looks fine to me, but curious did you trigger the real oops?
> If yes, it's better add the oops info into commit log.
> 
>>> cannot judge whether the bio structure is damaged or the kernel address is
>>> invalid.
>>>
>>> Here, we add kernel address validation by calling virt_addr_valid.
>>>
>>> Signed-off-by: renxudong <renxudong1@huawei.com>
>>> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> ---
>>>   block/blk-map.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-map.c b/block/blk-map.c
>>> index 3a62e471d81b..7deb1b44d1e3 100644
>>> --- a/block/blk-map.c
>>> +++ b/block/blk-map.c
>>> @@ -229,7 +229,7 @@ int blk_rq_map_kern(struct request_queue *q, struct request *rq, void *kbuf,
>>>
>>>   	if (len > (queue_max_hw_sectors(q) << 9))
>>>   		return -EINVAL;
>>> -	if (!len || !kbuf)
>>> +	if (!len || !virt_addr_valid(kbuf))
>>>   		return -EINVAL;
>>>
>>>   	do_copy = !blk_rq_aligned(q, addr, len) || object_is_on_stack(kbuf);
>>>
>>
> 
> 
> .
> 

