Return-Path: <SRS0=t5dV=4R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98363C3F2C6
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A49A24672
	for <linux-block@archiver.kernel.org>; Sat, 29 Feb 2020 23:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n80DV95u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="n8bV17AZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgB2XGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:06:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Feb 2020 18:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583017596; x=1614553596;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=edSB/1G+n1nOn3Y0Ks3inR7WYwepd+2OZterQ+RNMK4=;
  b=n80DV95udPJTn131n4aYY+qV3B2wzWSR8EhQbQlDuZ5eS+pxY56rXDQ5
   3XquWJL1Vj4/cl/0dgqApcKB8gClaFISvBocWO/Dr8XPgyY0goyhEQOWP
   tuwaSTM1KY8x9sSTr4AiCO5B3j6mWzy4ubSc1653Fy7zW0aIdLB9aZWlS
   fap18/grgtcIIeocOlj1WmmCfznEmSI5yQ/QzapObyVbIegR7BPC23IPV
   rfo+b6rMU7d16xUMvPxFfgB2/KBmCMtJItvlLDFoacX/B37+2EIdO3CTj
   WUJ6wVH0M0KwdKnfIZxnUpg2BCLlEtclv8bTVj6IM+6Vczk4LPuAekW/Z
   w==;
IronPort-SDR: SY6Li5x5J514cmvKwyE3uLR4zZkzltyPm8HIGWx7lxWin1OiFG/EwNOOaEQ1KdD1xNJZtV0gBo
 yQj928s69QEqqHxc10PP87GHPf9HRaQtV4gZJO5FxfSfWVHjvOJWaYo8MSvW44M1ZDJN+aBMNA
 zJXgRHpGeLLhUjoON8sRPa/hjXvVrsRZ8wrWeWyeHccrLDyeicUpMgF6BgUKLW0YOaDfV2eF2l
 DMvFGOyb3RjAdL3iZZ4yVCr1sMiBO8XGNxtLUtLeU3BQDq84Kjuvj2gPfub406bdYQbs0C8Az+
 uFY=
X-IronPort-AV: E=Sophos;i="5.70,501,1574092800"; 
   d="scan'208";a="131596349"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2020 07:06:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qn8IWBi+0zIAx83ohm15u8shVPLFNBXdYntaeuoDENLRA27khumQe5C0wDNA9MJ1QACY13GcvquJwbsOnNxSZ+1+4ledi8RdLmR4ADjfUvZUg/9o3JpGQynP/SZpDANJnvKb1Kxcal0Ikm1eA/8zxW4OJkS8cUYj2luvj2a0nV8hhc47G+fqWK1ukBZdvuCbE/gZH2LGpLAT/tBxDLPnDIf3soMf1rH2pF3ydWrRgkz06PCMqirGDf80kyBFhe6+FsyOmQVpUsuYmEYO8hcqXfRoF8+oFPctGxRJZNk9mLNsbbnm9153bfOsRedTPgrnpp7f4uEgrnyDb9P5Q0SxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xNoGJ11sipe8TYlgyhOr+icjCy7ptg4Zztidl0Lg0Y=;
 b=laCpCxD+o7AogqcPP9OcDc2KyfU5y6D8Pom2LkERDBonQsC0iwk2s60IhRZ8kSk811quQ6VeEOmbdDdyxgd/245F9yriHvs/F899f1xsJ/JgCDVfh4iTTlsrJELMRGfRl5+F7V71MvaCqHsYkdtySFNJFmuRBopjURdcV3irVUd9AIZLA/zcEriuuQcRmPHOPN0E9oTSG4Ao2J+0hDiC43i8AkYSqv04AcEpyBAWBdofxSXlFj82cgl8+UJ6WqF2wLEa5MPaAhzn7UxZ2pRTTWZTSYKya9vze+lf1PLBRjnumpNYXQqt3yj/r1e23/bOBStT5pTE+9W01H9AgUP+qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xNoGJ11sipe8TYlgyhOr+icjCy7ptg4Zztidl0Lg0Y=;
 b=n8bV17AZuD6LJ6KHQE+kYHqURHnqR8uUuwUkJruPrBwL0LM1ONQS3QcnXXDtpKtEWLCpRY+9N8IBCg5PumDM2S6Z9KcHY99Y5uJHKf22Umt5wOv2aDDXBXul18LZUWruv60nV7xQPM9/gXwDsblN4XTsYpY+511eTR7h3uhIXzQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB4568.namprd04.prod.outlook.com (2603:10b6:a03:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sat, 29 Feb
 2020 23:06:32 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 23:06:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/6] block: fix comment for blk_cloned_rq_check_limits
Thread-Topic: [PATCH 1/6] block: fix comment for blk_cloned_rq_check_limits
Thread-Index: AQHV7kiooKMYyZywCEaC5GI+K+ZGAg==
Date:   Sat, 29 Feb 2020 23:06:32 +0000
Message-ID: <BYAPR04MB57491D9E8F0F1C8623220A7B86E90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-2-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 128304ab-8d5e-4968-1ac0-08d7bd6c0475
x-ms-traffictypediagnostic: BYAPR04MB4568:
x-microsoft-antispam-prvs: <BYAPR04MB456877637977FB02811183EB86E90@BYAPR04MB4568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(189003)(199004)(52536014)(5660300002)(4744005)(66946007)(55016002)(53546011)(110136005)(8936002)(6506007)(316002)(478600001)(9686003)(86362001)(4326008)(186003)(71200400001)(81166006)(76116006)(33656002)(81156014)(66446008)(8676002)(66556008)(64756008)(66476007)(7696005)(2906002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4568;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ueKLGgg820ZJL5Zspu6ven4cUa65Fbf9unLl19ETewO4FS+w0W+Gpgmx92KIf0alZ+uQvJ/oxWaLnGX5j92cum5FzGB+h5mh8D58uFrBGLQZpKzezzgG2MpDr/j9A2z60BjRxtsDWJJDPYSdOpRC1KmZmKSVlKX2yYIcMy2WvMIw//ztdo/p1mG5svJ8FOrGLXnymetoE0FcNDz3PDVlTYGdlbzhAhb1KRmnmeAEIYDRRuYxEVzijVCG4WuHzyPsQQvR+XuH+cVAl6AV/lySOcEiiOrwCaAmP5hZHp3ilNMilpPZchcMweKo0db8VyRcMKutfyBKHF0P/zR1yxyDbUs6kOeZl2XqleYD/PN/7cjsSLrU+SMdoXQT58tIvt5caMRhkAQgz3jfoDIF2leQLOWChaMq8TjNgU7rv3WlMDuYbqvjGDmOYyYIuopJFeqr
x-ms-exchange-antispam-messagedata: 1FwPxk5xk/3DBhWIhuCTf2FDWquUd5I2dFyNsFm17CzOAZhjXaZ0ROa+WMV/r/VsxMaTJjtkAtgZ9ct8bz4sJCJIFgcaZjDO73j0FyNV6l65B5GbpsLNWTllDm2HToQa8yRBEhnJ7EJjbe4IWLaSLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128304ab-8d5e-4968-1ac0-08d7bd6c0475
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:06:32.3506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs20R0IhbiIPSVRDztr9BNQsUNcO5ManplVDD/vaZHKI2SjCMPwsFLgT+ZIdJXLzYiKElP4eVB3YeHXDmKeDPqQxAKS7t3qgkqwtX3zlEDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4568
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
On 02/28/2020 07:06 AM, Guoqing Jiang wrote:=0A=
> Since the later description mentioned "checked against the new queue=0A=
> limits", so make the change to avoid confusion.=0A=
>=0A=
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=0A=
> ---=0A=
>   block/blk-core.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 089e890ab208..fd43266029be 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1203,7 +1203,7 @@ EXPORT_SYMBOL(submit_bio);=0A=
>=0A=
>   /**=0A=
>    * blk_cloned_rq_check_limits - Helper function to check a cloned reque=
st=0A=
> - *                              for new the queue limits=0A=
> + *                              for the new queue limits=0A=
>    * @q:  the queue=0A=
>    * @rq: the request being checked=0A=
>    *=0A=
>=0A=
=0A=
