Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF5DC48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 19:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5124520883
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 19:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Llt5u6lW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iq7XHVEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFYTY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:24:28 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33729 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFYTY2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 15:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561490667; x=1593026667;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=o1Z6yI8edYlRbMea0pd6anKl3TRgqKPhJShWiU4ai7k=;
  b=Llt5u6lWlwErb9gDv/GOxdpAHdOuuv9QVtF90ooHZxBiMgAMbOq+lBkb
   z+n+TgyA47QTW92AJjSErCptgfZ+ORo8NmlLvCAdps5RzTu5c+iq41r/D
   tbEct5nWboxJmcqeAoxrkO9y8A0Korw9P3pdtHWw/24A5Wd7u+rU2630y
   wLMRUEXi3EY49D8sJFE7Pl4Z66cE2p3HGpCGhu46jQ1vMlTmaEZQs/s+f
   RFV8vcMuV+XLEVW3uLHilpvEJn47SmXcDAy7WFpVAW2mjQts7ha2mVZvP
   ZTinEmw/Ivvd6XxJ9DH+Nmh1xqncvhzIkHEARkN6KL4JoNCU37+PyhyKn
   A==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557158400"; 
   d="scan'208";a="217899513"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 03:24:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnC5pE1bxAJz5pN+iLPOA0YOBKP1Awiue5oA7TYH4cA=;
 b=iq7XHVEIjs3oeCYBdg021TZ5u/6htTqFZd10a2e/6Aq49zoe8HsfsNI84MMBAtCcZdB/ehawhzrHN7JnjcIPkQhI/yZLaBeaX4Uyh6Jv+YyLjred3mIbfYDeDlgoVXy1BXQBNr29O3X3O858UpZZctVX0KFVPD328NB1usGMajc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4360.namprd04.prod.outlook.com (20.176.251.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 19:24:25 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 19:24:25 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Florian Knauf <florian.knauf@stud.uni-hannover.de>
CC:     "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: Re: [PATCH v2] drivers/block/loop: Replace deprecated function in
 option parsing code
Thread-Topic: [PATCH v2] drivers/block/loop: Replace deprecated function in
 option parsing code
Thread-Index: AQHVK386Ta6SMRAy8UW37kTixSPwpg==
Date:   Tue, 25 Jun 2019 19:24:25 +0000
Message-ID: <BYAPR04MB574963E31CE0DB5581F5311F86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190625175517.31133-1-florian.knauf@stud.uni-hannover.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dc0c2de-cfdd-488d-b83f-08d6f9a2bc10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4360;
x-ms-traffictypediagnostic: BYAPR04MB4360:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB436018DCA048D006DA29674F86E30@BYAPR04MB4360.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(6246003)(4326008)(2906002)(9686003)(52536014)(66946007)(14444005)(66066001)(476003)(6916009)(71200400001)(25786009)(446003)(6116002)(33656002)(3846002)(71190400001)(76176011)(102836004)(6506007)(486006)(26005)(186003)(53546011)(5660300002)(99286004)(7696005)(256004)(8676002)(966005)(316002)(478600001)(54906003)(72206003)(86362001)(66446008)(6436002)(55016002)(229853002)(64756008)(76116006)(73956011)(6306002)(305945005)(53936002)(7736002)(66556008)(74316002)(68736007)(66476007)(8936002)(81166006)(81156014)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4360;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +IxJTUpbNylKhOnxJJBnKCG/TSxIC8soMtIrZb1QOkDigAEl8H8D/H58Yy0Vto5p+NDN6PZLje35vlPhMnFVk4onKi5wy6fEXVzX1G4zSlWxfjUnYiKACcqJXGZjrhnnBk3mBRpAdKZdxoU5UEbszpheTPiAbRHnr0xNQyIpzwKIAZ71vDtJHHYm4EDbbN61qb47qTPxQJfxPKo/pToteLBOtozKgcyj0gDbOX08YIKYcHB8xyjU5/k9FRuRScHuj9D2NL2rzkohMTrvRcCG5obesh6wnP0hg4KSRBjVlkrqDlvEQkBV51vzdR5K25lNjQy7nwNUdUmU9dD/y+GkUctEPt3eECNebsCDzga6IckHIRUYNUSjpTZAN5A3p6a66a0V32cWjK6KZ+xSi5taUbSJYJDhwPKqbzKW5kJcRHc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc0c2de-cfdd-488d-b83f-08d6f9a2bc10
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 19:24:25.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4360
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I believe you have tested this patch with loop testcases present in the =0A=
:- https://github.com/osandov/blktests/tree/master/tests/loop.=0A=
=0A=
With that, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.=0A=
=0A=
On 06/25/2019 10:55 AM, Florian Knauf wrote:=0A=
> This patch removes the deprecated simple_strtol function from the option=
=0A=
> parsing logic in the loopback device driver. Instead kstrtoint is used to=
=0A=
> parse int max_loop, to ensure that input values it cannot represent are=
=0A=
> ignored.=0A=
>=0A=
> Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>=0A=
> Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>=0A=
> ---=0A=
> Thank you for your feedback.=0A=
>=0A=
> There's no specific reason to use kstrtol, other than the fact that we=0A=
> weren't yet aware that kstrtoint exists. (We're new at this, I'm afraid.)=
=0A=
>=0A=
> We've amended the patch to make use of kstrtoint, which is of course much=
=0A=
> more straightforward.=0A=
>=0A=
> drivers/block/loop.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c=0A=
> index 102d79575895..adfaf4ad37d1 100644=0A=
> --- a/drivers/block/loop.c=0A=
> +++ b/drivers/block/loop.c=0A=
> @@ -2289,7 +2289,7 @@ module_exit(loop_exit);=0A=
>   #ifndef MODULE=0A=
>   static int __init max_loop_setup(char *str)=0A=
>   {=0A=
> -	max_loop =3D simple_strtol(str, NULL, 0);=0A=
> +	kstrtoint(str, 0, &max_loop);=0A=
>   	return 1;=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
