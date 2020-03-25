Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B6C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 05:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A183820719
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 05:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l5+2bxLr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uoki+fmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgCYFUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:20:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3379 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgCYFUE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 01:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585113605; x=1616649605;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UskEXDXhEVYnLS37w9npCgMfd9P8QOjkKQTWbE52mhc=;
  b=l5+2bxLreZaFe2xraojM6C4snQljCkye+RWrtPkIRZy/c3k5fJ027LNm
   azxj9+TV6/BdKf2ksSCeDEjoOePJJIZcEmmCTbS5/hCG4Ue1ziz5pwz/F
   pGVB9vixjKakuBOd/4tcjKyZslZiGzZ7kxfMTdlkF69IIm6HuO+3af1As
   x/pKCbhu0Eo+b9s60fRrKudhi0h8yU/ObS8mfNFscojM1yK8uhUJxCz0D
   fN4YNFl4oIqJA/fhxGwBie2YFaVkoqP4g0dB+iIdbzqf8IGlGb97Foi2X
   kdMbZqhHbvQRyCG17+mSCbxgQ0aTmYOM2TmVZdXa3Bugy8ZeKADAkBv53
   Q==;
IronPort-SDR: h5PhBFRGi8i39qV539/UwNoG68CdnEAaDzTQ9B6I1WbCLNFjMdds64ng4XZdBvPERNZKQ7lr+i
 yYrUTgLWFYvahRt/DU5ikL8Gc2yNS8rWDeQWIvpJn6beNC9P8crz/I6tVMiGbOFv8Gb9emwJGL
 EzOVjQEswqKGL+rExjB+Qh5Rm8r/30J8QcN/3Sz5EVqS7dZJvxJ0DRvDMPL0LDGPodShy5WYln
 hrmi2y83GRVZPSamM/kCWv5XLwjJlkTzdmU5ew1Sbbuta0+lILbzbAkdcXAKHm8M/seJE0oliO
 vAQ=
X-IronPort-AV: E=Sophos;i="5.72,303,1580745600"; 
   d="scan'208";a="134888582"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 13:20:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA/cPhZbFsBXyNJI2Ii2qX8AIj67l88VMu8x0f4jNfT2kb9I1e4amdbWZ3CyyS7XPUKXCOEBe3v55/9g6VWJ7sTOu1tX+iKwJ0lRuzFzzL7KzNwZNly/Y5wSy2IcQ0yqkawv4CgVe+5ZU22GrEPjbJ/3ULFyu8ifapffjCmdZKnX7paW3gxKY0d31i5/u9hCNdtHwsqUq8gAgQQbIeGBSztBc+H0B7Dh6sieIMasqXy44OkxemYtyA5LMJzKrL0Ah/2PKqHLYkUq53rUu87QTh4yIJLU1Eoo/9cMvu1sKacXViYDp1y6sQ8HHXaaQH19hRAhsLXIE/WyCD7qsNzX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvscLeCOLtKJOfo35Be6hZRRg028rr8AT3BW+qO+0L4=;
 b=Wvq+pbW/hWv7i6ulwmf0aDJPwlZPgRgy39i8S0NddPx0mB3WzsC72SB5Q/MhrwmcNfSVTI6Ym8tTkwBNVqsdnWLikxFdguZi9uxsQrJ2bR2GOMXi17wNz4yEUeR3QxvASp7Y1vNRloKsZWFPaLjLb20UMxv8TogiQYkX0w9431R9tDCFYml+kRMTTrFULqBqvGnGB3Ix0o8u5rMIyLBrrRXq5R7/qgU0yHCrCs+tWOplvNf7C01hTQLthM7y6yo79lPRhjZuIc2t93qBX82p0ssZ9GJGxHqw012QezMYP2Ux48LQqKvdH8edaRqVvbGIfICLl3cB55Hf6LEJF14kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvscLeCOLtKJOfo35Be6hZRRg028rr8AT3BW+qO+0L4=;
 b=uoki+fmpBtqj9kyC0Ywv/NLL0/H55Mcdp48Gg1Ua+fBrnniLinTl27kRpGA8rOI8udoqAdIaur5lgFoBr/ixIUjp4ffOVZu4in8USKLorlu9uEB+JCD27Bs+uZ5zgz78ubBq5RuHGv64JOB6clqZ0bFo0ci1JzY7qmPROSrZ1Ac=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2309.namprd04.prod.outlook.com (2603:10b6:102:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Wed, 25 Mar
 2020 05:20:03 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 05:20:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Topic: [PATCH V3 1/3] block: add a zone condition debug helper
Thread-Index: AQHWAlSDtDC4ZWOwBEmfbD5R0f0WZQ==
Date:   Wed, 25 Mar 2020 05:20:02 +0000
Message-ID: <CO2PR04MB234368CCA125D6DD0A1C376CE7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <20200325021629.15103-2-chaitanya.kulkarni@wdc.com>
 <CO2PR04MB2343C3B9DF774E6A6F052EC0E7CE0@CO2PR04MB2343.namprd04.prod.outlook.com>
 <BYAPR04MB49659AFBB6519B9E9ABC51E186CE0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81199103-a0cf-4051-19dd-08d7d07c2c3c
x-ms-traffictypediagnostic: CO2PR04MB2309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2309A38DE9ED0465932ABD22E7CE0@CO2PR04MB2309.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(91956017)(64756008)(76116006)(66946007)(66556008)(66446008)(66476007)(33656002)(52536014)(9686003)(2906002)(55016002)(8936002)(5660300002)(478600001)(26005)(53546011)(8676002)(81166006)(186003)(81156014)(110136005)(6506007)(7696005)(4326008)(316002)(71200400001)(86362001)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2309;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sdZ+0c0Bl6jm63UGOY9oynYipS1za8SHAXX2+Nw+Mek0BFC++RVWQ+sNgk3nAAC6N/ESQA6F4OEeR4WNvG4N+ZKKyr45/gokxFnFwscGJevHkTKsrqj9muSXp1vzVsLjBuG9s9ufuXEAVmmqY6NJhcrGvRBMOcivGPs2tGBMdR5UVd5dDo9ZTfpMydKlkCKkMH+QpXp4YbVYVG5h6piDHo+nj8WK6sTUuGbrv1K919nkB/GDWuNvqcsg/+wi0IqrhaRwkG0F/cIBT0+aESloan1TUgX873JJOuZzRqR8uX1xZ9vHEGnPje29/vu93ciw7WtK0aZ37ZrxMVF7SjIXmhBRFjJOnSxlpWGEMh31Emz6yIThOpBt0ILoNDDolX5hBD+bIPPe70Ny3kgNkCm5NBmdOIJZMAk7+1zPhDJWLr9miAJpymsvwCOPy2CMSB8aq64bO2Bf0oiiRFkY2tmdD9FHsem18VSvzpLSGcwnxjSApIkYIhznANuNIqQeIMwa
x-ms-exchange-antispam-messagedata: QutNH4a9vRrv7DjRG1KUqyUeh/LsKDKbQ6Rr3lPtim7Z4If1ETmDrwRFjF2FqtFe+0rA7ZvIA65z3nREg9d+zxiVTqE3S4GYIDot/RQzX0qjSjRbVpRLVJgvReNiYvOI6kYjsmOffEWdMdcXcP/ZYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81199103-a0cf-4051-19dd-08d7d07c2c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 05:20:02.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fdxz740DXTpEu4ppjJ+V9r9EIEzvCppdNAQb1hhZSPzTKfFDD50YxpTe7we3P3P6YZoNj2/SJOEyh7ByE/bAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2309
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/25 13:31, Chaitanya Kulkarni wrote:=0A=
> On 03/24/2020 08:27 PM, Damien Le Moal wrote:=0A=
>>>   {=0A=
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>>> index 53a1325efbc3..0070f26b9579 100644=0A=
>>>> --- a/include/linux/blkdev.h=0A=
>>>> +++ b/include/linux/blkdev.h=0A=
>>>> @@ -887,6 +887,9 @@ extern void blk_execute_rq_nowait(struct request_q=
ueue *, struct gendisk *,=0A=
>>>>  /* Helper to convert REQ_OP_XXX to its string format XXX */=0A=
>>>>  extern const char *blk_op_str(unsigned int op);=0A=
>>>>=0A=
>>>> +/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
>>>> +extern const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=
=0A=
>>>> +=0A=
>> I do not think that the extern is needed here. And I think that this dec=
laration=0A=
>> should go under #ifdef CONFIG_BLK_DEV_ZONED since its code is compiled o=
nly if=0A=
>> that config option is enabled.=0A=
>>=0A=
> =0A=
> Are you suggesting like following ?=0A=
> =0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +/* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */=0A=
> +const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
=0A=
Yes, That is what I meant. But may be do not add another #ifdef and simply =
move=0A=
the declaration within one of the existing #ifdef CONFIG_BLK_DEV_ZONED in=
=0A=
blkdev.h ? Less #ifdef is always better :)=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
