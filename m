Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9CC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9EF20661
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 18:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dellteam.com header.i=@dellteam.com header.b="nDhjZz7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCFS5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:57:07 -0500
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:19462 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfCFS5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Mar 2019 13:57:07 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2019 13:57:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dellteam.com; i=@dellteam.com; q=dns/txt; s=smtpout;
  t=1551898620; x=1583434620;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5RBsKgMNHFUQhSs7d8ktd5YbPP2KL1KnDzqpm54BRms=;
  b=nDhjZz7M3dPaA5bu57uEj9Lf/7c+lsTNtZomfEEKICjokDAp3oUF0VOh
   9zbajsL/olIJcuC6ZNA8YZWP+gVfHyIMvVe8bFav/1voyGH/yf9kPq8wN
   SpYSeZo7DyirAAusoUaHGo08BghXNze075depY5vkvqi42KJj2nwsdMXu
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EQAAC0FYBchieV50NkHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgWCBBoECEjGMGF+OdpYmgXsLAQEshECEVjQJDQEBAwEBAwE?=
 =?us-ascii?q?DAgEBAhABAQETCwgpL4I6IoJyFhUTPxIBPmkEAQ0NGoMAgXafKT0Cb4EBiQc?=
 =?us-ascii?q?BAQGBazOKKoEvAY0+gRGNdAKKDAqGU4FjkUMJBZJzIZMvLYpCkjECBAIEBQI?=
 =?us-ascii?q?UgUc3KoEucFCCbYIVDgmOHkGBWYtNAYEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2EQAAC0FYBchieV50NkHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?WCBBoECEjGMGF+OdpYmgXsLAQEshECEVjQJDQEBAwEBAwEDAgEBAhABAQETC?=
 =?us-ascii?q?wgpL4I6IoJyFhUTPxIBPmkEAQ0NGoMAgXafKT0Cb4EBiQcBAQGBazOKKoEvA?=
 =?us-ascii?q?Y0+gRGNdAKKDAqGU4FjkUMJBZJzIZMvLYpCkjECBAIEBQIUgUc3KoEucFCCb?=
 =?us-ascii?q?YIVDgmOHkGBWYtNAYEeAQE?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2019 12:48:09 -0600
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26Ih76F060189
        for <linux-block@vger.kernel.org>; Wed, 6 Mar 2019 13:48:31 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2r2fhq1sbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 13:48:30 -0500
Received: from ausxippc110.us.dell.com ([143.166.85.200])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Mar 2019 00:48:27 +0600
X-LoopCount0: from 10.166.135.137
X-IronPort-AV: E=Sophos;i="5.58,448,1544508000"; 
   d="scan'208";a="759622109"
From:   <Alex_Gagniuc@Dellteam.com>
To:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
CC:     <keith.busch@intel.com>
Subject: Interesting 'list _add double add' with nvme drives
Thread-Topic: Interesting 'list _add double add' with nvme drives
Thread-Index: AQHU1E0vvJr8rFhLyU2vfjUHQLfY0Q==
Date:   Wed, 6 Mar 2019 18:48:28 +0000
Message-ID: <e15de0114ffc415899aadc2d0aae418b@ausx13mps317.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.11.235]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903060129
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,=0A=
=0A=
I'm seeing a list error when we take away, then add back a bunch of nvme =
=0A=
drives. It's not very easy to repro, and the one surviving log is pasted =
=0A=
below.=0A=
=0A=
Alex=0A=
=0A=
=0A=
[  111.808900] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Down=0A=
[  117.496424] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
[  117.508144] pciehp 0000:3c:06.0:pcie204: Slot(180): Link Up=0A=
[  117.521525] pciehp 0000:b0:05.0:pcie204: Slot(179): Link Up=0A=
[  117.764856] pci 0000:3f:00.0: [144d:a822] type 00 class 0x010802=0A=
[  117.764897] pci 0000:3f:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit=
]=0A=
[  117.764948] pci 0000:3f:00.0: Max Payload Size set to 256 (was 128,=0A=
max 256)=0A=
[  117.765671] pcieport 0000:3c:06.0: bridge window [io  0x1000-0x0fff]=0A=
to [bus 3f] add_size 1000=0A=
[  117.765679] pcieport 0000:3c:06.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.765682] pcieport 0000:3c:06.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.765686] pcieport 0000:3c:06.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.765689] pcieport 0000:3c:06.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.765696] pci 0000:3f:00.0: BAR 0: assigned [mem=0A=
0xab500000-0xab503fff 64bit]=0A=
[  117.765710] pcieport 0000:3c:06.0: PCI bridge to [bus 3f]=0A=
[  117.765717] pcieport 0000:3c:06.0:   bridge window [mem=0A=
0xab500000-0xab5fffff]=0A=
[  117.765723] pcieport 0000:3c:06.0:   bridge window [mem=0A=
0x382000400000-0x3820005fffff 64bit pref]=0A=
[  117.766944] nvme nvme2: pci function 0000:3f:00.0=0A=
[  117.767060] nvme 0000:3f:00.0: enabling device (0000 -> 0002)=0A=
[  117.780851] pci 0000:b2:00.0: [144d:a822] type 00 class 0x010802=0A=
[  117.780889] pci 0000:b2:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit=
]=0A=
[  117.780938] pci 0000:b2:00.0: Max Payload Size set to 256 (was 128,=0A=
max 256)=0A=
[  117.781576] pcieport 0000:b0:05.0: bridge window [io  0x1000-0x0fff]=0A=
to [bus b2] add_size 1000=0A=
[  117.781583] pcieport 0000:b0:05.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.781586] pcieport 0000:b0:05.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.781590] pcieport 0000:b0:05.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.781593] pcieport 0000:b0:05.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.781600] pci 0000:b2:00.0: BAR 0: assigned [mem=0A=
0xe1400000-0xe1403fff 64bit]=0A=
[  117.781613] pcieport 0000:b0:05.0: PCI bridge to [bus b2]=0A=
[  117.781620] pcieport 0000:b0:05.0:   bridge window [mem=0A=
0xe1400000-0xe14fffff]=0A=
[  117.781626] pcieport 0000:b0:05.0:   bridge window [mem=0A=
0x386000200000-0x3860003fffff 64bit pref]=0A=
[  117.782498] nvme nvme3: pci function 0000:b2:00.0=0A=
[  117.782530] nvme 0000:b2:00.0: enabling device (0000 -> 0002)=0A=
[  117.800846] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802=0A=
[  117.800883] pci 0000:b1:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit=
]=0A=
[  117.800927] pci 0000:b1:00.0: Max Payload Size set to 256 (was 128,=0A=
max 512)=0A=
[  117.800932] pci 0000:b1:00.0: enabling Extended Tags=0A=
[  117.801564] pcieport 0000:b0:04.0: bridge window [io  0x1000-0x0fff]=0A=
to [bus b1] add_size 1000=0A=
[  117.801571] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.801574] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.801577] pcieport 0000:b0:04.0: BAR 13: no space for [io  size 0x1000=
]=0A=
[  117.801580] pcieport 0000:b0:04.0: BAR 13: failed to assign [io  size=0A=
0x1000]=0A=
[  117.801587] pci 0000:b1:00.0: BAR 0: assigned [mem=0A=
0xe1500000-0xe1503fff 64bit]=0A=
[  117.801599] pcieport 0000:b0:04.0: PCI bridge to [bus b1]=0A=
[  117.801606] pcieport 0000:b0:04.0:   bridge window [mem=0A=
0xe1500000-0xe15fffff]=0A=
[  117.801612] pcieport 0000:b0:04.0:   bridge window [mem=0A=
0x386000000000-0x3860001fffff 64bit pref]=0A=
[  117.802362] nvme nvme4: pci function 0000:b1:00.0=0A=
[  117.802390] nvme 0000:b1:00.0: enabling device (0000 -> 0002)=0A=
[  117.896666] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present=0A=
[  117.896844] pciehp 0000:b0:05.0:pcie204: Slot(179): Card not present=0A=
[  117.896944] pciehp 0000:3c:06.0:pcie204: Slot(180): Card not present=0A=
[  120.225239] nvme nvme2: Shutdown timeout set to 10 seconds=0A=
[  120.225299] nvme nvme3: Shutdown timeout set to 10 seconds=0A=
[  121.336917] nvme nvme4: failed to mark controller CONNECTING=0A=
[  121.336922] nvme nvme4: Removing after probe failure status: 0=0A=
[  121.353534] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present=0A=
[  121.353538] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up=0A=
[  121.368290] list_add double add: new=3Dffff956b64c0c658,=0A=
prev=3Dffff956b64c0c658, next=3Dffff956f6f2ddfe0.=0A=
[  121.368310] ------------[ cut here ]------------=0A=
[  121.368312] kernel BUG at lib/list_debug.c:31!=0A=
[  121.372769] invalid opcode: 0000 [#1] SMP PTI=0A=
[  121.377132] CPU: 7 PID: 628 Comm: irq/45-pciehp Not tainted 5.0.0 #216=
=0A=
[  121.383662] Hardware name: Dell Inc. PowerEdge R740xd/07X9K0, BIOS=0A=
1.4.4 [Recoverable-Unmask] 03/09/2018=0A=
[  121.393137] RIP: 0010:__list_add_valid+0x41/0x50=0A=
[  121.397751] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01=0A=
00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 50 25 12 af e8 1d 2e c9=0A=
ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08=0A=
[  121.416495] RSP: 0018:ffffbe9708f9bbf0 EFLAGS: 00010046=0A=
[  121.421723] RAX: 0000000000000058 RBX: ffff956f6f2ddfe0 RCX:=0A=
0000000000000000=0A=
[  121.428854] RDX: 0000000000000000 RSI: ffff956f6f2d6908 RDI:=0A=
ffff956f6f2d6908=0A=
[  121.435986] RBP: ffff956b64c0c600 R08: 000000000000087c R09:=0A=
0000000000000003=0A=
[  121.443118] R10: 0000000000000000 R11: 0000000000000001 R12:=0A=
ffff956b64c0c658=0A=
[  121.450250] R13: 0000000000000282 R14: ffff956b64c0c658 R15:=0A=
0000000000000000=0A=
[  121.457383] FS:  0000000000000000(0000) GS:ffff956f6f2c0000(0000)=0A=
knlGS:0000000000000000=0A=
[  121.465468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[  121.471212] CR2: 00007f77870ba068 CR3: 000000083389e004 CR4:=0A=
00000000007606e0=0A=
[  121.478345] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=0A=
0000000000000000=0A=
[  121.485477] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=0A=
0000000000000400=0A=
[  121.492610] PKRU: 55555554=0A=
[  121.495320] Call Trace:=0A=
[  121.497780]  __blk_complete_request+0x74/0x110=0A=
[  121.502222]  blk_mq_complete_request+0xb6/0x100=0A=
[  121.506759]  nvme_cancel_request+0x27/0x70 [nvme_core]=0A=
[  121.511896]  blk_mq_tagset_busy_iter+0x203/0x270=0A=
[  121.516510]  ? nvme_complete_rq+0x210/0x210 [nvme_core]=0A=
[  121.521736]  ? nvme_complete_rq+0x210/0x210 [nvme_core]=0A=
[  121.526964]  nvme_dev_disable+0xfb/0x1d0 [nvme]=0A=
[  121.531493]  nvme_remove+0x12c/0x170 [nvme]=0A=
[  121.535681]  pci_device_remove+0x3b/0xc0=0A=
[  121.539608]  device_release_driver_internal+0x183/0x240=0A=
[  121.544834]  pci_stop_bus_device+0x69/0x90=0A=
[  121.548931]  pci_stop_and_remove_bus_device+0xe/0x20=0A=
[  121.553899]  pciehp_unconfigure_device+0x84/0x140=0A=
[  121.558608]  pciehp_disable_slot+0x67/0x110=0A=
[  121.562796]  pciehp_handle_presence_or_link_change+0x25f/0x400=0A=
[  121.568630]  ? __synchronize_hardirq+0x43/0x50=0A=
[  121.573074]  pciehp_ist+0x1bb/0x1c0=0A=
[  121.576567]  ? irq_finalize_oneshot.part.43+0xe0/0xe0=0A=
[  121.581617]  irq_thread_fn+0x1f/0x60=0A=
[  121.585198]  irq_thread+0xe7/0x170=0A=
[  121.588602]  ? irq_forced_thread_fn+0x70/0x70=0A=
[  121.592963]  ? irq_thread_check_affinity+0x90/0x90=0A=
[  121.597754]  kthread+0x112/0x130=0A=
[  121.600987]  ? kthread_create_on_node+0x60/0x60=0A=
[  121.605521]  ret_from_fork+0x35/0x40=0A=
[  121.609098] Modules linked in: xt_CHECKSUM ipt_MASQUERADE tun bridge=0A=
stp llc ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack=0A=
ebtable_nat ip6table_nat nf_nat_ipv6 ip6table_mangle ip6table_raw=0A=
ip6table_security iptable_nat nf_nat_ipv4 nf_nat devlink iptable_mangle=0A=
iptable_raw iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4=0A=
ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables=0A=
sunrpc f2fs vfat fat intel_rapl skx_edac nfit x86_pkg_temp_thermal=0A=
intel_powerclamp coretemp kvm_intel kvm ses enclosure irqbypass=0A=
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_cstate joydev=0A=
iTCO_wdt iTCO_vendor_support ipmi_ssif dcdbas intel_uncore=0A=
intel_rapl_perf mei_me pcspkr i2c_i801 mei ioatdma lpc_ich ipmi_si=0A=
ipmi_devintf ipmi_msghandler acpi_power_meter raid1 dm_raid raid456=0A=
libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx=0A=
raid6_pq mgag200 drm_kms_helper ttm drm mpt3sas igb nvme crc32c_intel=0A=
raid_class nvme_core uas scsi_transport_sas usb_storage=0A=
[  121.609134]  dca i2c_algo_bit=0A=
[  121.699398] ---[ end trace 8704317f268b2403 ]---=0A=
[  121.743228] RIP: 0010:__list_add_valid+0x41/0x50=0A=
[  121.747858] Code: 85 94 00 00 00 48 39 c7 74 0b 48 39 d7 74 06 b8 01=0A=
00 00 00 c3 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 50 25 12 af e8 1d 2e c9=0A=
ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8b 07 48 8b 57 08=0A=
[  121.766601] RSP: 0018:ffffbe9708f9bbf0 EFLAGS: 00010046=0A=
[  121.771827] RAX: 0000000000000058 RBX: ffff956f6f2ddfe0 RCX:=0A=
0000000000000000=0A=
[  121.778958] RDX: 0000000000000000 RSI: ffff956f6f2d6908 RDI:=0A=
ffff956f6f2d6908=0A=
[  121.786089] RBP: ffff956b64c0c600 R08: 000000000000087c R09:=0A=
0000000000000003=0A=
[  121.793222] R10: 0000000000000000 R11: 0000000000000001 R12:=0A=
ffff956b64c0c658=0A=
[  121.800353] R13: 0000000000000282 R14: ffff956b64c0c658 R15:=0A=
0000000000000000=0A=
[  121.807487] FS:  0000000000000000(0000) GS:ffff956f6f2c0000(0000)=0A=
knlGS:0000000000000000=0A=
[  121.815573] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
[  121.821319] CR2: 00007f77870ba068 CR3: 000000083389e004 CR4:=0A=
00000000007606e0=0A=
[  121.828448] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=0A=
0000000000000000=0A=
[  121.835583] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:=0A=
0000000000000400=0A=
[  121.842713] PKRU: 55555554=0A=
[  121.845506] nvme nvme3: IO queues not created=0A=
[  121.849891] nvme nvme3: failed to mark controller state 2=0A=
[  121.855298] nvme nvme3: Removing after probe failure status: 0=0A=
[  124.879721] md/raid1:md126: active with 1 out of 2 mirrors=0A=
[  124.885245] md126: failed to create bitmap (-5)=0A=
