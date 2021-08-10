Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC7C432BE
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E36461051
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 06:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhHJHAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 03:00:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234999AbhHJHAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 03:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628578790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
        b=RJuf4H2pzUsOgmImHgPMM+DvRKRHM1u0NYbm7B+HE5YE9s5w1oP6yXv6wPyKJaUrnhjbFt
        RAPpS4mwxQnGwCq0hDBJvD2C4wMhL6JpbzkUqEp7sNwUxLveYFAk61IsaOTfEpXIipBDhg
        scMWAULw3jRp9xugzKb4uZddskjLFbU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-D1EfI7dXP-CrU1ZpmeNQFA-1; Tue, 10 Aug 2021 02:59:47 -0400
X-MC-Unique: D1EfI7dXP-CrU1ZpmeNQFA-1
Received: by mail-pj1-f69.google.com with SMTP id q72-20020a17090a1b4eb0290177884285a6so17954916pjq.2
        for <linux-block@vger.kernel.org>; Mon, 09 Aug 2021 23:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Cffq7OlH6V/Z8AE+xnVC0ZiIhRDeVUhtuJhpMuTZxX0=;
        b=DycXs/SmnwmlaoOabXXcgK6hNY7tDiy0Fz1JE1RHKogIiJ1/bju5i0zHYZESN2nSHQ
         EmRCE2wGrxphmZ09+FMSh0FsZe60ylofPWzIbPeWe4VltkABXDl+ycnjaAM4YTUBzj07
         foJmEq+6UdEy3d8kOrCCLuVab/7Y0v03Z04Tk1Rij8NO14hvmk1PrijqEVNI6NYLGtHz
         ITo2UKZjfygVk9YKJwX/Xb1h50wG62y+OBE921dBp3MgziWZ7W0p53K/IWZdN8ihJL3T
         /0MpXXbJRnU4U6BtXtHqmedBc5Ka0Mb5ITpeo/ToLQEaovWSbaYlJZbr17UDP8s2PyYl
         wnlQ==
X-Gm-Message-State: AOAM531/6v9I8iIgRaw3shArb3JPaGu15ZTMWus2vxZPPVqdpD26hXhX
        STxAVHCaJ4HlpWNQCW3GZ0LGa9aeFbhkbK2NUghO+W92F03bB/Xl0VrvGZODRUbAX3cQVUHORoO
        sOfoTnT89XZ0SlWQHtZPybSM=
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr29351077pjb.134.1628578786186;
        Mon, 09 Aug 2021 23:59:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyrbs/YDU3MNI8hVXqMW422VJSPmpjHIL4mjB5dm/5UNU1I3yH/ewcl/R9s/ijTMhy9D8SBg==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr29351059pjb.134.1628578785896;
        Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p3sm1722059pjt.0.2021.08.09.23.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 23:59:45 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
 <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <46c513b4-6644-d4b0-84f4-32df34b6d7b8@redhat.com>
Date:   Tue, 10 Aug 2021 14:59:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2021/8/10 下午12:59, Yongji Xie 写道:
> On Tue, Aug 10, 2021 at 11:05 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> 在 2021/8/9 下午6:16, Xie Yongji 写道:
>>> An untrusted device might presents an invalid block size
>>> in configuration space. This tries to add validation for it
>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
>>> feature bit if the value is out of the supported range.
>>>
>>> And we also double check the value in virtblk_probe() in
>>> case that it's changed after the validation.
>>>
>>> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>>> ---
>>>    drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
>>>    1 file changed, 33 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index 4b49df2dfd23..afb37aac09e8 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
>>>    static unsigned int virtblk_queue_depth;
>>>    module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>>>
>>> +static int virtblk_validate(struct virtio_device *vdev)
>>> +{
>>> +     u32 blk_size;
>>> +
>>> +     if (!vdev->config->get) {
>>> +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> +                     __func__);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
>>> +             return 0;
>>> +
>>> +     blk_size = virtio_cread32(vdev,
>>> +                     offsetof(struct virtio_blk_config, blk_size));
>>> +
>>> +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
>>> +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
>>
>> I wonder if it's better to just fail here as what we did for probe().
>>
> Looks like we don't need to do that since we already clear the
> VIRTIO_BLK_F_BLK_SIZE to tell the device that we don't use the block
> size in configuration space. Just like what we did in
> virtnet_validate().
>
> Thanks,
> Yongji


Ok, so

Acked-by: Jason Wang <jasowang@redhat.com>



>

