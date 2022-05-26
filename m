Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D030C433EF
	for <linux-block@archiver.kernel.org>; Thu, 26 May 2022 07:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346423AbiEZHg0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 May 2022 03:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiEZHgY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 May 2022 03:36:24 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52C8994FC
        for <linux-block@vger.kernel.org>; Thu, 26 May 2022 00:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653550584; x=1685086584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qHTK2iE1QjMm/cknfYz08RFBrM0fspmizhcpAzFXLH4=;
  b=Il1Vd6+5svVBnwRvchIq/s4bUnhsmtHkxK+9+6ZVOEV/ZmpNUJ5I+JYC
   4WwbtsyjJfUPLjNiP4qhYKsxvAGfD/qOtUVs3Jw/6IwvYCqPdN9rI7488
   viD1s8KZt4mMeD9Hwrg/OvM2Wb7Mtx8VfKZZQHXVzZmGWwj9glQ8TDiGp
   giyBXJE67jCxc7OKOhwUqx0SNFiW2sEaNobEe9ObVmy/vrNDTIIVCNGQQ
   ongCOEuIOMgOMjxZxg86Av76PfvNVYZgmjVbvoppqq0rpUlrL6OCxFpUt
   TSKC3vGh+EcpE59qhToaztxKlHIR6Vvi+N1E19mXGEkCkibAUq1FRZn1T
   A==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; 
   d="scan'208";a="202318438"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 15:36:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZwL5pZUUpmTRtHeDtrsDOWkaUBR4W3Pq7sBQrfVOnWFaLLNvAcIxEO3PkGDZVN85bmk4O7sHUayMHgNJOlla4XCDV2qAPnWG9f5iu6AmQYdJIsJ/WsUu4w/MjXBR00B0PQb5ytVxz1trDQfPLb0bBvrLUDgsr/pAoU9B8xi+M0DjdCDpmA38kSgWquk/3dJHLNmNKBjEPITIR/qSu+MAvNnPV0yYvQ+LfAj4si8Lj7VcYDvAh8MFpRg+AIn8q1zt6Z0GCHx/nxF82m5Oc0qDWcmANm28sptig2tRNsqKOBRfHHmWVP+K3QegKljQXDvrkSbKKWEuVbzbelMet94oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujyXZKTxMuz6BKMQI0u+JEYz3PRSZDVV8KHWp/4DCpk=;
 b=iDn2m9lXBFVcz/EcWL7JOjkU/stpzpz9PPg3DJVxNDvoiTW/1dN13G3/jNx1k/vwOchdv6hekihWw3TH4C1nvFDEPftwLtdXpPqMBUyQqZD8pKkDXFDi/wmRomiei0uBpqxwmI9sRDPkO1WflvOIc/Q9qgy1ItvSjweexEuSRAlA/y3m3iB0jTjiRFnlsoCWGTcFN7PVCpg5VO3cebgZi4vzLIZSv27p2RkYMirdqUT0scORJU9PjdfCl1t7rGAuwNuziNdJxxh8U5axTu4fkYGm+AnI31QhSvnTwsfIf/Soy05EA3pbbrukz0ur83Dx9KAdH/63iAluhv0IoNY1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujyXZKTxMuz6BKMQI0u+JEYz3PRSZDVV8KHWp/4DCpk=;
 b=kshYsqUnRCZa5JLDHaUjMKnoaifqVC757bzi1E66/PEJM92xvUL3hAhe3uJjBQwD13LDAlnEEfMNE0FMiogSVoX3UUoZ9K6PINHZ/Pnw7k03B4UsjNB9COL7644/sKst7h36wZRCzIZqobS7INzKSiBEiVdv95z43/FnnbvUC78=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7372.namprd04.prod.outlook.com (2603:10b6:806:da::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Thu, 26 May 2022 07:36:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 07:36:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] nvmeof-mp/001: Set expected count properly
Thread-Topic: [PATCH blktests v2] nvmeof-mp/001: Set expected count properly
Thread-Index: AQHYbQ6PWTWInQpfsUS5qcjfUUQCvq0wzHaA
Date:   Thu, 26 May 2022 07:36:20 +0000
Message-ID: <20220526073619.xyrwfudl5ibdw3rg@shindev>
References: <20220521123020.90046-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220521123020.90046-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c637973-0fb5-474c-ce66-08da3eea6d3a
x-ms-traffictypediagnostic: SA0PR04MB7372:EE_
x-microsoft-antispam-prvs: <SA0PR04MB73725E2A008981B2A932C592EDD99@SA0PR04MB7372.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrf4o+xMmb78VMHYRCb4WwVnPGKUXEtsm3uwtcPmJmOIBIYT6QzZ7r+46Vt4U0AMu/x5LPSdE00+mqVFdhnsX4Gj9ZKuzD5ZW4Dl3iS4HHIOAl1KAV6LHWh+b/FcELVSHg0D3pui6iUfY0XvvAzrLExDJS+t1j5R39/pa5VZ1x0W9T0b91z1aJLgoJqKuzEDEctqjfdUPngf4ijxB3Kf6Mpv9iFRDagIBL3R0nPo3fLEnX1rzeleIJ3pSMai0Gr2bvwFy7MNC8YlPXkpGH6lNja6FFtJ6MBosDgnXjtuvhJwDsl8UEd8hexOLDx4EUlJSfpuvHwqbIHqcgBpvbiXq7vaPDOiSqPaGh3cf98qAteash3B2TEz3K5FeFhNIqzj+T5+pat2or9vWighpNgAcdgueE8bYJ7cc4fu1Gw9kmoqEicnzZr5INJUGbLuCDYJqFslFoN+dPaHa0DOiwnQ/i6oMIYDkRZVmhv7KYoOqeNyDBCtR9DVzbaO8fw9Agbo4ph4u1PstH92XHlwGG4GDkJQY0iZ6cbsZRECBiRd5ORpC1GJhC50gZDAEciKXnD1/Hmcpz7qxa5hv42447ocy5z+NWGA3M9JaUiUhJ32o7pmDQi3jIZK2sQhaC1Yb7TAUpPsDBDmGSv0VSRA25J7avsxQHQaKv9ggm6eE3pLeWCOWZBAUZwqZi/qh5LshvsaQshmj1oHVwdEMSTbYHwdWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4744005)(5660300002)(1076003)(2906002)(122000001)(186003)(6486002)(44832011)(9686003)(6506007)(26005)(6512007)(8936002)(83380400001)(38070700005)(38100700002)(508600001)(82960400001)(71200400001)(66446008)(66946007)(66556008)(76116006)(91956017)(64756008)(86362001)(4326008)(66476007)(6916009)(316002)(54906003)(8676002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zVGaZpTi/8PDd8RVg3Xcbt/hlA1ycmBe8etL6Qu4jvFv3ezAsq0ybrsK7ZM1?=
 =?us-ascii?Q?NVPSxLhtFcn23KFJwITtmJdy7dyHD3Er3yDwZ7eQbnGiCLVjAjewZxLCjSYz?=
 =?us-ascii?Q?g9TF8z2o//ALVtvhsYWSAawAV91VYQqW0jpVemaB2Wtb+HeZz333LUbL5yvl?=
 =?us-ascii?Q?7s06hR4GXlhwWuLUMdvK8eYARxCLuQuCVK2CZMVJkx3Qw3ieiYN1+pyCTLFX?=
 =?us-ascii?Q?MuP3FZf9jOwBG69ocYlR9ZgwVFBcjihzosUsJTtHzVqUbBwevGKpnPdEgSF1?=
 =?us-ascii?Q?gs5sbJ0lqzSyvjqd+uhMlLmB50xtcNb5RrcgqnGagFHAdoJVJYtiJRS5HXmS?=
 =?us-ascii?Q?BpyLSd+S1a8LSFUFu7Uc/mrsLsINnwOzrmBO13HCoED8xGTl1cle19SjbJDL?=
 =?us-ascii?Q?I385sLAWx1quOiGdDLeVxud+vAW3a1AWBZSZCoKT1CS/Jv1yJZQHpJ08iASS?=
 =?us-ascii?Q?hqs2sjVE/KddwtbVt6Q/SG1MtpvrcMHlNXKr8vOy8pdNPrx9nkA8mpsio9kM?=
 =?us-ascii?Q?nzq4EgHNa8+dUoHoOs2m8CgX9B3gpYwv+tjl61cQ37+OzZsCM5S/fxyyL8Qw?=
 =?us-ascii?Q?Q5SWS+ikV3tGv2OMwMSDq8RN51n8nb2lCTn1AeL4aofWmKeH3st5GVQV5Md1?=
 =?us-ascii?Q?HZbWK8ljhcZow6tbTtEC8mb/LrJo+mEKfg7R3IQeRY5F3rzpbWxfCxVxDC/r?=
 =?us-ascii?Q?mT462iRT4VKrgsPtUWXA82jjRdT/188U3ZuUeXjG85Vve559GLZCNmg7KU7U?=
 =?us-ascii?Q?judyjM1x9Fpt3GyapzNM2LJFIoHxj2piJG1FGuSVYdSms7iNGBO+UNTZ87Y/?=
 =?us-ascii?Q?gZuu39dL5NP7SSX0QuiXrUivMEqsoiUD0J/22whbe7Mc/m9TyeM4GhQnwZvU?=
 =?us-ascii?Q?C1S7OPw2s+nwafmL3x4NxQwP2ZtElk8GmRN/Wtrw7pu9eTfipx8t3ij0VxPi?=
 =?us-ascii?Q?PO1Lz2t6xddpUN1LOrOGlbBGVygKE2zORuq9QuhU+Q9mpYSkZpAWtpP9zX/N?=
 =?us-ascii?Q?ac1SoiBV8EHYlKRx/6stVfqdsQArQOirRpwkvqsR0RwygjyqKH7eMOwYLUm9?=
 =?us-ascii?Q?Ws9V9zsCNl0IAsd/tvf9bPPRfPYopTc8s/uLogVx3wI+7IOtcDgZarTIGH92?=
 =?us-ascii?Q?jF0D1OoIe8+37xRxgNtRx6UwN0DE4PxhFUQL3YUXAcoDrUWoZzspBFm9Xdn/?=
 =?us-ascii?Q?9Pb45r7KObca3YGWgRY/S54iC5znkzrNc3EEMgyWj8NlMKDNWbKulqv0Eze5?=
 =?us-ascii?Q?m4qZquMwg9W0w2zRUWHt56/qd5cHxAu6rlpjhyTnwvmsCTu1SAfY/n0WtL51?=
 =?us-ascii?Q?fSIfxjAep+sSggzWTMjaNZ8G4r2JYXGIOrP0EJmFNvelGFNAyXdS5ta2h33o?=
 =?us-ascii?Q?yGAfMLsdF6Jnf35cCcW94QJIR3ZtLdfprhk9Xu80bqQsgVPFBE5LBj54/lZF?=
 =?us-ascii?Q?g6BG2NAkfrjyubZQIjrLtUCrR0rUvzlUkWb2h2Z0VsL03aeqDcZCgjEPsIun?=
 =?us-ascii?Q?tj7M90YciGMgXfWEDBEMMX7PaLdH5KRyyicdBHD8uKTRxQ7+UpS+8Cqa2HeA?=
 =?us-ascii?Q?yh5tpDy/gYYWjDIm7mxQbo2x6BokhOqZlASIuwSCF0jGRUtk/Ks8Lw391EXg?=
 =?us-ascii?Q?dTD/h7mmesdxW+jJtX1jFbDDnftE5tbc26SguZRg7XzOU0ve5x79INH+/Cfp?=
 =?us-ascii?Q?nLb1We7MpY7DXZYUfn6NgZwNkYqdzG1RYK2bORnA7GBT/vJu1Uweybmv4hvW?=
 =?us-ascii?Q?rP4qEYwnjoZFsWGmTeol/n3OvwUOUiWNqKYYbGBNZDFmdUOHrLzz?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A9E78B494F109449760A6C9EEB84228@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c637973-0fb5-474c-ce66-08da3eea6d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 07:36:20.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHFfQ8fS+LRQpKPWmCC6NaoRV6YWG1HKxkceFYM4/q1Jn5RpGSNW7aVOZYZ2ciH2n6feaCxnJcaeYMwOHOFV6lywu+zUmvfcWzJdjterkPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7372
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 21, 2022 / 20:30, Xiao Yang wrote:
> The number of block devices will increase according
> to the number of RDMA-capable NICs.
> For example, nvmeof-mp/001 with two RDMA-capable NICs
> got the following error:
> -------------------------------------
>     Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 2 <> 1
>     Passed
> -------------------------------------
>=20
> Set expected count properly by calculating the number
> of RDMA-capable NICs.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Thanks, applied.

--=20
Shin'ichiro Kawasaki=
