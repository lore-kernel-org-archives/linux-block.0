Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C83C47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B11961249
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 06:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhFIGzj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:55:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35418 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhFIGzi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 02:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623221624; x=1654757624;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=PKUzrXJrIQgJ4aGmOrOqH+82oPegHgeJms/0PMjgwgo=;
  b=QJk1Wpv+IRG2fKt96iv7baimZxwSUTCd3dhT7S8UJapYRstET+FG6PRF
   efYi8Nk6EimQWjd/D9irIz1/crqwWvpG8q+dJR8jihQ7FblBR6DsoLBop
   rKjOMAdU8D1/HRfW6eo8AqMG6Nv8oFBjyGiI18tDF4Lg3ayIgE6N0+3dv
   0gHPjppkzBQfrYklz9XzPBgVU1WdVC0C0rYZZvXoTH44QPAy4ggbKM23p
   JPlL0ojBSDCB9zdR1MO/eZDAE2mvvCTm6Hy3LwEGrl6KBRPZjdzahhQd+
   z/issuiF3TYLF6AH5HlxAvke6yXt+t219Ud2gtoTuD4aCZfK7E1NbmL2O
   A==;
IronPort-SDR: Lp7QcEFq5aqwAxJwE4T/ek8rG7TNEsLq8Eaz0axp+eEAihvGm4Zh/1yBcBPkKnQPtBl7NnBU46
 YwasB+J04hmayZfVJuB+B0ODoOX2k5mUC2JElk6GI691A1G9OGkl6+VQj+XwkIflsk9QLt+zMv
 rsVFgs67d6ou6KCllOIGGYoau0NGuCnlc3pcg77lQKjsxyTivwUp86THwuKZ24STDT65KDyQEO
 KHMk+kHvv5st9ShZ54wVMrKLJdAPeorbgvh5IrI8/54VLkKUYxrgqEg7w1RVqsn3txzR9/m6CV
 REU=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="170542276"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 14:53:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN6qZW9crJRpqWPwvQMBwEk6VcnGaDrd5r2w37o4puazShhpc1eJ26SsEOZBFBUPh8DGWn9GZnspydBWCs36Tw6inClOr1ALVLvZECwoQHmdFPLZZPPjDsulZpzE3lHfTPBZoubDzcIpONbCGqtcne7kDew47uB5dW2V4J978MFF8XcTLQEjWXg7gjIgYklhtJVu7Y5WDYSke7L6b4mIq01l7srDSPVOuM6UvaG/PX0wtfb5OHyMrgRKmou1Cu98/d6vAVvMG1Ei/URBTmxtH/vmLovSQVE1FyxzB/IoI4/saZz5k1p/mGloXDTXIC1e9XGJWsdMmOX9CfOLH1tnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdmMK+zF8bKiGrqRca5hfaJYSD7abukNzxpNPANNqR0=;
 b=W3G1Vt5ql0MXC3Z6nPJzAzdya5GNhmnv3e6Y8SqI2dcOaZJykV92H1d++KF5jOF3EMxsraYGSprvlv8qYjDYgGkCe4Mx/OqUuP8lt4RBxbdOUw19DwvxyMGHvK1W+JJ12G8OlM9+GqvN0gWH/FhYzjaK1CVjB5LOG0EkJgHbHdrdcVrWltdeYVbMJrbiyvsgFQyK5KcFq0LZOjxpX4vnGx8Iyei/FgrOcn6Af/PblikFD5MAR1gTwXP+TbXAjec2+Babsg+8ALHVAENhajqb0lJEUSIe11x+h0o4ZOxhgdJ7GULLJpdO33qioED1O5rMCUg2mGj5KSedOX095UlJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdmMK+zF8bKiGrqRca5hfaJYSD7abukNzxpNPANNqR0=;
 b=L2m/4y2npG45S/JYNfbEENM80xwrYVn2+H7W2uVoMlxBXXASh5IFrhxhNWVKPSrsW0AqEWWjz33ajXGGw2imPdxZg/ktmr7NFXVutFj16pdxbscl7swRF7HVDIQmzaqZ+se08p1lW7CmJR0J/MsP//Y9Eap9AtWlvxbrb5LTm4E=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB6040.namprd04.prod.outlook.com (2603:10b6:a03:e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 06:53:39 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::84d7:af4e:7223:2f2]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::84d7:af4e:7223:2f2%3]) with mapi id 15.20.4219.022; Wed, 9 Jun 2021
 06:53:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Topic: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Index: AQHXXPwtp5wIJLz/bUO+HXbRCV2UYw==
Date:   Wed, 9 Jun 2021 06:53:39 +0000
Message-ID: <20210609065339.aecrkqc6dj3xgbiw@shindev.dhcp.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfbb6872-5730-449a-b32f-08d92b13502f
x-ms-traffictypediagnostic: BYAPR04MB6040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB60400D31713FD083ABA96202ED369@BYAPR04MB6040.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUy7kfk5q5ih+qV1JRW5tuLzgFb7L4yEeISCz/jm33it1fMndCljf6t7mlMT/sELEaxndlKIKbn5nPLd/ij7gJpv5Mxrina2xGMsmJlh5njuj1GWH7EVpnF7McoLgwwFv6VL/85UPXjO70oGo3CQQH4loskwxdrdFg+ogp5D+J4A/MrtRM2Zz11JOXVjkKFVy74PAs/s1Jy5uQM8nkFL10farWtZQu1AMp6HZnuG7aZcRLbK1EB8GWBnAuq9WKvPZllRyi9bxYTwjGeClrVSMwkqL6BiDHvnndqjxWaUBf8QvE0N99NarJX93h68+ukHJ3lqYeltRfexh232knqCJQWUoj89C/2a554TVVVplX94gs6g/eHlVfIsk4KtIC1FcTI7TzyerIVVXiQeW545o7TSmtH+veA2pproAZsrGNDv1gBuFu4Z5/tEw7UL/rhjWpfgE65bGXWvdNTHnza4EjLvU7Oov1Y2NTq0dJrvXNcp7c1S1wBstnDLjZSEkftT3lcuLnlm7UTEYcu/F1sKwhM/oRQh1u8fJWD+gN+eszEr3871sv3yW8cJkIWGWNRh2xX9Dsu8iQoFbRVyff3i/xW2BV0cal7gneQuM2FLocaxa27DnGQ6urryRZk7ERkCrGveUCo0NpSpMmz+D0C47w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(186003)(91956017)(6916009)(83380400001)(38100700002)(4326008)(122000001)(76116006)(86362001)(66946007)(66446008)(64756008)(66476007)(66556008)(71200400001)(5660300002)(8676002)(6506007)(44832011)(316002)(6486002)(478600001)(45080400002)(8936002)(9686003)(6512007)(30864003)(1076003)(2906002)(26005)(58493002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jvhnWPsAYQeXpuNX56CXqs4gKlnMghhdAex3fZJuMmAplP0zNtEXEbD5ETrI?=
 =?us-ascii?Q?8BLXv9fvXCj5oqD8hPQ3lwI2SmLwdiWv2WhgSFuQ61dLW59fx9Y9UxTJQ7OY?=
 =?us-ascii?Q?49IfgiiLq0pzOWXriEPeIp3937wL4qWvWwB7aDfBi8XvtpeIqgauxoq1q9eN?=
 =?us-ascii?Q?LFxGAbzlq9gMeMxrqKE67F5urN/Ii4Nb5jCkwMfYhoc4imxsjve6XDyQdl26?=
 =?us-ascii?Q?/n6QcPJFf/UEhqPoBOlE4R6rVwdrVcX1xhWxIsIoV+EslAzw/EKsovkoTLAm?=
 =?us-ascii?Q?totzDcfLV1fY7k9CmUl3JhHPoFVEmF+iNaIFUOPmB9AMmmC1A8EVOvxiMe9g?=
 =?us-ascii?Q?B1KFVRvGiUB4SYvARflu/eLNa18gb0jJYyGiC4WMhGF7cdZtC7YheCFRTPM0?=
 =?us-ascii?Q?E1R3M+Ex9woC7hFdSDqpBEJyfE0/VM+HLA+rCR/NNPAiqoz5UazDR7zgaCCU?=
 =?us-ascii?Q?b0v1ZvnnbovcFeksAeJ0q1t1BrFl8vrSYcFbsbWhzmiaEbnURV/S12FMr1kL?=
 =?us-ascii?Q?7W+cuzdlqQWnm9aLVs7RsejwAoblr8CrnD08Hwoxlhld85xCjG/C+dv6SFSu?=
 =?us-ascii?Q?CI0b/F5GOhGadrTU7hrrZEH3tC3wEo6MAmn7SXnSz7x6LGR+68Oa3zd15NXU?=
 =?us-ascii?Q?CjK5tKgmh7a3oBJUkz4YhbeP0VZQs+doqobAowM7dtfXFBklvqaI4uMxQWnB?=
 =?us-ascii?Q?uTAbUo7YikhF+cn1qXGR02tKTrpOFO4MZG9asXk7YU3Vnltc2f+8yDHGgRx9?=
 =?us-ascii?Q?JbDc0M/PeVNzmOAlIhvHFZfLUdD9FmB4iDllhnsYhIQPgBDALQrfd4aNhqOy?=
 =?us-ascii?Q?JmDSyD5VdYS7ZP0+WE+FF1fm8j24v+kdsyOXRw7yVOrk1AYhZckT3UR2PBOU?=
 =?us-ascii?Q?7QVo8yzEbshgTeCWQH2mOumgDLlvPUbfIZGU3qoXuJ4FC0nfyrWJr3PJzykk?=
 =?us-ascii?Q?tQXdFi8Cu/pjJcNUF26AZ64I7mx1eQP/dyL+CVMShMUDSjAckeyXSWMnQcVh?=
 =?us-ascii?Q?0FOjn3sKOMUruQvGl1vjl83ScDQJRUQQD89c5uavMmvIv2dD9hdeSibGI2yc?=
 =?us-ascii?Q?r0jXmlwH7p/O0pJ4R5g5LPlLtNUv14ghs2V2kWHYxYBQOWK2WK8whiKiPqr8?=
 =?us-ascii?Q?tbasqe4lntHkisYYRt1sHv0W0YgTTaorVCayATnChHOy1T+Ik3OUX4Q62ocI?=
 =?us-ascii?Q?ZYUfcsDDvnXba3+DgzEqFD08hr/davX0pvqlIUcl4ec9y3p9jKvURSMhKqZY?=
 =?us-ascii?Q?I/BU9xCF2kIwiUnKYBpPCxW1gbNeMrcywuPib+gRuZAZn3PuEtkzlVtB9Bi/?=
 =?us-ascii?Q?YC+l8dVGXBEHaORh7mm7vGAX5jTrnKGROoaRFPTEeHYhkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <532971FF7C88484E8507FDDCE8BB472D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb6872-5730-449a-b32f-08d92b13502f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 06:53:39.8067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JV6J4s8iCsYQPZLPR58h57MzwDP5rc9aI7cCwgYzFsp+AqzljavE1fJW+8z/NLWpNgIoimXWzlHMkJSv5gHpldprogZyVd1Bomqz5tX61A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6040
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi there,

Let me share a blktests failure. When I ran blktests on the kernel v5.13-rc=
5,
block/008 failed. A WARNING below was the cause of the failure.

    WARNING: CPU: 1 PID: 135817 at kernel/sched/core.c:3175 ttwu_queue_wake=
list+0x284/0x2f0

I'm trying to recreate the failure repeating the test case, but so far, I a=
m not
able to. This failure looks rare, but actually, I observed it 3 times in th=
e
past one year.

1) Oct/2020, kernel: v5.9-rc7  test dev: dm-flakey on AHCI-SATA SMR HDD, lo=
g [1]
2) Mar/2021, kernel: v5.12-rc2 test dev: AHCI-SATA SMR HDD,              lo=
g [2]
3) Jun/2021, kernel: v5.13-rc5 test dev: dm-linear on null_blk zoned,    lo=
g [3]

The test case block/008 does IO during CPU hotplug, and the WARNING in
ttwu_queue_wakelist() checks "WARN_ON_ONCE(cpu =3D=3D smp_processor_id())".
So it is likely that the test case triggers the warning, but I don't have
clear view why and how the warning was triggered. It was observed on variou=
s
block devices, so I would like to ask linux-block experts if anyone can tel=
l
what is going on. Comments will be appreciated.


[1]

[29603.810633][T127266] ------------[ cut here ]------------
[29603.816381][T127266] WARNING: CPU: 4 PID: 127266 at kernel/sched/core.c:=
2670 ttwu_queue_wakelist+0x27c/0x2b0
[29603.826198][T127266] Modules linked in: dm_flakey iscsi_target_mod tcm_l=
oop target_core_pscsi target_core_file target_core_iblock xt_CHECKSUM xt_MA=
SQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge s=
tp llc nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_in=
et nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reje=
ct_ipv6 nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_brout=
e ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat n=
f_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle i=
ptable_raw iptable_security target_core_user rfkill target_core_mod ip_set =
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter=
 sunrpc intel_rapl_msr iTCO_wdt iTCO_vendor_support intel_rapl_common x86_p=
kg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cst=
ate intel_uncore joydev pcspkr i2c_i801 i2c_smbus mei_me mei lpc_ich ses en=
closure ioatdma wmi
[29603.826259][T127266]  ipmi_ssif ipmi_si ipmi_devintf ipmi_msghandler acp=
i_power_meter acpi_pad ip_tables drm_vram_helper drm_kms_helper crct10dif_p=
clmul drm_ttm_helper crc32_pclmul ttm crc32c_intel drm ghash_clmulni_intel =
igb mpt3sas nvme dca nvme_core i2c_algo_bit raid_class scsi_transport_sas f=
use [last unloaded: null_blk]
[29603.941330][T127266] CPU: 4 PID: 127266 Comm: fio Not tainted 5.9.0-rc7 =
#1
[29603.948201][T127266] Hardware name: Supermicro Super Server/X10SRL-F, BI=
OS 2.0 12/17/2015
[29603.956368][T127266] RIP: 0010:ttwu_queue_wakelist+0x27c/0x2b0
[29603.962198][T127266] Code: 89 e7 e8 37 5d 60 00 e9 2c fe ff ff e8 3d 5d =
60 00 e9 f0 fd ff ff e8 53 5d 60 00 e9 41 ff ff ff e8 89 5d 60 00 e9 7b ff =
ff ff <0f> 0b e9 a6 fe ff ff 48 89 04 24 e8 04 5d 60 00 48 8b 04 24 e9 8e
[29603.981715][T127266] RSP: 0018:ffff88856b3ef3f0 EFLAGS: 00010046
[29603.987714][T127266] RAX: 0000000000000004 RBX: ffff88861ad21200 RCX: ff=
ff88861ad00000
[29603.995616][T127266] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ff=
ffffff98dfe920
[29604.003521][T127266] RBP: 0000000000000000 R08: 0000000000000004 R09: ff=
ffffff9988a227
[29604.011425][T127266] R10: fffffbfff3311444 R11: 0000000000000001 R12: 00=
00000000000004
[29604.019330][T127266] R13: ffff8886035b8000 R14: 0000000000000004 R15: ff=
ffffff98dfe920
[29604.027235][T127266] FS:  00007f43b1067a40(0000) GS:ffff88861ad00000(000=
0) knlGS:0000000000000000
[29604.036099][T127266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[29604.042618][T127266] CR2: 00007f2a8eeeb421 CR3: 000000057abf2001 CR4: 00=
000000001706e0
[29604.050523][T127266] Call Trace:
[29604.053757][T127266]  ? lock_is_held_type+0xbb/0xf0
[29604.058640][T127266]  ? rcu_read_lock_sched_held+0x3f/0x80
[29604.064123][T127266]  try_to_wake_up+0x4f0/0x1420
[29604.068831][T127266]  ? migrate_swap_stop+0x970/0x970
[29604.073882][T127266]  ? insert_work+0x18b/0x2d0
[29604.078417][T127266]  __queue_work+0x4f2/0xe90
[29604.082863][T127266]  ? try_to_grab_pending.part.0+0x23/0x530
[29604.088604][T127266]  ? lockdep_hardirqs_off+0x80/0xb0
[29604.093738][T127266]  mod_delayed_work_on+0x9a/0x110
[29604.098703][T127266]  ? cancel_delayed_work_sync+0x10/0x10
[29604.104182][T127266]  ? __blk_mq_delay_run_hw_queue+0x95/0x570
[29604.110019][T127266]  kblockd_mod_delayed_work_on+0x17/0x20
[29604.115586][T127266]  blk_mq_run_hw_queue+0x125/0x270
[29604.120630][T127266]  ? blk_mq_delay_run_hw_queues+0x150/0x150
[29604.126459][T127266]  blk_mq_sched_insert_request+0x2d4/0x5f0
[29604.132201][T127266]  ? __blk_mq_sched_bio_merge+0x440/0x440
[29604.137863][T127266]  blk_mq_submit_bio+0xaa4/0x14e0
[29604.142828][T127266]  ? blk_mq_try_issue_directly+0x120/0x120
[29604.148577][T127266]  ? percpu_ref_put_many.constprop.0+0x83/0x150
[29604.154757][T127266]  ? dm_wq_work+0x210/0x210
[29604.159201][T127266]  submit_bio_noacct+0x6b9/0xc30
[29604.164078][T127266]  ? lock_is_held_type+0xbb/0xf0
[29604.168960][T127266]  ? bio_associate_blkg_from_css+0x1c6/0xb00
[29604.174877][T127266]  ? blk_queue_enter+0x7c0/0x7c0
[29604.179762][T127266]  submit_bio+0xe4/0x480
[29604.183943][T127266]  ? submit_bio_noacct+0xc30/0xc30
[29604.188999][T127266]  ? bio_add_pc_page+0xd0/0xd0
[29604.193702][T127266]  ? bio_release_pages.part.0+0x10c/0x3d0
[29604.199367][T127266]  __blkdev_direct_IO_simple+0x41f/0x7a0
[29604.204938][T127266]  ? bd_link_disk_holder+0x780/0x780
[29604.210160][T127266]  ? mark_lock+0x82/0x1470
[29604.214522][T127266]  ? __lock_acquire+0xb66/0x5400
[29604.219400][T127266]  ? bd_may_claim+0xc0/0xc0
[29604.223847][T127266]  ? __lock_acquire+0x1603/0x5400
[29604.228811][T127266]  blkdev_direct_IO+0xd6a/0x1070
[29604.233690][T127266]  ? mark_lock+0x82/0x1470
[29604.238053][T127266]  ? __lock_acquire+0x1603/0x5400
[29604.243016][T127266]  ? bd_prepare_to_claim+0x220/0x220
[29604.248247][T127266]  ? lockdep_hardirqs_on_prepare+0x4f0/0x4f0
[29604.254164][T127266]  generic_file_read_iter+0x1f4/0x470
[29604.259477][T127266]  new_sync_read+0x350/0x5d0
[29604.264007][T127266]  ? vfs_dedupe_file_range+0x5c0/0x5c0
[29604.269414][T127266]  ? inode_security+0x56/0xf0
[29604.274032][T127266]  vfs_read+0x296/0x4a0
[29604.278126][T127266]  __x64_sys_pread64+0x17d/0x1d0
[29604.283004][T127266]  ? vfs_read+0x4a0/0x4a0
[29604.287271][T127266]  ? trace_hardirqs_on+0x20/0x170
[29604.292238][T127266]  do_syscall_64+0x33/0x40
[29604.296593][T127266]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[29604.302421][T127266] RIP: 0033:0x7f43baf6924f
[29604.306778][T127266] Code: 08 89 3c 24 48 89 4c 24 18 e8 ed f3 ff ff 4c =
8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 1d f4 ff ff 48 8b
[29604.326303][T127266] RSP: 002b:00007ffec6c62e60 EFLAGS: 00000293 ORIG_RA=
X: 0000000000000011
[29604.334648][T127266] RAX: ffffffffffffffda RBX: 00000000011fc540 RCX: 00=
007f43baf6924f
[29604.342554][T127266] RDX: 0000000000001000 RSI: 00000000012ac000 RDI: 00=
00000000000008
[29604.350459][T127266] RBP: 00000000011fc540 R08: 0000000000000000 R09: 00=
007ffec6d7b1b0
[29604.358370][T127266] R10: 0000000001936000 R11: 0000000000000293 R12: 00=
007f43576f4d20
[29604.366276][T127266] R13: 0000000000000000 R14: 0000000000001000 R15: 00=
000000011fc568
[29604.374188][T127266] irq event stamp: 78824
[29604.378368][T127266] hardirqs last  enabled at (78823): [<ffffffff963c45=
50>] ktime_get+0x150/0x190
[29604.387318][T127266] hardirqs last disabled at (78824): [<ffffffff962395=
67>] mod_delayed_work_on+0xd7/0x110
[29604.397045][T127266] softirqs last  enabled at (78564): [<ffffffff982010=
92>] asm_call_irq_on_stack+0x12/0x20
[29604.406861][T127266] softirqs last disabled at (78555): [<ffffffff982010=
92>] asm_call_irq_on_stack+0x12/0x20
[29604.416673][T127266] ---[ end trace effce0b470837a17 ]---
[29604.422074][    C4]=20
[29604.422075][    C4] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[29604.422076][    C4] WARNING: possible circular locking dependency detect=
ed
[29604.422077][    C4] 5.9.0-rc7 #1 Not tainted
[29604.422078][    C4] ----------------------------------------------------=
--
[29604.422079][    C4] fio/127266 is trying to acquire lock:
[29604.422079][    C4] ffffffff9913a678 ((console_sem).lock){-.-.}-{2:2}, a=
t: down_trylock+0x13/0x70
[29604.422083][    C4]=20
[29604.422083][    C4] but task is already holding lock:
[29604.422084][    C4] ffff8886035b8c38 (&p->pi_lock){-.-.}-{2:2}, at: try_=
to_wake_up+0x84/0x1420
[29604.422087][    C4]=20
[29604.422088][    C4] which lock already depends on the new lock.
[29604.422088][    C4]=20
[29604.422089][    C4]=20
[29604.422090][    C4] the existing dependency chain (in reverse order) is:
[29604.422090][    C4]=20
[29604.422091][    C4] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[29604.422094][    C4]        _raw_spin_lock_irqsave+0x48/0x60
[29604.422095][    C4]        try_to_wake_up+0x84/0x1420
[29604.422095][    C4]        up+0x7a/0xb0
[29604.422096][    C4]        __up_console_sem+0x3c/0x70
[29604.422097][    C4]        console_unlock+0x451/0xa10
[29604.422098][    C4]        vprintk_emit+0x232/0x510
[29604.422099][    C4]        devkmsg_emit.constprop.0+0x97/0xb3
[29604.422100][    C4]        devkmsg_write.cold+0x48/0x74
[29604.422101][    C4]        do_iter_readv_writev+0x34c/0x6d0
[29604.422102][    C4]        do_iter_write+0x137/0x5d0
[29604.422102][    C4]        vfs_writev+0x14a/0x280
[29604.422103][    C4]        do_writev+0x100/0x260
[29604.422104][    C4]        do_syscall_64+0x33/0x40
[29604.422105][    C4]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[29604.422106][    C4]=20
[29604.422106][    C4] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[29604.422110][    C4]        __lock_acquire+0x29e4/0x5400
[29604.422111][    C4]        lock_acquire+0x18f/0x990
[29604.422112][    C4]        _raw_spin_lock_irqsave+0x48/0x60
[29604.422113][    C4]        down_trylock+0x13/0x70
[29604.422114][    C4]        __down_trylock_console_sem+0x33/0xb0
[29604.422115][    C4]        vprintk_emit+0x203/0x510
[29604.422115][    C4]        printk+0x96/0xb2
[29604.422116][    C4]        report_bug.cold+0x31/0x5e
[29604.422117][    C4]        handle_bug+0x3d/0xa0
[29604.422118][    C4]        exc_invalid_op+0x14/0x40
[29604.422119][    C4]        asm_exc_invalid_op+0x12/0x20
[29604.422120][    C4]        ttwu_queue_wakelist+0x27c/0x2b0
[29604.422121][    C4]        try_to_wake_up+0x4f0/0x1420
[29604.422122][    C4]        __queue_work+0x4f2/0xe90
[29604.422122][    C4]        mod_delayed_work_on+0x9a/0x110
[29604.422124][    C4]        kblockd_mod_delayed_work_on+0x17/0x20
[29604.422124][    C4]        blk_mq_run_hw_queue+0x125/0x270
[29604.422125][    C4]        blk_mq_sched_insert_request+0x2d4/0x5f0
[29604.422126][    C4]        blk_mq_submit_bio+0xaa4/0x14e0
[29604.422127][    C4]        submit_bio_noacct+0x6b9/0xc30
[29604.422128][    C4]        submit_bio+0xe4/0x480
[29604.422129][    C4]        __blkdev_direct_IO_simple+0x41f/0x7a0
[29604.422130][    C4]        blkdev_direct_IO+0xd6a/0x1070
[29604.422131][    C4]        generic_file_read_iter+0x1f4/0x470
[29604.422132][    C4]        new_sync_read+0x350/0x5d0
[29604.422133][    C4]        vfs_read+0x296/0x4a0
[29604.422134][    C4]        __x64_sys_pread64+0x17d/0x1d0
[29604.422135][    C4]        do_syscall_64+0x33/0x40
[29604.422135][    C4]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[29604.422136][    C4]=20
[29604.422137][    C4] other info that might help us debug this:
[29604.422138][    C4]=20
[29604.422139][    C4]  Possible unsafe locking scenario:
[29604.422139][    C4]=20
[29604.422140][    C4]        CPU0                    CPU1
[29604.422141][    C4]        ----                    ----
[29604.422142][    C4]   lock(&p->pi_lock);
[29604.422144][    C4]                                lock((console_sem).lo=
ck);
[29604.422146][    C4]                                lock(&p->pi_lock);
[29604.422148][    C4]   lock((console_sem).lock);
[29604.422149][    C4]=20
[29604.422150][    C4]  *** DEADLOCK ***
[29604.422151][    C4]=20
[29604.422152][    C4] 3 locks held by fio/127266:
[29604.422152][    C4]  #0: ffffffff99159260 (rcu_read_lock){....}-{1:2}, a=
t: __queue_work+0xa0/0xe90
[29604.422156][    C4]  #1: ffff88861ad33a58 (&pool->lock){-.-.}-{2:2}, at:=
 __queue_work+0x2d3/0xe90
[29604.422159][    C4]  #2: ffff8886035b8c38 (&p->pi_lock){-.-.}-{2:2}, at:=
 try_to_wake_up+0x84/0x1420
[29604.422163][    C4]=20
[29604.422164][    C4] stack backtrace:
[29604.422165][    C4] CPU: 4 PID: 127266 Comm: fio Not tainted 5.9.0-rc7 #=
1
[29604.422166][    C4] Hardware name: Supermicro Super Server/X10SRL-F, BIO=
S 2.0 12/17/2015
[29604.422167][    C4] Call Trace:
[29604.422168][    C4]  dump_stack+0xae/0xe8
[29604.422169][    C4]  check_noncircular+0x2fc/0x3b0
[29604.422169][    C4]  ? print_circular_bug+0x370/0x370
[29604.422170][    C4]  ? stack_trace_save+0x81/0xa0
[29604.422171][    C4]  ? lock_repin_lock+0x370/0x370
[29604.422172][    C4]  __lock_acquire+0x29e4/0x5400
[29604.422173][    C4]  ? lockdep_hardirqs_on_prepare+0x4f0/0x4f0
[29604.422174][    C4]  lock_acquire+0x18f/0x990
[29604.422174][    C4]  ? down_trylock+0x13/0x70
[29604.422175][    C4]  ? sched_clock_cpu+0x18/0x170
[29604.422176][    C4]  ? lock_release+0x7c0/0x7c0
[29604.422177][    C4]  ? find_held_lock+0x2c/0x110
[29604.422178][    C4]  ? vprintk_emit+0x1ba/0x510
[29604.422179][    C4]  _raw_spin_lock_irqsave+0x48/0x60
[29604.422179][    C4]  ? down_trylock+0x13/0x70
[29604.422180][    C4]  down_trylock+0x13/0x70
[29604.422181][    C4]  ? printk+0x96/0xb2
[29604.422182][    C4]  __down_trylock_console_sem+0x33/0xb0
[29604.422183][    C4]  vprintk_emit+0x203/0x510
[29604.422183][    C4]  ? ttwu_queue_wakelist+0x27c/0x2b0
[29604.422184][    C4]  printk+0x96/0xb2
[29604.422185][    C4]  ? log_store.cold+0x11/0x11
[29604.422187][    C4]  ? mark_lock+0x82/0x1470
[29604.422188][    C4]  report_bug.cold+0x31/0x5e
[29604.422189][    C4]  handle_bug+0x3d/0xa0
[29604.422190][    C4]  ? lock_acquire+0x18f/0x990
[29604.422191][    C4]  exc_invalid_op+0x14/0x40
[29604.422191][    C4]  asm_exc_invalid_op+0x12/0x20
[29604.422192][    C4] RIP: 0010:ttwu_queue_wakelist+0x27c/0x2b0
[29604.422193][    C4] Code: 89 e7 e8 37 5d 60 00 e9 2c fe ff ff e8 3d 5d 6=
0 00 e9 f0 fd ff ff e8 53 5d 60 00 e9 41 ff ff ff e8 89 5d 60 00 e9 7b ff f=
f ff <0f> 0b e9 a6 fe ff ff 48 89 04 24 e8 04 5d 60 00 48 8b 04 24 e9 8e
[29604.422194][    C4] RSP: 0018:ffff88856b3ef3f0 EFLAGS: 00010046
[29604.422195][    C4] RAX: 000000000
[29604.422197][    C4] Lost 62 message(s)!


[2]

[ 8339.653610][    C2] ------------[ cut here ]------------
[ 8339.659324][    C2] WARNING: CPU: 2 PID: 558 at kernel/sched/core.c:3158=
 ttwu_queue_wakelist+0x284/0x2f0
[ 8339.668804][    C2] Modules linked in: iscsi_target_mod tcm_loop target_=
core_pscsi target_core_file target_core_iblock nft_fib_inet nft_fib_ipv4 nf=
t_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject=
 nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_se=
curity iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptabl=
e_mangle iptable_raw iptable_security ip_set nf_tables bridge stp llc nfnet=
link rfkill target_core_user ip6table_filter target_core_mod ip6_tables ipt=
able_filter sunrpc intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal in=
tel_powerclamp coretemp kvm_intel kvm irqbypass iTCO_wdt rapl intel_pmc_bxt=
 iTCO_vendor_support intel_cstate joydev mei_me ses i2c_i801 mei intel_unco=
re enclosure ipmi_ssif lpc_ich i2c_smbus ioatdma wmi acpi_ipmi ipmi_si ipmi=
_devintf ipmi_msghandler acpi_power_meter acpi_pad zram ip_tables ast drm_v=
ram_helper drm_kms_helper crc32c_intel syscopyarea sysfillrect sysimgblt fb=
_sys_fops cec
[ 8339.668927][    C2]  drm_ttm_helper ttm ghash_clmulni_intel drm mpt3sas =
igb raid_class scsi_transport_sas nvme dca nvme_core i2c_algo_bit pkcs8_key=
_parser [last unloaded: zonefs]
[ 8339.770658][    C2] CPU: 2 PID: 558 Comm: systemd-udevd Not tainted 5.12=
.0-rc2+ #1
[ 8339.778222][    C2] Hardware name: Supermicro Super Server/X10SRL-F, BIO=
S 3.2 11/22/2019
[ 8339.786310][    C2] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
[ 8339.792054][    C2] Code: 34 24 e8 3f 7d 63 00 4c 8b 44 24 10 48 8b 4c 2=
4 08 8b 34 24 e9 a1 fe ff ff e8 78 7d 63 00 e9 66 ff ff ff e8 8e 7d 63 00 e=
b a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 19 7d 63 00 48 8b 04
[ 8339.811494][    C2] RSP: 0000:ffff888811489ce0 EFLAGS: 00010046
[ 8339.817415][    C2] RAX: 0000000000000002 RBX: ffff88810eee3240 RCX: fff=
f888811480000
[ 8339.825240][    C2] RDX: 0000000000000000 RSI: 0000000000000002 RDI: fff=
fffff91e2c6f0
[ 8339.833067][    C2] RBP: 0000000000000002 R08: ffffffff91e2c6f0 R09: fff=
fffff929a2ba7
[ 8339.840894][    C2] R10: fffffbfff2534574 R11: 0000000000000001 R12: 000=
0000000000000
[ 8339.848719][    C2] R13: ffff88881149f8c0 R14: 0000000000000002 R15: 000=
0000000032c01
[ 8339.856545][    C2] FS:  00007fe9e16cc380(0000) GS:ffff888811480000(0000=
) knlGS:0000000000000000
[ 8339.865325][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 8339.871763][    C2] CR2: 000055d9e787ea88 CR3: 000000011d906004 CR4: 000=
00000001706e0
[ 8339.879591][    C2] Call Trace:
[ 8339.882730][    C2]  <IRQ>
[ 8339.885440][    C2]  ? lock_is_held_type+0x98/0x110
[ 8339.890321][    C2]  try_to_wake_up+0x5c7/0x1780
[ 8339.894940][    C2]  ? migrate_swap_stop+0x970/0x970
[ 8339.899907][    C2]  blk_update_request+0x711/0xe50
[ 8339.904787][    C2]  ? scsi_cleanup_rq+0x110/0x180
[ 8339.909578][    C2]  scsi_end_request+0x71/0x620
[ 8339.914199][    C2]  scsi_io_completion+0x176/0xe00
[ 8339.919078][    C2]  ? provisioning_mode_store+0x3f0/0x3f0
[ 8339.924562][    C2]  ? scsi_run_host_queues+0x60/0x60
[ 8339.929616][    C2]  blk_complete_reqs+0x9a/0xd0
[ 8339.934235][    C2]  __do_softirq+0x1d0/0x881
[ 8339.938596][    C2]  __irq_exit_rcu+0x1b9/0x270
[ 8339.943137][    C2]  irq_exit_rcu+0xa/0x20
[ 8339.947235][    C2]  sysvec_call_function_single+0x6f/0x90
[ 8339.952721][    C2]  </IRQ>
[ 8339.955520][    C2]  asm_sysvec_call_function_single+0x12/0x20
[ 8339.961353][    C2] RIP: 0010:ptep_clear_flush+0x4f/0x150
[ 8339.966753][    C2] Code: 48 89 f5 48 c1 ea 03 53 80 3c 02 00 0f 85 00 0=
1 00 00 be 08 00 00 00 4c 89 ef 49 8b 5f 40 45 31 f6 e8 85 64 0a 00 4d 87 7=
5 00 <48> c7 c0 78 cf e3 91 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80
[ 8339.986193][    C2] RSP: 0000:ffff88811faf7ba0 EFLAGS: 00000246
[ 8339.992111][    C2] RAX: 0000000000000001 RBX: ffff888118eb9c00 RCX: fff=
fffff8f7c368b
[ 8339.999939][    C2] RDX: ffffed102446ac7f RSI: 0000000000000008 RDI: fff=
f8881223563f0
[ 8340.007764][    C2] RBP: 000055d9e787e000 R08: 0000000000000001 R09: fff=
f8881223563f7
[ 8340.015589][    C2] R10: ffffed102446ac7e R11: 0000000000000001 R12: fff=
f888121105a08
[ 8340.023417][    C2] R13: ffff8881223563f0 R14: 8000000213aa9865 R15: fff=
f8881211059c8
[ 8340.031246][    C2]  ? ptep_clear_flush+0x4b/0x150
[ 8340.036037][    C2]  wp_page_copy+0x839/0x1fd0
[ 8340.040485][    C2]  ? lock_release+0x680/0x680
[ 8340.045015][    C2]  ? __do_fault+0x5d0/0x5d0
[ 8340.049376][    C2]  ? do_wp_page+0x318/0x1650
[ 8340.053822][    C2]  __handle_mm_fault+0x1f31/0x4af0
[ 8340.058787][    C2]  ? lock_is_held_type+0x98/0x110
[ 8340.063666][    C2]  ? copy_page_range+0x3810/0x3810
[ 8340.068635][    C2]  ? count_memcg_event_mm.part.0+0xfc/0x1a0
[ 8340.074377][    C2]  ? trace_hardirqs_on+0x1c/0x110
[ 8340.079257][    C2]  handle_mm_fault+0x15f/0x620
[ 8340.083879][    C2]  do_user_addr_fault+0x385/0xe30
[ 8340.088758][    C2]  ? do_kern_addr_fault+0xb0/0xb0
[ 8340.093636][    C2]  ? irqentry_enter+0x55/0x60
[ 8340.098170][    C2]  exc_page_fault+0x60/0xe0
[ 8340.102528][    C2]  ? asm_exc_page_fault+0x8/0x30
[ 8340.107321][    C2]  asm_exc_page_fault+0x1e/0x30
[ 8340.112027][    C2] RIP: 0033:0x7fe9e25c5cdd
[ 8340.116301][    C2] Code: 08 48 8b 4f 08 48 89 c8 48 83 e0 f8 48 3b 04 0=
7 0f 85 91 00 00 00 48 8b 47 10 48 8b 57 18 48 3b 78 18 75 69 48 3b 7a 10 7=
5 63 <48> 89 50 18 48 89 42 10 48 81 f9 ff 03 00 00 76 2c 48 8b 57 20 48
[ 8340.135739][    C2] RSP: 002b:00007fff57b878d0 EFLAGS: 00010246
[ 8340.141658][    C2] RAX: 000055d9e787ea70 RBX: 000055d9e78851d0 RCX: 000=
0000000000291
[ 8340.149485][    C2] RDX: 00007fe9e2701ce0 RSI: 0000000000000002 RDI: 000=
055d9e78851d0
[ 8340.157310][    C2] RBP: 00000000000002c0 R08: 000055d9e789cc70 R09: 000=
0000000000290
[ 8340.165137][    C2] R10: 0000000000000047 R11: 000055d9e780d130 R12: 000=
07fe9e2701a00
[ 8340.172963][    C2] R13: 00007fe9e2701a18 R14: 000000055d9e7885 R15: 000=
055d9e7885490
[ 8340.180794][    C2] irq event stamp: 13527209
[ 8340.185149][    C2] hardirqs last  enabled at (13527208): [<ffffffff9140=
0185>] __do_softirq+0x185/0x881
[ 8340.194536][    C2] hardirqs last disabled at (13527209): [<ffffffff911e=
2c30>] _raw_spin_lock_irqsave+0x50/0x60
[ 8340.204616][    C2] softirqs last  enabled at (13527014): [<ffffffff8f1a=
f839>] __irq_exit_rcu+0x1b9/0x270
[ 8340.214175][    C2] softirqs last disabled at (13527207): [<ffffffff8f1a=
f839>] __irq_exit_rcu+0x1b9/0x270
[ 8340.223735][    C2] ---[ end trace b4a0f179ac6a8cbe ]---
[ 8340.229054][    C2]=20
[ 8340.229056][    C2] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 8340.229057][    C2] WARNING: possible circular locking dependency detect=
ed
[ 8340.229058][    C2] 5.12.0-rc2+ #1 Not tainted
[ 8340.229059][    C2] ----------------------------------------------------=
--
[ 8340.229059][    C2] systemd-udevd/558 is trying to acquire lock:
[ 8340.229060][    C2] ffffffff92218b18 ((console_sem).lock){-.-.}-{2:2}, a=
t: down_trylock+0x13/0x70
[ 8340.229064][    C2]=20
[ 8340.229065][    C2] but task is already holding lock:
[ 8340.229065][    C2] ffff88810eee3f20 (&p->pi_lock){-.-.}-{2:2}, at: try_=
to_wake_up+0x88/0x1780
[ 8340.229068][    C2]=20
[ 8340.229069][    C2] which lock already depends on the new lock.
[ 8340.229069][    C2]=20
[ 8340.229070][    C2]=20
[ 8340.229071][    C2] the existing dependency chain (in reverse order) is:
[ 8340.229071][    C2]=20
[ 8340.229072][    C2] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[ 8340.229074][    C2]        _raw_spin_lock_irqsave+0x3b/0x60
[ 8340.229075][    C2]        try_to_wake_up+0x88/0x1780
[ 8340.229076][    C2]        up+0x7a/0xb0
[ 8340.229076][    C2]        __up_console_sem+0x2d/0x60
[ 8340.229077][    C2]        console_unlock+0x41b/0x880
[ 8340.229078][    C2]        vprintk_emit+0x257/0x420
[ 8340.229079][    C2]        devkmsg_emit.constprop.0+0x95/0xb1
[ 8340.229080][    C2]        devkmsg_write.cold+0x48/0x74
[ 8340.229082][    C2]        do_iter_readv_writev+0x32b/0x6b0
[ 8340.229083][    C2]        do_iter_write+0x137/0x5d0
[ 8340.229084][    C2]        vfs_writev+0x147/0x4a0
[ 8340.229084][    C2]        do_writev+0x100/0x260
[ 8340.229085][    C2]        do_syscall_64+0x33/0x40
[ 8340.229086][    C2]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 8340.229086][    C2]=20
[ 8340.229087][    C2] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[ 8340.229090][    C2]        __lock_acquire+0x290e/0x58b0
[ 8340.229090][    C2]        lock_acquire+0x181/0x6a0
[ 8340.229091][    C2]        _raw_spin_lock_irqsave+0x3b/0x60
[ 8340.229092][    C2]        down_trylock+0x13/0x70
[ 8340.229092][    C2]        __down_trylock_console_sem+0x24/0x90
[ 8340.229093][    C2]        vprintk_emit+0x230/0x420
[ 8340.229094][    C2]        printk+0x96/0xb2
[ 8340.229094][    C2]        report_bug.cold+0x31/0x53
[ 8340.229095][    C2]        handle_bug+0x41/0x80
[ 8340.229096][    C2]        exc_invalid_op+0x14/0x40
[ 8340.229096][    C2]        asm_exc_invalid_op+0x12/0x20
[ 8340.229097][    C2]        ttwu_queue_wakelist+0x284/0x2f0
[ 8340.229098][    C2]        try_to_wake_up+0x5c7/0x1780
[ 8340.229098][    C2]        blk_update_request+0x711/0xe50
[ 8340.229099][    C2]        scsi_end_request+0x71/0x620
[ 8340.229100][    C2]        scsi_io_completion+0x176/0xe00
[ 8340.229100][    C2]        blk_complete_reqs+0x9a/0xd0
[ 8340.229101][    C2]        __do_softirq+0x1d0/0x881
[ 8340.229102][    C2]        __irq_exit_rcu+0x1b9/0x270
[ 8340.229102][    C2]        irq_exit_rcu+0xa/0x20
[ 8340.229103][    C2]        sysvec_call_function_single+0x6f/0x90
[ 8340.229103][    C2]        asm_sysvec_call_function_single+0x12/0x20
[ 8340.229104][    C2]        ptep_clear_flush+0x4f/0x150
[ 8340.229105][    C2]        wp_page_copy+0x839/0x1fd0
[ 8340.229106][    C2]        __handle_mm_fault+0x1f31/0x4af0
[ 8340.229106][    C2]        handle_mm_fault+0x15f/0x620
[ 8340.229107][    C2]        do_user_addr_fault+0x385/0xe30
[ 8340.229108][    C2]        exc_page_fault+0x60/0xe0
[ 8340.229108][    C2]        asm_exc_page_fault+0x1e/0x30
[ 8340.229109][    C2]=20
[ 8340.229109][    C2] other info that might help us debug this:
[ 8340.229110][    C2]=20
[ 8340.229110][    C2]  Possible unsafe locking scenario:
[ 8340.229111][    C2]=20
[ 8340.229112][    C2]        CPU0                    CPU1
[ 8340.229112][    C2]        ----                    ----
[ 8340.229113][    C2]   lock(&p->pi_lock);
[ 8340.229114][    C2]                                lock((console_sem).lo=
ck);
[ 8340.229116][    C2]                                lock(&p->pi_lock);
[ 8340.229118][    C2]   lock((console_sem).lock);
[ 8340.229119][    C2]=20
[ 8340.229120][    C2]  *** DEADLOCK ***
[ 8340.229120][    C2]=20
[ 8340.229121][    C2] 3 locks held by systemd-udevd/558:
[ 8340.229121][    C2]  #0: ffff888118eb9d58 (&mm->mmap_lock#2){++++}-{3:3}=
, at: do_user_addr_fault+0x228/0xe30
[ 8340.229125][    C2]  #1: ffff88811f57f438 (ptlock_ptr(page)#2){+.+.}-{2:=
2}, at: wp_page_copy+0x5e5/0x1fd0
[ 8340.229129][    C2]  #2: ffff88810eee3f20 (&p->pi_lock){-.-.}-{2:2}, at:=
 try_to_wake_up+0x88/0x1780
[ 8340.229132][    C2]=20
[ 8340.229132][    C2] stack backtrace:
[ 8340.229133][    C2] CPU: 2 PID: 558 Comm: systemd-udevd Not tainted 5.12=
.0-rc2+ #1
[ 8340.229134][    C2] Hardware name: Supermicro Super Server/X10SRL-F, BIO=
S 3.2 11/22/2019
[ 8340.229135][    C2] Call Trace:
[ 8340.229135][    C2]  <IRQ>
[ 8340.229136][    C2]  dump_stack+0x93/0xc2
[ 8340.229136][    C2]  check_noncircular+0x235/0x2b0
[ 8340.229137][    C2]  ? print_circular_bug+0x460/0x460
[ 8340.229138][    C2]  ? vsnprintf+0x830/0x15c0
[ 8340.229138][    C2]  __lock_acquire+0x290e/0x58b0
[ 8340.229139][    C2]  ? printk_sprint+0x89/0x110
[ 8340.229139][    C2]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[ 8340.229140][    C2]  ? vprintk_store+0x4ba/0x630
[ 8340.229141][    C2]  lock_acquire+0x181/0x6a0
[ 8340.229141][    C2]  ? down_trylock+0x13/0x70
[ 8340.229142][    C2]  ? lock_release+0x680/0x680
[ 8340.229142][    C2]  ? printk+0x96/0xb2
[ 8340.229143][    C2]  _raw_spin_lock_irqsave+0x3b/0x60
[ 8340.229144][    C2]  ? down_trylock+0x13/0x70
[ 8340.229144][    C2]  down_trylock+0x13/0x70
[ 8340.229145][    C2]  ? printk+0x96/0xb2
[ 8340.229145][    C2]  __down_trylock_console_sem+0x24/0x90
[ 8340.229146][    C2]  vprintk_emit+0x230/0x420
[ 8340.229147][    C2]  ? ttwu_queue_wakelist+0x284/0x2f0
[ 8340.229147][    C2]  printk+0x96/0xb2
[ 8340.229148][    C2]  ? record_print_text.cold+0x11/0x11
[ 8340.229148][    C2]  ? find_held_lock+0x2c/0x110
[ 8340.229149][    C2]  report_bug.cold+0x31/0x53
[ 8340.229150][    C2]  handle_bug+0x41/0x80
[ 8340.229150][    C2]  exc_invalid_op+0x14/0x40
[ 8340.229151][    C2]  asm_exc_invalid_op+0x12/0x20
[ 8340.229152][    C2] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
[ 8340.229152][    C2] Code: 34 24 e8 3f 7d 63 00 4c 8b 44 24 10 48 8b 4c 2=
4 08 8b 34 24 e9 a1 fe ff ff e8 78 7d 63 00 e9 66 ff ff ff e8 8e 7d 63 00 e=
b a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 19 7d 63 00 48 8b 04
[ 8340.229154][    C2] RSP: 0000:ffff888811489ce0 EFLAGS: 00010046
[ 8340.229155][    C2] RAX: 0000000000000002 RBX: ffff88810eee3240=20
[ 8340.229156][    C2] Lost 55 message(s)!


[3]

[40041.712804][T135817] ------------[ cut here ]------------
[40041.718489][T135817] WARNING: CPU: 1 PID: 135817 at kernel/sched/core.c:=
3175 ttwu_queue_wakelist+0x284/0x2f0
[40041.728311][T135817] Modules linked in: null_blk dm_flakey iscsi_target_=
mod tcm_loop target_core_pscsi target_core_file target_core_iblock nft_fib_=
inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_re=
ject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle ip6t=
able_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 n=
f_defrag_ipv4 iptable_mangle iptable_raw bridge iptable_security stp llc ip=
_set rfkill nf_tables target_core_user target_core_mod nfnetlink ip6table_f=
ilter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_common x86=
_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass iTCO_wd=
t intel_pmc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore joydev l=
pc_ich i2c_i801 i2c_smbus ses enclosure mei_me mei ipmi_ssif ioatdma wmi ac=
pi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad zram=
 ip_tables ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect crc32=
c_intel sysimgblt
[40041.728481][T135817]  fb_sys_fops cec drm_ttm_helper ttm ghash_clmulni_i=
ntel drm igb mpt3sas nvme dca i2c_algo_bit nvme_core raid_class scsi_transp=
ort_sas pkcs8_key_parser [last unloaded: null_blk]
[40041.832215][T135817] CPU: 1 PID: 135817 Comm: fio Not tainted 5.13.0-rc5=
+ #1
[40041.839262][T135817] Hardware name: Supermicro Super Server/X10SRL-F, BI=
OS 3.2 11/22/2019
[40041.847434][T135817] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
[40041.853266][T135817] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 48 8b 4c =
24 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be 71 64 00 =
eb a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 49 71 64 00 48 8b 04
[40041.872793][T135817] RSP: 0018:ffff888106bff348 EFLAGS: 00010046
[40041.878800][T135817] RAX: 0000000000000001 RBX: ffff888117ec3240 RCX: ff=
ff888811440000
[40041.886711][T135817] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ff=
ffffffb603d6e8
[40041.894625][T135817] RBP: 0000000000000001 R08: ffffffffb603d6e8 R09: ff=
ffffffb6ba6167
[40041.902537][T135817] R10: fffffbfff6d74c2c R11: 0000000000000001 R12: 00=
00000000000000
[40041.910451][T135817] R13: ffff88881145fd00 R14: 0000000000000001 R15: ff=
ff888811440001
[40041.918364][T135817] FS:  00007f8eabf14b80(0000) GS:ffff888811440000(000=
0) knlGS:0000000000000000
[40041.927229][T135817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40041.933756][T135817] CR2: 000055ce81e2cc78 CR3: 000000011be92005 CR4: 00=
000000001706e0
[40041.941669][T135817] Call Trace:
[40041.944895][T135817]  ? lock_is_held_type+0x98/0x110
[40041.949860][T135817]  try_to_wake_up+0x6f9/0x15e0
[40041.954567][T135817]  ? migrate_swap_stop+0x970/0x970
[40041.959618][T135817]  ? insert_work+0x193/0x2e0
[40041.964152][T135817]  __queue_work+0x4e8/0xdb0
[40041.968599][T135817]  ? try_to_grab_pending.part.0+0x439/0x530
[40041.974429][T135817]  ? hctx_unlock+0x7d/0xe0
[40041.978790][T135817]  mod_delayed_work_on+0x8c/0x100
[40041.983755][T135817]  ? cancel_delayed_work+0x1f0/0x1f0
[40041.988982][T135817]  ? __blk_mq_delay_run_hw_queue+0x95/0x4b0
[40041.994817][T135817]  kblockd_mod_delayed_work_on+0x17/0x20
[40042.000390][T135817]  blk_mq_run_hw_queue+0x125/0x270
[40042.005439][T135817]  ? blk_mq_delay_run_hw_queues+0x410/0x410
[40042.011275][T135817]  blk_mq_sched_insert_request+0x294/0x420
[40042.017020][T135817]  ? __blk_mq_sched_bio_merge+0x340/0x340
[40042.022677][T135817]  ? blk_mq_rq_ctx_init+0x99a/0xe80
[40042.027819][T135817]  blk_mq_submit_bio+0xb37/0x15f0
[40042.032786][T135817]  ? blk_mq_try_issue_list_directly+0x940/0x940
[40042.038966][T135817]  ? percpu_ref_put_many.constprop.0+0x82/0x1b0
[40042.045148][T135817]  submit_bio_noacct+0x79c/0xe60
[40042.050023][T135817]  ? blk_queue_enter+0x810/0x810
[40042.054902][T135817]  ? find_held_lock+0x2c/0x110
[40042.059611][T135817]  submit_bio+0xe4/0x4c0
[40042.063795][T135817]  ? submit_bio_noacct+0xe60/0xe60
[40042.068847][T135817]  ? bio_add_zone_append_page+0x2c0/0x2c0
[40042.074507][T135817]  ? bio_release_pages.part.0+0x10c/0x3d0
[40042.080167][T135817]  ? __blkdev_direct_IO_simple+0x436/0x7d0
[40042.085912][T135817]  __blkdev_direct_IO_simple+0x40d/0x7d0
[40042.091488][T135817]  ? bd_link_disk_holder+0x6e0/0x6e0
[40042.096711][T135817]  ? __lock_acquire+0xbbc/0x51b0
[40042.101591][T135817]  ? mark_lock+0xe4/0x18a0
[40042.105953][T135817]  ? set_init_blocksize.isra.0+0x140/0x140
[40042.111698][T135817]  ? mark_lock+0xe4/0x18a0
[40042.116054][T135817]  ? lock_is_held_type+0x98/0x110
[40042.121021][T135817]  ? find_held_lock+0x2c/0x110
[40042.125730][T135817]  blkdev_direct_IO+0xd23/0x11d0
[40042.130607][T135817]  ? __lock_acquire+0x15c2/0x51b0
[40042.135577][T135817]  ? bd_prepare_to_claim+0x2a0/0x2a0
[40042.140799][T135817]  ? __lock_acquire+0x15c2/0x51b0
[40042.145770][T135817]  generic_file_read_iter+0x1f4/0x470
[40042.151080][T135817]  blkdev_read_iter+0x100/0x190
[40042.155871][T135817]  new_sync_read+0x352/0x5d0
[40042.160403][T135817]  ? __ia32_sys_llseek+0x310/0x310
[40042.165458][T135817]  ? __cond_resched+0x15/0x30
[40042.170076][T135817]  ? inode_security+0x56/0xf0
[40042.174698][T135817]  vfs_read+0x26c/0x470
[40042.178796][T135817]  __x64_sys_pread64+0x17d/0x1d0
[40042.183674][T135817]  ? vfs_read+0x470/0x470
[40042.187946][T135817]  ? syscall_enter_from_user_mode+0x27/0x70
[40042.193780][T135817]  ? trace_hardirqs_on+0x1c/0x110
[40042.198747][T135817]  do_syscall_64+0x40/0x80
[40042.203107][T135817]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[40042.208939][T135817] RIP: 0033:0x7f8eb5cdb96f
[40042.213297][T135817] Code: 08 89 3c 24 48 89 4c 24 18 e8 7d f3 ff ff 4c =
8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 cd f3 ff ff 48 8b
[40042.232824][T135817] RSP: 002b:00007fffaa10c9d0 EFLAGS: 00000293 ORIG_RA=
X: 0000000000000011
[40042.241169][T135817] RAX: ffffffffffffffda RBX: 00000000012e2540 RCX: 00=
007f8eb5cdb96f
[40042.249074][T135817] RDX: 0000000000001000 RSI: 000000000130a000 RDI: 00=
00000000000009
[40042.256985][T135817] RBP: 00000000012e2540 R08: 0000000000000000 R09: 00=
007fffaa163080
[40042.264898][T135817] R10: 0000000000862000 R11: 0000000000000293 R12: 00=
007f8e96829458
[40042.272813][T135817] R13: 0000000000000000 R14: 0000000000001000 R15: 00=
000000012e2568
[40042.280732][T135817] irq event stamp: 1042448
[40042.285084][T135817] hardirqs last  enabled at (1042447): [<ffffffffb320=
209e>] try_to_grab_pending.part.0+0x1ae/0x530
[40042.295683][T135817] hardirqs last disabled at (1042448): [<ffffffffb320=
2b3b>] mod_delayed_work_on+0xcb/0x100
[40042.305591][T135817] softirqs last  enabled at (1041222): [<ffffffffb31b=
5316>] __irq_exit_rcu+0x1c6/0x270
[40042.315150][T135817] softirqs last disabled at (1041215): [<ffffffffb31b=
5316>] __irq_exit_rcu+0x1c6/0x270
[40042.324711][T135817] ---[ end trace b6f997c9a553aa02 ]---
[40042.330118][    C1]=20
[40042.330119][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[40042.330121][    C1] WARNING: possible circular locking dependency detect=
ed
[40042.330123][    C1] 5.13.0-rc5+ #1 Not tainted
[40042.330125][    C1] ----------------------------------------------------=
--
[40042.330126][    C1] fio/135817 is trying to acquire lock:
[40042.330128][    C1] ffffffffb641acb8 ((console_sem).lock){-.-.}-{2:2}, a=
t: down_trylock+0x13/0x70
[40042.330134][    C1]=20
[40042.330135][    C1] but task is already holding lock:
[40042.330137][    C1] ffff888117ec3f30 (&p->pi_lock){-.-.}-{2:2}, at: try_=
to_wake_up+0x88/0x15e0
[40042.330142][    C1]=20
[40042.330144][    C1] which lock already depends on the new lock.
[40042.330145][    C1]=20
[40042.330146][    C1]=20
[40042.330147][    C1] the existing dependency chain (in reverse order) is:
[40042.330149][    C1]=20
[40042.330150][    C1] -> #1 (&p->pi_lock){-.-.}-{2:2}:
[40042.330155][    C1]        _raw_spin_lock_irqsave+0x3b/0x60
[40042.330156][    C1]        try_to_wake_up+0x88/0x15e0
[40042.330157][    C1]        up+0x7a/0xb0
[40042.330159][    C1]        __up_console_sem+0x2d/0x60
[40042.330161][    C1]        console_unlock+0x3f7/0x840
[40042.330162][    C1]        vprintk_emit+0x257/0x420
[40042.330163][    C1]        devkmsg_emit.constprop.0+0x95/0xb1
[40042.330165][    C1]        devkmsg_write.cold+0x48/0x74
[40042.330166][    C1]        do_iter_readv_writev+0x32b/0x6b0
[40042.330167][    C1]        do_iter_write+0x137/0x5d0
[40042.330169][    C1]        vfs_writev+0x147/0x4a0
[40042.330170][    C1]        do_writev+0x100/0x260
[40042.330172][    C1]        do_syscall_64+0x40/0x80
[40042.330173][    C1]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[40042.330175][    C1]=20
[40042.330176][    C1] -> #0 ((console_sem).lock){-.-.}-{2:2}:
[40042.330181][    C1]        __lock_acquire+0x2940/0x51b0
[40042.330182][    C1]        lock_acquire+0x181/0x6a0
[40042.330183][    C1]        _raw_spin_lock_irqsave+0x3b/0x60
[40042.330184][    C1]        down_trylock+0x13/0x70
[40042.330185][    C1]        __down_trylock_console_sem+0x24/0x90
[40042.330186][    C1]        vprintk_emit+0x230/0x420
[40042.330187][    C1]        printk+0x96/0xb2
[40042.330187][    C1]        report_bug.cold+0x31/0x53
[40042.330188][    C1]        handle_bug+0x3c/0x70
[40042.330189][    C1]        exc_invalid_op+0x14/0x40
[40042.330189][    C1]        asm_exc_invalid_op+0x12/0x20
[40042.330190][    C1]        ttwu_queue_wakelist+0x284/0x2f0
[40042.330191][    C1]        try_to_wake_up+0x6f9/0x15e0
[40042.330192][    C1]        __queue_work+0x4e8/0xdb0
[40042.330193][    C1]        mod_delayed_work_on+0x8c/0x100
[40042.330194][    C1]        kblockd_mod_delayed_work_on+0x17/0x20
[40042.330194][    C1]        blk_mq_run_hw_queue+0x125/0x270
[40042.330195][    C1]        blk_mq_sched_insert_request+0x294/0x420
[40042.330196][    C1]        blk_mq_submit_bio+0xb37/0x15f0
[40042.330197][    C1]        submit_bio_noacct+0x79c/0xe60
[40042.330198][    C1]        submit_bio+0xe4/0x4c0
[40042.330199][    C1]        __blkdev_direct_IO_simple+0x40d/0x7d0
[40042.330199][    C1]        blkdev_direct_IO+0xd23/0x11d0
[40042.330200][    C1]        generic_file_read_iter+0x1f4/0x470
[40042.330201][    C1]        blkdev_read_iter+0x100/0x190
[40042.330202][    C1]        new_sync_read+0x352/0x5d0
[40042.330203][    C1]        vfs_read+0x26c/0x470
[40042.330203][    C1]        __x64_sys_pread64+0x17d/0x1d0
[40042.330204][    C1]        do_syscall_64+0x40/0x80
[40042.330205][    C1]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[40042.330206][    C1]=20
[40042.330206][    C1] other info that might help us debug this:
[40042.330207][    C1]=20
[40042.330208][    C1]  Possible unsafe locking scenario:
[40042.330208][    C1]=20
[40042.330209][    C1]        CPU0                    CPU1
[40042.330210][    C1]        ----                    ----
[40042.330210][    C1]   lock(&p->pi_lock);
[40042.330212][    C1]                                lock((console_sem).lo=
ck);
[40042.330214][    C1]                                lock(&p->pi_lock);
[40042.330216][    C1]   lock((console_sem).lock);
[40042.330217][    C1]=20
[40042.330218][    C1]  *** DEADLOCK ***
[40042.330218][    C1]=20
[40042.330219][    C1] 3 locks held by fio/135817:
[40042.330220][    C1]  #0: ffffffffb643ae80 (rcu_read_lock){....}-{1:2}, a=
t: __queue_work+0xa0/0xdb0
[40042.330223][    C1]  #1: ffff8888114730d8 (&pool->lock){-.-.}-{2:2}, at:=
 __queue_work+0x2ce/0xdb0
[40042.330227][    C1]  #2: ffff888117ec3f30 (&p->pi_lock){-.-.}-{2:2}, at:=
 try_to_wake_up+0x88/0x15e0
[40042.330230][    C1]=20
[40042.330231][    C1] stack backtrace:
[40042.330231][    C1] CPU: 1 PID: 135817 Comm: fio Not tainted 5.13.0-rc5+=
 #1
[40042.330232][    C1] Hardware name: Supermicro Super Server/X10SRL-F, BIO=
S 3.2 11/22/2019
[40042.330233][    C1] Call Trace:
[40042.330234][    C1]  dump_stack+0x93/0xc2
[40042.330234][    C1]  check_noncircular+0x235/0x2b0
[40042.330235][    C1]  ? print_circular_bug+0x1f0/0x1f0
[40042.330236][    C1]  ? enable_ptr_key_workfn+0x20/0x20
[40042.330237][    C1]  ? desc_read+0x218/0x2e0
[40042.330237][    C1]  ? vsnprintf+0x830/0x15c0
[40042.330238][    C1]  __lock_acquire+0x2940/0x51b0
[40042.330239][    C1]  ? printk_sprint+0x89/0x110
[40042.330239][    C1]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
[40042.330240][    C1]  ? vprintk_store+0x581/0x630
[40042.330241][    C1]  lock_acquire+0x181/0x6a0
[40042.330242][    C1]  ? down_trylock+0x13/0x70
[40042.330242][    C1]  ? lock_release+0x680/0x680
[40042.330243][    C1]  ? lock_chain_count+0x20/0x20
[40042.330244][    C1]  ? lock_downgrade+0x6a0/0x6a0
[40042.330245][    C1]  ? printk+0x96/0xb2
[40042.330246][    C1]  _raw_spin_lock_irqsave+0x3b/0x60
[40042.330248][    C1]  ? down_trylock+0x13/0x70
[40042.330249][    C1]  down_trylock+0x13/0x70
[40042.330250][    C1]  ? printk+0x96/0xb2
[40042.330252][    C1]  __down_trylock_console_sem+0x24/0x90
[40042.330253][    C1]  vprintk_emit+0x230/0x420
[40042.330254][    C1]  ? ttwu_queue_wakelist+0x284/0x2f0
[40042.330255][    C1]  printk+0x96/0xb2
[40042.330256][    C1]  ? record_print_text.cold+0x11/0x11
[40042.330258][    C1]  report_bug.cold+0x31/0x53
[40042.330259][    C1]  ? ttwu_queue_wakelist+0x284/0x2f0
[40042.330260][    C1]  handle_bug+0x3c/0x70
[40042.330262][    C1]  exc_invalid_op+0x14/0x40
[40042.330263][    C1]  asm_exc_invalid_op+0x12/0x20
[40042.330264][    C1] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
[40042.330266][    C1] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 48 8b 4c 2=
4 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be 71 64 00 e=
b a0 <0f> 0b 45 31 ff e9 cb=20
[40042.330269][    C1] Lost 69 message(s)!

--=20
Best Regards,
Shin'ichiro Kawasaki=
