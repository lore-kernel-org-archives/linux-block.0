Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79459C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE21D206CA
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HAgLBP9f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="REhT3T0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKKIHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:07:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10760 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgKKIHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605082029; x=1636618029;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HAgLBP9fclKV8VKNx9Ih3u+SJ7t20lnJtWA3jyH2+XGRxbgwfy30vNrF
   uaWcflJ7bfJYjcrPFJdFPdU59QvFsld1UGJ+z2CgsxBWfHCC0oWxwFpW8
   IkdzIt4tYGao2sTjVzUkLUKXSkPhqGuwYoBPKsW6zFWXJ7IoG9QhTahD+
   B9jL9fbzNINZUDgdv3ibq+PXZotv/IWKWW9k1x5sk5dX+x0wDI5ABRuH9
   KR3MB0XpCJNVsbTVANzvFN775XlawemTD9fJSIeCr3JFHH0k63TwD+6B6
   cLWGzEyi4tGLrWbq65ODwgxQ0Gd92xKqFQMEBzELV5O0n50wqBPLObFZb
   Q==;
IronPort-SDR: CAtF3acqoFzHku3hHaRETPyk4warlxzmsRvPgJLa4ddJrS4tT4u/FzklW7C6ajV9tf3Vx8QMd9
 E0t8bnTS97XW/2sarRpoWHVtqmydWEAApiUoI0Dm93vTEO7g4Z2L4SdfT1HFoOKvsb6f6JaRJd
 FfmcAu4tJqmcBYCufyRRLhS/S3COxOfOwCuqDcG7wOOjY3Hm/Cabg0bFZ3LN1FYvoVvjCDJ3vL
 t3z5RUtOCpOoGfayN/x/8hIag3oo3D5YnRlQ0FKGIy9K4+araXJlVNPmA+9BAmlTeJDDgTq6Gt
 ULA=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="152464278"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhM+t7+ByroOp/ryxQ7kTJIu1jPquSx/hpPaEEbFfsBcxNkDvJmBsSFwS7FdAML6mqz34I+N3ST/eg1Jkd7gXGRG9psyYNHR+cSsFVzsD1WKcajAjjn9MgSOlLlnsVCJub5wjECwJqCktXWq8Q/FQGF5JacCWMbULqy5CMuI3Zwk9+c43xwsnAT75aciQHEXSB/ixbWBaIOXANIz1hzWPyNLa5YZ2N73jQYuDfeumaRQZE8GUQiB1pHsJLk/nvf/efkvmuiXXzKJVPSbM6tXpCoF1REdEaOuotNC0ztruyHcX+Eg13vAUwnIMoyGp+yh7gLBLl3FFsKtrUUmraD0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=H91O7Cdn+I9uk7EobBFW9Bnd2Gy045myyWWvC3a0zlvspoZvIL+BbOl4N/TqCw/yDg2Qpe+OaH+kIxaxo5MSmt8sgIqU0fe5BSDsQe/fiYtCiQeFiVCrgBsmQEac6UJD1x2vJsfJMiNngZ+pw9LMuhCuAZCw7rXHZr0b2BwEsFx/3StdO6fwqy9HrbcnHeFlWRr2SC3zRx+4MKH+KsvB7ccJb4DhCI1NxUGx16O419+FJR/eCNSjon09sevyfC1DuXcAX7S8acxuGj/jJjxYmjD6JHmVaCF1H+O97xKf/LEoWKpjtcPTQnH+DJfSeX0t4nM8LbfJL44+utEglwM30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=REhT3T0CB5+p7DAJLyakrhdDICqVsLkyonEFoItNZKt5HEnBRZyrqoQJjfaiFCdc8nJMRdyDGhjhX5h3j7TT0ZUZHCVQCT/gVjRCC60OkmRuOAmFvBqlCmrOi3H6yQuyS5GdO4YGVIbG9q+6yRl99KcjDsmJZ8jh18/v8GNQtZI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4687.namprd04.prod.outlook.com
 (2603:10b6:805:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 08:07:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:07:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 2/9] null_blk: Fail zone append to conventional zones
Thread-Topic: [PATCH v2 2/9] null_blk: Fail zone append to conventional zones
Thread-Index: AQHWt+njVAVU5NGHKkOh9lxytqg47A==
Date:   Wed, 11 Nov 2020 08:07:07 +0000
Message-ID: <SN4PR0401MB35981644132768160502EC0D9BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 402e5766-aaad-4847-15f6-08d88618c8a9
x-ms-traffictypediagnostic: SN6PR04MB4687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4687567235BEB417E66ADE9F9BE80@SN6PR04MB4687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYTxMK1SPDga22rdwxY56/+dS5PRnb32euyx60FiNpztpiXOGJyxyOKLLu10BdEd1aZv/KM6cMlC7wK9xh8GswQ/8qBNbCxwtREUVOSAvIfM+E+Vypab4zptvDRhOUkVAwXtSwOcLhjVnv0zTREg79TgxLPbAhmqPOreKhFpBbp7OQHXZ9hJM1ih/isWu6mp8XP8oHFlGLuOvducHyG9Btdy/SthMKDn4cCrkpkhli9b3h3yer3StKVrTng7nD/3sbhvt6eSFeE6srvvXuY3W9jKwypWWuBCF0dXSDvaE8eqj4zxHwsRKg1K0tmtIvXjhHwwjMJKBR2dBZN4JNh6GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(19618925003)(26005)(4270600006)(316002)(8936002)(478600001)(55016002)(110136005)(33656002)(558084003)(71200400001)(66946007)(52536014)(2906002)(6506007)(66476007)(66556008)(5660300002)(66446008)(9686003)(64756008)(7696005)(8676002)(186003)(91956017)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: YoBbSM65x+cemMmx8ZM6JWS3xsNXmVieOoDWFurdJr5e49bHB+8wj7kJCsoyErcGO3Bi46KBNzOWvsLvi31mpoBU6Qna5LPRujoA3D3IUa8PNOseHfTpDMhVeuKMtnPTYvy7FuyRkkxE0RfCHG1ilSGlIJIMVlqBrhTqw5WQU29vALy8JfsRgaFynRXCPs1NNrYj7UqHjrVukvCX7B1ncgsPYrL4fbKYeV3/EaOD9yfT+NCzSKRQOf7p8/BYKrqv00RTMmAP8DvsyOr6igkVvpv8IQaEVLuj8V8bxkmOg8gibF+8HdaCjxZeMVNZjSl4cqxLNoGgbyDe6Yn5R/llZQkTt3ml/jYEocdI0FdOwHiEGo31izaTL1tdrVmYVwp+nbXtijJNROR5Svvb5ZghOI1gDmnwsBHdx6ffQjZl7ye7GhzsC8gy2s/FPccXYKOxuc8QafKhm0O4SoTMyMjxRH45C2cAZqjjrC0oXN5KSfXIDn5171N0AzpskMPNyU211rB71XYeuuKemtZRSbd3x52sHONA4vNiDRqG9FWSfhPEt5uKfniZHaufASUQ3einTcbWZmaX1XF4+xEpq+3gfWDCrZApkzqnu2FtU/77qt2QNh+mbN41Blf7M5lbukd8Wy838C/JjDj/1pB12BMusw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402e5766-aaad-4847-15f6-08d88618c8a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:07:07.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWEV19y00WS47c6/dCX9L//J/uLIlRGitqGuWLOynPsJvHxKvMZpKAjXm7kacdmFkpePIC87vdyX3v+XDa7cSMNvF8XQp6YeptKQ22va7+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4687
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
