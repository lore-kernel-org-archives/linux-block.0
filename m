Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753816AbeC1Pog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Mar 2018 11:44:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2SFhho8182467
        for <linux-block@vger.kernel.org>; Wed, 28 Mar 2018 11:44:35 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2h0dxn01a1-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 28 Mar 2018 11:44:34 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 28 Mar 2018 16:44:32 +0100
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
 <20180328152617.GA6071@ming.t460p>
 <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
Date: Wed, 28 Mar 2018 17:44:29 +0200
MIME-Version: 1.0
In-Reply-To: <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <28c522b8-7891-3df3-9768-7f0d45c42307@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

FWIW, these logs were from a different system (with less disks and cpus).
the related log is

[    4.114191] dasd-eckd.2aa01a: 0.0.3f77: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
[    4.114852] dasd-eckd.2aa01a: 0.0.3f74: New DASD 3390/0C (CU 3990/01) with 30051 cylinders, 15 heads, 224 sectors
[    4.122361] dasd-eckd.412b53: 0.0.3f77: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
[    4.122811] dasd-eckd.412b53: 0.0.3f74: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
[    4.123568]  dasdc:VOL1/  0X3F77: dasdc1
[    4.124092]  dasdd:VOL1/  0X3F74: dasdd1
[    4.286220] WARNING: CPU: 1 PID: 1262 at block/blk-mq.c:1402 __blk_mq_delay_run_hw_queue+0xbe/0xd8
[    4.286225] Modules linked in: autofs4
[    4.286231] CPU: 1 PID: 1262 Comm: dasdconf.sh Not tainted 4.16.0-20180323.rc6.git0.792f5024dd01.300.fc27.s390x #1
[    4.286232] Hardware name: IBM 2964 NC9 704 (LPAR)
[    4.286236] Krnl PSW : 0000000053ccfc28 00000000c4b59c51 (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
[    4.286239]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[    4.286242] Krnl GPRS: 00000003da4eb000 0000000300000000 00000003dae67000 0000000000000001
[    4.286243]            0000000000000000 00000003da4eb710 0000000300000000 000000010dbafd98
[    4.286245]            000000010dbafd98 0000000000000001 0000000000000001 0000000000000000
[    4.286248]            00000003dae67000 0000000000aaa750 000000010dbafc00 000000010dbafbc8
[    4.286256] Krnl Code: 0000000000698e46: ebaff0a00004        lmg     %r10,%r15,160(%r15)
                          0000000000698e4c: c0f4ffff7aca        brcl    15,6883e0
                         #0000000000698e52: a7f40001            brc     15,698e54
                         >0000000000698e56: e340f0c00004        lg      %r4,192(%r15)
                          0000000000698e5c: ebaff0a00004        lmg     %r10,%r15,160(%r15)
                          0000000000698e62: 07f4                bcr     15,%r4
                          0000000000698e64: c0e5ffffff02        brasl   %r14,698c68
                          0000000000698e6a: a7f4fff6            brc     15,698e56
[    4.286301] Call Trace:
[    4.286304] ([<000000010dbafc08>] 0x10dbafc08)
[    4.286306]  [<0000000000698f5a>] blk_mq_run_hw_queue+0x82/0x180 
[    4.286308]  [<00000000006990c0>] blk_mq_run_hw_queues+0x68/0x88 
[    4.286310]  [<00000000006982de>] __blk_mq_complete_request+0x11e/0x1d8 
[    4.286313]  [<0000000000698424>] blk_mq_complete_request+0x8c/0xc8 
[    4.286319]  [<000000000082c5d0>] dasd_block_tasklet+0x158/0x490 
[    4.286325]  [<000000000014bc9a>] tasklet_hi_action+0x92/0x120 
[    4.286329]  [<00000000009feeb0>] __do_softirq+0x120/0x348 
[    4.286331]  [<000000000014b76a>] irq_exit+0xba/0xd0 
[    4.286335]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
[    4.286337]  [<00000000009fe180>] io_int_handler+0x130/0x298 
[    4.286338] Last Breaking-Event-Address:
[    4.286340]  [<0000000000698e52>] __blk_mq_delay_run_hw_queue+0xba/0xd8
[    4.286342] ---[ end trace 0d746eb6f9348354 ]---

On 03/28/2018 05:36 PM, Christian Borntraeger wrote:
> 
> 
> On 03/28/2018 05:26 PM, Ming Lei wrote:
>> Hi Christian,
>>
>> On Wed, Mar 28, 2018 at 09:45:10AM +0200, Christian Borntraeger wrote:
>>> FWIW, this patch does not fix the issue for me:
>>>
>>> ostname=? addr=? terminal=? res=success'
>>> [   21.454961] WARNING: CPU: 3 PID: 1882 at block/blk-mq.c:1410 __blk_mq_delay_run_hw_queue+0xbe/0xd8
>>> [   21.454968] Modules linked in: scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_multipath dm_mod autofs4
>>> [   21.454984] CPU: 3 PID: 1882 Comm: dasdconf.sh Not tainted 4.16.0-rc7+ #26
>>> [   21.454987] Hardware name: IBM 2964 NC9 704 (LPAR)
>>> [   21.454990] Krnl PSW : 00000000c0131ea3 000000003ea2f7bf (__blk_mq_delay_run_hw_queue+0xbe/0xd8)
>>> [   21.454996]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
>>> [   21.455005] Krnl GPRS: 0000013abb69a000 0000013a00000000 0000013ac6c0dc00 0000000000000001
>>> [   21.455008]            0000000000000000 0000013abb69a710 0000013a00000000 00000001b691fd98
>>> [   21.455011]            00000001b691fd98 0000013ace4775c8 0000000000000001 0000000000000000
>>> [   21.455014]            0000013ac6c0dc00 0000000000b47238 00000001b691fc08 00000001b691fbd0
>>> [   21.455032] Krnl Code: 000000000069c596: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>                           000000000069c59c: c0f4ffff7a5e	brcl	15,68ba58
>>>                          #000000000069c5a2: a7f40001		brc	15,69c5a4
>>>                          >000000000069c5a6: e340f0c00004	lg	%r4,192(%r15)
>>>                           000000000069c5ac: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>>                           000000000069c5b2: 07f4		bcr	15,%r4
>>>                           000000000069c5b4: c0e5fffffeea	brasl	%r14,69c388
>>>                           000000000069c5ba: a7f4fff6		brc	15,69c5a6
>>> [   21.455067] Call Trace:
>>> [   21.455072] ([<00000001b691fd98>] 0x1b691fd98)
>>> [   21.455079]  [<000000000069c692>] blk_mq_run_hw_queue+0xba/0x100 
>>> [   21.455083]  [<000000000069c740>] blk_mq_run_hw_queues+0x68/0x88 
>>> [   21.455089]  [<000000000069b956>] __blk_mq_complete_request+0x11e/0x1d8 
>>> [   21.455091]  [<000000000069ba9c>] blk_mq_complete_request+0x8c/0xc8 
>>> [   21.455103]  [<00000000008aa250>] dasd_block_tasklet+0x158/0x490 
>>> [   21.455110]  [<000000000014c742>] tasklet_hi_action+0x92/0x120 
>>> [   21.455118]  [<0000000000a7cfc0>] __do_softirq+0x120/0x348 
>>> [   21.455122]  [<000000000014c212>] irq_exit+0xba/0xd0 
>>> [   21.455130]  [<000000000010bf92>] do_IRQ+0x8a/0xb8 
>>> [   21.455133]  [<0000000000a7c298>] io_int_handler+0x130/0x298 
>>> [   21.455136] Last Breaking-Event-Address:
>>> [   21.455138]  [<000000000069c5a2>] __blk_mq_delay_run_hw_queue+0xba/0xd8
>>> [   21.455140] ---[ end trace be43f99a5d1e553e ]---
>>> [   21.510046] dasdconf.sh Warning: 0.0.241e is already online, not configuring
>>
>> Thinking about this issue further, I can't understand the root cause for
>> this issue.
>>
>> After commit 20e4d813931961fe ("blk-mq: simplify queue mapping & schedule with
>> each possisble CPU"), each hw queue should be mapped to at least one CPU, that
>> means this issue shouldn't happen. Maybe blk_mq_map_queues() works wrong?
>>
>> Could you dump 'lscpu' and provide blk-mq debugfs for your DASD via the
>> following command?
> 
> # lscpu
> Architecture:        s390x
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Big Endian
> CPU(s):              16
> On-line CPU(s) list: 0-15
> Thread(s) per core:  2
> Core(s) per socket:  8
> Socket(s) per book:  3
> Book(s) per drawer:  2
> Drawer(s):           4
> NUMA node(s):        1
> Vendor ID:           IBM/S390
> Machine type:        2964
> CPU dynamic MHz:     5000
> CPU static MHz:      5000
> BogoMIPS:            20325.00
> Hypervisor:          PR/SM
> Hypervisor vendor:   IBM
> Virtualization type: full
> Dispatching mode:    horizontal
> L1d cache:           128K
> L1i cache:           96K
> L2d cache:           2048K
> L2i cache:           2048K
> L3 cache:            65536K
> L4 cache:            491520K
> NUMA node0 CPU(s):   0-15
> Flags:               esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx sie
> 
> # lsdasd 
> Bus-ID     Status      Name      Device  Type  BlkSz  Size      Blocks
> ==============================================================================
> 0.0.3f75   active      dasda     94:0    ECKD  4096   21129MB   5409180
> 0.0.3f76   active      dasdb     94:4    ECKD  4096   21129MB   5409180
> 0.0.3f77   active      dasdc     94:8    ECKD  4096   21129MB   5409180
> 0.0.3f74   active      dasdd     94:12   ECKD  4096   21129MB   5409180
> 
>>
>> (cd /sys/kernel/debug/block/$DASD && find . -type f -exec grep -aH . {} \;)
> 
> 
> see attachement:
> 
