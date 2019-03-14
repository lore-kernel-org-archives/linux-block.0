Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBF9C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 06:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C42184C
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aAlO0Ptb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfCNGIo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:08:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48114 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfCNGIo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 02:08:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2E64Mdo106464;
        Thu, 14 Mar 2019 06:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fjmTfz4kS+DpD6s1TryczWSKtR6eZS3+jdnilrNj65k=;
 b=aAlO0PtbuU/0dkv9wHYLCOy+4RC5wT4RRZCAD8t8aeJ7DAtQgttWqjyzfYPbnWj3DL9o
 hlmwgKnT7ZP9iihRhyTeKYMJfi4jPeQRJuX7o+HTqeiNWTqDm+K7Ia7dLDhaXo5MpcUI
 0jBo9fix38uJRtXnTbU7HFsEX2i4L6Q3tTWR6de7/VA/UU95wTh49zqKhxVoQDRJW9Tg
 MF847VPcx3LFHY9NOEwTu4YVds5C6TCgXExQrELCsbOF94Ub6NRCoB9KWRHE+vd3EuAb
 c+aEK/b2ufu4DtKlXnEuO34z5SbOTU8GaKROlAkAKJyN8mSYQ9urRGLvgMQRd7WhZX0y bA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r44wuewuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 06:08:37 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2E68VGT031768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 06:08:32 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2E68V5x005678;
        Thu, 14 Mar 2019 06:08:31 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 06:08:30 +0000
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
Date:   Thu, 14 Mar 2019 14:12:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190313103900.1ea7f996.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140040
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/13/19 5:39 PM, Cornelia Huck wrote:
> On Wed, 13 Mar 2019 11:26:04 +0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> On 3/13/19 1:33 AM, Cornelia Huck wrote:
>>> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>   
>>>> I observed that there is one msix vector for config and one shared vector
>>>> for all queues in below qemu cmdline, when the num-queues for virtio-blk
>>>> is more than the number of possible cpus:
>>>>
>>>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
>>>>
>>>> # cat /proc/interrupts 
>>>>            CPU0       CPU1       CPU2       CPU3
>>>> ... ...
>>>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>>>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
>>>> ... ...
>>>>
>>>>
>>>> However, when num-queues is the same as number of possible cpus:
>>>>
>>>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
>>>>
>>>> # cat /proc/interrupts 
>>>>            CPU0       CPU1       CPU2       CPU3
>>>> ... ... 
>>>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>>>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>>>>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>>>>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>>>>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
>>>> ... ...
>>>>
>>>> In above case, there is one msix vector per queue.  
>>>
>>> Please note that this is pci-specific...
>>>   
>>>>
>>>>
>>>> This is because the max number of queues is not limited by the number of
>>>> possible cpus.
>>>>
>>>> By default, nvme (regardless about write_queues and poll_queues) and
>>>> xen-blkfront limit the number of queues with num_possible_cpus().  
>>>
>>> ...and these are probably pci-specific as well.  
>>
>> Not pci-specific, but per-cpu as well.
> 
> Ah, I meant that those are pci devices.
> 
>>
>>>   
>>>>
>>>>
>>>> Is this by design on purpose, or can we fix with below?
>>>>
>>>>
>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>> index 4bc083b..df95ce3 100644
>>>> --- a/drivers/block/virtio_blk.c
>>>> +++ b/drivers/block/virtio_blk.c
>>>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>>>  	if (err)
>>>>  		num_vqs = 1;
>>>>  
>>>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>>>> +
>>>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>>>  	if (!vblk->vqs)
>>>>  		return -ENOMEM;  
>>>
>>> virtio-blk, however, is not pci-specific.
>>>
>>> If we are using the ccw transport on s390, a completely different
>>> interrupt mechanism is in use ('floating' interrupts, which are not
>>> per-cpu). A check like that should therefore not go into the generic
>>> driver.
>>>   
>>
>> So far there seems two options.
>>
>> The 1st option is to ask the qemu user to always specify "-num-queues" with the
>> same number of vcpus when running x86 guest with pci for virtio-blk or
>> virtio-scsi, in order to assign a vector for each queue.
> 
> That does seem like an extra burden for the user: IIUC, things work
> even if you have too many queues, it's just not optimal. It sounds like
> something that can be done by a management layer (e.g. libvirt), though.
> 
>> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
>> so that different platforms (e.g., pci or ccw) would use different ways to limit
>> the max number of queues in guest, with something like below?
> 
> That sounds better, as both transports and drivers can opt-in here.
> 
> However, maybe it would be even better to try to come up with a better
> strategy of allocating msix vectors in virtio-pci. More vectors in the
> num_queues > num_cpus case, even if they still need to be shared?
> Individual vectors for n-1 cpus and then a shared one for the remaining
> queues?
> 
> It might even be device-specific: Have some low-traffic status queues
> share a vector, and provide an individual vector for high-traffic
> queues. Would need some device<->transport interface, obviously.
> 

This sounds a little bit similar to multiple hctx maps?

So far, as virtio-blk only supports set->nr_maps = 1, no matter how many hw
queues are assigned for virtio-blk, blk_mq_alloc_tag_set() would use at most
nr_cpu_ids hw queues.

2981 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
... ...
3021         /*
3022          * There is no use for more h/w queues than cpus if we just have
3023          * a single map
3024          */
3025         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
3026                 set->nr_hw_queues = nr_cpu_ids;

Even the block layer would limit the number of hw queues by nr_cpu_ids when
(set->nr_maps == 1).

That's why I think virtio-blk should use the similar solution as nvme
(regardless about write_queues and poll_queues) and xen-blkfront.

Added Jason again. I do not know why the mailing list of
virtualization@lists.linux-foundation.org always filters out Jason's email...


Dongli Zhang
