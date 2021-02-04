Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E874C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E49A64F51
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhBDJRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:17:53 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45712 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbhBDJPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430179; x=1643966179;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1KCT5TVTOYmycLn1rcCZqHsCWP/L0/6iHafJR9B3ARs=;
  b=f9uckkkDim5o9ExYUJAsHDF+RCAYZLtNs8NePU5JNqNGqJ1NcCQbrkTb
   10jvFv5XTADsz3JFhk4XL+fFtZcYHGi2SKOKN2tb7OH8Ow1KKEvonc2nk
   l8Y7Tn6xUhcLoKOsw9eKDVCD3vzby/4SmjDReeNIPh5FAslNfExm+2jXg
   aR+JvAp/C6zoHWrx9qnbmF0MaKkI3I+oaxD2nH6qwpqPMd1LwcxIX+UIu
   fgCpUtTpGDNEsC8ghB32hB8Q/KvfJakpGwqNXXIl1PkE6W7fV5SKnMmyW
   klytUFs3xf6oIO81TKE+dMyZnFgZFjE+FxDc+3HWX5P5Mglu0nJv1hKGc
   w==;
IronPort-SDR: r7Yp3P45P5aJWkXcpRsKE0ja48s8Xzbskp+c7CmyVAju+zeb17lhVxQ/vjOQaeA4AG39ki4pxV
 SoSKdzbjO1aKiOf65VojaUdC7yr6ppE9SfrMR0KPWCbIbdkYp3NraUB/02esUXvN27sEqi5C5r
 OU5AHQmkjh8v+Wz5TAInhE9kBvQfhe7bt816VMCt+dnvzjVa7bdod1zm00ZVbe6IoWxQLZl4za
 yC4626HGo9vQhQOdfZHeScL9TsrtBi20nxkSzgiUMS23z31AlfffSpJen+oyqzxlMzfJKkt1jk
 GQQ=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="263194400"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:14:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzTO6l8hm9YX5itcWs5Vce7uexrjVOUJWnsRdDv0wTOsg0ai2NMw05UARTe5B4YsTb4D5hda8q21cGlfZ6gEpPXPrRPyO4cHrrBmnWZ/UwUk9j0D6EyCMYAP/IufBnp/sR1xZjbq63G+zCp6yf7rJm8PqQig2ZZk4xZPgKMmrK4AufU5d+B1yp4Y6M2H/fMUjT987aZkExvi4NcOdRHVpI+ywihEeVf0tpJth55ZQn6aBQk4Xgit9EOHmanUpqrgoRED2FUNXPYlEZeT1uuJFcxbuwh50cA1mC4M/x7p3LeXnE6OcjgYBA/6QqiBuQJJfcPV5dfAc9shuERDnib0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCT5TVTOYmycLn1rcCZqHsCWP/L0/6iHafJR9B3ARs=;
 b=TIm48PpsxJ2+150hjrXBNt5Jv48ymz3mqAjijy0ry2se+UlwxKmOnpyIeAF9uA97QIfBYPjRJoOU2lu7WI7/dseIsDFCAxu/D68ZvWz9ehsO5/pD+tsgSdUlWNdRt+eOiWogoOjlm4Y4TZHwmgfpyzQ3lIm8mWE1B2baT1GrFi/gVPSwF3Nv2b0qKNPvdk0kv4N5+2JCiKagCW/L1jh72KdsFtcFyG7eF4TFYxq9rgSZUHoYF3eZsBqrA6YFvgwR08ohfqf3xmEN7RDyo9Y3BCqcy2loG8rJq4niTx+crN6erW5RV8S83rX5yof1msPpCHC1COpz08LhZ+DrRPh5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KCT5TVTOYmycLn1rcCZqHsCWP/L0/6iHafJR9B3ARs=;
 b=RsbdsWwmpo19cWKTKemjHCdpCtL6O79ajSvJlGbHQLdguTzwo76ho06vtMWbP4OivtqP7n04uWbPXY+Bv6f0++z4Ad7sqidr/2kbKFSAwWeh0SbavjQlIKbK41DoPPU+2gB9gFc1JstPwZAPD2XqyIenfXWcJ2z34kEKp0lXNI4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5118.namprd04.prod.outlook.com
 (2603:10b6:805:9a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Thu, 4 Feb
 2021 09:14:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:14:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJckzeVsveL8EqbiqYBSLlIvA==
Date:   Thu, 4 Feb 2021 09:14:13 +0000
Message-ID: <SN4PR0401MB359820BA20257B72EDFBA3499BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:51f:6b4a:2171:57e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b49e4320-7220-49d2-6953-08d8c8ed3dae
x-ms-traffictypediagnostic: SN6PR04MB5118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB511886EF34303280EE7689A59BB39@SN6PR04MB5118.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2TqxOP7KW9fhyST6GHElcqz22F+rL4E/HOQRj+wquEclXoTtxmDfoR1Zy+Vf45JEydbDo931V5OQ4ZS1ni4NJHQJg5HRsJtDw2V5ckmHLFqPf6xrDasLQct7k2p7XEkqGwbqYOoXWDQFtXomoxeJ5UqLKQ1Uojz5Ru20cgTcw6s4a98UjGUBicB0MJQJqUBl04U8dsgxrtfUi27VgPXTC9EcFMmQBJCryGmga9zXhHFOU/jx3NX1YUpW/KAd7o98wCoJTJHDpZwKif1I9ce8SU/DWKmyqUmJsCfD4AySyA6Ks8yNIzuDQfkk9GzIDe1oSFWs33+gHTgCtZD7G7P5hqGWPw2o0CMqCCKIhukHc+NWq3lrUDDagyExQnjuWze9xX78/r8bb7WhSqQq9pQbELIU7OBCIAkO8eMIYZwgoAPaR5G5MOMbURZ8K1RBqLfhroIF0fskGGXQXqcvGYFrwjcea/940I+pjc+sxJAfPQmgYUsh71nTBuonQcg9tY3ylR1BmAisM88bPyLaypu7CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(55016002)(316002)(110136005)(9686003)(91956017)(66946007)(8676002)(7696005)(186003)(478600001)(52536014)(8936002)(76116006)(2906002)(71200400001)(5660300002)(66476007)(66446008)(66556008)(64756008)(4744005)(86362001)(4326008)(33656002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gpkwLuuCzITgebIA/242yFzY6ckTvKu+v3awt8QdTtXv/qtW/ke6mR+azMbl?=
 =?us-ascii?Q?mOh2/eQijeAPLGf7K31LqzULvTddjkjvSHk4tE6UbY4yiJlYlfKSGK1/QN3v?=
 =?us-ascii?Q?JqEu6tl4tB3kxFO5YrJtFQAuf1HTZ0ummOL59RN4KLu6kaKhMLoH8cc05sBt?=
 =?us-ascii?Q?fEPebgr1oSafbRsesSiaq5CFZvc/os3V9bPb1eA0zs12ZPBEqOFRyjQOb1cQ?=
 =?us-ascii?Q?zYaGDTIXN2149tLtfw3v4wd5zhL5Tra/NTPhuSyGLAjjAFOVwIz4Va11sepa?=
 =?us-ascii?Q?XmYD723aRh6SO8r38C84P95DeU3wsF7zrwa4Ycn3eurM2/egiiVmVJm6VboZ?=
 =?us-ascii?Q?+keMNocJyntgsNJS1iXtrJc5ok8urQcmlJPz4SbCTSkR0/OJCZ2Zk97YqGN2?=
 =?us-ascii?Q?UuXRbdX6/LxwZdb7+FknPlXBF/r2geAqnGK2uGSAKZ1rBWP5vA70Z7aUp1Lj?=
 =?us-ascii?Q?TusRU8QKKKl7R49f60KiOTZSZwR4Z+o0KZhW89uOtil58RmZOc6WmrY1z9jJ?=
 =?us-ascii?Q?G9Yt/OCzl7JiPWDvxf1wORQFqrZ46D8EY/+p/kdUEcx6jdAXhEApb2HT4TjF?=
 =?us-ascii?Q?cy3UBvMcyp45snhg+ElJJBA3mNZ1fXxT+/et5ORwolW0yOHpa7yWHcKFvGvr?=
 =?us-ascii?Q?gOkQL0Qpalq0iDtz4po0Q8Wx8S2Q6U2+9Cnxscu0Z0Qr3ExDd0Qg+s0iKNYo?=
 =?us-ascii?Q?UkOfYoHZS23G0o7GqJ2ntKFTdyTZwj2FXdAwLLq8gunVCsu7zNigaywHIPUQ?=
 =?us-ascii?Q?xyXV/ET+5vgqS9fz05IvHDrAIPsWb2Aq0AphV9+Q86ii7H+YNTTUtdwMGFf5?=
 =?us-ascii?Q?xc1bqF1hp5EdTTFh4e6xWQaubkssoA2/cE60f689+ErN1Yj9NyoUhEZX/XIe?=
 =?us-ascii?Q?paPHqEfn+2MLLLqIksycp36Rohe4mbJkdCMsAWUgTE0hDMBbGAFm25oZgknK?=
 =?us-ascii?Q?moYNnuy4OfGaF5ZzRviVNiNZ9wmAIHiNeKjbFx8U0o1GYf+DS6XYL6WVm5Pn?=
 =?us-ascii?Q?ht+nNdm16MYznwuNhwHBOc6xu3o39zoFFlCltjRSRMxvulB+HrdzKSIOfwt3?=
 =?us-ascii?Q?aH8bOLtvoAUoxBiXS5XiHEVcTzMZQJA2sSPDsAPFsnGa3GYPp/PKsNWb19TO?=
 =?us-ascii?Q?5XNFQV+uroJebI5ntvC/kDZAqgfvJTOS9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49e4320-7220-49d2-6953-08d8c8ed3dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:14:13.9320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7SMfGCNh5ZIQoTnhqcu9MwLzPtolLLfXEM436a/ck3CkyahwuXPT2+eZ9p4FywM1x2ZaoMxWbHws0c2/CDokflPwBFj1YmBLEoufRm9egI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5118
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/02/2021 10:03, Damien Le Moal wrote:=0A=
> On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
>> Given that #1 in this series is accepted,=0A=
>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
> =0A=
> Do you mean "if #1 in this series is accepted" ?=0A=
> I have not received patch #1... I wonder if it hit the list ? Did you get=
 it ?=0A=
> =0A=
=0A=
Me neither, seems like vger is acting funny again=0A=
