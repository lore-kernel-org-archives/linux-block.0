Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B02C43334
	for <linux-block@archiver.kernel.org>; Sat, 23 Jul 2022 02:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiGWCuR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWCuR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 22:50:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD786301
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 19:50:12 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4LqW3F2qKBzKHdm
        for <linux-block@vger.kernel.org>; Sat, 23 Jul 2022 10:48:57 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgD3_9PbYdtiQyxXBA--.46608S3;
        Sat, 23 Jul 2022 10:50:04 +0800 (CST)
Subject: Re: [PATCH] blk-mq: run queue after issuing the last request of the
 plug list
To:     Ming Lei <ming.lei@redhat.com>, Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        yukuai3@huawei.com, "zhangyi (F)" <yi.zhang@huawei.com>
References: <20220718123528.178714-1-yuyufen@huawei.com>
 <YtZ4uSRqR/kLdqm+@T590>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0baa5b04-7194-54fa-08a5-51425601343e@huaweicloud.com>
Date:   Sat, 23 Jul 2022 10:50:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <YtZ4uSRqR/kLdqm+@T590>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgD3_9PbYdtiQyxXBA--.46608S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFykXFyDCw4fGw45Kr13XFb_yoW8ZF1kpF
        W0va1Yya1FqF4vgw4fZa13Gr1Sqr43urZxGry5KrW3Zrs0gaykAr1rGFWDZFWSyFZ5AF47
        Wr4DX393uwn3ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming!

ÔÚ 2022/07/19 17:26, Ming Lei Ð´µÀ:
> On Mon, Jul 18, 2022 at 08:35:28PM +0800, Yufen Yu wrote:
>> We do test on a virtio scsi device (/dev/sda) and the default mq
>> scheduler is 'none'. We found a IO hung as following:
>>
>> blk_finish_plug
>>    blk_mq_plug_issue_direct
>>        scsi_mq_get_budget
>>        //get budget_token fail and sdev->restarts=1
>>
>> 			     	 scsi_end_request
>> 				   scsi_run_queue_async
>>                                     //sdev->restart=0 and run queue
>>
>>       blk_mq_request_bypass_insert
>>          //add request to hctx->dispatch list
> 
> Here the issue shouldn't be related with scsi's get budget or
> scsi_run_queue_async.
> 
> If blk-mq adds request into ->dispatch_list, it is blk-mq core's
> responsibility to re-run queue for moving on. Can you investigate a
> bit more why blk-mq doesn't run queue after adding request to
> hctx dispatch list?

I think Yufen is probably thinking about the following Concurrent
scenario:

blk_mq_flush_plug_list
# assume there are three rq
  blk_mq_plug_issue_direct
   blk_mq_request_issue_directly
   # dispatch rq1, succeed
   blk_mq_request_issue_directly
   # dispatch rq2
    __blk_mq_try_issue_directly
     blk_mq_get_dispatch_budget
      scsi_mq_get_budget
       atomic_inc(&sdev->restarts);
       # rq2 failed to get budget
       # restarts is 1 now
                                         scsi_end_request
                                         # rq1 is completed
                                         ©®scsi_run_queue_async
                                         ©® 
atomic_cmpxchg(&sdev->restarts, old, 0) == old
                                         ©® # set restarts to 0
                                         ©® blk_mq_run_hw_queues
                                         ©® # hctx->dispatch list is empty
   blk_mq_request_bypass_insert
   # insert rq2 to hctx->dispatch list

  blk_mq_dispatch_plug_list
  # continue to dispatch rq3
   blk_mq_sched_insert_requests
    blk_mq_try_issue_list_directly
    # blk_mq_run_hw_queue() won't be called
    # because dispatching is succeed
                                         scsi_end_request
                                         ©®# rq3 is complete
                                         ©® scsi_run_queue_async
                                         ©® # restarts is 0, won't run queue

The root cause is that the failed dispatching is not the last rq,
and last rq is dispatched sucessfully.

Thanks,
Kuai
> 
> 
> 
> Thanks,
> Ming
> 
> .
> 

