Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF99C48BCD
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 11:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECEA61108
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 11:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbhFILvE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 07:51:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3185 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239639AbhFILum (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 07:50:42 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G0Q676PQNz6J9VY;
        Wed,  9 Jun 2021 19:35:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 13:48:46 +0200
Received: from [10.47.80.201] (10.47.80.201) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 9 Jun 2021
 12:48:45 +0100
Subject: Re: [PATCH] blk-mq: fix use-after-free in blk_mq_exit_sched
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        <linux-block@vger.kernel.org>,
        <syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com>
References: <20210609063046.122843-1-ming.lei@redhat.com>
 <f5fbc650-5bd3-32ee-1d31-8b1dd1d7fa19@huawei.com> <YMCU+iuHs4ULN0lb@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <81c38feb-9d3e-7adc-57e6-54bccf0d3142@huawei.com>
Date:   Wed, 9 Jun 2021 12:42:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YMCU+iuHs4ULN0lb@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.201]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/06/2021 11:16, Ming Lei wrote:
> On Wed, Jun 09, 2021 at 09:59:43AM +0100, John Garry wrote:
>> On 09/06/2021 07:30, Ming Lei wrote:
>>
>> Thanks for the fix
>>
>>> tagset can't be used after blk_cleanup_queue() is returned because
>>> freeing tagset usually follows blk_clenup_queue(). Commit d97e594c5166
>>> ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap") adds
>>> check on q->tag_set->flags in blk_mq_exit_sched(), and causes
>>> use-after-free.
>>>
>>> Fixes it by using hctx->flags.
>>>
>>
>> The tagset is a member of the Scsi_Host structure. So it is true that this
>> memory may be freed before the request_queue is exited?
> 
> Yeah, please see commit c3e2219216c9 ("block: free sched's request pool in
> blk_cleanup_queue")

JFYI, I could recreate with the following simple steps:

root@(none)$ mount /dev/sda1 mnt
[   27.252887] FAT-fs (sda1): Volume was not properly unmounted. Some 
data may be corrupt. Please run fsck.
_hw/unbind)$ echo HISI0162:01 > ./sys/bus/platform/drivers/hisi_sas_v2
[   31.262274] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.270314] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.278262] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.286245] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.294164] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.302143] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.310097] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   31.321599] hisi_sas_v2_hw HISI0162:01: dev[9:1] is gone
[   31.429245] hisi_sas_v2_hw HISI0162:01: dev[8:1] is gone
[   31.533461] hisi_sas_v2_hw HISI0162:01: dev[7:1] is gone
[   31.637338] hisi_sas_v2_hw HISI0162:01: dev[6:1] is gone
[   31.740840] hisi_sas_v2_hw HISI0162:01: dev[5:1] is gone
[   31.750659] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[   31.833500] hisi_sas_v2_hw HISI0162:01: dev[4:1] is gone
[   31.937351] hisi_sas_v2_hw HISI0162:01: dev[3:1] is gone
[   31.947749] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[   31.953195] sd 0:0:1:0: [sdb] Stopping disk

[   32.690815] hisi_sas_v2_hw HISI0162:01: dev[2:5] is gone
[   32.771526] hisi_sas_v2_hw HISI0162:01: dev[1:1] is gone
[   32.790406] hisi_sas_v2_hw HISI0162:01: dev[0:2] is gone

root@(none)$
root@(none)$
root@(none)$ umount mnt
[   37.323039] 
==================================================================
[   37.330262] BUG: KASAN: use-after-free in blk_mq_exit_sched+0x110/0x1c8
[   37.336880] Read of size 4 at addr ffff001051e80100 by task umount/547
[   37.343401]
[   37.344884] CPU: 4 PID: 547 Comm: umount Not tainted 
5.13.0-rc5-next-20210608 #80
[   37.352362] Hardware name: Huawei Taishan 2280 /D05, BIOS Hisilicon 
D05 IT21 Nemo 2.0 RC0 04/18/2018
[   37.361486] Call trace:
[   37.363924]  dump_backtrace+0x0/0x2d0
[   37.367586]  show_stack+0x18/0x28
[   37.370898]  dump_stack_lvl+0xfc/0x138
[   37.374643]  print_address_description.constprop.13+0x78/0x314
[   37.380472]  kasan_report+0x1e0/0x248
[   37.384131]  __asan_load4+0x9c/0xd8
[   37.387615]  blk_mq_exit_sched+0x110/0x1c8
[   37.391706]  __elevator_exit+0x34/0x58
[   37.395451]  blk_release_queue+0x108/0x1d8
[   37.399545]  kobject_put+0xa8/0x180
[   37.403029]  blk_put_queue+0x14/0x20
[   37.406601]  disk_release+0xcc/0x100
[   37.410171]  device_release+0x94/0x110
[   37.413918]  kobject_put+0xa8/0x180
[   37.417401]  put_device+0x14/0x28
[   37.420712]  put_disk+0x2c/0x40
[   37.423848]  blkdev_put_no_open+0x54/0x78
[   37.427853]  blkdev_put+0x108/0x258
[   37.431335]  kill_block_super+0x5c/0x78
[   37.435166]  deactivate_locked_super+0x6c/0xd0
[   37.439605]  deactivate_super+0x8c/0xa8
[   37.443435]  cleanup_mnt+0x110/0x1c0
[   37.447007]  __cleanup_mnt+0x14/0x20
[   37.450578]  task_work_run+0xbc/0x1a8
[   37.454236]  do_notify_resume+0x2cc/0x590
[   37.458242]  work_pending+0xc/0x3c8
[   37.461725]
[   37.463207] The buggy address belongs to the page:
[   37.467990] page:(____ptrval____) refcount:0 mapcount:-128 
mapping:0000000000000000 index:0x0 pfn:0x1051e80
[   37.477724] flags: 0xbfffc0000000000(node=0|zone=2|lastcpupid=0xffff)
[   37.484164] raw: 0bfffc0000000000 fffffc00415a9008 ffff0017fbffebb0 
0000000000000000
[   37.491900] raw: 0000000000000000 0000000000000006 00000000ffffff7f 
0000000000000000
[   37.499635] page dumped because: kasan: bad access detected
[   37.505198]
[   37.506680] Memory state around the buggy address:
[   37.511463]  ffff001051e80000: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   37.518677]  ffff001051e80080: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   37.525891] >ffff001051e80100: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   37.533104]^
[   37.536324]  ffff001051e80180: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   37.543538]  ffff001051e80200: ff ff ff ff ff ff ff ff ff ff ff ff ff 
ff ff ff
[   37.550751] 
==================================================================
[   37.557963] Disabling lock debugging due to kernel taint
root@(none)$
root@(none)$

And this patch fixes it:
Tested-by: John Garry <john.garry@huawei.com>

> 
>>
>>> Reported-by: syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com
>>> Fixes: d97e594c5166 ("blk-mq: Use request queue-wide tags for tagset-wide sbitmap")
>>> Cc: John Garry <john.garry@huawei.com>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-mq-sched.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
>>> index a9182d2f8ad3..80273245d11a 100644
>>> --- a/block/blk-mq-sched.c
>>> +++ b/block/blk-mq-sched.c
>>> @@ -680,6 +680,7 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>>>    {
>>>    	struct blk_mq_hw_ctx *hctx;
>>>    	unsigned int i;
>>> +	unsigned int flags = 0;
>>>    	queue_for_each_hw_ctx(q, hctx, i) {
>>>    		blk_mq_debugfs_unregister_sched_hctx(hctx);
>>> @@ -687,12 +688,13 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>>>    			e->type->ops.exit_hctx(hctx, i);
>>>    			hctx->sched_data = NULL;
>>>    		}
>>> +		flags = hctx->flags;
>>
>> I know the choice is limited, but it is unfortunate that we must set flags
>> in a loop
> 
> Does it matter?

It's just a nit on the coding style: it's not an especially good 
practice to set the same value in a loop.

But, as I said, choice is limited.

> 
>>
>>>    	}
>>>    	blk_mq_debugfs_unregister_sched(q);
>>>    	if (e->type->ops.exit_sched)
>>>    		e->type->ops.exit_sched(e);
>>>    	blk_mq_sched_tags_teardown(q);
>>> -	if (blk_mq_is_sbitmap_shared(q->tag_set->flags))
>>> +	if (blk_mq_is_sbitmap_shared(flags))
>>>    		blk_mq_exit_sched_shared_sbitmap(q);
>>
>> this is
>>
>> blk_mq_exit_sched_shared_sbitmap(struct request_queue *queue)
>> {
>> 	sbitmap_queue_free(&queue->sched_bitmap_tags);
>> 	..
>> }
>>
>> And isn't it safe to call sbitmap_queue_free() when
>> sbitmap_queue_init_node() has not been called?
>>
>> I'm just wondering if we can always call blk_mq_exit_sched_shared_sbitmap()?
>> I know it's not an ideal choice either.
> 
> So far it may work, not sure if it can in future, I suggest to follow
> the traditional alloc & free pattern.
> 
> 

Fine

Thanks,
John
