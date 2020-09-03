Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B9CC433E7
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D35F20767
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N1rHeQ5H";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rEmXCAEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgICI4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:56:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46498 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgICI4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 04:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599123375; x=1630659375;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=N1rHeQ5HOS7dMcrc3BiQ6l/U7i6TJ3hP+eJyHtPXffoEEgVBPPH+5FIM
   +QXe0nV7E8IXmDCzl9BSkG37ZJQybfKsPwE3wSVjLYcA60tGLInOeb3EW
   Kev3110RvOU8o9M4x+PeDBARVZPiimYuAsZmjiQKcYENJND+QrwYiPd2V
   N4F00Jxa9RoL8FyKUz6lyJ9p4bC1OuAtWQvlRRAvZ0zpGeHamQva4/QO/
   ZeG7NHGPfytDwiUfbgkdgS9vq9z4XcSqjxX0eVI19SDGhuyEVjxsunfUP
   vOWuTLH4VERuJuDaFaBLm3qKiNnOBrtTRF1tpU551GmyN8blX8d95Ez6z
   A==;
IronPort-SDR: eVD7nNJLe2HRwjazMCUnLcv6aqSel/k45K5hb7e2Rr8oiHaFl9O1/fHgI3r8P9slIq5Wdv1kaO
 zEkZq5is9t1rNnubvrChs8d1Tgk+YjpC/q/Qq23kJ/ZfIYk4Xn1nsRtz4VnflPAYCX6Y3S6+w+
 zj+Rw+Uy4a2v6D0s3ryc5w/5H+G2zyoTN2q3Y531rkeBm+bWtD1oyc0CWspnmfLk3TwucSXP5/
 MP3D6PCbQaOhx1GlWcSONVkBGIV9iuPKlJBo37SpTe0y23Ir3vFX5aq8GI5OlmzTshsJp7pkJY
 SYs=
X-IronPort-AV: E=Sophos;i="5.76,386,1592841600"; 
   d="scan'208";a="147706909"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 16:56:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0CcUYNBwpy0VLkUL0BekCT++ROG4Ks7l+z9VpTz9IX/2o1huCknnvSSsnu1KloPPBPTC3fkHkN44xVEgQQRwbfPbkmvXvaRMRYserClCmwbBKyt4Gvpa/XT9EdVgOY8ou7bK9RtSqjDNUbDOSA2erVUjIESiM+5Z3hcolpuy4P/jCRYiilQkkRhW9PgTYLpEJiN7cdqqjqCX1wpBlpD8Vp8+gDXQiD9sLjzCgwT98kKiIk0n24gRYYJ4U5JPO+mcy4H2lyduRRNhv1Wzj5EQwHnRS1lP/aHWR2x2fO7AshtPVerLqqw6T2Q81qAkIYzkaQOndoOIIBjeVnyEWK8nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RESc+oX5j4cTNcPdPcUN8ZxqTg9pk9bkuVrFWVL8MjEY0PkVAuO+HO/aUJRFImdHxk609BuJUcVNxIMXkQlkqmdlr1ZhV+6Oqe2NI2oaONG6VcD4PeR6xZIVhsreCpY2N7G4cWaEml/24aJbSEg5G9x2ecFhyCv+hxnuNqxbwVn3Jn7cvURggG7wrKhyHhqwCLWcd/KZHdF0QVMXXFIZ+iRmR/hEghNns6vgOPIYZYXZQAGPgNGvdPzCYDU7UpI/b9HmodHZ5y1CQ7zraV0dje5h5N+olMFE1WWSo9qK+yX7s5n+r3tcrXQZd5yqdIMjUwgPJ9w5JTxaOyN2++VxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=rEmXCAENOjIFT1mN3LZzLViNJ1kWEeQeqVqDhC+QPxqWIJFEeuD8+21cKGffgfjJjdBsQqEOcrleq+UjiFiXNheRl+mJTVD/PvZrHqgHXOC+HfSzJu3mLpYftcQ44QH8F44GAL7BUen+FEk5WteUZv+z9r/I3qHOrU9ca5dws18=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4862.namprd04.prod.outlook.com
 (2603:10b6:805:90::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 08:56:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Thu, 3 Sep 2020
 08:56:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfSmaV4Z1Tg4VL0+Dee3d19pWQg==
Date:   Thu, 3 Sep 2020 08:56:12 +0000
Message-ID: <SN4PR0401MB3598B620E696890C100AD6A99B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ceac4d5-723e-4143-fbac-08d84fe73529
x-ms-traffictypediagnostic: SN6PR04MB4862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4862E56CA41B5CF0AD56B8509B2C0@SN6PR04MB4862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZVFB1fkIFWYZOEn96A+iOGjbc+ld0EAhe7lbEfHWTxZf3gM6kN3xh6dERm3SVzBQAckFgKwbE+20nBNQC54XIfBNtRKJYJwsxiIKXv+mPBrgJlYPHVjw/qIyMAa/2TbnYFR9OqfQljqHsFO9i1tpYJ553l8F0o5KmAnKFJBYmd/Zu3zDjjZWdew6SLpDhaSxENMhjqAFJxUo8nT+sUFUGMJka6EqxWV8HC16mnP0Itee+o/Ly/960XjTUy9W1gAatqjwh1GGZLRFz5xBFs4WO4ail1m3/0K57fDdkFbbD03ULZSouFJfsmvFVY8nu3gMCrZKM32kxNPpqqzPUP0qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(9686003)(7696005)(4326008)(55016002)(6506007)(66556008)(186003)(4270600006)(316002)(110136005)(54906003)(86362001)(66946007)(5660300002)(33656002)(19618925003)(66476007)(8676002)(52536014)(558084003)(71200400001)(66446008)(76116006)(8936002)(91956017)(478600001)(2906002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lc7acxjGZebwoE1lrhd4VueQujbNlnUnTNrsyYdeTTfNzXSFm/Y1tpNnGvQnxGyei5vF/pGjqPdSVOp8ZqyuGDOx3CekQFQypomsc2hfwoGxgwzMSqmbAo/Tr8cAh6K/nyxA27LR73VcZjYWnbSurcPAdnsC0tUoOkX7MIdsAO3vI1wTeJMRQgyQXLlOxOP7SLPhmIOA3VCzuI0E6wsVlw0TP6IgYylrLHfp55EsH5B/RxOfsgN1xl/4EBe9xk4PjBvzlK0rbb2zpqEgsM4zHJHsNb83IyUAmM/zjqjG07U//NhPDNz16o5kVUxnTdQ4D5j+bf/4K3/WTH8nBLyFWpljHEXFbMd19CvMiOaKLgmukrDf7Zpn2ZupqfX+i+Z7GGaQILDJPfwQEPEQ04JjUISwwdp7RM2/8yC+cQt21n3N+NKyuZ23Yu5vnyqCLv1746bGbg6QOMdCt5sd5nUHIxGNj2THwCrgmtaSujiRSliXVpq8VfU8iAoJygfehaIYf8WYsm1E9+3eZDeAMXO8QU+pYZqqk2hRLryqBDVKPagJgQ4PtC7tW9MBxn1FIgHo1WrfwoHL8DJmQmjxxelMbuX1NOXYh8kt2a2IWsYdVdMXs6SlxTljFoAJZt3fxsjxfmltaWVZ3rIc+xEMKBUNTzzY/DVNVrhB5soFhSAw2uhg+bgrdtxDPDYM2evJsD7RXYJAHAnjpHHb3IlPcUlNMg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ceac4d5-723e-4143-fbac-08d84fe73529
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 08:56:12.0079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVpbtcJiMDyF9NqfmWxUvGGI4rczP8W5RMWjsGKiOCzq6EzBto+NC2XcosJ1sl4d09o7nrbnq5BmWJukGopev0jtw1UZquw/6jTixPsnNIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4862
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
