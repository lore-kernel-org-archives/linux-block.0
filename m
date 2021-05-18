Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A136C433ED
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73788610A2
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 11:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbhERLz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 07:55:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243045AbhERLzz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 07:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3ABF6ACB1;
        Tue, 18 May 2021 11:54:34 +0000 (UTC)
To:     Ming Lei <ming.lei@redhat.com>, John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <108caf1d-c31d-2303-57a8-8fe0f7bde22b@suse.de>
Date:   Tue, 18 May 2021 13:54:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKOiClSTyHl5lbXV@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/21 1:16 PM, Ming Lei wrote:
> On Tue, May 18, 2021 at 10:44:43AM +0100, John Garry wrote:
>> On 14/05/2021 03:20, Ming Lei wrote:
>>> In case of shared sbitmap, request won't be held in plug list any more
>>> sine commit 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per
>>> tagset"), this way makes request merge from flush plug list & batching
>>> submission not possible, so cause performance regression.
>>>
>>> Yanhui reports performance regression when running sequential IO
>>> test(libaio, 16 jobs, 8 depth for each job) in VM, and the VM disk
>>> is emulated with image stored on xfs/megaraid_sas.
>>>
>>> Fix the issue by recovering original behavior to allow to hold request
>>> in plug list.
>>
>> Hi Ming,
>>
>> Since testing v5.13-rc2, I noticed that this patch made the hang I was
>> seeing disappear:
>> https://lore.kernel.org/linux-scsi/3d72d64d-314f-9d34-e039-7e508b2abe1b@huawei.com/
>>
>> I don't think that problem is solved, though.
> 
> This kind of hang or lockup is usually related with cpu utilization, and
> this patch may reduce cpu utilization in submission context.
> 
>>
>> So I wonder about throughput performance (I had hoped to test before it was
>> merged). I only have 6x SAS SSDs at hand, but I see some significant changes
>> (good and bad) for mq-deadline for hisi_sas:
>> Before 620K (read), 300K IOPs (randread)
>> After 430K (read), 460-490K IOPs (randread)
> 
> 'Before 620K' could be caused by busy queue when batching submission isn't
> applied, so merge chance is increased. This patch applies batching
> submission, so queue becomes not busy enough.
> 
> BTW, what is the queue depth of sdev and can_queue of shost for your hisilision SAS?
>  
>>
>> none IO sched is always about 450K (read) and 500K (randread)
>>
>> Do you guys have any figures? Are my results as expected?
> 
> In yanhui's virt workload(qemu, libaio, dio, high queue depth, single
> job), the patch can improve throughput much(>50%) when running
> sequential write(dio, libaio, 16 jobs) to XFS. And it is observed that
> IO merge is recovered to level of disabling host tags.
> 
I've found a good testcase for this by using null_blk:

modprobe null_blk submit_queues=32 queue_mode=2 irqmode=0 bs=4096
hw_queue_depth=2048 completion_nsec=1 nr_devices=4 shared_tags=1
shared_tag_bitmap=1

and using a simple fio job with libaio and rw=read and numjobs=32 will
do the trick:

[nullb]
rw=read
size=16g
ioengine=libaio
direct=1
buffered=0
group_reporting=1
bs=4096
numjobs=32

(of course, the 'numjobs' and 'submit_queues' parameter would need to be
adjusted to your machine).
Omitting the 'shared_tag_bitmap' module parameter would yield around 12M
iops; adding it would see a rather dramatic drop to 172k iops.
With this patchset it's back to the expected iops value.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
