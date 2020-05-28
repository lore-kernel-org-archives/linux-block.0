Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE9BC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9473D207D3
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 20:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kF3ipv60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406981AbgE1UTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 16:19:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406958AbgE1UTh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 16:19:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SKBvkQ176959;
        Thu, 28 May 2020 20:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Hv8ohpce88M/SCupqMGYlKCrTgESmjXWEjDcd3/zWIc=;
 b=kF3ipv60+QxcpLewIStynfjW0JevjLwRjeeFSaQRgU2BmUg5RbEUllZ5hnG6y6VOw2Ox
 MPdpQODPW3qPjv0XtDK92GWgvNnVdVcazm83Xi6P6flkcgx003UmPAuPrWvb3Ceek7oa
 tUMrY25tGZfwAlAmerTUxuipJaryzPSwqHOm3Jqf5zgvQeeDwtYbB+oJUb1j92TzNoYW
 XYNMcrEfIDkwlJ0Rd8/Gb5qK2hamR4WVJb3/YAqMaS/P/tznU4Tsx8G4ngdBsU98Px11
 XCsP6X1N3zXb9/Dd0ZRec+yqcMrIlJ1YI2vg41D8rzepn4pE0Spafsna+Gpij1nQWQai wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 318xbk75cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 20:19:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SK7fkQ033332;
        Thu, 28 May 2020 20:19:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31a9kt4k69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 20:19:07 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SKJ16d013332;
        Thu, 28 May 2020 20:19:01 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com (/10.76.241.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 13:19:01 -0700
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
 <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
 <20200528191118.GB3504306@dhcp-10-100-145-180.wdl.wdc.com>
 <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
From:   Alan Adamson <alan.adamson@oracle.com>
Message-ID: <f9cbedc9-88b2-acc8-5b95-f1c247ab1525@oracle.com>
Date:   Thu, 28 May 2020 13:21:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528191443.GA3504350@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=3 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280132
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It did come back.  Just took a little longer.

Alan

[  394.319378] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  394.334228] nvme nvme0: new error during reset
[  394.340125] nvme nvme0: Shutdown timeout set to 10 seconds
[  394.343452] nvme nvme0: 56/0/0 default/read/poll queues
[  394.343557] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 995
[  394.343559] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  394.343559] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  394.343560] Call Trace:
[  394.343561]  <IRQ>
[  394.343563]  dump_stack+0x6d/0x9a
[  394.343564]  should_fail.cold.5+0x32/0x42
[  394.343566]  blk_should_fake_timeout+0x26/0x30
[  394.343566]  blk_mq_complete_request+0x15/0x30
[  394.343569]  nvme_irq+0xd9/0x1f0 [nvme]
[  394.343571]  __handle_irq_event_percpu+0x44/0x190
[  394.343573]  handle_irq_event_percpu+0x32/0x80
[  394.343574]  handle_irq_event+0x3b/0x5a
[  394.343575]  handle_edge_irq+0x87/0x190
[  394.343577]  do_IRQ+0x54/0xe0
[  394.343578]  common_interrupt+0xf/0xf
[  394.343579]  </IRQ>
[  394.343581] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  394.343582] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  394.343583] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  394.343584] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  394.343585] RDX: 0000005bd0b51f04 RSI: 0000000031573862 RDI: 
0000000000000000
[  394.343585] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  394.343586] R10: 011c65ca3dee2b0c R11: ffff9b537fc6bb44 R12: 
0000000000000002
[  394.343586] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[  394.343588]  cpuidle_enter+0x2e/0x40
[  394.343590]  call_cpuidle+0x23/0x40
[  394.343591]  do_idle+0x230/0x270
[  394.343592]  cpu_startup_entry+0x1d/0x20
[  394.343594]  start_secondary+0x170/0x1c0
[  394.343596]  secondary_startup_64+0xb6/0xc0
[  424.524341] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  424.524389] nvme nvme0: Abort status: 0x0
[  454.729622] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  454.740442] nvme nvme0: new error during reset
[  454.750403] nvme nvme0: Shutdown timeout set to 10 seconds
[  454.753508] nvme nvme0: 56/0/0 default/read/poll queues
[  454.753596] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 994
[  454.753598] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  454.753599] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  454.753599] Call Trace:
[  454.753600]  <IRQ>
[  454.753603]  dump_stack+0x6d/0x9a
[  454.753604]  should_fail.cold.5+0x32/0x42
[  454.753605]  blk_should_fake_timeout+0x26/0x30
[  454.753606]  blk_mq_complete_request+0x15/0x30
[  454.753609]  nvme_irq+0xd9/0x1f0 [nvme]
[  454.753612]  __handle_irq_event_percpu+0x44/0x190
[  454.753613]  handle_irq_event_percpu+0x32/0x80
[  454.753615]  handle_irq_event+0x3b/0x5a
[  454.753616]  handle_edge_irq+0x87/0x190
[  454.753617]  do_IRQ+0x54/0xe0
[  454.753619]  common_interrupt+0xf/0xf
[  454.753620]  </IRQ>
[  454.753622] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  454.753623] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  454.753624] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  454.753625] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  454.753626] RDX: 00000069e16d295b RSI: 0000000031573862 RDI: 
0000000000000000
[  454.753626] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  454.753627] R10: 011c65eebaf0c79e R11: ffff9b537fc6bb44 R12: 
0000000000000002
[  454.753627] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[  454.753630]  cpuidle_enter+0x2e/0x40
[  454.753632]  call_cpuidle+0x23/0x40
[  454.753633]  do_idle+0x230/0x270
[  454.753634]  cpu_startup_entry+0x1d/0x20
[  454.753636]  start_secondary+0x170/0x1c0
[  454.753637]  secondary_startup_64+0xb6/0xc0
[  484.934587] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  484.934641] nvme nvme0: Abort status: 0x0
[  492.613861] INFO: task kworker/u114:2:1182 blocked for more than 245 
seconds.
[  492.613884]       Not tainted 5.7.0-rc7+ #2
[  492.613912] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  492.613948] kworker/u114:2  D    0  1182      2 0x80004000
[  492.613953] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  492.613954] Call Trace:
[  492.613956]  __schedule+0x2dc/0x710
[  492.613958]  ? __kfifo_to_user_r+0x90/0x90
[  492.613960]  schedule+0x44/0xb0
[  492.613961]  blk_mq_freeze_queue_wait+0x4b/0xb0
[  492.613962]  ? finish_wait+0x80/0x80
[  492.613963]  blk_mq_freeze_queue+0x1a/0x20
[  492.613966]  nvme_update_disk_info+0x62/0x3b0 [nvme_core]
[  492.613968]  __nvme_revalidate_disk+0x8d/0x140 [nvme_core]
[  492.613970]  nvme_revalidate_disk+0xa4/0x140 [nvme_core]
[  492.613971]  ? blk_mq_run_hw_queue+0xba/0x100
[  492.613973]  revalidate_disk+0x2b/0xa0
[  492.613975]  nvme_validate_ns+0x46/0x5b0 [nvme_core]
[  492.613978]  ? __nvme_submit_sync_cmd+0xe0/0x1b0 [nvme_core]
[  492.613980]  nvme_scan_work+0x25a/0x310 [nvme_core]
[  492.613983]  process_one_work+0x1ab/0x380
[  492.613984]  worker_thread+0x37/0x3b0
[  492.613985]  kthread+0x120/0x140
[  492.613990]  ? create_worker+0x1b0/0x1b0
[  492.613992]  ? kthread_park+0x90/0x90
[  492.614011]  ret_from_fork+0x35/0x40
[  515.139879] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  515.150634] nvme nvme0: new error during reset
[  515.158310] blk_update_request: I/O error, dev nvme0n1, sector 0 op 
0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  515.158346] Buffer I/O error on dev nvme0n1, logical block 0, async 
page read
[  515.160800] nvme nvme0: Shutdown timeout set to 10 seconds
[  515.163954] nvme nvme0: 56/0/0 default/read/poll queues
[root@localhost ~]#



On 5/28/20 12:14 PM, Keith Busch wrote:
> On Thu, May 28, 2020 at 12:11:18PM -0700, Keith Busch wrote:
>> You can expect your fake timeout with 100% probablility to take 150
>> seconds minimum to return a retryable request.
> Sorry, I should have said 300 seconds. We restart the timer for aborts,
> so 5 requeues * 30 seconds * 2 timer starts = 300 seconds.
