Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD0DC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4224217F5
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQq4I0rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfCNPgq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:36:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45762 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfCNPgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 11:36:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2EFTFJQ006723;
        Thu, 14 Mar 2019 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UeGG6/KpWg91Pxckic2qsKLJ050YIWHkVv6xWgHCKEs=;
 b=LQq4I0rwM3XlyNiMnK+eRq95eW/gDN6/PHYhao/FmaYWapT03+gTlWNBmPSTCE5uL5Nm
 0EBkzGXoRr9PXI9KDsiR9YkOufmpkkt3olQtm7s5PRe6iZmAkvOI+eVy0f5sDAduxCPh
 pn3fNc3XASqSPDkVlFr3kixykKVOUPuX3SkzDvnMP9VfMxrpem4NUreTbEORt3BxpTNe
 K8xRy1dk5qNCZaXvfu6cIFkeNlHLJ0aoLBd9V22jxsY918O9DTSulMgU3IoOh4DdRMVa
 iAJskydvUfwAHcrsT16QGJ3VBFxdJRmbaHW7Of3c20KDmy9MasZ1iYDZIWieGaIxZUEZ Ng== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2r44wuhtsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 15:36:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2EFae3f011313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 15:36:40 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2EFadlh026121;
        Thu, 14 Mar 2019 15:36:40 GMT
Received: from [10.191.11.116] (/10.191.11.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Mar 2019 15:36:39 +0000
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190314082926-mutt-send-email-mst@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, jasowang@redhat.com,
        linux-kernel@vger.kernel.org
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <7a1e3b7a-1df5-2f4a-3f41-a6342102b882@oracle.com>
Date:   Thu, 14 Mar 2019 23:36:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190314082926-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140110
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/14/2019 08:32 PM, Michael S. Tsirkin wrote:
> On Tue, Mar 12, 2019 at 10:22:46AM -0700, Dongli Zhang wrote:
>> I observed that there is one msix vector for config and one shared vector
>> for all queues in below qemu cmdline, when the num-queues for virtio-blk
>> is more than the number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
> 
> So why do this?

I observed this when I was testing virtio-blk and block layer.

I just assign a very large 'num-queues' to virtio-blk and keep changing the
number of vcpu in order to study blk-mq.

The num-queues for nvme (qemu) is by default 64, while it is 1 for virtio-blk.

> 
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ...
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
>> ... ...
>>
>>
>> However, when num-queues is the same as number of possible cpus:
>>
>> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
>>
>> # cat /proc/interrupts 
>>            CPU0       CPU1       CPU2       CPU3
>> ... ... 
>>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
>>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
>>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
>>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
>>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
>> ... ...
>>
>> In above case, there is one msix vector per queue.
>>
>>
>> This is because the max number of queues is not limited by the number of
>> possible cpus.
>>
>> By default, nvme (regardless about write_queues and poll_queues) and
>> xen-blkfront limit the number of queues with num_possible_cpus().
>>
>>
>> Is this by design on purpose, or can we fix with below?
>>
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 4bc083b..df95ce3 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
>>  	if (err)
>>  		num_vqs = 1;
>>  
>> +	num_vqs = min(num_possible_cpus(), num_vqs);
>> +
>>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
>>  	if (!vblk->vqs)
>>  		return -ENOMEM;
>> --
>>
>>
>> PS: The same issue is applicable to virtio-scsi as well.
>>
>> Thank you very much!
>>
>> Dongli Zhang
> 
> I don't think this will address the issue if there's vcpu hotplug though.
> Because it's not about num_possible_cpus it's about the # of active VCPUs,
> right? Does block hangle CPU hotplug generally?
> We could maybe address that by switching vq to msi vector mapping in
> a cpu hotplug notifier...
> 

It looks it is about num_possible_cpus/nr_cpu_ids for cpu hotplug.


For instance, below is when only 2 out of 6 cpus are initialized while
virtio-blk has 6 queues.

"-smp 2,maxcpus=6" and "-device
virtio-blk-pci,drive=drive0,id=disk0,num-queues=6,iothread=io1"

# cat /sys/devices/system/cpu/present
0-1
# cat /sys/devices/system/cpu/possible
0-5
# cat /proc/interrupts  | grep virtio
 24:          0          0   PCI-MSI 65536-edge      virtio0-config
 25:       1864          0   PCI-MSI 65537-edge      virtio0-req.0
 26:          0       1069   PCI-MSI 65538-edge      virtio0-req.1
 27:          0          0   PCI-MSI 65539-edge      virtio0-req.2
 28:          0          0   PCI-MSI 65540-edge      virtio0-req.3
 29:          0          0   PCI-MSI 65541-edge      virtio0-req.4
 30:          0          0   PCI-MSI 65542-edge      virtio0-req.5

6 + 1 irqs are assigned even 4 out of 6 cpus are still offline.


Below is about the nvme emulated by qemu. While 2 out of 6 cpus are initial
assigned, nvme has 64 queues by default.

"-smp 2,maxcpus=6" and "-device nvme,drive=drive1,serial=deadbeaf1"

# cat /sys/devices/system/cpu/present
0-1
# cat /sys/devices/system/cpu/possible
0-5
# cat /proc/interrupts | grep nvme
 31:          0         16   PCI-MSI 81920-edge      nvme0q0
 32:         35          0   PCI-MSI 81921-edge      nvme0q1
 33:          0         42   PCI-MSI 81922-edge      nvme0q2
 34:          0          0   PCI-MSI 81923-edge      nvme0q3
 35:          0          0   PCI-MSI 81924-edge      nvme0q4
 36:          0          0   PCI-MSI 81925-edge      nvme0q5
 37:          0          0   PCI-MSI 81926-edge      nvme0q6

6 io queues are assigned with irq, although only 2 cpus are online.


When only 2 out of 48 cpus are online, there are 48 hctx created by block layer.

"-smp 2,maxcpus=48" and "-device
virtio-blk-pci,drive=drive0,id=disk0,num-queues=48,iothread=io1"

# ls /sys/kernel/debug/block/vda/ | grep hctx | wc -l
48


The above indicates the number of hw queues/irq is related to
num_possible_cpus/nr_cpu_ids.

Dongli Zhang
