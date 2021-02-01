Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72718C433E0
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 09:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B10864EAA
	for <linux-block@archiver.kernel.org>; Mon,  1 Feb 2021 09:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhBAJsc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Feb 2021 04:48:32 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47413 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBAJsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Feb 2021 04:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612172911; x=1643708911;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PpJoBnejVqrPWyAtyRvOoW+ypFLnUavc1AJbE2Zei3Y=;
  b=ApY2a0XpyUnM9SdTIKWxR7LPpcsX6P1XJXhABwkMXB5Zq5fXVozcq6A8
   XSizH22VAYxbyu3VI8wcoGZx/Il9XA2oFAXFbBSOPNYEVPLxvG1uATT7K
   ILfhtRJc455A2o0knWYrP1fpJVwLdteMvEB3jgWubzAuIadwMxZYsnYXl
   LEJNfZQQIjhebrDyc3Un8HeZOVQops7UdJONUBvqInqbsueYu2lHqjHiW
   +EMTKI/4YkIwHYpSNVXEWC+psOUvCBFI5WhnS5OGdUIEbF0kP73Uc+DcR
   HGs7u19t0rnQhV4gOnmKINKzuVOJV076YsJpgq8j4NXg6oxQ8tQrOkDS2
   Q==;
IronPort-SDR: B+fnF3hyJcpt7QZM07aNRM6oAJJUiuEU2CXkaj7LBZa+uqZOjZEtbRi2nnXu2IfGWTyDn9/mz9
 z8Y+bV0H/axY0TarWPZUGXoQVqeVRlz1xi6R5cY1KJXwcldiCyeEuBUJwzYepKhocv6BQHVZgf
 Cs0U+zjGftT3ArDjiXqDsEuHWgSbK14wZgu8otFCJ3qHUkG+im1AZ8i5EillDx+mtlAsK7WG9n
 qZojrk8uWlsYWPJcaSOV4Qw7Vx09t5tOOsfuaFs+76Ip6k87+NSK7hPX6gLnd/7p3HCIgZzE1h
 H7Y=
X-IronPort-AV: E=Sophos;i="5.79,392,1602518400"; 
   d="scan'208";a="269213141"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 17:47:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEx7rRLy196cwmRUS6ry8frKqP5sq8fzNO1bSIEiMBt1idkPFox9GgF6P+bLl3Z9vwN1RwqcZZQu+37kTfMYCWLnfMnqXiclxh2AL0VfzqJV264BQ75oWf3BMdy6QgopI2PAN1GoPGkO++4Z02AtbYGOS2lj8YxSeXVpcIOpXM3fUZSnmae1wYpbAcLOlR8nIBNXx7HVrvSob2RSDyU1WLuObq9beN7Ml+qioHxbKy6NSV4fsg1Yo92HMRavkW9JU47USgdGqF/hIyozHDDK8cAK3rQ6YpYxO+UF1mgCbqqfYY/bNRBq5CyhZSJtLVZ3/w7WqRVIGvtgqoo3e8FUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpJoBnejVqrPWyAtyRvOoW+ypFLnUavc1AJbE2Zei3Y=;
 b=cmXq/q3KRRZ05k59u09l2HNPY01VHjL39Ir4VCLVrHhvpvrYAFs5AjAG3YPtX76Ln00jgG6TIGygWf6WzowAiixvPzBj1nLRRHEsxXAC3KF+W25oP7PYmlh4ty+FJ2R9eiWmTPgr7y11n58w/2bGJFwoEKzqDvuSAP32Md3AaJEstYfpI7TOPjENo2yoNCtCF1FxQrNr+ehXHWsgpA6Ohyyu/+GJ/jzFZYkXdXdGaqaAUcnQx2g4bwLceDtmKz4HYGIWQywWlnYO0l9vUodVV+U/QB8Ov0p5fpwWaP55LJG0+hAVIxcHSRDNoC9yVqrd+P2riPFZqezwLahScBxEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpJoBnejVqrPWyAtyRvOoW+ypFLnUavc1AJbE2Zei3Y=;
 b=atZViaNM/tws1MVlUZTPZeV7uHXpfbbB0k5Sv5DIJNeB7O/O5cLaepWnrVbhWSfcduxR8jbUfMrsvlEkGYtPDRbxZY7xdrIcvf5/1hbTrQEHQxYwnzG99QTHtbCC/yQxOf28mxaFBp6U0tBTkHYIGwr4AXa+1SkA+ycaifqbHrE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7500.namprd04.prod.outlook.com
 (2603:10b6:806:14d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 1 Feb
 2021 09:47:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 09:47:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH V2 3/4] block: add io_extra_stats node
Thread-Topic: [PATCH V2 3/4] block: add io_extra_stats node
Thread-Index: AQHW+DnWuHw03NMd2ECw7ZTtJRpHxA==
Date:   Mon, 1 Feb 2021 09:47:24 +0000
Message-ID: <SN4PR0401MB35980F52820FF8D6B0E3D8DD9BB69@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210201012727.28305-1-guoqing.jiang@cloud.ionos.com>
 <20210201012727.28305-4-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07c02a82-ec77-44f1-0e42-08d8c69660bb
x-ms-traffictypediagnostic: SA2PR04MB7500:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SA2PR04MB75000B4CD676517CABD2915D9BB69@SA2PR04MB7500.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ9q6o3q3xvztFMc3CS6zXmpKMEb6XDVr2Isy5/GIopXPn+CQ8bZktOkfIshTVwSz7aQWLWTvLWHiZZIPFfhKBTwfauUUl+/qIJ82ykHV81WZPfte0LtSZ3X4un7eeCS1FUxJjWnlXCzFZz/BoTg5Ibja+9U9TQx2CqvixwtUN180W+X/fT1W56sNoW09h7sjg5DgER/ytB0kkahp/4VQuJlalkovOAj8Abzch52qPkavkKHb/tkhFpb50UD2fy7wsAiCaLLzEegIhracIg+yc0OvZFfU1+GjLiw2uQED4rbVVIHFgWdjqriPa+IhXeG0qXO7LlwSdL44upsiasp9KbecLtTgzec1nfOUCeW9XhW+SnXaOi4LKG9wSYDYD+uZQA82eodPmEzIe5/QC9uZ4cUwi2TTVEMzqZKvgaZFMZuOs9ITidyMenkuAqlfXEJgFTy2kmrQmI/1scNVwuwK0Nfaf48q9NQ1RaH3fFCtVIobdQRRd3bLSB/ytzpS9efGRHE5ruB2FzmqSBpVRGtcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(8936002)(66476007)(6506007)(110136005)(52536014)(55016002)(186003)(316002)(33656002)(66946007)(4744005)(9686003)(71200400001)(76116006)(2906002)(64756008)(86362001)(5660300002)(91956017)(66446008)(53546011)(54906003)(66556008)(478600001)(7696005)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8+7xpPyEmiUHfy0JsbmVf+H3VI9BEAwNZuD2ujzw0iYdnsto2e0vvVxj2RIA?=
 =?us-ascii?Q?W2M+WvIL9jlhoHDfk5XOO8dDOKZVQI4mxG6kRXSc2SX8PhV7wyc3hOwD6sOy?=
 =?us-ascii?Q?/xDh61Rruzl+hgVOzlPwfHL96u5QUnb6fwE3WAF/o9CuU9iJiPUS3ueKtcrh?=
 =?us-ascii?Q?QOUO5wCApJEbSwWIHmQdzBrYOCNzcKIrhDekm+iqswzUa+mBM0ooTcFwY5Hy?=
 =?us-ascii?Q?DxiK13krNphNvojrUGwpaJ3xIjx1y2Uo2+hmniCcGocyv5XvyB8ukiQYnxTd?=
 =?us-ascii?Q?slrYjJOZLxA5Gf/1P8gBt/nJSX6GXvqM1SE2xVaPxnANI1pCOgt+ot3ezPnE?=
 =?us-ascii?Q?1PkIIki6FWskPRmgEHEcXIBiAuOAWCmqk8b4vvxYmb5wIZmXN/AzidMGG8Yd?=
 =?us-ascii?Q?g5E9F592WxEz9OKZRNw/1USZfy7H5zlYDzPOCxyKTQ6b67eWLDZspzGKCW/8?=
 =?us-ascii?Q?87b3KTxX2FHF/4qQS0qMoOFqrhokaYhUWLJYK35A/4a1xljpoV3wL4gy+gE3?=
 =?us-ascii?Q?dP2YrTyaunLqvLXuvePVbxTeFZuO/T4e6UDbt9rgWLh9wQeoeMefiVohrwsH?=
 =?us-ascii?Q?u6fxocdmWvBLFE7AKMwN/LDHbR+fotX8TMnscPz98NgJsgijB+mFoCR3MtiS?=
 =?us-ascii?Q?drJmRvm4x8f1K6d3KGhKhLSFWsmXqpe6EnO/qjJSBhsenKHX1UsbA0yNHViB?=
 =?us-ascii?Q?STnC27GSJM9y4gEk2hpjyqBYo1aMvGZAHSuyhY/PHhfRTPu8R8T1BHYPUiai?=
 =?us-ascii?Q?OjosdCijhAxCPw8wWEHnu7L+AWJ3l8FCpXuBJcxO22AQnPqBg0RAoej0g4lb?=
 =?us-ascii?Q?d8glDE3W5ovQAkbae4WkIuNg3cK00T/MjbVnPqyrbvq2SZhsUGeRCgeyDnTD?=
 =?us-ascii?Q?mpw2wUvYOlUHz5lKeG3/5YLRQtwKwkH+eI47tEMp6m4g1/afWhJE6kX45RTM?=
 =?us-ascii?Q?AO2DB1PrPLCZeGPsYnlFUl8FqHLWG8GBenUcAsce7+aBGLAke0CAcyvjD8Ko?=
 =?us-ascii?Q?TGCQpVaqBYdiJdVJy/s2mKrOXFLYgzETiTerBY7yHYtxtAD2bRY8P3obz1yR?=
 =?us-ascii?Q?dbgh/DKIdb/JNCXiGQoM7EFjhqLw5bOVyjANCbHU1bIfbKNSI4Jqgoc4Sz/z?=
 =?us-ascii?Q?+Km4dW41eKgOr0BkgPBQgAZD3XZ+4Wc0yQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c02a82-ec77-44f1-0e42-08d8c69660bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 09:47:24.2441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K27oq9iYb8uAfBHPBDDKHFeCJPQmDXxfMC6w5NBp461PNIJcOhOMK+pK+sS6GthslF1V/tRnTglZ7pEZwRfjxKiYN12F4c/ukwOFCUTBbj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7500
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/02/2021 02:30, Guoqing Jiang wrote:=0A=
> If user doesn't care about the size and latency of io, and they could=0A=
> suffer from the additional overhead. So introduce a specific sysfs node=
=0A=
> to avoid such mistake.=0A=
=0A=
=0A=
I would make this patch number 1 in the series and then merge patch 4=0A=
(the check for blk_queue_io_extra_stat()) into the patches adding =0A=
blk_additional_latency() and blk_additional_sector().=0A=
=0A=
 =0A=
