Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3135C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 16:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D81D20CC7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 16:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GyKeiz7u";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K2ES4f7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbfIMQ1M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:27:12 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388719AbfIMQ1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 12:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568392032; x=1599928032;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5oyn/VfYHWbAgER+5J3u/BYMDaLFwe68OvEvFeUnEl4=;
  b=GyKeiz7uxz6EUMDImuhjrTH6R5eevlEdpsf0bheyf5uCqvNQYtfNkDgD
   +pcIPvcTV/bFp4DvSkANzYXFNWMXJNnDH9Zb6HYP84cUsYZCZXYF9eHr1
   2XnUE3Dzf1LP4XDqwNjnyRXzO4kBIxXcvBihIfCPlv6r4RZOGaZ7VHIvU
   3yQcm9CBh7J6s6xwTjjD2DqS85cXyLH7fwRfGtzlV9EJArRluIFkojfuM
   0SZSXOamPLBqyn9kBYp4eQgLordaS82vKNDE78ahiQ24gvrA+ug5FcHNY
   J6gGkpL+hwq0JHdr0KO0zuZ3JIpymqVREO5++CT12oqyhzvriPeQKIfKp
   A==;
IronPort-SDR: BuQ9w33Er+bN60wkiP18RyUf0FJUhGt1It4M6/nzh3rJdqs3LnDsHNecNW88JHrijAwMLKAFSs
 +203+I7uG6IwfjUYDsS/7pkZP8eVTnuNNElKi0R9r2zjCNNlxUhuwuX+Z6EfRQyI+7yDUkGiUU
 2jS7eev0D1KgDxLVRDizXuQq9nyHbd51GgIalIWWbmjsvH2G13Ln90zUnpz3gjYso2C9BEF4xv
 qCY+M7ss/kfXGbcv+jkUufZdZ2Cnw/mxBbxUZCfONlRwQM4FPakXj6a2RBBuhX6Pr5zQlVKT00
 uWQ=
X-IronPort-AV: E=Sophos;i="5.64,501,1559491200"; 
   d="scan'208";a="118193617"
Received: from mail-by2nam05lp2053.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.53])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2019 00:27:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8iIYpQS0DxwUFcpo0A4IoMZt86Qx3eocVsmW4xFzc0A2twyXnHYkWjMZq+O3X567wQtbxhJ2dMDshfjOmbq6umftWxryRXsFh9hsTXumQ9UFQ4Sni2EizAUKJkeQo6SiGhgrX0ZOgjsfhBUsPnFBVph+5u3aMEs33Xo5CIcdWHpclEqNXycZVDwnua9w94iaDqFCKtpNhKwsNadbyhrciPwyKV5gKw/XFt/efq0uqGd9FsOd1Wv3Ps29M6VYWjbzE/qrczejYC1vpiDplUsOCsjg/IeOGGvBlJkEFrOUzqNd20x8aaWEMzXyE7wIAcG6USUwavHzCbQ4oCpXqzfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oyn/VfYHWbAgER+5J3u/BYMDaLFwe68OvEvFeUnEl4=;
 b=khArSsU1jZZE74WZb2DcitIEczpiTl9+ZrrjBEnE5qq2ehyllS1s0gzJcCAgs/fypMYcPzFlfWn2muPzN70QUrUpqNaz3CFuC6HdvPHt1wZF+ss7AynoeTlyRNZ/tSBEa6XGhl8JWaE8giukdSRXpoN+7iOf0eUlZIan+Qsi3m13BltMxbKqKK39351PXCr63pjr1x/DxdouHgjIm2Fpxlpo0ihD84DbhKsJgZIcF3o4kPPsd3kNFb23t+PmlhdGFIjuTomNHtmRc1uRXbyl2KluKkmbXrD/XKtLAZ6HPh4mV/Yc9GjX3FsnvZ7FBEs60Bn1SGMm3Dwkv9uYcv7cMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oyn/VfYHWbAgER+5J3u/BYMDaLFwe68OvEvFeUnEl4=;
 b=K2ES4f7RuW1H6osKN+NHH/9sqDFOXw3hVEN+X31NMBz9XkKtMvDgf4ryaQSVpykFWvI7/JYQEbFr0EGXoNtDBRpPaHLFCJ0RFR+wRWOem0IoCphJJZXeQv+V4iPaJooNKd7KOzXfiXGg42fTuvi4v4yJDSowxgG56XZhGMbPleQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6039.namprd04.prod.outlook.com (20.178.233.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 13 Sep 2019 16:27:10 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2263.018; Fri, 13 Sep 2019
 16:27:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "m@bjorling.me" <m@bjorling.me>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH 3/3] null_blk: validated the number of devices
Thread-Topic: [PATCH 3/3] null_blk: validated the number of devices
Thread-Index: AQHVaK/tthLu0hDHKk6eugQSeTinSQ==
Date:   Fri, 13 Sep 2019 16:27:10 +0000
Message-ID: <BYAPR04MB5749E8298AEBE080BFD3F26A86B30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-3-andrealmeid@collabora.com>
 <20190912161937.GK29434@bombadil.infradead.org>
 <dbdb0415-8762-f9c1-a65a-3531d9cca109@collabora.com>
 <DM6PR04MB5754177B405819C802549AE686B00@DM6PR04MB5754.namprd04.prod.outlook.com>
 <d55554f5-7212-c5fc-dbb0-4269be913aaa@collabora.com>
 <20190913151249.GN29434@bombadil.infradead.org>
 <e029c399-e0cf-62e4-5ce3-a4287eb6cd94@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8607638a-1b97-41ea-ff39-08d738673a66
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6039;
x-ms-traffictypediagnostic: BYAPR04MB6039:
x-microsoft-antispam-prvs: <BYAPR04MB60394B1C2DB91EF316FB5A8586B30@BYAPR04MB6039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0159AC2B97
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(199004)(189003)(5660300002)(7696005)(99286004)(486006)(26005)(76116006)(66066001)(186003)(316002)(76176011)(110136005)(256004)(6436002)(478600001)(2906002)(66446008)(53546011)(6506007)(54906003)(14454004)(64756008)(74316002)(4326008)(558084003)(7736002)(476003)(3846002)(66476007)(66946007)(66556008)(71200400001)(71190400001)(305945005)(6116002)(81156014)(81166006)(53936002)(8936002)(9686003)(55016002)(446003)(52536014)(8676002)(6246003)(33656002)(25786009)(229853002)(86362001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6039;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GwMFjoPtI6+M8TEOEYuehsVieGXYa/doLWCGeNSkI/zkYRVGizI1GlhBi8FMxggZ2GCHsuAAqRdep8OnurcP3MQmxbnBiZ/urwubsjAhTirmBCe4y3kyCHgycyCokOUl5SzgEg6kCdFv3ltBoC0q1SBX4beLTdD9hzlUAXxBLqohriVHGWpjZ9qApHZhIsQqa3OYuXPUwCCAcnaGe4hNIVfw43ZyonHS97cXanSVdkQYPVEJ5wSe0ifVfVIQzg9JEVHIsx1KMhAXjju3tYLyCjHsuZwuzlQ5qijZjxa6/eMPE66x+lElfBBMoSfSKI88NI5g4XVgZdBNZb29+5dwnNSujR/JPnzTQNkvGFws3VFNeQBiLgJFe0XVjZWRgYVx3g5Hsw4p2joX4Zb1NT4DT7oJqWr96NED8eI9VU5Ty3U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8607638a-1b97-41ea-ff39-08d738673a66
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2019 16:27:10.7230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odqfni2YUFQj+bya/hFh3fL0fb0v7S5aUi3srpC7GYJ/c1WSVvmMcmB1XZY5EcurN7ku0wvdV8aqXcIw1MPi7FqC8xIwZMmpeVLfU3oVNlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09/13/2019 09:23 AM, Jens Axboe wrote:=0A=
> It also breaks the case of loading it, then setting up a new device=0A=
> through configfs.=0A=
=0A=
Yep, this is exactly I was asking nr_device=3D0 as modparam is allowed=0A=
and membacked null_blk creation will fail with this check.=0A=
