Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E02C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28FD223C8
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 01:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAVBoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 20:44:39 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:60329 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726424AbhAVBo1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 20:44:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMTXQh2_1611279807;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UMTXQh2_1611279807)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jan 2021 09:43:27 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <405493e0-7917-2ee9-7242-5f02c044a0fb@redhat.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ce313c74-645f-3a55-44ac-4e757497c778@linux.alibaba.com>
Date:   Fri, 22 Jan 2021 09:43:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <405493e0-7917-2ee9-7242-5f02c044a0fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

Any comments on this patch?

Thanks,
Joseph

On 1/19/21 12:14 PM, Jason Wang wrote:
> 
> On 2021/1/18 上午11:58, Joseph Qi wrote:
>> module parameter 'virtblk_queue_depth' was firstly introduced for
>> testing/benchmarking purposes described in commit fc4324b4597c
>> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
>> Since we have different virtio-blk devices which have different
>> capabilities, it requires that we support per-device queue depth instead
>> of per-module. So defaultly use vq free elements if module parameter
>> 'virtblk_queue_depth' is not set.
>>
>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> 
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
>> @@ -755,17 +756,18 @@ static int virtblk_probe(struct virtio_device *vdev)
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
