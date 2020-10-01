Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB1BC4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A786420796
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VMlj7ije";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tFXLpXJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731895AbgJAKl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:41:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61106 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbgJAKl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601548916; x=1633084916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q5DepclaaFg9oQrltRo/lDYWZBQshy17dRXjx0zpu4s=;
  b=VMlj7ije5cOdNbPdMfVO39rfaQCMpzj65vPYKYJphaFLYuqXwgjmVTBD
   NyWk93Ce4YOVCSwd5UY1lEsEjAL6RJKF6Nis8fe/4mXNkHcX9E1Ty6f+o
   +aJbglQQM+B8SfAmoeGckj/S/CNKVls0M4U+vKpk/yKqKg0NtoEW3YzcM
   ZTgOrE3Emq96GrAtHFty2fFIKIwbjL/AkrozCYwNcSybAI1XC3Y16hm7z
   C8GZAY+ukc65DhLrsQwOB9gqeeeYXiAj1JBvILsYcZtc6rG0ofGv5Gpit
   V7fnd7zYXWiktXddy/Ou4a39mH22Fu8NRkZlhEmLCG8UihnKtM9i2AtKM
   Q==;
IronPort-SDR: c/CCF/z2VzGnZAi9yZNRNuaR3q1WZWdAlr5C1DochvJ59XouWVF6jIxvHHsUxUry0cKzHG35BE
 CTRQCgDa3owq5/5ln0ZHhzHs8eVJrwGSj9o7nDm1eqh8/CJr5X6wrX7QyzueREnW4b1ycs18bM
 ef9YSM8RNYsnUujTDBqV/wG8cGtaEfngyN0GZ3tlICwHkgX1q4CPDi4f/DrZ1+JZtN+ptFTKFK
 gFqPQV1nzyj9MlEMPbTKGHUBZy+4TCXCCyCYK5wZmCS2AV7OZ24PV8hhvdoLmExb6NcaSDedFT
 jsk=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="258519314"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:41:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYRDT+4CXLnCPyTgXtPo3vSWv6cyIaH41YiUqPza+ZNtMj2ZfsrErfKQveVCGLi+3xXXo/gJ0/YzeWDQnk6ZrmP7bVGrGDlUER/fWQlieLNaz9Y7FESdbx1cOA2FGWnmzSzLC9PAU4/sLVT7fn+Um5SVAfcFZP/bAGEJjux04MHR5rg/0zXIxC7yo5hEM4kN/RdnFCo5rKCphISHwZTK7r4z9UFN2m3suoiTwp5t3E2CaVUJ38KoYqaPVbao63eKlHb1mxJBJPIKJN3Z/aEabCZCJzu+mPKmW+j4EpvaI7N6BXTYajeZ09Bh/CMaYVfYpKlK6b6YWKGn+OO7xwDFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5DepclaaFg9oQrltRo/lDYWZBQshy17dRXjx0zpu4s=;
 b=kuamph7W/njnH6ovgz4S86IsCv4hAYQ/NAufIROcafMFsurZRmVXOHaR3E7o1O7q+OOWLZ6DUGkYTbNS1uzd+Dvz9aXBuCrZ1Z1lYRMFv/9YCZre64NVwNU8JeAOJrXIDZZUEyfrCGKncuvigcrVtHOdpOfss6ZMe+YIPf1ci6INgtDFAxDuMjeYhm0VbmErMD+auLf4ZfINkI1I/LhkN+yedYbtX38L5oZscVDhaXHBUBW1JHYCBlfG0zukjPFzOD+aaHkdHit9c1fuo4Ies9+AV2L5e/M6WXDi9tyyan7sqmsePZ/8lwVEboWMpBnyDn6awKBTUEYMhHK/LXm/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5DepclaaFg9oQrltRo/lDYWZBQshy17dRXjx0zpu4s=;
 b=tFXLpXJWZzHscfT+0qF68RiI7dvYLkyV1GUAZh1ApApARQPq7VRp/UAQ/xZpv67ECXLafGUm77uMK3lLkvjuQfRTd4UhHKRuCGd5t7Xg8mR7TZxo1ZWgYttvyrICguB3RLST7R+3d4E+cf4OBcQ4k4bkCcQUmnklQoo/GH3YKqE=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6978.namprd04.prod.outlook.com (2603:10b6:a03:220::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 10:41:55 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::ca4:7065:e0f:50bb]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::ca4:7065:e0f:50bb%6]) with mapi id 15.20.3391.028; Thu, 1 Oct 2020
 10:41:55 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Topic: [PATCH blktests 2/3] block/004: Provide max_active_zones to fio
 command
Thread-Index: AQHWl9vSlEgOxFLjSkOaNH08AhcklKmCjzuA
Date:   Thu, 1 Oct 2020 10:41:54 +0000
Message-ID: <20201001104153.rbedkdqxtogzm52s@shindev.dhcp.fujisawa.hgst.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
 <20201001101531.333879-3-shinichiro.kawasaki@wdc.com>
 <SN4PR0401MB3598A42EB801A3797A7B8C799B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598A42EB801A3797A7B8C799B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d447ac76-0dcc-4319-ae80-08d865f69d7d
x-ms-traffictypediagnostic: BY5PR04MB6978:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6978564100B6F19795E87F8DED300@BY5PR04MB6978.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Cz3hJ9eB1YuQ+YerdY3yjFnMCuYXNtnt7d6S9hiF6rmeB4whkqaQ0TywJNMv4Tzfe2lIC0Bv307vcTFe6zxYZ6zbWajiCp2e82Wzop3WfmOsrEPRwjCjRPExaF89zlIPnhu2z+H2tlTQotJ0zZlj+JCndtz74q4zv2VTia3fqfwLzId29lFtQ7u8P3YrzXOCve/iuYtn1CGk9sE9sNgs8ag1/Cn/HXtQK4r2eFh4YO2mNlMHFWWjsKFkiGX4hMNjRfPEEI5aOW68p8XTM47B/4lvbVioC4XOZoxt1R7YsnZMfDppdSNVIzcfbwiWdzr+vERVRZUHPgaRlF9auYblQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(4326008)(6512007)(9686003)(8676002)(83380400001)(478600001)(54906003)(86362001)(6636002)(1076003)(6862004)(8936002)(5660300002)(91956017)(44832011)(76116006)(26005)(71200400001)(66946007)(186003)(66556008)(66476007)(2906002)(6486002)(316002)(66446008)(6506007)(64756008)(53546011)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pAzSGNNF96epVKSS6mxOGbNrB8vnyVhUZBYgc+9F86gq+hD1TDkkiQXiVhMdM3gasgdEwHDlWIjAgMy50K1qS/RRjXY4otV1KwQ35QMHLrbdHXRBHMHmaf0QnDtXDWDLpmFVbWAAghvjt8r2tRLFS/FfGr8qP77T7aN8OgDEbV6KsSeBNMXk6tG8IxgGO4GbiCQKdqAHS2IQMR2mCDoqDiLM26LE4hpqVzMlSQ5CCYlXksHordFng7RxNRH7ChaH0THHVh98pa0aFQgxRX6yBIJ+4Tva6nG6kJjdxKZCQ+1m1kZCPFR50Q3w2X2+qhwMPFYN+zVAqPAj3oGLJIyY6BWucRfjHr1xMXvy31jFx0J5UL1OH+o1L1kcleUbxHkPtiYvINDTH9eoaaeQe/TjBFhN9vDozpAiUTp6eXQr0y0t3EVa/auDNFjk6J8+J+G57cU3S7SMS6RvSMgya7FpW59h0P1mnx5YT0Be8SzAr4wxnQMjNecO0vC2mWQ7FMfi36R910oVnJUTiz/iEOpy4niDjoRBC38CqG32ZoqkhRFD2yK00wJb32ogrTp5HD7YiZJYbfK14L+MPkdvFZTygNGxCaqFr6nIMKNt8hZjIVDTyGBc+c9rsUhLKLPZTMYGoDDaXxvbeuYDj4W/ObihMQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18E6BF9C31D1254F9E95997C29509B13@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d447ac76-0dcc-4319-ae80-08d865f69d7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 10:41:55.0085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzrySJeg5z5WGW8ZRkUp2VksXakap1mK5YFf0Ok0WB4FeBgJktHwCSgWWQ+7jZa8u/lU+NP0ZvIx7jLloYYuXma0L/bTLv9IWRtm1yMBzIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6978
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 01, 2020 / 10:25, Johannes Thumshirn wrote:
> On 01/10/2020 12:15, Shin'ichiro Kawasaki wrote:
> > If the test target devices is a zoned block device with max_active_zone=
s
> > limit, the fio command in block/004 opens zones beyond the limit and
> > fails with I/O errors.
> >=20
> > To avoid the failure, pass the limit value to fio using --max_open_zone=
s
> > option. This option, which was introduced to fio together with
> > zonemode=3Dzbd, keeps the number of open zones within the specified val=
ue.
>=20
> What happens if I use a fio version that does not have the --max_open_zon=
es=20
> option defined?

The option --max_open_zones was introduced to fio together with zonemode=3D=
zbd,
since the beginning of fio's zoned block device support. If the test target
device is a zoned block device, the test case block/004 checks that fio
supports zonemode=3Dzbd. I think this check is valid for --max_open_zones a=
lso.

--=20
Best Regards,
Shin'ichiro Kawasaki=
