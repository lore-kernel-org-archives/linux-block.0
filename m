Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A488C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281CA613BD
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 21:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhELVlu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 17:41:50 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26172 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhELUDG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 16:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620849716; x=1652385716;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iL99Xo4bmiUZMxTGwH3uL4UqlB/7p3VRJD+NYKEA9jw=;
  b=cgqJy2BW5B5uBUTMfV+kwS2RaOSTf6cJPKrYwGB7ppLWsRO054CVUnWf
   JUvhp6aVzWpu9LZ3dr3K05ZQmQQqcYrI3++7HI1+s4cjm9cmQZQ/JTSHk
   vacDu9L32C1gjfI8ZWSJjl8C5KmS97tTVQO0m/uZ3OzjY017WZJJIyT5m
   I7ASqeN9YNxuDJC4TWWbQoo1slSyAwEhGUxAEsh5caeum17aRQhDgtuWq
   cqM6z3zGcytwmyq86TbOLo90YfMyelgg0axsE0Z2SaYXYqXiSQiJBFcqX
   n+YQregxVWgytr9bVbtnVUO+tYWtATPrpXh4K9PJB9Uc+UJem8lqfsK1F
   g==;
IronPort-SDR: z+QexEgDcMxgH99+N516f6vpAxrqIMHOYZ2ans2OIWZ/XgtG61WCfLfUPIXYd6uDxK+JxcU++d
 kT9/DhkDyK0En28JGDEtJsuj/BBQDmFHSyRh5oxLBpi7T6yb89Y7WQBSzaxtsYOcUQWJVPMk8t
 Z1dSCqP851/5+OeO0OS+gyeAqexF/ZUhJLUAyQ30XsBSKp/kjNlKrJhvzZ9HSmrFTlRjLRfvZq
 fSvXDDD3vb3gwnN4nd/GE4eVmc5dnnyv9+nEbFcutFcTwrRnxTO9+qpAqSh0Zb8/4cKy5jHWlZ
 M5Y=
X-IronPort-AV: E=Sophos;i="5.82,295,1613404800"; 
   d="scan'208";a="168508053"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2021 04:01:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPbwKYdgHV3fO36o+e1byGTg7ojumMNQwWA2ggPAevEI7gpvCKiAGqvdIEkgWlHrKTRBkhWPtvppzlRUxsxkgnqV7jPOB633UYgDdU80MK2HURhZTURT/V54vEmJdqZGijMfKR0BuJQkq/31afMHdpQTeFnDesSQa9JeGtRu+GrjWwEjvAf4QrXloFGPkM18cEyD7TUGpWpkPfrSuEo0I75Cx2vLaApBdScKsvHXVk4wQ5ktSebjJGMBOJIaBmgQLf1vp/by/z9vscDeyE0hu/wrAyfaRKVxCvlHljNJwu38cauRHqn7PcrGw3Cuvadc9RjalVKioA4hrjp35/qO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL99Xo4bmiUZMxTGwH3uL4UqlB/7p3VRJD+NYKEA9jw=;
 b=M+A2rwh3gC20ZL3Yte2daBlfFr5sIyaOYYKw/nT42zr65FOnoWsQZn6OtWmaJ7NgxmF98t2ZeES9N3MykMpLntgmTEQ1ICi+hqkC0VvSul9TXRex4xrh2EPHFEsttUMJydz81RhEUbqwXxU4eEEdWtQEgE1//3ypXC5o+ElDLnysJrgCQsL2r9inGRI+tl9p8gyWKD6IZUpQeJ7V/PsIMm7e3Bi3wGYtPFjuAR0nDq1phCwBjfXr+CC6G7v7HV/LF7CjEdEzP/Zrn7o2TbvfXLO7YT/GoexDsYY0hTo/y4JCy8KRueuS5KwMhHkBj+BzqH7GT2ycwdGs18bmpZ+jww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL99Xo4bmiUZMxTGwH3uL4UqlB/7p3VRJD+NYKEA9jw=;
 b=r8ONRogsSn4/n1xz+oOe2wq4278FBEZmB/pi1qXcjRLLWBw+ToqoHj95TxdyTXvqmbgiG9RLxY8M+QloscVqC09/o81WJWiXpYgDPuS3YbvO2YzL/6oFwB50Gtbeu/LPJqSLApBcY4QDJbBlji1uNwhevZPQm6UkO+JWjc2enFg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7680.namprd04.prod.outlook.com (2603:10b6:a03:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 20:01:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 20:01:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Use helpers to access rq->state
Thread-Topic: [PATCH] blk-mq: Use helpers to access rq->state
Thread-Index: AQHXRxQ8ZTsafKwn90e/FGE2vjutDg==
Date:   Wed, 12 May 2021 20:01:44 +0000
Message-ID: <BYAPR04MB4965C9302E1CA6B144A6CD8586529@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210512095017.235295-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71edd4a7-ae54-4402-85ce-08d91580c470
x-ms-traffictypediagnostic: SJ0PR04MB7680:
x-microsoft-antispam-prvs: <SJ0PR04MB7680A8B86EE8061AB6C948C586529@SJ0PR04MB7680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 36oLPC/0Omt6LZe627Pmg3GjmfGrsp5EAlSN+qVRYCcEBk+xSayUYHoYXY8/+tz0A9wsaX6ysMMgAAi4ZrD/tZ+gmtl443fWBhOV3rdcPNcAnahBucUv4rtxpYKy1FG3RRJnk9xIbCOCqgerNMqb2G9JKxtovyQOf9tBjqBWFlJw57joXAIWwlPP0BrkZRNOnCcnRBnwANopT6xvHp34Xx34dRC/BT1PvWrQKRYPXl2l9r7btIUSXi9nzrUVwxOPofQLedZ967AGyb7kVl2txjIukwEOCqGi5+5tMa5N06/YYnn0T2kg0RZS3ylXdZhJQSX86e3MG6KK0sX9xHt14fQh2WymY7Qqbo+g520YCqIWCFVGIpauTEo9DnYltdk5xhEbJKMBn6uxoFCmFUH64ADThIcnsGwWPXnAOAwLUdASMQJDQyxNGWKgw+kLX8yEPBvHVoN/nKFLRtZyoKTQqfApMY0ZU3GWrtrr++V43qw1Twg7JqwtTfpJ61p6jRUZpn1+m5C01m1Vzf6D2uDuWZRup1rJJD7sbAF15vte7cicxxl4vIvH5Ip+hjHH0uGvZNHz5IncXJv8vPoe3hYZat8x6tmUpfr/jYvM86XQtsc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(33656002)(26005)(86362001)(55016002)(316002)(9686003)(2906002)(52536014)(76116006)(38100700002)(478600001)(4744005)(8936002)(7696005)(186003)(71200400001)(8676002)(53546011)(122000001)(6506007)(66946007)(66556008)(64756008)(66446008)(66476007)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zEbZW3yuUhO2xmevE7z/GmfktT8Atqi0ZYQHgMIrjy4EZ/is2l3N4fWsT8YQ?=
 =?us-ascii?Q?c5D0oxaif+CCpIAZ3jWY4uCHHM0XvfcFEmOCoGDa9qc/pUc/RYWY1IYPpNBn?=
 =?us-ascii?Q?cLEE1j/4oQhqoSUyDQdT/M/E8cMj2cy0D/CMgfgT1IDg/r+ZbC0PRlKoeaV/?=
 =?us-ascii?Q?0fh7mrt2hjTW3GtIFI2YBW7EmyRu3DrzlEJf8GLfmlszSvQS7HzDjKDMDg05?=
 =?us-ascii?Q?Bgzf9EzKZSQb4xKkPTSbVLvpuXMsskPVsexqYbPtSd4WNog59ZCj3/SjuZ6A?=
 =?us-ascii?Q?5YRwKV/xxL/97wZd1tTN8kJh1yPLo1gvFaJS73O8mfRIXFr6e7cJktXEtSP+?=
 =?us-ascii?Q?VZhf3J8+BqynWY+AntYILz4jusr7Bfx0aUYTtez8w3/MWJGPlAt+22j7r1+N?=
 =?us-ascii?Q?wxn+XmyRah49K/X2DIMF9rB9UDj2ScByLLkMhGwBUHIMFDitxUm7F6nAWUTs?=
 =?us-ascii?Q?e1e6R+pgRGAWUwbcjwlNDZlr75MacXILkhRrYX7bJqynZ/ffwjuHUNUaqr97?=
 =?us-ascii?Q?YU0/3OBEXV8ZExdJihDGQQ+//IduMR99miu1HJEjN25lWr6ylxRlk8DZEVsi?=
 =?us-ascii?Q?LBWnNfLfAg7W5XkrWX8oftq9ZfbtK+2S8wkouXNzZQB6L/5YtRZr/7pcBoY8?=
 =?us-ascii?Q?VXCTeEHUc8e92Ejf/+9+Qk2n6i4Xf/kKFgZZgfuqaTaZw/oLq1tdDDmWo+hg?=
 =?us-ascii?Q?L8rlOk1Fw2Va3qjlOsAfxiBzWMU7+Fo6IeChFNjX2DoWp7MzyAM5MNtQ77/y?=
 =?us-ascii?Q?DrxLH8Z6bULS8H4c4sRUyoX0kw2z4u1UhDlfFEOkrfozK1gEbbtC/2wiiHCz?=
 =?us-ascii?Q?ASZW6OtY/3cDb5mFdT3cudQdgjexFEnu/XYiIKcjeqBcPjfXfCD9KKzNQ1ur?=
 =?us-ascii?Q?30NM+7bOmMCJeMIcYfcy6dqzbRIZiFRoDW3NATeXWStvb6tkydC9c09c3YTl?=
 =?us-ascii?Q?XKp3G7JdZR7rkTU/8dHx58cPASRcldokgxC5+F9kWHypJIemg9kE5YVL0kxI?=
 =?us-ascii?Q?G9w+S34tR3q38CTr5lwpu18/tQYh8b/dR6Qwr5z5yyoQAAFVGiYzQXqpVwCN?=
 =?us-ascii?Q?uqYAc6Fo2+4GqbxaU5G0fk3VFLKTQEC9j1h/5Az41+eonGooBoyXYrcbUrwE?=
 =?us-ascii?Q?H7lY329fk76NuLNv+jleyxetBuTfVNJSZJNnmHtaLDMxIEdlueBXa6qF6dKA?=
 =?us-ascii?Q?yhtIg+OBaEMZQnAWR/HWS3bJwXBbe0PgRQtRqqV2Hl3ws7x9y8mLXgyvbLpU?=
 =?us-ascii?Q?T9lSF+LoCEqMi1GodYm2CTRbGW0gEchxmVGez6Ka4/07NzKGq6VaLQAYgafX?=
 =?us-ascii?Q?AjAvDEMG4ypgB/FIIxrfcA38?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71edd4a7-ae54-4402-85ce-08d91580c470
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 20:01:44.3612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COCTVi3BbwEGwZlSYOG0Ui+uy19X3UgUszOyqzypUU73YFg4FixkCEe5AWkqZfO3+Xpkqg3zxjtiwd8GDU2j3cY16spSZR1yGeJXp4yru4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7680
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 02:50, Nikolay Borisov wrote:=0A=
> Instead of having a mixed bag of opencoded usage and helper usage,=0A=
> simply replace opencoded sites with the appropriate helper. No=0A=
> functional changes.=0A=
>=0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
=0A=
Not sure if that is kept open coded to make code easy to read.=0A=
=0A=
In either case looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
