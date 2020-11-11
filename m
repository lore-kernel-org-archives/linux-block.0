Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF4EC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF65206F1
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iLCuK913";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eCQigAHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgKKITe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:19:34 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46899 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKIT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605082769; x=1636618769;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6a+m5tWoPOPm/WjpnBipe8I8iI4prlhYbEK8vlTbyUQ=;
  b=iLCuK913cwXXjZ1D/PokJTcRlU7hMrxReFS5ODjO7qmlyDKnEY1tzpAk
   ScY8UHgrKMpEJqrG/dFL0Sp1jTIPA1kKLwUzjFi6e1atLbYHIza+EQ9A+
   yJj/QS5CoPt6qTw12ARcXjGRENKRD0qURNYf0xGi0+651vB6kr3F2SyRi
   tVa893ox85ArQb9Qh/ybs0Zeo1QetGA9E0rCZY1akAEIiTF5jY2rHsKbJ
   40aN/9NFMQIXQRFOZoLf5J8QNIS5AY/EEhbdXyCCzQrZ32D7AA2wpUUHG
   0XVUY6XUGsbpKUg8DiegJN7b5t8wKbtpaAgKIH4zJC0Lket3BLtN30V08
   w==;
IronPort-SDR: hj95QqIn05wtBxlCAwDMrP14axwBUd2grLv/G+WcGch7CvzA9s08Q1q1BTjS9H7JXYyMSJiqux
 +kLp2efnZH3A3E87Mm7gtm0XaH5y2NHIbHYZkLP2CKf7bK+gSlJHjY4i5+NSdPnz/vHpMTw4nX
 qiBvlzyfCRi95RBd5V9ugIM3OKkKQsIlXTRtLxsb0JjCN3CWRvIjx+0/BkVyAyIBFQxkU2fMRK
 Ghe0Kfm0IsKm14UWU3Flge6ZTjeqR+OXgnGfGqy546Nb9GD1wW6B3MuqUwM4BM0J7boODXciGW
 Tlc=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="262373466"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4GB4KoQswmWlVexWj3MTFRkVNDpcfs11zfz53lIYS00W65UbHWJeSVS6+er9dwAnDtfsRj9lTvQdd2LwLsDiNdyxFnN9EfI7MLb4KS7ZkWEbvlEAkMmLIQVbb0gznr4mJXbbzAbS5NZ5/3CHcAEuUoQGeIFQ/TXj169TdNte7L1pWZba8IBKEdhBK727hUk8WwU/891kfAjsoYDWNPgmz1YcaLFSGi0Vv6DSPFjEnMw5U7p5dd9D6l1+7gRm1CN5U9Zf/5IZfmquHwu2cYp7+uLORK6nC5uND1U0nynxBqDEVUtJ2NA4qLJNJ3IW7Vn4x/EjOl3Kb4f2AIvCl0XTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a+m5tWoPOPm/WjpnBipe8I8iI4prlhYbEK8vlTbyUQ=;
 b=IfDBXkwWuHa2FpKnPQ4nPBjNcnp/lcrrtCZpOniMlvpOfA4/hZEeib7GdcJ+pHsq+aDT9MqGqmJOsS3QZuevxpNhuIhwzHlbenLac/0rBceYT7vEypsDap4VV22vwOywSkGdAwx2RL9nj6I+WwZC2xMQHZcDk09xVI3xnGCY27F+4ieJdrR2pcynARVbkShNcN2yfVhZXv28p7rEcLuyNZw3uQDYSCuezwEUjv2Zb7hfKsDOohxS8cT+oSylKCvtvKl0+7vfYxgu5AHN2n6Cpdi5uyniN07oGkdYvrtZWdVuq5+6y4HifZ4BV/A8/QJ+ED0+Au8AuX8swxgnFOHxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a+m5tWoPOPm/WjpnBipe8I8iI4prlhYbEK8vlTbyUQ=;
 b=eCQigAHFlaUocYKyMOmO3zxKGAAxaUtklHqSfWfs302SE6SxQXo2+H7SRtJR/uyecGjHJ+jed6+jcfHTg9VqN4gpTRbOJEKDLrk4Bnc20vRl45pb6f0EPyE4Yaw/J3n9f/KkodvDuT2IegNYwTxmb/3f9z1VIvxMMwGXWGzjbRg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5165.namprd04.prod.outlook.com
 (2603:10b6:805:9b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 08:19:26 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:19:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 7/9] null_blk: discard zones on reset
Thread-Topic: [PATCH v2 7/9] null_blk: discard zones on reset
Thread-Index: AQHWt+nkpUJ2702P4k+gJ31oF4HQkg==
Date:   Wed, 11 Nov 2020 08:19:26 +0000
Message-ID: <SN4PR0401MB35986F3D8B058A29C5D1C4509BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-8-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 002d4395-b705-4f1d-944b-08d8861a80e1
x-ms-traffictypediagnostic: SN6PR04MB5165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5165738C1619D43408F8E3649BE80@SN6PR04MB5165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPTTB+Jm3NT32CF7yb7vDOi44h0NkH6GSsYOaNLQUfhffB8NFCP0TFv68hrZ3j2plUY+FZbvy8LmzEmJWd9uRgja7VfSEg2X5Zepjk9NtXJgOCju/FYcTPnafsIje/gKHzV4/HYqyElDq4IxdN6VzvzOJv5KyaMgsi6U7xaNAeCjVf6nDt94rih7VRhIzPhLELEvRgB8QUI10c1oeGS+dVtxiVi5z/9KNBQb7HiS8RJisFNwOguTFmYMjKlhQJ+rV5lUygtatQrNgITe7g1PlLos5zFGfK2x1o5TttSiq6ShwqssyIWynfEWo47mP4lNiJ5qp2kjBIhZwYEXV7dMdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(478600001)(26005)(186003)(110136005)(558084003)(71200400001)(6506007)(55016002)(33656002)(19618925003)(9686003)(8676002)(2906002)(52536014)(8936002)(86362001)(4270600006)(7696005)(66476007)(66446008)(5660300002)(66946007)(66556008)(76116006)(91956017)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SSAksV7uDi5N3dEZnnt6URNPt+6N7r3fDdpW9rwPW4wfCKwUBmfTpb6WuXz2nSIUNTK1m3fSqoV1nljDPSFnE4UUfipUbYyrsm4u+Dago5KwGX9jkZeTnxapOyHBRAmcRsw2wmFbqeI+aTRtWEnfzhCYkDvEiU/duzjczFaMykrTPXQwhLAVphlAv/nMDmY7VgYJY7vC8a35fLxzESJbrLQ+FYkyf2djgBz7Nage75iO6M2OcHBgNUpKrrHw9CZi1a2AvC4Ry/Poi16KjPPytoo1tq5iDwQYUHrSMqztqiQWkk1pTECqqWAh6VbOkhSkecNZak4QYACk25Pj2wl+L2sNtbyh6vE1SgujFwpiSJ/CACfLSAcATpyPl2qdoWMSY6W/Lf/T+Vd5OEaKlZBZAsg8iNCJSuw8260dZFwLJH31Xob8uQcfUPa84NmoXFuw5BM7yCLCyQSSxNh31vIbHJ699HyZ7QvlI2DwHpvMw9HoJMz2K6TwesTowy4O0v9gWKxrvSLZEX1kQBE+qE51nrx88Si0/jy7VOxcT1LnZXC79cV822s+qHH7hjNvGUFFYw4YnytfBQoiqpS+EC2AkfD9Sz1d03ZL717cg9GA5lBmsH8sgBGSpmgER2RVfidxmS2DW0lzCPwYR5JfCHwoPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d4395-b705-4f1d-944b-08d8861a80e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:19:26.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epE4luYu9s8WTTI6wsmhIPiZSSqn/QC/74A5ffBdAvxt9cOtBGUqAyY6S9YE3Vq1Nyhfvvsp0kzdGOniw4S2y3TcnNIZubpNlxgsnRQwxIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5165
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sounds reasonable,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
