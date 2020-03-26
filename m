Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B62C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 01:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A87B20737
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 01:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U8uGYL0N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PCzbO9XZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCZB0W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:26:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30941 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZB0W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 21:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585186057; x=1616722057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QYwxz5L6OV5yZE1dtpR40SpOkRMMzDpKW1/QmxMuboA=;
  b=U8uGYL0NoZl8oZ8Moq1lhdtk8bnsLK/oRYryhdm5MuFIQBv9GIej9eKs
   et5TVc6RIWD2KEv8HKI+/c2Xx2BqH0ZAYCydSxMCDMjPRaeC8Rx4klyIQ
   S9yDvDsZwX5bruhK1HCnAIAlvznw+WYjNnnj0HvhKDb+5fAsa+wh+BGLi
   PAQOOvZB1c35WTXCiv+gM+4WgGhsxo/o1xfkIcYZY52aWdSbH9wYdeI/A
   JFzkAIt9xxPosrwUP//LGXfBR0WU7LHrihYVji6RhRMqMtGc2YaRJZwIv
   aI+HF6CbGJcorVl+PunSzwgEeGzEColDasFgrsDffcSYyJFkVyZVkUPYo
   A==;
IronPort-SDR: PdYKN+xmHIPYtxhhhg59CdQz0jw0X45itGeIEmzZAnnEbFlhtaQiZkniTkHYgYhivzY2SCt25W
 wVh2Ptsj7LTIqnNGRAav5cN36/rsN5b1Hqp+9YNneIBm/asD5eICHAicEYHWYkeMsJIjxSbl0r
 Ooej9foHGrnNCdwH9tSmk7QlNwiQc5GBRRiOuPLWuNURUcqnDq5xmQ5TK2MxFlmrPnnBiaCfkg
 w8kJ11Se+PzTBbKdZOcPIdMIwEQrEyefvuHCG+Fu9pAV7lhHCzqGfLA/W4eksiJfxl1MzqHcPZ
 czU=
X-IronPort-AV: E=Sophos;i="5.72,306,1580745600"; 
   d="scan'208";a="235746900"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 09:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdPJA5JUvvpr3vPXMn/ZUs0Q1x/ZjJ0+hSJzpifnMoE/4jNU8FgisULqdUoczfdr6X02mvSgLAzgQabwSLlY50yVIF2siT/a1zHVDmU97HfXYCoKg3hfY5JZKrxGeNjjrgqmnqUnjGvfUcVVhvcNg6ipQX4tJibglY0NPejEpm1bPh0snqepDt971oCTqz1OzACOyPowUhldWHhZrwD7nAsbHJz8ssahQb47YBYhBis+4HuqbWFZiVxs1c8y+sO0ZTbB6HbSPlE6YtCyJZdj9hllo5XAuc5wtFGMZGMiwTTaMnZLl16ki7aNi6SqzAXX3advTzwrji8J6lW1W7Q4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0JuSbSqsrpSozCd509bcef+Yb4OmNEd8r6hJ6Al1pY=;
 b=Ia92kiwpaucsKDQ13g0Kmk+eZVJRbd7P5992GOBlSIgo4skBrnJWm0B3gvU76Q5ffvdC9UFVsxCk4bt8qBNYIr6yai1FqO3fv0g9a1aGOn1wJODRe4Uu6H+nFyISpK0vLT4DYDVZCYCFTBok6L6tWCEBc96PvsVs03at42VlfwrSQ/w1mrvKmEJyWLVgkss8UsMd5fnIreXRfafzL4vFiy0otuuHplhXZN4v4l9BVfuW+8mkjlgrKYr3LF30zX02o/DRLz3y828n5LFdUDSx1EQnM6qLwcal3tSLrwBxwhZyBUldLJ54f4LyeGsTAWJEvrdKl0/EMWeiCVK7RqWVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0JuSbSqsrpSozCd509bcef+Yb4OmNEd8r6hJ6Al1pY=;
 b=PCzbO9XZQk98XkbMGUmHB8FPzX/75XLBIFBPYr5hg0mVJUCBUhkvUe+J3vc0esHRr0GXRkC1WqJOavNTBSDrmBkpEDIY1VvTDCrqIX7dVCMBkqLl4MtdIKwrPSY/2bd6cyzRMdT56Y3dfee6smtU328DLhXQflYXGZT71XShl+4=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2135.namprd04.prod.outlook.com (2603:10b6:102:b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 01:26:20 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 01:26:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V4 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH V4 1/3] block: add a zone condition debug helper
Thread-Index: AQHWAtbtZnBuIeoR+kqwS2Zms5Murg==
Date:   Thu, 26 Mar 2020 01:26:19 +0000
Message-ID: <CO2PR04MB2343E5FC3B67540DBDB27B6AE7CF0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325174956.16719-1-chaitanya.kulkarni@wdc.com>
 <20200325174956.16719-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96642763-0dff-4a48-b8d1-08d7d124b022
x-ms-traffictypediagnostic: CO2PR04MB2135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2135752A34893D9872650C2EE7CF0@CO2PR04MB2135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(186003)(33656002)(66556008)(76116006)(91956017)(52536014)(2906002)(64756008)(66476007)(66446008)(66946007)(9686003)(7696005)(8676002)(81156014)(26005)(53546011)(4326008)(55016002)(5660300002)(86362001)(110136005)(478600001)(71200400001)(8936002)(6506007)(81166006)(316002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2135;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9EQCtshuBdF2FahYaPWJyVKlYeW1H5JtvctFv1YryArtU8se+y5vQ1Vyjh7ERsSZppF+v92h758f/A+czmeLop+Q7Q01W64rStD/6O8hwzdL8Om8U68vrAL54KVEayux+rrh3+WU7pGtQ/TWkjFie/9afQCJcNTmpMTzdpQq2LWtkGegyq5WJbAWHgh04l1b3mv2jYWLBBzzDkYzpbRNJC2dTuyXRwpT8ykxl4C6IYZgBpfGhyAsYuhkddi9rfLjy8IuUQBs16W0FuxCMNss7rLS67SxwxkSrF9Cv8XUoqnNt0hYZcMfWPefZg33152pe6cjcolPzSU6E6nrdN0fJ6VZjk9uUd4G7XdeZ82mzDwu13I30JzPIUVih9jCfUEPeXXULGh0G2HhvKHi3AOOaOSwkzxIRWaaN+4bDJABmDxktoUPTSyZde2T8TcudlPYRSW1jpVISGRKdMZ1H3x/J/3RQGtmGIjcd5nKOLUKl0=
x-ms-exchange-antispam-messagedata: OBjAh/idD28zekxZBsRjPm34utgKSk+HdLa2daqL9hpgkxqwzBC+KE/kZLwXdko99DUveeL8KjP2sIJsoMG2sgSMUQH0WVUiijPIA5PpBK+G8hRlTJNheDWyVzA13xmVdcx4f1AInHM2uxqXUFfBiw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96642763-0dff-4a48-b8d1-08d7d124b022
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 01:26:19.8258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnSnO7LN+iEjXDtcu7scZS5dBFe84b8c1303/KkA+pOTamTrBKy5LZJqkYBRMjCghAxO+P5CNrQOPvtd88uqzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2135
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/26 3:55, Chaitanya Kulkarni wrote:=0A=
> Add a helper to stringify the zone conditions. We use this helper in the=
=0A=
> next patch to track zone conditions in tracepoints.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> ---=0A=
>  block/blk-zoned.c      | 32 ++++++++++++++++++++++++++++++++=0A=
>  include/linux/blkdev.h |  4 ++++=0A=
>  2 files changed, 36 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 6b442ae96499..f87956e0dcaf 100644=0A=
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
> index 53a1325efbc3..8ab1f4526f72 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -952,6 +952,10 @@ static inline unsigned int blk_rq_stats_sectors(cons=
t struct request *rq)=0A=
>  }=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
> +=0A=
> +/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
> +const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
> +=0A=
>  static inline unsigned int blk_rq_zone_no(struct request *rq)=0A=
>  {=0A=
>  	return blk_queue_zone_no(rq->q, blk_rq_pos(rq));=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
