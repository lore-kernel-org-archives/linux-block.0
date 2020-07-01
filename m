Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A5C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EDCD206A1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fumtQXXq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VEm0+8fc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGAHbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:31:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44317 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGAHbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588711; x=1625124711;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=fumtQXXqcHs8/paI6gj3auMDvLOHjgiYL+GLnVAyZz2LuV+qWNji6ILj
   mANTyrVHLYtK1DU7IDeVjg1hVwUuTx9thDSqSa+QzvsAt8JHiQuYvsVq5
   F+KoOuIHjYZHhGv36QBLmDIofLmU1EIkBMpBIzLe1wCpFXNz++IZxUQLY
   5KoRh2VMcxF32RNSOUrWr127WE3G+P46px5xo675R6CcMc1NP445RqNoI
   N5LeCB353L+Oi+/tfDPHgLXAyKM9QpjV6KSt8cR28uEhtJrPulkjddhXc
   4M1l/h5cnTLttUuFMaOPb00LEcNfxP3WQD1nCWkkNlCMjg/mVRKqtAi6D
   g==;
IronPort-SDR: U1+YNOIF4EHUyaZVrQM5NLzDhOKp6Forp82dK4mkiixGqAIicutDw3Ywm2Avkd0TLL2lJPILOx
 AwfmHWc0kFdDYyZvLUW2oCOQiLDPUrrgKwV3AM0uCp1lIQ3UfMpmovlLoDShs1bY/unpMjLyya
 IMIj6X9tAPAn1EyHhFEX3vUwLm00Z0y2RCCH/On0hmTEODJ0h0hrYAus7473+jaGaAORCSME2K
 vn5kIXKII2siu1Tv5BoE1AGqx5mZTQ8D0JsL3ISiCcGy494D2r3KYCyFTwwpmrprmxupE4Ysj5
 PYQ=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="145679776"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:31:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XedH7Ehr1tJejX1oJqnajh6sUIj4dI052Qvny3ktoXHDASABClY/zW164thiZeET7wcpimz7JrOvxTVxeG1RJsFpdsV+w0vds01K7MDVPBe7Ceo+uKpnfwVe0KcPO3eoTG5ZzP/srEKeYZQjSwcvfcIZ/1l/Bq5+SOeZeT2gZYn4A7We2hLe3z1n8yZreu4jpyYEWE1ozFXXARi9WO6wGZSJftpvXfNj9YA7jnPIt1DVhkE+20cUYUAgufWXAY2JerY0YYKTaAgWhvwF24rOf38JEvpwoPi5U4hInoZ8N29yI26wT7omPBfGrQQYlTE0kaMBuV1VLO05osyEcRzY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YdGhJ0j2pGFVt/StzG+tH5QoFqR3f5qprcDkQSnOEedbXA6mdhKe/rSMMjRCyQRgB2bfFFqBLg9yswupdqM5ewZlu+n4iOPZEyUx3eRTBQlGVX7gUSwqbLkqQ9bnL/b9QPDZaU+DKAlUFkkDuqhLsiKnzfiTMhL7uFH3TFAseZXcRPSe/t4tiOYUYJ4l8j76+zIWhNcVQPE2W0Js632lsSSp3gIU8iumpJNIeBAmcUGhWr5QOOdaQAD08kUVu3tuv6xabOBffbIPXSiZRPFcqUkV85wXso38pjlQ9e8uxWBJeOSVXcYgTDY6ZWFnYA03tNDrtdiBvsvvKbB3If40Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VEm0+8fcKihsFHytRF11SzyhOhoAG5h13XCc8a0Gjal+HFqWQXyr2ZU7hIk4Amh7DsV63cgNG+XqBwOuZsffHlXitAdWiowrCqRgAdWuT/EL9h8gNVpSUnMU7ItzOx7p07iT5BEn00hreZ7FAdBydZw6Kqcg8hjI3xswEp/HFR0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2320.namprd04.prod.outlook.com
 (2603:10b6:804:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:31:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:31:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] block: remove the unused bd_private field from struct
 block_device
Thread-Topic: [PATCH 6/7] block: remove the unused bd_private field from
 struct block_device
Thread-Index: AQHWS5A1Z9kMQpgijkqsnXwlX5CA1w==
Date:   Wed, 1 Jul 2020 07:31:48 +0000
Message-ID: <SN4PR0401MB3598A8FF062FB8E163634B9D9B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b0265915-d150-4f1e-d1f9-08d81d90d061
x-ms-traffictypediagnostic: SN2PR04MB2320:
x-microsoft-antispam-prvs: <SN2PR04MB23204A075D1210ADF7A487779B6C0@SN2PR04MB2320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BRhCQy3F/KGbwNbvDyDUgPpJxTTcvoRvdTw93Pv9m3JtP+6sW5cMHYUrrVaYPbVP6ZnDFCxC7UP62JjBzQWEdYJorHzHNWtRUOKN1CcLGE3cs62qa1YCpHho7En3ghHkJrLOuj8uhxvCLSVTDiKY1K0Dwz3Pplea8HUzYa0yKcPJDLANhE7uOsm2vPImlhEkQizOtaLYa74ZpxFBh73qX0undyRbeO2Z7gsOn2GjIaFrMdkIPSXQoxqLBECx4xdrlCJP+L+qk6wobZM6VqAZSsHb45SOOEO0QySZkSXocSFG1dzI88oWW1YLzBDN4/rhi29bjtQXxuWEEkVYTysAkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(7696005)(478600001)(33656002)(6506007)(4270600006)(316002)(86362001)(4326008)(8936002)(5660300002)(52536014)(110136005)(8676002)(9686003)(55016002)(186003)(71200400001)(54906003)(19618925003)(91956017)(66556008)(64756008)(66446008)(558084003)(66946007)(66476007)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: p12gfzs3ekbdl/AAVOadvOHldga3zNGHl5B6/FJUIlxiEOSjiyWXarTDP6SChDqXsn49VXQ7Itc0NhNScFnX6pOYCatyIOepJj+X1BkDPDOx0p2Ty7qIbnhXmRjTL3DD/wuKiLfESVti1tyof3KNOH0wVwGYQrY+TgSrOl9JYMCHzm98TzdTdevUThNqzlRRLlREJjil4Drfa926UrSIkx6o7Phxm4cixi0laEHWw853lHE9X8XkQHENEKr8t2dbHA3ixXZ67/CSqMmsuKG4CAPIx1iTy7LSpwYyCZN2vfc0tdNVSIXk1XOz7WBNEewS1/ADjt9e1gOfysKxC2xWs2LF0Kpj0TK+0jnfFyHCOUJ+N1CLXkR7014OH9Q8U/lavxWpEPKOMKqxVbi+8afCyD03f9eVD52u1JYa+dIgqlu3QCQVBi8jyzLQBM802RaGNhE8VjfzqhBXy844ILLOPloCmo/lPZAMjKoLrPGYehma526AFgwqeNnSqLnktmbMDj5K3qaNpZfYHPSZXyIX6cYZumKmwwfWTUm1BY0P6IcejCgM7oMBzsCds8ySgaF5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0265915-d150-4f1e-d1f9-08d81d90d061
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:31:48.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKg2u1iArmSZtNeQFUE9MYQlAWQdwjFM82lIdHJ4tkUMKoupdJsRJ6FJAlzp1fDrm4lHAekbNdTYtSc+MGHpBqZlbV0Oaf0fFt+OzjQ1dCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2320
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
