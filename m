Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F14C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFB120C01
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eaMLn1LQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X3QifnDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEFQZw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:25:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35597 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEFQZw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557159951; x=1588695951;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dBcXJppg3bMFLmw1wNmK8Y3DaV+a93X9qIrBekk+ZK8=;
  b=eaMLn1LQ8EtUCx/O1swN6iIC1y/QjWVJzydjsD8hb5kAHxWAhEXzA3Sj
   aAi4WFO3+gPdrpSneGx+lCjP6NkhMw7PLTh1JD5zKWDILZ2Us40LkEQ9A
   KGoH7mCa36ZSpG2zg1if43WnExW8+yQK/ctVbxmcQktuBClaiBt/Wvx7Q
   FfUzcn3zfAyoR9tRaqOfb2LK6dTgdmfrCAwSMhAK+9B4wG+CgDmZmS9NU
   TRcyRW07aezb1qKnepyw2/VtohTadbl01pISLd4GAna/OnB4Mgq4b/f9C
   VlO0EVoCOIBtnHIWro+zc1GDgp1qJXMbWopWpSluz1RbQOQ0+9iw5f/5r
   g==;
X-IronPort-AV: E=Sophos;i="5.60,438,1549900800"; 
   d="scan'208";a="108834753"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2019 00:25:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PgQ9hynSDg75ycKVC1Q8mYI3E5/bbMagemptbdc0eg=;
 b=X3QifnDKWIZjOrbf8XzAahpLSwfkrhHxgIRTsSm7P7BjlpaH/BciXiCOOShwc/6xge6Cvf2leHzCQYQF36ZLUnjV9LcuwbC8zwPQVZ010C6zGUk9SBmwoQgLL8xmJhw3nuxSLcVimwhu83+m40dzrZq3UTDJDEuBvFvOHAYcEOM=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4062.namprd04.prod.outlook.com (52.135.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 16:25:49 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 16:25:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme: 017: fix nvmet pass data with loop
Thread-Topic: [PATCH 3/3] nvme: 017: fix nvmet pass data with loop
Thread-Index: AQHVA1QqzMpB1vP5BUSffPvuBQgzeQ==
Date:   Mon, 6 May 2019 16:25:48 +0000
Message-ID: <SN6PR04MB4527A202C575B8DBD2CD1EBA86300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-4-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68768818-08a0-4825-f610-08d6d23f7fea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4062;
x-ms-traffictypediagnostic: SN6PR04MB4062:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB40626A5E2D435A34522CA05486300@SN6PR04MB4062.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(52536014)(54906003)(316002)(53936002)(446003)(476003)(486006)(110136005)(6246003)(5660300002)(7696005)(478600001)(72206003)(14454004)(26005)(102836004)(186003)(33656002)(91956017)(66556008)(66476007)(9686003)(76116006)(64756008)(66446008)(66946007)(76176011)(73956011)(6506007)(53546011)(8936002)(55016002)(25786009)(229853002)(3846002)(4326008)(81156014)(6116002)(305945005)(7736002)(71200400001)(256004)(81166006)(68736007)(8676002)(2906002)(74316002)(6436002)(99286004)(86362001)(71190400001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4062;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8wlJaw/uz4+3trCIXMFBNhaNpLK0SSA5YoeVqG+Fl3Vt8ADLHsI4tYLFibOyesBPtDviqvj+iR3rai9OmDyX0m1jrFua8DS7dsn358xX5b9Sx8r77KNKi5LLuIawBafMH68PjpBzyen8JRPLffpDMiSsaObWZvmCqyw5/IKezPwYlIQeEObIi44Gz1tavHcZPUiMrgM54F5vcBqFQCxexPMVCNbjEOkYMhd1jxpRay2pi0ozitfs73wqBXXc3EficWCgUKasBK9bh25IAyhsIN0Gt08tB9wA94Mo0iRRGc6BFj9BdML1G9+xcsc8SJrWt3si0oPP9yEyNIQEFoVzpZeFO+pcyimdC6aTwBFI+NzLKbKEBB/FGi6kXgXIu3CgrxZcDFg23CJooGbSuJhigKsRRRaxLguYQyO5aTGP9II=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68768818-08a0-4825-f610-08d6d23f7fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 16:25:48.9300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4062
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to get rid of the string comparison here.=0A=
On 05/05/2019 08:06 AM, Minwoo Im wrote:=0A=
> The following commit has affected the result of genctr and treq field=0A=
> printed:=0A=
>=0A=
> genctr would increment two times per a subsystem due to=0A=
>    Commit b662a078 ("nvmet: enable Discovery Controller AENs")=0A=
>=0A=
> treq field would be printed out to support TP 8005:=0A=
>    nvmet driver:=0A=
>      Commit 9b95d2fb ("nvmet: expose support for fabrics SQ flow control=
=0A=
>                        disable in treq")=0A=
>    nvme-cli:=0A=
>      Commit 2cf370c3 ("fabrics: support fabrics sq flow control disable")=
=0A=
>=0A=
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
> ---=0A=
>   tests/nvme/017.out | 4 ++--=0A=
>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/tests/nvme/017.out b/tests/nvme/017.out=0A=
> index 4b0877a..d7685f6 100644=0A=
> --- a/tests/nvme/017.out=0A=
> +++ b/tests/nvme/017.out=0A=
> @@ -1,11 +1,11 @@=0A=
>   Running nvme/017=0A=
>=0A=
> -Discovery Log Number of Records 1, Generation counter 1=0A=
> +Discovery Log Number of Records 1, Generation counter 2=0A=
>   =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D=0A=
>   trtype:  loop=0A=
>   adrfam:  pci=0A=
>   subtype: nvme subsystem=0A=
> -treq:    not specified=0A=
> +treq:    not specified, sq flow control disable supported=0A=
>   portid:  X=0A=
>   trsvcid:=0A=
>   subnqn:  blktests-subsystem-1=0A=
>=0A=
=0A=
