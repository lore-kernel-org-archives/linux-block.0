Return-Path: <SRS0=uy3D=AZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B76C433E1
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DC720857
	for <linux-block@archiver.kernel.org>; Tue, 14 Jul 2020 07:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YB9btWOp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mywJToQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgGNHn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:43:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28419 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgGNHn2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jul 2020 03:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594712609; x=1626248609;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+B2nMG+XGedbaJjJ8Uryx4vDMOT2CnX74QbUv8sT1qc=;
  b=YB9btWOpiaqPaFwmgpCJmvVPOeU8/KAr14BPaR1SH47cZkBcoE9WJpPA
   iPHsHXfJ4ear0LGiN1Sbwy4zYJyVgRe7QHF+sYef8VR2I2oTPhYUFsYaK
   cVpGi1FdXpqyf7bb+0d7wcc6DvTVBYfV+uWZ4NP91noBXg+JqOGCCRm4j
   GPFvbmvqxGLahFePxdgrgaqpaPDFoh/ljgvveFdCoYGou36Gv6LGyE8pi
   EtYckjKIV+E7r7WeEdxQW1HvPKd08A+S8vUC4CPXbOmObvbPYwEFEadX9
   xNTNreYLvPQRmp9hN/lUU4wN+q9IEnxGjCQmlbY8HUJcUExIKL5LZF9DP
   g==;
IronPort-SDR: IuLY6E+/yAiOkpuQMU0Yj6SoDvZStNmAUMyB/4/pcHuaOfK4kmpyfIJ74XgfkAgK7GDcEfiVv4
 ycypkK3MerC3vD2zPZkbKJ3pHmwqHF9gfqzY1zpBLOmuNiC74UY9MsIw+ohRpA5ib+Mgr+7an/
 C5jAFEZB1KJ5muqHK2cmcimNWLHfQWxLJqGGME+/eueYJgwHExROLzCCVDaF/zpGUiLSL1H6Ow
 FooONJCLJA1OvxI4B9CvjjRSAlrNb1TDozdU/jwNyOFC98YECjSgnBBlzkelbmqypA4NvnYWkV
 NXI=
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="143704741"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 15:43:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qf5SW6G6T5IdP4e8WHJxu/xVBT1dueKuI37I85fQi+Uw0y4xayCkvuVb13SVhpr0HEKGNToV2TiHRFcYRoQwm6yaUcG+lXCaNQovSRAS3c4p25FpdZizYDf9d3pQvW8LVj5UK6nS9qv7bcnS0lJnF6+BLl0tYQtUGhn2migj2vLtINOTwFEVb1vlueJjxTSVJe5tpnzIobLDpbwuqA0oQuhrCdeTzVwrO3NZE5786fRUa+1L263EDg6BZQRywZEDXFmDYE0kStgmF7L5VPMCYE78yE3yLQTO4vSE4Y733H4XiphqilQbMx5gRRJliv1+H9DaXQmFYFAdFzWWhFR/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOr0jiLN9uQDf46y0BP/39yTVzJulKKs65XWG8gvFsg=;
 b=XwRUxYCXe96BnmBgBMh460iTMPAi8tdkEfuDGLqiCTASyn/oIAGo6yP9mgr31EBVsZa9FI0zimAJAygNUxKZFBdoj5VeCioN2aL4ultg8rQj/MtCek9c0n+kysuz4C2mjpxqLuAPYCOOu5FKGAAsW3I3tKNyJUjEWbY2bhi2OYaSzoShWGh8lrpEHEHy1NKnalu+LjvH0TeA7HSyyFnjheu94Mu1JkWLXLnFFHYuU+cswyiUBfsh4kReb8Q9Hv7GDj7aS8Fo8Fz0I5Sh080rA//yeS2lK0Md7PD/84LQfIIZf4bBreavp2AdnRxrMPctPWZ7VM3D/fNtE/a4p2lgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOr0jiLN9uQDf46y0BP/39yTVzJulKKs65XWG8gvFsg=;
 b=mywJToQVD87Du2n8MqLO+klox7x7ulvmEEgeTQVffrgBuYKwjOtCcsF4YuIhZ2USnmsOE9QBT/R/BgJPoGdh5mbYGgG+Gf0R6Hcenx3o4xf9INjMG85uP6yLMl84fVFEDpdiM3pR0nH9/KoX8ofbzipo2wzv11C2Pa91AZbGkKk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 07:43:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:43:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: Re: [PATCH RFC V2 1/4] block: add a statistic table for io latency
Thread-Topic: [PATCH RFC V2 1/4] block: add a statistic table for io latency
Thread-Index: AQHWWVqKVxbok0d+mU+ku6oJqz/pKw==
Date:   Tue, 14 Jul 2020 07:43:26 +0000
Message-ID: <SN4PR0401MB3598BB82CD8660B4A8ACBC479B610@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
 <20200713211321.21123-2-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:dc3b:feea:5e5f:2d30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2e5c8ae-feac-4ada-8b14-08d827c99856
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117C6EBD7C605641B1A91569B610@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bFAhcGCvnFsNfRtL0bNhTgDCO8IvRZwEB2nmqfgxAYr9JsbMBKddGlbMkTbxzXwv0KU3GCevpyxcKuseIz4wOEcNnmOMshEOAaQs87VpZZQP4MMyheVjZdGJwwljeEM+fQc49tE9z+36P4L8gQBaLV6mZLkVusTMkaDdpuBUY34Hr9JRynS9PW/NiFzDjIe1UcBMkjpydXAZPcVW2H1cmlYAKiainyCZhNAeLIx4pAwHUJCslkcMxrM6iFNy85Bt7WlYIEn74VZSfckTM/cqx8qTzPa6tqcTXiCgl0pBHa8+txLxb5uMeqxFBxKjLHC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(8676002)(76116006)(54906003)(86362001)(186003)(7696005)(2906002)(478600001)(6506007)(4326008)(55016002)(8936002)(71200400001)(91956017)(83380400001)(52536014)(33656002)(66946007)(9686003)(64756008)(66446008)(66476007)(316002)(5660300002)(110136005)(53546011)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YNZFq2I73o/lob5U+/1juY37+z0y5dDSuVAlovy1RLHfJC51fW34PsIuYdlfWONnn/PsufimNJ2nlfExPQIvUQ7VFPh7+1qFuyLsxAYC8kLcfePFrxFqxLTpI9mhOsczdJmueltaAsezMoxoZQkZ8fOJmzzX0XsKigx54aR4SNEBezud2LUKTDg4MFACBceO2hdXqrk7pz9gXueoQfARlhnWbdHgYurDh/gQM/ZxMlUpx4ybLf9S4fX0pXG4BrmGJUhs2fhowECOsRKr3lVNz4Kmyg1KgSUzkjJ5Swsao63bfH1uP4fQXKpS2+s/7XTi/ZRcUA5zqbBD13E/r4Ofa/JRefbiXCdmkUra4gx+3tEpnip8yhYuQxtZDZn4Bl0/H4KQUZ5XijrBbAhX7BikdbE/Nqebx7YIte5fvEqF8FgrVYGzwoatN8xiJkSK7ORnJkkBzj8NlG7Mbu/UnFWrosRnQw9As42bu8QbTLQQTy9TVHfQy3e7XZqE4igYrj6+bxKz2MB436W2shxXlGlHwZktgCwfflpVru0xxOXboVFbQCz8WTXlK0/dj9R/Isdt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e5c8ae-feac-4ada-8b14-08d827c99856
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 07:43:26.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjIC+kHt6OyI8dVfqa4t58QPwsxG73WSkk55+slEuxj0YfQgz7ZwuIImqpY7WMiPbi6p/rtCw74ZwyUUTPbNa+8YLaICDVMaXBYcWin53R8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/07/2020 23:14, Guoqing Jiang wrote:=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index d9d632639bd1..036eb04782de 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1411,6 +1411,34 @@ static void update_io_ticks(struct hd_struct *part=
, unsigned long now, bool end)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT=0A=
> +/*=0A=
> + * Either account additional stat for request if req is not NULL or acco=
unt for bio.=0A=
> + */=0A=
> +static void blk_additional_latency(struct hd_struct *part, const int sgr=
p,=0A=
> +				   struct request *req, unsigned long start_jiffies)=0A=
> +{=0A=
> +	unsigned int idx;=0A=
> +	unsigned long duration, now =3D READ_ONCE(jiffies);=0A=
> +=0A=
> +	if (req)=0A=
> +		duration =3D jiffies_to_nsecs(now) - req->start_time_ns;=0A=
> +	else=0A=
> +		duration =3D jiffies_to_nsecs(now - start_jiffies);=0A=
> +=0A=
> +	duration /=3D NSEC_PER_MSEC;=0A=
> +	duration /=3D HZ_TO_MSEC_NUM;=0A=
> +	if (likely(duration > 0)) {=0A=
> +		idx =3D ilog2(duration);=0A=
> +		if (idx > ADD_STAT_NUM - 1)=0A=
> +			idx =3D ADD_STAT_NUM - 1;=0A=
> +	} else=0A=
> +		idx =3D 0;=0A=
> +	part_stat_inc(part, latency_table[idx][sgrp]);=0A=
> +=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
>  static void blk_account_io_completion(struct request *req, unsigned int =
bytes)=0A=
>  {=0A=
>  	if (req->part && blk_do_io_stat(req)) {=0A=
> @@ -1440,6 +1468,9 @@ void blk_account_io_done(struct request *req, u64 n=
ow)=0A=
>  		part =3D req->part;=0A=
>  =0A=
>  		update_io_ticks(part, jiffies, true);=0A=
> +#ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT=0A=
> +		blk_additional_latency(part, sgrp, req, 0);=0A=
> +#endif=0A=
=0A=
Not commenting on the general idea here but only the code. The above introd=
uces quite a=0A=
lot of ifdefs in code. Please at least move the #ifdef CONFIG_BLK_ADDITIONA=
L_DISKSTAT=0A=
into the function body of blk_additional_latency() so you don't need any if=
defs at the=0A=
call sites.=0A=
