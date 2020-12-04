Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F21C4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126AC22513
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgLDDVu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:21:50 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40638 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDDVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 22:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607052109; x=1638588109;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
  b=VLN5E4cs8h4y7GUES39cuIpV31MAILauCBql200vANWiFvzH3HCkSk/L
   8XaEf/GLNRnapba0atUAIx+9Tx8xYrgGhit65uM+0yGyk0fmG6HLJs3iU
   GeptogZ4tYsUxozDB/f4FWtOCYTcK9dxt7ABGP3TC+LbyVIjx7tUR5N4D
   v0aK28j9dr22jxi/XYY/6YUgrposXiWlt5hlnexR5zobCU7XcmyG9wHht
   XzKiKCtcUt9aXmPQcau/JXwXZ6ag5T1HJKTsqRIk7nbRp1aSFLmMqDb+Z
   fwWlRVGXaql6t3IX7xOQLrNKaXdALwf7XoLZkRkWxY9Rcf5gVe1tBW5J5
   w==;
IronPort-SDR: oZiojuzW8PE/65kwjwJBwO/t2t/igC+5gjhhkpKhfcWtvc0Hm4KXCAM5gLovhY0TxG2FV6nHD1
 8ksDRDDVQ2EDyyMVZO7EiAZPB3LcN4MLiiuwPEqMUexkvmX6qnf+GNqLEvSGGXRigrnQi671Nz
 Sh/mLgLOJbW81JqsO25UZ65nrwNxtkuJkbjoSt/uESjFTVJO7OoBX1mklLxzQ91J523hB60en7
 oXPSPh9pgEMMOJmLVjL4tr5Fwv/XP4Ungu62tG2gaMpLkSGln2CM/ACQB29DYf22BMik52gt9H
 g8A=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="155613407"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:20:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3qs+eyCeiRstJlyooTMRmnL35heDQlPb+8xRmkJY4wYq2O6yKnGyLu5Ogqe671cuMh1Fum1jgStubLm27DVaPpuNFahrRfVZyfXlyOZ15dctgQpfwIIAAnHsLt1hx0pNJgcyino4xtxwGTM1oBGfOX8fnHU+bM4GKVoqtRhhbh6cg2AK655+FpC3xI9evRfM/1P+bBXPcaIQBAWOz/e75bj9VpgM4nT3pQkxu5b+yree6KKd6I7TKsKiJZ2Nidv0t5WMxcJeTHJCFi11EF8YNenTn7ARCETKG8t4qbg2tO+V5gqzxKrLr+56iaBewqZl+BwmuXJS1NYYzNt10rtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
 b=g2tL7XwKIh4ONprk3KGklZj5PcCHJH/VV9fSh8x1jI91Xl9XHwbGv+mOOLVmofZvZFA/SBit4N8U3/4zdzU6CgLFue0c95tsuZkk1PrB8eb4STKWw9sSfMtX86850eYIebC1qHG0Psr3fRREALT3eLao4Sw5qrNv67V9CqNHspB/4xY/UH+TPHmKdXQHS9CpeCoyeEIHrmblOyTu0cuxRYEvBtsOvpYciEeJrkZ/3nxjqn0Bdh5SiThr8vRbGqpdImMTRnEaa4RMKTma8scRkP3OThw0FcXgd1R0sz1RFZgCkylTaWXoGrqYPrYu5kBJ9X9cq1z1bEEsCVeHYZzSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
 b=J0LKl43FUzZTPa8TQk07iGGS7nFvasg1zEK5uCgLC9bkeVDZDwLyUqku5Omw55KAwhIHvxo7HuAc/TyxbM9tggB4z4cJnv6RHpGdPMatrKsHhbM+lBY+1Id0MECAqXj/iKC7yRx0mVAoeykc7p70ocMY7HqqtDzUuQMCV3CiArE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 03:20:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:20:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Topic: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Index: AQHWyHOq9iPpg1Z8ikysV3+jvL0kGA==
Date:   Fri, 4 Dec 2020 03:20:40 +0000
Message-ID: <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
 <20201202091018.GD2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 147febf4-6c10-41c0-aff4-08d898039408
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB75018BE5E3CD5B1FA509276686F10@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkoF9VVzAX0vmlvpk0vjsaOHzp/iNpIr/t2RN6y84Q//qssq313msrryvTShHXK+g2RsWN0ukSs4TR1VIGxokzzxs7gRrAfR1Z8+UrryVSbHvjvm2KLizzIAALwyioJPE3m/dNL0EdRsJOyI9UkPRGZ2keZvPfkGum1pcvCE27WxMDyntyHMeL3jgd8CUS/3Sd82zxZg09VL3F3KVaf1keAtgCvRAZzd4d9ui90y6hRVMA4UJPo5tsfaJN+jdvTEFT5mlOdfGSF5q99wmVr7xO8rjOHoVT5mQO+VVpBja7GdEl6N2tHITpbCCLuU2NH7C/sEV/c1VcdNUmz5piWTGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(52536014)(2906002)(8936002)(86362001)(186003)(8676002)(478600001)(55016002)(33656002)(6916009)(5660300002)(26005)(66446008)(66946007)(66476007)(7696005)(66556008)(64756008)(9686003)(316002)(4744005)(76116006)(4326008)(83380400001)(6506007)(71200400001)(53546011)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YmutPGQ4Of/GC7qNeWJufeDdkh9aC8YWoHVs1u5reFXiTf8QZQYS9VrzF3ZP?=
 =?us-ascii?Q?UEU9g23mszAJjm0RdOqPHMb0CLcf8t91C0FPzODtZijNPPoLVX9U5Cyh/0tu?=
 =?us-ascii?Q?gvKa0A3qQXRdHTLa761UiNf7mqOGN+oOxCcPdQY907DuJD3pqjTqEpL0NkkZ?=
 =?us-ascii?Q?qVDc2h4wIbT87y/ksSUoY5fGeaeuggjgddgHF6WWH0jkWal5g8AnEcJSgZ/9?=
 =?us-ascii?Q?TwIu95ep9ToHyGM6P0w0cT1yrxV2Geygo3VEpE5NPDfXKgEIdwySffHcNa02?=
 =?us-ascii?Q?o41ojQnL7ZeZjvAU2YhP0Wu1/1Br4JG8g4J3sAYuWJJ7SvTtaYG1dl+tcQJU?=
 =?us-ascii?Q?QkPXxMLfCwH5RtV0+iGwYcW/C9IWWWqBL/yxiABPbrdbSigc0n5fWJwTqGsm?=
 =?us-ascii?Q?faCtOpdJkIHy7qTERYFnW5n1NwM+5LngvvP5Y/ezCaPRjT+2bx04ZYScR1oK?=
 =?us-ascii?Q?MlK6ves/ad0ANRjBQyauASxPbCdjPb183+C4ZelOgYVomDg/nOyW4b0TjN4i?=
 =?us-ascii?Q?yt7HK7N5aHKuKQ0GLZZ6DPCrdbDQrYLSf71DeKZhphL2AQ7sHbMcHpYP6boh?=
 =?us-ascii?Q?22G7jmLGnXk7C7dWJ/0+9hkOzE18475ictS52M+RHcklnKOCmNCrUOYf5N5l?=
 =?us-ascii?Q?shb44ybT8j10YoiS9SJ9ZfVC6J8WG7rxQbjp1OziX+ipOc02gXph1eYw6j1x?=
 =?us-ascii?Q?un2d1i2qqn4ksOdPwbaUhvjdtrtznnwK3fO2KHxyvl+qbcWzk/jB8fOkHZHS?=
 =?us-ascii?Q?HqcQ0U7/JLaCGzZRh0aEbfA0SF4dcqRVu7EtedW+4OAnzOgouqNIjE1fksZ6?=
 =?us-ascii?Q?MW6L5lne/Bq5k+A3gy8OLoZwgCaQcvp84IP/xmM6CgMefxU06FYrEb+56JVX?=
 =?us-ascii?Q?btzPubfOwJG7HWX/AQXmXwJiZjPyVhMtKCirUpckbjNwqNYRVxrtcKf+fP6A?=
 =?us-ascii?Q?fkzC0ajBDgMyoc4n1kDLpqBilIoOjkw9Wzs/cYGbCZQaYCL0kDuBjxa36MUe?=
 =?us-ascii?Q?/xqL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147febf4-6c10-41c0-aff4-08d898039408
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:20:40.7946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWqqEdo45hLImUTAN8Sw+CPyH9e/x107ZzRvpVFPpClDessQetzHZnrW11xRejJuYbknbpuG/Lb64h20Ad0MLjD77d5bPr6hmPZm1FMKcgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 01:10, Christoph Hellwig wrote:=0A=
> On Tue, Dec 01, 2020 at 10:22:23PM -0800, Chaitanya Kulkarni wrote:=0A=
>> Update the nvmet_execute_identify() such that it can now handle=0A=
>> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows=0A=
>> host to identify the support for ZNS.=0A=
> The changs in this and all following patches really belong into the curre=
nt=0A=
> patch 2.=0A=
>=0A=
=0A=
This and each following patch doing one specific thing for which host=0A=
=0A=
side component is responsible, with one patch for backend handlers and=0A=
=0A=
wiring up of the same on for admin-cmd.c and io-cmd-bdev.c seems=0A=
=0A=
we are packing too much into one, unlike what we have has a nice=0A=
=0A=
bottom-up flow for the implementation, why not we keep that nice flow ?=0A=
=0A=
