Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6677AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DA610EA
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 10:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhJ2KjE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:39:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:48681 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhJ2KjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 06:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635503795; x=1667039795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UD+AYj6irLbq7cS9H69hECI6XY2pkrgXe/VxzT7nRJI=;
  b=LuL5QzHVy7u9MZ8chvqTmFnWYntMrm6i64WzTsxpotw4I0rcUSccLq6e
   jHJQwhAKJMS0rL8+fqKqsKAO9ct8YBiZaTPVNPXPVpDp02eVcEhPAz6Qh
   HpOYaTnVlE8IcFeIrVQuKrL9eAJ/JDbkgFWViNqmErPQD6zpGBOU8igKl
   pfjqgcGd64csL3imHERhke2u+i5O7M7SSw7rVJk8RYpTwr4F3aCDosZUj
   dDsfhQewMSVNXrB94sOEnGaget6cmxgQcArCjBxig9QEOq34m5vduLLoI
   BGJ1hXN+0RtHldrkq9dRBBycbMuFtaxYHsYDam/rv6lE7vbTBvezp0vem
   g==;
X-IronPort-AV: E=Sophos;i="5.87,192,1631548800"; 
   d="scan'208";a="183166851"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2021 18:36:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqa1aZ81NHLH4rRdOPLaQUVN1DcslA5Nt9oA1KZttZu87fJu+QUj/scone4VkXmrlHsVr9C1af/Ft7XfKAPHk8m2EQXZnjj9Xes8RmVgykEhcTwUVMCpSQhCRQu2v2SfKW2/C8zANVsHt5OvPfYkzQwUgy1sOSJy6u1TCn74PZQfGrHKi2HPdD/rGdXtMKfXfz4F9XfQtlulbV0bIswCElQ8m8x8/AM7YEZ14LzqJ2PC5H2JCspQXxdylEdolWSckMNQdaTHEoDcYl0r7+i0gfQfYIFejWovAbMaa4zOZHA85jbomz3cGcNFWdhmr58jfFHLLqWRKtU0OK5sw/gmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goeK3GMdNENKWcesSTYXzsRTsu4dI90PxcaMpN6d194=;
 b=Gg8DKpY5zmsfB3hicf1XYLYShC4EJ1YCcET0a2di4Tfx2/osQO5JBvEGd1d1bAn1HS6rDVYjJwLo77v33VqluaGMAvQA6PjjNbCLguAzvpHCjjwN6kJ+PJc3Dc5Dmg7yibvyVEH2lQ8wN8QkyniNsPB2KGL0obKlsCTahhYOs6dI+4rX6C1Ti2qmoSUt3K2/ulMTxO3z72Ax1Rc3FDePEMHxbCW3w3mnEFSr64imS9nvBIPTbt1UhRhZctaSHRgVk7HEbSjX/HABWWM8ba/ojxLsGahuygLHTfghHGFZ+w1uPdTdAuq7ACRme4uc7zZpD8PmtECM12rsFTggx//cZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goeK3GMdNENKWcesSTYXzsRTsu4dI90PxcaMpN6d194=;
 b=NbhOy9npv9uWSLW14wGfYC+mvN4LTj/WaanIqtyne5A1DOEg0Znh0vvMvsC7nChPvtKUDNPqcyW5ghgWXjGzYzGkNjgPEkNiomGjdeP2OgmuiDVcEIj5Dt+2GPblLK2SBjllR+gR75Ff0yyemV+waniHvWQ1VOLjRlu5NRYJHnM=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by SJ0PR04MB7725.namprd04.prod.outlook.com (2603:10b6:a03:32e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 10:36:33 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 10:36:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] blktests block/029 triggered NULL pointer on latest
 linux-block/for-next
Thread-Topic: [bug report] blktests block/029 triggered NULL pointer on latest
 linux-block/for-next
Thread-Index: AQHXyx6R5wBxL9OBcUCxaRAv3tP/86vpy3AA
Date:   Fri, 29 Oct 2021 10:36:32 +0000
Message-ID: <20211029103632.vqarkxpgvxi6kjwd@shindev>
References: <CAHj4cs-Co0mnojrWKGs5bhNrywTVW6OGtDp4yVN8RzaHPO4bog@mail.gmail.com>
 <2b2282c2-67f8-db19-cb13-1fc90664dada@kernel.dk>
 <CAHj4cs9R5ZV+WaOGxWot8Qj9cth2S3wvT4-R0qZc5G=rLPDMAQ@mail.gmail.com>
 <20211027103657.volbawehcsaolz4h@shindev>
In-Reply-To: <20211027103657.volbawehcsaolz4h@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953fbd35-bb64-4952-e694-08d99ac7fa13
x-ms-traffictypediagnostic: SJ0PR04MB7725:
x-microsoft-antispam-prvs: <SJ0PR04MB77257F65A996B23EEF9ECA4BED879@SJ0PR04MB7725.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 55+jetXuxpQSXoPk6ASM6PLuj7n9jYdEOM5fD/7nTMakkDYOIgKUFUehNLME4pGQoCMQrq43KnBnGZh31KzVD+mvLB811P/Nou+oEwyP2mHN4ouiWsW7fM1rKOR6r6uLksyUXJeVz8I1VU/Ec+JrjWvVzlB3ea12Hcb08U/P6AkIjJ88ftnjg88JTa9ThWo8ahOB2p/P85yfK8nV1yTvWbZlHE7hxR54goMGF5PmPAWL+7w6yxKhNZ5BHunRePwSk7iZNKChUOrpKUo+M0Uw3yqkEMsiCeQPsfxDfPGs9dv2K2bqJVC65enMVeKI3wMcuA4IZqHjE4hszcTurPoMrb6rmeZBGx5C161gEfnl0o3ockNimyyJ/siDV70mdzy5Z/n9ufxUVVZImrt4qJMzftfvkcE3D5IFJ7P/KRNwccGZurw5Ec9GKlR0IBN8K4qtaWVkOjbmzjTZ483BeHK1dU5z88pbKNhcEinQYepZMRZ86uRaenkQbYgw+x3r5U6Og/aFara1mSr2Ag6EFva3D125QJVSLP+C5s7hdFd4qo/AqvSfLzRLJfxOl8NYTpfGMUU4XPfQHC9lxo+x4o/1Zeo5ztTarjVfLi+Qg9OCJRQJ4v3JQakLZ0qIOPcfxLGlXs+25w1uqJ0Gi4E6pFbxp23TP/Tsovb3qU7YD9OfBXbjBTZyVX8cd4/jGxeX8pcNqKA6RE3uXPQXYS5wshzBZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(2906002)(38070700005)(33716001)(4001150100001)(9686003)(508600001)(26005)(8676002)(6512007)(6506007)(186003)(8936002)(54906003)(6916009)(71200400001)(45080400002)(83380400001)(86362001)(6486002)(53546011)(76116006)(5660300002)(4326008)(91956017)(82960400001)(66946007)(44832011)(66476007)(66556008)(1076003)(316002)(38100700002)(122000001)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CsC+h8PS5SmCGRZmo6RDa8UnFW+iZS5XOaIc8mQN/Zshx7RvK8pYvs7uDP7H?=
 =?us-ascii?Q?OgyufdCJ/qpMCTfnSSDBUsMq7OJPUmYm80TWdTbfuQc/4vgzZmBqxENyei8M?=
 =?us-ascii?Q?+i2+/pN9P37cwyU3+/O1m9XYOaMe4wAd0l8VfMQU27w2ZXOd2v/k/DDzO9r2?=
 =?us-ascii?Q?7w052pGytqbISj9c97z9bznsakPAJFmj2eAeAkOE2UC1fCdbgV89cDXUyviR?=
 =?us-ascii?Q?JCbV6GndyiZTCb5pM5y9c6Fpr8MWfeEUIdHXNus2Mnr/8c4tWAzlKdrCSpWw?=
 =?us-ascii?Q?FcvUxGaVY7h37zxLly2S5xJhWJ0B1m8+Ipc+sbCZ/QaZUdYdHoH4qYliJRJA?=
 =?us-ascii?Q?3v0qwCLSeYHerFZREi6tvpq2+E7a6dczwbhsdXPkEHsfhUaO3zMOOKh7dhT/?=
 =?us-ascii?Q?4u9MBnb+izGzVHIyBSjqVW0JPBBKvh/6TIgQ57cdxvSjcV6D/iwsjkgnqy8I?=
 =?us-ascii?Q?0zGx9nOLIkW4LY8hteD/00FRPHPNi+mxAAD6gSp/nz7nalAzmbg6FwgUbDFV?=
 =?us-ascii?Q?l5u3ELFp3xzpNtCuq6o3jLV5p/6BIvHceURSk0IzAttfJZNIJfZ/Tm+lHLHs?=
 =?us-ascii?Q?ZhVGtC+QOhLWQ1Ue8BbGskQCExJIAxBimraLeHLwQK1HCCI6gaTs4Evm6LeU?=
 =?us-ascii?Q?U8r9gq7aNhzeOwxaYL4uZO1GL/GD9jEaUs7AjYKwweltzAWJUOewNg4/R70V?=
 =?us-ascii?Q?x3JX8iII0MnI+L89N3iKXf/IRnweZiNsuATeNEPeoBxaV+XhEZwaocVwwX0t?=
 =?us-ascii?Q?G0igx8zdkh2P+VWotb3nTZOlaD10oXQG4tTYm6gWGZivVYCfFCqziludjYu9?=
 =?us-ascii?Q?6vtiZ1XTuW2kpxukZfPv6pF9xWZFuFeFPKQxcVFJCVGe6gk0FU2/55iebYWp?=
 =?us-ascii?Q?jHMWBwcLzYTr3swghxP22BGkMuivM/DlyP3m3mee6YTHX9ILQ0OElRMUBjlC?=
 =?us-ascii?Q?lBntnnoBwKEfN0Zjb1ICP1WWXih4TssuIbtZTj5XJsqFNTCt5Frza1D7fPBi?=
 =?us-ascii?Q?vACWR5tUQeJaEtmaqjvs8bLuWTI0YlPmZYwJtV+i96D13ori/Tu5SCxRCT+0?=
 =?us-ascii?Q?Z2ilgUoeVCHKckLVap46f0qlmBZ2bW+7GeHV+06omKuBCAzZUzJkdr9yfALi?=
 =?us-ascii?Q?MpQXwiU3dhq+8ch0HfGNSfMMkpffXE4H3zKkpi2x7s881EWr0xBDKxiqQ5zk?=
 =?us-ascii?Q?JLD90ptcoupUQqN7Qyy4JnnUGEmP5SJ8yNyRDj8W47UKhLVOE1AHwai7jhNg?=
 =?us-ascii?Q?iwxRxLEUGLOEIAscMGX3/5KCmIYfKKksAfNx1bOwY+aGa28f2ntM7rUoif2u?=
 =?us-ascii?Q?Cp5xJK6tjJV0IGqcvFo7+Fvv6uvrvT5vHAI6TbT2H3kciK7npZd59b9Dm9nr?=
 =?us-ascii?Q?ckXd7MkKKh70evCbXoU9n10a7dAxwhVEi+zCI04nCFKsZXro740dJ3mUI3pG?=
 =?us-ascii?Q?IVw3lOL1AROSRIOFRu8h6k/tHI4to3jIrrbaVctUC86BLlV3h2k0WLeojorN?=
 =?us-ascii?Q?ItXEyryHINCa5CgJ56/Epo4cZ0oqdIX8bI/zgE4yawtGsCnn8fQCWDKsM03j?=
 =?us-ascii?Q?J5JJMPoqx8c8X4FapCzVjKU45IYH73q3r2jdKeDQIlKlvns+t3FBe8xZzkbl?=
 =?us-ascii?Q?wbsX+7tneYvMz5L1EEbDzC3R6nNgV2abdwXNYIP64Iz4ON3SCjtnXBcqkJpp?=
 =?us-ascii?Q?9d2oFLHCH7+J7qbnIRl/rHWcfFU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <416A1ED62C8E3440B9887D33DF0806D6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 953fbd35-bb64-4952-e694-08d99ac7fa13
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 10:36:33.0440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oTngNzManZ6ydgmTZx5xdfDxI2k2eeSqkJPBWbvnQo46u50EYAvlxxUjc2/g9fkTfsWrmnA+wVC1MlLQA+Wy75TLCtYcABaKNG9m2W/XO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7725
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 27, 2021 / 10:36, Shinichiro Kawasaki wrote:
> On Oct 27, 2021 / 14:06, Yi Zhang wrote:
> > Hi Jens
> >=20
> > It still can be reproduced with the latest for-next update below, and
> > it's 100% reproduced on my x86_64 environment.
> >=20
> > 7c5835a8640c (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-5.16/scsi-ma' into for-next
>=20
> I also observe the null-ptr-deref during blktests block/029 run, using
> for-next branch tip, git hash 7c5835a8640c. With my configuration, KASAN
> reported null-ptr-deref in blk_mq_map_swqueue().
>=20
> I bisected and found that the commit 0a593fbbc245 ("null_blk: poll queue
> support") triggers it. Reverting this commit from the tip of for-next
> branch, the KASAN null-ptr-deref message was not observed.

The test case block/029 changes /sys/kernel/config/nullb/nullb0/submit_queu=
es.
When the submit_queues value changes, nr_hw_queue is updated without counti=
ng
the number of poll_queues. Another test case block/030 also changes the num=
ber
of submit queues, and shows the same failure symptom.

I also tried to change /sys/kernel/config/nullb/nullb0/poll_queues value, a=
nd
observed the same failure. So, null_blk needs a fix for handling of these
attributes.

I have created a fix patch and confirmed that the patch avoids the
null-ptr-deref. Will post the patch to linux-block list. Review will be
appreciated.

--=20
Best Regards,
Shin'ichiro Kawasaki


>=20
> >=20
> > On Tue, Oct 26, 2021 at 10:44 PM Jens Axboe <axboe@kernel.dk> wrote:
> > >
> > > On 10/26/21 3:33 AM, Yi Zhang wrote:
> > > > Hello
> > > >
> > > > Below NULL pointer was triggered[2] with blktests block/029 on late=
st
> > > > linux-block/for-next, pls check it.
> > > >
> > > > [1]
> > > > 9b3b463f3955 (HEAD -> for-next, origin/for-next) Merge branch
> > > > 'for-5.16/block' into for-next
> > > >
> > > > [2]
> > > > [  110.508269] run blktests block/029 at 2021-10-26 05:29:11
> > > > [  110.535182] null_blk: module loaded
> > > > [  110.674174] Kernel attempted to read user page (d8) - exploit
> > > > attempt? (uid: 0)
> > > > [  110.674212] BUG: Kernel NULL pointer dereference on read at 0x00=
0000d8
> > > > [  110.674236] Faulting instruction address: 0xc0000000009414c4
> > > > [  110.674251] Oops: Kernel access of bad area, sig: 11 [#1]
> > > > [  110.674272] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NU=
MA PowerNV
> > > > [  110.674308] Modules linked in: null_blk rfkill sunrpc joydev ofp=
art
> > > > ses enclosure scsi_transport_sas i40e at24 powernv_flash mtd
> > > > tpm_i2c_nuvoton regmap_i2c ipmi_powernv rtc_opal crct10dif_vpmsum
> > > > opal_prd ipmi_devintf i2c_opal ipmi_msghandler fuse zram ip_tables =
xfs
> > > > ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea
> > > > sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm
> > > > vmx_crypto crc32c_vpmsum i2c_core aacraid drm_panel_orientation_qui=
rks
> > > > [  110.674485] CPU: 60 PID: 3469 Comm: check Not tainted 5.15.0-rc6=
+ #3
> > > > [  110.674520] NIP:  c0000000009414c4 LR: c000000000941638 CTR: 000=
0000000000000
> > > > [  110.674556] REGS: c00000003aea77c0 TRAP: 0300   Not tainted  (5.=
15.0-rc6+)
> > > > [  110.674580] MSR:  900000000280b033
> > > > <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 84428482  XER: 00000006
> > > > [  110.674634] CFAR: c000000000941648 DAR: 00000000000000d8 DSISR:
> > > > 40000000 IRQMASK: 0
> > > > [  110.674634] GPR00: c000000000941638 c00000003aea7a60
> > > > c0000000028a9a00 c00000001ad8a8c0
> > > > [  110.674634] GPR04: c000000089287e00 0000000000000001
> > > > 00000000ffffffff ffffffffffffffff
> > > > [  110.674634] GPR08: 00000000000000d8 0000000000000000
> > > > 00000000000000d8 0000000000000400
> > > > [  110.674634] GPR12: 0000000000008000 c000000ffff9e600
> > > > c00000001ac416c0 0000000000000000
> > > > [  110.674634] GPR16: 0000000000000001 0000000000000001
> > > > 0000000000000000 c009dfffff94f300
> > > > [  110.674634] GPR20: 0000000000000000 0000000000000000
> > > > c0000000028e72b8 c0000000028e78a0
> > > > [  110.674634] GPR24: 0000000000000001 0000000000000008
> > > > c0000000aaa53838 c009dfffff94f388
> > > > [  110.674634] GPR28: c00000009d527698 c009dfffff94f3a0
> > > > 0000000000000002 c0000000aaa53858
> > > > [  110.674942] NIP [c0000000009414c4] blk_mq_map_swqueue+0x1a4/0x49=
0
> > > > [  110.674982] LR [c000000000941638] blk_mq_map_swqueue+0x318/0x490
> > > > [  110.675021] Call Trace:
> > > > [  110.675038] [c00000003aea7a60] [c000000000941638]
> > > > blk_mq_map_swqueue+0x318/0x490 (unreliable)
> > > > [  110.675080] [c00000003aea7b10] [c0000000009420e4]
> > > > blk_mq_update_nr_hw_queues+0x244/0x480
> > > > [  110.675128] [c00000003aea7bd0] [c00800000f3e2d60]
> > > > nullb_device_submit_queues_store+0x98/0x120 [null_blk]
> > > > [  110.675182] [c00000003aea7c20] [c000000000648aa8]
> > > > configfs_write_iter+0x118/0x1e0
> > > > [  110.675224] [c00000003aea7c70] [c000000000521494] new_sync_write=
+0x124/0x1b0
> > > > [  110.675281] [c00000003aea7d10] [c000000000524794] vfs_write+0x2c=
4/0x390
> > > > [  110.675299] [c00000003aea7d60] [c000000000524b08] ksys_write+0x7=
8/0x130
> > > > [  110.675316] [c00000003aea7db0] [c00000000002d648]
> > > > system_call_exception+0x188/0x360
> > > > [  110.675335] [c00000003aea7e10] [c00000000000c1e8]
> > > > system_call_vectored_common+0xe8/0x278
> > > > [  110.675355] --- interrupt: 3000 at 0x7fffa1aefee4
> > > > [  110.675367] NIP:  00007fffa1aefee4 LR: 0000000000000000 CTR: 000=
0000000000000
> > > > [  110.675393] REGS: c00000003aea7e80 TRAP: 3000   Not tainted  (5.=
15.0-rc6+)
> > > > [  110.675429] MSR:  900000000280f033
> > > > <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48422488  XER: 0000000=
0
> > > > [  110.675482] IRQMASK: 0
> > > > [  110.675482] GPR00: 0000000000000004 00007fffc592dd30
> > > > 00007fffa1be7000 0000000000000001
> > > > [  110.675482] GPR04: 0000000143297fc0 0000000000000002
> > > > 0000000000000010 00000001432bd791
> > > > [  110.675482] GPR08: 0000000000000000 0000000000000000
> > > > 0000000000000000 0000000000000000
> > > > [  110.675482] GPR12: 0000000000000000 00007fffa1d2afa0
> > > > 0000000000000000 0000000000000000
> > > > [  110.675482] GPR16: 000000010dfd87b8 000000010dfd94d4
> > > > 0000000020000000 000000010deeae80
> > > > [  110.675482] GPR20: 0000000000000000 00007fffc592df54
> > > > 000000010df83128 000000010dfd89bc
> > > > [  110.675482] GPR24: 000000010dfd8a50 0000000000000000
> > > > 0000000143297fc0 0000000000000002
> > > > [  110.675482] GPR28: 0000000000000002 00007fffa1be16d8
> > > > 0000000143297fc0 0000000000000002
> > > > [  110.675718] NIP [00007fffa1aefee4] 0x7fffa1aefee4
> > > > [  110.675750] LR [0000000000000000] 0x0
> > > > [  110.675769] --- interrupt: 3000
> > > > [  110.675789] Instruction dump:
> > > > [  110.675798] 2c290000 41820168 e91c0600 7bc926e4 e95c0048 7d28482=
a
> > > > 7d29a82e 79291f24
> > > > [  110.675845] 7d2a482a f93d0000 390900d8 7d489214 <7d08a02a> 7d088=
839
> > > > 4082004c 7d0050a8
> > > > [  110.675885] ---[ end trace b9b604499c6b5b71 ]---
> > > > [  110.814135]
> > > > [  111.814148] Kernel panic - not syncing: Fatal exception
> > > > [  113.674122] ---[ end Kernel panic - not syncing: Fatal exception=
 ]---
> > >
> > > Should be fixed in my current for-next branch.
> > >
> > > --
> > > Jens Axboe
> > >
> >=20
> >=20
> > --=20
> > Best Regards,
> >   Yi Zhang
> >=20
>=20
> --=20
> Best Regards,
> Shin'ichiro Kawasaki=
