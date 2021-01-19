Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A74AC433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 01:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289C2230FA
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 01:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbhASBeZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 20:34:25 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:50885 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729202AbhASBeY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 20:34:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMC0JGl_1611020021;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UMC0JGl_1611020021)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Jan 2021 09:33:41 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     Jason Wang <jasowang@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
Date:   Tue, 19 Jan 2021 09:33:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/18/21 1:25 PM, Jason Wang wrote:
> 
> On 2021/1/18 上午11:58, Joseph Qi wrote:
>> module parameter 'virtblk_queue_depth' was firstly introduced for
>> testing/benchmarking purposes described in commit fc4324b4597c
>> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
>> Since we have different virtio-blk devices which have different
>> capabilities, it requires that we support per-device queue depth instead
>> of per-module. So defaultly use vq free elements if module parameter
>> 'virtblk_queue_depth' is not set.
> 
> 
> I wonder if it's better to use sysfs instead (or whether it has already
> had something like this in the blocker layer).
> 

"/sys/block/<dev>/queue/nr_requests" indeed works, but isn't better to
set queue_depth according to the hardware capability at the very first?
AFAIK, nvme just set per-device queue_depth at initializing phase.

Thanks,
Jeffle

> 
> 
>>
>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>> ---
>>   drivers/block/virtio_blk.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 145606d..f83a417 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -705,6 +705,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>       u32 v, blk_size, max_size, sg_elems, opt_io_size;
>>       u16 min_io_size;
>>       u8 physical_block_exp, alignment_offset;
>> +    unsigned int queue_depth;
>>         if (!vdev->config->get) {
>>           dev_err(&vdev->dev, "%s failure: config access disabled\n",
>> @@ -755,17 +756,18 @@ static int virtblk_probe(struct virtio_device
>> *vdev)
>>           goto out_free_vq;
>>       }
>>   -    /* Default queue sizing is to fill the ring. */
>> -    if (!virtblk_queue_depth) {
>> -        virtblk_queue_depth = vblk->vqs[0].vq->num_free;
>> +    if (likely(!virtblk_queue_depth)) {
>> +        queue_depth = vblk->vqs[0].vq->num_free;
>>           /* ... but without indirect descs, we use 2 descs per req */
>>           if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
>> -            virtblk_queue_depth /= 2;
>> +            queue_depth /= 2;
>> +    } else {
>> +        queue_depth = virtblk_queue_depth;
>>       }
>>         memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>>       vblk->tag_set.ops = &virtio_mq_ops;
>> -    vblk->tag_set.queue_depth = virtblk_queue_depth;
>> +    vblk->tag_set.queue_depth = queue_depth;
>>       vblk->tag_set.numa_node = NUMA_NO_NODE;
>>       vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>>       vblk->tag_set.cmd_size =

-- 
Thanks,
Jeffle
