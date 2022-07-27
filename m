Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB93C19F21
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 04:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiG0EPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiG0EPC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 00:15:02 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240802CDF8
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658895301; x=1690431301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WJs3GMHG3tB+DwXiu360Vh8IBy2eFQRtzQWq16BVLIM=;
  b=jt89jMTm9czQVLawCRbdXcE6OdfqyjetXQqw2DRhYcAYZQi5nKYFwLO/
   qbVBMVZ6YpskBD11lv/DRi22W4/koN0TqCNN3ZR9Bbog2GbZfYt3yZlpe
   aykf2GOkSaLaUQs2vN8cloTsK3qYTRoLMgVsb+6Gemoj1XQzEcmsMCyO3
   hJjiFM+U8BaG8/00aFsKCBbBPXUOnzhXEPRsA6aaFhfATDDpCElJuwtpS
   bgq5y6oCGLjQDOiGbClx11iaI+jgSvCGkB7JpKx4tUQZJhUbsDsfJTSAu
   zQ+OiuexxwUPmvMlhEEl/KjAAvi0wytXsZ/AyIcOmQ8oa2cBN+SPpzceM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,194,1654531200"; 
   d="scan'208";a="205553128"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 12:14:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQMAX1Spe4ZJfBviaMMfJpaypF0Z1jDGCZGDsOcHESp4m4Wns1dnNc9eyR8IOor7G2QJADpFrULakFj0vh/lfBu968DIc+lWWjWjGYcWznh1kdbZ5lqp/yfJywGnBZwMWElSWKc54f/siLai4TTx/jftBDz3n1E1SQUGsvEqxwp1jC2TYGLRXqiOzWhb+48KaSXz3TIaNyzifsixwW+b6bDn85KjL4kadtZt4YvXgH5kr4+lNYLlf2D979GV/xoe6EFznq4Vwwv1kuRkH/SEm9r5xIAMRXoUyGdgIasdlyWoAbdCOqzBhohfXrsoOX19DZ3REVeP0ErGs+GB+2/HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJs3GMHG3tB+DwXiu360Vh8IBy2eFQRtzQWq16BVLIM=;
 b=bPLVK7mh+oDOJgQHjj6f9nJAuGYG/tBPswssrVvBsrF++QbB2K+ZXAqizfuvxBjheVAXJ0GR2GrqJ1YqdVG3X3plI+VKiNxTr+xkgbqpMhjhCc8EKeuOwqIUysArPB58M6YMleswEqbfIh7ILscaumjAur01U+VYhlNGfOYhF+hJmNeyy3mo9UwH1rsfOypmdpkUXgjSDVUE13UfFOJGwUz1oI1dPsLOlAhqCVDkfVJeDQOLe7EoLgMBz97f/+OGglQIrl1P8mEKgE4zxpYEV5xCXHvztvF0TQDHjZGn/NzG0MTbQrtN+i3gNrx9ZRxqG5lvn0K5bOzm41aKhweHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJs3GMHG3tB+DwXiu360Vh8IBy2eFQRtzQWq16BVLIM=;
 b=fxhWukbNCqb6x5FGQ8aZWORfeip+v4ahaDgxwu5TVkYkJSxcIC6APGk9Qiq2Xu3bixdUvsldSpyHNFHIIY0ybPNtKjyKin41NVtIdo/xLlA5K8FCGlkUbxycILkilWGKsly+/cVEGg596eMJv+S0eaJYLNmjVX2lCNJmhLAcf/M=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4957.namprd04.prod.outlook.com (2603:10b6:805:91::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Wed, 27 Jul 2022 04:14:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 04:14:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call
 in sub-shell
Thread-Topic: [PATCH blktests v2] common/cpuhotplug: allow _offline_cpu() call
 in sub-shell
Thread-Index: AQHYmxqR5/Sw+IEJgkKHkg74AO4wLq2QXpQAgAAkxwCAASVMgA==
Date:   Wed, 27 Jul 2022 04:14:57 +0000
Message-ID: <20220727041457.gkfv2akbygqdxrow@shindev>
References: <20220719025216.1395353-1-shinichiro.kawasaki@wdc.com>
 <CAHj4cs_XGXhHZsipb-BA2O_acaeBjDXa-CDfY771=a_GfEaU6w@mail.gmail.com>
 <20220726104512.ciqjtkc3lfaqdvxf@shindev>
In-Reply-To: <20220726104512.ciqjtkc3lfaqdvxf@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6fbe6b-08ee-4fdb-219e-08da6f86914d
x-ms-traffictypediagnostic: SN6PR04MB4957:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlaXH1m668NvDdJN6hnH1Va6nbtmSpJ9+boCFTrx3m+6vbz74H3RzgXMjDZmZhtaQom8VUaMKcpDSAiCSb0e524DoLIWTT58zRNRiHDD32Rp6FJZzghWP0xktBEpXrACTnDE4+v9alI0GooMWoiM8NRyexUd9eHnuWJFLpQKMS/7jgV6OzfQ/pqe93+kh0rnLMae4TPf3DcIhp426EBiQdl8j6T1e067N+xoy9AAu31/dKM+0Z2CJX9Gx3aDzuKKjeUZnPkbPc6NgEA2kV510lOIfhG/m7NHl+MCFG3uZ/UGsfkxnyo0JNKQulVwtRcqWJpNAb4Dbk6RdYS80l56LMjBYWb1f5l8ePDj3iTUAKFXch1mdzHWkP4iIc4q5Sce015ECkaRmKREETaUVWOty/xRS7ZJzXEPXboiFsPNddVty8j1NafOJe5kBoHnpAtKgf4126AmW763FZaWJF6AyasI0n/UJSN8AO016ErMLWE4ItsGki5AQcvZeHKeYSD63TCEIIWAOn7B6I15Hk9saKe6pIdLw93MgwEIxns0j+GxmLI1Shjkji0Q5Mar2rFsTxHcnQky6hVOFFHaj8IOzWsyBeDAVu4qBttSeijuechrEgzgTY6eKj6yS2YjKGxJDMMUANbpJowkcvZjvmcRA0YDtT4zX/QRoMIyIwdXbrKGxalfPJQIlD2elqbGVD1GpaRGhXMEjot/1oLuH0tyWyVxmgP5cCc4P8gzI/6QfSu37+ZRn7W1dJD19ycHvmdEtX3aNh0Wrlt2nAhuQD1gvpE1KlILhUAGFIIRPX+uYgSGNa7dLlr+l/1Dn9JzPoDI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(76116006)(71200400001)(64756008)(122000001)(2906002)(91956017)(66446008)(66946007)(66476007)(26005)(66556008)(83380400001)(82960400001)(86362001)(33716001)(9686003)(8676002)(6512007)(4326008)(38100700002)(54906003)(6916009)(186003)(1076003)(6486002)(478600001)(8936002)(38070700005)(5660300002)(44832011)(4744005)(316002)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mc5HyxG+jHIi6kx/VjYENSdFS+SpLUCzIHHsP4K9/bIzktJTEQZ2qkLKJy28?=
 =?us-ascii?Q?mW7qyLoT7VIdpqlzr/MACdeqwQFS+0EilCzVko9DxgmqeH1z+lCfRxuMSnhw?=
 =?us-ascii?Q?dnpADqWncoOkOUkrsvNzzkAt9QlMgweLH+twFj47vq1rvrd31rJfoyECXUtq?=
 =?us-ascii?Q?Le+afgl4+xAcT5/LWPE3s7qIM8Mjz+B28ekTNvIbmshebu3g3jCeWFP+nVbr?=
 =?us-ascii?Q?/pKgdTCRJga/vn4mnNaDCacP7uwGbjSLRp4aCxKf9rauiXd01kpFgq7OERDa?=
 =?us-ascii?Q?WJIWe6kJPvaRqEiuDa6ATGcJUzR7k5uoxINIRNcpDmD6AnRlhd59pPAvwUy6?=
 =?us-ascii?Q?Y9i48Wf6YsqEeynzv01UwyM2IMDhmD5231i/P/KUnuAuVKokVvQgxFnLyGEQ?=
 =?us-ascii?Q?ti7FCjEh1b1SZQY68SLFoAErYG8u70cFAsu/0pO4sN6fWypYgLerlT5wTOR3?=
 =?us-ascii?Q?JIxH9glCQaT0+jo6FMzXl4X0gzhVMXUudJkXeRAllleF6YgTiWOh8gi++t5i?=
 =?us-ascii?Q?jXNJmm2iYBQYrQ7FQFOe7aXuamJcyOw5kjUcMFqGdLX5Ajbg8jZ5bwaEH9Vo?=
 =?us-ascii?Q?fIdW0xaz+xNja+m3gkZHmk0jPWHTJn3OTHfSLjHjHGB92hOgrRc+SSjAcra4?=
 =?us-ascii?Q?O98VPB2MirF44oNTFS7sdKdgBJTzgJEH8oN80fhmfD0iueOn+bxd6UggT0x1?=
 =?us-ascii?Q?Hx3lZecRYt0dfTuT1wQZhrYeEETOb/IhE9+LJROM2R+VmUdlDsRqKpjD9ETT?=
 =?us-ascii?Q?mJVTyL5mXj+vdtGENGFpCNBDAntsTvMxphgEXIrvfgtfOHDDOeFHz3qz5Gld?=
 =?us-ascii?Q?VTcawWvnpaxZ3k7+0Adt7xeABgJD0wu7Wcx3xFHohVFiInCJiv661XwWs55V?=
 =?us-ascii?Q?rA7nW2qtCueYnQPU2mabj0JD8Zo8cFZBhHCE1UYpZdsjFK5YMCoAGCx99P6P?=
 =?us-ascii?Q?Xxj7xzbSsVIPMlco7ekLK1jrIPsj52ax2YX/QOdjql7ZCnXNOpYAsnPcZqG1?=
 =?us-ascii?Q?Sa+xsd96KOWbd9wqN7ncpn8M4jCcXCjXCe5VPoS4LVf25cqQCr05Kvb2joD1?=
 =?us-ascii?Q?86AfxEsCfR12lDfQFxAMhumbM0MXw7dChsXNmWSlWzVUxK34dsxHrOir7xgg?=
 =?us-ascii?Q?IyUGf7lgQ8J8x5nB+YAv8TbU+/elgmtgjLS3XzNRoUa2fOGYM1vf+rdaTC5w?=
 =?us-ascii?Q?0X0v29ACknJksv3L5VnEyiwtW2xB2e9u7BoagRRHFNrj3E0Twq2POUVEmeFh?=
 =?us-ascii?Q?rqr2poNtdgZT27umWDHovpzdw/zKrpVwjs3QO3sDG7riOXcJL2i5tqd4tw9y?=
 =?us-ascii?Q?iNIKEdvUnZudHL1hwYLERqBS8rQcH1G5GlzDK3mQKsDMqLxJDvjFUol9lFZ7?=
 =?us-ascii?Q?g9HNJDPAF8K8B9IanCzjUCZWV4wMestADnMOn/DAlbcjHiRUiJlAH3u+N3AN?=
 =?us-ascii?Q?uWVrsffVyQZ642F2qQ1jnS8RZqrTPa5b1bcECnEFFM7VcBaqt/nWqYendVlS?=
 =?us-ascii?Q?JD1KcTdWVmClcKWs+lHes89142dE5dNNPUyp/6lYtZmrxBBoCiHQdr7m/s3C?=
 =?us-ascii?Q?tJ66k1a9p4+vw0BqdyUazJz5z2QdXLt/sdYXd8gKcJ1TUZ9wzQeFfMxnK7XO?=
 =?us-ascii?Q?k7I+nkZOR9WhzCv2KRjx2GQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C224BD33E1FC2468A6F32D8FAF61CB6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6fbe6b-08ee-4fdb-219e-08da6f86914d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 04:14:57.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gz4yE7t4CF5TYnE3/FSNgLtyspUb+gFKkKhgLmVuFMNPAlEZsULB+wEJBO+gCYEu4601WUxM4Oj+VNRd0HI4YJ9mKscrPkh02mYi0eFvG5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4957
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 26, 2022 / 10:45, Shinichiro Kawasaki wrote:
> On Jul 26, 2022 / 16:33, Yi Zhang wrote:
> > Hi Shin'ichiro
> >=20
> > This change introduced one new issue that the offline operation will
> > be skipped when there are more than one test devs.
>=20
> Yi, thanks for finding this. Then this v2 fix is not good. Tomorrow, I'll=
 do
> some more confirmation and will revert v2 and apply v1 instead. v1 fix is=
 a bit
> dirty, but should work well.

Yi, I have reverted v2 and merged v1 to the blktests upstream. In case you =
still
see issues, please let me know.

--=20
Shin'ichiro Kawasaki=
