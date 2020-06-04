Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55C0C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 05:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3D32072E
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 05:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XyeRRAR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgFDFXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:23:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52728 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFDFXR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 01:23:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0545I3Fd050466;
        Thu, 4 Jun 2020 05:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EgtTIFYAT2+RJeuyGJI0V2nN4xg0hHuzUAeVn9HZgR0=;
 b=XyeRRAR3jy5dvX7G4IpP5oMiZtlIpjNksa4+6pfXqqiPSCU/9F8VL8tvba9OnI4CymH0
 EyKzyYDc2/0EGSCDrLD/EQ8ZOabx3og3uaKlj8hXEv2Y9bvQvW5pff4gxJ3uEEDVOn7i
 k17Uoj3HO82SxQxNt3QwLUbKtHMVhUkbcidcvAD01t+R2+/PFjGgpXQmS3iY2ThSW1MK
 RxY3R0KLichFdJoELUfWRpfX0tBa4+ob8zoE6G1ciJvo+m2w+F+GXGKt31tQYvGaEStY
 YFtxfUUX1gKOReZih0Q2w8pgBrkws1CYS51SuZZ/+BSqOkrqCwOCDaQJniH+UuSCr2+J dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31bewr4mt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 05:22:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0545I7U9069049;
        Thu, 4 Jun 2020 05:22:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31dju4dsdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 05:22:53 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0545Mob5001913;
        Thu, 4 Jun 2020 05:22:51 GMT
Received: from [10.159.230.80] (/10.159.230.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 22:22:49 -0700
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
Date:   Wed, 3 Jun 2020 22:22:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006040035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040035
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/3/20 9:16 AM, John Garry wrote:
> On 03/06/2020 14:36, Ming Lei wrote:
>> On Wed, Jun 03, 2020 at 01:53:47PM +0200, Christoph Hellwig wrote:
>>> On Wed, Jun 03, 2020 at 06:51:27PM +0800, Ming Lei wrote:
>>>> Commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
>>>> prevents new request from being allocated on hctx which is going to be
>>>> inactive,
>>>> meantime drains all in-queue requests.
>>>>
>>>> We needn't to prevent driver tag from being allocated during cpu hotplug, more
>>>> importantly we have to provide driver tag for requests, so that the cpu hotplug
>>>> handling can move on. blk_mq_get_tag() is shared for allocating both internal
>>>> tag and drive tag, so driver tag allocation may fail because the hctx is
>>>> marked as inactive.
>>>>
>>>> Fix the issue by moving BLK_MQ_S_INACTIVE check to __blk_mq_alloc_request().
>>>
>>> This looks correct, but a little ugly.  How about we resurrect my
>>> patch to split off blk_mq_get_driver_tag entirely?  Quick untested rebase
>>
>> OK, I am fine.
>>
>>> below, still needs a better changelog and fixes tg:
>>>
>>> ---
>>>  From e432011e2eb5ac7bd1046bbf936645e9f7b74e64 Mon Sep 17 00:00:00 2001
>>> From: Christoph Hellwig <hch@lst.de>
>>> Date: Sat, 16 May 2020 08:03:48 +0200
>>> Subject: blk-mq: split out a __blk_mq_get_driver_tag helper
>>>
>>> Allocation of the driver tag in the case of using a scheduler shares very
>>> little code with the "normal" tag allocation.  Split out a new helper to
>>> streamline this path, and untangle it from the complex normal tag
>>> allocation.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   block/blk-mq-tag.c | 27 +++++++++++++++++++++++++++
>>>   block/blk-mq-tag.h |  8 ++++++++
>>>   block/blk-mq.c     | 29 -----------------------------
>>>   block/blk-mq.h     |  1 -
>>>   4 files changed, 35 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 96a39d0724a29..cded7fdcad8ef 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -191,6 +191,33 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>>>       return tag + tag_offset;
>>>   }
>>>   +bool __blk_mq_get_driver_tag(struct request *rq)
>>> +{
>>> +    struct sbitmap_queue *bt = &rq->mq_hctx->tags->bitmap_tags;
>>> +    unsigned int tag_offset = rq->mq_hctx->tags->nr_reserved_tags;
>>> +    bool shared = blk_mq_tag_busy(rq->mq_hctx);
>>
>> Not necessary to add 'shared' which is just used once.
>>
>>> +    int tag;
>>> +
>>> +    if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
>>> +        bt = &rq->mq_hctx->tags->breserved_tags;
>>
>> Too many rq->mq_hctx->tags, you can add one local variable to store it.
>>
>> Otherwise, looks fine:
>>
>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 
> So I did see this for mq-deadline scheduler:
> 
> ] Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000040
> [  518.688402] Mem abort info:
> [  518.691183]ESR = 0x96000004
> [  518.694233]EC = 0x25: DABT (current EL), IL = 32 bits
> [  518.699568]SET = 0, FnV = 0
> [  518.702667] irq_shutdown irq143
> [  518.705937] CPU43: shutdown
> [  518.706093]EA = 0, S1PTW = 0
> [  518.708733] psci: CPU43 killed (polled 0 ms)
> [  518.716141] Data abort info:
> [  518.719050]ISV = 0, ISS = 0x00000004
> [  518.722892]CM = 0, WnR = 0
> [  518.725867] user pgtable: 4k pages, 48-bit VAs, pgdp=0000041fa4eae000
> [  518.732318] [0000000000000040] pgd=0000000000000000
> [  518.737208] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [  518.742768] Modules linked in:
> [  518.745812] CPU: 0 PID: 1309 Comm: kworker/43:1H Not tainted
> 5.7.0-rc2-00125-gf498b5de8a1c #390
> [  518.754496] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon D05 IT21
> Nemo 2.0 RC0 04/18/2018
> [  518.763624] Workqueue: kblockd blk_mq_run_work_fn
> [  518.768315] pstate: 80000005 (Nzcv daif -PAN -UAO)
> [  518.773094] pc : blk_mq_put_tag+0x2c/0x68
> [  518.777091] lr : blk_mq_get_tag+0x2ec/0x338
> [  518.781260] sp : ffff800021a53ab0
> [  518.784562] x29: ffff800021a53ab0 x28: ffff041f9e81d248
> [  518.789861] x27: 00000000000002aa x26: ffff041fa3e49300
> [  518.795159] x25: ffff001fb0178fc0 x24: ffff800021a53c68
> [  518.800458] x23: 0000000000000000 x22: 0000000000000000
> [  518.805756] x21: ffff800011a69000 x20: ffff041fa3e49310
> [  518.811055] x19: ffff800021a53b90 x18: 0000000000000004
> [  518.816354] x17: 0000000000000000 x16: 0000000000000000
> [  518.821652] x15: 0000000000000000 x14: 00000000000000ef
> [  518.826951] x13: 00000000000000ef x12: 0000000000000001
> [  518.832249] x11: 0000000000000000 x10: 00000000000009c0
> [  518.837548] x9 : ffff800021a53d50 x8 : ffff041f9e39a620
> [  518.842847] x7 : fefefefefefefeff x6 : 0000000000000000
> [  518.848146] x5 : 400007ffffffffff x4 : 0000000000001000
> [  518.853445] x3 : 00000000000002aa x2 : 0000000000000000
> [  518.858743] x1 : 0000000000000000 x0 : ffff041fa3e49300
> [  518.864042] Call trace:
> [  518.866477]  blk_mq_put_tag+0x2c/0x68
> [  518.870126]  blk_mq_get_tag+0x2ec/0x338
> [  518.873948]  blk_mq_get_driver_tag+0xf8/0x168
> [  518.878292]  blk_mq_dispatch_rq_list+0x118/0x670
> [  518.882896]  blk_mq_do_dispatch_sched+0xb0/0x148
> [  518.887500]  __blk_mq_sched_dispatch_requests+0xec/0x1d8
> [  518.892799]  blk_mq_sched_dispatch_requests+0x3c/0x78
> [  518.897837]  __blk_mq_run_hw_queue+0xb4/0x130
> [  518.902181]  blk_mq_run_work_fn+0x20/0x30
> [  518.906179]  process_one_work+0x1e8/0x360
> [  518.910176]  worker_thread+0x44/0x488
> [  518.913825]  kthread+0x150/0x158
> [  518.917041]  ret_from_fork+0x10/0x1c
> [  518.920606] Code: b9400004 4b020063 6b04007f 540001e2 (b9404022)
> 
> With Christoph's patch and "blk-mq: get ctx in order to handle BLK_MQ_S_INACTIVE
> in blk_mq_get_tag()" [I didn't test without that patch], no issue detected so far.
> 

I think my patch is no longer required with Christoph's patch.

Dongli Zhang

Dongli Zhang
