Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE3C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBEA610C7
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFUUWf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:22:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31376 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFUUWe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624306819; x=1655842819;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/H/c7E9rW1b9+j1C8+3uJnl9ChMvL3WLejVL4cTitmE=;
  b=IXvFN1gtXGPHjlpMyrZM1JQY90yTbm3iGafeH16VfbxNSfjsettkd4NK
   r2yiolHRUpv9PTCXxil0KQjWGQLdTkH/9fSFJOxaQebAkvHw5YAbY/Jhs
   yJlSXWdt6nDdx0sBI5sgzxDcbfJvn0nA6+1iI4bJI/55lfB1Yo8M5BsPq
   TjbMKpkqiNPIPh19vDjZeecxBLWjyJc91spPFuy/cA5RI2ND3M+ZuB9tV
   1+6GMXJ2pwylypqFZHUH+wjzKhsyPvREvD8dzY2vvvi5PArYQmeHgLkTY
   s4i3v76/9jgtNKtHfOSBPX+AqDtCYp3dn3rCWI8o5aQd6YKcgYBkktt+M
   A==;
IronPort-SDR: LNy7JEl3uj52iVFPiWUn1TStOGmCcPugnubXwC4QltYJQlmZQJbW6yVIaiXgEhGR7EXm5RMtRN
 yPjlpFSqY1lV1vJuNjEM2zlRsN63QSy/dr1AnAKx58CJ39xAoxloPkDgRLc5M75VAJyGnYA3C1
 0a9qKgbyfOMPu5NrMf9l6JAsuoTSQ7JBI+gamD5QIfIncywzgtIxveHYDN0ttZrYQhlY4VMdcM
 n4qdy0ze7uXkXQFEO70+EjCNtKRy7zW8EfZ05EOIGQU1vd5MMBUC7rQKzDK7iMJEsbW6uaSoim
 yng=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="172519417"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:20:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfGiuYiTaHTlYsvDcAa1ecPMWAvuZDI4NDnK+0HRQaGcDtG7WFiKHuIkfB88ztjn0626PYDS21RcXMH7o8mucEINzHQiLeSpJ0EbEfpcOCRukqffgLMi+8aIfFvircF8kyfnthd6y7eI2HXpIcZDPaNce4J/xEitWkZa2BT/uZSe6pEtX0nf67fj7R6SLiC6K4pOGGrJ3SqTSh9AmH2k3ESEnmLPbGa7uTkUIHmxDQbPqF/zAOhsKZW4BRLw9cbgKabWZY5fwSfloP8Uvuc0vxqeP0CnODbWBjCphE0uV5JqXw6pdJdAwkoarD+z+9GD6Jc+3RFKCLAhHR1VkBypzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H/c7E9rW1b9+j1C8+3uJnl9ChMvL3WLejVL4cTitmE=;
 b=mE+Cq7o6uyE/Qm2IlgipljToNTmFA3//wGi2R4DkagzeMxhzB81XcxC55+shk8Po0XL/EjgZh09naDwM9sm+LivlJyR3HYQDH9oHIpdQq7gHKjrAeSG3hRc/wlxUS4GEe/OMt6VS4yhRFtbW8hwCmbrnxrFzy8mcpfs+KzWaCO9fC69aKeXOkXThqfNpQ1iHnnRfLYOpQWF5W/09x93ZSqHRNxlJgm4Qb8riiR79VBgt9tmLZivuZSQV9iITCKSZJWfkWwwzmx+KPZpYBqhxhZObdYPWQxdxE4o9mcLivOaIOhn1EXmKLWjadc7oeS/Z391SS2fBtU9Ay6oJa4VITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H/c7E9rW1b9+j1C8+3uJnl9ChMvL3WLejVL4cTitmE=;
 b=kXJoKgt6AJsJpF6CtjZRRvlkhINXWDim1i+rGYHqwrR4B8PMBM8+4Fqa+FQsrBRISY3a/E9Efme6knQqlfOeQJN2Zmzlgq7hmC3V6UXloR9kPj3QLwIiyrUITBUnLEThfSAADMoiRJmBglHpgJrVUlA7Jhe18YIBSqLHe1Yzadk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5429.namprd04.prod.outlook.com (2603:10b6:a03:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 20:20:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:20:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 9/9] loop: rewrite loop_exit using idr_for_each_entry
Thread-Topic: [PATCH 9/9] loop: rewrite loop_exit using idr_for_each_entry
Thread-Index: AQHXZooUQGkFT5ExSEWbeDdrbPMydw==
Date:   Mon, 21 Jun 2021 20:20:18 +0000
Message-ID: <BYAPR04MB496534116EA00E81128D42BC860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a314bc3-29cd-4e6d-ddd0-08d934f1fcef
x-ms-traffictypediagnostic: BYAPR04MB5429:
x-microsoft-antispam-prvs: <BYAPR04MB54296EF30F39EF5E0ED80A5D860A9@BYAPR04MB5429.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pv2Go/dAXZHr1OVNhRzbITaAlc8NB/HZ3MbbXGeyx1iFofMxrVUXz0zX9NYI67YCA//51jX7iQGM8HraJgUM+3x8SUca1rBx0MzmwnHc40ETNrYDiAiz5EZ6qQoMCNsJLxQ0Zydx0F2Nq5nxiNTzudD1tAxq5JkhxzA3Fua5c2OUCCVzabixvCaMXqnA5OMB8caHyi55aUdh/aEUPN2qdL6tHrQ+chvccnAyfLMe9Ma4n3T9cRUJB5CMJOGtZ23VH6znn89IpO5AZrjuNHo4U8z/VuicBuIIc0i6QOSN4WEwI3C511F/wYlTTvfuWGtGhdADgam5ub4woplmkjoCJt9lZS4GyKYBLqSIm+dy1ZU5TigCUkfDVOUIiEf/UL+jcTz7SKXv4fO197wYb30E6zdHyh+DLN/eYj9hX9KpXy2+dVJJXHPk+7VW7+FGk5/fxo9sOwNzgmIxuaVBHIA6BaHbTKz2CayCDKEPjaYufiXawsNHwDd38W9RxCzYl68pWNfHRL3yzHFXOhQd7LbJkWHpVxJNINAwpP3Wj2wb3Tnt+TuvVq0UfMdFDZC/iAjtPY2dvE7Nm/LxXkt3xI2G1Jjs6Dol5RDQUKpdZysy5vA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(33656002)(6506007)(8676002)(478600001)(558084003)(53546011)(8936002)(26005)(5660300002)(7696005)(38100700002)(4326008)(71200400001)(186003)(122000001)(316002)(66446008)(2906002)(66556008)(66476007)(64756008)(66946007)(76116006)(86362001)(55016002)(9686003)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fq/c0fFl1ADVbf5atHbptnHSHk5f7MJRAP66VwcTvZgfmB6vjHqDjviPKm8w?=
 =?us-ascii?Q?MqAiN2Je4t8NReAU9z7Q+yZShnMwSgFN5ODs3fVwCLkqDipfTZITDMO7Sb0B?=
 =?us-ascii?Q?fJUKXBVPqn7yUGx7f2RHTNRE6Xjta/YLxY+1L++ePlSF0qWSlXXLkLMOTUGY?=
 =?us-ascii?Q?EUJFfnk1kSxKWRYwwgaKa5WM72vJe2nR4G3o97qWcpaP53u23oqqnwACF5he?=
 =?us-ascii?Q?5iGIrQZSGeBcY1oblc4t6/S6A2dExwhGXmhBhxM0hZgypljnYpGRgtyJ9HfV?=
 =?us-ascii?Q?1muGUpVyjp0KUA7PQYpmHv+zSeQLKUptEpGEJXKUCZx9vQX0ilsXE829kipD?=
 =?us-ascii?Q?fegJE2KxmTvk8bRhM7dnrH2MehULceB65eu4xWb0mP5rZ+VnrxPvrtKeUg7Z?=
 =?us-ascii?Q?x0/kTOW3jiFzArNIpXKXQPJvytyNH0o2emqENHEfvVr477aQi/Bl3+3QwXPC?=
 =?us-ascii?Q?8K+zbOUJqm1YpbG4Ck76541WyUoJPnPsdFo5qtYpiEWqgWS7xr8V4h9qQCLU?=
 =?us-ascii?Q?D4uxb1prKKMfn1jLvBOCyM3DW0/rC75HRUjZC+pZ7tbfcJtoxgxLcjn83ZRS?=
 =?us-ascii?Q?vv81r9On1mPuDq0jQq/EaT7MDyxsopxidl2gHbyLx9w1kS9sKiEI76I6nhjI?=
 =?us-ascii?Q?efkSQPCT/JKGVXymlChvve2MB6HZ0eUxujqzqcf/njntWAnWIaWpbm1hOEvX?=
 =?us-ascii?Q?dNkTVBFkyfxula+E6c4YgCdJUqe4p/H3knbyRVDNjtQO/aTI9H+PuiSYE2bW?=
 =?us-ascii?Q?xcTpSxOqI/sIolHgusoKwWzG/YU0nLa/1+9Krxlko+EPCEZVI/QCFlTRUTye?=
 =?us-ascii?Q?TwdenbnGPNDRJMfVtQrWTBE68kBBrjj40Bzk4LdIokhV9US5VAzVq1+pp5yi?=
 =?us-ascii?Q?Mtv1fkdOHlq8qvJoy7GrEws8qjiEXRQqFfFBtYOL7VS/TebD9ByyRKQM3YH4?=
 =?us-ascii?Q?gPECg9cNiPx5/11VjOxQY8a0utfmbPlyLT0XEX/iXYo6WcoRK6jibNwokMue?=
 =?us-ascii?Q?GShXUQCKJcgRlNLxLNto95tvGlJYxlBpKAtnpUOSSt2ByAH4DU9gd59j0Ycv?=
 =?us-ascii?Q?l5NCqpxG8bycRxQFbl0FTDW9Y6HqNmU+k6OGPQ83e0OCvY5gYOxREzBNEu2k?=
 =?us-ascii?Q?/U64f+42KG3y4WLJ4+vJxZHw8ehxw9vqNj2dmmKrrSqDoL0icPucqxLkHTkJ?=
 =?us-ascii?Q?aDHmmnvTkNSz0Ah1Q/AStIV0sOQ6LagYtRbPHIcLQifOZsN0Pu8lzkGxPxel?=
 =?us-ascii?Q?VO6m1e4Ac+DdnE4ydXzieR87/5O/PNrMioxHrkmlSMcKRGDd0cF4jLaToFze?=
 =?us-ascii?Q?9fU/dofTTckDP89hF5xwp1S38l71jhhc4T2vSzl2D2g/QQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a314bc3-29cd-4e6d-ddd0-08d934f1fcef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:20:18.3817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opu0s9W0jsALWCYkGkgz8r2kf6jxfd05dsb09eYBxjMhKYhZo3p5FADYDeWDj99GDTOr0kAaF0UFVfDGt09VbeaikkUqbD1vDzYEo9cl9a8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5429
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:42, Christoph Hellwig wrote:=0A=
> Use idr_for_each_entry to simplify removing all devices.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
I actually thought about this while reviewing the first=0A=
patch. Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
