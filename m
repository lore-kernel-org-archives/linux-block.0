Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53585C07E99
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 03:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2494B613B5
	for <linux-block@archiver.kernel.org>; Fri,  9 Jul 2021 03:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGID7u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jul 2021 23:59:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38409 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhGID7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jul 2021 23:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625803027; x=1657339027;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BPRnsw9xf+Ifok0Bf/t2HBmnuRH0d6xxSQnh1JlBbzc=;
  b=o4+JwRBd1qVh+xZvmdW7hntfRXqIfLLlC33aGotayMRxVDp1vS7ofHlY
   oCqP1SL2IXddqKRb5D5McsYHgkJG+HRwbY20IcDSZPTPbkM/z1prL6eW1
   A9GeoMLQxbbRMSEco0j54o5XCF5Hg974Nobr02DdqkKv4ThVsuFhbe1pZ
   jYHcK4yhtXWYFmcyLYfsCiPfeAiZ9K1fPnhGVCQVZUESfTZBl7p7lKdSr
   KLqy9hVPuN/rBglkDAMeobG8sQ6+21ZwRz8z6aNPCZB13Bdckg9/QXsL/
   kv9tMQ2AOu29DnAz/mcWsE799DFvDC+toXCoCbCl+yU8f8vqGmeqrMspP
   w==;
IronPort-SDR: 9ehbhOLqayTXn8g/JUKtpLP4WiLZCvFCbVigUL3NeqYVL4ZdkYtTSnCVCdgJ6hH/N0p7YMxu5r
 9Cv8qHwG5NWoaztu4X2u9HVQ5NzuLjUdRLfj8NEBuvEt3rtG7jlYRKqBX/MYi//dCBlI9DJx/n
 H7q53cgAsxBrUmh/Ts/xIUTOHm83tzCbFjQ24NnFZK+qATRiLMD1TZDQA+lMiLnP94m5A8tLSF
 IXmdgKh/ScBLeLUIvQ7Il39QpgRmu9ryq4MVMKsypAwjFyLY1f9KEm5hwE+rUdDLKaG9sx+I8b
 77Y=
X-IronPort-AV: E=Sophos;i="5.84,225,1620662400"; 
   d="scan'208";a="178929885"
Received: from mail-bn8nam08lp2047.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.47])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2021 11:57:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD2Fk2PKin8yMI7GoKOKAvdmblaWfMPQVLphDtlcP6qGiRw1QhymUE0pB8Bw4lc2XzzrSkl58Yzw1lY3GWoNnTw97UZBo1FJuVIZvsq8dWYn7taNqQ1+g0GI7IVJoSmn65H0ZQ4XQXX0Im1ipR4l+fpXsxoG9AHB+ccu70IGg7bE87jYl4hD3e9YeWUHrFkQfcHXEN6Fs2uVGA3VhiNwX/wMXeKo1+OnuqxZct4LwQIoQi0Q/wo4bvOLRKQa7/aY3JdKiWln4VenRusMNWhZBd/QIhC39CAXIkzCYk0SdfEdJnPutRXHjRZdPxBf/uRzYZXS1PM1iL5XXk70vtKkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEMgdM6taND7TxY8Tinyq+oDAe2M4HNxq0VzwyzvTLI=;
 b=aT4tUj200ttfcjUh2c3B0wfxu+s+TgYYnRUEKuDQFLesz0a6Df4yjnRXPTLgXCua4WfOSHd8FZQ4zKjQiZ+ii7Kjl0Tym/+AccB6OOGlJM4nBty7QGWZEvrTlwMzNCn2SzStwMWZzRHrGDg7o2aDOhZ2ff+sE1gfMcNjfu64rX+55Fvqm79oYPZPnMQQLYMGfJDgbu+vvN01ln0jPRhp7ERTJqFwP32vacwhiK03pdJXFaBylKLbYnBfxNN2N450ZmVWMmaPIrpiOLy3blkGlqrzA9qcXy+rnxhljoYlOrZrtMH7JtGMlKADPOH5+FWG1XVdVDu/HtpFKPujZA2VRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEMgdM6taND7TxY8Tinyq+oDAe2M4HNxq0VzwyzvTLI=;
 b=0M+7EgrfxJthZ/lPVRHPOjD3VCIK8BO14OSBC2Cbg6HBs0ZQxpY9CvdozEyouMAonmGM0+U5RENf3HgrkXRQ/GTai/nIL5scENfzcehWW4d+5dWbP4okT+tReRlxITIn6NOnkiGHBpw4Wi0RNVGcJQVWsoRtMwyhE+J5LUBHqPY=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BY5PR04MB6582.namprd04.prod.outlook.com (2603:10b6:a03:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 9 Jul
 2021 03:57:05 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625%3]) with mapi id 15.20.4308.023; Fri, 9 Jul 2021
 03:57:04 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Topic: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Index: AQHXXPwtp5wIJLz/bUO+HXbRCV2UY6sM7DEAgBwKMgCAETyZAA==
Date:   Fri, 9 Jul 2021 03:57:04 +0000
Message-ID: <20210709035704.mvhtxxr6ewootlpz@shindev>
References: <20210609065339.aecrkqc6dj3xgbiw@shindev.dhcp.fujisawa.hgst.com>
 <20210610083200.3832-1-hdanton@sina.com>
 <20210628044346.jo3xzlxhnxuxt7nz@shindev>
In-Reply-To: <20210628044346.jo3xzlxhnxuxt7nz@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6acb048f-81f7-47fc-8d0c-08d9428d9d7d
x-ms-traffictypediagnostic: BY5PR04MB6582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6582CE1AF744D457CFBC56B7ED189@BY5PR04MB6582.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itOdwsObN5aOIey8qiT6C3xh4sifE/JTsiTFEtAyVk74eBBUifNyJRfIx6MmI976Sds6kFyASza7wWHbL7P6cdWYsxxF+955snv+y2JLuIL0phBVKRSHbopDODLhb0nWRY+NL+IALR8dDq17F+k4EfEhVKbTaTgqLZsvYP8MWOihBKyzk+OTw2pE46HxTgPRlLhBoIehQd3vEMLlvM9X2G8yHTQ8wS2BtRp60mqY2R1G95hABzVmZ409P3D3V88BuZ87f5c6SaeRPzXxxrk/lwZ3nMVmLvmcBKfrfmGKMzIxu2rG0E3I5KIhDGd5nfsBwYSRVcVAxS2RnKVOdFIDaQrie/awZSa+6PbgTv4O7CRG0XvzKW+TUUN9DomD/RI1crlOV6YEB/yBlTP7Z1NGvEJaqwiaC+v35FXMWsc2mg8OEB0Uo0R0mmEbX3c0L8k8UTRiayfHBdSYyBQjd5YrFkT2IjKrvGIFHTY+zWqhjUvSkZ/g8XemxK02u4hxMzOdTp1CSJ4KY3P7V0RxeLboOrpGTMOjX1jsX66Zo9qBAviSxCh9t/SbffzuOEs/IVcK6sasdzzGDm7BxJTGyEotZDUNstdgAxiAZweiu5e2f+smuQ4KWdtJTtmwgte35TliOCGgYocbbIjclw8TpSD8Dw8/DXviZ2j7nVRy0fNVOP0ZYXoroZD+xgRrID4yBHR/HJf6+aA8SSVbljopp8srItYz3+RBp8pnWuk0RvXvJyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(6512007)(66476007)(71200400001)(5660300002)(86362001)(6916009)(33716001)(2906002)(6506007)(478600001)(66946007)(44832011)(66446008)(64756008)(966005)(9686003)(316002)(66556008)(1076003)(54906003)(45080400002)(38100700002)(8936002)(4326008)(83380400001)(186003)(26005)(122000001)(91956017)(6486002)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V9XsRffc/rYYNNJh9W4WNh6TQuuFn9pnAOoApCtxanDlg1IpFZpuLFFUD4hY?=
 =?us-ascii?Q?lfQ+bY+UKS+uuYvr8PoODJ3krqTG6KJ42rDrxW/Fd8/L8AMnOmZcM0oJ9cCw?=
 =?us-ascii?Q?OjNu0hhfHTxMxyPzgmBlE2AjiJuT5OJJZPsARokFo+6/9vW//V7XaefnLlqQ?=
 =?us-ascii?Q?rwEQAztSgOXTjXMKabyPeNmVlW7MI1GhRFt2ogKkCfE7I/nGPLQ8kKTxMlhk?=
 =?us-ascii?Q?g23S9GOVZ2xIpqTPpW9s70LlERdDo3qzNudkK0jdqdRNouDCDK1Hk4ayKaPh?=
 =?us-ascii?Q?D7RYdTh3fZuKDjpD3AlRIuHvzDzLVuRcgpCZP6Y9XF6tSMqBstMJb/6MYA0M?=
 =?us-ascii?Q?rcunJ2cuAE7knwXhjsDUStH0UEB94jTnNI1Xy0VdiJfWFTql7vOl7mMZGFdw?=
 =?us-ascii?Q?clHt57cLVSZEzu5ZoXJ+YrxZZYNjk4eQ9gCFqcxSymMqxypTev81if9w7Iou?=
 =?us-ascii?Q?yNLdeI76hvUCAf2eEjoYLy1JWdDv9IDP0oDP3u9ThlOQX8OzqY9gwsSB7AHZ?=
 =?us-ascii?Q?/O+9Ni7YIXpV6TbkmZCx9pADtM6EyQYXiGaO9kXQS6NnhVe2tQpe6IpvHTYr?=
 =?us-ascii?Q?vFpgJT36YOyHI74QdVH2BGbj7auX6yPnXnZVC5cu6JKUPwdTb14tpc1GXnFT?=
 =?us-ascii?Q?a4yNVBmi9Imgy4Hd6egrqOEHtwryB2aveVYU6Qtmg/VLyV1UhkkYSK2kPtRn?=
 =?us-ascii?Q?xYcAQN+2n+SRWFXHMhsAq8mlrhRBXWeKc1A6rj13bzkRwo4UYYJ9Cp1N8ltS?=
 =?us-ascii?Q?5rup05xuJerose/3cqTqodLHwziSqjf6PY5N72GnDsgCPineBYRj4IO9QSEY?=
 =?us-ascii?Q?86m8GTU61T5BsRdX0+MvjMup9YszYcTWeYQwSOktf0jo38OI+S4YgV/Jro7D?=
 =?us-ascii?Q?osPE2VCTc354KNK7wF+NzT5SszT2Qj/Hf1gMDpRhYHvBtTiOnuA8H+93lnbS?=
 =?us-ascii?Q?Gi1nliGrmmdU9Hv0F8GRzmrlOaja6uk+4hLA6D4ECULDww/oi13fJ0whuRXF?=
 =?us-ascii?Q?cZ4MIUd+8XJKoCKZqfb6cBqzwbKNnXWVu/l1nDllOP/rcfCkoD9aThNWVeGy?=
 =?us-ascii?Q?Le5srIwgYOujEDfcDll8rpcRMz/L1E9igMU/izGcuhHd48Jdnz1eTrQRgcJc?=
 =?us-ascii?Q?rt5x7xWKbsGn1PL+dKx/WMvEeGfmI82tOrk/PGTRy6kBmEB6qb4nWiZwwSzG?=
 =?us-ascii?Q?FrSDhoMqAgsUzPSVjze0Up/vwNRgFrzhI1U2gxdUhRE9zM206xCDU7AKNBEx?=
 =?us-ascii?Q?t/KfYn1/mPalVoZoQ464jOogEfaFUbV+xMHajiDqocvOgCXY2f/XwptA8YNV?=
 =?us-ascii?Q?LeGZbBpGANFuwGAVpQIw2hAKSGKt18f/NQN5+7v6Zh7jKw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CB45D3A1BC71B4CA3CC5C8F6BEB86C9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acb048f-81f7-47fc-8d0c-08d9428d9d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2021 03:57:04.8353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KN+m3GZwtthuAxzgaMXGxCqMTu2B9pDnmQznmQKxGy3ejLOvfzF3EM/mLf4X2YVCtrk/VpshNm+P2vwwH8UETK3afZtj99ZMKwE/y3CFWDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6582
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 28, 2021 / 13:43, Shin'ichiro Kawasaki wrote:
> On Jun 10, 2021 / 16:32, Hillf Danton wrote:
> > On Wed, 9 Jun 2021 06:55:59 +0000 Damien Le Moal wrote:
> > >+ Jens and linux-kernel
> > >
> > >On 2021/06/09 15:53, Shinichiro Kawasaki wrote:
> > >> Hi there,
> > >>=20
> > >> Let me share a blktests failure. When I ran blktests on the kernel v=
5.13-rc5,
> > >> block/008 failed. A WARNING below was the cause of the failure.
> > >>=20
> > >>     WARNING: CPU: 1 PID: 135817 at kernel/sched/core.c:3175 ttwu_que=
ue_wakelist+0x284/0x2f0
> > >>=20
> > >> I'm trying to recreate the failure repeating the test case, but so f=
ar, I am
> > >> not able to. This failure looks rare, but actually, I observed it 3 =
times in
> > >> the past one year.
> > >>=20
> > >> 1) Oct/2020, kernel: v5.9-rc7  test dev: dm-flakey on AHCI-SATA SMR =
HDD, log [1]
> > >> 2) Mar/2021, kernel: v5.12-rc2 test dev: AHCI-SATA SMR HDD, log [2]
> > >> 3) Jun/2021, kernel: v5.13-rc5 test dev: dm-linear on null_blk zoned=
, log [3]
> > >>=20
> > >> The test case block/008 does IO during CPU hotplug, and the WARNING =
in
> > >> ttwu_queue_wakelist() checks "WARN_ON_ONCE(cpu =3D=3D smp_processor_=
id())".
> > >> So it is likely that the test case triggers the warning, but I don't=
 have
> > >> clear view why and how the warning was triggered. It was observed on=
 various
> > >> block devices, so I would like to ask linux-block experts if anyone =
can tell
> > >> what is going on. Comments will be appreciated.
> >=20
> > [...]
> >=20
> > >> [40041.712804][T135817] ------------[ cut here ]------------
> > >> [40041.718489][T135817] WARNING: CPU: 1 PID: 135817 at kernel/sched/=
core.=3D
> > >c:3175 ttwu_queue_wakelist+0x284/0x2f0
> > >> [40041.728311][T135817] Modules linked in: null_blk dm_flakey iscsi_=
targe=3D
> > >t_mod tcm_loop target_core_pscsi target_core_file target_core_iblock n=
ft_fi=3D
> > >b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv=
4 nf_=3D
> > >reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mang=
le ip=3D
> > >6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag=
_ipv6=3D
> > > nf_defrag_ipv4 iptable_mangle iptable_raw bridge iptable_security stp=
 llc =3D
> > >ip_set rfkill nf_tables target_core_user target_core_mod nfnetlink ip6=
table=3D
> > >_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_com=
mon x=3D
> > >86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass =
iTCO_=3D
> > >wdt intel_pmc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore j=
oydev=3D
> > > lpc_ich i2c_i801 i2c_smbus ses enclosure mei_me mei ipmi_ssif ioatdma=
 wmi =3D
> > >acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_p=
ad zr=3D
> > >am ip_tables ast drm_vram_helper drm_kms_helper syscopyarea sysfillrec=
t crc=3D
> > >32c_intel sysimgblt
> > >> [40041.728481][T135817]  fb_sys_fops cec drm_ttm_helper ttm ghash_cl=
mulni=3D
> > >_intel drm igb mpt3sas nvme dca i2c_algo_bit nvme_core raid_class scsi=
_tran=3D
> > >sport_sas pkcs8_key_parser [last unloaded: null_blk]
> > >> [40041.832215][T135817] CPU: 1 PID: 135817 Comm: fio Not tainted 5.1=
3.0-r=3D
> > >c5+ #1
> > >> [40041.839262][T135817] Hardware name: Supermicro Super Server/X10SR=
L-F, =3D
> > >BIOS 3.2 11/22/2019
> > >> [40041.847434][T135817] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
> > >> [40041.853266][T135817] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 48=
 8b 4=3D
> > >c 24 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be 71=
 64 0=3D
> > >0 eb a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 49 71 64 00 48 =
8b 04=3D
> > >
> > >> [40041.872793][T135817] RSP: 0018:ffff888106bff348 EFLAGS: 00010046
> > >> [40041.878800][T135817] RAX: 0000000000000001 RBX: ffff888117ec3240 =
RCX: =3D
> > >ffff888811440000
> > >> [40041.886711][T135817] RDX: 0000000000000000 RSI: 0000000000000001 =
RDI: =3D
> > >ffffffffb603d6e8
> > >> [40041.894625][T135817] RBP: 0000000000000001 R08: ffffffffb603d6e8 =
R09: =3D
> > >ffffffffb6ba6167
> > >> [40041.902537][T135817] R10: fffffbfff6d74c2c R11: 0000000000000001 =
R12: =3D
> > >0000000000000000
> > >> [40041.910451][T135817] R13: ffff88881145fd00 R14: 0000000000000001 =
R15: =3D
> > >ffff888811440001
> > >> [40041.918364][T135817] FS:  00007f8eabf14b80(0000) GS:ffff888811440=
000(0=3D
> > >000) knlGS:0000000000000000
> > >> [40041.927229][T135817] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033=3D
> > >
> > >> [40041.933756][T135817] CR2: 000055ce81e2cc78 CR3: 000000011be92005 =
CR4: =3D
> > >00000000001706e0
> > >> [40041.941669][T135817] Call Trace:
> > >> [40041.944895][T135817]  ? lock_is_held_type+0x98/0x110
> > >> [40041.949860][T135817]  try_to_wake_up+0x6f9/0x15e0
> >=20
> > 2) __queue_work
> >      raw_spin_lock(&pwq->pool->lock) with irq disabled
> >      insert_work
> >        wake_up_worker(pool);
> >          wake_up_process first_idle_worker(pool);
> >=20
> > Even if waker is lucky enough running on worker's CPU, what is weird is=
 an
> > idle worker can trigger the warning, given
> >=20
> > 	if (smp_load_acquire(&p->on_cpu) &&
> > 	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
> > 		goto unlock;
> >=20
> > because p->on_cpu must have been false for quite a while.
> >=20
> > Is there any chance for CPU hotplug to make a difference?
> >=20
> > Thoughts are welcome.
> >=20
> > Hillf
>=20
> Hillf, thank you very much for the comments, and sorry about this late re=
ply.
>=20
> I walked through related functions to understand your comments and, but I=
 have
> to say that I still don't have enough background knowledge to provide val=
uable
> comments back to you. I understand that the waker and the wakee are on sa=
me CPU,
> and it is weird that p->on_cpu is true. This looks indicating that the ta=
sk
> scheduler failing to control task status on task migration triggered by C=
PU
> hotplugs, but as far as I read comments in kernel/sched/core.c, CPU hotpl=
ug and
> task migration are folded into the design and implementation.
>=20
> The blktests test case block/008 runs I/Os to a test target block device =
30
> seconds. During this I/O, it repeats offlining CPUs and onlining CPUs: wh=
en
> there are N CPUs are available, it offlines N-1 CPUs to have only one onl=
ine
> CPU, then onlines all CPUs again. It repeats this online and offline unti=
l I/O
> workload completes. When the only one CPU is online, the waker and the wa=
kee can
> be on the same CPU. Or, one of the waker or the wakee might have been mig=
rated
> from other CPUs to the only one online CPU. But still it is not clear for=
 me why
> it results in the WARNING.
>=20
> Now I'm trying to recreate the failure. By repeating test cases in "block
> group" on the kernel v5.13-rc5, I was able to recreate the failure. It to=
ok 3 to
> 5 hours to recreate it. The test target block device used was a null_blk =
with
> rather unique configuration (zoned device with zone capacity smaller than=
 zone
> size). I will try to confirm the failure recreation with latest kernel ve=
rsion
> and other block devices.

I tried some device setups, and found that dm-linear device on null_blk
recreates the warning  consistently. In case anyone wishes to recreate it, =
let
me share the bash script below which I used. I tried it several times on th=
e
kernel v5.13, and all tries recreated the warning. With my system (nproc is=
 8),
it took from 3 to 6 hours to recreate.

---------------------------------------------------------------------------=
-----
#!/bin/bash

# create a null_blk device
declare sysfs=3D/sys/kernel/config/nullb/nullb0
modprobe null_blk nr_devices=3D0
mkdir "${sysfs}"
echo 1024 > "${sysfs}"/size
echo 1 > "${sysfs}"/memory_backed
echo 1 > "${sysfs}"/power
sleep 1

# create a dm-linear device on the null_blk device
echo "0 $((0x2000 * 4)) linear /dev/nullb0 0" | dmsetup create test
sleep 1

# run blktests, block/008 many times
git clone https://github.com/osandov/blktests.git
cd blktests
echo "TEST_DEVS=3D( /dev/mapper/test )" > config
for ((i=3D0;i<1000;i++)); do
        echo $i;
        if ! ./check block/008; then
                break;
        fi
done

--=20
Best Regards,
Shin'ichiro Kawasaki=
