Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A447CA9EAF
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 03:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341802087F
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 03:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CCgDjLzu";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HVQhBWGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfJ3DaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:30:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:11632 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfJ3DaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 23:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572406268; x=1603942268;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0ewsI2CO4L77E0s5Lk+odQ5nGn5qkNj6pJhOQG0ubJk=;
  b=CCgDjLzuaAb7DR8mdxRHOo/hWm2DBiF5HMRAO0fRgKjjkR3CGlrhZ8Vs
   qk5u3LB8LG6bz1pzmZeF5ALKrbszQ38Nb0o0Ai6kuShKMnVZxMs3hB/+n
   sAZWrgKIiUHeJHNr/IzRzTej+2tXTLenvblBgSWy2ME/lwzSvRsXzMXMv
   NXmsc0FXWSeyGKLjR8w823MiCYUSdIsHx44dXkV+K377CeRP2AvDTF0Fg
   2XHB2G1iJguBTE+StwzO8br+GXejOL2wAAMLyQvmSpvyIwY2fzrJsOPs9
   O9viSbqmXzpD4vgpUp6eKDsG0jikMfQ+cCjajbsQwsgl/AfvRKKpoSnjq
   w==;
IronPort-SDR: /xg24b6vbOPD8tF/mpDJOnXq556CTgVVsM07ZEXrnM7Zq8Yb4a+vKm0/Pkpyj6TRIs+Z6I7Ltt
 GhK1a9g/EC93AhUK8ty7Ukz/DeqRbcylTU0rVioAQBnIx66QYurrmPhfElFiU4aesCAVHmjToA
 DT5ifT5RGaz3Fi/5DnBKEA875MOEdo8H6he9hyQV/PqQUesmeLLPDWjmIAz3VTj+5rkPmtJrps
 edYd889+cLPmEpIbudQ8uvId0uEcfOENHPa8Z3KDq4WFkfe2PuW10s2F0muhpUXddipgJojivl
 Lz4=
X-IronPort-AV: E=Sophos;i="5.68,245,1569254400"; 
   d="scan'208";a="222786426"
Received: from mail-bn3nam01lp2052.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.52])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2019 11:31:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS0Y9dTWFtaUks/mNx945IMVsGCt4mocWvrNoSnn3rQ6x6O1DxjGBs89Uv/DRtC3vgl5xbWMUTF9rckrK9c60JdqH5D8Pm/kOw91b1NKiuzrvi9JhupfVbWhndQK70x50EswsLlR1JaFc7cpm35mUEfsSA7duCUMockn+2O98/UQDahyEirsaqIgZutuy98w8GJRnyltiJWkL9ERAlEqGDLUiixaAy/5mDfS7J97f6vIVc38oxT1SuocUtqPs0aKR/UTpVJ9KdvYGhxUNVhG0xtg9zKR6naFeaK1o62uNssh6g4910U3FTZWuGWEeR7YVy00paxqaJmUKcdlM5k8mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ewsI2CO4L77E0s5Lk+odQ5nGn5qkNj6pJhOQG0ubJk=;
 b=CD/h9SNG4knFq0fDd0gC4zZIjpMhu57a9GoO+KyABVeswHzf3Ns0Pa7/iwOrzoEoajO+6/1e+KPLzeOZ8vaMkEAqWEKTtOh8XlCKD5QrblF8ZZkSFQD6jIfcbwr88TNJcXLs2eSCZnsTX0jb6tAa6sWczlbXyUuK2b/nGjXXtcyQqRbraEypZ8k64Pi71iV8g8DegX2hZoilP9O0RNWssPR/DXNHDqgfN9ZJ6XT50oumlS6cvwqYU+gQpLSysqaC4tS6j2zbA/we4EerFkRUtLQrE8Doh0e80utJUw2RycUwukqYYt93SpqqtkR846R81J537pc98rX9IJTmhmjXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ewsI2CO4L77E0s5Lk+odQ5nGn5qkNj6pJhOQG0ubJk=;
 b=HVQhBWGKrn6sRHSLBfBI3JYxxFaJM1xN1XHtg5dDe54bibTZqBVEPllfjI8dhPHAJ+oSTd+7kHq2uknq2g7Qfu89YPGdCKRgueasCuLtapYeDB/rzE0Ql3p+O2vfdSurs2LI+MVzPr+60PLAT3PtK+IYFDraU4itzp4V4S69uuQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5797.namprd04.prod.outlook.com (20.179.60.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Wed, 30 Oct 2019 03:30:01 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 03:30:01 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        "outreachy-kernel@googlegroups.com" 
        <outreachy-kernel@googlegroups.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkcamp@lists.libreplanetbr.org" <lkcamp@lists.libreplanetbr.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] blk-mq: Fix typo in comment
Thread-Topic: [PATCH] blk-mq: Fix typo in comment
Thread-Index: AQHVjqlGW4KUljIfGk+QSWTa5wn3Eg==
Date:   Wed, 30 Oct 2019 03:30:00 +0000
Message-ID: <BYAPR04MB5749EED7A988D38E7F1F977D86600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191029223556.2289-1-gabrielabittencourt00@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fc981a5-2ccf-4a98-a432-08d75ce97241
x-ms-traffictypediagnostic: BYAPR04MB5797:
x-microsoft-antispam-prvs: <BYAPR04MB57975B50D08AB8A1591FEE0A86600@BYAPR04MB5797.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(76176011)(8676002)(26005)(81156014)(81166006)(6506007)(33656002)(316002)(110136005)(25786009)(53546011)(102836004)(7696005)(2501003)(256004)(186003)(7736002)(305945005)(6116002)(3846002)(2906002)(446003)(74316002)(52536014)(8936002)(5660300002)(229853002)(66066001)(486006)(9686003)(6246003)(476003)(6436002)(55016002)(66946007)(66446008)(64756008)(66556008)(2201001)(76116006)(478600001)(86362001)(558084003)(99286004)(71190400001)(71200400001)(14454004)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5797;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRq/77ohxhtMeedocznQRC8tS/Q1/i7G6WDEuj3UZ0SSCf5IKZKD3uwA9oRH2fiicgn4MnniHRw2tPsMENntzehqla70A7T8Rs/eKiH2l/x+p2yJmf64H67qMeNzTpgI3RR8CJIoI3B99vY2amvkZklnG9jPfHNn0RECBJjIQGe3OKNqfZC8R0iSPOirmPZjeegyI6R6BQXDXmwGZz5vkADvnq4ruzoms1w7/L5e/BMaE3yN9ctclS7WwgfRraIIqUDxUZJ0F3pfLMz70KL2qfN+7Ti7X0SfNhjitljpRWEOI/+Gl99oEnc7ESvE1XB9zKteTR12phwQd+I0SC3nO+dK8Y+OjR/Zf5C1iTv62NhysaBkUgyVkSQTHIZobqDnQvMJyyh7DElDIDuY/F83jkQB9wNDbtIxY+buII14bcGildGd01WcOFpD0ssbT/RQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc981a5-2ccf-4a98-a432-08d75ce97241
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 03:30:00.8725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9gOnIU764qvh+3CBQ4ZTWX3DiKe5nomKjEI8UvNv2OkOBRLtmSMKRHRU/KCUMClY1VLzR2H95RlRrflgg7XPC41KhSlRmRMlABrv9WpM4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5797
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 10/29/2019 03:36 PM, Gabriela Bittencourt wrote:=0A=
> Fix typo in words: 'vector' and 'query'.=0A=
>=0A=
> Signed-off-by: Gabriela Bittencourt<gabrielabittencourt00@gmail.com>=0A=
=0A=
