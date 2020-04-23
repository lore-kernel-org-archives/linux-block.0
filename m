Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F2C55189
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 02:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7255F2077D
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 02:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RxHibVQc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EWjKES1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgDWCAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 22:00:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:6755 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgDWCAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 22:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587607236; x=1619143236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ounyCmVEb2ovR83LyEebB2mp3Zqnk+xVqFjc40G+qJM=;
  b=RxHibVQcbQBL5j1ym1ZzNQPBIrLMfA88gs7nch5I+I+8veFQoH6AcUxR
   l5BRIAh/wswGuENMfQCG0vvVLe1dloYxmOcVXrFXy97rKoWJ5c4lCr+9F
   ybIHHz0aQdq8YoMhm6HKZ/sswnCOJtRPZ2oNao5jXxvtS5ttY0dSNebK+
   bNkYkQ6mprjFpzYeAQq9hfkm2Ai3veS4bAzSTY/i2M3Lk1MgNl82mwNPW
   /242SspASkalFvXddnLtwDO/m726w5gi17fQjpYNeKy8QJuok2ZBCuO9G
   KxYmYag3YilkX6JMVTRycwp0ZfXgXwoZto/PlzEJ4RUF3uWDsnArvcnx1
   A==;
IronPort-SDR: 1y+bsdAzSJUadjgjUpTqx7z4RU/J1nxTkVNEQSWRZiwwvNJU6idLpgau4Yuby3k+Ft2Rg+SKyx
 kHjkutYSXbkuhgA6lgdhOe1pjD0Y3Bymf7J6SGyRk7D6wOWyeogitii5n3qJaS/th65E/PHeA9
 0M4/CP025UWOmTWQE/eqdol5rIx24qd9Z/WMFzRj7oHhd+OBj6YV5JTcQret4k7GFPyOFdm4d+
 u1y8z0C9KGV9WIh0VJDFLrrvWXiISSgtLRUptltAkw8mtdxGVDHmDc7LrWg0daygN6pVuSuCSj
 Zag=
X-IronPort-AV: E=Sophos;i="5.73,305,1583164800"; 
   d="scan'208";a="136241081"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 10:00:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSEBbMq51+IUNCRbDVCXSnu3QXgjcaaX7XkcJXYwUyMn8DqjZh7vrazFY/eEJ/S5IpGF45VP1sqmr1kYQzdr/4HUv+vb1iAXDcn6LshfMYQohJYOW3xTPjIB4/E8SkMxdzh85ArFuquYt6JbQYnfem8ell+/tljk/WVUy74BhHtz2Wayx8+Adkjmw3CXB4pioZSST5SaGr8JMGyE9sjOknm6yNtV+VMElqZky/2K0J2Z6aQRXRH/r4mNUD92Wug1xcEdzNwevsxlbz3qpNYzU+k1ywLYBEx93aKNzEBVrgDWiTgpw5MWq12/JbxifWx9FaLDETgNMC5ECp0pvAMuUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ounyCmVEb2ovR83LyEebB2mp3Zqnk+xVqFjc40G+qJM=;
 b=AYIetFYVWlbSiM1Q8IwGd1LpVLkM3Snzl/XYwe0MWUOJmbD0d3HYuB3oHxO0GPHL+kKdfp9bMted3z8lcMruYIQU3t+h6MyEoErm9BnPgwwZTYAARbJHw5DRO9fTwZhYpw4npW5FvEz36JMws/J8AFSfCqzQR8flcEUfGgO4AIKMvJ490AGvSNqVScbZNGI3O6DJMvu6LsMetMKoV9B0fgDWAxs3XHw7bkD4seg5Ti0cvsq9n1n/VzKZqIEqaX+b6Rcttfy43RodnkIQtXTDw+ZTbjPPTypje3AuaRKoSd0B+RXpEgK4PhOcf5DppdY+jcrExc3F5+VwI0U4gAI3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ounyCmVEb2ovR83LyEebB2mp3Zqnk+xVqFjc40G+qJM=;
 b=EWjKES1El7KwthJ+kKFk8MR3FZsFp6CY2f+93qZKSkEUox+qtYZ68MDookp7o7gI2fY7vzPYslfgvxi3j7Xih8VboPbVR8V6oqA5Yrqigw+xJG62i83vFS4xKAMgkaqSjfQJ+IjlHp3XdMAW6VWKehSDEeTg2QGBtFE6pIKM2QQ=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB4725.namprd04.prod.outlook.com (2603:10b6:a03:59::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Thu, 23 Apr
 2020 02:00:33 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 02:00:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v3] Fix unintentional skipping of tests
Thread-Topic: [PATCH blktests v3] Fix unintentional skipping of tests
Thread-Index: AQHWGHntLvzkzDjxR0qwZVVh9k3pZqiF9PwA
Date:   Thu, 23 Apr 2020 02:00:33 +0000
Message-ID: <20200423020032.lxdpnrr7yepj6vuq@shindev.dhcp.fujisawa.hgst.com>
References: <20200422074436.376476-1-its@irrelevant.dk>
In-Reply-To: <20200422074436.376476-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 353781aa-78b5-492e-4665-08d7e72a1bb2
x-ms-traffictypediagnostic: BYAPR04MB4725:
x-microsoft-antispam-prvs: <BYAPR04MB472573894718B334F2ACA4A0EDD30@BYAPR04MB4725.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(91956017)(86362001)(1076003)(4326008)(66946007)(6916009)(5660300002)(2906002)(71200400001)(44832011)(66446008)(64756008)(66556008)(66476007)(186003)(8936002)(8676002)(6486002)(81156014)(6512007)(9686003)(6506007)(26005)(54906003)(316002)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+jRIAtPFIqWi+eZYxKd+gW6AhuXTOn478jdnoJzUBZh7KcZm41rXKpaFddn+mObJAEWDwMRgHq2fDYwBJrWHG+x/7KH2tbGRqyu0SfZ3liGvrSxCMkVst1gMP5ka+qTN8Q7hkZLfL4DLOlTFXMc6+k99akKKaCH/S7gjNEaq+7z1ew26Vb8SFtjwt+dLQHMwgAW9pV8cp7nfHOyNuRBgPDaoxpBGSr6koKQEY5dxTS/hviOVMWYdDe5rlG3AmCuoiXIa9bF+3whrScX/z5CAi1iOW5J+aFFUsPhN+8LvmNbO/FMUPi08DZmjhuwaWYb378FjvUUuG68CUKjJwEuGYjFBXWuDptM3cNN6fZ18pxWwl+b3WW9WR+yisgV/d5Cji2+pGqlu7vHKChRLbMeedGPT3q5f+eDISc2a8jEKByq4mFR/CQKAeK4dDmb8774
x-ms-exchange-antispam-messagedata: M+NFEzulexylBR2RDBXV6m4X79L7sX/SmkgVts9Yb3c70zMR0RwOM78JMVNVbbrdfKElHgJTYXHniwnmKhoCJTJy9layXvf6U4Pp4mLIIjNsmT2rFAcWn5Frj7xMn2w0/uVo5XFyZlhaxWfmfsiQmA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6F0D491EDFA0249B22C85A18BFA7FB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353781aa-78b5-492e-4665-08d7e72a1bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 02:00:33.4016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2i82h7UpO7VCi1cpaVojf8TaIUWy0COlJHlZiEdHoRV0k87QUhi70CzxRlLwjEOjq2oqBfWwVjRART1EJq8QDQTRu3ntxSoPwJL92lgKtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4725
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 22, 2020 / 09:44, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> good handful of tests.
>=20
> For example, block/005 uses _test_dev_is_rotational to check if the
> device is rotational and uses the result to size up the fio run. As a
> side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> commit cd11d001fe86) causes the test to print out a "[not run]" even
> through the test actually ran successfully.
>=20
> Fix this by renaming the existing helpers to _require_foo (e.g. a
> _require_test_dev_is_rotational) and add the non-_require variant where
> needed.
>=20
> Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>=20
> Changes since v2
> ~~~~~~~~~~~~~~~~
> * Fix missing _test_dev -> _require_test_dev in block/003 (Shinichiro)
> * Revert change in block/004 (Shinichiro)

Thanks you for the update. Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
