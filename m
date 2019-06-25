Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E6CC4646B
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4164C206DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 02:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vjyYqkBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfFYCus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:50:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33800 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbfFYCus (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jun 2019 22:50:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P2hYfl173896;
        Tue, 25 Jun 2019 02:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XFwVO5gZ5iPnoC3Sie2eTRsT7P5Yy78QuLt59bFa7gg=;
 b=vjyYqkBSmwZZzASPkdig48f/ZQ6M2xSaGZ5JoZ2KnXyx+ZPzBBz5jpr+YfS4p8kOBgMK
 cRZUhtWzrXPbHSruaYB3vGzigEwZITmgaEgbBqmNa7sOzJDbcVDlo5qZKeAe3CL1tUcm
 5M4bHkPHUkGiFoanu+gHs/CjaLWqLOG4JpUPmZ4inceEdsFEstJIdDbAVtv9FBNSJbdG
 XRYOi/RAKl0S0E56k2XrWz/6dp2Ko8HCpldPTqJoZNebUc5JNy0xuVOU9qutqttRf7D2
 loE5bOWw7AyYgZxdlP1pxiS+pUxQ+tWhCw3AQHcOyZqpL4n4u2Ss51RRwW+D0fKttBai Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brt1g94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 02:48:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5P2mhmx068696;
        Tue, 25 Jun 2019 02:48:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6twvmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 02:48:43 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5P2mdxC004165;
        Tue, 25 Jun 2019 02:48:39 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 19:48:39 -0700
Subject: Re: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet
 mail)
To:     =?UTF-8?B?d2VuYmluemVuZyjmm77mlofmlowp?= <wenbinzeng@tencent.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Wenbin Zeng <wenbin.zeng@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "hare@suse.com" <hare@suse.com>, "osandov@fb.com" <osandov@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1561389847-30853-1-git-send-email-wenbinzeng@tencent.com>
 <20190625015512.GC23777@ming.t460p>
 <fe4f40e7bbf74311a47c9f3b981f8c53@tencent.com>
 <20190625022706.GE23777@ming.t460p>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9bae2938-dcb6-de91-b16f-36ce8af8b7fb@oracle.com>
Date:   Tue, 25 Jun 2019 10:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190625022706.GE23777@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906250021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906250020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/25/19 10:27 AM, Ming Lei wrote:
> On Tue, Jun 25, 2019 at 02:14:46AM +0000, wenbinzeng(曾文斌) wrote:
>> Hi Ming,
>>
>>> -----Original Message-----
>>> From: Ming Lei <ming.lei@redhat.com>
>>> Sent: Tuesday, June 25, 2019 9:55 AM
>>> To: Wenbin Zeng <wenbin.zeng@gmail.com>
>>> Cc: axboe@kernel.dk; keith.busch@intel.com; hare@suse.com; osandov@fb.com;
>>> sagi@grimberg.me; bvanassche@acm.org; linux-block@vger.kernel.org;
>>> linux-kernel@vger.kernel.org; wenbinzeng(曾文斌) <wenbinzeng@tencent.com>
>>> Subject: Re: [PATCH] blk-mq: update hctx->cpumask at cpu-hotplug(Internet mail)
>>>
>>> On Mon, Jun 24, 2019 at 11:24:07PM +0800, Wenbin Zeng wrote:
>>>> Currently hctx->cpumask is not updated when hot-plugging new cpus,
>>>> as there are many chances kblockd_mod_delayed_work_on() getting
>>>> called with WORK_CPU_UNBOUND, workqueue blk_mq_run_work_fn may run
>>>
>>> There are only two cases in which WORK_CPU_UNBOUND is applied:
>>>
>>> 1) single hw queue
>>>
>>> 2) multiple hw queue, and all CPUs in this hctx become offline
>>>
>>> For 1), all CPUs can be found in hctx->cpumask.
>>>
>>>> on the newly-plugged cpus, consequently __blk_mq_run_hw_queue()
>>>> reporting excessive "run queue from wrong CPU" messages because
>>>> cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) returns false.
>>>
>>> The message means CPU hotplug race is triggered.
>>>
>>> Yeah, there is big problem in blk_mq_hctx_notify_dead() which is called
>>> after one CPU is dead, but still run this hw queue to dispatch request,
>>> and all CPUs in this hctx might become offline.
>>>
>>> We have some discussion before on this issue:
>>>
>>> https://lore.kernel.org/linux-block/CACVXFVN729SgFQGUgmu1iN7P6Mv5+puE78STz8hj
>>> 9J5bS828Ng@mail.gmail.com/
>>>
>>
>> There is another scenario, you can reproduce it by hot-plugging cpus to kvm guests via qemu monitor (I believe virsh setvcpus --live can do the same thing), for example:
>> (qemu) cpu-add 1
>> (qemu) cpu-add 2
>> (qemu) cpu-add 3
>>
>> In such scenario, cpu 1, 2 and 3 are not visible at boot, hctx->cpumask doesn't get synced when these cpus are added.

Here is how I play with it with the most recent qemu and linux.

Boot VM with 1 out of 4 vcpu online.

# qemu-system-x86_64 -hda disk.img \
-smp 1,maxcpus=4 \
-m 4096M -enable-kvm \
-device nvme,drive=lightnvme,serial=deadbeaf1 \
-drive file=nvme.img,if=none,id=lightnvme \
-vnc :0 \
-kernel /.../mainline-linux/arch/x86_64/boot/bzImage \
-append "root=/dev/sda1 init=/sbin/init text" \
-monitor stdio -net nic -net user,hostfwd=tcp::5022-:22


As Ming mentioned, after boot:

# cat /proc/cpuinfo  | grep processor
processor	: 0

# cat /sys/block/nvme0n1/mq/0/cpu_list
0
# cat /sys/block/nvme0n1/mq/1/cpu_list
1
# cat /sys/block/nvme0n1/mq/2/cpu_list
2
# cat /sys/block/nvme0n1/mq/3/cpu_list
3

# cat /proc/interrupts | grep nvme
 24:         11   PCI-MSI 65536-edge      nvme0q0
 25:         78   PCI-MSI 65537-edge      nvme0q1
 26:          0   PCI-MSI 65538-edge      nvme0q2
 27:          0   PCI-MSI 65539-edge      nvme0q3
 28:          0   PCI-MSI 65540-edge      nvme0q4

I hotplug with "device_add
qemu64-x86_64-cpu,id=core1,socket-id=1,core-id=0,thread-id=0" in qemu monitor.

Dongli Zhang

> 
> It is CPU cold-plug, we suppose to support it.
> 
> The new added CPUs should be visible to hctx, since we spread queues
> among all possible CPUs(), please see blk_mq_map_queues() and
> irq_build_affinity_masks(), which is like static allocation on CPU
> resources.
> 
> Otherwise, you might use an old kernel or there is bug somewhere.
> 
>>
>>>>
>>>> This patch added a cpu-hotplug handler into blk-mq, updating
>>>> hctx->cpumask at cpu-hotplug.
>>>
>>> This way isn't correct, hctx->cpumask should be kept as sync with
>>> queue mapping.
>>
>> Please advise what should I do to deal with the above situation? Thanks a lot.
> 
> As I shared in last email, there is one approach discussed, which seems
> doable.
> 
> Thanks,
> Ming
> 
