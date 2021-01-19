Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCF5C433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 04:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809A920DD4
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 04:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbhASEJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 23:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730116AbhASEIN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 23:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611029204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XxjUqcN38hjRWlI1UqqG9yx1inb5rkEhsdJ3OcF1xYs=;
        b=eGeY2KN2eBbq0SSlaqOv8AWppqYCmKBf4UUW/eOnVnurWPOjsjin3FmpUuF9LpWxHg93x5
        eVbxMU2ul8EqnXT5uo+mCQyl1jDwAdeHg/Sg0zccJosk9qDr0hLErNNYiwpTkJyGo1G1pH
        siplLxY8LB8OfVgSclZYIwqrUB3+Urw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-peZjWp4XPnOEOApiswON6g-1; Mon, 18 Jan 2021 23:06:42 -0500
X-MC-Unique: peZjWp4XPnOEOApiswON6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B6515723;
        Tue, 19 Jan 2021 04:06:41 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4197B62688;
        Tue, 19 Jan 2021 04:06:35 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <46f2f81f-9906-e1f7-d8fd-6da2c61683ba@redhat.com>
Date:   Tue, 19 Jan 2021 12:06:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/1/19 上午9:33, JeffleXu wrote:
>
> On 1/18/21 1:25 PM, Jason Wang wrote:
>> On 2021/1/18 上午11:58, Joseph Qi wrote:
>>> module parameter 'virtblk_queue_depth' was firstly introduced for
>>> testing/benchmarking purposes described in commit fc4324b4597c
>>> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
>>> Since we have different virtio-blk devices which have different
>>> capabilities, it requires that we support per-device queue depth instead
>>> of per-module. So defaultly use vq free elements if module parameter
>>> 'virtblk_queue_depth' is not set.
>>
>> I wonder if it's better to use sysfs instead (or whether it has already
>> had something like this in the blocker layer).
>>
> "/sys/block/<dev>/queue/nr_requests" indeed works, but isn't better to
> set queue_depth according to the hardware capability at the very first?
> AFAIK, nvme just set per-device queue_depth at initializing phase.


I agree, the problem is that the current code may modify module parameter.

Thanks


>
> Thanks,
> Jeffle
>
>>
>>> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 12 +++++++-----
>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 145606d..f83a417 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -705,6 +705,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>>        u32 v, blk_size, max_size, sg_elems, opt_io_size;
>>>        u16 min_io_size;
>>>        u8 physical_block_exp, alignment_offset;
>>> +    unsigned int queue_depth;
>>>          if (!vdev->config->get) {
>>>            dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> @@ -755,17 +756,18 @@ static int virtblk_probe(struct virtio_device
>>> *vdev)
>>>            goto out_free_vq;
>>>        }
>>>    -    /* Default queue sizing is to fill the ring. */
>>> -    if (!virtblk_queue_depth) {
>>> -        virtblk_queue_depth = vblk->vqs[0].vq->num_free;
>>> +    if (likely(!virtblk_queue_depth)) {
>>> +        queue_depth = vblk->vqs[0].vq->num_free;
>>>            /* ... but without indirect descs, we use 2 descs per req */
>>>            if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC))
>>> -            virtblk_queue_depth /= 2;
>>> +            queue_depth /= 2;
>>> +    } else {
>>> +        queue_depth = virtblk_queue_depth;
>>>        }
>>>          memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
>>>        vblk->tag_set.ops = &virtio_mq_ops;
>>> -    vblk->tag_set.queue_depth = virtblk_queue_depth;
>>> +    vblk->tag_set.queue_depth = queue_depth;
>>>        vblk->tag_set.numa_node = NUMA_NO_NODE;
>>>        vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>>>        vblk->tag_set.cmd_size =

