Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D64C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7366264E60
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhBWTdm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:33:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:1736 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbhBWTdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 14:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614108818; x=1645644818;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TwsGQfkdUtoOX0IPMFnRurJJ/V4acOSDMyN0k1a5/TY=;
  b=Rav+8EIQ8va5MjD6K1aLIXpWXbtSTKQnhcrh2sxXHG5gW78J2+SSsQ0h
   aD7prlS/lhHu1K1GWHjfQ9joH0dong3V24ouvJcmoynZLVq7ueyiufadJ
   Cn/dFGoYsI0+V6qg4+6Z/foIfQSUVi2OsvW560NOw4rOUWv3gpjnR4k+g
   SPxtyjVwkVuD5IjlApC7C/rHUxj4Zylb79+mcPRFoifI4cPMv11J5PCJy
   RQbPp1KGrgomtsFMQpL9NI+IczAzy3ryPr/CRLL6rbLMqz1MMNke+N14/
   qCRG7w9l+61bTAXVSFwDjG/MOCzRrypT73OeGJ6YpsAXpBTs3rhu+ThOl
   Q==;
IronPort-SDR: kFF8j4y7MOU9pu8o+/Gq+qqmcS0UuIVC4YHEDy1m+u9nDWPRBOE6a3S/K5R472K4mTweNy8MA/
 4ZPXcp7aG30arTeZWBycEHFBo6LSGfyIhwkuv94M5TReKXnpxfrEpdHXsOx8mMsONFLGXDur54
 5HwGr0NN+ALGvWhBMipkH/pQ/kQKvyf7DGXtEY0wAU0XR+kUoeb+WG2rmH/WjG9dAxD4JeMvMg
 WvEUUzjx0xY9b+vJDPL3pPaEyaJYENecugP3j6aAAGXJaFT3k4ntvQK0LCaQMKVCqfc5p2GajS
 ZI4=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; 
   d="scan'208";a="160638920"
Received: from mail-dm6nam08lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 03:32:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVabF63d4qXa7MS7guxyXPTPw26+k0VUt9WH3UtWqj7a0FoJWsqxWKMKu/rMoA14fqUfu6oNDgr7FoFie7D7UiO27Qh7jsOQMCkGFi343VUHaZ16suLpAtwpfQR2t4bkQbxmlsmH5/rUhaboR2kH5VW2dDAlQk7S5eqmtKL4loOECP53Svww3QkbReJPSASbEzbTF0W8pZPdToSQk+I3g/4iLO4J9BS0QY7AdK65pD5bDPygpTOPDHr5XzQ/IBxvdbU+vFrDllnfDmfTaevj3aic3CWGr8jXNPjl5/o466Uqq70QMHc3E5ePAaMl5Zju9a3C6Ubil1pP/+johvO5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwsGQfkdUtoOX0IPMFnRurJJ/V4acOSDMyN0k1a5/TY=;
 b=Uog0hSwKeGRYsY6yaX2Sg5jBxVf2SnWkPOcFmnmrb48mxm5IcIDq4J5dTKh1Z4/haviY1GcuiIKj2IKmkxY16j3aXXeTSyRawucany9fI/JyMkrmXdxALTORxmhjWdRaBUOTPuG+2uWTbLcTXqFu52KqSEbSGJ+YXcdT3vqsj4p8fIq8sAtPA3uoi5Qq+mfeZau/JifFlQijQUl/4hre7Qoz0BN+MG2SxH2zjLfI8A7Aie4rdMbVa4rqIGy7fh2p5+ldgjy7LzZKaxddn/VthES1XFzX70FZYHIfZqYLNAmDJzM6sv0ZZ2JnlwMtz1j8I5yW+n/8n3QvqaprfXxPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwsGQfkdUtoOX0IPMFnRurJJ/V4acOSDMyN0k1a5/TY=;
 b=xHuQGf1c9Opq5aIgxR/OWy0jnEjUk/dswkg7OUqFeRdfDwFPzlfJqELlAFIOa+USLHAxw2rNpW3v5nZhw0Usqg4eiFSWLkcRugbBUyRSoP6/yBZ2i9Sxfg/59EyoQOsCpSQxuMSJYx6bnQfmSOhYa9bxDDdQDGqen9Yp4GQU8M8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7261.namprd04.prod.outlook.com (2603:10b6:a03:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 19:32:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:32:30 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Lauri Kasanen <cand@gmx.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH -next] n64: fix return value check in n64cart_probe()
Thread-Topic: [PATCH -next] n64: fix return value check in n64cart_probe()
Thread-Index: AQHXCeuADYOy19AFxEqmygLJRShSWQ==
Date:   Tue, 23 Feb 2021 19:32:30 +0000
Message-ID: <BYAPR04MB49653378C3288544F3B4B72686809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210223140104.1743541-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5802fbb-8ebf-47ad-cdac-08d8d831c2fb
x-ms-traffictypediagnostic: SJ0PR04MB7261:
x-microsoft-antispam-prvs: <SJ0PR04MB7261E722CFEF85731C1C2DDA86809@SJ0PR04MB7261.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oik0bdwBYpYpEW9TRC9BbSsVXl7//Dxe1WexjvGWqNBFkLjIgYE3zqjhUly/i6a8AXUbUs/8qJ5hM+hZCHC8BU+CJRbQg5yC2lORMck8rQOglqhFjYk9oZ/1WGDnIIJBUy+Im/E4YN17HrkfmAvKOvzn2NBs320lQTqFR6NcxVc7ywO0jbQ1NbE7u1oEYYSF0xaAbA3mUiSxwm41GrnscxvbpRkN+AEi3t12dWcYvWQhfQ5EOowHkr4WI2gd5T1BW+QPf3jezCqFakR/ggvJcR6swM9y3iCYpjqh1uEm30PpSP4JX2Em2GDELLKcX557O2L20mliL32pjAweWSpHv4I/ITRYg0NhjRpA+O6FVeymi6j30O/iipvpFVe7mYHG7Wi91FHA1a516kSnr70BS+zROLCFCQagREbKi8d+9llXDaZTshwAFJ/mo1Ush/FVOmSbPVdOs18QI4jS2v1i5Mx3YKPpplFGd3vVBCafDDG21+mtkuZRrWRV0AXGvVFks63nJigHrWcnvc9HBpxlXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(33656002)(86362001)(64756008)(8936002)(6506007)(7696005)(110136005)(83380400001)(316002)(4744005)(186003)(66476007)(76116006)(66556008)(5660300002)(52536014)(55016002)(53546011)(9686003)(2906002)(26005)(71200400001)(66446008)(478600001)(8676002)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mxnFhRMidYR+1YqqgWbL4zfAn+lz46z/o68q1D3SNE8Krn5gPTwmDf/5+DxK?=
 =?us-ascii?Q?XVjWNo4RolNiKIpQNXsAW+3q7Ci3iOJtpxi6XMB7BFZw0ejFyRzIsdscD8QC?=
 =?us-ascii?Q?JVnHdVZhYDQTMHDrRcnhdVD1jbF9Gw2VipgFj9BuPmmIV3PHL3AIpkxSqTM+?=
 =?us-ascii?Q?jLNmXQmiWuI6VS1WffYsSII2cYFQuHNY7ywAYGRLUIqzNMcrP16KJNJStVFB?=
 =?us-ascii?Q?5KEjnIhJhZcn6mjN9pJcVISw6mT1UqvQe3QMTmxW4TNtowC4S4UmMtCiakWe?=
 =?us-ascii?Q?hCWuRkpiLymkiA8I1JvTWJbjOOzejQxsvuw+6bAbcM9tfZcnfvMs8iCkEwY+?=
 =?us-ascii?Q?d87/JJuVeVarDatyDEhaZEEvSjMUoyHO8Is/31E9D/ySy1ymCSfOWhuVm3HO?=
 =?us-ascii?Q?PSRVaIBi+beKOC6rTm9bxBFDXJNZCwfEOWl75M9vv52ARzZLvb9VQZprRh/g?=
 =?us-ascii?Q?aW6wjab3NVvlRrLX2cGTq6AQnOy7uM4wKSErULF6UVyyCqfjq8xsS5+QgzUz?=
 =?us-ascii?Q?svOp9/cxj+OgMhIRj599w6cZ0jExLAKJyG5480YBhTJT+c1VUq+gyJp8iIRV?=
 =?us-ascii?Q?Z+Yy9chjorZp29Fjjh05z6/RuPYb1V4itxWmPjYSlytlG25W+G2Qnx4IGcqm?=
 =?us-ascii?Q?CYB9vrKL3/cGqZA2sehTGJuKAx2VBxC95ilmakrsjcLYk7q4pFHaHF9F4t7Q?=
 =?us-ascii?Q?ptOJrNO8Bs+ZsGS8KqxxRdrP/BKWSackF5lCPup+BtFrYbsjPJ9eoBzFDtF4?=
 =?us-ascii?Q?/QpEq95HhoWTB9yZ+Es+7n/jGC2ca80irsj+GoW7FaeIK2WoI1Xz//FlCAmU?=
 =?us-ascii?Q?y/Sg+mtT5SUC2mAQocxPm59EO1P1bmMIoTUmTwMBnA6tvQWhPv/zconvMwmU?=
 =?us-ascii?Q?xrlIywsStNr47xuwzUKhNuE1Z/dAHVAF+s0Pgil3nKmgDMp2DJWugzVBuhQ+?=
 =?us-ascii?Q?7ts6BsnNOtfGt97vl8s8Yov+GUKJi5gVzCMOtGFdZJJkGaYJ7UatAMXjMYmr?=
 =?us-ascii?Q?8nbmqfwRAvznflPRzvI0S9dR4CaVyQcrGPjsPiibroLoqzQwldd7c+hJ55Bu?=
 =?us-ascii?Q?9+j+chfkUfuIurXquHkz15N6F8MYlJJUVMm9ixL3uHWIfu/ZdYGY4qbpu+z2?=
 =?us-ascii?Q?B+YZPYAP6/MoU7JK5b6lgAs35cQKdRpY+Aq4OXv1SgU38JHWS5Zu3TYRiyXB?=
 =?us-ascii?Q?2vReJ6peklbPH0ZlAlL8H/y2iPXy3n7lPO4uCWd4BBDAtCTO9UVKMwibSwyG?=
 =?us-ascii?Q?L4I/pk6ZPUL3U/aFCKRPB5FSaMTdLNSqHcaxFcNdlQMhs2G+wevb0rM5uSdE?=
 =?us-ascii?Q?sbJ5IovuYGDbTUHn31255Rm2YDam6VjDSt2ZtDQup7kXzQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5802fbb-8ebf-47ad-cdac-08d8d831c2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 19:32:30.7775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZ/L1wDDPkz/Q93wwo1+43PSIMs1tdCk+fxRsdUTNtg+SiTjbAO1AZCLNfGr4VGwDMVWAm86vw9VkShr8xrJtMIvvPxCn4VXENC4P99tFrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7261
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 05:55, Wei Yongjun wrote:=0A=
> In case of error, the function devm_platform_ioremap_resource()=0A=
> returns ERR_PTR() and never returns NULL. The NULL test in the=0A=
> return value check should be replaced with IS_ERR().=0A=
>=0A=
> Fixes: d9b2a2bbbb4d ("block: Add n64 cart driver")=0A=
> Reported-by: Hulk Robot <hulkci@huawei.com>=0A=
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
