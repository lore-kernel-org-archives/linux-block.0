Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DB6EB64DD
	for <linux-block@archiver.kernel.org>; Thu, 13 Jul 2023 11:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGMLKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjGMLKR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 07:10:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E4198A
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689246615; x=1720782615;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=s0t4CJQLqqBzu1lrIVcuGgNB8t/fqYs94fw3Jizny6w=;
  b=nX0SPRldMe4fwSkXVqMiahAPHFIgopE+mzLDLjMU+V3fQ3qneb+VGGCu
   GyKZCGZQBBgkIzpqqirZfXOO+gLZe5DlEa+AR061FgU0D5seU9ZH8r3m7
   zJ6Kqs454h47u8siE+tgzSPN9Nr/OA7oQesrU01sHNULvj85H4yt4GoTS
   B72VfxCR1Ew9wjqP3BQ1XpsfcvTCJUER21BfikcRpriaqI/uotl1OnfFQ
   SQMyhqAU7oqiyFV68X2OGNWJvo1ecqaM2V/Mp2E7KIzRy5+W8UJsHUSEf
   sGiIjEhT2SFMVyr0GnMIXIdjgdIusj8GQmgOue9VNWWbgSC7SD0Kvkh4G
   w==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684771200"; 
   d="scan'208";a="349865316"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 19:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvRoqh/eUrAaiR7qfc/GFN9yJrl7pkRPEeGosd4VVTxojJ8kzTUcLv0gc7roaBsFSdSzNaIBfKIrTL3qfKRyIkEZq9U0otzGeRuwkdpWnDFRY3c8uHPzr8G6woFfVhHALx/OU0LG00L1ra9BkYTi2wgUuK3TPQc/AowjdYSGk0iW+ehWs6kscjfkzxiuANJUe5DqqKYjycoSVlPmcuDdQGJHsPNJhnHafWO/ATjjT1ijJGonw0nPWj5OGTbYCaYxDeSCbgfx+RT90NHaLItvR8H/YGIonSIPVLsELcdECiXR4M/Z//tBmw9NoUcS8t06h4unImcCYhJyGZ7eD6eA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fuamEcaM24HAG3fTuGvULzs6Jo3NGwM3x5+ZjzfLDU=;
 b=BOBxnzqPROoEPgWQGVQlmBzafVQA6X9xKWlO9WVPnZxi9/op64wcY7OptyjaTGH2XFlOvT2PlG5eph9o0M8f/HhZEg7hmiLbbvbjH+F1FtuMSjc9pxjv4ZUe2neefuVk1QyqETFnEoRQ7gAMD3n2xXzxxxdd2XBAUheeELf8+oikr0+k2oBwkLiQCwmB+HujoIJKiZJQqbMXH9Cmsy4iQVm+MEpt8Tvq1mwVaQV1hTbdWOUxeGdkpksgFaIKGydnb9O2obg2T7XmGWMwUk+taZR4s9CkfU3xju7tz9EFw0hpQbdWob8P3P2XXDP6rb9A2ISYZr3skQE+2R7T5Oungw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fuamEcaM24HAG3fTuGvULzs6Jo3NGwM3x5+ZjzfLDU=;
 b=rvsUkv+QQhSA3IUuwRDg5e3lh1XHUu1JxaOS+Y/oSco+jYTmDCUHN02hP/5tqeN7Xeb3tR+wB7cce8xzWezthwJ8cVdTH7xAnckepOw3WOw7FDBWVXtRQJ5GMb5o8ohzL0Yvf+/Pbtx9Mm/30o9uOopqZpApqm+6eEWuLy9vnR4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8661.namprd04.prod.outlook.com (2603:10b6:510:248::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 11:10:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 11:10:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [bug report] f2fs mount failure on zoned block devices
Thread-Topic: [bug report] f2fs mount failure on zoned block devices
Thread-Index: AQHZtXqWvEj1MKroG0CyZtEYFKT/dQ==
Date:   Thu, 13 Jul 2023 11:10:10 +0000
Message-ID: <5ncdtsl3nycvxwldjg27yhqbt3pg6sdnjlynucbt536fudq7pg@o4zhoxt224jm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8661:EE_
x-ms-office365-filtering-correlation-id: 34221675-78df-440e-6c22-08db8391b914
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0GaAWQi1qXT7fT2PjKfnLgN4QBEiRafKglDLzVAx4YTCdzpMVWCzdpSsaDNeblq2k9ltCdykBMl02f/pkG1FqQFqlmCqtU0APtapZFy5ghypZ2zFB3Ef5sGXi2o2k7Rr4QW5eIP/GOsDNAmYUPQ/+tP9JyYnXnVHAy9AAld/HuKBNZACSH3/vYTdvl5MMOpvaq2zcpO8jPuAaoBij+nfb/keB6UQg64nvP/d17AO0WoDhRe2OWHQrH7J19oIgOA/r8/YfuMMy+KFh/arepzh3TLZ0cth7PM59fhhvo+0wal50IoBc0woT/aZ6gDrLcz6UG0m5gj3M/j00gDYhRp73jmcOYNKX50jAUx4AYf/ErW1DZzIIP+EHHygoMm3BAZJGvtqaB7I+dEyLHpiI8qiNwzZL7TaI7wDF+OVQpSLAOSliWQhvQvOIOGxdFXJMdDJRgkf7lUBKBM6kGeRWnqdyh8BccNPDzad4XseIYpItDU3QhEzzoy6zsH4Z8dGv/qh/kNJv80OkiZFBzD19ZJMBMTQF7jwK0gJ0ss1hwzDGYV4slVNBSV7+SnobyIbibvcq0JgJz/HFey83dGdSpkTqRSToZLFx8lH4/QrMZoBwfcT5NkCZrTYCI+gv/d4zJ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(45080400002)(6486002)(478600001)(91956017)(110136005)(54906003)(71200400001)(186003)(26005)(6506007)(9686003)(6512007)(76116006)(2906002)(33716001)(66946007)(41300700001)(316002)(66446008)(4326008)(66476007)(44832011)(66556008)(8676002)(5660300002)(8936002)(64756008)(38100700002)(82960400001)(122000001)(86362001)(38070700005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QCwzefsherMlBiT3CDt40RPT1Q9uNi3zvk1q2eWExP/7O7/VmaYqeedMRVfP?=
 =?us-ascii?Q?l8tenUP/UzpYToNXw4iJxms7aPw7jhVFH93IjS8jFsy7uqDJS0yxbBFUKu0/?=
 =?us-ascii?Q?hm90WM6WSz8yjO0pKy9R2rGX+Y98s8cJeQ3ETSqAVjdP+hnw4p5L8QZ7mYr5?=
 =?us-ascii?Q?VnmNw+8U9GnY6I1k/1c/v6+zuVPyFG/fcg5xrzU5u1x6VIGn8kOp3GUseYKN?=
 =?us-ascii?Q?CSgq+PcGebKwJgi3cXmlZRvB89ekcABmMpV6akBd9KbwtAWrtwjda3iIfra0?=
 =?us-ascii?Q?v69Xup8UncO9sdApZG4Vp+EK8h2m/YE3Ds6Ixbnpobxn5FUwzyPiIsppml+p?=
 =?us-ascii?Q?si+jdZ2+wGc2kBIvVUAYE91oZPSww7I5uwLdBsEOE4BgRual4MaiJTuFis4t?=
 =?us-ascii?Q?sTvf8nXV70An/2vNOJa1mYejxCCWVINu4x416pInRRq4yTxnGjNbGIU487Ii?=
 =?us-ascii?Q?2QpiprpgdWKtX7DOaxQaYHBGpZfxW9c/u8Hapmg/iUcPNS2kbsdak0SPLg+l?=
 =?us-ascii?Q?hYG9FgFy8pG4q2w2rREOVz5y4MnVLdiw69MePOKqXXLsE9RCuVL/jZRzWzL/?=
 =?us-ascii?Q?fYn5HV+KLb98D4/iJaAiACt3DQ9FrqEbC6WU7QveZHUgayF6nnDCu+bL5UCF?=
 =?us-ascii?Q?B7cmYo3byNGbsmUaEWLjS/RMIzqWlawbVaPYbZ02QDJuvv+a3g3nzjwBYli+?=
 =?us-ascii?Q?7Buz48EQviE211+NH4rQ9uz9AOdrjOpC8zwSCKDUAzlQxJ3/plx+LJsfyxlX?=
 =?us-ascii?Q?VMckGOuQiXfpgY4ASeWQ6+2NtGTjhePQnx5qq17c8wcGJQveO5DHbTSWcksL?=
 =?us-ascii?Q?Q1s5VziqVBp+MGltVSyF34xYWfG93tq+crrW+JvjVDMelzcggkp4x+muRwPs?=
 =?us-ascii?Q?pOARS/L+MK3cxiTerKn3/BVSGTZ/pGH23S3qsSyjDoqtuVApYDvVZFbUY1/r?=
 =?us-ascii?Q?r7fDMmlKEjwZhYcIY0U6T1DKb7MpUSb962BaD19QPkbLQCkucLyfwhktFEWm?=
 =?us-ascii?Q?ZWMKsYd4PVQJoaRkwMEr45B5R5H9cceGN1hL/KivRYibFRZ2i78nAy08FC67?=
 =?us-ascii?Q?m6Jm8B12kkpu8YUyMno/BSZ46TT9g286VuyliV40hOPKK5wM5O1PiFP3F02z?=
 =?us-ascii?Q?2RP70vVujfWsafJ17wB86RNthN+p8rpw9526hRlM46xt9E0fAq4/J+W2SPWX?=
 =?us-ascii?Q?l69R7REw6Y6AUh2N6qW1mDrbxbFQS3sLyGgW/4qq/Fbh7lr6dYZf5WfELg8f?=
 =?us-ascii?Q?MgiTHwaymMlhNlgNVYNGHDdw8ZgAkfvSUZkoi7Fx6wY9ppOWZ+2ltJ1abQsa?=
 =?us-ascii?Q?YjQuBnE5hB38W9TYSNc72/75w/BB/e7gVgqdApwHN5k+H+MXG91zvF57M4sM?=
 =?us-ascii?Q?Xci/AaeqcXcIcbc959Yi2ZpGVw1ogB33Ve4Hb7WFvxg4j+fe4T3MiVsetaBO?=
 =?us-ascii?Q?2USPct2mgoh6GuTgsoPH3UkOVzP34gTvyKjAATlxAukChC1lHenlrb8lSWJ5?=
 =?us-ascii?Q?QRPNUHbkGroXsIQa7HKlcx2+kR2U4x7eJz2Z3SyJpAGrpYN/XDZQXO0P0zHW?=
 =?us-ascii?Q?PBAUyzPzpd2ToSagHQeVVqb1oX7NDBP9m3KrfvDy7IelTZcnFkKS5FNzBrYE?=
 =?us-ascii?Q?IeDO29CN3EE3pUbIvRtmNdY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <39B2C598064F0B4089537F95C27B1F7C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ym8jTD+8AjnOKaSKyEQCY11912ptA5D9QXnnMoYAuQerojE4I0yVlCqNK3WgWGeaNVHwwSlGjJjcJfPdVyGHLgybVNEjzKt9LLL2C2i3vuTKCkNp2/t55/TdO6C2EQqKBGB9lO8MT7shzkKGyZ1RJsgGQZ76v486Q9ORVXQWPo9zmCGfIefHK72N8LovlLAEfYAraS3xPanZsrj6t1V/PeRrtDkAtLAS8TnJtHP7nYAwOPqjR4M9hQ4TcbY7X6WKcMcjq9rypu8kqFjQqCQEG2bXsiGAeFV+xJMIZi1LE1ER5TVnvMZPs5MA/5UBPSVeM7CxLAFN/5jDYySpDiwINZvwMdzTF1QmcOkyyivzjTIn3IOejIoXeFaBL4JxRSRD39Ew5UrBHVdcIfRQnaGm7KaA3W+Iz7Zl+p4KsOI9gQAeLNXMFqVlYok2ul3CA/5A4a52WStCAndx5LqgEdfNH0BqVLDPP66FPwej1AXWJUJ354rEvW10dPRSWi7wUayvP/8fcv1x66m1s20eZ7ntXASqL56zHgH8b1VxEAcO0+91ukJMQyWk/pJiR0YWnUmciOTEtZ6f4OSmU9QpMjrlKJgssKy3mK6gvWCS7ChCkdJIl/UThkLH8jGSrtQlwfvI92HdXGyb/RO23vnz+lQoWCcqoiHoENrHQNmou9Wh5YglxlWmdwBm2HTVOpJaRFeMiDv3c1269lyxA7lGVeSzgwHj/cT7+eOCZNiq6YOFwzKLGvRkdE8aV9QTlE4lBtg18+yemN6Pq+5ctnLfvUWc96N7OLibQ77Frn2sqyFCIYBhsB7J2SCnUZHOeVpy1am0Hk5zNF33hA3YCBFvBiaHaEBmD+ZsnoY7BG0W1XYmMQ=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34221675-78df-440e-6c22-08db8391b914
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 11:10:10.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyrlXIx4/FH2DckuH6aiHj2sMUtNptUOzzqiyYdTu8BxOrhHo1vy1/EhxrMZ6KmgLFdNl9IaFGfKxWvD27YrgUTG/pL1V2lFXadKu8/Qz5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8661
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With kernel v6.5-rc1, I observed failure of a blktests test case zbd/010, w=
hich
mounts f2fs on zoned null_blk and scsi_debug devices. This mount failure ca=
n be
recreated just executing "mkfs.f2fs -m" and "mount" commands on various zon=
ed
block devices. The mount failure is not observed with non-zoned regular blo=
ck
devices. I bisected and found the commit 87efb39075be ("fs: add a method to=
 shut
down the file system") is the trigger.

At the failure, kernel prints a WARN [1] for "bdev->bd_holder_ops !=3D hops=
"
check in bd_may_claim(). I think this WARN is printed because,

- f2fs_mount() calls mount_bdev() and sets bdev->bd_holder_ops =3D &fs_hold=
er_ops.
- f2fs_scan_devices() calls blkdev_get_by_*() for zoned block devices
  specifying hops =3D NULL

Advises for fix will be appreciated. The commit message of the trigger comm=
it
says "File systems their own get_tree method or opening additional devices =
will
need to set up their own blk_holder_ops.". Do we need blk_holder_ops for f2=
fs?

[1]

[  330.649528] ------------[ cut here ]------------
[  330.650297] WARNING: CPU: 1 PID: 1083 at block/bdev.c:487 bd_may_claim+0=
x196/0x1d0
[  330.651247] Modules linked in: scsi_debug null_blk f2fs crc32_generic nf=
t_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4=
 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defr=
ag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr intel_rapl_ms=
r intel_rapl_common kvm_intel ppdev sunrpc kvm irqbypass rapl parport_pc i2=
c_piix4 parport joydev fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc=
32c_intel polyval_clmulni polyval_generic bochs drm_vram_helper drm_kms_hel=
per drm_ttm_helper ghash_clmulni_intel ttm nvme sha512_ssse3 drm sym53c8xx =
nvme_core scsi_transport_spi e1000 nvme_common serio_raw ata_generic pata_a=
cpi scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg [last un=
loaded: null_blk]
[  330.659173] CPU: 1 PID: 1083 Comm: mount Not tainted 6.5.0-rc1-kts #1
[  330.659966] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[  330.661296] RIP: 0010:bd_may_claim+0x196/0x1d0
[  330.661919] Code: 41 5d 0f 95 c0 48 81 fa 80 ed 1f 98 0f 95 c2 21 d0 83 =
f0 01 c3 cc cc cc cc 48 c7 c7 70 ab 57 9b e8 0f 32 8e ff e9 fc fe ff ff <0f=
> 0b e9 32 ff ff ff e8 2e 32 8e ff e9 90 fe ff ff e8 24 32 8e ff
[  330.663974] RSP: 0018:ffff888113e17940 EFLAGS: 00010282
[  330.664679] RAX: dffffc0000000000 RBX: ffff888100457300 RCX: 00000000000=
00000
[  330.665520] RDX: 1ffff1102008ae74 RSI: ffffffff9aa148e8 RDI: ffff8881004=
573a0
[  330.666408] RBP: ffffffffc1ba5220 R08: 0000000000000001 R09: fffffbfff36=
ae75c
[  330.667232] R10: ffff888113e17968 R11: ffff888114cd8000 R12: 00000000000=
00000
[  330.668116] R13: ffff888100457300 R14: ffff888100457300 R15: ffff8881004=
57300
[  330.669008] FS:  00007f8348dc4b80(0000) GS:ffff8881f6e80000(0000) knlGS:=
0000000000000000
[  330.669950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  330.670693] CR2: 00007f8348e1c620 CR3: 0000000184fc6006 CR4: 00000000001=
70ee0
[  330.671575] Call Trace:
[  330.671931]  <TASK>
[  330.672242]  ? __warn+0xcd/0x2b0
[  330.672697]  ? bd_may_claim+0x196/0x1d0
[  330.673236]  ? report_bug+0x26b/0x2e0
[  330.673743]  ? handle_bug+0x79/0xa0
[  330.674200]  ? exc_invalid_op+0x17/0x40
[  330.674758]  ? asm_exc_invalid_op+0x1a/0x20
[  330.675307]  ? bd_may_claim+0x196/0x1d0
[  330.675872]  bd_prepare_to_claim+0x1a4/0x260
[  330.676420]  ? __pfx_bd_prepare_to_claim+0x10/0x10
[  330.677024]  ? kobject_get_unless_zero+0xca/0x160
[  330.677634]  ? _atomic_dec_and_lock+0x18/0x90
[  330.678169]  ? iput.part.0+0x5a/0x620
[  330.678705]  blkdev_get_by_dev.part.0+0x67/0xa00
[  330.679252]  ? devcgroup_check_permission+0x12d/0x310
[  330.679924]  blkdev_get_by_path+0x170/0x240
[  330.680431]  ? __pfx_blkdev_get_by_path+0x10/0x10
[  330.680971]  ? __kasan_kmalloc+0xaa/0xb0
[  330.681501]  f2fs_fill_super+0x531d/0x8d50 [f2fs]
[  330.682126]  ? snprintf+0xab/0xe0
[  330.682555]  ? __pfx_f2fs_fill_super+0x10/0x10 [f2fs]
[  330.683196]  ? sget+0x2db/0x560
[  330.683616]  ? __pfx_f2fs_fill_super+0x10/0x10 [f2fs]
[  330.684272]  mount_bdev+0x25d/0x310
[  330.684752]  ? __pfx_f2fs_mount+0x10/0x10 [f2fs]
[  330.685306]  legacy_get_tree+0x106/0x200
[  330.685818]  ? __pfx_bpf_lsm_capable+0x10/0x10
[  330.686317]  vfs_get_tree+0x8d/0x330
[  330.686804]  __do_sys_fsconfig+0x7b3/0xad0
[  330.687273]  ? __pfx___do_sys_fsconfig+0x10/0x10
[  330.687818]  ? lockdep_hardirqs_on_prepare+0x27f/0x3f0
[  330.688432]  ? lockdep_hardirqs_on_prepare+0x27f/0x3f0
[  330.688988]  do_syscall_64+0x60/0x90
[  330.689413]  ? lockdep_hardirqs_on_prepare+0x27f/0x3f0
[  330.690010]  ? do_syscall_64+0x6c/0x90
[  330.690455]  ? do_syscall_64+0x6c/0x90
[  330.690889]  ? do_syscall_64+0x6c/0x90
[  330.691335]  ? lockdep_hardirqs_on_prepare+0x27f/0x3f0
[  330.691916]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  330.692521] RIP: 0033:0x7f8348ed98be
[  330.692943] Code: 73 01 c3 48 8b 0d 4a 05 0c 00 f7 d8 64 89 01 48 83 c8 =
ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 05 0c 00 f7 d8 64 89 01 48
[  330.941768] RSP: 002b:00007fff70300468 EFLAGS: 00000246 ORIG_RAX: 000000=
00000001af
[  331.027163] RAX: ffffffffffffffda RBX: 00000000006766a0 RCX: 00007f8348e=
d98be
[  331.027937] RDX: 0000000000000000 RSI: 0000000000000006 RDI: 00000000000=
00003
[  331.028669] RBP: 0000000000677820 R08: 0000000000000000 R09: 00000000000=
00001
[  331.029413] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[  331.030099] R13: 00007f8349071f04 R14: 00007f8349070540 R15: 00000000006=
767e0
[  331.030889]  </TASK>
[  331.031148] irq event stamp: 12117
[  331.031542] hardirqs last  enabled at (12127): [<ffffffff973f056e>] __up=
_console_sem+0x5e/0x70
[  331.032436] hardirqs last disabled at (12136): [<ffffffff973f0553>] __up=
_console_sem+0x43/0x70
[  331.033234] softirqs last  enabled at (12058): [<ffffffff9723cfa6>] __ir=
q_exit_rcu+0x146/0x190
[  331.034130] softirqs last disabled at (12049): [<ffffffff9723cfa6>] __ir=
q_exit_rcu+0x146/0x190
[  331.035019] ---[ end trace 0000000000000000 ]---
[  331.035513] F2FS-fs (nullb0): Failed to find devices=
