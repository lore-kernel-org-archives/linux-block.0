Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A53C433EF
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 11:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiEaLIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiEaLIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 07:08:20 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9655439810
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 04:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653995296; x=1685531296;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q7nO6G6z6MfsliaPdrkjnQqAaOfkvmsnClB16EwHO9Q=;
  b=ZRmoeVEI9RCRtwyhU4ikDV6kCI3ajSf5J3w9iap0SbexGJZKk9fDzdGq
   RM7IcSygZeK8ITiJh4wiNzLFtVyjC7O+73HfYVXw3qkTB/UYA2sCzWYqe
   8zuP+QE2JzbplkdFqY7wgSLjCC1xL2a4sLZx1GM+wJJuvApFdpOWi0KRD
   bo+YhY7AIsZt8no8jCxafE5or8pPDQlpcu5vclyKRfr9Zf/y8Kz3mR4OT
   UAQopKWqxCwaSFIpW9KUfYCN1AJbXN9N9/Ho9vdEOtLF498zB7+yNuDhB
   Xgl/nsS3ubB/JOCKYxB36Y8v5R00a6vjT28May2MlLb5WddSpnY+liv7p
   A==;
X-IronPort-AV: E=Sophos;i="5.91,265,1647273600"; 
   d="scan'208";a="201879055"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2022 19:08:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDvg/4RWlSriODeo9PfPBhivMhvsMrkUWxgYPlpH4dc6KMR6RdOOODJ94uz7Tt1yrk6tTmiOHn0vBg6d/4XphbWAOvBBXnn5+sKcFGqS1SU220f4tJ97ZiaN9ieUUQWqLylhHXGTIPdyRkIMvuFf4EBa8DFsAFBCodZJDxUhwswtkjUy5u5L2l48MmCepX16p1tma0zbV7g16GyiF60hAaqxoHywiwj1DdVA560IWwZf5PW374QjKhoiEvGajOv2PpsHzLGdyfq5LPF5dOZse/jkHiGhl8Y1waq0nyGMG/+bIQ6jKLkGCJBQFd/cX1gbeaFADRQ0gg+0ZvxQKCGEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7nO6G6z6MfsliaPdrkjnQqAaOfkvmsnClB16EwHO9Q=;
 b=lSRXhDqWhxd9hqRCxxHzBJsZ8mTk/orfc6V9/+7lQOUOyG3UU4JpVa9ta2npetXVPctBODXq0BODuq2IFgkehKyzA8/MgbyCRp4IRqc1wpg4au2p3gbX0iedTe7vy/bKE173sms4rVjuDxUajm2Z9BA8ywMEolnme/BX8axi02yddMHLcSsP6qm/v7+qm/QPyOidAVBCh9yl4cZ2quu/EL/TDKeQFac6QBaYObwJRKqxHApKtJPQpi6ovqHUrvGkVeRElhVG352z2+mK/JR1CQY/re7szGhl+a9SFu/2tT27b+GUT4efRpDTVNOAZMM/qtcPfgm/6P2HSQy8QHv5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7nO6G6z6MfsliaPdrkjnQqAaOfkvmsnClB16EwHO9Q=;
 b=B/YdBGiyJU0NcCZcnRZhBCmmCru3HHfHlZKFvUX4FpQcQknj/EeMBlIRwymttp/VM9Sp9XRHZyvuw0ZMJNPGuB1sc0D0EZ5ap1Yq4v1BiXiopZmTWOiV0B/0hWWLXP1j5gGpvIXATxKmDLr0o/hoV0APXHR7ERhjU4/h6Uq1G5A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB5581.namprd04.prod.outlook.com (2603:10b6:208:d9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Tue, 31 May 2022 11:08:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:08:15 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/9] nvme: use _have_loop instead of
 _have_modules loop
Thread-Topic: [PATCH blktests 1/9] nvme: use _have_loop instead of
 _have_modules loop
Thread-Index: AQHYdCZisGwmvSP2t0+vFZtVxupzr6041SOA
Date:   Tue, 31 May 2022 11:08:14 +0000
Message-ID: <20220531110813.wvrsqsdjng3bcto2@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-2-hch@lst.de>
In-Reply-To: <20220530130811.3006554-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1849706a-41a7-4579-b538-08da42f5dbe6
x-ms-traffictypediagnostic: MN2PR04MB5581:EE_
x-microsoft-antispam-prvs: <MN2PR04MB5581D8C495DFC3E4B19C49EFEDDC9@MN2PR04MB5581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jaD3Attjx8cIUo4a2pX9nfi8kIAhux9D1JfBYL268aYEkHTEM6XeDVMUPlbV1ijp2K1Dk5mP9hJGZC85Sz+z0MWmMrc82R7RZQ7X3K1ubEZScm9fW71H4XPr6Fj/T4JRwgHyhuC7G2RrzRnTNwYVY8G+w4bCMj4ea75f4RNriNHA8dKL9lvEo+YBwCQ0KkF5XddzDCsYeOIojZUp9aJAEeLKzVStk41DCCxCDcuolEBGBzQnbILEobGCJXkRKSkjmcN02yXWRc5/djv/WvKlgt8tE/yvbG7Op2NVD4KIxkiiDyKg8ST6ozkd7VB8W+4Z5JIu35SEXOyFVnrf6cjNC5ap/XwacUgY3P1/lnmrarZyyjAVBspLmIg1Pgo/dvX+7cgDQOeWeuZqgm7Io9Kv0RL8jhW+7FKbP0waALBZ5OVEZDTvUEsHvuHDNvsJDAHWewsGeBOJX9XgSP230EwBPg2iE4KfxiljTmysQiwyK4wQbgt8dTceLaGeWMCXDIPlwquw7z5iNeySuARZvj8IhrEHElPmuJxMcwEigGXiRhj/upPszvGvTRjmLpdHsyK4BG3TS7paWwt4z5Ey6lb9VulkzgKGkJb/aUL45Rr7jLY+C3BibFo7+T8gWSnd+l0cD9s5nw4xSWgjzu/oxOj7ggi5DsKNCvbOOuHLNaLS/neV8Ti3fIbY8MLYb9uk7UZAW8HiZdLbZFhuy1x4kkEDkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(6506007)(9686003)(5660300002)(4326008)(26005)(76116006)(8676002)(2906002)(82960400001)(91956017)(66946007)(66556008)(66476007)(6512007)(44832011)(33716001)(38070700005)(66446008)(64756008)(558084003)(6486002)(38100700002)(508600001)(6916009)(316002)(86362001)(71200400001)(122000001)(186003)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oj/jPR77G26tb0ctjFcnEM7rnI+91kFv7+0W0LqWB2NDIckvGCPk/ge9Y+MI?=
 =?us-ascii?Q?pnzCija8RjC9A1HqH4MrfbSx4We8rWCUW5Xg5DO/95Flo/ydu7SHIhrG9vzI?=
 =?us-ascii?Q?+HT+/QwOLypXYU/H0DQd2HKy8L1CWW7tYmAvFykWyYi3UmTTKhk9YM0Llfe7?=
 =?us-ascii?Q?tYu+qrx7eZjGKbpwJLPv5xofqF01eKRnTIgqFihE8D7cQSnFDQuOrb2FDpM1?=
 =?us-ascii?Q?i+gnQZYZh+jyOXXAkupZ98fBqKUqByi/3xM0MpRBo5SgEg+43lTJLCMjMi5H?=
 =?us-ascii?Q?LJ2wEg1OCU/fdyeg2th4NIR/fILLELmGcZTpZHn7ZllTBjq4J3QNLN/MsMca?=
 =?us-ascii?Q?GMfjAbxZ6GFDG5QXIloNucMBLkR3SZkwrdaZNiuMqWqPEZvTMKUALQL5KSpu?=
 =?us-ascii?Q?8wELW15fs6UIspd/79eukWHf9XA3LxU3PsRtBzZlteNQGqdRzcmQ07/v0ZRK?=
 =?us-ascii?Q?yrJsx3dCX3N2optfAuAMkCCGPzK7Ga2fg9rauKUzsRxzOv67d06oFX0u6KA7?=
 =?us-ascii?Q?Sdkd9/McVnBkDQEubbjIQOZHzO7dpfku4IsBOSpWvsCIIWjM2y6D6e2YVT29?=
 =?us-ascii?Q?lGrDuVUkURzQ1GtA+qRJktYWJ5DURh5QbPI15qzqjIEo+GeirdlS21RlNFMd?=
 =?us-ascii?Q?Bq+m0PLHBw2a/v9klOUCFNoYDHznq+8KKJtvEQRD2PHyRNbEsGfjACtIFIaw?=
 =?us-ascii?Q?2n9j7kUV707ngTdddJL4dHLsAX2qO7IIxLOvydlTp/l0AW9XciEu19+P+Oxp?=
 =?us-ascii?Q?tq3OqOeYxd1m1o2qLbZAQGhEsrHDD04lXbL9dHStZjBC6wouy5aiPpgCR12z?=
 =?us-ascii?Q?iSVY6MqJRTPagXYUQaKaTCS3XZnFrKrzjgFhujrNToI3PETw7lnHnfeeG50E?=
 =?us-ascii?Q?LsIF+4qA1wqGtI5Ap/MAIS5ovhsOA0nEltxslUKOKbFxHPjZQTpbRgRjCqip?=
 =?us-ascii?Q?/59SyWJvMKY6s9QezXE8puIM2BhJnwDZc1Hm66UlfqWAmXLbug5FgP822DNd?=
 =?us-ascii?Q?scLnrw9E8XyjSPqmKHcFidhcW6nyoDiT9uZhE8CqoRWC01YIzto2PVpdnZAH?=
 =?us-ascii?Q?cfGKJTvFLu354bGUUOdxLHUHu6z6Wb4LY3b2NHPjsHgxmxvzmoZsOJpuJZwv?=
 =?us-ascii?Q?ozIF6HaxgaXj2Kr63v238MFoIrYUgy5UtmMql9yySriio6S2+JE5tAJMbZlk?=
 =?us-ascii?Q?y5lglh4m2ITAHx2AWK6qmsmu0pr7EbbjqGzXXkUeYK7yeVG96fZVb8KAK0U1?=
 =?us-ascii?Q?SlJjtqn7xBnTFVRtplVU8zYig0JrlCXpnuMwrJf3F3WbpmcjJieRlQ+RXxAN?=
 =?us-ascii?Q?h+W5Iy6mEYdL8zqgXM+vEAykqQTfEfIr28qRHVvgVeb4ioUsW9wzAhO3VUfN?=
 =?us-ascii?Q?CRLXbzQQL1adwixuPvhj440VoM7QcKBALEem1MOeVuR97eIajKpM16fS9ZKm?=
 =?us-ascii?Q?Crv3ETPlXzyhkYqqZimtejWhrzQFabLg9xq/F1N7iNng3AmpgMZFkzzwqk5S?=
 =?us-ascii?Q?a+e4vYuoLBhHLaj5ZwLENyi9xh+4OuxiqXE0o3xGTmaWvhotBb0PIiFpRwPl?=
 =?us-ascii?Q?qBao/P8vbmp+kBEXtAX9PbUT0F6IgNw8+TdywITkngP/V4zxAIXn/1NVlcKY?=
 =?us-ascii?Q?pIEKC0b6+ecrVc89/jbxOuoOUBeNugs0uVEPE3sU3VOYOZWC4fu7mIrtPJkY?=
 =?us-ascii?Q?ALRDL9dd1bpDkyJ2ICPJ7ZkumPGvrP52NcNcGotN0BrGD7DatHsfcrB2oLf6?=
 =?us-ascii?Q?2pgBDGvOum4OFx61Pygjl+xcpleTvefCsdLddEKulFp8mN+wkfcH?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D947FCBB89B7A84994A893BB4D9B25EB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1849706a-41a7-4579-b538-08da42f5dbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 11:08:14.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uoE93IfM0NtbojNOMB8pXfx4as1l4gUOkXI92EyE/FdxvGUw7T5rdl3VQRG7YMwSUSY24Eyg9Bu1zFe+3Gbyxf0TJqZXJfdeeALU1SIwiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5581
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> Also check for the losetup existance.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Shin'ichiro Kawasaki=
