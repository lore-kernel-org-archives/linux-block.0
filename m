Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018DEC4CEC4
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94C922451
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 19:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E0phpWeN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LihaMrGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfIRTib (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:38:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52005 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfIRTib (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 15:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568835511; x=1600371511;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5JJqk99R1JcH9lggVc/zTcvDsHViro09kI9FbFXnLms=;
  b=E0phpWeNp2Tn0mbXcyb8PVNGk5iCQU3p6dsBV+eL7Z1TOzlX5dy7g5xa
   qA7JSsh96FRJQvVgqsGG2bHM9S2gOWJmVvKo2DfF8HUjBgSWmZUbmfJI6
   oZoVLJq2gjhxlv5v3hRy+tJEJFCr9m0Wk5ed5DBYKJ40ehvftq2THpPwq
   3qXwNblGFG8cGn1jT53G1mQnkcDrKSIqndxRQNAhK/yCX+jpavNSvI44G
   g6tIVY1UhUU5OWNDzlFnhcdbqLLYrCdUUfmGbp7n0oLlgWgBoLePAU/8e
   PO3G9GqBRTZlH79ztXpaBfzt3osUOrqnX0PeWbO24AX6RC6pO5E3tKPUg
   A==;
IronPort-SDR: ld0DA/9MZLysW9PlKLRTCDtjvqWuwD916VBki3quqoPIvPeZ/IK2BCzqaTfoDTx3ROX3N44ZFY
 hYlResM+nd1yjaXNNbS2o8IZiK3aRng/NttWRZHxBmbVTfGIKeGXRAm7mor3pjJ/sLGvjQPM3H
 S7QU7eyES4K150fy7zi9NMPhV88eS/0fNuSldv61YYnlqNlM88tJHtWZsWLAg82X96EQxKMBR+
 X3ykyoJW5gpK4vXy6JThhXx9JZ4aUqQwnjlzgCfp76o/ah0wXvPd2WezbhqocEEQ4FoiIAN7WZ
 3oE=
X-IronPort-AV: E=Sophos;i="5.64,521,1559491200"; 
   d="scan'208";a="120133543"
Received: from mail-by2nam05lp2050.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.50])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2019 03:38:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSxeueaqM7fp7romHeSmnoPQ8TbFIDDYrIoF2960VcsYZoomhY6knyxTO0XKEdl+5YhJU77HcDt7L6ZvZXKkBsbxNWXmkcV5vfEBINlOsyUxjarY3PQDbmgHormL19u6kT1Dg/dpB/g7qK0DIm72V+VEQ6Em2d9kbYicg3NJV8kaoErGEbsz1I4JWMhITcCLEiBmqNWHbacECtiQ4KxwHlG6ZLq0s9elHosSP67rtsG+wytenFcw3co3o6kEqiJpETpZFVLiLxrcZQcF9cqcnbvmzjLLPG9dbDQOov/pZLAIbmTerrb5k53AiFUXml4RfS2BUQORfxW+WWelPn4hVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7STkWks98Xnapso93fTgPBaidjFqrTRl5brTMgArIk=;
 b=H47tGL4O5IIEVAOzmulE8NvPqOSJb9ZG6aVnY0uv2gRAjyjtstDZ3VgtX/ZQ9gK2bsQw75twJXolrg3nf7iAMKz2atjEL7M5SxzBjVNauTBBYbyn6sRZsM7jv2yLURpeYEhHgwuDg3xoOEUS8PnqeOAEX2YuPcKN18tPJOphb3LbwHhAJEPRpGBjJqjaJYV+r9XafSHK0/o/DYrcLSzNDDRGVekux2GkY12Px2UTUEgaj5LVW77qFLrUaH8SLF31fXc9YNKgoqrbv3hoKBeX1up7FPnR37OVB/Y8AdmWeY5BhgAavbrQapQLEJ4THzPp91aaGlHVirgLRKRteSwOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7STkWks98Xnapso93fTgPBaidjFqrTRl5brTMgArIk=;
 b=LihaMrGZmzWVK/CCpNs1kjGojnUn3YpRrwuAA15brdDm1/P366gBThO5pIeSoUpxAHL1JRkie2UoK8obIK46r7UfCUm7RSZyeSD0jCvPm1Qe5dG+fnuOsoa0wXXujiCR4Otu5ZFQcVP+iuXnINmaWSDq2UuomgeIkBgOGWy7LOw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5685.namprd04.prod.outlook.com (20.179.57.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Wed, 18 Sep 2019 19:38:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.023; Wed, 18 Sep 2019
 19:38:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Alessio Balsini <balsini@android.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Fix implicit unsigned to signed conversion
Thread-Topic: [PATCH] block: Fix implicit unsigned to signed conversion
Thread-Index: AQHVbg1L5/tB/1/RpkaA7g34GChgcQ==
Date:   Wed, 18 Sep 2019 19:38:29 +0000
Message-ID: <BYAPR04MB5749E2705682FDAFEC213887868E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190918103828.257631-1-balsini@android.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91b5d671-89c9-4d12-59da-08d73c6fc837
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5685;
x-ms-traffictypediagnostic: BYAPR04MB5685:
x-microsoft-antispam-prvs: <BYAPR04MB56852E2D6CDFA992079E1BE3868E0@BYAPR04MB5685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01644DCF4A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(189003)(199004)(66946007)(66476007)(4744005)(6116002)(66066001)(2906002)(33656002)(478600001)(86362001)(14454004)(256004)(4326008)(25786009)(6246003)(52536014)(8676002)(2501003)(66556008)(64756008)(66446008)(305945005)(229853002)(55016002)(9686003)(6436002)(76116006)(7736002)(74316002)(3846002)(76176011)(476003)(186003)(6506007)(53546011)(81156014)(81166006)(486006)(102836004)(316002)(54906003)(26005)(8936002)(99286004)(110136005)(71190400001)(71200400001)(5660300002)(7696005)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5685;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UeCx137FGAfwBGUHvmIfojNBaTOsxz/vu9MFndFWYtB/GC7AujEg+MQ/54tschO7NJSk4CcxgRXwxz2tQ9CHPc7vw+t+uHZaQ7yW+LFXmYmxKpKFxYrAP+SZAfiqxHjAGNFzKkDq2WOGd9V5wWLN3Iy9UkWCklTx/92lOEeWwwV/W3Zj8Q+wOu2s6MUaX69SYfuRZuspV9Tz95YVPGtdGP1CjoOVgCmTBfJKBveBXlkDIYG7bKbi6j5nqJ8rZfFIPK30X3yx3wHb7ZK0VGbeYT8qJYxKrIPhAUQa6qn65HDAuPSenZke2KUN8d+Hyjx8CHwIOQIT5dfYTlPiLba6wRh3ASnSGqpW8n2Q8c9/vSebYhnuWO1w+Fbfce0qSvoddnGtgIcHOleezBN1P/4QUTpu/Or6zW2JUfrkWCKuk6g=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b5d671-89c9-4d12-59da-08d73c6fc837
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2019 19:38:29.2392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Abob0uCPX27q7XkL5eaHr/eZeQTCFjbGajSdNxZf98LM8K00529Ujh2FjercZ1ZyERX7ZAJFEFvFXg5jvUGXcnCqwWaHLlv9mGGBYL7OoRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5685
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since this is a conceptual error and will not cause any bug=0A=
not sure if this needed as things are not leading to any bugs.=0A=
=0A=
However cleanup is helpful in avoiding any confusion.=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 09/18/2019 03:39 AM, Alessio Balsini wrote:=0A=
> An unsigned integer variable may be assigned negative values, and is=0A=
> returned by the function with an implicit conversion to signed.  Besides=
=0A=
> the implicit conversion at return time for which the variable=0A=
> representation is fine and there is no variable manipulation that may=0A=
> lead to bugs in the current code base, this is a conceptual error.=0A=
>=0A=
> Fix by changing the variable type from unsigned to signed.=0A=
>=0A=
> Signed-off-by: Alessio Balsini<balsini@android.com>=0A=
> Cc: Jens Axboe<axboe@kernel.dk>=0A=
=0A=
