Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E19C001B0
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 14:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjHJOXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232604AbjHJOXH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 10:23:07 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB0358A
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691677374; x=1723213374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=epejFWwkzb8k1dFvWV/xegDZYW5xTAXLFL3rTaTaJSM=;
  b=do5wUPAiIoY+CrAhA11Iao6dtes3VqhLFyYwV16UvydfW2L1Dor0c44w
   nfr047f6mHDV5GTusdm+zanuqn6GOXhSXZQsLiQuO7pYq5s79v/EUwgeq
   dallXaRPF0A60kL2UCGhJSYcINq2mH4GMKTo7ZEKTAerdSCf+VeT7GFoF
   O4LrZXd7TsgDPbvwPusAYROng3fxmq8J7NzAAHC4R055LKYGjnO4CqNUI
   kYIMZcrhUhC+efR7gC/hzkAnA270xS9hWogekt8FiiflBUyWCyWDO4XKZ
   a5OZeO0h2VZHTe3WzvwIIPsBctkseAcEN5RAQZfe/Zu3TkI9Vyh1ViLKg
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684771200"; 
   d="scan'208";a="345795913"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2023 22:22:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJfUfyankXCumaVzvWed+4ctB3yvT0PLjx2ioFBFTL660q+O8gEgCxcZ2UuolEPSRoeU+zEZ3ITATLO6gc1zR3ANFhMI9y+FuBe2ZeKVeIcy+JKaxcLrZGW9DOqREn3SnGPh7KVc4Rit52/42TczJx5TNBj0c2EAfEUI5yc590jBm+s+/O7hJGAcoyujpc4wx+mg0b1AZcoJYLmTnrG9XCQ0b8Sk15TDp0jgEskbNCpNRSk7WKrB7zaO3g2BnNS9IGPgI2sNUcadK2F6RsWuAnyJnsN+opnRaTMfDBWrN9vmZWTeGQ7E8k+Rr/176ECiLz+OX7UGjo05BIz4Rgp82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUt+JQd7H4vPDIcOdnrq+kbZ/lmHOPbk2+CZDw5xAh8=;
 b=lOL2EkIJ6julOfGPprIK6UiTBfKcDRz5orrsveSLMN6A7WhiNhxTD9GnhsF1P7NXVT3NJzI9C5tA9veIW3ZWR3yLeLxkX5o6QOXmulyOO9ECrXZTZx3hiEX6ka9FfJzmUWZDG4EGYndkLPkdi40NQudvGei45NykIMXnd4E1DqGkjmhThxv5vNrjIViYA9laO8iG71gMzrKlSG0BHkjIgF3/60rYSss3QV5o+P41wXRRpvcB4UAzUnMF8ylDgV8caGXNRhp9dTw2sKcxkH4H+SdxxQ7Ig9yJHCW0zrIcnte3zKAGWZPMHrgF06nJLPc3qvVFyN/42LDiaXxiLwARRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUt+JQd7H4vPDIcOdnrq+kbZ/lmHOPbk2+CZDw5xAh8=;
 b=cvLEUhCCI7JDpt5pczb9qVG+U1P3mKYyeBJ2vjjEb/XIZ0X4Ncmcx/34mo8dCOxpkvz7DOKZfH8RTFU+3WZhLG0pNoFCmOWdFp1SaCki7qmZiOLELXrhlNlM6SVMZM2pdDeDTmAoa21a3rgEoNrnWnDbTi+Yc8nP1dWvRzG+AD4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7390.namprd04.prod.outlook.com (2603:10b6:a03:293::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:22:50 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d093:80b3:59e5:c8a9%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:22:50 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH V2] ublk: zoned: support REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHZy4hMzEohYWMWrE+MOG55GSQMF6/jgPsAgAAN7ACAAAZMAA==
Date:   Thu, 10 Aug 2023 14:22:50 +0000
Message-ID: <ZNTytlego591Zmin@x1-carbon>
References: <20230810124326.321472-1-ming.lei@redhat.com>
 <ZNThwMBAqqVUGtek@x1-carbon> <ZNTtbpNCiXPvRlvI@fedora>
In-Reply-To: <ZNTtbpNCiXPvRlvI@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7390:EE_
x-ms-office365-filtering-correlation-id: c03993fa-9717-47d8-c613-08db99ad4733
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5who6Nbln5PhwJw9Z/CPlhBM7DZOpLGpgg9T3qC5cyekNuiQ+wxMJ0/xRZl/dLVWVMJvmnSr/CLj5nHyES7GrqJWw1G4o0dtKAwPHzAsGNII9zh9FudZBi2nRpmv50qqRTXjhI7uujpHkfg5cDmNG6TOfcxZ7FWp0km8N1lru97bzsK8HJ8v4A7KUL9uilGDt9pFRd+g7nroTL7uEt/ywQ0axg7PBuF2POBivq5Dsn39Vs723tBet1ovxUHgWDR/lDSZSGBKuTgzH7gXWQJYrvO+EVIOrzpNGvOnUVumFhDIgnI63FS8TkupkJ1MpxvkkdhgcW07nbc1BqU1fmuYC0vvNSEcbz+TBrxzY4e4b/hbBNF4sV6KIm0YqGcu7BGA3BSzzmb5/isHUc27FflvbDhoAPyPLtaIoqyNZpkO2rQBNogavWepKSDmiflm9q2ctmHlDbNUIo1soBbcVBldvudsyjksXftgdnLjk3M/THrQKRK6T+u73KomM+3Zuaa+5yyxB5gGnbpLtfuOQrBuwYC1hJBkIrG14AUrmjnyzvTJfZa4wqzyIoQMh1MANHBTuixkJGtZSMloqNpvtimhDTVRepP9sxppFVQJiPpcSQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(451199021)(1800799006)(186006)(83380400001)(2906002)(41300700001)(6486002)(966005)(71200400001)(54906003)(316002)(4326008)(6916009)(33716001)(66946007)(38070700005)(76116006)(66446008)(91956017)(64756008)(66556008)(66476007)(82960400001)(122000001)(9686003)(6512007)(86362001)(38100700002)(5660300002)(478600001)(8936002)(8676002)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WmpvqGKCAN9+nKG+HK7p6eG00cY97sdUFWGXTnBwnqkRnijBApxDeU7lqyS?=
 =?us-ascii?Q?yN/jhHsAHbp3WBHUc2MuzBr0LfsYYmloxNE+f/mPHqg5b2qbC4jhyCLyIv0z?=
 =?us-ascii?Q?Z3rJr1GUyEx/4+4Z2pnwJ6ifIy5c3Sz579BJU9ge0RgGArWzhWfkPrqZLeTu?=
 =?us-ascii?Q?9fHujnoj1+uEGt4oa4OaLvy//N7RoLaCtcFe63AnUXdB7STZFNKhtJyIqe6j?=
 =?us-ascii?Q?CFCzKeyRlyloxubHKP/0kr9v7uOmjFTsmdZ2TocL9T5c8W64ReaCvW3+X2Jp?=
 =?us-ascii?Q?I4DmxIeEt5ph9Lq4kPW4KDC5LUFaXwFplRmNVLstd2mM17OvUvUabD9o2pAY?=
 =?us-ascii?Q?2h2t85eqpWGBGkSWLFeZOT5Ch2gh5ifIvioiKOfiOKGcid8ET3ByvyFsY79b?=
 =?us-ascii?Q?WYM9cDhWvCHMEmSrwaaoaoK8jU1Do08E4dyhxinoGjimMKcaanpmo0nNxMDf?=
 =?us-ascii?Q?lQSOXJZyzPJjFi1K1eJNIBDDSmt07+MESlhKjHAqrXCoBfIQCNVlzVhvlh9y?=
 =?us-ascii?Q?kNOkZIlkETB8MZBRozyFtjz5HpCuEuSrD/1O6MaP2h+ou4kqB6ObPphX1U+y?=
 =?us-ascii?Q?7SwqAPK4uE8aEMKKtmGIL7W0P0+YwHikTx7U9vfvFN9D3pkwcGXLFVPE/KVt?=
 =?us-ascii?Q?Xy32Gk/E+etUHNio3Xo39skICMHc5dyyYrCiDCUknGceQl/88IOZZERAcGZd?=
 =?us-ascii?Q?3teV3fXlR3EwkwaTkipohCEeB9u/eYDDiU/NnNyQKJCSVWENuuJ3TGbpPGwm?=
 =?us-ascii?Q?H5InR/OT+cu+D+We1Mz6CwXua4+9tAwPHjR80jHTJJJqB07DpGu0SO5/k6/2?=
 =?us-ascii?Q?56PvAR6w3ulatBEm0ERi7Rul5NP4cfhFFcZcGaodA/LrrwE/ig3pAMPuLA9R?=
 =?us-ascii?Q?REcUXdRGHk8tnN2vfWOR1Vlgt1hiZA0KLrbrEJNsfTYb/4+Udhbub3R3WqZ2?=
 =?us-ascii?Q?eJuM3D72DtHWkNOVcx1Kxro6Fzl8wlyNQykW2lZpeyhfjpvln/2k3iT3Pmsu?=
 =?us-ascii?Q?sK0v+IygbVOLybzemwUlOqOWhE36Erg5cCTXpqc3zcrreANi0J79Cgjobj8N?=
 =?us-ascii?Q?8J5+4qsfAonuEPlAJDXIXOe/eIz+IrvEEI8r0xwuXgp4yM7cb+vPbYEJwNtI?=
 =?us-ascii?Q?F3R2YJ8ZvAm4C5hmGaFvKUSTI1w0Mxur6/zhrxI6hw3Xs9USxNVTdf0o+5Fb?=
 =?us-ascii?Q?AoqV7Jq4M9+b/OJghKLdrmbZGAVdLiO25O0t2lfMTXYeKPaVviCFQ6GbPgiI?=
 =?us-ascii?Q?1yvNWeNw7mWXjpgqWpRz11x07tnQUI9c6kUleEgWg7WQ4WD0Ckt2d5E3kDqE?=
 =?us-ascii?Q?4zvjUYis+as5qw/SSEtorCUx7VKyeNqXOzl3k7lqJnyCy2oTQwsHGFHKkxl2?=
 =?us-ascii?Q?+cBIiHLQbgnRu2A7ADHGYqxcyDiE04FIGkJHHszUmftsSQD3TKs3BHt9nL1D?=
 =?us-ascii?Q?KXeWGg+dEUSfCH/711IMX77Rq3ZkrAKz6qkNxMJPUD3pN9Bz4TISdihPCqZS?=
 =?us-ascii?Q?/YQ/gr7Ovgwrb4QPpmgZSPbFXV0BGd38vV6oqYJGU2nvcwOTfgq3qX4oG1D4?=
 =?us-ascii?Q?8YdTKxkT1PdzqjQdJnqUlJJ3tHcBuUk3WvGCWUSqYnYfE4TKcxiIcMdfuRtj?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <845D5CCC70839E4AB26D07420D31C54C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J9jIv355NVur0iyYKip7LSMBiCdh1XI3Mrdc5N5xq2oC18s3MvpJv53Q+3q6y4TqJyVqO0JtFaQjdTZ5xgY1IN0MZUqiUSPnMdd7j9LrczJbvYVvGJTRDIWDSOL0pJA73rre5/RbsxH3a6spD/3ebwHXBwyz6yHyUZhoiOrxzXjcTv5LujpRLU/colkdHuXVKrYFiifGML4ueyAhW6k7ndiKo8WBrfQZPAh75dQoPVJwA9Ov66QB4lJqBfGzuKPZY7eC4rZkj2+IIgP9RvFD7Frm/h82fgPCaP6mB+ZJJsm1fuZNjXqAQ7eLHsRUY3Sz9DbhN9qI40RBPfZLuYYfUgkv2M0eTZ6Q0dStu9sulY+areDdumHLWzcwjTX2vqVm5ANN8sbxOFP2qSJhPjjD0imxg3yQIJppuxL4LVGIQLI8cdiyNzk7AZbP1+m0W8MYxZwaahLrYdJ1R0jiGIaenv3oKE0/kaRkvrZU4+wpX6AQ7xJuy19OIHBQd75/bDqWw7bAFsGbA9d5p/rXfdCTEW65BnCzvO48WRSOxvAeA8iDGgikbmYJz5T6jUeOTzyAOitEanV2pJ+aSrKsEumKbzh+xzbN64u6WTuNnteZ0HjCNu/Juuo5r4+kE8pWiNFvjtWJA28X0k7M7qSYN9EtY7dBmhdTF0oW+DUPg+REGNx6qAYVyGvR5YS6KYtcyaTIprqdEwRzGvBBzK5MMOONRA9N1p2BULTvPZ3RfayQHB1OByVHg62p+kWZ4/KjOXQUPJMTBhuc0nbHaJU4Ij4xOJfz87vOQIr+pNIf3md+dZGCk2UaSv1CIf4znlR/5ZOHFJL5DHRtTrLpW7scBp45u3q83nqmmUXtl2ha6NaIa7Vf/s3zJO8xyfHPtlFAjQ0BeIsm1JAQFhLXlkD8oGBvcg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03993fa-9717-47d8-c613-08db99ad4733
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 14:22:50.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TdMh1t5HR8ptHESeHI2zI9Xnjkj3s5seIe5caAUuW7Xd48KX2f0zjqCVoIcmcWNxUHQx8v1xGX3Wk1jkV7VXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7390
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 10, 2023 at 10:00:14PM +0800, Ming Lei wrote:
> On Thu, Aug 10, 2023 at 01:10:30PM +0000, Niklas Cassel wrote:
> > On Thu, Aug 10, 2023 at 08:43:26PM +0800, Ming Lei wrote:

(snip)
=20
> UBLK_IO_OP_ZONE_* is part of ublk UAPI, but REQ_OP_ZONE_* is just kernel
> internal definition which may be changed time by time, so we can't use
> REQ_OP_ZONE_* directly.
>=20
> Here you can think of UBLK_IO_OP_ZONE_* as interface between driver and
> hardware, so UBLK_IO_OP_ZONE_* has to be defined independently.
>=20
> > but if you want to keep this pattern, then perhaps you want
> > to define UBLK_IO_OP_ZONE_RESET_ALL to 17.
>=20
> Why do you think that 17 is better than 14?

I never said that it was better :)
I even said: "I don't see any obvious advantage of keeping them the same" :=
)

Just that it would follow the existing pattern of keeping
UBLK_IO_OP_ZONE_* in sync with REQ_OP_ZONE_*.


>=20
> I'd rather use 14 to fill the hole, meantime the two ZONE_RESET OPs
> can be kept together.

Ok, but then, considering that UBLK_IO_OP_ZONE_* is not part of any officia=
l
kernel release, and that the highest UBLK_IO_OP is currently defined as 5:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/uapi/linux/ublk_cmd.h?h=3Dv6.5-rc5#n237

why not define:
+#define		UBLK_IO_OP_ZONE_OPEN		6
+#define		UBLK_IO_OP_ZONE_CLOSE		7
+#define		UBLK_IO_OP_ZONE_FINISH		8
+#define		UBLK_IO_OP_ZONE_APPEND		9
+#define		UBLK_IO_OP_ZONE_RESET		10
+#define		UBLK_IO_OP_ZONE_RESET_ALL	11

instead of, like it currently is in linux-block/for-next (this patch includ=
ed):

+#define		UBLK_IO_OP_ZONE_OPEN		10
+#define		UBLK_IO_OP_ZONE_CLOSE		11
+#define		UBLK_IO_OP_ZONE_FINISH		12
+#define		UBLK_IO_OP_ZONE_APPEND		13
+#define		UBLK_IO_OP_ZONE_RESET_ALL	14
+#define		UBLK_IO_OP_ZONE_RESET		15

Because, even after this patch, you would still have a hole between
UBLK_IO_OP_ value 5 and 10.


Kind regards,
Niklas=
