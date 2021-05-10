Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD32C433B4
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDDB61432
	for <linux-block@archiver.kernel.org>; Mon, 10 May 2021 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJHlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 May 2021 03:41:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50287 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhEJHlG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 03:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620632402; x=1652168402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5WHHYufkFosRLMeU9Qvr8NzBj8t3KybJU6U/tENplNg=;
  b=KztQYFPWuZRq0kW40D66ddPJelO8FkkUbDLxiGZYFosHBGWBfMf/dDz3
   UTiSKhA0AmNc5/38zxGRoKxS1Sw0ZGYWzlf7jnOdvARjMpThFJ3CDthby
   zxrxOAqna1jLoSvlUsWbI4i9RX7kP94AxfQiUFbLZO+MztDAywwEc4cYa
   89Gq7kPmm+BxYYZkDFL0k5kxfwfI7rwQYAji+0ANZyBr1XAvGgxft0WwN
   0lYH7ObQu4pPKnml7/L4DgQCSNR8j+nWxMAK3Lmo4KLHOqh7k6obcY1Pt
   095A8qp0I+nXGuh0Ru3bov1JEhvl1WU0LgkiBFa7pZe8hWaRIqFGh33UJ
   g==;
IronPort-SDR: ogfYJaFz8GkDTNFPEZZQO0S9hoYskJrDNlV47ObNp+eRZGso+8AWkJ9qDgj+SCPQQI2eAPifbR
 9E0ShoidlUzrCTL4VDQ9nu3Jtw+V8O1shzpfxaiekLcwywh02mccVTrNYhtYa7+Yc/EuqUpqre
 kgHsNqr0BStjbdVUcTYV9HnohDuN6h+kWofmRHV1XpvNo5EOyq7uFKfV5Qy/BH77p5aadqLBw+
 ODLYfAgQ6J9jZyM0OnMRkKEIWbP81faI+9RWKJtD8h44t8nsvDhXyJixr/Pt9yPatOvukWvSGW
 cHs=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="168156382"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 15:40:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXDBNNqMZaa6tQH2uoAjnX2GWrOyHgR260Ul0ff8jSnaR27Bhc4JPAVu+3bnV69HuNCZXHPw9eUKwzUTD+htF2hVYLcSMznccqgfCmyLFsdn+o1gCW66lB7pYXMYpqGgafknSRv3Sc6NhTE3iIV2aDQRA69Zdpan9Q9IXs7/OJ2qpv3FyQTqxwTcVMRP2WHwU+/QdaDc8H3Ybk3GEX6BiLsf0QmkJHuo2wA87WOeNRYbeMicX9ExydIy5jaGnwIqnejMumBzDaKTEkQtG9hLXqzojjqqDAsgmFroAIo39fhA+rieNWoZ6KOBFZZktpaAphkDrRFDfF4PcTA/ay57Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WHHYufkFosRLMeU9Qvr8NzBj8t3KybJU6U/tENplNg=;
 b=kQu42fwkr3J1QuNTZB+azfxJH9HB8uIA+C3Og33JkaVsY8U2sAePjBewLjjJMHqdSP3E9ds/jO9nA+tjy/6jzO9EFnfi6HSLKhDXNmSFyhv0oLfhxxJ63/SpKhQjdyUWIX8HEaG/imLqz5eP8nww7B8++pHFzJmriFE8bRLMOwPaqpxMz8lyR+DySVYM5SESMJa1J4+ukUxpP0sLqMqOBYxTFUEgGAr/sJHfUmqeYRt2BvFA9/wretmH/Lh7JK2UU946DMe0+ZSJs1OdsAniJPdZ6mVQUCNmBy9nAKOMH5RfvBIlthQoU1YiHoiG5dsrT6dTLY7ABcpN2JzhmCG9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WHHYufkFosRLMeU9Qvr8NzBj8t3KybJU6U/tENplNg=;
 b=DcfcB2HYSH0oet1PCVBshVCjmmx6+9wzlH76hWTim3BguNDlEV3DtsPe9hy2GG+PBQ+Mm2KIvLx3x3kMzdq/ZEBTvR8W6cI1PrBWAYAa79+ZNagbwqxlAWoeAxQoP3vBJ/nUDyPn/jeRds7xC9ZI+u1lCdrkKflmG6fCmnLD2jc=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB5945.namprd04.prod.outlook.com (2603:10b6:5:171::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30; Mon, 10 May 2021 07:39:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%7]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 07:39:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD
 cards
Thread-Topic: [PATCH 0/2] mmc: core: Implement support for cache ctrl for SD
 cards
Thread-Index: AQHXQohNKxu4RT1OFEWqz8n335r4pKrcWPlg
Date:   Mon, 10 May 2021 07:39:57 +0000
Message-ID: <DM6PR04MB657511CDCE94264D080F006CFC549@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20210506145829.198823-1-ulf.hansson@linaro.org>
In-Reply-To: <20210506145829.198823-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1202a52-84c2-4733-e497-08d91386cfab
x-ms-traffictypediagnostic: DM6PR04MB5945:
x-microsoft-antispam-prvs: <DM6PR04MB5945EFD273C0D9543EE9971DFC549@DM6PR04MB5945.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1r24pmASbIHZDUTXBMdf3+LOAjQUy/+U4fQsaMozSQGeQp9NOWvu7wiJMvwgIRjY7fpbukkqV5a2XHL3lSh4c+vhSMOL2KC3Zb/yEvBzlk7a+BKV6WZoyHHDjg+tGVf9aY2eQ7aK24BkOaJDlWNCEi8520ZZTSb641vxeBxk/kNQvsoiMv9+lNCkTM4Spe0n4tngdXQ5yW1cZvfKbPeZqS6+9bSMqYJLTm3kixUtRakDCUVAcnvfXKk3a055mMCzpEc35XOOkm41PyrZUGiBmNDSs227rXyq3iY+/lt4k50k8n4suZ3Cm3DyG7sjRY1TSbNT4TYPwHNG1M50DbXVJ1fzRlL0wllXDQGNL8Hx4gGyvERI/sQxNPhg3sEoHnQ9zMTp6VtBM480doKaSkRE+RP+GoKmrSV67n1EBRUJXrw/29RMw31k7zu4XVjquG1m63J1vJT50iL7Q1rdipelgCE7lPAhmwhhanu2qLXKvjkQrxJUiOGueEIDECEuQC2xhYhMBIu2xTC7NtJL9s3vxQhNShyeLWUAFOGxj5RR3/DAh3Z+HmUuTXXTb0+0+PGsUnEGSFbgsDijALR1eSYSMjcLPIee+1Uw4JfIybwWe9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(478600001)(52536014)(9686003)(122000001)(86362001)(38100700002)(8936002)(8676002)(26005)(71200400001)(83380400001)(76116006)(33656002)(54906003)(316002)(66946007)(66556008)(66476007)(4744005)(110136005)(64756008)(4326008)(186003)(7696005)(66446008)(5660300002)(2906002)(6506007)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1wS2NcbujIS4j39vHikwlJfZpS63WjFTycfIbGlc8uDR5x6xjw/+PAutmyUg?=
 =?us-ascii?Q?IOWXwayyTZ2tEcKeBnVP3mto94DI4+9O+rwJGGpQVyPDrkEP4/2Ac2aJ2ORc?=
 =?us-ascii?Q?HmqeL6L8JZDMuXDu82Ty9NSQ2iVpY5AQwMjK8OYx0z6lSy+V0EKfMzoQKL5+?=
 =?us-ascii?Q?BLXcE5MCgGH0bjWjX72eslTkWjkOsS2G7Js7aZykbCNC3OrJ0/TCJDf1CbKT?=
 =?us-ascii?Q?TgBFLGZZ+zlnOtCz/ubd1Ur05i8EtE0SUisFrF71RhNVFJpP6Ad/L3sWxmjn?=
 =?us-ascii?Q?dQMaKRBWfjXIZ+VImql+LKnPr1Wf4jp6J3mfOM5dHBhQtJT5aR5cnEkNQ3s8?=
 =?us-ascii?Q?Okww3QL7qrb1NsuxR/wxPzbsCue74kqFLM4kYUg0QCn8KtjJ4qkWSuzP2pr2?=
 =?us-ascii?Q?/O9bPN+szzzjrf0UYwxJLH17Xn0xR0c4A/rn9wnz74rTDDymtrRIXy6jyjKY?=
 =?us-ascii?Q?1AMGOCHt5FUa0ht79kBKOGyezGbVY99lmMLJyVxa/RoZ9Rqe22b9LmYd5hSF?=
 =?us-ascii?Q?T7dNBuRYJ3Z77S4pg1uZhpvvpOOvGwEyHB3asgFO8J+BquPTJWMRnvul8sdR?=
 =?us-ascii?Q?nND67qLhI5N2gw5RdgLN8a3nfDVleN6fQL7kYPmO5ahp17QlF/dhcD0oF4PX?=
 =?us-ascii?Q?MannzmOcVA8HGqqlS7L3xp6O5sGfUFF8yCpQTNwAh6br54KAGb1ApK0w8n/W?=
 =?us-ascii?Q?dy/8/Xc1hYzM7Z8YLfrynaBn1FKq5Yfc4tsiMOy7bWnj4UBEJP4eauBqJTbX?=
 =?us-ascii?Q?93MMUkxiOG2xvYklf2O2IOZQm5he0BiXsRDlq4Dm7RB1CylqaHCQRI69cyaz?=
 =?us-ascii?Q?ATSMnlzqFcqNo/CYJHqAjnGKaRI7Rc433WyRAmiEmCpX/jZYd6DgGN5VqqBa?=
 =?us-ascii?Q?JVWxte/q5NjbobdLs7YC1iX2xJWq+sifdp0s7asrf74UVg2RUA/ywNFfLwMf?=
 =?us-ascii?Q?37j+JqvqMECZHdIn88QtVDPRocGLBagae1WL6BH2tE8PeH15Xl3rZR1Bohz0?=
 =?us-ascii?Q?7IqUTHnIykMdSGy0XushXN12cYPe/ML8zHtN65KjmAYPAOZCYWe3SOL/1AtD?=
 =?us-ascii?Q?GAj9rKtG/FDwk+UzKOHGB6uVG5i/4WuCLPoHPcQ3TBVgXEaTOcwTAHEIdLAb?=
 =?us-ascii?Q?lzv6XALY7qrLYxkm2D/lvsuBNYXc7krMhUzPLega78uY5KCvfYM9eTtwH2lY?=
 =?us-ascii?Q?tanN1Srj/osI6NHsBQVa8WK6V80+8wxTeo6SebIVQaTkKZb94zKBTu/CrAJF?=
 =?us-ascii?Q?psPJWgVjLV2ispjfHXOSOZfjPk6Vj1vl32YqU/Lr36AK6dlmZEpQs/IGeOQj?=
 =?us-ascii?Q?5p+cmE3c07BmKqHo1aMZEkqm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1202a52-84c2-4733-e497-08d91386cfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 07:39:57.9279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKbHDYyNZgs7We3S+wH3CeiClVLMrmCgMGp7gnFJXmqvTM5YUkTtjmp8f/mhQYTKzRMIVVpst2s2tzku8ijAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5945
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> In the SD spec v6.x the SD function extension registers for performance
> enhancements were introduced. As a part of this an optional internal cach=
e
> on
> the SD card can be used to improve performance.
Just to verify that you are aware of that:
In addition to the extension Registers that were defined in the physical co=
re spec,
there was a separate document that was released that suggest a common OS AP=
I's to those registers.
It is called "SD specification part A5, SD Extensions API specification".

Thanks,
Avri
