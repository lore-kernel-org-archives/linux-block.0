Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EECEC34031
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4809B24654
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 01:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bOMe4+ku";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ssz/MPD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBSB6s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:58:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56331 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgBSB6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 20:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582077528; x=1613613528;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Du/vgAxQnrg/7fOYhkUcufbgXgiBSEnrPsstJDUdg2s=;
  b=bOMe4+kuhxhoY86nIIn6vmSLiXD826rRGRMvjcOLX8OC4/PTz9VWT5vd
   4yd9a/c91Wfd96ImHgQiLtX5ci8aHF8QZ69m4dDmJhqmUQBKcgSHpBYTj
   CUUKlJNbd7W42TT65BcnHHVGJpoaNWdJ1Tl8f7RRcfEJyVmmvfJBrr5l/
   gZMXWHDOVAQYNAZpR3T3K5Tl8Wqnar0P8kJLqswaL6ItWGk/PvmOr5GKj
   m2BnYVlCzzl2Ucusv8BBzC2qOIqTh5BsSSD4g4ehFMtrxX8vug/JXXAr+
   D08zfK4ab0zl5xQRxpjv2rnl1kRGmN+FLSpWPvlLGF1Lcu9ZqU+2nOyc+
   g==;
IronPort-SDR: iq+SaOd9rzwY+It76/Qur5dw4DbqiyTKoFiQc503I1Pjza5S4KhxEKipwE7rgjMX/8PPFo1+zb
 uhVUgcL8CoWo9hLVjcnIGGVGXKSM9AuZ1ebtGjienH5GGHPrf+18M8wiUEfQqsVKp+DtB7099P
 fdd1/jlcn++iMqro7Q+UEufrZBmQ+Q68LCWx1IiqqOGr0RTdfB3Q5ymKzl3SqgwF0/T2AbWueo
 AE1viYlESjRzlnLMFziVE80TRO2ITAe8zIokFpu8LgvjklZRoo1P5pcUxYZg2kXwHuQ1i6gYZE
 QUQ=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; 
   d="scan'208";a="130673048"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 09:58:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcG9SE52BfZj+sUwTSfnLrqM38LFj2Ni9eVLTfd5/RWJNo6subsLGUBzKPnC9gWwZwkQZiUArcBAels/FQvns1mqU5JFGiyVvGRjDTw0QVLqGIgeqfTR7TyMgD5aUMof0GZ1PkGTJJ0ZnNrZILv18jT+H3nFFXETdujpglJ2+22cO+4NB9B5akrKQjby+UlmTyBZ95j/vijTHpceAzJwO30CAmwtzvbTQjtVhg7tc0oYEq13dCShn/cXBQ8wHLn/6GgHaAbRLCXuFS0uDTDIT11HUZDtkc5lIjSwQpEluHM6S6u/Dg/1qpeIOySttVUR5NALsgFgxTgyA3JKT6TG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV+tpcCZZKPAuKeWcZfx72vxZaYkltWFBowKQRYvEJ0=;
 b=i0PJCKZcjHV0w7Uf3vWHRhqTk+G6kE0nk0KEhD+TGf9tTL7UEkkG4pNtcWA1qPNbZgNOXkIaNBZJXIlcjFOR7MGtDWJN6j5W+kU0OGtRvMFYhGpiKZaaTNuKBQnOsnAmiiFnij9fMxzUlJE04ucun314qL18Tuo2OpCVnzJFX7e9RG9aW4EcT8ljR0hKazdnlPEhrWgv0TYJHxNr6LYX6xBVzsGq14h6ZTuNoh4tv+wVfjqy9X1Rk0hce/EhIjRf73hKvaZzL0N+MsZWXEoIAwDC30o1ShkAhd604aPCnE65BZgZG1PPZC4Vij/k3Yo6pl/+rk3NRWV6fADdqE9JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV+tpcCZZKPAuKeWcZfx72vxZaYkltWFBowKQRYvEJ0=;
 b=ssz/MPD2hu/EM/Zm5ZTdcfK1EXBzr/2IPK9F/UKWZ/eaHR/ggyb8Krv5y8XjZyFWLaC9M6SRCiwO3+JctF10lx440W6In0yINdFefGDVsADI/nsoNpFnAcoj+eLzabCQ1huMAl/GBClArnXqmJ7bClJW86JrjTdpzJZNRGY0eMQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB6072.namprd04.prod.outlook.com (20.178.197.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 01:58:45 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 01:58:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH V2 1/3] block: add a zone condition debug helper
Thread-Index: AQHV5oDoYz+JRPRCgUubcBCM9eci/g==
Date:   Wed, 19 Feb 2020 01:58:45 +0000
Message-ID: <BYAPR04MB581681E76D092E8444BC5A91E7100@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
 <20200218172840.4097-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ed6c6ae-122c-493b-4707-08d7b4df40db
x-ms-traffictypediagnostic: BYAPR04MB6072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6072201369648D1008D2B577E7100@BYAPR04MB6072.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(9686003)(7696005)(55016002)(478600001)(4326008)(8676002)(5660300002)(8936002)(33656002)(2906002)(86362001)(91956017)(76116006)(66556008)(66446008)(66476007)(64756008)(66946007)(186003)(52536014)(6506007)(53546011)(81156014)(26005)(81166006)(316002)(110136005)(71200400001)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6072;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4vLTRMBVgL50fXV0JHNiaJoa6tyVEMw5VpxVrB7/pYs8mw4VKGJDxkT/P6lTVir7HEyAsu+5nxcbCgTVqAsh0EREz+W3vzklMqRQ0yXgl8CHWjkT92LJHoFZeKKTb1k9UOdJH5UAclJZitKQB1qUoN7byVIGH1Jv0WpIjr87eZILjXEAnIJuB3SEAPXizrfiwEmMmpFSPHef1x03GC1DlUCg0OU2vBYtF7NHeCrycsdeb9TyJ9ghyY19k6yeplq5GmV/5JZhsLNvCtyArT3QcVvGZy8NNroZjYswpzv4dlTP9c3YSTITkR6XdwydwH/Cs9AEcUX8FPoDs/Bq42kDtbGwnjh/pXmKA92xojCKOw9Wa1ggSGHD0+h23h7yT5KsRuHaNMBzJHGezWdrzKUYEdVv0i6Ygp4c4gJDGyLfuNdWued8lXhoaR9loHdKvqKYB3bNrQGNEYpuMDGCwpArXFmlHhMXp7VmQtlevDJc7ga7Akth+rOPpTOmQp8k+Rg
x-ms-exchange-antispam-messagedata: NxlFkAg/ZL/8twKb+fmp9rA8DnR+/j2JAedJnCew86fejZpmZPShMQQfGOiVc/eaZ1HlIRQ4xw6D4MlqNsLYhYbN7BvaSM1HRxLH8so3HiVdRkcyaSeDGPsrfmUiRwSuZ6DiQ7sNs4b/dn11z+qv6Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed6c6ae-122c-493b-4707-08d7b4df40db
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 01:58:45.4214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfa4N8eFpiUieNdr5rjRAG974SbsLedY+uLXFnZ6OeXKYT4eurG27v+IK7c6RKP+WxEaWaGypk+Vpd2GUs44Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/19 2:29, Chaitanya Kulkarni wrote:=0A=
> Add a helper to stringify the zone conditions. We use this helper in the=
=0A=
> next patch to track zone conditions in tracepoints.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
> Changes from V1 : -=0A=
> =0A=
> 1. Move blk_zone_cond_str() to blk-zoned.c.=0A=
> 2. Mark zone_cond_namd array static.=0A=
> 3. Remove BLK_ZONE_COND_LAST.=0A=
> 4. Get rid of inline prefix for blk_zone_cond_str().=0A=
> ---=0A=
>  block/blk-zoned.c      | 32 ++++++++++++++++++++++++++++++++=0A=
>  include/linux/blkdev.h | 10 ++++++++++=0A=
>  2 files changed, 42 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 05741c6f618b..f18f1ee9d71f 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -20,6 +20,38 @@=0A=
>  =0A=
>  #include "blk.h"=0A=
>  =0A=
> +#define ZONE_COND_NAME(name) [BLK_ZONE_COND_##name] =3D #name=0A=
> +static const char *const zone_cond_name[] =3D {=0A=
> +	ZONE_COND_NAME(NOT_WP),=0A=
> +	ZONE_COND_NAME(EMPTY),=0A=
> +	ZONE_COND_NAME(IMP_OPEN),=0A=
> +	ZONE_COND_NAME(EXP_OPEN),=0A=
> +	ZONE_COND_NAME(CLOSED),=0A=
> +	ZONE_COND_NAME(READONLY),=0A=
> +	ZONE_COND_NAME(FULL),=0A=
> +	ZONE_COND_NAME(OFFLINE),=0A=
> +};=0A=
> +#undef ZONE_COND_NAME=0A=
> +=0A=
> +/**=0A=
> + * blk_zone_cond_str - Return string XXX in BLK_ZONE_COND_XXX.=0A=
> + * @zone_cond: BLK_ZONE_COND_XXX.=0A=
> + *=0A=
> + * Description: Centralize block layer function to convert BLK_ZONE_COND=
_XXX=0A=
> + * into string format. Useful in the debugging and tracing zone conditio=
ns. For=0A=
> + * invalid BLK_ZONE_COND_XXX it returns string "UNKNOWN".=0A=
> + */=0A=
> +const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)=0A=
> +{=0A=
> +	static const char *zone_cond_str =3D "UNKNOWN";=0A=
> +=0A=
> +	if (zone_cond < ARRAY_SIZE(zone_cond_name) && zone_cond_name[zone_cond]=
)=0A=
> +		zone_cond_str =3D zone_cond_name[zone_cond];=0A=
> +=0A=
> +	return zone_cond_str;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(blk_zone_cond_str);=0A=
> +=0A=
>  static inline sector_t blk_zone_start(struct request_queue *q,=0A=
>  				      sector_t sector)=0A=
>  {=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 053ea4b51988..a40a3a27bfbc 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -887,6 +887,16 @@ extern void blk_execute_rq_nowait(struct request_que=
ue *, struct gendisk *,=0A=
>  /* Helper to convert REQ_OP_XXX to its string format XXX */=0A=
>  extern const char *blk_op_str(unsigned int op);=0A=
>  =0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
> +extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
> +#else=0A=
> +static const char *blk_zone_cond_str(unsigned int zone_cond)=0A=
> +{=0A=
> +	return "NOT SUPPORTED";=0A=
> +}=0A=
=0A=
why not inline ? That compiles ? Please check builds with=0A=
CONFIG_BLK_DEV_ZONED disabled.=0A=
=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
> +=0A=
>  int blk_status_to_errno(blk_status_t status);=0A=
>  blk_status_t errno_to_blk_status(int errno);=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
