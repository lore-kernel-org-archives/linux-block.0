Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1549C282DA
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7973F21841
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 05:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfDIFNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 01:13:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbfDIFNw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Apr 2019 01:13:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3955naL066285
        for <linux-block@vger.kernel.org>; Tue, 9 Apr 2019 01:13:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rrm0wj334-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 01:13:50 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <stewart@linux.ibm.com>;
        Tue, 9 Apr 2019 06:13:50 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 9 Apr 2019 06:13:45 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x395DiCa30933178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Apr 2019 05:13:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FF71AC064;
        Tue,  9 Apr 2019 05:13:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D11AC060;
        Tue,  9 Apr 2019 05:13:40 +0000 (GMT)
Received: from birb.localdomain (unknown [9.81.204.125])
        by b01ledav006.gho.pok.ibm.com (Postfix) with SMTP;
        Tue,  9 Apr 2019 05:13:40 +0000 (GMT)
Received: by birb.localdomain (Postfix, from userid 1000)
        id 5E1AE176AD2; Tue,  9 Apr 2019 15:13:36 +1000 (AEST)
From:   Stewart Smith <stewart@linux.ibm.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly() changes
In-Reply-To: <20190404170843.83517-1-bvanassche@acm.org>
References: <20190404170843.83517-1-bvanassche@acm.org>
Date:   Tue, 09 Apr 2019 15:13:36 +1000
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19040905-0064-0000-0000-000003C84700
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010893; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01186431; UDB=6.00621380; IPR=6.00967191;
 MB=3.00026355; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-09 05:13:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040905-0065-0000-0000-00003CFF3A34
Message-Id: <87y34jwykf.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904090035
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:
> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests that
> have been queued. If that happens when blk_mq_try_issue_directly() is called
> by the dm-mpath driver then dm-mpath will try to resubmit a request that is
> already queued and a kernel crash follows. Since it is nontrivial to fix
> blk_mq_request_issue_directly(), revert the blk_mq_request_issue_directly()
> changes that went into kernel v5.0.
>
> This patch reverts the following commits:
> * d6a51a97c0b2 ("blk-mq: replace and kill blk_mq_request_issue_directly") # v5.0.
> * 5b7a6f128aad ("blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests") # v5.0.
> * 7f556a44e61d ("blk-mq: refactor the code of issue request directly") # v5.0.

At least when this patch is cherry-picked back on top of 5.0.7, it
doesn't seem to fully fix the problem for us (which is ppc64le). We hit
this at some point while eudev is finding disks and we have a process
mounting them to see what's there:

cpu 0x4a: Vector: 400 (Instruction Access) at [c000203ff398b100]
    pc: c0000000021fe700
    lr: c0000000002001d8: blk_mq_complete_request+0x34/0x138
    sp: c000203ff398b390
   msr: 9000000010009033
  current = 0xc000203ff3901b00
  paca    = 0xc000203fff7f3680	 irqmask: 0x03	 irq_happened: 0x01
    pid   = 658, comm = kworker/u257:2
Linux version 5.0.7-openpower1 (hostboot@gfw275.aus.stglabs.ibm.com) (gcc version 6.5.0 (Buildroot 2019.02.1-00016-ge01dcd0)) #2 SMP Mon Apr 8 09:14:53 CDT 2019

[link register   ] c0000000002001d8 blk_mq_complete_request+0x34/0x138
[c000203ff398b390] c000203ff398b3d0 (unreliable)
[c000203ff398b3d0] c0000000002d0428 scsi_mq_done+0x48/0x6c
[c000203ff398b410] c0000000002ee8d8 ata_scsi_simulate+0x78/0x29c
[c000203ff398b460] c0000000002eee74 ata_scsi_queuecmd+0xa8/0x2cc
[c000203ff398b4a0] c0000000002d2ac4 scsi_queue_rq+0x7bc/0x810
[c000203ff398b540] c000000000202570 blk_mq_dispatch_rq_list+0x474/0x5c0
[c000203ff398b600] c000000000207560 blk_mq_sched_dispatch_requests+0x114/0x18c
[c000203ff398b660] c0000000002009e4 __blk_mq_run_hw_queue+0xe0/0xf8
[c000203ff398b6e0] c000000000200a5c __blk_mq_delay_run_hw_queue+0x60/0x184
[c000203ff398b740] c000000000200c20 blk_mq_run_hw_queue+0x70/0xe4
[c000203ff398b790] c0000000002077ec blk_mq_sched_insert_request+0x68/0x194
[c000203ff398b7f0] c0000000001fc1d8 blk_execute_rq_nowait+0x78/0x8c
[c000203ff398b810] c0000000001fc234 blk_execute_rq+0x48/0x90
[c000203ff398b860] c0000000002cfa10 __scsi_execute+0xd8/0x1ac
[c000203ff398b8d0] c0000000002cc31c ioctl_internal_command.constprop.2+0x50/0x144
[c000203ff398b980] c0000000002cc474 scsi_set_medium_removal+0x64/0x9c
[c000203ff398b9c0] c0080000101f2754 sd_open+0xe8/0x148 [sd_mod]
[c000203ff398ba00] c00000000018b730 __blkdev_get+0x198/0x3e4
[c000203ff398ba70] c00000000018b9cc blkdev_get+0x50/0x35c
[c000203ff398bb10] c00000000020b140 __device_add_disk+0x468/0x488
[c000203ff398bbd0] c0080000101f5484 sd_probe_async+0xd4/0x180 [sd_mod]
[c000203ff398bc60] c00000000009a128 async_run_entry_fn+0x68/0x138
[c000203ff398bca0] c000000000090858 process_one_work+0x204/0x334
[c000203ff398bd30] c000000000090ca4 worker_thread+0x2d0/0x394
[c000203ff398bdb0] c000000000096cb4 kthread+0x14c/0x154
[c000203ff398be20] c00000000000b72c ret_from_kernel_thread+0x5c/0x70

4a:mon> r

R00 = c0000000002d0428   R16 = 0000000000000001
R01 = c000203ff398b390   R17 = 0000000000000000
R02 = c000000001d5af00   R18 = 0000000000000004
R03 = c000003feb215600   R19 = 0000000000000000
R04 = c000003feb1a1900   R20 = c000003feb215600
R05 = 0000000000000005   R21 = c000003feb660000
R06 = 0000000000000020   R22 = 0000000000000402
R07 = 0000000000000000   R23 = 0000000000000000
R08 = c000003fecf86300   R24 = c000003fecf22800
R09 = 0000000000000001   R25 = c000003fecf2e800
R10 = 0000000000000000   R26 = c000003feb0f5000
R11 = c0080000101f5b20   R27 = c000003feb215720
R12 = c000203ffc1ff500   R28 = c000003fecf2e800
R13 = c000203fff7f3680   R29 = c000003feb2158b0
R14 = c000000000096b70   R30 = c000003feb660000
R15 = c000203ff3c10000   R31 = c000003feb215720
pc  = c0000000021fe700
cfar= c0000000002001d4 blk_mq_complete_request+0x30/0x138
lr  = c0000000002001d8 blk_mq_complete_request+0x34/0x138
msr = 9000000010009033   cr  = 24022222
ctr = c0000000002d03e0   xer = 0000000000000000   trap =  400
4a:mon> 
 special_registers=
S

msr    = 9000000000001033  sprg0 = 0000000000000000
pvr    = 00000000004e1202  sprg1 = 0000000000000000
dec    = ffffffe807402ddf  sprg2 = 0000000000000000
sp     = c000203ff398ab60  sprg3 = 000000000008004a
toc    = c000000001d5af00  dar   = 00000000100be2af
srr0   = c0000000021fe700  srr1  = 9000000010009033 dsisr  = 40000000
dscr   = 0000000000000010  ppr   = 0010000000000000 pir    = 0000080a
amr    = 0000000000000000  uamor = 0000000000000000
sdr1   = 0000000048022224  hdar  = 0000000000000000 hdsisr = 00000000
hsrr0  = c000000000051708 hsrr1  = 9000000000001033 hdec   = ffffffe109d0f8da
lpcr   = 0040400001d2f012  pcr   = 0000000000000000 lpidr  = 00000000
hsprg0 = c000203fff7f3680 hsprg1 = c000203fff7f3680 amor   = 0000000000000000
dabr   = 0000000048022224 dabrx  = c000000000051708
dpdes  = 0000000000000000  tir   = 0000000000000002 cir    = 00000000
fscr   = 0000000000000180  tar   = 0000000000000000 pspb   = 00000000
mmcr0  = 0000000000000000  mmcr1 = 0000000000000000 mmcr2  = 0000000000000000
pmc1   = 00000000 pmc2 = 00000000  pmc3 = 00000000  pmc4   = 00000000
mmcra  = 0000000000000000   siar = 0000000000000000 pmc5   = 80000031
sdar   = 0000000000000000   sier = 0000000000000000 pmc6   = 80000001
ebbhr  = 0000000000000000  ebbrr = 0000000000000000 bescr  = 0000000000000000
iamr   = 0000000000000000
hfscr  = 000000000000059f  dhdes = c000000000051708 rpr    = 00000103070f1f3f
dawr   = 0000000000000000  dawrx = 0000000000000000 ciabr  = 0000000000000000
pidr   = 000000000000001a  tidr  = 0000000000000000
asdr   = 0000000000000000  psscr = 2000000000300332
ptcr   = 0000203fff7e0004



For reference, the backtrace we got with near pure 5.0.6 (one patch
in xhci):

cpu 0x27: Vector: 380 (Data Access Out of Range) at [c000001ff537b2d0]
    pc: c0000000001fe754: blk_add_timer+0x2c/0xa4
    lr: c0000000002001d4: blk_mq_start_request+0xa8/0xe0
    sp: c000001ff537b560
   msr: 9000000000009033
   dar: 43f900c0000020d3
  current = 0xc000001ff52dd880
  paca    = 0xc000001ffffe1f80     irqmask: 0x03     irq_happened: 0x01
    pid   = 812, comm = kworker/u321:1
Linux version 5.0.6-openpower1 (hostboot@gfw273.aus.stglabs.ibm.com) (gcc version 6.5.0 (Buildroot 2019.02.1-00015-gc5f183f)) #2 SMP Wed Apr 3 04:45:56 CDT 2019
enter ? for help
[c000001ff537b590] c0000000002001d4 blk_mq_start_request+0xa8/0xe0
[c000001ff537b5c0] c0000000002d25b0 scsi_queue_rq+0x508/0x810
[c000001ff537b660] c0000000002023c0 blk_mq_dispatch_rq_list+0x474/0x5c0
[c000001ff537b720] c000000000207360 blk_mq_sched_dispatch_requests+0x114/0x18c
[c000001ff537b780] c000000000200834 __blk_mq_run_hw_queue+0xe0/0xf8
[c000001ff537b800] c0000000002008ac __blk_mq_delay_run_hw_queue+0x60/0x184
[c000001ff537b860] c000000000200a70 blk_mq_run_hw_queue+0x70/0xe4
[c000001ff537b8b0] c0000000002075ec blk_mq_sched_insert_request+0x68/0x194
[c000001ff537b910] c0000000001fc028 blk_execute_rq_nowait+0x78/0x8c
[c000001ff537b930] c0000000001fc084 blk_execute_rq+0x48/0x90
[c000001ff537b980] c0000000002cf7b0 __scsi_execute+0xd8/0x1ac
[c000001ff537b9f0] c0000000002d3bd0 scsi_probe_and_add_lun+0x1ec/0xa48
[c000001ff537bb40] c0000000002d4778 __scsi_add_device+0xf4/0xf8
[c000001ff537bba0] c0000000002ef068 ata_scsi_scan_host+0xf4/0x1fc
[c000001ff537bc30] c0000000002e94b4 async_port_probe+0x6c/0x78
[c000001ff537bc60] c00000000009a0b0 async_run_entry_fn+0x68/0x138
[c000001ff537bca0] c0000000000907e0 process_one_work+0x204/0x334
[c000001ff537bd30] c000000000090c2c worker_thread+0x2d0/0x394
[c000001ff537bdb0] c000000000096c3c kthread+0x14c/0x154
[c000001ff537be20] c00000000000b72c ret_from_kernel_thread+0x5c/0x70
27:mon>

-- 
Stewart Smith
OPAL Architect, IBM.

