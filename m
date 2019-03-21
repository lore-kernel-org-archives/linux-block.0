Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FAC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EE3218B0
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 02:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EdXR4KgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCUCKu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:10:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 22:10:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L2A2kh010810;
        Thu, 21 Mar 2019 02:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=otAhvbJ3K+0qHFPGUojCcM5doo+pAGqt+tj8FwwZyZU=;
 b=EdXR4KgLTZs0zTKApw47xnb3dHk554teC62oXT9gzCLGxliEyiotSuVq0AAp24gV6GAI
 ZWK86oQ/Vq7lN5QLQIz9Az9yRkmgahIyp1uMDa0UWHAXHq+UTKxVQoZxX2A5dURScg3Y
 gRWmhsxGo2wX10MfGkOp/zvygahYWk5EYugzM0a8B+VkQJdHO4beCiiP4ZwCu2h6oODa
 OCs3WDiLyxLs8vm6M9VrP/IygCZVaRETK2SFD5uX3uPcinuH3PI2RRhx6RloDlEqovMe
 2U7PizGS2e3l7Dfkvi36zy79DLjV7gsJT0D9sC2AFcbgpGpO2fNy+1knOuh22y758Ne4 uQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r8rjux31t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 02:10:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2L2Ahtx017595
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 02:10:44 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2L2Ah0c003894;
        Thu, 21 Mar 2019 02:10:43 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 19:10:43 -0700
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
 <20190315134112.7d63348c.cohuck@redhat.com>
 <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
 <0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
 <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <92cd9e4b-5a40-5c8c-14a6-0787c94c5dbf@oracle.com>
Date:   Thu, 21 Mar 2019 10:14:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/20/19 8:53 PM, Jason Wang wrote:
> 
> On 2019/3/19 上午10:22, Dongli Zhang wrote:
>> Hi Jason,
>>
>> On 3/18/19 3:47 PM, Jason Wang wrote:
>>> On 2019/3/15 下午8:41, Cornelia Huck wrote:
>>>> On Fri, 15 Mar 2019 12:50:11 +0800
>>>> Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>>> Or something like I proposed several years ago?
>>>>> https://do-db2.lkml.org/lkml/2014/12/25/169
>>>>>
>>>>> Btw, for virtio-net, I think we actually want to go for having a maximum
>>>>> number of supported queues like what hardware did. This would be useful
>>>>> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current
>>>>> vector allocation doesn't support this which will results all virtqueues
>>>>> to share a single vector. We may indeed need more flexible policy here.
>>>> I think it should be possible for the driver to give the transport
>>>> hints how to set up their queues/interrupt structures. (The driver
>>>> probably knows best about its requirements.) Perhaps whether a queue is
>>>> high or low frequency, or whether it should be low latency, or even
>>>> whether two queues could share a notification mechanism without
>>>> drawbacks. It's up to the transport to make use of that information, if
>>>> possible.
>>>
>>> Exactly and it was what the above series tried to do by providing hints of e.g
>>> which queues want to share a notification.
>>>
>> I read about your patch set on providing more flexibility of queue-to-vector
>> mapping.
>>
>> One use case of the patch set is we would be able to enable more queues when
>> there is limited number of vectors.
>>
>> Another use case we may classify queues as hight priority or low priority as
>> mentioned by Cornelia.
>>
>> For virtio-blk, we may extend virtio-blk based on this patch set to enable
>> something similar to write_queues/poll_queues in nvme, when (set->nr_maps != 1).
>>
>>
>> Yet, the question I am asking in this email thread is for a difference scenario.
>>
>> The issue is not we are not having enough vectors (although this is why only 1
>> vector is allocated for all virtio-blk queues). As so far virtio-blk has
>> (set->nr_maps == 1), block layer would limit the number of hw queues by
>> nr_cpu_ids, we indeed do not need more than nr_cpu_ids hw queues in virtio-blk.
>>
>> That's why I ask why not change the flow as below options when the number of
>> supported hw queues is more than nr_cpu_ids (and set->nr_maps == 1. virtio-blk
>> does not set nr_maps and block layer would set it to 1 when the driver does not
>> specify with a value):
>>
>> option 1:
>> As what nvme and xen-netfront do, limit the hw queue number by nr_cpu_ids.
> 
> 
> How do they limit the hw queue number? A command?

The max #queue is also limited by other factors, e.g., kernel param
configuration, xen dom0 configuration or nvme hardware support.

Here we would ignore those factors for simplicity and only talk about the
relation between #queue and #cpu.


About nvme pci:

Regardless about new write_queues and poll_queues, the default queue type number
is limited by num_possible_cpus() as line 2120 and 252.

2113 static int nvme_setup_io_queues(struct nvme_dev *dev)
2114 {
2115         struct nvme_queue *adminq = &dev->queues[0];
2116         struct pci_dev *pdev = to_pci_dev(dev->dev);
2117         int result, nr_io_queues;
2118         unsigned long size;
2119
2120         nr_io_queues = max_io_queues();
2121         result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);

 250 static unsigned int max_io_queues(void)
 251 {
 252         return num_possible_cpus() + write_queues + poll_queues;
 253 }

The cons of this is there might be many unused hw queues and vectors when
num_possible_cpus() is very very large while only a small number of cpu are
online. I am looking if there is way to improve this.



About xen-blkfront:

Indeed the max #queue is limited by num_online_cpus() when xen-blkfront module
is loaded as line 2733 and 2736.

2707 static int __init xlblk_init(void)
... ...
2710         int nr_cpus = num_online_cpus();
... ...
2733         if (xen_blkif_max_queues > nr_cpus) {
2734                 pr_info("Invalid max_queues (%d), will use default max: %d.\n",
2735                         xen_blkif_max_queues, nr_cpus);
2736                 xen_blkif_max_queues = nr_cpus;
2737         }

The cons of this is the number of hw-queue/hctx is limited and cannot increase
after cpu hotplug. I am looking if there is way to improve this.


While both have cons for cpu hotplug, they are trying to make #vector
proportional to the number of cpu.


For xen-blkfront and virtio-blk, as (set=nr_maps == 1), the number of hw queue
is limited by nr_cpu_ids again at block layer.


As virtio-blk is a PCI device, can we use the solution in nvme, that is, to use
num_possible_cpus to limited the max queues in virtio-blk?

Thank you very much!

Dongli Zhang

> 
> 
>>
>> option 2:
>> If the vectors is not enough, use the max number vector (indeed nr_cpu_ids) as
>> number of hw queues.
> 
> 
> We can share vectors in this case.
> 
> 
>>
>> option 3:
>> We should allow more vectors even the block layer would support at most
>> nr_cpu_ids queues.
>>
>>
>> I understand a new policy for queue-vector mapping is very helpful. I am just
>> asking the question from block layer's point of view.
>>
>> Thank you very much!
>>
>> Dongli Zhang
> 
> 
> Don't know much for block, cc Stefan for more idea.
> 
> Thanks
> 
