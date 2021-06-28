Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA7C2B9F4
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 04:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F6761C31
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 04:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhF1EqS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jun 2021 00:46:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60483 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhF1EqR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 00:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624855431; x=1656391431;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iUbIF2J9MSBvGWn6Bshtlz/NtvdryAOYOUJrxtXn0hY=;
  b=T1V1ZlfpDU9k0OfFkM/AO6yBpHy1SNcnrHdrJ4SWsDJyOZREwHmCBrJc
   b3DlutWFV7VjpF+JxRfDfy79407uqHwWELucKxe7Cpc7J0rfPgMhs0jTz
   ofMQn4EirSNedrFmZUBYUEcDP+9jnuLUVl7yBc3Bpes8x4cS1foExvUKb
   pYKm5WO6sRbvPtvQWKut1oew0ZkjVslp8EThwEUjJZxB+wiRDM4WdhQFl
   DgNiTmpSBuABgqT2NTQRp2qnKWFfmMmeyfLrQ9PkQBAZImlr7wduSqm9H
   OZXb79qMYg5pPizOHbTMvJ0e0UTWDAxxh+r+XdSu1VLwqaLeGXzQg56DQ
   Q==;
IronPort-SDR: bZDOLeOV9NsLe8PXZx2YWre3ROSPop36A7a1F5Rp9RDMfa74xZTmPlg1EIHqLcOD57B5vMuRut
 gacvzafCm04CRu12wx8vYsIQvTOawRYa9LMbipBn0AXsg0SFxcqakMABxcHwHOMZCZ7jMdfCPx
 foyZLnwnh18wbAx+ZFgwfpfzKJ5uDpSKPoXPr/v07SB+YlMDusLHkelp0gPD5JKw/bMjJT66gP
 VviPY+y9bRbLS9NCp4xGTr+Bj9PP2KDnLUdLliQizsZntxlKZqS4T/Vepa8H88eiuudKf8XAiO
 XpY=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; 
   d="scan'208";a="177846316"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 12:43:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt25xJ8gkmjRsddRWBCqDfxAd+z9xAsAdKGlchRxbfg2TdKaSMPD0vcOxCzYXJbfIIrduPbRoANzXm9YyXvCn6YdWrBoHvvtjgxW9y5KlU+d7lH3/FaFudsI5VAPzPAang4XOKbF5Jpiqmm7EILKdi8xJMBI+c2WPOOCC9dQ+nb3zqjbsa1KctZJt/5nCSNC7PuKcuYTTpabaj6Dp54sVUK5AMLUV3yVpDU6qVRUcZD8ufuk0oN9Dm3gqcIFPtRP4L4pLw1z+LgB4nW4XJfY5+h/XSRQJ33S8rLaGcuVedfw7ChbI1bhSa+NjLtsYIb20f/5qMcGLMb+ktjtg40I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZWEdInbWgCwrpQkqEmpPBWe+BHjkLWHBAsYRigXpGM=;
 b=EvIB+c23QM3WvJE/U2FBQ7W52EZDdHQ7kGIavHzAL6PDYBB+e/wu7DdhFmb/uMV+69j+MxE4TjF/gV41raYfYAZptPzunZpf7EXigqVKyP6jfXwtjR3gBTNVi9Scqobq3/DgfAhdTT1V9yT04WiRiBUAR0P4ezCNawXNbPIiQLdLVQuqzR+jtrLlpu36Iwzs32hLXrUvtidYMCIZPLQsZfo+5r+/dmTSeYm9Fa8mXYsmsCGYpfPj1ruLdkgUxKX0i//PgBO5Sew0WQp0J4qSBTXA4tA91TS6NC3cdVFKdHPuNXsH7FS8ISjyX/JKsd2+W/ozWg4LW9J3e/ww5yoXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZWEdInbWgCwrpQkqEmpPBWe+BHjkLWHBAsYRigXpGM=;
 b=R1hFIum+sjxrQ3G3fjVWkOMJF80NI7DRkSmD2rwqEPpKev8aNA40PTDqmDCPd9+7MSZOeJ5ENVr78krSeh5rlTSp2Zvv6J3a6LITRWWnvnkChH1VMsH9zMW5KGeNi3LWFr+iRFwZiyRehb7zj9zGNaxAbLlXMCXMy6I0n7Z3N14=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by SJ0PR04MB7295.namprd04.prod.outlook.com (2603:10b6:a03:29f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 04:43:47 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::84d7:af4e:7223:2f2]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::84d7:af4e:7223:2f2%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:43:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Topic: WARNING at blktests block/008 in ttwu_queue_wakelist()
Thread-Index: AQHXXPwtp5wIJLz/bUO+HXbRCV2UY6sM7DEAgBwKMgA=
Date:   Mon, 28 Jun 2021 04:43:47 +0000
Message-ID: <20210628044346.jo3xzlxhnxuxt7nz@shindev>
References: <20210609065339.aecrkqc6dj3xgbiw@shindev.dhcp.fujisawa.hgst.com>
 <20210610083200.3832-1-hdanton@sina.com>
In-Reply-To: <20210610083200.3832-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea5b3f4d-3fb0-4624-4650-08d939ef515b
x-ms-traffictypediagnostic: SJ0PR04MB7295:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7295A1A15A4804134506C131ED039@SJ0PR04MB7295.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y6qBq0X7m6uQ+/W/Z9XLVLtujifdxRgZt23H4cdLJ+wuTbeks1Cc040IZD//SaZIMUVnpFEuv3dHUukmz9H5UKmG7WlC2NUlSRHi5dXJwWr6zEwgPPU/ykrjaW3mQ3pTEeumvIKU3wKHY3TYEu3+yGY104bPg+v+oblFEcKvrjR75KUcK/ZW5Zh+9tEKO9gfBIRjV2FCwN/nbKTvHFpi6HQdbiQ0ORE91xXfMnVQknkWptrVdtLujFt6r6deuwuPZVaz98p7nv0nQ/uQ+zuGyowayc2fXaE0LrUNQoEhRsqHxGbqeb2DbGW/Jt+V6CtIeu8hu7cuYnM/UXkCdkmt/yfYGj9alc9IEC7Rc6F1XwaiZUR19mAUtc550B58KiMDf3F5kEXq5NYDhBwqKxjLcQG6wCPlEDM090oRZO4VqRPhQ9TBOCZFGtve0sHQqfApN5tjaNqkRBnIDm/uL9v0pQVzp5/tQA7k8MytnXqFaYEdIziLoeTw7LZt9aCNSeibC2xYTynoX5mjCdJTYSg0n+YGYEzRj3V7n6b/NQLFz2f9mNZzalpTspsJK+943q+ulNBn5YHBiYMhrSPxCEKiIszbKRxjivRXq5gT4P4A5yE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(54906003)(86362001)(33716001)(9686003)(6512007)(4326008)(5660300002)(316002)(6486002)(66476007)(64756008)(30864003)(91956017)(76116006)(66556008)(66446008)(1076003)(66946007)(71200400001)(186003)(122000001)(38100700002)(8676002)(8936002)(478600001)(83380400001)(6506007)(6916009)(26005)(44832011)(45080400002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dcbgEKX7qiMgS213ga0PuYsKazldn9fEOyJngK5g0ZSZ5/e0ke1WFMUkQga2?=
 =?us-ascii?Q?QkGBPKW5rU9ShW6+UaOuppbdn7z48/WH/oPsKUZ+OI7dSAAzxbmVQOYAayPo?=
 =?us-ascii?Q?NbBBAH/AVkLXdbU8IyH7TcJi7iTOamj/aAMg2PgEmr0I+AcamPDOqxob+FzB?=
 =?us-ascii?Q?UPiyYULOeRI0grbjHQAglF+kVboST2SYVidrURnFnv+NHaLPTLWxyGLZFrud?=
 =?us-ascii?Q?0nvD5AMvWIzHf3OWYi4AKZfBB/HF/oVTLUBoRARYacGA77EumFrorBEXQzBx?=
 =?us-ascii?Q?g+yj0BDgsU5C5K1wQtdcML1QT6zw8Bhm9U/lAoz1SCx9IhCL06JojSCyuZBJ?=
 =?us-ascii?Q?FCVE48njUCFmjjEb9m19ukEkF3uu/sJ0aqkpEOSw7BIMarpirVPG4eLsLQfx?=
 =?us-ascii?Q?FxqKzC8MRBpWYkkwL5GRUygYQiwidMNhOaOZf96o1b7RBZe2SNEcbSErK9sB?=
 =?us-ascii?Q?A8MLd+SUV3vmkuUTRIlLcprVlwtZ04onHXf7U0W6NCT+AgqTp+yqSqQoXqfr?=
 =?us-ascii?Q?yPIZ5C7kzQq3dv3Jym/2/sh8ggwMnXwBHU2dvc9ssl0CiPYc47KXOqaAuXdl?=
 =?us-ascii?Q?5jqivoOUQ2Qt8aVbVPZ0bewKJ0oEKMNb1DqfabPaSULyBkFx6CXE9HE6m7g7?=
 =?us-ascii?Q?PiZQrcZG/cwCr4v23T+mKjhdg4wj97mugMCx76KA1leXI6qWN6tLG/z4fxZ3?=
 =?us-ascii?Q?vEur40Q4hll2smMYdRMjDcColCyBF33h1wr9gt2s4XfcC7e1/OcsqnGPN2iQ?=
 =?us-ascii?Q?qW1fJzdPIBysy/jTvyBhI8FwGEahzLD5+n1YvQHZxxBN5nYTPrPEFPMaubxi?=
 =?us-ascii?Q?0NEK9RG3VaCnQeDJeblo1tpCg/6Em0TrpDHKYSQeThozuShzhJYJJIVbM9CS?=
 =?us-ascii?Q?3QgENbIn4lzzAmx+gzN6smwsDI0k7UfGw/Q3M6MqOnv1hPnkhNk5EZGm4a9n?=
 =?us-ascii?Q?NgSZMQdnMj9YipzAZD+JnG78qEVs59IapN2WIVNmQlH4Zq9U1HsZVa/gdk8X?=
 =?us-ascii?Q?jEb2UM8a+XLBg3rDD04I5kmv/sNXQuaftezS975wSxULY/PsIKy8PsnNyzdr?=
 =?us-ascii?Q?GMeD57H87zzu+qJ8EJ//hAgKzd5oW1ZmjM6jNceUY5b4IGtbrght4dIpko04?=
 =?us-ascii?Q?4eBxAVs22wIovfsHS3ohcGzzWtI9WvzEQdHddOUYUXbQcBrLuwKn+ubVr0mN?=
 =?us-ascii?Q?aUQQ7uOF+NIqZxa/GIrSaKD8Mg+kV/xY+kZTNd/UpTqZiFwjHlu5TPC73wLr?=
 =?us-ascii?Q?CLICKfCX34/6RGS9D/6dioxcP+EXh1GbYdMLCMMC/0C2QyocV0zMPdHqRjMK?=
 =?us-ascii?Q?bUMQVBjm2JpV5AJVnMQkeI08AbjwmStp1pBseGpu4clbpg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB8B4BE749A77B4483C545EB89A173E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5b3f4d-3fb0-4624-4650-08d939ef515b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 04:43:47.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rUuZV140jp9etwOBKTrdvK0mGDGuH+4cq2JAWtbWLDDNyk60Bu1WfA7isxgi6sTCa9xXzrJT061IsRSmidMbbpA2zYRVaS/zbkQjlgTy/2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7295
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 10, 2021 / 16:32, Hillf Danton wrote:
> On Wed, 9 Jun 2021 06:55:59 +0000 Damien Le Moal wrote:
> >+ Jens and linux-kernel
> >
> >On 2021/06/09 15:53, Shinichiro Kawasaki wrote:
> >> Hi there,
> >>=20
> >> Let me share a blktests failure. When I ran blktests on the kernel v5.=
13-rc5,
> >> block/008 failed. A WARNING below was the cause of the failure.
> >>=20
> >>     WARNING: CPU: 1 PID: 135817 at kernel/sched/core.c:3175 ttwu_queue=
_wakelist+0x284/0x2f0
> >>=20
> >> I'm trying to recreate the failure repeating the test case, but so far=
, I am
> >> not able to. This failure looks rare, but actually, I observed it 3 ti=
mes in
> >> the past one year.
> >>=20
> >> 1) Oct/2020, kernel: v5.9-rc7  test dev: dm-flakey on AHCI-SATA SMR HD=
D, log [1]
> >> 2) Mar/2021, kernel: v5.12-rc2 test dev: AHCI-SATA SMR HDD, log [2]
> >> 3) Jun/2021, kernel: v5.13-rc5 test dev: dm-linear on null_blk zoned, =
log [3]
> >>=20
> >> The test case block/008 does IO during CPU hotplug, and the WARNING in
> >> ttwu_queue_wakelist() checks "WARN_ON_ONCE(cpu =3D=3D smp_processor_id=
())".
> >> So it is likely that the test case triggers the warning, but I don't h=
ave
> >> clear view why and how the warning was triggered. It was observed on v=
arious
> >> block devices, so I would like to ask linux-block experts if anyone ca=
n tell
> >> what is going on. Comments will be appreciated.
>=20
> [...]
>=20
> >> [40041.712804][T135817] ------------[ cut here ]------------
> >> [40041.718489][T135817] WARNING: CPU: 1 PID: 135817 at kernel/sched/co=
re.=3D
> >c:3175 ttwu_queue_wakelist+0x284/0x2f0
> >> [40041.728311][T135817] Modules linked in: null_blk dm_flakey iscsi_ta=
rge=3D
> >t_mod tcm_loop target_core_pscsi target_core_file target_core_iblock nft=
_fi=3D
> >b_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 =
nf_=3D
> >reject_ipv6 nft_reject nft_ct nft_chain_nat ip6table_nat ip6table_mangle=
 ip=3D
> >6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_i=
pv6=3D
> > nf_defrag_ipv4 iptable_mangle iptable_raw bridge iptable_security stp l=
lc =3D
> >ip_set rfkill nf_tables target_core_user target_core_mod nfnetlink ip6ta=
ble=3D
> >_filter ip6_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_commo=
n x=3D
> >86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass iT=
CO_=3D
> >wdt intel_pmc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore joy=
dev=3D
> > lpc_ich i2c_i801 i2c_smbus ses enclosure mei_me mei ipmi_ssif ioatdma w=
mi =3D
> >acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter acpi_pad=
 zr=3D
> >am ip_tables ast drm_vram_helper drm_kms_helper syscopyarea sysfillrect =
crc=3D
> >32c_intel sysimgblt
> >> [40041.728481][T135817]  fb_sys_fops cec drm_ttm_helper ttm ghash_clmu=
lni=3D
> >_intel drm igb mpt3sas nvme dca i2c_algo_bit nvme_core raid_class scsi_t=
ran=3D
> >sport_sas pkcs8_key_parser [last unloaded: null_blk]
> >> [40041.832215][T135817] CPU: 1 PID: 135817 Comm: fio Not tainted 5.13.=
0-r=3D
> >c5+ #1
> >> [40041.839262][T135817] Hardware name: Supermicro Super Server/X10SRL-=
F, =3D
> >BIOS 3.2 11/22/2019
> >> [40041.847434][T135817] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
> >> [40041.853266][T135817] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 48 8=
b 4=3D
> >c 24 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be 71 6=
4 0=3D
> >0 eb a0 <0f> 0b 45 31 ff e9 cb fe ff ff 48 89 04 24 e8 49 71 64 00 48 8b=
 04=3D
> >
> >> [40041.872793][T135817] RSP: 0018:ffff888106bff348 EFLAGS: 00010046
> >> [40041.878800][T135817] RAX: 0000000000000001 RBX: ffff888117ec3240 RC=
X: =3D
> >ffff888811440000
> >> [40041.886711][T135817] RDX: 0000000000000000 RSI: 0000000000000001 RD=
I: =3D
> >ffffffffb603d6e8
> >> [40041.894625][T135817] RBP: 0000000000000001 R08: ffffffffb603d6e8 R0=
9: =3D
> >ffffffffb6ba6167
> >> [40041.902537][T135817] R10: fffffbfff6d74c2c R11: 0000000000000001 R1=
2: =3D
> >0000000000000000
> >> [40041.910451][T135817] R13: ffff88881145fd00 R14: 0000000000000001 R1=
5: =3D
> >ffff888811440001
> >> [40041.918364][T135817] FS:  00007f8eabf14b80(0000) GS:ffff88881144000=
0(0=3D
> >000) knlGS:0000000000000000
> >> [40041.927229][T135817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033=3D
> >
> >> [40041.933756][T135817] CR2: 000055ce81e2cc78 CR3: 000000011be92005 CR=
4: =3D
> >00000000001706e0
> >> [40041.941669][T135817] Call Trace:
> >> [40041.944895][T135817]  ? lock_is_held_type+0x98/0x110
> >> [40041.949860][T135817]  try_to_wake_up+0x6f9/0x15e0
>=20
> 2) __queue_work
>      raw_spin_lock(&pwq->pool->lock) with irq disabled
>      insert_work
>        wake_up_worker(pool);
>          wake_up_process first_idle_worker(pool);
>=20
> Even if waker is lucky enough running on worker's CPU, what is weird is a=
n
> idle worker can trigger the warning, given
>=20
> 	if (smp_load_acquire(&p->on_cpu) &&
> 	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
> 		goto unlock;
>=20
> because p->on_cpu must have been false for quite a while.
>=20
> Is there any chance for CPU hotplug to make a difference?
>=20
> Thoughts are welcome.
>=20
> Hillf

Hillf, thank you very much for the comments, and sorry about this late repl=
y.

I walked through related functions to understand your comments and, but I h=
ave
to say that I still don't have enough background knowledge to provide valua=
ble
comments back to you. I understand that the waker and the wakee are on same=
 CPU,
and it is weird that p->on_cpu is true. This looks indicating that the task
scheduler failing to control task status on task migration triggered by CPU
hotplugs, but as far as I read comments in kernel/sched/core.c, CPU hotplug=
 and
task migration are folded into the design and implementation.

The blktests test case block/008 runs I/Os to a test target block device 30
seconds. During this I/O, it repeats offlining CPUs and onlining CPUs: when
there are N CPUs are available, it offlines N-1 CPUs to have only one onlin=
e
CPU, then onlines all CPUs again. It repeats this online and offline until =
I/O
workload completes. When the only one CPU is online, the waker and the wake=
e can
be on the same CPU. Or, one of the waker or the wakee might have been migra=
ted
from other CPUs to the only one online CPU. But still it is not clear for m=
e why
it results in the WARNING.

Now I'm trying to recreate the failure. By repeating test cases in "block
group" on the kernel v5.13-rc5, I was able to recreate the failure. It took=
 3 to
5 hours to recreate it. The test target block device used was a null_blk wi=
th
rather unique configuration (zoned device with zone capacity smaller than z=
one
size). I will try to confirm the failure recreation with latest kernel vers=
ion
and other block devices.

--=20
Best Regards,
Shin'ichiro Kawasaki

>=20
> >> [40041.954567][T135817]  ? migrate_swap_stop+0x970/0x970
> >> [40041.959618][T135817]  ? insert_work+0x193/0x2e0
> >> [40041.964152][T135817]  __queue_work+0x4e8/0xdb0
> >> [40041.968599][T135817]  ? try_to_grab_pending.part.0+0x439/0x530
> >> [40041.974429][T135817]  ? hctx_unlock+0x7d/0xe0
> >> [40041.978790][T135817]  mod_delayed_work_on+0x8c/0x100
> >> [40041.983755][T135817]  ? cancel_delayed_work+0x1f0/0x1f0
> >> [40041.988982][T135817]  ? __blk_mq_delay_run_hw_queue+0x95/0x4b0
> >> [40041.994817][T135817]  kblockd_mod_delayed_work_on+0x17/0x20
>=20
> 1) try to queue work on kblockd_workqueue that is bound percpu workqueue,=
 so
> kworker is bound to one CPU.
>=20
> >> [40042.000390][T135817]  blk_mq_run_hw_queue+0x125/0x270
> >> [40042.005439][T135817]  ? blk_mq_delay_run_hw_queues+0x410/0x410
> >> [40042.011275][T135817]  blk_mq_sched_insert_request+0x294/0x420
> >> [40042.017020][T135817]  ? __blk_mq_sched_bio_merge+0x340/0x340
> >> [40042.022677][T135817]  ? blk_mq_rq_ctx_init+0x99a/0xe80
> >> [40042.027819][T135817]  blk_mq_submit_bio+0xb37/0x15f0
> >> [40042.032786][T135817]  ? blk_mq_try_issue_list_directly+0x940/0x940
> >> [40042.038966][T135817]  ? percpu_ref_put_many.constprop.0+0x82/0x1b0
> >> [40042.045148][T135817]  submit_bio_noacct+0x79c/0xe60
> >> [40042.050023][T135817]  ? blk_queue_enter+0x810/0x810
> >> [40042.054902][T135817]  ? find_held_lock+0x2c/0x110
> >> [40042.059611][T135817]  submit_bio+0xe4/0x4c0
> >> [40042.063795][T135817]  ? submit_bio_noacct+0xe60/0xe60
> >> [40042.068847][T135817]  ? bio_add_zone_append_page+0x2c0/0x2c0
> >> [40042.074507][T135817]  ? bio_release_pages.part.0+0x10c/0x3d0
> >> [40042.080167][T135817]  ? __blkdev_direct_IO_simple+0x436/0x7d0
> >> [40042.085912][T135817]  __blkdev_direct_IO_simple+0x40d/0x7d0
> >> [40042.091488][T135817]  ? bd_link_disk_holder+0x6e0/0x6e0
> >> [40042.096711][T135817]  ? __lock_acquire+0xbbc/0x51b0
> >> [40042.101591][T135817]  ? mark_lock+0xe4/0x18a0
> >> [40042.105953][T135817]  ? set_init_blocksize.isra.0+0x140/0x140
> >> [40042.111698][T135817]  ? mark_lock+0xe4/0x18a0
> >> [40042.116054][T135817]  ? lock_is_held_type+0x98/0x110
> >> [40042.121021][T135817]  ? find_held_lock+0x2c/0x110
> >> [40042.125730][T135817]  blkdev_direct_IO+0xd23/0x11d0
> >> [40042.130607][T135817]  ? __lock_acquire+0x15c2/0x51b0
> >> [40042.135577][T135817]  ? bd_prepare_to_claim+0x2a0/0x2a0
> >> [40042.140799][T135817]  ? __lock_acquire+0x15c2/0x51b0
> >> [40042.145770][T135817]  generic_file_read_iter+0x1f4/0x470
> >> [40042.151080][T135817]  blkdev_read_iter+0x100/0x190
> >> [40042.155871][T135817]  new_sync_read+0x352/0x5d0
> >> [40042.160403][T135817]  ? __ia32_sys_llseek+0x310/0x310
> >> [40042.165458][T135817]  ? __cond_resched+0x15/0x30
> >> [40042.170076][T135817]  ? inode_security+0x56/0xf0
> >> [40042.174698][T135817]  vfs_read+0x26c/0x470
> >> [40042.178796][T135817]  __x64_sys_pread64+0x17d/0x1d0
> >> [40042.183674][T135817]  ? vfs_read+0x470/0x470
> >> [40042.187946][T135817]  ? syscall_enter_from_user_mode+0x27/0x70
> >> [40042.193780][T135817]  ? trace_hardirqs_on+0x1c/0x110
> >> [40042.198747][T135817]  do_syscall_64+0x40/0x80
> >> [40042.203107][T135817]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [40042.208939][T135817] RIP: 0033:0x7f8eb5cdb96f
> >> [40042.213297][T135817] Code: 08 89 3c 24 48 89 4c 24 18 e8 7d f3 ff f=
f 4=3D
> >c 8b 54 24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 0=
0 0=3D
> >0 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 04 24 e8 cd f3 ff ff 48=
 8b=3D
> >
> >> [40042.232824][T135817] RSP: 002b:00007fffaa10c9d0 EFLAGS: 00000293 OR=
IG_=3D
> >RAX: 0000000000000011
> >> [40042.241169][T135817] RAX: ffffffffffffffda RBX: 00000000012e2540 RC=
X: =3D
> >00007f8eb5cdb96f
> >> [40042.249074][T135817] RDX: 0000000000001000 RSI: 000000000130a000 RD=
I: =3D
> >0000000000000009
> >> [40042.256985][T135817] RBP: 00000000012e2540 R08: 0000000000000000 R0=
9: =3D
> >00007fffaa163080
> >> [40042.264898][T135817] R10: 0000000000862000 R11: 0000000000000293 R1=
2: =3D
> >00007f8e96829458
> >> [40042.272813][T135817] R13: 0000000000000000 R14: 0000000000001000 R1=
5: =3D
> >00000000012e2568
> >> [40042.280732][T135817] irq event stamp: 1042448
> >> [40042.285084][T135817] hardirqs last  enabled at (1042447): [<fffffff=
fb3=3D
> >20209e>] try_to_grab_pending.part.0+0x1ae/0x530
> >> [40042.295683][T135817] hardirqs last disabled at (1042448): [<fffffff=
fb3=3D
> >202b3b>] mod_delayed_work_on+0xcb/0x100
> >> [40042.305591][T135817] softirqs last  enabled at (1041222): [<fffffff=
fb3=3D
> >1b5316>] __irq_exit_rcu+0x1c6/0x270
> >> [40042.315150][T135817] softirqs last disabled at (1041215): [<fffffff=
fb3=3D
> >1b5316>] __irq_exit_rcu+0x1c6/0x270
> >> [40042.324711][T135817] ---[ end trace b6f997c9a553aa02 ]---
> >> [40042.330118][    C1]=20
> >> [40042.330119][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> [40042.330121][    C1] WARNING: possible circular locking dependency d=
ete=3D
> >cted
> >> [40042.330123][    C1] 5.13.0-rc5+ #1 Not tainted
> >> [40042.330125][    C1] -----------------------------------------------=
---=3D
> >----
> >> [40042.330126][    C1] fio/135817 is trying to acquire lock:
> >> [40042.330128][    C1] ffffffffb641acb8 ((console_sem).lock){-.-.}-{2:=
2},=3D
> > at: down_trylock+0x13/0x70
> >> [40042.330134][    C1]=20
> >> [40042.330135][    C1] but task is already holding lock:
> >> [40042.330137][    C1] ffff888117ec3f30 (&p->pi_lock){-.-.}-{2:2}, at:=
 tr=3D
> >y_to_wake_up+0x88/0x15e0
> >> [40042.330142][    C1]=20
> >> [40042.330144][    C1] which lock already depends on the new lock.
> >> [40042.330145][    C1]=20
> >> [40042.330146][    C1]=20
> >> [40042.330147][    C1] the existing dependency chain (in reverse order=
) i=3D
> >s:
> >> [40042.330149][    C1]=20
> >> [40042.330150][    C1] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >> [40042.330155][    C1]        _raw_spin_lock_irqsave+0x3b/0x60
> >> [40042.330156][    C1]        try_to_wake_up+0x88/0x15e0
> >> [40042.330157][    C1]        up+0x7a/0xb0
> >> [40042.330159][    C1]        __up_console_sem+0x2d/0x60
> >> [40042.330161][    C1]        console_unlock+0x3f7/0x840
> >> [40042.330162][    C1]        vprintk_emit+0x257/0x420
> >> [40042.330163][    C1]        devkmsg_emit.constprop.0+0x95/0xb1
> >> [40042.330165][    C1]        devkmsg_write.cold+0x48/0x74
> >> [40042.330166][    C1]        do_iter_readv_writev+0x32b/0x6b0
> >> [40042.330167][    C1]        do_iter_write+0x137/0x5d0
> >> [40042.330169][    C1]        vfs_writev+0x147/0x4a0
> >> [40042.330170][    C1]        do_writev+0x100/0x260
> >> [40042.330172][    C1]        do_syscall_64+0x40/0x80
> >> [40042.330173][    C1]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [40042.330175][    C1]=20
> >> [40042.330176][    C1] -> #0 ((console_sem).lock){-.-.}-{2:2}:
> >> [40042.330181][    C1]        __lock_acquire+0x2940/0x51b0
> >> [40042.330182][    C1]        lock_acquire+0x181/0x6a0
> >> [40042.330183][    C1]        _raw_spin_lock_irqsave+0x3b/0x60
> >> [40042.330184][    C1]        down_trylock+0x13/0x70
> >> [40042.330185][    C1]        __down_trylock_console_sem+0x24/0x90
> >> [40042.330186][    C1]        vprintk_emit+0x230/0x420
> >> [40042.330187][    C1]        printk+0x96/0xb2
> >> [40042.330187][    C1]        report_bug.cold+0x31/0x53
> >> [40042.330188][    C1]        handle_bug+0x3c/0x70
> >> [40042.330189][    C1]        exc_invalid_op+0x14/0x40
> >> [40042.330189][    C1]        asm_exc_invalid_op+0x12/0x20
> >> [40042.330190][    C1]        ttwu_queue_wakelist+0x284/0x2f0
> >> [40042.330191][    C1]        try_to_wake_up+0x6f9/0x15e0
> >> [40042.330192][    C1]        __queue_work+0x4e8/0xdb0
> >> [40042.330193][    C1]        mod_delayed_work_on+0x8c/0x100
> >> [40042.330194][    C1]        kblockd_mod_delayed_work_on+0x17/0x20
> >> [40042.330194][    C1]        blk_mq_run_hw_queue+0x125/0x270
> >> [40042.330195][    C1]        blk_mq_sched_insert_request+0x294/0x420
> >> [40042.330196][    C1]        blk_mq_submit_bio+0xb37/0x15f0
> >> [40042.330197][    C1]        submit_bio_noacct+0x79c/0xe60
> >> [40042.330198][    C1]        submit_bio+0xe4/0x4c0
> >> [40042.330199][    C1]        __blkdev_direct_IO_simple+0x40d/0x7d0
> >> [40042.330199][    C1]        blkdev_direct_IO+0xd23/0x11d0
> >> [40042.330200][    C1]        generic_file_read_iter+0x1f4/0x470
> >> [40042.330201][    C1]        blkdev_read_iter+0x100/0x190
> >> [40042.330202][    C1]        new_sync_read+0x352/0x5d0
> >> [40042.330203][    C1]        vfs_read+0x26c/0x470
> >> [40042.330203][    C1]        __x64_sys_pread64+0x17d/0x1d0
> >> [40042.330204][    C1]        do_syscall_64+0x40/0x80
> >> [40042.330205][    C1]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >> [40042.330206][    C1]=20
> >> [40042.330206][    C1] other info that might help us debug this:
> >> [40042.330207][    C1]=20
> >> [40042.330208][    C1]  Possible unsafe locking scenario:
> >> [40042.330208][    C1]=20
> >> [40042.330209][    C1]        CPU0                    CPU1
> >> [40042.330210][    C1]        ----                    ----
> >> [40042.330210][    C1]   lock(&p->pi_lock);
> >> [40042.330212][    C1]                                lock((console_se=
m).=3D
> >lock);
> >> [40042.330214][    C1]                                lock(&p->pi_lock=
);=3D
> >
> >> [40042.330216][    C1]   lock((console_sem).lock);
> >> [40042.330217][    C1]=20
> >> [40042.330218][    C1]  *** DEADLOCK ***
> >> [40042.330218][    C1]=20
> >> [40042.330219][    C1] 3 locks held by fio/135817:
> >> [40042.330220][    C1]  #0: ffffffffb643ae80 (rcu_read_lock){....}-{1:=
2},=3D
> > at: __queue_work+0xa0/0xdb0
> >> [40042.330223][    C1]  #1: ffff8888114730d8 (&pool->lock){-.-.}-{2:2}=
, a=3D
> >t: __queue_work+0x2ce/0xdb0
> >> [40042.330227][    C1]  #2: ffff888117ec3f30 (&p->pi_lock){-.-.}-{2:2}=
, a=3D
> >t: try_to_wake_up+0x88/0x15e0
> >> [40042.330230][    C1]=20
> >> [40042.330231][    C1] stack backtrace:
> >> [40042.330231][    C1] CPU: 1 PID: 135817 Comm: fio Not tainted 5.13.0=
-rc=3D
> >5+ #1
> >> [40042.330232][    C1] Hardware name: Supermicro Super Server/X10SRL-F=
, B=3D
> >IOS 3.2 11/22/2019
> >> [40042.330233][    C1] Call Trace:
> >> [40042.330234][    C1]  dump_stack+0x93/0xc2
> >> [40042.330234][    C1]  check_noncircular+0x235/0x2b0
> >> [40042.330235][    C1]  ? print_circular_bug+0x1f0/0x1f0
> >> [40042.330236][    C1]  ? enable_ptr_key_workfn+0x20/0x20
> >> [40042.330237][    C1]  ? desc_read+0x218/0x2e0
> >> [40042.330237][    C1]  ? vsnprintf+0x830/0x15c0
> >> [40042.330238][    C1]  __lock_acquire+0x2940/0x51b0
> >> [40042.330239][    C1]  ? printk_sprint+0x89/0x110
> >> [40042.330239][    C1]  ? lockdep_hardirqs_on_prepare+0x3e0/0x3e0
> >> [40042.330240][    C1]  ? vprintk_store+0x581/0x630
> >> [40042.330241][    C1]  lock_acquire+0x181/0x6a0
> >> [40042.330242][    C1]  ? down_trylock+0x13/0x70
> >> [40042.330242][    C1]  ? lock_release+0x680/0x680
> >> [40042.330243][    C1]  ? lock_chain_count+0x20/0x20
> >> [40042.330244][    C1]  ? lock_downgrade+0x6a0/0x6a0
> >> [40042.330245][    C1]  ? printk+0x96/0xb2
> >> [40042.330246][    C1]  _raw_spin_lock_irqsave+0x3b/0x60
> >> [40042.330248][    C1]  ? down_trylock+0x13/0x70
> >> [40042.330249][    C1]  down_trylock+0x13/0x70
> >> [40042.330250][    C1]  ? printk+0x96/0xb2
> >> [40042.330252][    C1]  __down_trylock_console_sem+0x24/0x90
> >> [40042.330253][    C1]  vprintk_emit+0x230/0x420
> >> [40042.330254][    C1]  ? ttwu_queue_wakelist+0x284/0x2f0
> >> [40042.330255][    C1]  printk+0x96/0xb2
> >> [40042.330256][    C1]  ? record_print_text.cold+0x11/0x11
> >> [40042.330258][    C1]  report_bug.cold+0x31/0x53
> >> [40042.330259][    C1]  ? ttwu_queue_wakelist+0x284/0x2f0
> >> [40042.330260][    C1]  handle_bug+0x3c/0x70
> >> [40042.330262][    C1]  exc_invalid_op+0x14/0x40
> >> [40042.330263][    C1]  asm_exc_invalid_op+0x12/0x20
> >> [40042.330264][    C1] RIP: 0010:ttwu_queue_wakelist+0x284/0x2f0
> >> [40042.330266][    C1] Code: 34 24 e8 6f 71 64 00 4c 8b 44 24 10 48 8b=
 4c=3D
> > 24 08 8b 34 24 e9 a1 fe ff ff e8 a8 71 64 00 e9 66 ff ff ff e8 be 71 64=
 00=3D
> > eb a0 <0f> 0b 45 31 ff e9 cb=20
> >> [40042.330269][    C1] Lost 69 message(s)!
> >>=20
> >
> >
> >--=20
> >Damien Le Moal
> >Western Digital Research=
