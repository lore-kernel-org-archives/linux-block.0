Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1542C4740A
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9821521924
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XgL2aDf7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VfP+5+QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390553AbfIIRHA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:07:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37675 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfIIRG7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 13:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568048820; x=1599584820;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
  b=XgL2aDf7YWgdcEgr4nkj2QbKRe0sIZvOSiF67ykU62kQ/SCaxXh+UArM
   trEanLNDHzV0/993dSa+HXAX83GWxW1m4b/aKc67siFPNERW/O1vNIZVs
   6uuN5NNnLc6EIkNU1HZ7GQsF6ov3r5C+p2mbOhnnY1AiqYnCvParoulwG
   iswZNduPZy8WjXZ4rRaMftOXvTk1i/lbLbEt0WF0UaR64BBQT6J7QwTWA
   H6BKaqmsADLZq7E36jDJecbTkcgii2L/BnFUVKPW0GwB2SYmwd1HxVnM+
   hqk70ZjfpiHsvWO8cRRs//92rncI9K40CDPVPzogRK1ppisuF6NQiGcQN
   A==;
IronPort-SDR: S9TURH3thW+G799QmgNnbndWN+JpXa2kWOcyNT8icwLzPW1puUkcuah8oekUaOA0sEhHKPSt3f
 JRyqayqAV1ScupuSe6pqyBz7gRG8nE/um9DbavW89f6TeaJyAvRDqxaolC8MrmaMadEN5dY5J9
 CDv3KGpwlpDWGF0w+nQPWhYI7JFoQyvwVw5c146OpGM0oh1jjPHrxv4uJutlnGkbEqpm8xOLS2
 TjuhdP75y2PCnZkvI6heXeR0nfSbfOayDh12eJAC4r/Ar1pJtxDLMUqs/EiWPUWfbxKYYKnfqa
 tIg=
X-IronPort-AV: E=Sophos;i="5.64,486,1559491200"; 
   d="scan'208";a="122401135"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2019 01:06:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xme7zAyP+79pr+thoGtn/Bg6Bm43plusbH0eJfNd8o4vfm6Px7xX7L6VQfz47RfJEY960diG6isYlaQyfG57OWw5DRPCvXCI6qKjwHFxzOlXirIcXBf7Tup029ctnQA47yQTI23qVT5KdIJRu0NPRcMuyonl/dCNp0WdPQidvVRwaInlKKM1yfT/ZCw5rfUg8bmTDVa+GukSYlZijBc/IOL34oAnSmiSTDNIuoY2Tm0vNgwtrbG2UIRyRa9JU3dElq6rWtKRD+VqJwuQVbrFPSejz5AMpOeFtq8RY4pTmYm9XqV5VVzVuhMZNnAQKW7B615Ac0jiTtnmQhReUILmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
 b=g3Vq0akLDN9bmavO0frwhDWmvEyT8mI1+Py+lJUJr65GYKXiYW7+8OkZPk5vlddh/0Aw/GADXtc5Uy+HN/snHPhx7QGuiPaDpVTfAi+47QOYIGjfjIsg0PUGiAumQyleXzwYuNse7OrRCkpNAhjxHWnmRlnhZxvzIS3P9MjyhYko5nD+2v1HXQ82hxb9gCRHUC/MW6mfsUfxLWyYIHV54dMwepiS+XtJV9pMugr+HuTRio1OlUQtB5Zo+pWFDobhDFIQmBv7KV0NxXyZTQCmnSmitK+BQNOA8RB4/uHh+JME71sn/Uk9ZylXU3tr+8tbcntSDrwPfL+2NehzrKviLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Rxj/1cKdA3Q/9M+u5xKL/vAOnQCgESIAzrB9C3Wya8=;
 b=VfP+5+QJUUNgGyeIqn3d9pP7uLfpA+yWiziGn4mH4DneoV0mAr23K1DxcNEOOtTGlSkOcVCYSHJ0gH/eKZ/90TFTTo7XOBimLrViGR6p5oTeyxylhFQGzi48BBt7MrUtoyHYfb02Xyle9bvT9jP/P4RLhPqRQfrjkdDJfGoc7fY=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5621.namprd04.prod.outlook.com (20.179.56.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 17:06:57 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 17:06:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Topic: [PATCH blktests] nvme/031: Add test to check controller deletion
 after setup
Thread-Index: AQHVZBGFOhLove2B20W3iAzHm6F5Cg==
Date:   Mon, 9 Sep 2019 17:06:57 +0000
Message-ID: <BYAPR04MB57490B2A63235BD0078D86A186B70@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190905174347.30886-1-logang@deltatee.com>
 <BYAPR04MB5749A3E9B06514AF589FE13B86B50@BYAPR04MB5749.namprd04.prod.outlook.com>
 <7ae33b82-88d7-2fa3-2bc3-da0b262d0ee8@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd560e0-4fe0-4032-f383-08d735481f68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5621;
x-ms-traffictypediagnostic: BYAPR04MB5621:
x-microsoft-antispam-prvs: <BYAPR04MB5621D86587D13E4E5BAA1F0B86B70@BYAPR04MB5621.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(51914003)(189003)(199004)(25786009)(8936002)(316002)(478600001)(3846002)(26005)(186003)(6116002)(486006)(476003)(2906002)(53936002)(305945005)(33656002)(110136005)(229853002)(55016002)(6246003)(9686003)(74316002)(52536014)(66476007)(71190400001)(71200400001)(86362001)(6436002)(64756008)(66446008)(66556008)(2501003)(256004)(446003)(5660300002)(66066001)(81156014)(81166006)(6506007)(7736002)(76116006)(2201001)(102836004)(99286004)(14454004)(7696005)(66946007)(8676002)(4744005)(76176011)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5621;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GhWp+aqwwNgsgl+OS23mAhkGoifopgMDXI+oXAa7fQk9dG8GMK+ZP6waPAkEZVj+Pwy+rdqZrzF0UyA8wKEiJG2RopI3vY+WvPBLs4aTyXVxWYaYicqeAMLdsA5xS3EQkkWGzBAMIED0/LABmxPgXgi0dz62C0RPAjvxICmKFrRfZT12hNMRO9R6tlnTPA8fAIq14Eg9AN4CO/KEtVnbkbwYSlMuRzBsJRt+gG6nDQupJgdJkxnRhvnimXe5wKiIrw6WRLgDjuS0pKDaZ4qEOSTwApuNdkv4aO9vYUXbd6H7aZ3XV5/47xibJY6BnM8uihKkRhjtKkEbdtJtAEQ61uo5NazLlMmouO3YEr4656sVHgN1YCKGsXi/dPip+psPecdw8rCeYI+ZU4cj0UdkCZyPV6s5ZPazf+0n3r6zgfg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd560e0-4fe0-4032-f383-08d735481f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 17:06:57.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5bSencciiDN1H1l3EKqZsSJclidPMLR+S26rekVpsNfPSf7W8LQlug7e6jvaG1uX9BlIwh+4YrV5/EmBCtNy+eaCqB+nAZt/iRQaM/tls0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5621
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,=0A=
=0A=
Thanks for the testcase Logan, once passthru patches are applied=0A=
feel free to post the blktests for the passthru on the mainling list,=0A=
I'll be happy review.=0A=
=0A=
On 09/09/2019 09:14 AM, Logan Gunthorpe wrote:=0A=
>=0A=
> On 2019-09-07 12:19 p.m., Chaitanya Kulkarni wrote:=0A=
>> >On 09/05/2019 10:44 AM, Logan Gunthorpe wrote:=0A=
>>> >>A number of bug fixes have been submitted to the kernel to=0A=
>>> >>fix bugs when a controller is removed immediately after it is=0A=
>>> >>set up. This new test ensures this doesn't regress.=0A=
>>> >>=0A=
>>> >>Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
>>> >>=0A=
>>> >>---=0A=
=0A=
