Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7478DC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306C5208E3
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dLxtDY6h";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BkbtQe1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFYPmh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:42:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64724 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFYPmh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 11:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561477396; x=1593013396;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VRqwf+C4sabDSz/MSTSOMmrkEKnrYAIbmx9quKVJKe4=;
  b=dLxtDY6h2zRGe1+JGieodV97WZXq4d0PjaXkafvf4Z9vEGQZwexVor8c
   NfhDfBHpTByUj17h4C4BNBNckUTFOxZqzcXkLtMXLBpQycZii2bBFE5O5
   qwgcLx+MawNuXG+zD1lHBF/fVwkGsSGjAuQPlWtltX7rzv5laLKMc6xkW
   4xrppIg/mYSDzVL+M/1fgUtLXtrnn72WMiSGuYTlWG4LhkZU6xOaZjRGL
   uK9ECXsoDGVIqs73WFF+TO0Y6gDsly3upQ9exH42fiEmvi9d9SpETMErE
   qk3FWT/LcgWgQ5GbruyCHXWKG0BTBju26mpDrmLGOSF+5wVXQyFllJ8NA
   g==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557158400"; 
   d="scan'208";a="211296095"
Received: from mail-by2nam05lp2054.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.54])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 23:43:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=MQMk3XMSOqfKce32PyMcixsfrwOajF/nFiAZOlIQ88ZQgqcDqw7CtU/lTMSexxB0DWNOsNqCFqa4JIYA4HBr7Sd4yKp2YPyobGaxNeHuYwgQiysMC5mGmAmDIdsk4IpiZAQPHiQao5Fm5sYzxu2zvEj0H47mAH7aiUxHSeF3oRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFF/HuIT28KSpL/BKM3dv4Ug/EORaCvMClrhYeRLV0=;
 b=mdUUrVLBF3Ts0BAFDKgDjthwUckyNk5MYUPlLcijwxtdHU55AHOyzaH/QBOXOic2xVd1WcPd5CxbdIxpKWiDhtY4QGFafRDR86bw3VfAwahF20G4JwC2P+c6cXes2Za66G9GAWBMVhlITXe4JTP6hATDpdV+/HL/TJx+g7phAoY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPFF/HuIT28KSpL/BKM3dv4Ug/EORaCvMClrhYeRLV0=;
 b=BkbtQe1eJdp67wlP/os4eXR+sxRmMzXSN2pj9HoZHHxH2btTG2N+SkB+fZ/WKTzOygyTTciBgPkNdbVeWPz1TT+uNUAlscgzcX/9gsDhNm+fgeRBa8vXjwCy7Pd7ap0VoPDQrbvw8HeARNb0Od2ZrYD0BYZnSENiRXqmuacDBOA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5607.namprd04.prod.outlook.com (20.179.56.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Tue, 25 Jun 2019 15:42:35 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 15:42:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Florian Knauf <florian.knauf@stud.uni-hannover.de>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: Re: [PATCH] drivers/block/loop: Remove deprecated function, range
 check for max_loop
Thread-Topic: [PATCH] drivers/block/loop: Remove deprecated function, range
 check for max_loop
Thread-Index: AQHVK0vP1hG+6t1xhEGsUYH4DjqpSg==
Date:   Tue, 25 Jun 2019 15:42:35 +0000
Message-ID: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190625114056.8706-1-florian.knauf@stud.uni-hannover.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905912b5-080b-4916-0592-08d6f983be9e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5607;
x-ms-traffictypediagnostic: BYAPR04MB5607:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB560723836D7CA8849B3596B186E30@BYAPR04MB5607.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(74316002)(478600001)(3846002)(8936002)(6116002)(81166006)(8676002)(4326008)(81156014)(7736002)(68736007)(305945005)(76116006)(486006)(5660300002)(86362001)(71200400001)(71190400001)(14454004)(2906002)(14444005)(256004)(110136005)(9686003)(33656002)(55016002)(53936002)(229853002)(6436002)(54906003)(316002)(66066001)(25786009)(76176011)(99286004)(64756008)(186003)(66446008)(66556008)(26005)(446003)(72206003)(7696005)(476003)(52536014)(6246003)(53546011)(6506007)(102836004)(66476007)(66946007)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5607;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cx6JtxyasIRkaO6BwRyEAyvX1JYlWOW5GtTCg30ittFgVhbuYidaCfzEECTUnjM00sS/OV2lFDonkAuRjHFJgpc/EPjs2Wyqu94FFo5AcBT/ClW/CSviNe+y9bIu774cIEmSock4KRnMmqumbAkSGqSoMk2JO+ULD/9JRSdhV6rez7WfmSWJ35JU4QSqX5VcF/RbfDUcRp4NF+5uxlCbm4dTkvletFUiIB+e7UEOK4a02tTQh4kwf0jGNP561PqRuK17iWKf/3XWEEOEurCtcOBo1l6T3J4PCu1g3awMcnepDcfSNScBGCuLQ1+o8zn4SxeeQBc+ho/ddU2V+sUO9Zl7Yxzcx9/fJRT6dgr9QNabccZGz9U7EWVFi5CDYKRsARI7FzrmmqKQUGjgzdTj9a2b9IhUvwyzJWJkYGVLF+8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905912b5-080b-4916-0592-08d6f983be9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 15:42:35.2543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5607
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for your patch.=0A=
=0A=
On 06/25/2019 04:47 AM, Florian Knauf wrote:=0A=
> This patch removes the deprecated simple_strtol function from the option=
=0A=
> parsing logic in the loopback device driver. It also introduces a range=
=0A=
> check for the max_loop parameter to ensure that negative and out-of-range=
=0A=
> values (that cannot be represented by int max_loop) are ignored.=0A=
>=0A=
> Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>=0A=
> Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>=0A=
> ---=0A=
>   drivers/block/loop.c | 12 +++++++++++-=0A=
>   1 file changed, 11 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
> index 102d79575895..acdd028ed486 100644=0A=
> --- a/drivers/block/loop.c=0A=
> +++ b/drivers/block/loop.c=0A=
> @@ -2289,7 +2289,17 @@ module_exit(loop_exit);=0A=
>   #ifndef MODULE=0A=
>   static int __init max_loop_setup(char *str)=0A=
>   {=0A=
> -	max_loop =3D simple_strtol(str, NULL, 0);=0A=
> +	long max_loop_long =3D 0;=0A=
> +=0A=
> +	/*=0A=
> +	 * Range check for max_loop: negative values and values not=0A=
> +	 * representable by int are ignored.=0A=
> +	 */=0A=
> +	if (kstrtol(str, 0, &max_loop_long) =3D=3D 0 &&=0A=
Is there any specific reason to use kstrtol()?=0A=
=0A=
Since max_loop global variable is defined as an int, can we use kstrtoint()=
?=0A=
> +			max_loop_long >=3D 0 &&=0A=
> +			max_loop_long <=3D INT_MAX)=0A=
> +		max_loop =3D (int) max_loop_long;=0A=
> +=0A=
>   	return 1;=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
