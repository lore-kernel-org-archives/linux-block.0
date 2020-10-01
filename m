Return-Path: <SRS0=e+pS=DI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F42C4727C
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A095721531
	for <linux-block@archiver.kernel.org>; Thu,  1 Oct 2020 10:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OWcvP9Bj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ScHZGbVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgJAK0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Oct 2020 06:26:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33434 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgJAK0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Oct 2020 06:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601547984; x=1633083984;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OWcvP9BjnzpeTuny0l0AGVdpCLEPCDQqfWWohNWml9BeUEE5tUvBJ5BL
   f3b4qpZACwLFvjAYb8YoXb4AOyKApN3eTVwE7FJWPKi0kkdFkxbw6GbeC
   2QHq/su0AwLx6GkBUQGQLqdx5np8iwUTOzWoHWr4MQzq+M/w1D7UnsBFW
   gtmTSk0RdB7aE8cg87K8L0+LzqY1GqJO6m94YCS32ySHgiTqRRPMdGzZN
   6M2FTf73EpS6swvSunB5UYFdFJlblhmwBf5Go9d0WnLCnmNsB6jPNUBMe
   7JD2DN6cOlBaPnm5cZ76XlCImsmU+MAVXFmvifHAmlFS7iyCJ/e7kDSXg
   Q==;
IronPort-SDR: ShQRztLl4jR+8H9V/zlUBpVv2eet5Sdh5mJgejPvcvJs7JERmcb3xUULak8QWfadt2S7cOxVgB
 KpLUA5+hblEu9vwfX4E3SaoIDqZlNj4bp8C20toa0e1I5D6v55GcscIy3saLWFlSYP8fTFWABZ
 2xrM7L0yU2CB+6XkgccHJh5QJSpzZivSHxePuzziLLaXtULfXwmIAj34p2LDFzOephdQkMpfZl
 uHD+ciqv/D0GglHhn3g2J0yqFIUK+JKE72MUpn4X2nFq7rINqkYaApbf4hEXUb7wFI/Re+au43
 7TI=
X-IronPort-AV: E=Sophos;i="5.77,323,1596470400"; 
   d="scan'208";a="149982583"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2020 18:26:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPkuHeu0nNWQDQJJdMciKUuDZUAEhaP6StX+6QIB8m7mXGJaXcqnPzyKAONMghfXQy0TAjuYHIMhEAmOPSRvxgoSdXCNC/T8Mp6XGgK8bm61GcFMxtIKZ1Occfr6gibSrKssEANKN7jE0sroSKs2bAv08AepQyZQRFCKvHp/7MuQCujvWTqNLXS5t/gx8uYEugOXLJGlGBFLelSHqJZUkuNNBvEfxFdVVTclP49GPUVw+xby3SvDNGJfepOfpItsamnwnFRKHNuVbwtjxM95EN49ek0bNwsOy4Vg5rlzPYDLd0UqHEoB3dEMlyrDESPV5Njq8lFFRasT4I3zwZsX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AlmafjCFFS12SV7X+TmHQAd7jxZtObDrSerGZ5pr6nm2UHwrbDgE4C1JHj4eUeyQhHq2h10R2C0elvfxOfNsrCN/2aipO7QcKedgGdHneZRxvGCYDjaYm3AoGv5Ql7djVuEBZobP/Op4/Is+WSGLFdVAtW5mxvEoGZEiOGmwLx+ouXYrTLycC68Mgb/dSM3gwsoH2rJnASJOwAtDB8dGS/mhQ3fanTlpE/bCXDpMi1a+ZR0Qdb5AIlMuBdxa4xhd1rDk9jAKiTVBr14aDtOzMzVDCAjc5ub1I8/hxZ8rB2FbuTK+65SMp8q0ADO6rTgHG0y1Kq07zQT6Vt9ceUX8vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ScHZGbVvpxFhyJxZN92JnnW1VjotjR1MTF9KCzFKD1tvcyPGfVFxqidbl5Az9qKJ4PV0/1cg8JduSlPg8V8sDIlerMg7G0+5eq6qsLAv3uHH/1j7Gwyk0yH8/uGbLyFaskcY9gF5Yyo5CedSZwvrOgA9QfXvY6j/sDcRyC6+A84=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 1 Oct
 2020 10:26:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3412.029; Thu, 1 Oct 2020
 10:26:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 1/3] common/rc: Add _test_dev_max_active_zones()
 helper function
Thread-Topic: [PATCH blktests 1/3] common/rc: Add _test_dev_max_active_zones()
 helper function
Thread-Index: AQHWl9vQwWK5Bd7Xaky6Ipnt4Jb38Q==
Date:   Thu, 1 Oct 2020 10:26:22 +0000
Message-ID: <SN4PR0401MB359844A3A227AFA34C867A7A9B300@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201001101531.333879-1-shinichiro.kawasaki@wdc.com>
 <20201001101531.333879-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:a4b7:4173:7208:fe59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2397b321-30e9-47e5-b133-08d865f471b1
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44646C2C1B136B40068CCC259B300@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyvWBUw8akhhPpzX/BiEcLdgKSCVyU3CpTm3EH6XrllsIK4rjXlZTLjpTkgBrKkUVYokqb/ALupEPVuZq2YaHvMW9TrwLfP5z6hvpeDE+5426sblHX+ZILNiAlXuQZ+AHDd9sk36BOefKnvHoS4Yie/DpFI/po4RV6SRyzT7ujP3usoffrBe2fvVjnbER82ADhZC9ra/Vx+RM1/XXDZyz7JJCrAw2jIPMTinCgt9trLLVHWCB3DXmK/eALbF5DilYmNZROLc9RQxDwyIojMrTbr8UDQTl0ViXX9vjkeHC/9lBF2ZHLDiI0c9+jvEx5ZmGPi+Beg00SYt2MwM0IIZLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(316002)(19618925003)(71200400001)(186003)(54906003)(7696005)(6506007)(110136005)(91956017)(2906002)(478600001)(33656002)(76116006)(55016002)(86362001)(558084003)(9686003)(5660300002)(66446008)(8936002)(8676002)(66476007)(52536014)(64756008)(66556008)(4270600006)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B3YPga7kPF0rRVyK78tGvy2/b5kIFWWuZzHTBm1FAxGIS2Kzo3pM8sxwkPKltjgeWd83YUIXBEOmEUB+DTtJ64xXf+1Br9FHN3s1Yjhe7QPdRkj0ARGSaZ9W3gjpH+ZBmNIBfu00oDYQQ5pHB9XFMomwuj3muwUJHnda7kJDs4lSgPY3KHjm//2UtoTcwIyaouvGX0GG5EpPD70hVsEQjEmGzDkvda/R5qHPtMI77qPNoXvigHvUQY2J28e6UygmRGabkc1XqJSqn2bSwhFJH/Ajujch5UtfO+tBOjH1AGYaHiTVmIhK4LyMUdajYNjF8XS4XfkPW52O9WUPGWHTCjH0a5zhlN6+2A7ITIsYUI9uNv4wMuSbhg9EX4dNzho6mGYFP50KWBCsKXHnqlZs4bP+TOQOkJGi5Y1+fCXw1nCppdGPyQml5BI1fh0HIF5zLQOKE1W3vHL5Z8vTKkg/yn0PlNmLPMCB1wLeyr5aTaZvyfQ0dmufLfB1MN0lnvhgkRQgF0klEYhKrC7fAcBsMX4eNd1i05l849IZYETdO0gCeBeI2bL8lg8sQjmKxzPGKiCFoX/5akzSXjDYAbNkpCnbrLKDYWJNTLe/1jpoys/MOuPwkWPJFWHW8hWGpjVdDuQk+VKvtQkFJpsQY4CjjrMUb5MdVhaypQQCoRNKymLgNydzSyh4PLOX38cLLCeM6juTu0c7R0YLPVZUmokH5A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2397b321-30e9-47e5-b133-08d865f471b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 10:26:22.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTIqnWczujr+ETZwyWQ701yRIGcnz8NkEJo+UfsJDObexExkViMEfR5jfdu86C2N5G4WijhtbpmUDLW04MHb5li7/EBJfvji7zgsyG9XjdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
