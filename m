Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB50C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CF42184E
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 16:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOS29Ip1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfCNQId (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:08:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46914 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfCNQIc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 12:08:32 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EG3kog075939;
        Thu, 14 Mar 2019 16:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=8Nxz7iGKA6dQQPMDTaJWul8tOm3uLDYFEuvj4q0tcn0=;
 b=YOS29Ip1gZaYV4GwS/+7w8uWLYFVed5G6h0LtdHO65BUEm2l004+fzJDRwuapsVyxMGj
 WfNj6y+F7Qr94LmSiuOhrg/16IklmbVWRyHLQDRtW/2HEFC5kj6GydLefVuRiEQHkCm/
 hIotgHCcPofKrW05StYEM+zqhHsXnuoFo7ehv6xnp3Bj1W2RmiHKvx2bNek0RIvqMoJA
 SZW8pCqdWgaCkoIx54CQutxPvy4ZiXFq+pGPIE5ZAnCfzCjGe7kSRvvkyoZC9Mp//A4f
 qKG9hy8zabkdsXUQ9HVg2i/I7LhLXwtNeCnvOLZ6FKCVM+DCyDHhkthnlNRWAC4dRw6J Ng== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430f2g47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 16:08:26 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2EG8Pu0008679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 16:08:25 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2EG8OZ5014270;
        Thu, 14 Mar 2019 16:08:25 GMT
Received: from [10.191.13.189] (/10.191.13.189)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 16:08:24 +0000
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Cornelia Huck <cohuck@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <20190314131339.1b61fff6.cohuck@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <74cf10ad-34bb-333a-3119-6021697c8e33@oracle.com>
Date:   Fri, 15 Mar 2019 00:08:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314131339.1b61fff6.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140114
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/14/2019 08:13 PM, Cornelia Huck wrote:
> On Thu, 14 Mar 2019 14:12:32 +0800
> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> On 3/13/19 5:39 PM, Cornelia Huck wrote:
>>> On Wed, 13 Mar 2019 11:26:04 +0800
>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>>   
>>>> On 3/13/19 1:33 AM, Cornelia Huck wrote:  
>>>>> On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
>>>>> Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>>>>>> Is this by design on purpose, or can we fix with below?
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>>>>> index 4bc083b..df95ce3 100644
>>>>>> --- a/drivers/block/virtio_blk.c
>>>>>> +++ b/drivers/block/virtio_blk.c
>>>>>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>>>>>  	if (err)
>>>>>>  		num_vqs = 1;
>>>>>>  
>>>>>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>>>>>> +
>>>>>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>>>>>  	if (!vblk->vqs)
>>>>>>  		return -ENOMEM;    
>>>>>
>>>>> virtio-blk, however, is not pci-specific.
>>>>>
>>>>> If we are using the ccw transport on s390, a completely different
>>>>> interrupt mechanism is in use ('floating' interrupts, which are not
>>>>> per-cpu). A check like that should therefore not go into the generic
>>>>> driver.
>>>>>     
>>>>
>>>> So far there seems two options.
>>>>
>>>> The 1st option is to ask the qemu user to always specify "-num-queues" with the
>>>> same number of vcpus when running x86 guest with pci for virtio-blk or
>>>> virtio-scsi, in order to assign a vector for each queue.  
>>>
>>> That does seem like an extra burden for the user: IIUC, things work
>>> even if you have too many queues, it's just not optimal. It sounds like
>>> something that can be done by a management layer (e.g. libvirt), though.
>>>   
>>>> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
>>>> so that different platforms (e.g., pci or ccw) would use different ways to limit
>>>> the max number of queues in guest, with something like below?  
>>>
>>> That sounds better, as both transports and drivers can opt-in here.
>>>
>>> However, maybe it would be even better to try to come up with a better
>>> strategy of allocating msix vectors in virtio-pci. More vectors in the
>>> num_queues > num_cpus case, even if they still need to be shared?
>>> Individual vectors for n-1 cpus and then a shared one for the remaining
>>> queues?
>>>
>>> It might even be device-specific: Have some low-traffic status queues
>>> share a vector, and provide an individual vector for high-traffic
>>> queues. Would need some device<->transport interface, obviously.
>>>   
>>
>> This sounds a little bit similar to multiple hctx maps?
>>
>> So far, as virtio-blk only supports set->nr_maps = 1, no matter how many hw
>> queues are assigned for virtio-blk, blk_mq_alloc_tag_set() would use at most
>> nr_cpu_ids hw queues.
>>
>> 2981 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
>> ... ...
>> 3021         /*
>> 3022          * There is no use for more h/w queues than cpus if we just have
>> 3023          * a single map
>> 3024          */
>> 3025         if (set->nr_maps == 1 && set->nr_hw_queues > nr_cpu_ids)
>> 3026                 set->nr_hw_queues = nr_cpu_ids;
>>
>> Even the block layer would limit the number of hw queues by nr_cpu_ids when
>> (set->nr_maps == 1).
> 
> Correct me if I'm wrong, but there seem to be two kinds of limitations
> involved here:
> - Allocation of msix vectors by the virtio-pci transport. We end up
>   with shared vectors if we have more virtqueues than vcpus. Other
>   transports may or may not have similar issues, but essentially, this
>   is something that applies to all kind of virtio devices attached via
>   the virtio-pci transport.

It depends.

For virtio-net, we need to specify the number of available vectors on qemu side,
e.g.,:

-device virtio-net-pci,netdev=tapnet,mq=true,vectors=16

This parameter is specific for virtio-net.

Suppose if 'queues=8' while 'vectors=16', as 2*8+1 > 16, there will be lack of
vectors and guest would not be able to assign one vector for each queue.

I was tortured by this long time ago and it seems qemu would minimize the memory
allocation and the default 'vectors' is 3.

BTW, why cannot we have a more consistent configuration for most qemu devices,
e.g., so far:

virtio-blk use 'num-queues'
nvme use 'num_queues'
virtio-net use 'queues' for tap :)

> - The block layer limits the number of hw queues to the number of
>   vcpus. This applies only to virtio devices that interact with the
>   block layer, but regardless of the virtio transport.

Yes: virtio-blk and virtio-scsi.

> 
>> That's why I think virtio-blk should use the similar solution as nvme
>> (regardless about write_queues and poll_queues) and xen-blkfront.
> 
> Ok, the hw queues limit from above would be an argument to limit to
> #vcpus in the virtio-blk driver, regardless of the transport used. (No
> idea if there are better ways to deal with this, I'm not familiar with
> the interface.)
> 
> For virtio devices that don't interact with the block layer and are
> attached via the virtio-pci transport, it might still make sense to
> revisit vector allocation.
> 

As mentioned above, we need to specify 'vectors' for virtio-net as the default
value is only 3 (config + tx + rx). That would make a little difference?

Dongli Zhang
