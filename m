Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE69C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD132071B
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DVAgVz+X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bOE84Agr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgC0QFd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:05:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35398 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgC0QFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585325132; x=1616861132;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QBATsvaUGn/tldLgNQtDDiaBoatR8T+75eyrDPZuLfA=;
  b=DVAgVz+Xagc6UD0mJ7i3ZVsRpYyGBgXhXgcv41mrcMy/q3Na7utSqjgO
   qs+izgTiswS2V6iuaVsvxjlKGa+opWK7qEFowPKssUp5ZT5YK4ruWSmbK
   ISM8YKSA7U4RlRwsAebeCEXb6hultXRDaDquSUBAvGUEtvFUbsiSC8RwK
   sR5xBz+r3dc51gdUkIp3IYVhuc36aUq7NC/2atFlk0TwZBg/WpMZa1w0G
   wFwA6q3FINReoiF6dO+/shMP+lWT5ZzU3Ux2VIJaKdoVE4Vo4fy4Msm9X
   GVaS/dm/pKWpzt3MpmNZWP430ExSz3XxraL6GsuhNpP+CZvz1qzXerfBe
   Q==;
IronPort-SDR: NWvRDBoSRm5SBsXxGN1zSW//gfHoaVt7HCdC0n5M05zM4mwKRX+52aeqHghrc5gfhMUYvKCF8/
 55BZDGYFyUTxQGN5NfbdcqkIDP72J7TnRMRnaMvitynxwecW9ZwCEDckyT/iAJNcdOnpLyM52R
 3hIOCujBLezhrRIFumjTMUyyIkSbhjaDhzlsRsAsOzaLelcoZf0cT3rNpw/ZQa0rSWzoaZNupS
 Wqxu3nYc+HQP0z1J+CcGtb4ROv9D8QNypXSS+LuRoyfe9UOHqeMfq0TsChfByDYlr5IR0MKxMW
 ais=
X-IronPort-AV: E=Sophos;i="5.72,313,1580745600"; 
   d="scan'208";a="242207287"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 00:05:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIzESR0DVbjvPMR8AQp85PydjPI5qG7Sm7an+aFh93h0uFaAJ9+oRl7088BtEO7F5jOdSSMkq3tLkIasBASiY/tr0w32T/QsGNBGsdCG2gDoz2RYspy1WDACvQPpToaVdiTwRPlC6kepca5rjPwoTm5j9jLDbvi8RMTOMlwFbkgpg3bH8nHXFXa6QOCOstB4ahmjjkYZ8JsWBS6cIW+IU9osvFU+uklvH18kedW5tQ+3dNZLrizsbLCg8YZrfpgp/QZUUHob9gMewgqX6zqwlJBWrBVr5p6BeFedx0V0hbnMExOa4Ckh0ICV0FBh2D8zjxUbQIDwzVdHNGpd++GCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBATsvaUGn/tldLgNQtDDiaBoatR8T+75eyrDPZuLfA=;
 b=lh69VTRck+0obFtTR9VwdxyRCcS2TJdyNnqaoylI3ysP6ZajzwxZNIj0QC7cVXWHmNuKcCZfMZ7sh2YuJ46Y6Iwqg0eNIn8HtAojiO3rsR54EF4TjX5qMWVapA8tyS2QGge393tM3lq2LFOYB5QHmc28LT5kdsZ9kKClwsQJGy6btOz7OqF3lAIvUBeDhDUAux27fFKaXBokYqNlUUYFdWlG0JV9JYPoOM5u0cctfq9HpSkSl4zFADNI9jsioyo6ZxfQjnTE7afAPV/KJi7KKNicgRGFaImot1osjPeqS7ddYKBES1RbB4TjYngb97IhZ4ABcHtehHyIQwC6GRqI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBATsvaUGn/tldLgNQtDDiaBoatR8T+75eyrDPZuLfA=;
 b=bOE84Agrt3tweP0iDPN0Fe0vScz/Dlcr3msJlJJGlg/BH7tGD4r0qfftVwVcDVWvN9Jk+8MiEW0s93/HR7J5SjIvpg5uVb1dzqDOR3dZwodXG0WrnAEmqMnoV3g1+PkokyHnMaMdVBNd/F/sojeafaLmb0o8vfJ+o4WcEcmWA4Y=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2328.namprd04.prod.outlook.com (2603:10b6:102:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 16:05:30 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 16:05:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Topic: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Index: AQHWAlR/C6ezoVBvH0Skn3eTheZBNQ==
Date:   Fri, 27 Mar 2020 16:05:30 +0000
Message-ID: <CO2PR04MB2343F7076EE9192F1015C34FE7CC0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <093c4ab1-924f-b109-31a8-ce5813f52e14@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4613ddd3-f1f4-4070-85ff-08d7d268ac5d
x-ms-traffictypediagnostic: CO2PR04MB2328:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB2328A09C5FF1FFDB726FBAE6E7CC0@CO2PR04MB2328.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(81156014)(8676002)(8936002)(71200400001)(81166006)(4744005)(55016002)(9686003)(7696005)(86362001)(2906002)(6636002)(110136005)(33656002)(66446008)(26005)(53546011)(6506007)(186003)(64756008)(66946007)(4326008)(5660300002)(66556008)(498600001)(91956017)(52536014)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBAwKiqKgq+B8gGS0e2Yj3Ekk4W/LCyMMkTg8NwSOg2yPrOUEcw1P6JsdZG+3Wx5RaBgimMWMwfwnDdZu6/XavnFUR0Fz80ZFpzTtgUHiysqArkvIBh8W5SmzoyCN0VTAjAruyfb3KmhGnnYaU/febshe3PJmH9/jFUrKfhDH8nzjeiL4hMMdbW2QffjomGOYR3Rd4Ihf+dYOv8tPIzqviU7GbVgWQ9rFPXXq4P6Y9WYqbS1egEEEsIc8L+Agdm4kncgHdD9xjOuB9U+0c9Y3ltAsN6I2rTW3nqHzpMjbgMvCmi4kf3JVbBzSop5t8CS7DCKnxieehE9BbS5vGJqo56rPE0aRV/ZIq0ITvjSidgqHIcXSSwSsfg/dN/vbAzwmZwBOM3L7vq1JEyZdqeXlXSDgil6PJvNxuAk1JcjR9HM+VAENAZJa33iC20kb5ip
x-ms-exchange-antispam-messagedata: NhLeWytBilk3EMgK2/MjXZX/S3CkzvYJRxU5IF8nQciYnJb5Q6YVvERfa2pIj72D1AIemr1ByFFB/TBQWf468qDMh5MpoLassvIW/dT0H27+GCidUVrSWnF/KfMBt7tqnO4/cMe6yfk0Pw9Isszx4w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4613ddd3-f1f4-4070-85ff-08d7d268ac5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 16:05:30.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HS0iW3UHIoeHt4zU9VWohE0xwQQ1j4vMUDry5/Tz0ttRLw6qtjbPBOWxqyrxJKMUUBNuQz+mHauqyyS0hmtCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2328
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/03/28 0:35, Jens Axboe wrote:=0A=
> On 3/26/20 9:12 PM, Chaitanya Kulkarni wrote:=0A=
>> Hi Jens,=0A=
>>=0A=
>> Can we get this in ?=0A=
> =0A=
> There still seems to be the unresolved issue of the function=0A=
> declaration. I agree that we should not have a declaration for=0A=
> a function if CONFIG_BLK_DEV_ZONED isn't set, so move it under=0A=
> the existing ifdef.=0A=
=0A=
The latest v4 series that Chaitanya posted addressed this issue.=0A=
The subject of this email is indeed v3 though...=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
