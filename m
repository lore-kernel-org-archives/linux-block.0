Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B236AC433ED
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 13:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A4610CD
	for <linux-block@archiver.kernel.org>; Tue, 18 May 2021 13:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244096AbhERNXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 May 2021 09:23:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239145AbhERNXq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 09:23:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9ECFCABF6;
        Tue, 18 May 2021 13:22:27 +0000 (UTC)
To:     John Garry <john.garry@huawei.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, chenxiang <chenxiang66@hisilicon.com>
References: <20210514022052.1047665-1-ming.lei@redhat.com>
 <b38d671a-530b-244a-bc0f-0b926c796243@huawei.com> <YKOiClSTyHl5lbXV@T590>
 <108caf1d-c31d-2303-57a8-8fe0f7bde22b@suse.de>
 <7f985b61-fd26-0f90-14ab-d4c857f7851c@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH] blk-mq: plug request for shared sbitmap
Message-ID: <3f61e939-d95a-1dd1-6870-e66795cfc1b1@suse.de>
Date:   Tue, 18 May 2021 15:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <7f985b61-fd26-0f90-14ab-d4c857f7851c@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/21 2:37 PM, John Garry wrote:
> On 18/05/2021 12:54, Hannes Reinecke wrote:
>>> In yanhui's virt workload(qemu, libaio, dio, high queue depth, single
>>> job), the patch can improve throughput much(>50%) when running
>>> sequential write(dio, libaio, 16 jobs) to XFS. And it is observed that
>>> IO merge is recovered to level of disabling host tags.
>>>
>> I've found a good testcase for this by using null_blk:
>>
>> modprobe null_blk submit_queues=32 queue_mode=2 irqmode=0 bs=4096
>> hw_queue_depth=2048 completion_nsec=1 nr_devices=4 shared_tags=1
>> shared_tag_bitmap=1
>>
>> and using a simple fio job with libaio and rw=read and numjobs=32 will
>> do the trick:
>>
>> [nullb]
>> rw=read
>> size=16g
>> ioengine=libaio
>> direct=1
>> buffered=0
>> group_reporting=1
>> bs=4096
>> numjobs=32
>>
>> (of course, the 'numjobs' and 'submit_queues' parameter would need to be
>> adjusted to your machine).
>> Omitting the 'shared_tag_bitmap' module parameter would yield around 12M
>> iops; adding it would see a rather dramatic drop to 172k iops.
>> With this patchset it's back to the expected iops value.
> 
> I will consider running this test myself, but do you mean that you get
> ~12M with shared_tag_bitmap=1 and this patch?
> 
> I would always expect shared_tag_bitmap=1 to give a drop for null_blk,
> as we move from per-submit queue driver tag to all submit queues sharing
> the same driver tagset.
> 
There is a slight drop (less than 1M iops), but that is about to be
expected; however, as there is a rather high fluctuation in the numbers
I didn't include it.

But nothing as dramatic as without this patchset :-)

> And I am not sure if you are fixing the IO sched from default.
> 
No, I don't; I'm using whatever it's there (ie mq-deadline).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
