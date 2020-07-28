Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2617DC433E3
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C1620775
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lwdBMYbz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vdhk+OZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgG1KrU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:47:20 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43622 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgG1KrT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595933238; x=1627469238;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lwdBMYbzlG3sFiPTFNfzwsprkeqBp13hRsq+GoxW6GEbZdCxWLNghabz
   8oX0URDYVr8j5It3aqzGkxXBVABia9UK2HG6yyCOltGzXMDmeaha37Pvp
   OG3JMqGHrvR00NxXoDZmgGh9ZAlFpzDOSwxJnbACqdQueNKhGaom3MuZq
   1O/dV94o++kJ6/ixHImdQTxUeRPpKtZFEKUOU5iOIF5Dz3liKWVE+a/iX
   AXWeLKaoxnIVAbq+LUQAwt5Zwxl1XMCArbrh7ObHdLxuDISliRppGTT6o
   D77vf+GsKhYfxP8MUyuDvZ8nCu0t/VXKu9Vq/JmRCiqR/jOTzyYSJy7pO
   Q==;
IronPort-SDR: Jwe+nm8Xu0J7g2Xb+bEzQIq5QWuXI4MmvrJfp/nl6B6Ap+umbW7GhLpwk0KQz9DQCYL7Oq/p5T
 6/2gPfS3UGLpi0oecp8KDBIwkyUEuAcVALcxCj/ZE3Wte7uk8Hdpgaf0bM29XBT/kWQMWnboCx
 WTuvuEmkNDuzozxB3BiGpXph2QewmMRL55/+lLrQ1gg5Vodnr9hu9fmaMFZ8MLcN5MkusBjn9Z
 DuIE6wb3UOkOrx4JyVzKjUMuXQ5zUFLjyr5xve1dniDSmfeuin4fkFQNg9UdEcpurRWXiySvY0
 6t8=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143545258"
Received: from mail-sn1nam02lp2052.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.52])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:47:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOQNBTsMaY0awAxcubpMn97rbfSY3yP5GL2ogm2Tk3DpFH35GcgyLkLu3/UoGm43Ie98wjyKn0RJczdrWOm3NW8HWwrSnJWtuB2j92Guw/qSpAdKNXZsMOZRa5Ekyrp5pbDdsbYIQeTWMi9NCK0hjuM++sB3SCmJFP83i+oKOutmPMddzpOElpIHWypds5mxyvSvwJKgqSnpNSccZCTyMxL9Ofxzh2j1YYGRDPRVQERInaOMlcEgvl5iieUGHM7fYSq+KXjv+/4c3GGFnlx9mJqgGlyoAnpsnHRdhbeE41z9ik/+HTlqXAQh+DY3ffSXSsn28O6xP5iSOgG14IPIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Y/hUqtb5cesiY4zbD11Edsm+n/VsKcZXFCbwhkS1BaeBiHTh0uLJqHwo/BOdt3RnVC2sbJH9ZAiaYenjqNqGtzGSGGDzahJLe9jsV6IRZAHGAa1DiafsViYvXG2E2QqyP0tBefyMKCFVLRuhwgzpB8gTvKMJMpMYKhYdJ5j846YUpI6E1j6brTruse/fmXzP858eJD9V8ayWlu9tDjj/lRipwwWa19oUWwQdABMO3j+CP3qKBAJe1rcvIk+XzmhPnxE3n7Ag3FAeNt9sZK1zgETV8oac9iISug5YHYZr6DQOTlJBtu0TChBLFFSaA3tSiuIhDOvCH7FosR5lzzJnhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Vdhk+OZ46l7Joq1yyDqEH+UIIxe8PL47RiQFpoQHdHXkB4TZ7sZ0XIRPSNxp57mOn6GJulpdsmG1Dv1EIaiSX9vlAtc8IOwOHdc7IXNJrYpg/wCOcN39/R9+6DSSeHKC5Eo8DkOvigSwhCHlAj5IkLzH/ZWV2gNYfsyELm8xC1Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:47:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:47:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 4/5] zbd/005: Enable zonemode=zbd when zone
 capacity is less than zone size
Thread-Topic: [PATCH blktests 4/5] zbd/005: Enable zonemode=zbd when zone
 capacity is less than zone size
Thread-Index: AQHWZMf0GsCR3gk4n0e/OrWopjHorg==
Date:   Tue, 28 Jul 2020 10:47:17 +0000
Message-ID: <SN4PR0401MB3598B2F8086EA0138354E2DD9B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-5-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5f3dfd4-8d5d-450a-bf09-08d832e398bd
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5325515B6F8EB6D118779C5A9B730@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MnGJwToPj5qKqwlY9Mis6x1YxL12bVDAAxhqHQT3d/rv4sKRX5zzaTStL3NUoky+E8BLrMqbA+XVnDZPdamXfn0X3gZiAHhZO5mMpzw6fhBhyq6G1VlPQ1goRNKNmSoOe3lzXoaw6Yl5y6IuU29x1ufDCiVJyCRCgzgAS6TD0z8QvLs//eaR2PA4cHrkVH/40D3Da6/T3Kx1Zq/4+cibC0eavQXBiauQnYFOx09j+LVpTkDzxUP2pp9L0i13taXq6NL3FKFYZAE5wMx/79tTjmpFTwJQHWa4iLEX79u4AZwsh2Do2impL1jbGNgwY6Db0ZQMVaLX8earFcd+K09Jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(86362001)(54906003)(110136005)(316002)(4270600006)(33656002)(558084003)(4326008)(71200400001)(5660300002)(19618925003)(26005)(66946007)(66476007)(66556008)(64756008)(52536014)(8936002)(9686003)(7696005)(55016002)(8676002)(478600001)(186003)(76116006)(2906002)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cMtkMLqiQE2Gj7iiU2NPLh7SMlGegvUM0AZ4Y0IGHezFCY5mXIo+44lq75CRoylEkXnTzomm5WHHjf3JJR2+0P3oYjyWD/E6Y6NJyyqxiEdeCqwxOcI5V4QRqsHv4KZibSDGfi/HU8MIdqVhFyM8lDqvfe49m+TddrJURA8Z81NvpbDeyvBOcvpkuz0PrKXWlbLpgcwt/IeqKT4TbJB9RhGdMgjmXCh+T5kLS2TBA8kuC443Cjo67vYFh3E76/YOhwrDgmHNUwhH2uUOku2bYLh12Y/NwJMUc4NuymBJZSWDCHDUAoypO3xZZQERLctIGfTN3Sq+TkwIH5ZKfPp8YPN7eO2/JnoY3RPx2WvVGmH2u8rup8VMADMPEdJg0kIzaoipHAIYC0OLZgrRWTqRJoV/DUeVZ80lcUGcIBK2w3smoBgqRSrAu9IIto4z14MH70sRoCsevBCBE0rSGcdwN3pYSCKit6g1d4xTaRjZIj4zL7wiP78gtFMdL0CzFtCl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f3dfd4-8d5d-450a-bf09-08d832e398bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:47:17.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+yebUOiB52AQ+VlnZ+dXc1UPHmqgWmoO5vW/xpURulgQpkWASz64yTJNiEDrglNB5FL3ro2+yl6nz+yMoNdR8lgFIwSZFfcv5pIbDJjQS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
