Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E74AE92FC5
	for <linux-block@archiver.kernel.org>; Fri,  6 Oct 2023 02:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjJFCEe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Oct 2023 22:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Oct 2023 22:04:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746DDE
        for <linux-block@vger.kernel.org>; Thu,  5 Oct 2023 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696557873; x=1728093873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2IE8tN2G/Zuzce17Z30C/l35+jftJ7GcYWnfYPSrPkk=;
  b=MCMP0sAvpIbn6JruNLMo7tcpimNUdTOfvDe2dThiwLHHk+Of60ksKNZy
   Uncn2PQ0kmUK9e+SttIb6I8ot5vGsb/XnQKs0FzVxp2yodPOOzNnZhdsh
   19rFR1Qm6vsuHZHdH74B0L/8GAfbf7Pszec6DgNPi4/JYENwMY+DWz41/
   9TF4gNMlJJoVwtQLOvdiL34pzycyg8h/nJiPh2itB1rXlOwaOlk1p0tE1
   1hShvwDPtce1JySK1CEc7vBXTJnlfZBe7XPEubZiad0KE431eBCsv6bPg
   9YDhgS+ArIskQk+8O5HCz/C7lW7gUpQ+7PB4fn91DTN9vqIMXGoyt4+r+
   w==;
X-CSE-ConnectionGUID: XEyuTy0NRrmx0yiuQrRjdQ==
X-CSE-MsgGUID: MbJ1uauXRVy74cszchgsWw==
X-IronPort-AV: E=Sophos;i="6.03,203,1694707200"; 
   d="scan'208";a="245804375"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2023 10:04:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6aqg/RKHyL+FHgj14HrA9lQ+g24DoBlpO2CkNEhJl7i5ifA2TMhnCgxDpeo+ape1e8cjhA4+sB0xMuOwGkktKDfREmcfBp1iG8y48dumjwgoyqqYX6ET6OAAaVCqet73kgv7Kg4UPAKxQeWdh1sMkClCmJiIcDqYrb3vXuYK27xNWYh185ZW24UBo4OeTnFKzPl5Lf9uAZfJfHJqqSvlH4YSDelPfnnt86L1Ml0Dg8yockAg6/am0OYe6ZpMIqKx56knTxELvz1J1ouXNrSSArd4t+qi3tYlfJqhtwiaHJs3OIH0+CdqjDLq/UwPRaJm1bw/Kb57XV7N2toc46bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IE8tN2G/Zuzce17Z30C/l35+jftJ7GcYWnfYPSrPkk=;
 b=D5js7oWyxQpKv97n33CqDR2Khrei66nP4uTTEngkisHt0nMFdEW8rPAHwHMV19NlifEKVbHuaAgSVEWZj4K1Js+gGDbuO1Tuv4OGRmwpwyC6/RnY3ts1LEcZv9rTdMO7qRDaqqEkd6r8sCpnsMbWkeRbyTKUmutbWVD8HRRfVY8fZ8Pa5vPZKDFFxk4r426zxgOgmEhwyBweYbxYNXuvldIrj8NMHjmceUFvO2hhjuu/s1bp8uuPnOouentMjc30ZRTBA0UKyquhRLZQPZxSpkXWPQ9adlqf1TdG415fFY/lECOzfTthkoCqIWFcmfhKgC0n1n8RqdrSUcbj46tE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IE8tN2G/Zuzce17Z30C/l35+jftJ7GcYWnfYPSrPkk=;
 b=sOm8OyTQej5LxNMzJoHU88LxrfoZanDbXP4+y8mEb23VycWoXmYL6IKC0BoucQIjN7/VBeq3ekkyAkSH1jvNVUL1OHMzi32NDUjsUNYCHJZtkAE85FYbozrDLlSBu1ytUXfaDk3FShNQWcUgI2rUQDUmQft9qxMEw2nayuWll7g=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6318.namprd04.prod.outlook.com (2603:10b6:208:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29; Fri, 6 Oct
 2023 02:04:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6838.016; Fri, 6 Oct 2023
 02:04:27 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Sun Ke <sunke32@huawei.com>
Subject: Re: [PATCH blktests] nbd/004: avoid left connection
Thread-Topic: [PATCH blktests] nbd/004: avoid left connection
Thread-Index: AQHZ8nKcddj4j/AxG0WcycAeMTA9IrA8DeaA
Date:   Fri, 6 Oct 2023 02:04:27 +0000
Message-ID: <6xfnuc22fqx3lhxvo7s42fsqqg42fqiecscljkupsn2vtjdmu7@4zu4wy6o333v>
References: <20230929011640.3847109-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230929011640.3847109-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6318:EE_
x-ms-office365-filtering-correlation-id: abecab72-8118-468b-b762-08dbc61091c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZNmENtA9zBNW7tTlaypFuJ0mqOuV9tGKyW3ZHnNAhd7OwF2kghcfC2Dx7rIzEdkPZhTfvXsjsqcC9iw+Np4FwHYtrdmbmZ2LlDYJTHyPJ7801nmkJheZH0jOIM9dZvGgjod6jRE0oPaN7TJSFxNVCZoFfCvC7Pb0xhQXiEtd8HtWQzwraDbP8U1+MVPRSIpVJLLnXNauaVykRQ3ayOfwiRhGLB9V9rqv+tJeV6dvweerYkd+GYpDFrLMkfmXTedUcLb4WlcN89SPlsdgs1CN9gmL1u2y5EpuzxsMC8qiLhWw4fb/JIDJ+zqmM+cm5+ZpzvUm4qP1vNdnm0k36t1jxzNrXWl33HM6VNODj9bnUulbb4Mt0nyBGt5l7NxNutnC5l+fVrjhouqPL8zjakdWN6jl0oFcz9gdCOukVefM6T+VqiTc0L3SvAd0VvRGM8SChRwLiwt9o5Nt+iWhzcop2USK7Iy6bJitdDhTQTP2aKEUMm0X3Z/f6aMr1QIWBGjmN2pKiSWPASMCDoEUT2LHZ8Onu+cMkpUs0N64NWv79gegfHhMrv2N/tDtGdPIm//01r3NoBPnfzD3+8ewe2VMZhyE9V0bbpFqWNL8HvulTCdcHqAF+FMe+QKww80xZa6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(33716001)(4744005)(83380400001)(44832011)(8676002)(4326008)(26005)(8936002)(122000001)(6512007)(82960400001)(9686003)(71200400001)(6506007)(38100700002)(5660300002)(64756008)(86362001)(2906002)(478600001)(91956017)(6486002)(66476007)(76116006)(66556008)(66446008)(38070700005)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3XTRtRvSw+5WWOVro5e1R4Cy5PyESD/5M5I3uU9eq/hsy+yETx/flf+aNR3y?=
 =?us-ascii?Q?pE73aPsSY1xVCHNAm/Ayv2utIqomp6nVIJh9LWAtVvLCWx8fhNUY89Xdfl16?=
 =?us-ascii?Q?IL2lRewUx6XXPcwg/QMXJuQbaCLp6ISHIxRwSB9lxymO44OCXTgHuAUdVzCj?=
 =?us-ascii?Q?EmsWiJIVYM0OOqZAOYSTJ+B8YGhjlrqVq1HCpGW+JxDPgUyPka0xGDKSriEk?=
 =?us-ascii?Q?q/GCZUgffiOPy0VIrGXdrkMU1dzuOMw5X5LDwBNWujtDEJSBomrXSl53vlbS?=
 =?us-ascii?Q?dIAXDviHsn3vJu8oi4G/WjaelGXi/pEMmhm9FH8BqUAl8aCKF07WCZbcH0Hi?=
 =?us-ascii?Q?fJvBBpJSWC/R+a20JfmjvXkTwHVv6uf1YiYkOTx7A9vtx2ULMVhGi0/YtG//?=
 =?us-ascii?Q?7uFVStl2+ouuO5vgrpgnGqJLTFJJ4HU/OWXu1uhyqgl9ooG4QQwX5h1B8cz7?=
 =?us-ascii?Q?XPOFDXL2asqq3lz87JuOlCaoGh3ls4xhsZ5IT3ToV7Pa/kiY1t+uJiTOOJ5F?=
 =?us-ascii?Q?6/VN4OxjUIYuKGDywbhTehalooGbYvMnaVcwBkko5gWdXbMzo5PiRaCEVOck?=
 =?us-ascii?Q?7uv/570ZpUmUA6r4XkTMdYupWrTV4jhPfbmCUc5Nqpoz7HUfICq+/HArYzJ0?=
 =?us-ascii?Q?QML/TTNNQrSlZ+2Qt0vhXJnOsHEWRsz6A1jzU5UTB4Rnm/ZVUTgz0JDg/8Qw?=
 =?us-ascii?Q?I0cXgb+GPDjVBGAVjd30ABJ0cR/ovBXgerNfFTt0KlWULStLpkCvMs796iYW?=
 =?us-ascii?Q?naboYtn+7jHnzKGx+1CWuQ+EYcBOny9pLHluL8oOzJdzPVvNkG7iMDkof1Xm?=
 =?us-ascii?Q?p51IRMWerAeLEOOOKRy+9V43zMShZCUMFGlOsPfEw5yrxmjR9ApqCEQ/vlg+?=
 =?us-ascii?Q?xu4BFH+bpmMpZ0lD8ipaAbvLg6jVHmeIGaZ/TSpxtpFUcWXKYwA8QwgTr5mj?=
 =?us-ascii?Q?7FEJuTVHkOm5zZRMX5EHy9owg66MuESVAQiVb6UgEsQEscBSmlNcO/Bsk90T?=
 =?us-ascii?Q?UznvB5CTPGqcu16PGMJvgY2s1G60CMPHT9EyXU1DXcxD3t5QwITXv4iJAUlm?=
 =?us-ascii?Q?QVAV3KyrSPLYMBunBGlwFsBEV7Nm8f3FL65rr1/vqyWcsp0ZzM6gLcq2VJzN?=
 =?us-ascii?Q?4JhP25pkH7UpSNzoGfEwD6A+CaM5bxuyy8r6/jCgXc8McfkOL8Qe/om/BtZc?=
 =?us-ascii?Q?GdEDDVaN/Z2T6JzMdIMomvpFINgjhzIUaXRkczxsPe88iNaPRD6buv+QS9qy?=
 =?us-ascii?Q?D2aAJBQi5jx9g/oA67j18+SAWSwCjxoNbVtW1NdZukZ4UinJqup4WpS5bxPm?=
 =?us-ascii?Q?9GTnOHPra7BRXW/RxBk8UWa3TC79GcNeyXeHGky5z4GLr6BQSvIxJfl2dHCg?=
 =?us-ascii?Q?8BM1OMwP6mSAE/g9i8G6ROkmWBrp/P4VkwelEB3d+044QwyO0zo8NE1kITAR?=
 =?us-ascii?Q?ANb445NEMlKmf1fGo9SFexH+vWc5lfCi1sQesNDb+NvvXikAov3CifSikIEW?=
 =?us-ascii?Q?Fmuvsz0PYPhS1DVquAzAgpd1Z2o3NMnAngIghF+pBrWVvBloTsusJwUCB91o?=
 =?us-ascii?Q?atSg5VJwHqRsa2dmvwsAUCoNJUtjzqJt0wPRLAhfO0wlkSBgHbNgyxLJnRdu?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <433518CB4D240A4BACD972B648B828D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CzKCHycmj1nidRHvnthJfFkuyRZcJqGB5wdG1OnG+em3eVGAQjh4w/H+4ZTaVdhg1KgdxqoSX+9mQu0ymeobDnSlx7VLRypB8ZbUeSsNuLQNKYpeDwwfOR4ZPuoGqXLK/+TiHNWzLtB44ecakmf4oB3rcW5nuc5Cc71rbUXanm6S3qQcvd89n4aKzjqwDJ0QgogC9RYKuPmbinpW933yRkYUD+yMOfKLSJ8SVrgLc7VJNh66K8ztCppUmSCCtrcJD05SXyWvsAx12WcDBbtPvkJwjmUoQvBH6ePKUH1on8K10t5NlxtniAPoF/konUoGoRM2k/9DhN2hDTUNv4+D8DXdxvUNn9fmcot9HdRHcsS77Eznnv9oIz1b8PtD/fH8UE/+j6q+lKEt+FbSa2HdSveyprG+L/40OoOsyxzk3r7J8+A63pGbUcYXI6PmXQVd74YvcR+QeIVSzgyD70/6LWFjTni5acZUgdDmDFyAU5L925gSYDCBKMyo/mV122ReN/5EgQoF1Oaz3Wv2cQ1HSnVhh5V0nn4Nul03M+Xtft+hyQlia2zrCZbh3yKbCfYcT6T0obKnVWm+TLe5t3Yx00mMwYlHhNIdjKQEBrwtdLQ6ySZ/Zhg7vA4aT4HVJQOtKyUd3lSY3hjhyJXCkyjxmAUlMAfMiTAY7nd+Zmeacm/0qq9kaSkzKquVqMHhFFxwgGYO/wPlV2FbwZ2rcgSyc3TLplAbqv0Tz8XzFvcgbwsVk1mTZ6wCRiRsjNnq/tNG8vxe3HAbYWyqPhWVTlXMVibQAMoliTsxEwtU8bN81tWAdtt6gR9AzquAr24O3X8E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abecab72-8118-468b-b762-08dbc61091c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 02:04:27.0374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bltkfVDY+F+nGY7t8IXcuFfTtnue2DLMgUsPT0LYSU5sxB6Rcz1z7VuttXkSF4LJuCKZ6dEXgpvr14FR3lvRXllyax3TqhIKrBawbw8Lqwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6318
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 29, 2023 / 10:16, Shin'ichiro Kawasaki wrote:
> The test case nbd/004 disconnects /dev/nbd0 in most cases, but sometimes
> leaves it in connected status. The test case stops the nbd server then
> /dev/nbd0 does not work even when it is in connected status. This makes
> "udevadm settle" command to wait for nbd udev events infinitely and
> causes failures of following test cases.
>
[...]
>=20
> To avoid the left connection, wait for nbd-client process completion
> and call _netlink_disconnect at the test case end.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, the patch has got applied.=
