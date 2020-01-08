Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4DC282DD
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 22:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4854E206DB
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 22:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bY2oJxVD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zJwKO0dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgAHWi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jan 2020 17:38:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44955 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHWi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 17:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578523109; x=1610059109;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/HTE5q0l3v2+pD584wwaZmXoTa3Fejk2XDzQLJbmORw=;
  b=bY2oJxVDvabyx9hO7AiC65u4CSoJhScxaXZvcRfmHyr6BT0bxXeygUqE
   W5MOJQveDm0OAIEF9i0pHxgYNdgb3V/ktCuJhCXnvJuuQUzQfDxWnrOk/
   l4MhY/BNa20XQP0Rgr41DDds6BBV+N3T8TE0oKAbzZUuFz293OwSYrP33
   x7JMXU0KG2fvPhhuNtVd0gQMB+/CgsKUMwusQlIp1gkckuYzvOWJ8Dq1R
   QgRkinAzAe8ik21aJbfE+2QTxWetL+QGiNR+ennIIfu5EQ+9wyA0F0nvv
   Mu+TiCVtrIB+pow+R5xke6L2Mt6HBgRm7fLeQDXQFT61Ppr99djSXLYF3
   w==;
IronPort-SDR: xEF8xIuZjKDBrAhXxC/XdvGOkXoFhUdPPzQfbmnV+ysSlcFE7DjtrMWmT6HObUindhGFS9Pch0
 p7HUH64O6Tj3chHzFgehO6ZZw7cGihDaPhW2bvh51JGx7iaBlXsND+bPgXANZU4BWbp9untZzE
 WWSk6oCiJY21zCwiegTMlqBLhNrtlXmxAzZFF6qGnE/QBxMCKRmKHlHQKKPl0KP60hRjpVtidc
 Qi33tKM4ZmSSQ2w2quLin2wheYkUXoFGO6SeOoCqpB3+JEFRUFDBoPoKP1oES7mc4ejFzZAzZN
 n38=
X-IronPort-AV: E=Sophos;i="5.69,411,1571673600"; 
   d="scan'208";a="128564053"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 06:38:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnboaCMgLEzhMYkVfxsmN0ikyTmGOqX0pT7bZlz/pKxGPvAKhN3ZyamM80a4PWFMW1aoKRfPZSmee34vSVZGOme7/xhhMwLLvMFYVuMR4PvRGZ5/2BWPrWojPtJ8PheRuLzFm43yJiguZIVyG7s5TysE7Z8s6H1LICrGpRW8/Sv5iu7lHocZNFfFiBD6g6FLruiuQudjX2rc+EcZmwQ+SLJKalePwSJb1JVE2NolH3n5bOl0svq5br6rBuJeGVsPRNdE+SX/+/1QoxKkMKOPpMkaYQsrJwvSUh3ErLE987eg+2ZaVBRWR+uzVoSR/vllLSvVt2S8E2vmm40s3NnwuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HTE5q0l3v2+pD584wwaZmXoTa3Fejk2XDzQLJbmORw=;
 b=GaI99N7/RmtChuwxcyxRMri42jrRURhrWqIyHOa9m43TTFHWkIAVTRFR3NYwZWEVMfzndJZkQMfxajsSaAPjaTdWiKjoG4V5aReTaat/fDRq9RCdHcLRvNmycjZbi445dp9VQL3zohpw8xvI0/6zkduE609shdmA8OQ9Sm/3ogvM3bnACVhK1v1E3T1w17QA4D+DDrdzUL4msKz8Hbu7vEA6a6CJn0mLl9AyWeQgjyK1shQOd381j0nf78H5fCl+nDlHWdFDWK54Lww8gkBUIjwM0n2j2RnaHIR3lGw9kLf5i1ngg+MGv6Sl4CluWtJagK8z2DlPD7BCXcOOsI3Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HTE5q0l3v2+pD584wwaZmXoTa3Fejk2XDzQLJbmORw=;
 b=zJwKO0dqyytrFs+hzUY2WlYAyw8EKM1+nsWCxRvP8DzAmmxBDZKOpYnagU9F5iO/XLrNK2WKFFg0p1mLOASnlayRO0kxC96E8B1eqTSAp8W2m87AazvtJ0xwaUvIxnXhTLG3P0K2SHBLdGFuByMBQxnJG497TE71sjiJD79Qkgw=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4631.namprd04.prod.outlook.com (52.135.238.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 22:38:27 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 22:38:27 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
Thread-Topic: [PATCH] block: mark zone-mgmt bios with REQ_SYNC
Thread-Index: AQHVtjOXhh37zfACp0GStK4HY+VLxg==
Date:   Wed, 8 Jan 2020 22:38:27 +0000
Message-ID: <BYAPR04MB574986DD54130EACCC5A4DE8863E0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191219061423.3775-1-chaitanya.kulkarni@wdc.com>
 <e63f8fd4-77bd-1031-bf15-b3155b262974@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0242b01-a0d4-4a56-7de2-08d7948b7a81
x-ms-traffictypediagnostic: BYAPR04MB4631:
x-microsoft-antispam-prvs: <BYAPR04MB46311116FCBEDF78D11260A9863E0@BYAPR04MB4631.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(71200400001)(4744005)(2906002)(26005)(81156014)(81166006)(86362001)(7696005)(53546011)(478600001)(6506007)(8676002)(5660300002)(8936002)(52536014)(316002)(55016002)(110136005)(66476007)(64756008)(66446008)(66946007)(9686003)(186003)(66556008)(76116006)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4631;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOj6GM4Ep6/eIagy6nmA+VOiiYJ1q/mN4emKw2DsVirUADZbyv8XBIlQJWvcBf8Pr26RxS8WksRFM1/h4bbi8zm+OvabF+Y2IL3R/O0Mv/WMrt4CPDMIR7zeKzNaf8j2LEIDL+F60vPQOmVwDWDaD8rtexxMueO3w8JFXOdsaRjSqwqUxp3+XN1/UPIGLWUQdSLSoykoHtsz88gmwN/GH7grydcadFfArU6Yx8cL7xyTORJ/Acq43OLjJfbGBxr3CpGwVAAaMNuFdcyRypMJx1LGWg7k11U64/rRyXVeWLtmbFsxiGIu+3Qu1QZkkpGPjsfAHE7om0bWOoVYxRiErRhWz+EGiqo5SzH1pIh8+ji18SmdQASqtRqAVhOwHFx1ggwwtfkit0QqYPsMT0ZypxFmbjCSx0AB33rmTw6V/cEA0RWmP7qFIImqNpwcoGdd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0242b01-a0d4-4a56-7de2-08d7948b7a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 22:38:27.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZdMh4+QkdNsfYjHCJXpWfQBz+cgplu8AO3/mG87JAYntwmm0vZ+KAe3AvCNxIRUpkSIzoRXM9qwUC7Uuqjn7HpwX6hLeyaHxaloPq536SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4631
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
I sent out a new version, can you please take a look and=0A=
let me know if you are happy with the commit log ?=0A=
=0A=
On 12/19/2019 04:47 AM, Jens Axboe wrote:=0A=
> On 12/18/19 11:14 PM, Chaitanya Kulkarni wrote:=0A=
>> >This patch marks the zone-mgmt bios with REQ_SYNC flag.=0A=
> This needs a much better commit message, you're not telling me=0A=
> anything I can't see by reading the patch itself. A good commit=0A=
> message contains the reason for the patch, there's no justification=0A=
> right now.=0A=
>=0A=
> -- Jens Axboe=0A=
=0A=
-ck=0A=
