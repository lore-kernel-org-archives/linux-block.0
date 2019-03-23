Return-Path: <SRS0=7zlQ=R2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76642C43381
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D8721902
	for <linux-block@archiver.kernel.org>; Sat, 23 Mar 2019 11:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aIYfQ5JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCWLO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:14:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40646 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCWLO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Mar 2019 07:14:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2NB9d0j034464;
        Sat, 23 Mar 2019 11:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=q6Vljd9Y9wIfU42BUTFJBOiApHALT3R85W511PZscA0=;
 b=aIYfQ5JT0OHkQCRSn8/D/DE39YOi2ZU+aLgZAaYEYXNsJhMAVnirUzU+p8U9nAQVHlBY
 5RkJY4dAnsxxzpYVkzW1IFC4E7OPwR4J9gB1LoXFzExM1NPgmSpFVdUN0Pp7/suRzOpf
 aYPDlWHy7o7xmJitYPCn5/yBpIwYvB/7HODIbAEsj6TzW8Hh/K6r08EuDTOtgiT/CCU0
 S4UpOmRQU0PK7UgxaiWHFpb97JEagpNR0V6CrlVct9xraHSvnnLtkXZiP1eHxscgbZxq
 YI9K7v12KCfiO+8OicbWfw1GTATB7/k1bbf2aOpogpopDtQLWCzwUG1A6bYGfk6uxm+6 mg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2rdaae0u8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Mar 2019 11:14:44 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2NBEhSe012439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Mar 2019 11:14:44 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2NBEfmo006587;
        Sat, 23 Mar 2019 11:14:41 GMT
Received: from [10.191.2.156] (/10.191.2.156)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 23 Mar 2019 04:14:40 -0700
Subject: Re: [PATCH] block/mq: blk map queues by core id
To:     luferry <luferry@163.com>
References: <20190322100949.5555-1-luferry@163.com>
 <9fa3eda2-536c-86a1-a7a3-c157fd0cdfdc@oracle.com>
 <4cddfb88.8534.169a941f24a.Coremail.luferry@163.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9b568440-cd06-d74c-5708-333b847e49c1@oracle.com>
Date:   Sat, 23 Mar 2019 19:14:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4cddfb88.8534.169a941f24a.Coremail.luferry@163.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9203 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903230087
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/23/2019 02:34 PM, luferry wrote:
> 
> I just bought one vm , so i cannot access to hypervisor. I will try to build the environment on my desktop.
> I'm sure about something.
> The hypervisor is KVM and disk driver is virtio-blk.
> [root@blk-mq ~]# dmesg |grep KVM
> [    0.000000] Hypervisor detected: KVM
> [    0.186330] Booting paravirtualized kernel on KVM
> [    0.279106] KVM setup async PF for cpu 0
> [    0.420819] KVM setup async PF for cpu 1
> [    0.421682] KVM setup async PF for cpu 2
> [    0.422113] KVM setup async PF for cpu 3
> [    0.422434] KVM setup async PF for cpu 4
> [    0.422434] KVM setup async PF for cpu 5
> [    0.423312] KVM setup async PF for cpu 6
> [    0.423394] KVM setup async PF for cpu 7
> [    0.424125] KVM setup async PF for cpu 8
> [    0.424414] KVM setup async PF for cpu 9
> [    0.424415] KVM setup async PF for cpu 10
> [    0.425329] KVM setup async PF for cpu 11
> [    0.425420] KVM setup async PF for cpu 12
> [    0.426156] KVM setup async PF for cpu 13
> [    0.426431] KVM setup async PF for cpu 14
> [    0.426431] KVM setup async PF for cpu 15
> [root@blk-mq ~]# lspci |grep block
> 00:05.0 SCSI storage controller: Red Hat, Inc. Virtio block device
> 00:06.0 SCSI storage controller: Red Hat, Inc. Virtio block device
> 
> [root@blk-mq ~]# lscpu
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                16
> On-line CPU(s) list:   0-15
> Thread(s) per core:    2
> Core(s) per socket:    8
> 
> [root@blk-mq ~]# ls /sys/block/vdb/mq/
> 0  1  2  3
> 
> [root@blk-mq ~]# cat /proc/cpuinfo |egrep 'processor|core id'
> processor	: 0
> core id		: 0
> processor	: 1
> core id		: 0
> processor	: 2
> core id		: 1
> processor	: 3
> core id		: 1
> processor	: 4
> core id		: 2
> processor	: 5
> core id		: 2
> processor	: 6
> core id		: 3
> processor	: 7
> core id		: 3
> processor	: 8
> core id		: 4
> processor	: 9
> core id		: 4
> processor	: 10
> core id		: 5
> processor	: 11
> core id		: 5
> processor	: 12
> core id		: 6
> processor	: 13
> core id		: 6
> processor	: 14
> core id		: 7
> processor	: 15
> core id		: 7
> 
> --before this patch--
> [root@blk-mq ~]# cat /sys/block/vdb/mq/*/cpu_list
> 0, 4, 5, 8, 9, 12, 13
> 1
> 2, 6, 7, 10, 11, 14, 15
> 3
> 
> --after this patch--
> [root@blk-mq ~]# cat /sys/block/vdb/mq/*/cpu_list
> 0, 4, 5, 12, 13
> 1, 6, 7, 14, 15
> 2, 8, 9
> 3, 10, 11
> 
> 
> I add dump_stack insert blk_mq_map_queues.
> 
> [    1.378680] Call Trace:
> [    1.378690]  dump_stack+0x5a/0x73
> [    1.378695]  blk_mq_map_queues+0x29/0xb0
> [    1.378700]  blk_mq_alloc_tag_set+0x1bd/0x2d0
> [    1.378705]  virtblk_probe+0x1ae/0x8e4 [virtio_blk]
> [    1.378709]  virtio_dev_probe+0x18a/0x230 [virtio]
> [    1.378713]  really_probe+0x215/0x3f0
> [    1.378716]  driver_probe_device+0x115/0x130
> [    1.378718]  device_driver_attach+0x50/0x60
> [    1.378720]  __driver_attach+0xbd/0x140
> [    1.378722]  ? device_driver_attach+0x60/0x60
> [    1.378724]  bus_for_each_dev+0x67/0xc0
> [    1.378727]  ? klist_add_tail+0x57/0x70

I am not able to reproduce above call stack when virtio-blk is assigned 4 queues
while my qemu cmdline is "-smp 16,sockets=1,cores=8,threads=2".

# cat /sys/block/vda/mq/0/cpu_list
0, 1, 2, 3
# cat /sys/block/vda/mq/1/cpu_list
4, 5, 6, 7
# cat /sys/block/vda/mq/2/cpu_list
8, 9, 10, 11
# cat /sys/block/vda/mq/3/cpu_list
12, 13, 14, 15


I do agree in above case we would have issue if the mapping is established by
blk_mq_map_queues().


However, I am just curious how we finally reach at blk_mq_map_queues() from
blk_mq_alloc_tag_set()?

It should be something like:

blk_mq_alloc_tag_set()
 -> blk_mq_update_queue_map()
      -> if (set->ops->map_queues && !is_kdump_kernel())
             return set->ops->map_queues(set);
      -> else
             return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);

Wouldn't we always have set->ops->map_queues = virtblk_map_queues()?

Or the execution reach at:

virtblk_map_queues()
 -> blk_mq_virtio_map_queues()
     -> if (!vdev->config->get_vq_affinity)
            return blk_mq_map_queues(qmap);
     -> else
            establish the mapping via get_vq_affinity

but vdev->config->get_vq_affinity == NULL?

For virtio pci, get_vq_affinity is always set. Seems virtio mmio would not set
get_vq_affinity.


I used to play with firecracker (by amazon) and it is interesting firecracker
uses mmio to setup virtio-blk.


Sorry for disturbing the review of this patch. I just would like to clarify in
which scenario we would hit this issue, e.g., when virtio-blk is based on mmio?

Dongli Zhang

> 
> 
> At 2019-03-22 19:58:08, "Dongli Zhang" <dongli.zhang@oracle.com> wrote:
>>
>>
>> On 03/22/2019 06:09 PM, luferry wrote:
>>> under virtual machine environment, cpu topology may differ from normal
>>> physical server.
>>
>> Would mind share the name of virtual machine monitor, the command line if
>> available, and which device to reproduce.
>>
>> For instance, I am not able to reproduce with qemu nvme or virtio-blk as I
>> assume they use pci or virtio specific mapper to establish the mapping.
>>
>> E.g., with qemu and nvme: -smp 8,sockets=1,cores=4,threads=2
>>
>> Indeed I use three queues instead of twp as one is reserved for admin.
>>
>> # ls /sys/block/nvme0n1/mq/*
>> /sys/block/nvme0n1/mq/0:
>> cpu0  cpu1  cpu2  cpu3  cpu_list  nr_reserved_tags  nr_tags
>>
>> /sys/block/nvme0n1/mq/1:
>> cpu4  cpu5  cpu6  cpu7  cpu_list  nr_reserved_tags  nr_tags
>>
>>
>> Thank you very much!
>>
>> Dongli Zhang
>>
>>> for example (machine with 4 cores, 2 threads per core):
>>>
>>> normal physical server:
>>> core-id   thread-0-id  thread-1-id
>>> 0         0            4
>>> 1         1            5
>>> 2         2            6
>>> 3         3            7
>>>
>>> virtual machine:
>>> core-id   thread-0-id  thread-1-id
>>> 0         0            1
>>> 1         2            3
>>> 2         4            5
>>> 3         6            7
>>>
>>> When attach disk with two queues, all the even numbered cpus will be
>>> mapped to queue 0. Under virtual machine, all the cpus is followed by
>>> its sibling cpu.Before this patch, all the odd numbered cpus will also
>>> be mapped to queue 0, can cause serious imbalance.this will lead to
>>> performance impact on system IO
>>>
>>> So suggest to allocate cpu map by core id, this can be more currency
>>>
>>> Signed-off-by: luferry <luferry@163.com>
>>> ---
>>>  block/blk-mq-cpumap.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
>>> index 03a534820271..4125e8e77679 100644
>>> --- a/block/blk-mq-cpumap.c
>>> +++ b/block/blk-mq-cpumap.c
>>> @@ -35,7 +35,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>>>  {
>>>  	unsigned int *map = qmap->mq_map;
>>>  	unsigned int nr_queues = qmap->nr_queues;
>>> -	unsigned int cpu, first_sibling;
>>> +	unsigned int cpu, first_sibling, core = 0;
>>>  
>>>  	for_each_possible_cpu(cpu) {
>>>  		/*
>>> @@ -48,9 +48,10 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
>>>  			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
>>>  		} else {
>>>  			first_sibling = get_first_sibling(cpu);
>>> -			if (first_sibling == cpu)
>>> -				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
>>> -			else
>>> +			if (first_sibling == cpu) {
>>> +				map[cpu] = cpu_to_queue_index(qmap, nr_queues, core);
>>> +				core++;
>>> +			} else
>>>  				map[cpu] = map[first_sibling];
>>>  		}
>>>  	}
>>>
