Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC98C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 04:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1D6218A1
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 04:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfCOEuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 00:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfCOEuS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 00:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E600E307CEB1;
        Fri, 15 Mar 2019 04:50:17 +0000 (UTC)
Received: from [10.72.12.187] (ovpn-12-187.pek2.redhat.com [10.72.12.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16B3C5C231;
        Fri, 15 Mar 2019 04:50:12 +0000 (UTC)
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
Date:   Fri, 15 Mar 2019 12:50:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 04:50:18 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/3/14 下午2:12, Dongli Zhang wrote:
>
> On 3/13/19 5:39 PM, Cornelia Huck wrote:
>> On Wed, 13 Mar 2019 11:26:04 +0800
>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>
>>> On 3/13/19 1:33 AM, Cornelia Huck wrote:
>>>> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
>>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>>    
>>>>> I observed that there is one msix vector for config and one shared vector
>>>>> for all queues in below qemu cmdline, when the num-queues for virtio-blk
>>>>> is more than the number of possible cpus:
>>>>>
>>>>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
>>>>>
>>>>> # cat /proc/interrupts
>>>>>             CPU0       CPU1       CPU2       CPU3
>>>>> ... ...
>>>>>   24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>>>>   25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
>>>>> ... ...
>>>>>
>>>>>
>>>>> However, when num-queues is the same as number of possible cpus:
>>>>>
>>>>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
>>>>>
>>>>> # cat /proc/interrupts
>>>>>             CPU0       CPU1       CPU2       CPU3
>>>>> ... ...
>>>>>   24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>>>>   25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>>>>>   26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>>>>>   27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>>>>>   28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
>>>>> ... ...
>>>>>
>>>>> In above case, there is one msix vector per queue.
>>>> Please note that this is pci-specific...
>>>>    
>>>>>
>>>>> This is because the max number of queues is not limited by the number of
>>>>> possible cpus.
>>>>>
>>>>> By default, nvme (regardless about write_queues and poll_queues) and
>>>>> xen-blkfront limit the number of queues with num_possible_cpus().
>>>> ...and these are probably pci-specific as well.
>>> Not pci-specific, but per-cpu as well.
>> Ah, I meant that those are pci devices.
>>
>>>>    
>>>>>
>>>>> Is this by design on purpose, or can we fix with below?
>>>>>
>>>>>
>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>> index 4bc083b..df95ce3 100644
>>>>> --- a/drivers/block/virtio_blk.c
>>>>> +++ b/drivers/block/virtio_blk.c
>>>>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>>>>   	if (err)
>>>>>   		num_vqs = 1;
>>>>>   
>>>>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>>>>> +
>>>>>   	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>>>>   	if (!vblk->vqs)
>>>>>   		return -ENOMEM;
>>>> virtio-blk, however, is not pci-specific.
>>>>
>>>> If we are using the ccw transport on s390, a completely different
>>>> interrupt mechanism is in use ('floating' interrupts, which are not
>>>> per-cpu). A check like that should therefore not go into the generic
>>>> driver.
>>>>    
>>> So far there seems two options.
>>>
>>> The 1st option is to ask the qemu user to always specify "-num-queues" with the
>>> same number of vcpus when running x86 guest with pci for virtio-blk or
>>> virtio-scsi, in order to assign a vector for each queue.
>> That does seem like an extra burden for the user: IIUC, things work
>> even if you have too many queues, it's just not optimal. It sounds like
>> something that can be done by a management layer (e.g. libvirt), though.
>>
>>> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
>>> so that different platforms (e.g., pci or ccw) would use different ways to limit
>>> the max number of queues in guest, with something like below?
>> That sounds better, as both transports and drivers can opt-in here.
>>
>> However, maybe it would be even better to try to come up with a better
>> strategy of allocating msix vectors in virtio-pci. More vectors in the
>> num_queues > num_cpus case, even if they still need to be shared?
>> Individual vectors for n-1 cpus and then a shared one for the remaining
>> queues?
>>
>> It might even be device-specific: Have some low-traffic status queues
>> share a vector, and provide an individual vector for high-traffic
>> queues. Would need some device<->transport interface, obviously.
>>
> This sounds a little bit similar to multiple hctx maps?
>
> So far, as virtio-blk only supports set->nr_maps = 1, no matter how many hw
> queues are assigned for virtio-blk, blk_mq_alloc_tag_set() would use at most
> nr_cpu_ids hw queues.
>
> 2981 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
> ... ...
> 3021         /*
> 3022          * There is no use for more h/w queues than cpus if we just have
> 3023          * a single map
> 3024          */
> 3025         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
> 3026                 set->nr_hw_queues = nr_cpu_ids;
>
> Even the block layer would limit the number of hw queues by nr_cpu_ids when
> (set->nr_maps == 1).
>
> That's why I think virtio-blk should use the similar solution as nvme
> (regardless about write_queues and poll_queues) and xen-blkfront.
>
> Added Jason again. I do not know why the mailing list of
> virtualization@lists.linux-foundation.org always filters out Jason's email...
>
>
> Dongli Zhang


Or something like I proposed several years ago? 
https://do-db2.lkml.org/lkml/2014/12/25/169

Btw, for virtio-net, I think we actually want to go for having a maximum 
number of supported queues like what hardware did. This would be useful 
for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current 
vector allocation doesn't support this which will results all virtqueues 
to share a single vector. We may indeed need more flexible policy here.

Thanks


