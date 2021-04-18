Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967ECC433B4
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B21610EA
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhDREsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 00:48:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28828 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDREsy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 00:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618721307; x=1650257307;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9DMa5VHSrZLUj40l9cdjrsdckZiBUFasdz2tvSZnaeg=;
  b=SMcfa+C1yX7uAKSwudalmR/iLJ0GPbW4Mgg2vOEU7Z7WZ3db0uTrTIQN
   ShTJgBaPasXRgp59W5+8IFnMhnld1vxhfPdHMF8tI8uWKtAmGn/0J8ga7
   mLWK4Ks6MpY+ZcPYDLgWq5GjcEIktrLO1XYShhezN3HoMYuEcDdvNOibu
   slo/FjlmPE0O7VCAcnnpfZvAp57dAkJGU5eR07pd3xW1pqBy3gIorlrfi
   8roHnsJqzCuZ38lkY4sX4PTw0+a4w3k/bK1PMIzx9FgDzbabY3Zo5GOO+
   zipaHrqBUb3RN01PGgr27so52Mf8j8yR3C81YY7SKJiIHt7kL9DjfL/zj
   A==;
IronPort-SDR: ONGg7H6zMtgxrzAL5eEFoVzNLmpGib03XWt/rVLXjyN5w969wOkgGRp4HVeVbHREnHRGA4fHJy
 emR4abuuZGOA7BpgWNruqf+5zg/WhEIBEtfa1s1LYNRH7GdBhMHrrdMvcxretaWvWae2g9gLhJ
 MPmSGHKXqYlns7f+Vw/4cckmKoow28q/t/bmjYAQIBiGMsrSF13MAluVJfyF/+YbyjVawH+WS9
 tjx23B7KGo0w13R0BOB2yLHDdvYOMjxSOrbvu9VuEHzGONEmRo6h0h41AsZRIEAsBfpQfRf8Rc
 GDs=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="169856810"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 12:48:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHMkwZflF2VIQ7n7rgUb3QnMl2OJS71Awp2ckiJ2vozOdzprkHgKhzJQB8x+vLbag3Z6z9vsinkA+p5kc1ye65d/mgwazdm8WVr2pi2/jQWGRb9g2Aocctc4FYkMrs56dBroiYV+JpNr7G+VZ3LrIZ5oKm/h3UjXr2/COwsG9rwJCgM+CqCYnoWG8BmM3BeKvQTMG/H9C5d+6P53+oiCufd6ZcVsDndDVSwLmZfcVJCpJRJSmCYTe/lI/i6pTQcxL4H+a/dvmNMRZsLw3ZsY+drpFcXatHNUcb31K/3KpR43NwDBk64V9xetjHdqWvFzsGpzIBn1yXwpPVRre/bt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DMa5VHSrZLUj40l9cdjrsdckZiBUFasdz2tvSZnaeg=;
 b=YStt4XjVsAYHccI+YZrwkgHGlrHABHDKb4FpJvO8aPjQiz+GvhoEZuiOMBrh8mKSs1+3GoJteSMpOjZhLxHYQtOZc0uqgZaK7Y1w4lIblPTMymfnGlMabMD24T1LmFwXL1HZ3+o4+1z0wqKbfXMVmhFOOpt5BJfpeg6JVJ/xOa1k434305EMMfbjsoueg0PpteJjETsRn5b6odKyIR9efXxfHysf59YsymcX85bUhvSnSMmPonN31rMz0Bk6GW1hec3LxooB0vDeAH8Llik1zjmpx3YLnIxF3hCTM9doUGM6W4ArhZq3TPAobjsBpqNauyNJ/YhYMraEvLggf4Titw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DMa5VHSrZLUj40l9cdjrsdckZiBUFasdz2tvSZnaeg=;
 b=ZAZq1RdRSNG4x3dnBhOq3X5v+Z3muAeIBXIZwp17SH5Z8VYXICnote7o/18Oq8tV01B2jYYG2nKlpiq8y5rnwoXIHZ/Wx73zc6SodgIHCQWYooK8gzvwvlQBFsIkZeYRBPhceGeyn02XBrtCkNytH2HHLtX7CyAXAH7aCtIILOw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Sun, 18 Apr
 2021 04:48:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.019; Sun, 18 Apr 2021
 04:48:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: poll queue support
Thread-Topic: [PATCH] null_blk: poll queue support
Thread-Index: AQHXM56KmL6kCanFwEqXUyQ/m0BBrQ==
Date:   Sun, 18 Apr 2021 04:48:23 +0000
Message-ID: <BYAPR04MB4965477AF2D08FD873F0EC3F864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f220ea1-25a5-4bbc-8b32-08d9022532be
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB43257C5C1FC8416C56CE5B07864A9@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAE/W5pvghH5/X66PbZpVqK00LyJjt6NYfdI+uAPtM6bXQFm7zQ+Fi9NA+yYPJ1TQvzZ/2It3p8M17UlLPno8uD9eQsJfGGRaO7n2Hjr1irQVhFKT4BYS49qa/d3SQLiyHXKfsYpRT79aHhm3XhLuHdrgoq1L0ZY4xlLYcc6D7IRdPNsZ/NNA9YkgiQCp6VYxrNPMtPcH6Obcgh0atCaq0xLWI+qFWY0JSZAVXfAOnpzs+fm+GS6vEihdTZ+qRQhd9ih/HL8wSZihVX6uuaoIHxZC5+tMkAWp6YjK/XU2GlAG+kADutgYbmHbFyk6DbkqJlGXaBgv0FKtmUlnqXkvQarOqEGmZFSaxlJIlY74lghdKlz1ZlCaz9/1Zo9u/5JYFoLeEGQ8Y7xWYdBxLHnhzej4f/7rLinfgsKeqf5e5bN54HC36yJp+WZ9y0kg1iakSHDbrzo7pfzzCkYG45bmpbYbif58yNxrINASl8I2sg700KDLB8x7SUHG16++VyfgZ0fg8bRCIuOkxl4L7ePJ3VUhB5BHVOVp/9fFifZB/ce8f7pvmO8gSNs1da88+6hME8opFhpdBL8fj2NdZsWywKbhu2yVbqHQIB13oQaWak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(26005)(186003)(38100700002)(122000001)(6916009)(86362001)(66946007)(7696005)(66556008)(66476007)(33656002)(76116006)(2906002)(6506007)(53546011)(66446008)(316002)(64756008)(478600001)(4744005)(71200400001)(55016002)(8936002)(4326008)(9686003)(8676002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L8VvT5mSHH6jsxXaVM6+dTq0r3EhT9WLf/r1WAlc8NutQn+GHSmaAJMWEDwy?=
 =?us-ascii?Q?GOxaNkj40pV9iFsYkySuuBO1lG8dK99/kPZTTywZwxu0RKA+DVC9BzvcfBC8?=
 =?us-ascii?Q?IvUe4/rtcDV4xmNF+2P/VPrCZwFinzYGXEUJVDppgjou33IVsbxUCoPtNY62?=
 =?us-ascii?Q?Wp1VCycSTYVUFGPj7RQPuGDINka29gCSmAh5wdoluYCXqQ3XTY9mRhSvTCjp?=
 =?us-ascii?Q?/sAAE1J9FRVwGrCMIvXQcc/Dl7oUieirHlZoG/CvuAyTQKvvSTmw1yhmdYi3?=
 =?us-ascii?Q?kYpqFZ//F7gaeyzfVisfTQjTblMjghL9zfFaeWYiWiOI5qd7djNZXf1LDjda?=
 =?us-ascii?Q?zX85FWVtRYhGFsfSc5/JJSWiOYlqJb+22kCSz3Mzv/hyknSQxaVpVyoa7n2U?=
 =?us-ascii?Q?iXGJNDACsvqjWtJf/F9CPlPU7G1YQ7yyKrZ9Vn2CbPfxsQ5GqJ78ygt1DEIU?=
 =?us-ascii?Q?mlU+77BEPt1BIGsCgX4SPfrkEJvxvZQa2neno8RiErspcE8xMEUcTRkPpTu9?=
 =?us-ascii?Q?hGnmGFn5JHBEr/GJ+r1CvBVXbH1UZwwC8VHHNAP36DOioKXRXrFoMRXcqKh+?=
 =?us-ascii?Q?oWyVi/j8JmFuhZHqAyAQFHhzaLVkxaGVYHYFkpiLV6Ceb9dbpk0s5Tqq5isl?=
 =?us-ascii?Q?aQ8FZNAidqWgjpwB22yV7EUVwsKUb4pbJlAm/OUd7AOoRtX7XnBrWwDg/a/T?=
 =?us-ascii?Q?QY33dNRtYqbX36HjNGx/8A2UCAu7Xw05xPYldOMfC6kbSpYwgMicKnI7a9GV?=
 =?us-ascii?Q?cD0ofQ1x1LcSwc+HHfdI0csmIkG9ELBcQ8vgXhoewfWGTNs3/riJnU6Tk06R?=
 =?us-ascii?Q?HOYLnK+MUJEu+VFYLyKWqdxggTW/vdXDju9iT7D512OuccB9Bu/kBx8Gei6S?=
 =?us-ascii?Q?EokWPoNKx+YhZLicq6Kurml9FCISw16LLwnv1iU6V+FBC4S75dk8X4PF+Fzb?=
 =?us-ascii?Q?mVlJ4OVRrJ6B7CgqrhPj8eu1ipvEXhFjhfQwz0R5V1daHgp7LR2A4gIvzgdb?=
 =?us-ascii?Q?uKQydgVbvqw2TblIpB5+SNm0ZphlPviN7VnBuRi67xKxD2LyTeo8upuczeQt?=
 =?us-ascii?Q?6l9R0b6Z90jH5PR3lj0HKWtli4j/N7JVvu7mEzvYlkYI9PxIFxM7ZMjaCmpu?=
 =?us-ascii?Q?EVVyWKQ2doInE7pKGP4V4rqddyptAY7pEl3t3MndOXWwtGmRPXVU8LTt2Q5R?=
 =?us-ascii?Q?TGqm8dVsbdFMSNersNGtJYEtDRqyW6Y1roAtXr4WYiTElEi8PRBnsFJUacak?=
 =?us-ascii?Q?OpC3ag+XTY8Baqxh5y1bHsDPQf9SS27P4SvB5UifjzL/jdXFtNuFO2u+LKUA?=
 =?us-ascii?Q?GtiCetem8Ao37SXwPRvvbdMU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f220ea1-25a5-4bbc-8b32-08d9022532be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 04:48:23.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsrR0eBwAw43WXrn5CZZRxSskaU1BR7OGuMefiCWfIw0IMSMlu0nbAWzFdNhB8GZeGHC75Z1j2tNpG9zx7qpx34C+gcI+r6wTzmcslmPWHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 08:30, Jens Axboe wrote:=0A=
> There's currently no way to experiment with polled IO with null_blk,=0A=
> which seems like an oversight. This patch adds support for polled IO.=0A=
> We keep a list of issued IOs on submit, and then process that list=0A=
> when mq_ops->poll() is invoked.=0A=
>=0A=
> A new parameter is added, poll_queues. It defaults to 1 like the=0A=
> submit queues, meaning we'll have 1 poll queue available.=0A=
>=0A=
> Signed-off-by: Jens Axboe <axboe@kernel.dk>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
