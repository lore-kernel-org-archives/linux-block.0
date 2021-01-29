Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCCCC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C8864DDB
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhA2AHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:07:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25238 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhA2AHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 19:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611878842; x=1643414842;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dJBBv8qht9j78cy/eT5YeEWW3mqCSw6yUSTJRAtiFzA=;
  b=KHPoYKiCfYkH50HB3QvF83cfqAss/C2ww15QdqWMlpsFauavMwiah/Us
   J3DzwOklIZ0Si/2u5gSIwgzO/B0JPaBTfYYJBsAh4NG58UwYvnj8ib86u
   cSfdNLksP5Pm2kpRZLWKMgPL/QUqoijKtVjxwKCSRTnN5s0C2OR+AxI+Q
   N0aGln9DNR19UikBAJv76ME4RafsP7y9p4CILAsGErpDxhpt92WjtSmC8
   0DBcXHfZ43HCFahPDsScS8+2cFywpiwegy5KuU8uJrFkf8hlVufFNT4y8
   BVYlSRjIL40ULevdBbDnQP4/tXkkOQTCfOI/b1FOL4LbI/aamO4LapgKo
   A==;
IronPort-SDR: sFf1cpx8p07cBnv+ycoYGurMmp9+csho76OdqLb99iPLVDEMzGxkYiFew/N/SgEYLxrjTx50u0
 XCdeFv/4X2Nx/PO75QbROlUBvqRiLArw5kJgBtYufMGCQyWUEun3Fm5jhtYNIypRU/L8Xq8F7q
 oDk49M5DjVDc1IaC2hXSdArIsTVrdj+p58z80njXZSohyu1SC0euiLoW6h/MuDtaRbvc53KHDd
 sNvq/iyHKf6558AcAPqTMwl2YyJigE4dBgOlW5LCsCgADisjAb+y9l6SItIRDr/V7vSC7hlHjV
 H4k=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="159765285"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 08:06:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK/q640xh8gq4+lBhGALpszBNe8K+AGm+ODDpu7lDgoCzx6La3nFrPvQnFQVIWw2siicHdhc8DDxcPCm470vp8wZfHdM9abbr/0yBByir5IBU5/zKJaqlAr6+FkaLQrzlYSleX8fW1cWcvWCUmi9dODKTXyyRic3a2UkQHbgfEZkAvyHvfDcR6w8x6+phmPcckBgzPGQgPfqFmJXsIQr12J691mH59U2ShpoAh8JqtqmpATxoROikVl4tdOvseSVBJQdB2jB/wKFPpiT7TTl8XwhaXPhalxpWwxiZkTinydyRweShmraoZi1jjw0JL9YggDvrPent3G599fzzP3Ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX4OQxvqainc6oMJ1OEGUheXAkrhYaBUb7RdSHB6Aac=;
 b=mISR+QGxOnbcFTykL74mhZm0w/tlnQN3f1UZE3zdQDGFiFhUm7DyCbzqlG9ZhM9pWRHaQpyoG9B5Yx7qxO7W74GhzLLCzL9wSaTY9uZJMaNxx0cbh8M9GC8OgmU79R7FlxmfavYeeNNzTxizRgHow6wDUV12DHOCL1Hug2ILbllc1cl8BYJqeCaHE0gGPIReZS02Ri3hvpwqY8Klnt0oRQZaeuKorP/+sp2Ep+yfcKsouZn/GCXwBZYH5oZZ0o71whiUvaeEX9NxxMc72cSR+ru8oviuWKNVXNnva1qTw8FJYJtdGKXBAA8cGWG9VEZreyzgvfV6S1ZQwimVV3sIew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zX4OQxvqainc6oMJ1OEGUheXAkrhYaBUb7RdSHB6Aac=;
 b=GI3Qr6deexsZwAIbNeAr8rRzIW0jtQEHrIvIYutV1IkOVV3XFblnUDFymmcQPYXfs8l+khgZZrry+m2NHbkEkvJ1oNs4MzHSjMQ6oV3wjrehJih8RZzaGrziv0AxUS6FNLLZLBfYCTCqyU6DFnSlA/AW8DySCUNP3mUGxcg767I=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6484.namprd04.prod.outlook.com (2603:10b6:208:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 00:06:14 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 00:06:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Topic: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Index: AQHW6JWhTDBaNFwpekOwBKcgOK9iWw==
Date:   Fri, 29 Jan 2021 00:06:14 +0000
Message-ID: <BL0PR04MB6514FF2CF7ADF9B400865C4BE7B99@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112034453.1220131-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7e23bbc-261b-42e2-a9b2-08d8c3e9b183
x-ms-traffictypediagnostic: BL0PR04MB6484:
x-microsoft-antispam-prvs: <BL0PR04MB64846A57A0C78705DE46EAA9E7B99@BL0PR04MB6484.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2mFPBcKrWbuOsljFxBV0052YiOLX7n/VMhiox92a6cXPXJtrvh7Mhm06m2UxLjbSCaz4KHKwetGft0EzEDujXcCvk4edhH8Y7nvGBfaBz0ueYZutVhdOi2WY0+TUo3k3V+MLI/HI4ZvEflyyVrkxQdVMzx0+lq4/qK6p+1WQVbzLbf1WFThDVrnQHPTtMH1tZhpKt70lDMmfM9kQo5rvpa6Ti8q7GtN4xnFxcnvxqL0oKgAkd1/qCGo2mmC8vkw45F7oRlMejPrziBNFBEzAquwKG9wFT2qMzkvbYteFsaRLvHPEFqET0nLqQWYlyNeLXP6FaGoiIl771UiEYO9DrOtKQ5cL+iKMjdy9Pz0qkJDmjPMW186251ae38cWWw94u6RFetMXewsAW2IEvP1Q8kgp4310WVfCejzBeqKIHS/ULyektobeh89x+LnE3DcbL4hw4rKWREkELD6u6YbCJoPaPTVvVl5olsSB1oPC7JHfV+hCoPbB1Qtr+j6U7CdQ6JMLkRWyriuaIWahoQDHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(110136005)(9686003)(55016002)(2906002)(316002)(5660300002)(6506007)(7696005)(86362001)(52536014)(186003)(8676002)(33656002)(91956017)(478600001)(66556008)(66946007)(66446008)(83380400001)(64756008)(71200400001)(76116006)(66476007)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UPHk3zl77mVCoPzmcKFMm/zJR5L/z3tioX4mWl3QycOL7eofSwh98fagR+J4?=
 =?us-ascii?Q?pLGTBinSU8cCIgZ92QuBx2qytpdmlsJA2HujyV8y/RLDWkCNh7/aikBWp75A?=
 =?us-ascii?Q?nRO73vicQ/rklyhF1DOrN+XyFDIJgVNuEXDwYsuNfMml094MLtGT7aBEnLI5?=
 =?us-ascii?Q?ZONndHZefzvwtCXnN8ZZuM5FIauColJ2cpg2lVfur6luk36zb3osDSbZYb5c?=
 =?us-ascii?Q?ePQuc8yS75axD0M63PUmy0JbGo2IQDSnL9iC+kTS2bFubcUFzI+K3vkRksQW?=
 =?us-ascii?Q?V6MZvv5qvq3aVLB+ZaS6mFtEls2WZHBPNyLUIcl0tNhBrkoHeLFXsgKBrhML?=
 =?us-ascii?Q?JLWtSBvB67pcQm/Q/CftPDvWt1F6oKa/nvgL4i/5cqLtrKuNquEzF3GrkYYe?=
 =?us-ascii?Q?dIGTxJok1nRtmONPPRdJ3bNIeST3453lPcQLCIv/Pzd+fF43zRXrTICmzc/n?=
 =?us-ascii?Q?BOrVSHjtEyMZ+hPjITqnUnqppgyjGdOdx8qdMmpP6WkVFYB2RkJUQS8G/F9p?=
 =?us-ascii?Q?J+7b+5eCBetwNOgCcOxiaeZ3IX4EOURzov/kvP02PCrK1qhqAUFIRIE/Uzjv?=
 =?us-ascii?Q?B5HWRMb7wk+vnYZ48Ac33Rc+8H18HmpkL6zttziz+/MmdNL4gwpN9K8XpDQy?=
 =?us-ascii?Q?7CeXkoWJLDf/cbob/7EXvet6OJZjnoBEo8GnYOYyXTXyXclNz9PD9+EJz2D5?=
 =?us-ascii?Q?srFxgBsEJtPqu3F/r/P56LZmFenynSOM2BD2xv/JzWlOZPIkBmvrhb9nXFB2?=
 =?us-ascii?Q?ez6YoRqt4H5lZujJ+7XQHUU8Ep2PJw7Lgzlt1qe0c2jgLPMosFW6ZmRMWx7g?=
 =?us-ascii?Q?DEloWPAC9BvbTwAuqpa+a/2etjjXMm8vbPCA27zTjCKuugi5aVj1MwAd1BhY?=
 =?us-ascii?Q?umCT5kuCFu3ArdQ77BS4siYsQ8gx8otG0EeD+rFwNY6nT89j9KDxH0M5ckHe?=
 =?us-ascii?Q?2AH1SQw62phfkU0uAmi7oqIvpgdBzkVtyg+5KJMxJq3rhloC3oO/+Hjy8WIc?=
 =?us-ascii?Q?VOVbYqshePMLPoOOYXqRwXICAMr4EcCXUEITKZrNuE7agLMyquBz0/WUmON9?=
 =?us-ascii?Q?+Aj0jVd1VebT7h5Op03tPz34qe5kipy4XAPY0J+MtvmhBHOuS3KlETBulPIh?=
 =?us-ascii?Q?haX3AKOtxsTsX/F4Yt2hUCZukhIC80QEtA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e23bbc-261b-42e2-a9b2-08d8c3e9b183
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:06:14.5095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VnPiPbzgA9EeFV6i2EmnC/t0SZ1uFomQMQaXnQjOFeRVBeDaNIB2ZYUChnrpOjOnWSiC7+OlyWu0waTpdgHiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6484
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 12:47, Damien Le Moal wrote:=0A=
> To avoid potential compilation problems, replaced the badly written=0A=
> MB_TO_SECTS macro (missing parenthesis around the argument use) with=0A=
> the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()=0A=
> to calculate the total number of zones of a zoned device, simplifying=0A=
> the code.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  drivers/block/null_blk/zoned.c | 15 ++++++++-------=0A=
>  1 file changed, 8 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zone=
d.c=0A=
> index 148b871f263b..535351570bb2 100644=0A=
> --- a/drivers/block/null_blk/zoned.c=0A=
> +++ b/drivers/block/null_blk/zoned.c=0A=
> @@ -6,7 +6,10 @@=0A=
>  #define CREATE_TRACE_POINTS=0A=
>  #include "trace.h"=0A=
>  =0A=
> -#define MB_TO_SECTS(mb) (((sector_t)mb * SZ_1M) >> SECTOR_SHIFT)=0A=
> +static inline sector_t mb_to_sects(unsigned long mb)=0A=
> +{=0A=
> +	return ((sector_t)mb * SZ_1M) >> SECTOR_SHIFT;=0A=
> +}=0A=
>  =0A=
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector=
_t sect)=0A=
>  {=0A=
> @@ -77,12 +80,10 @@ int null_init_zoned_dev(struct nullb_device *dev, str=
uct request_queue *q)=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
>  =0A=
> -	zone_capacity_sects =3D MB_TO_SECTS(dev->zone_capacity);=0A=
> -	dev_capacity_sects =3D MB_TO_SECTS(dev->size);=0A=
> -	dev->zone_size_sects =3D MB_TO_SECTS(dev->zone_size);=0A=
> -	dev->nr_zones =3D dev_capacity_sects >> ilog2(dev->zone_size_sects);=0A=
> -	if (dev_capacity_sects & (dev->zone_size_sects - 1))=0A=
> -		dev->nr_zones++;=0A=
> +	zone_capacity_sects =3D mb_to_sects(dev->zone_capacity);=0A=
> +	dev_capacity_sects =3D mb_to_sects(dev->size);=0A=
> +	dev->zone_size_sects =3D mb_to_sects(dev->zone_size);=0A=
> +	dev->nr_zones =3D DIV_ROUND_UP(dev_capacity_sects, dev->zone_size_sects=
);=0A=
>  =0A=
>  	dev->zones =3D kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),=
=0A=
>  				    GFP_KERNEL | __GFP_ZERO);=0A=
> =0A=
=0A=
Jens,=0A=
=0A=
Looks like this one has fallen through the cracks...=0A=
Could ypu pick it up please ?=0A=
Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
