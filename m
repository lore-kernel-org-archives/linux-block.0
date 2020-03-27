Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64340C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371FD20787
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 03:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rma5bgJA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DuaPenVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgC0DM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:12:26 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42216 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgC0DM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 23:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585278746; x=1616814746;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hE/ltUq1W9Q7xgWZGg9Hv4nrz9WspWlOpULc3yJRdIM=;
  b=Rma5bgJAIpMP8RO/iMZCA+i7Y6f2uh4GsYshQRbNgbnDUfqWTvQFC6rE
   DdsnM5ODD0l7Zm5oQnTUuIFtVOpBu8eUFAginzePcMQKs0w67f2XJX5Af
   vXbsXxGZEuhPeeXYgdDuw4kzQd9yKvu4oM8arBIvlUdKHhptgPJpj6zsh
   bOszhuth3SZ0HBH05dRfhLStwOTNjzYVNCXgOcCYeMpsav+B5XtSuMyBt
   WFBbEyaImV0ZKxs6I/ynJVac0YxAjnNicYx23wkvsyo7ldgtfdgQbKXII
   IrmtMdnSrInKyxHZnVKLzl4f+8xoo07DdcbPzFsZI9qBUhBb/ammhLz96
   w==;
IronPort-SDR: tw4aljDpAURFbd3/vgXnOmgRiXl3chDLmFjuo7j5qV1fw4kGJ6OjbX0CxZbG7doOqToUuk510k
 cE2FLge5LgsCun8DbtGzK7vrnn6c393BNJpMGkBrO4Xtrhz+cNkiqiMpOkb5SlDU5exid4miRX
 XvsCGetHnXgzCAUOUo981l5SHUz+pQuMbsCZhV2/4ZK6HJf3k9remiG/Wj8VocM5lTZ2qL+784
 efDXu/dLlb0nVuNov9ufYKDSBOmR9ErwfxxN6MKt2Z/7zQIzN7fiLunPZ8N6oo6c9Pzbiqsfnp
 HNw=
X-IronPort-AV: E=Sophos;i="5.72,310,1580745600"; 
   d="scan'208";a="135080859"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2020 11:12:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb9IrChMc/Cq+IDz5Hw0SE6Lcg3WLezhokjp7eu9n2v+J1zu75JKZ7BUa2XUMiKbEqmTDX/hEEAFN+PNIC34U4vKNoJfpZj7H4CKV5FqVTmoeLCUTiEVVJRyiZqEvW0RFOU2gfhFFSutzgQnuGKMCrBAz0uz4K5kFFXINkGWGGJU6tzcHVg5Qr0B6FAMsbNYJKXrcpAJXbUFpEf42EGv/CDJVYqrhregWCwdYOCXw26pBoppD4cQ7TnWDvZlXh5pTMBntLGUWLCXvCrmGMuYPC8s8cyyX+A2ijvqwQIGAl3tutYnbkdCVNLViaKAsURXAh0MPYutz2FwPglbO3mTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE/ltUq1W9Q7xgWZGg9Hv4nrz9WspWlOpULc3yJRdIM=;
 b=fASNaRCQ7l4UmO+yXKl+rE6nGiuw9iNh96E5/2nkFg+kLk4b8GARLlAeJDEqGu4P1wjJ1t6KaerHW5LrK2Wk+rWrzVfbovCrmz7f7tP5WyLFoyhaMLv7EwrttBxNDSgmY+FqjVUoQletw5MSLr3YHnVg0nbZA7LX6vpXancQQP09TsZh57sa5mjZvzPJ28W11+WezIyBrHqWEblTh8CuNuUiNsG/E8ECCXyLkKavawJo2qqt45AbRzzNAoMGgO7iBc9EDNM30e1aV2jXFCAtbtUF+c/3oezE2FZoHgRYEfVknOBH7l9DgvgTzqLkeOyZMbXHDBdBW0cjLFukHFJdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hE/ltUq1W9Q7xgWZGg9Hv4nrz9WspWlOpULc3yJRdIM=;
 b=DuaPenVYA5lLmiy8DxXcVtPMljITf7IbbwhNSabjO7AyWYe+oqoVXxjfNed+FNSiX74AwLKEfNm2QeIx5ed1PJL7z+kRod62HUImypazEP9qD3rIuhuBD80op7Wq+RqlyE2gAR9LkWB/0+tszxwno1IhVJ9Haw1JoVCXsqtb2bw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4070.namprd04.prod.outlook.com (2603:10b6:a02:b4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 27 Mar
 2020 03:12:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 03:12:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Topic: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
Thread-Index: AQHWAlR/KLeasVEdYkWa6OO45kCzaw==
Date:   Fri, 27 Mar 2020 03:12:22 +0000
Message-ID: <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57c26091-0704-4e9a-5d37-08d7d1fcab3f
x-ms-traffictypediagnostic: BYAPR04MB4070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB40703E4F1FCF51407F7A125E86CC0@BYAPR04MB4070.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(2906002)(186003)(5660300002)(55016002)(52536014)(26005)(4744005)(76116006)(9686003)(66556008)(66476007)(66446008)(66946007)(64756008)(6916009)(33656002)(86362001)(478600001)(54906003)(81156014)(71200400001)(4326008)(316002)(6506007)(8936002)(7696005)(8676002)(53546011)(81166006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KA/bvJgxszePCxN4UZacLzSSj+3ZhExkpqbx6MkMsXpd+BjoQ0tI77/Je5DWfhtChP9BnIC03OG/Aj0UILgaAWoUOPipVHqBjE0DFgmJhRy9VQEd1vJXlpKhUp+6LkuxjMu8AC5rNzIidHqvDwdZlmHnTQWBhm9L6LnzTQZA40An47KnoAHi0L4XItfdwAfxn2Z1rRFGZlPiXYeqfL8eCPjNO8Vei5B7Ej8xNVLfAXo1/n2PSMjRmaqaLxjgMG5aZB+yoOErcqKiZy7jWaWmGm7Ojaxs589WzW5HGKYhgug5hp8X6639mcX6EMCCJPqV24mrxqNh1xv6XR9en+c1hwQn2sHw3QaAQoYvrnBPvdfgQNx1p6H9yQO2lJ89fWz3PH2peyiKh973u38dBBDFWykyd6cira+o3y/mrm0zq0suDhcg7M1hhlEgdvaTVuYd
x-ms-exchange-antispam-messagedata: bfHMjrLUozOS+Rc3FsxYKsAjiBUmLOCMc+trkdKiiSbBIAtmFhi/uU994XbD3XRZwXeKrrZyzJILoDjBXwVq7CgtiquywWYJtJt912yPPLfcX7uhshWmUTwSQSDDXqzgU6H08qoRdVSmmyAm8cOVCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c26091-0704-4e9a-5d37-08d7d1fcab3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 03:12:22.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSFenOgZTDcRSVP2mfjhTPrHiv2PmrOjvoqU0koPH/y2ZsrNunynj9mtxxNiZlHkHXuxUpLJ19uPsvY6dzNII8OwR8v8iFSpNi3BpxZQRdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,=0A=
=0A=
Can we get this in ?=0A=
=0A=
On 03/24/2020 08:21 PM, Chaitanya Kulkarni wrote:=0A=
> Hi Jens,=0A=
>=0A=
> Recently we've added several new operations for zoned block devices=0A=
> blk-zone.c (ZBD). These operations have a direct effect on the=0A=
> zone-state machine present in the null_blk_zoned.c.=0A=
>=0A=
> This will allow us to add new testcases in blktests in order to verify=0A=
> the correct operations on the driver side.=0A=
>=0A=
> This is a small patch series which adds tracepoints for the null_blk=0A=
> block driver when configured in a zoned mode (with command line=0A=
> parameter zoned=3D1).=0A=
>=0A=
> The first patch is a prep patch that adds a helper to stringify zone=0A=
> conditions which we use in the trace, the second patch adds new=0A=
> tracepoint definitions and the third patch allows null_blk_zoned to=0A=
> trace operations.=0A=
>=0A=
> Please have a look at the end for sample test output which has tests=0A=
> for CONFIG_BLK_DEV_ZONED and !CONFIG_BLK_DEV_ZONED.=0A=
>=0A=
> Regards,=0A=
> Chaitanya=0A=
>=0A=
=0A=
