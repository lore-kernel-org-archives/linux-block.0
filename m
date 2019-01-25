Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730E7C282C3
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39502218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 00:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfAYAp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 19:45:58 -0500
Received: from gfuc.org ([88.99.83.187]:47872 "EHLO gfuc.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfAYAp6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 19:45:58 -0500
Received: from [192.168.178.72] (dslb-092-075-200-083.092.075.pools.vodafone-ip.de [92.75.200.83])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by gfuc.org (Postfix) with ESMTPSA id 4017E1E00A5;
        Fri, 25 Jan 2019 00:45:55 +0000 (UTC)
Subject: Re: fsync hangs after scsi rejected a request
To:     Ming Lei <tom.leiming@gmail.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <70df6d90-31eb-96f4-908d-462ea58dea6e@florianstecker.de>
 <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
From:   Florian Stecker <m19@florianstecker.de>
Message-ID: <a30b5868-dd7d-d3db-b7f4-c723ac279ead@florianstecker.de>
Date:   Fri, 25 Jan 2019 01:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVOSHtV7jcMwEvDKZzPnsLRzkdvAEqb+ggugkM27LJvagg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/22/19 4:22 AM, Ming Lei wrote:
> On Tue, Jan 22, 2019 at 5:13 AM Florian Stecker <m19@florianstecker.de> wrote:
>>
>> Hi everyone,
>>
>> on my laptop, I am experiencing occasional hangs of applications during
>> fsync(), which are sometimes up to 30 seconds long. I'm using a BTRFS
>> which spans two partitions on the same SSD (one of them used to contain
>> a Windows, but I removed it and added the partition to the BTRFS volume
>> instead). Also, the problem only occurs when an I/O scheduler
>> (mq-deadline) is in use. I'm running kernel version 4.20.3.
>>
>>   From what I understand so far, what happens is that a sync request
>> fails in the SCSI/ATA layer, in ata_std_qc_defer(), because it is a
>> "Non-NCQ command" and can not be queued together with other commands.
>> This propagates up into blk_mq_dispatch_rq_list(), where the call
>>
>> ret = q->mq_ops->queue_rq(hctx, &bd);
>>
>> returns BLK_STS_DEV_RESOURCE. Later in blk_mq_dispatch_rq_list(), there
>> is the piece of code
>>
>> needs_restart = blk_mq_sched_needs_restart(hctx);
>> if (!needs_restart ||
>>          (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
>>          blk_mq_run_hw_queue(hctx, true);
>> else if (needs_restart && (ret == BLK_STS_RESOURCE))
>>          blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
>>
>> which restarts the queue after a delay if BLK_STS_RESOURCE was returned,
>> but somehow not for BLK_STS_DEV_RESOURCE. Instead, nothing happens and
>> fsync() seems to hang until some other process wants to do I/O.
>>
>> So if I do
>>
>> - else if (needs_restart && (ret == BLK_STS_RESOURCE))
>> + else if (needs_restart && (ret == BLK_STS_RESOURCE || ret ==
>> BLK_STS_DEV_RESOURCE))
>>
>> it fixes my problem. But was there a reason why BLK_STS_DEV_RESOURCE was
>> treated differently that BLK_STS_RESOURCE here?
> 
> Please see the comment:
> 
> /*
>   * BLK_STS_DEV_RESOURCE is returned from the driver to the block layer if
>   * device related resources are unavailable, but the driver can guarantee
>   * that the queue will be rerun in the future once resources become
>   * available again. This is typically the case for device specific
>   * resources that are consumed for IO. If the driver fails allocating these
>   * resources, we know that inflight (or pending) IO will free these
>   * resource upon completion.
>   *
>   * This is different from BLK_STS_RESOURCE in that it explicitly references
>   * a device specific resource. For resources of wider scope, allocation
>   * failure can happen without having pending IO. This means that we can't
>   * rely on request completions freeing these resources, as IO may not be in
>   * flight. Examples of that are kernel memory allocations, DMA mappings, or
>   * any other system wide resources.
>   */
> #define BLK_STS_DEV_RESOURCE    ((__force blk_status_t)13)
> 
>>
>> In any case, it seems wrong to me that ret is used here at all, as it
>> just contains the return value of the last request in the list, and
>> whether we rerun the queue should probably not only depend on the last
>> request?
>>
>> Can anyone of the experts tell me whether this makes sense or I got
>> something completely wrong?
> 
> Sounds a bug in SCSI or ata driver.
> 
> I remember there is hole in SCSI wrt. returning BLK_STS_DEV_RESOURCE,
> but I never get lucky to reproduce it.
> 
> scsi_queue_rq():
>          ......
>          case BLK_STS_RESOURCE:
>                  if (atomic_read(&sdev->device_busy) ||
>                      scsi_device_blocked(sdev))
>                          ret = BLK_STS_DEV_RESOURCE;
> 

OK, please tell me if I understand this right now. What is supposed to 
happen is

- request 1 is being processed by the device
- request 2 (sync) fails with STS_DEV_RESOURCE because request 1 is 
still being processed
- request 2 is put into hctx->dispatch inside blk_mq_dispatch_rq_list *
- queue does not get rerun because of STS_DEV_RESOURCE
- request 1 finishes
- scsi_end_request calls blk_mq_run_hw_queues
- blk_mq_run_hw_queue finds request 2 in hctx->dispatch **
- runs request 2

However, what happens for me is that request 1 finishes earlier, so that 
** is executed before *, and finds an empty hctx->dispatch list.

At least this is consistent with what I see.

 > All in-flight request may complete between reading 'sdev->device_busy'
 > and setting ret as 'BLK_STS_DEV_RESOURCE', then this IO hang may
 > be triggered.
 >

More accurate would be: between reading sdev->device_busy and doing 
list_splice_init(list,&hctx->dispatch) inside blk_mq_dispatch_rq_list.

I'm not sure how the SCSI driver can do anything about this except 
returning BLK_STS_RESOURCE instead (which I guess would not be a great 
solution), as basically everything else happens inside blk-mq. Or what 
do you have in mind?
