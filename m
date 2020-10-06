Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C63C4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677E620FC3
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 23:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nnVPaBpE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RuplAx7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJFXoX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 19:44:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:21578 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFXoX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 19:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602027862; x=1633563862;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=azUc6zCPKUxBs7wESsBO0mvUWsHfExYQvwdbnS0+dts=;
  b=nnVPaBpEW+r86yr1Gk56ChUX2+3Jue3bwxRPSlT+bHZ6PDW5nKPSJEeK
   aT0dISk7DmqdJfY8TulZ9aaHX8PO7giZhBZQtdGYATabOFd6szkeQEqhU
   kehxFBRK/Nx9ae1KChYax53pCs6szoDYff+6/tdp2apjt9xpLD1omQolc
   LYx+pfnlDOK8LORSP5J5cAqNF1NqvZZFNJhpH4zBtALj7bpC2eHIYwpnX
   AqiqIpsjSTplHJAaSuXvPw41jwYZtRHQZMaHf2WCGZQ7LlU/fLewChGrI
   jPh8g3CrmlVPzznlWmKQTyIsAnymRmCBvNZh9T9+UAIsUV7bkJqyM//kw
   g==;
IronPort-SDR: gJqeKioDrCC+Xz76fLNpo8ajiVzjv9D0CKSmjLpGEPS2494IOlnLRnvIvTWS2ezUghRgJTtryL
 YrADVDc8l0zvoXvSVaSBVvtFAYSn5gC0CYQ3dTEKwj9AM0QbnnpLT5qqqFVEmXhjwLiJ26sP53
 p3c6WRgsL3aIWQW5EHGn0GcD6Xo1qdEU1W4rwXbfDCrliV4fELe8anOSYl3WGIqbNfJpGj81VC
 ljC8JLiBqenMbOX0/MxLimTgMwBCGu5+FhHykCaWVbjFn4lAphapUk6Bo+0uNyBMas06oZSvo+
 Kac=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; 
   d="scan'208";a="259009219"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:44:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdmOjYiGmVNSvAT2bZtLvU5mWdtsdkChvNVQJ3zoavNzdV5xJzmbLUwRZq79nyDH9aOUna0XsfiMRRfIZDtHEhsMmuwJd++c4AxDaLzgyvPJV9hv4amseC50JtuJxmDUC8VVevUQHlUzeA4OCXCgAZP7URtyqiolSMRoBQMIHw+SItd//MHMPQcsj1UayR515BY/a3QCctr/FWEZaXEvloodizyvVqxwFG8n4YYSyPZxOyefHmj13Wcdrs3HsNdxiWdw9eSWnZQ92/8ZRMB6BgxWWIeGzv/rVaw0YDQtXLMA1Tc7b4kk10mCC0y9R76A78ttcrPDWhjqw7Ssy6t56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlBoIPcJGSJCd7kntsajkKusjQcmLRECox1GtfrE4q0=;
 b=HakbkFxGfs8aKP1OBkMK0Qjy9s/I/yZN73BY8QeCFgGVsomvXmErTBwz+v09ioieQsRxIwxJyfrGk0XLRRitDztrls8LzK8HeqPonQRW30dV0qQiPDoCoXIr5lR8a44j1LaQ4Id09L3TRmi/EDBvx1qut8N7xU5lkkSBonLTFhaz252KhqA4jkdZKg/39j/0qMDukC3EIKp65cRUmkqyIomX9GoPb3OLlCd9rfXw8cEh7SoOr5QtMZO1C96Xv4xVwkfODVPmaaGaSBqhq4M1QvvsqtRvp+Wxsir2QPxgTwvboKFN2qAMzr4H0MZm4SeekmVQsOpFoGcbczO53ixUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlBoIPcJGSJCd7kntsajkKusjQcmLRECox1GtfrE4q0=;
 b=RuplAx7+EQOVQkvEU0tc79vxUox1A0NkPKyHvoERYWiVgs4Un9mtOI2OuqAP7x6gahDIpLK6CJKCCNH5XyMsFJ7U0elZ+D8mnhRNDG5ci3s/xH08iQFDo7wygQo/HKEU61rgau1T2/5yfDV8qLz5IumlG5Ap8wqj8h7fpe1yr34=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 6 Oct
 2020 23:44:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:44:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Topic: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Index: AQHWl1sou8OL2CxeA0mV1a+SBBjD2A==
Date:   Tue, 6 Oct 2020 23:44:20 +0000
Message-ID: <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2946aa9-cd3e-4279-2021-08d86a51bf8c
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB4325204860729529A7DBAF1C860D0@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xyCKWu1t+Zs4olYyDogqNJM7sB78FM3zzsTdPk+mJONKH/1o4QY1DFY8eDbXLWcnDqOecQNRBPdLYRVmLdstX78aU9RmOxYdvb5IYZqg+G9kRBm9/1XGFOvfcsdR8+94typE+XHnsHig7kCVS0awBolfKBC0okZh2FVtvtR8/369yjw7tV7448gtYE1eHhzR/ei2Yr8VumJOZKBM9rev9x1UjDrkgPul3SvQtYofcAUe7GSd/tX24ej91hbjcyGQ4IiEEEuokO69o2pww73yuABgTTUdG9Z31hPL9G1LOpsSutFRpS3aATx/nwqEHME
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(66446008)(2906002)(66476007)(66946007)(64756008)(66556008)(76116006)(8676002)(6506007)(53546011)(186003)(26005)(558084003)(498600001)(7696005)(52536014)(4326008)(54906003)(8936002)(110136005)(5660300002)(55016002)(9686003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OeUB8vQwtUf+7UtUnE5MuHCjrtfGccztnki6zJRxrx84TjOJa7j8OiK3Jq7I4hgZNn/uw9xK6/fxUssYxKDAX8NmD2fEAa3Gun3j3QUkRSLOSPyiUpq1bMHF13j9boMcYpjGAmN208gUpbO+ldXxSu+BrvuieXS490kSx8UnniBt9aJe/SF3pyR4Ddxq6Wx+z7j7/gkVvuvnQOic8iZyx8M2+BTGEtcsmZv348Sg0TgERKrSQsXmREiCf//hG7VMjTbfrKrb/itONeH65Rt97fckKlnQH0vOS70igM6kTFcKSDkQw6ME39JxA5FGgbfDXwlNH+ihpsetvykwb58RwuGpo5CvuYaF+DuNGSdphJhSUk/6ejf2TULKAk2Bgb/DpTeMuh+yc4W+sq/TLs0dKC4P6/XDxyu+bKw8yE3CrwQY6CpV5yNg3iRayCM4VcNXTzB5IoUJX5vPUt5WzlUGry9sGQjCytn7zRaTSM9HeUX2MmOufWA16Sa3j225hBtQAcUhuMBGt+IanVMkbRRHkD1i5v3uS8QYjSCDH/u6AZBC1m5sCUrSmaQFIh96M6rzO1VqxtqhcqkrmaKbctC+zp29n6qvYscRqqEP+UgR9sDSbJ1XNvMgAskv1euCLmcTm3gEFSP4H21W2+LzBAX89A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2946aa9-cd3e-4279-2021-08d86a51bf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:44:20.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaTniBC/tTLy7RwpurfJrubVTcRfRJJCawNAUvMZTsPMSkv4Ds/5ppxJ1XcuiHcPzi23NFsgDVcxIHopeh9ODkMWYueVEvKV8FeArK2NdYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/20 11:54, Logan Gunthorpe wrote:=0A=
>  =0A=
>  requires() {=0A=
>  	_nvme_requires=0A=
> -	_have_program mkfs.xfs && _have_fio=0A=
> +	_have_xfs=0A=
> +	_have_fio=0A=
Can you make _have_xfs return true false ? so it can be used with && ?=0A=
