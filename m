Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EDC433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 18:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D88208A7
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 18:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLutkwwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405855AbgE1Sgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 14:36:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405970AbgE1Sgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 14:36:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SIWBXB086867;
        Thu, 28 May 2020 18:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=82IvVlrNxbL9+GKpc1+9oJqs+m7vZ4Lj5fx6gsbxtc0=;
 b=JLutkwwXYMkf8cCgj1UIafQx85OBMIfXO1EL3jfs9egb5B3QtOQhu4BMCT3Npjw06WPx
 YTgcfj5uCCtMXOa7O4gu39c8SEU6F52D8UT+yjef1UUG6p8+1mxXFR30C1VZZezFEWd+
 gEkUZP0tYgjQpCAgAkbsqZNlrtm5lJh4VTZQJWsL1Ts/1FjfekGLokbb7jxHOIDQwtJi
 b7o7gSDOAupcSpPeBSv+xNtfwdeAq7wdoaFoHm8ZuI+rTRUzjZyloMz3XDmq3wzlywyf
 i6qsWG35AkILEQeLd3NI6ZplfW8hCG1wc7bg9/kXMDrDVtvuPbRzc2cxXQVMSw3YX098 zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 318xe1pmph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 May 2020 18:36:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04SIX8ld166099;
        Thu, 28 May 2020 18:36:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 317ddt8cq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 18:36:24 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04SIaNxC032674;
        Thu, 28 May 2020 18:36:23 GMT
Received: from dhcp-10-76-241-128.usdhcp.oraclecorp.com (/10.76.241.128)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 May 2020 11:36:22 -0700
Subject: Re: [PATCHv3 2/2] nvme: cancel requests for real
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200528153441.3501777-1-kbusch@kernel.org>
 <20200528153441.3501777-2-kbusch@kernel.org>
From:   Alan Adamson <alan.adamson@oracle.com>
Message-ID: <68629453-d776-59e5-cdc9-8681eb2bab37@oracle.com>
Date:   Thu, 28 May 2020 11:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528153441.3501777-2-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=3 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=3 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005280125
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Still seeing a hang.

Alan


[   92.034813] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 1000
[   92.034816] CPU: 54 PID: 0 Comm: swapper/54 Not tainted 5.7.0-rc7+ #2
[   92.034817] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[   92.034818] Call Trace:
[   92.034819]  <IRQ>
[   92.034827]  dump_stack+0x6d/0x9a
[   92.034830]  should_fail.cold.5+0x32/0x42
[   92.034833]  blk_should_fake_timeout+0x26/0x30
[   92.034835]  blk_mq_complete_request+0x15/0x30
[   92.034840]  nvme_irq+0xd9/0x1f0 [nvme]
[   92.034846]  __handle_irq_event_percpu+0x44/0x190
[   92.034848]  handle_irq_event_percpu+0x32/0x80
[   92.034849]  handle_irq_event+0x3b/0x5a
[   92.034851]  handle_edge_irq+0x87/0x190
[   92.034855]  do_IRQ+0x54/0xe0
[   92.034859]  common_interrupt+0xf/0xf
[   92.034859]  </IRQ>
[   92.034865] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[   92.034866] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[   92.034867] RSP: 0018:ffffae4ecc6d3e40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[   92.034869] RAX: ffff9b537fcacc40 RBX: ffffce4ebfc83200 RCX: 
000000000000001f
[   92.034869] RDX: 000000156db3b7a5 RSI: 0000000031573862 RDI: 
0000000000000000
[   92.034870] RBP: ffffae4ecc6d3e80 R08: 0000000000000002 R09: 
000000000002c4c0
[   92.034871] R10: 011c6513a4e6709e R11: ffff9b537fcabb44 R12: 
0000000000000002
[   92.034871] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[   92.034874]  cpuidle_enter+0x2e/0x40
[   92.034877]  call_cpuidle+0x23/0x40
[   92.034878]  do_idle+0x230/0x270
[   92.034880]  cpu_startup_entry+0x1d/0x20
[   92.034885]  start_secondary+0x170/0x1c0
[   92.034889]  secondary_startup_64+0xb6/0xc0
[  122.473526] nvme nvme0: I/O 384 QID 27 timeout, aborting
[  122.473586] nvme nvme0: Abort status: 0x0
[  152.678470] nvme nvme0: I/O 384 QID 27 timeout, reset controller
[  152.697122] blk_update_request: I/O error, dev nvme0n1, sector 0 op 
0x0:(READ) flags 0x80700 phys_seg 4 prio class 0
[  152.699687] nvme nvme0: Shutdown timeout set to 10 seconds
[  152.703131] nvme nvme0: 56/0/0 default/read/poll queues
[  152.703290] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 999
[  152.703293] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  152.703293] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  152.703294] Call Trace:
[  152.703295]  <IRQ>
[  152.703301]  dump_stack+0x6d/0x9a
[  152.703302]  should_fail.cold.5+0x32/0x42
[  152.703305]  blk_should_fake_timeout+0x26/0x30
[  152.703306]  blk_mq_complete_request+0x15/0x30
[  152.703311]  nvme_irq+0xd9/0x1f0 [nvme]
[  152.703316]  __handle_irq_event_percpu+0x44/0x190
[  152.703317]  handle_irq_event_percpu+0x32/0x80
[  152.703319]  handle_irq_event+0x3b/0x5a
[  152.703321]  handle_edge_irq+0x87/0x190
[  152.703323]  do_IRQ+0x54/0xe0
[  152.703326]  common_interrupt+0xf/0xf
[  152.703327]  </IRQ>
[  152.703330] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  152.703332] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  152.703333] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  152.703334] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  152.703334] RDX: 000000238dd33ffa RSI: 0000000031573862 RDI: 
0000000000000000
[  152.703335] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  152.703336] R10: 011c653849df4957 R11: ffff9b537fc6bb44 R12: 
0000000000000004
[  152.703336] R13: ffffffffa374c120 R14: ffffffffa374c2d8 R15: 
ffffffffa374c2c0
[  152.703339]  cpuidle_enter+0x2e/0x40
[  152.703342]  call_cpuidle+0x23/0x40
[  152.703343]  do_idle+0x230/0x270
[  152.703344]  cpu_startup_entry+0x1d/0x20
[  152.703348]  start_secondary+0x170/0x1c0
[  152.703352]  secondary_startup_64+0xb6/0xc0
[  182.883552] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  182.883608] nvme nvme0: Abort status: 0x0
[  213.088659] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  213.109414] nvme nvme0: Shutdown timeout set to 10 seconds
[  213.112785] nvme nvme0: 56/0/0 default/read/poll queues
[  213.112880] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 998
[  213.112882] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  213.112883] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  213.112883] Call Trace:
[  213.112884]  <IRQ>
[  213.112887]  dump_stack+0x6d/0x9a
[  213.112888]  should_fail.cold.5+0x32/0x42
[  213.112889]  blk_should_fake_timeout+0x26/0x30
[  213.112890]  blk_mq_complete_request+0x15/0x30
[  213.112893]  nvme_irq+0xd9/0x1f0 [nvme]
[  213.112896]  __handle_irq_event_percpu+0x44/0x190
[  213.112897]  handle_irq_event_percpu+0x32/0x80
[  213.112898]  handle_irq_event+0x3b/0x5a
[  213.112900]  handle_edge_irq+0x87/0x190
[  213.112901]  do_IRQ+0x54/0xe0
[  213.112903]  common_interrupt+0xf/0xf
[  213.112903]  </IRQ>
[  213.112905] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  213.112906] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  213.112907] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  213.112908] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  213.112909] RDX: 000000319e847448 RSI: 0000000031573862 RDI: 
0000000000000000
[  213.112909] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  213.112910] R10: 011c655cc6d029f4 R11: ffff9b537fc6bb44 R12: 
0000000000000002
[  213.112911] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[  213.112913]  cpuidle_enter+0x2e/0x40
[  213.112915]  call_cpuidle+0x23/0x40
[  213.112916]  do_idle+0x230/0x270
[  213.112917]  cpu_startup_entry+0x1d/0x20
[  213.112919]  start_secondary+0x170/0x1c0
[  213.112920]  secondary_startup_64+0xb6/0xc0
[  243.293996] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  243.294050] nvme nvme0: Abort status: 0x0
[  273.498939] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  273.509832] nvme nvme0: new error during reset
[  273.519648] nvme nvme0: Shutdown timeout set to 10 seconds
[  273.523310] nvme nvme0: 56/0/0 default/read/poll queues
[  273.523397] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 997
[  273.523399] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  273.523400] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  273.523400] Call Trace:
[  273.523401]  <IRQ>
[  273.523404]  dump_stack+0x6d/0x9a
[  273.523405]  should_fail.cold.5+0x32/0x42
[  273.523406]  blk_should_fake_timeout+0x26/0x30
[  273.523407]  blk_mq_complete_request+0x15/0x30
[  273.523410]  nvme_irq+0xd9/0x1f0 [nvme]
[  273.523412]  __handle_irq_event_percpu+0x44/0x190
[  273.523413]  handle_irq_event_percpu+0x32/0x80
[  273.523415]  handle_irq_event+0x3b/0x5a
[  273.523416]  handle_edge_irq+0x87/0x190
[  273.523417]  do_IRQ+0x54/0xe0
[  273.523419]  common_interrupt+0xf/0xf
[  273.523420]  </IRQ>
[  273.523422] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  273.523423] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  273.523424] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  273.523425] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  273.523425] RDX: 0000003faf43ca28 RSI: 0000000031573862 RDI: 
0000000000000000
[  273.523426] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  273.523426] R10: 011c658143e5b34c R11: ffff9b537fc6bb44 R12: 
0000000000000002
[  273.523427] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[  273.523429]  cpuidle_enter+0x2e/0x40
[  273.523431]  call_cpuidle+0x23/0x40
[  273.523432]  do_idle+0x230/0x270
[  273.523433]  cpu_startup_entry+0x1d/0x20
[  273.523435]  start_secondary+0x170/0x1c0
[  273.523436]  secondary_startup_64+0xb6/0xc0
[  303.704204] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  303.704245] nvme nvme0: Abort status: 0x0
[  333.909140] nvme nvme0: I/O 960 QID 26 timeout, reset controller
[  333.928010] nvme nvme0: new error during reset
[  333.934087] nvme nvme0: Shutdown timeout set to 10 seconds
[  333.937470] nvme nvme0: 56/0/0 default/read/poll queues
[  333.937571] FAULT_INJECTION: forcing a failure.
                name fail_io_timeout, interval 1, probability 100, space 
0, times 996
[  333.937588] CPU: 53 PID: 0 Comm: swapper/53 Not tainted 5.7.0-rc7+ #2
[  333.937588] Hardware name: Oracle Corporation ORACLE SERVER 
X6-2/ASM,MOTHERBOARD,1U, BIOS 38050100 08/30/2016
[  333.937589] Call Trace:
[  333.937590]  <IRQ>
[  333.937592]  dump_stack+0x6d/0x9a
[  333.937593]  should_fail.cold.5+0x32/0x42
[  333.937594]  blk_should_fake_timeout+0x26/0x30
[  333.937595]  blk_mq_complete_request+0x15/0x30
[  333.937598]  nvme_irq+0xd9/0x1f0 [nvme]
[  333.937600]  __handle_irq_event_percpu+0x44/0x190
[  333.937602]  handle_irq_event_percpu+0x32/0x80
[  333.937603]  handle_irq_event+0x3b/0x5a
[  333.937604]  handle_edge_irq+0x87/0x190
[  333.937606]  do_IRQ+0x54/0xe0
[  333.937607]  common_interrupt+0xf/0xf
[  333.937608]  </IRQ>
[  333.937610] RIP: 0010:cpuidle_enter_state+0xc1/0x400
[  333.937611] Code: ff e8 e3 41 93 ff 80 7d c7 00 74 17 9c 58 0f 1f 44 
00 00 f6 c4 02 0f 85 d2 02 00 00 31 ff e8 16 c3 99 ff fb 66 0f 1f 44 00 
00 <45> 85 e4 0f 88 3d 02 00 00 49 63 c4 48 8d 14 40 48 8d 0c c5 00 00
[  333.937612] RSP: 0018:ffffae4ecc6cbe40 EFLAGS: 00000246 ORIG_RAX: 
ffffffffffffffdd
[  333.937613] RAX: ffff9b537fc6cc40 RBX: ffffce4ebfc43200 RCX: 
000000000000001f
[  333.937613] RDX: 0000004dc03adbda RSI: 0000000031573862 RDI: 
0000000000000000
[  333.937614] RBP: ffffae4ecc6cbe80 R08: 0000000000000002 R09: 
000000000002c4c0
[  333.937615] R10: 011c65a5c18bd252 R11: ffff9b537fc6bb44 R12: 
0000000000000002
[  333.937615] R13: ffffffffa374c120 R14: ffffffffa374c208 R15: 
ffffffffa374c1f0
[  333.937617]  cpuidle_enter+0x2e/0x40
[  333.937619]  call_cpuidle+0x23/0x40
[  333.937620]  do_idle+0x230/0x270
[  333.937621]  cpu_startup_entry+0x1d/0x20
[  333.937623]  start_secondary+0x170/0x1c0
[  333.937624]  secondary_startup_64+0xb6/0xc0
[  364.114200] nvme nvme0: I/O 960 QID 26 timeout, aborting
[  364.114241] nvme nvme0: Abort status: 0x0
[  369.745713] INFO: task kworker/u114:2:1182 blocked for more than 122 
seconds.
[  369.745758]       Not tainted 5.7.0-rc7+ #2
[  369.745787] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  369.745808] kworker/u114:2  D    0  1182      2 0x80004000
[  369.745817] Workqueue: nvme-wq nvme_scan_work [nvme_core]
[  369.745818] Call Trace:
[  369.745823]  __schedule+0x2dc/0x710
[  369.745828]  ? __kfifo_to_user_r+0x90/0x90
[  369.745829]  schedule+0x44/0xb0
[  369.745831]  blk_mq_freeze_queue_wait+0x4b/0xb0
[  369.745833]  ? finish_wait+0x80/0x80
[  369.745834]  blk_mq_freeze_queue+0x1a/0x20
[  369.745837]  nvme_update_disk_info+0x62/0x3b0 [nvme_core]
[  369.745839]  __nvme_revalidate_disk+0x8d/0x140 [nvme_core]
[  369.745842]  nvme_revalidate_disk+0xa4/0x140 [nvme_core]
[  369.745843]  ? blk_mq_run_hw_queue+0xba/0x100
[  369.745847]  revalidate_disk+0x2b/0xa0
[  369.745850]  nvme_validate_ns+0x46/0x5b0 [nvme_core]
[  369.745852]  ? __nvme_submit_sync_cmd+0xe0/0x1b0 [nvme_core]
[  369.745855]  nvme_scan_work+0x25a/0x310 [nvme_core]
[  369.745859]  process_one_work+0x1ab/0x380
[  369.745861]  worker_thread+0x37/0x3b0
[  369.745862]  kthread+0x120/0x140
[  369.745863]  ? create_worker+0x1b0/0x1b0
[  369.745864]  ? kthread_park+0x90/0x90
[  369.745867]  ret_from_fork+0x35/0x40


On 5/28/20 8:34 AM, Keith Busch wrote:
> Once the driver decides to cancel requests, the concept of those
> requests timing out ceases to exist. Use __blk_mq_complete_request() to
> bypass fake timeout error injection so that request reclaim may
> proceed.
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba860efd250d..f65a0b6cd988 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -310,7 +310,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   		return true;
>   
>   	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> -	blk_mq_complete_request(req);
> +	__blk_mq_complete_request(req);
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_request);
