Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDA8C54FD5
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97D82076E
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QV9nJBT8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zENC6Af7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCYD1O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:27:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:13870 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYD1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 23:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585106832; x=1616642832;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wKqIYgY1V8eG20nG9dLDCPVoe1Ld5yqAHqzNkZvFmIo=;
  b=QV9nJBT87cMM8nqZcT1dJXZWcMjEMAEiQXqgMq0KQYtMpUj7oBxDjl3h
   W09O4RDrpioztx2oiJY9EpY1F2x874pIao0xsJ3gvhbtpJeVgmHezwAD1
   IdG8wCH/YfoNCVAxaE0v6/iA4y5dAxT+7PjUrbtDO7QZIOTwWYROY3COF
   8k7eG7y6wJSUJTebNPPY8DEqImjUiP6qUbTSA6V9VniSfBwnIfFlK/hmC
   sg4HnfleYOFeF2Fc12tYzin+I/y+AHqNAS2CiEOOhGFioITjeB164UAl7
   ZfM4yg3fHTKp4SV3V4HsYUmolYRckXCz3i3MFSlK/h2VN0SvCxVXi/OJV
   g==;
IronPort-SDR: zu+S0tS/gZzt3TTFPqVtfmUv8YHly+G6BznUZCFFbRED2setEckzLNmRrsoI6cGpn86RqP8uiC
 PyaDnBZUt2jqeHTS/EQHxSO/dcealhgYc0dWXkTEWQMM72FnVE3XQaVa3zBcOgpZRVxDyRvlup
 R9HpHs/XlOIMuzPPXSAL1Gx6+4N4mB3O0/xh3Y/RwK+aV7B9c3hZSmveK9oHOgw6TBVIH9HMWB
 CAgVNYC1YgXLqrKM5n6+uzut+qb4P4U+NOtKoUBzNcCvoQG/ifqIgZOA5AMyH8rhaONtowvE38
 Thg=
X-IronPort-AV: E=Sophos;i="5.72,302,1580745600"; 
   d="scan'208";a="133862623"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 11:27:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkHJQn0PWOAFI94Y6t/KvIhRrGZB0X5DA5mDVWijn8Zc1hjcGzAZyPn6ZQcsr9YGoh9fKfNusejBNmKqQcuc0vz8LGyQr51zIht1ugFqY1JaElA/dwx5qQUw3lRGf2LxxH25sFQDOBAVGn6UwC1586U2QU2d1V2RAj0FePafuSTFu8eCPTcLDaxvf87TXwXKY7YbFrtsJJh26bvxvTdHPkG2gz7ui1AH0GcQq+UwGN+K8ywHhFSFJruVT6GFTh6tez6KGT1imBFMvgVLQueiJsRjJ9h5fw4pimaJuGlDrgTG11hY3snGt5Uz8HrbrpRpHksje/Vgs9ek3ap/VDiJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhITKfRsJnLDSz/S9u981SbptbRgumZV50Jmv1ht8YE=;
 b=cDGCZKWireocm4cmUILg7yFh6qL38GVEjPNx5qQxvI/zR3asZpCbC6ojjCq8yYUFrE4nSyA1fyQgnAkc9aLQS2LG7UnRN0rZGXey+aXAnbtzfkPdfU9I+XcXqqOqevju1JZFjieeujYxktMd2sC0dqg4awg34YfCT3yaIxaRPyaEC6owm3m0MmfOPyYlS4Zm9HU/eL1qqFT6CEwGNyeK0nmpc8KewcyN7IKwsns27nWmpyhSvHh+Adv0pICEpv/0KkWKj5Vn8tJjYEyoni2R4rkD6kMfTpcAWNsrQAR61pzZosBoYbzhEoXC3vr4qqv6YL7ElEvGCZhroAgkWm6ewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhITKfRsJnLDSz/S9u981SbptbRgumZV50Jmv1ht8YE=;
 b=zENC6Af7oC395VmcdogUqvm8hFlpvCA1FJbEmqhn6hcq/3uH+AKoHSk/CgiZilUXVcM0A6m9hXv0nxNWhVXi6XIibjYpzjhovl2bDu6ZBzvdwrh+Xv7bzefy4eXH3y+tjfnzjtdOB/Xj4mKUH4HTZKAx0sz8W5qGnHGYJydjHqA=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2136.namprd04.prod.outlook.com (2603:10b6:102:11::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 03:27:09 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 03:27:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Index: AQHWAlSDtDC4ZWOwBEmfbD5R0f0WZQ==
Date:   Wed, 25 Mar 2020 03:27:09 +0000
Message-ID: <CO2PR04MB2343C3B9DF774E6A6F052EC0E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <20200325021629.15103-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48e9ac9c-757e-4fc8-1d0d-08d7d06c66f5
x-ms-traffictypediagnostic: CO2PR04MB2136:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB21362F0359587408AD0E0D85E7CE0@CO2PR04MB2136.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(71200400001)(33656002)(8936002)(9686003)(91956017)(66476007)(4326008)(66556008)(66946007)(66446008)(55016002)(186003)(76116006)(86362001)(64756008)(52536014)(110136005)(2906002)(26005)(7696005)(316002)(5660300002)(81156014)(478600001)(53546011)(81166006)(8676002)(6506007)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2136;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DCIZKZ0ylH2uSid9tGVq6VmAoW5Chs4DB2NXrdXBg7HK77/0qCjhyuwpuJG3br2Pt/fQT0jyaSPU4t3VFV80ztB+67esp1e8hVHTYZGQJ5GDA0t/sw+ABd2oX+o2b3f6/KNfWLh94KOoGyLA+R8HSN2GIHJomSUYSPcMmzU98tEzD62NnsxNAhE+jzFsEgTIi/JlX9eg77nyVei/VUYRga4a8P0MFjrYKs/hog0fdc01+W+iUft7zefl84tekgufuVHKdwAaiwpI5UWEsJ5YSmNVA00JqEepN1kb1pZWVfGUMGfHbbcMQW9xRxA6TtNQSws875jhJEj1J7Z3peVxV4K2wPDs0Dc5yl+IGutMzW96G9Swt/8ZFT9ttig141kGb1Ki4Cek0oJ8klkMFHu19VhXfz6Ts+qo2DlEtqCim7iqhyFEP/eWupTGmT5puOl2+/qFitKAOrUctoNAIhqAAIkkAgv8FYakOnClF8rtvga0i30zagiMIgVwpLspXj3+
x-ms-exchange-antispam-messagedata: EPrLWtRZNrBMtNcrYmExjZehmyUva1iMFHcBft9Jls/l/c0NcyApgsFIuyJKQlf1TuZ6IsRfOUX0D7STMyJTEMqBpPxKrANUzKDlKlU5tj44uCTidwWaYfSoX01odJLnmo6gzdHlJjvbyERhFl/ofg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e9ac9c-757e-4fc8-1d0d-08d7d06c66f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 03:27:09.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsEv6Xz3CjHmIzc/G7SjBvMiJEH7yn4B0WZlbl7KSpdNBwyVH0/9tasDdizBZ+Big6d8p60jjSElsZhA3fc0vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2136
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 12:21, Chaitanya Kulkarni wrote:=0A=
> Add a helper to stringify the zone conditions. We use this helper in the=
=0A=
> next patch to track zone conditions in tracepoints.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c      | 32 ++++++++++++++++++++++++++++++++=0A=
>  include/linux/blkdev.h |  3 +++=0A=
>  2 files changed, 35 insertions(+)=0A=
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
> index 53a1325efbc3..0070f26b9579 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -887,6 +887,9 @@ extern void blk_execute_rq_nowait(struct request_queu=
e *, struct gendisk *,=0A=
>  /* Helper to convert REQ_OP_XXX to its string format XXX */=0A=
>  extern const char *blk_op_str(unsigned int op);=0A=
>  =0A=
> +/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
> +extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
> +=0A=
=0A=
I do not think that the extern is needed here. And I think that this declar=
ation=0A=
should go under #ifdef CONFIG_BLK_DEV_ZONED since its code is compiled only=
 if=0A=
that config option is enabled.=0A=
=0A=
>  int blk_status_to_errno(blk_status_t status);=0A=
>  blk_status_t errno_to_blk_status(int errno);=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
