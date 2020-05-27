Return-Path: <SRS0=4GtC=7J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C34C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4D42084C
	for <linux-block@archiver.kernel.org>; Wed, 27 May 2020 18:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UDLPzB3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbgE0SHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 May 2020 14:07:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52710 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgE0SHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:07:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RI28Lb120155;
        Wed, 27 May 2020 18:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+h/gGcyWHKhcDMgy1dZJ30IPaBXOLlyVVZC9lm/roic=;
 b=UDLPzB3nXuSobGjgTr+BHjwz619MBmLwPHTthZ4nF1kKAzf9jKtuPiUkhOfh0s56hR2W
 dgNJi42vitdXgqHmhVE+3FrszPO0IQ7ylV9PI6xv1JyhlnHrrZS6vsdcC7vB3uM2DlQV
 f679+fDixQgCl9PJaboj5TW/e8r7+bZ38HZDmWo2gKaM7nRgm48Q4Ohe/tNAuT9fZuTn
 1obDRnQH/6STxQRIj8stypxIGDglDDXJ1gTppBpgX3fH3/wsIfX/wHjezqDD7DK2nKOX
 uArLXsLGpNWptMeZ+XuMyIfze/2NYUJQkYoiSnKefVsemF+KXfukjMKq9oAMJXAd5g3g Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 318xe1gytx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 May 2020 18:07:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04RI357h150070;
        Wed, 27 May 2020 18:07:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 317ddr7xe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 18:07:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04RI75JA025708;
        Wed, 27 May 2020 18:07:05 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com (/10.76.241.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 May 2020 11:07:05 -0700
Subject: Re: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
References: <20200520115655.729705-1-ming.lei@redhat.com>
From:   Alan Adamson <alan.adamson@oracle.com>
Message-ID: <22083f76-43f5-38a1-0e2d-84b626a6fd50@oracle.com>
Date:   Wed, 27 May 2020 11:09:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520115655.729705-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=4 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9633 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=4 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270141
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I tested this patch against a timeout test I've been working with and 
I'm getting a hang.

# cat block-err.sh
set -x
echo 100 > /sys/kernel/debug/fail_io_timeout/probability
echo 1000 > /sys/kernel/debug/fail_io_timeout/times
echo 1 > /sys/block/nvme0n1/io-timeout-fail
dd if=/dev/nvme0n1 of=/dev/null bs=512 count=1


# sh  block-err.sh
+ echo 100
+ echo 1000
+ echo 1
+ dd if=/dev/nvme0n1 of=/dev/null bs=512 count=1

**** Hang ****

# dmesg
.
.
.
[   79.403253] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 1000
[   79.403255] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0-rc7+ #1
[   79.403256] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[   79.403257] Call Trace:
[   79.403259]  <IRQ>
[   79.403267]  dump_stack+0x6d/0x9a
[   79.403270]  should_fail.cold.5+0x32/0x42
[   79.403273]  blk_should_fake_timeout+0x26/0x30
[   79.403275]  blk_mq_complete_request+0x1b/0x120
[   79.403280]  nvme_irq+0xd9/0x1f0 [nvme]
[   79.403287]  __handle_irq_event_percpu+0x44/0x190
[   79.403288]  handle_irq_event_percpu+0x32/0x80
[   79.403290]  handle_irq_event+0x3b/0x5a
[   79.403291]  handle_edge_irq+0x87/0x190
[   79.403296]  do_IRQ+0x54/0xe0
[   79.403299]  common_interrupt+0xf/0xf
[   79.403300]  </IRQ>
[   79.403305] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[   79.403307] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[   79.403308] RSP: 0018:ffffb97e8c54be40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[   79.403309] RAX: ffff9781bf76cc40 RBX: ffffd95e7f743200 RCX: 
000000000000001f
[   79.403310] RDX: 000000127ccd6e6c RSI: 0000000031573862 RDI: 
0000000000000000
[   79.403310] RBP: ffffb97e8c54be80 R08: 0000000000000002 R09: 
000000000002c4c0
[   79.403311] R10: 011b921e580bc454 R11: ffff9781bf76bb44 R12: 
0000000000000002
[   79.403311] R13: ffffffffbd14c120 R14: ffffffffbd14c208 R15: 
ffffffffbd14c1f0
[   79.403314]  cpuidle_enter+0x2e/0x40
[   79.403318]  call_cpuidle+0x23/0x40
[   79.403319]  do_idle+0x230/0x270
[   79.403320]  cpu_startup_entry+0x1d/0x20
[   79.403325]  start_secondary+0x170/0x1c0
[   79.403329]  secondary_startup_64+0xb6/0xc0
[  109.674334] nvme nvme0: I/O 754 QID 34 timeout, aborting
[  109.674395] nvme nvme0: Abort status: 0x0
[  139.879453] nvme nvme0: I/O 754 QID 34 timeout, reset controller
[  139.895263] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 999
[  139.895265] CPU: 5 PID: 2470 Comm: kworker/5:1H Not tainted 5.7.0-rc7+ #1
[  139.895266] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  139.895271] Workqueue: kblockd blk_mq_timeout_work
[  139.895272] Call Trace:
[  139.895279]  dump_stack+0x6d/0x9a
[  139.895281]  should_fail.cold.5+0x32/0x42
[  139.895282]  blk_should_fake_timeout+0x26/0x30
[  139.895283]  blk_mq_complete_request+0x1b/0x120
[  139.895292]  nvme_cancel_request+0x33/0x80 [nvme_core]
[  139.895296]  bt_tags_iter+0x48/0x50
[  139.895297]  blk_mq_tagset_busy_iter+0x1eb/0x270
[  139.895299]  ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
[  139.895301]  ? nvme_try_sched_reset+0x40/0x40 [nvme_core]
[  139.895305]  nvme_dev_disable+0x2be/0x460 [nvme]
[  139.895307]  nvme_timeout.cold.80+0x9c/0x182 [nvme]
[  139.895311]  ? sched_clock+0x9/0x10
[  139.895315]  ? sched_clock_cpu+0x11/0xc0
[  139.895320]  ? __switch_to_asm+0x40/0x70
[  139.895321]  blk_mq_check_expired+0x192/0x1b0
[  139.895322]  bt_iter+0x52/0x60
[  139.895323]  blk_mq_queue_tag_busy_iter+0x1a0/0x2e0
[  139.895325]  ? __switch_to_asm+0x40/0x70
[  139.895326]  ? __blk_mq_requeue_request+0xf0/0xf0
[  139.895326]  ? __blk_mq_requeue_request+0xf0/0xf0
[  139.895329]  ? compat_start_thread+0x20/0x40
[  139.895330]  blk_mq_timeout_work+0x5a/0x130
[  139.895333]  process_one_work+0x1ab/0x380
[  139.895334]  worker_thread+0x37/0x3b0
[  139.895335]  kthread+0x120/0x140
[  139.895337]  ? create_worker+0x1b0/0x1b0
[  139.895337]  ? kthread_park+0x90/0x90
[  139.895339]  ret_from_fork+0x35/0x40
[  139.897859] nvme nvme0: Shutdown timeout set to 10 seconds
[  139.901186] nvme nvme0: 56/0/0 default/read/poll queues

On 5/20/20 4:56 AM, Ming Lei wrote:
> Hi,
>
> For nvme-pci, after controller is recovered, in-flight IOs are waited
> before updating nr hw queues. If new controller error happens during
> this period, nvme-pci driver deletes the controller and fails in-flight
> IO. This way is too violent, and not friendly from user viewpoint.
>
> Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
> in nvme-pci reset handler with checking if all ns queues are frozen &
> controller disabled. Then a fresh new reset can be scheduled for
> handling new controller error during waiting for in-flight IO completion.
>
> So deleting controller & failing IOs can be avoided in this situation.
>
> Without this patches, when fail io timeout injection is run, the
> controller can be removed very quickly. With this patch, no controller
> removing can be observed, and controller can recover to normal state
> after stopping to inject io timeout failure.
>
> Ming Lei (3):
>    blk-mq: add API of blk_mq_queue_frozen
>    nvme: add nvme_frozen
>    nvme-pci: make nvme reset more reliable
>
>   block/blk-mq.c           |  6 ++++++
>   drivers/nvme/host/core.c | 14 ++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/pci.c  | 37 ++++++++++++++++++++++++++++++-------
>   include/linux/blk-mq.h   |  1 +
>   5 files changed, 52 insertions(+), 7 deletions(-)
>
