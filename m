Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAFCC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61B9206A1
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="TJsixCZt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6qCHV0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgJGA60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:58:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:19216 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgJGA60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 20:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602032627; x=1633568627;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
  b=TJsixCZtAUNM3oxZwOeD63E8xHcre1bcFTqVSki9GpjfzvWrKYCyK83E
   i7+QCbgBfcdvuIfXSfk/E+ZZ7VQOgT14ncBA158hQg1TpLWsdlB2UpBq7
   weZiL7n41hw0P2PGCRtLI7Q0Dms5OaBfkKN8HjkREpUNS5GExJDu/DzXQ
   dnWpxvj0Zf3BKMndc5BVq4kP3BpujlfIp1WU32pTEKHpv5xrNtAjkwLzp
   +dRsKq6s6rax7KSL8Sv5SQSevcgUt4G8wh1QDz7Zzs+VRFNdI6mJ9bR1p
   AUEYH0chRNE2Li9+C6Y6VGVmYKVd0n+BvyXxSekgm/9kRHh2QfcYQYOsv
   Q==;
IronPort-SDR: z/02lHZCV+6yCNwRxP9N4FAj11lL1xbL6lMx+ipp6YNTyI1u/L+4Lz3mIPigMgYr6RikrQNN1P
 Xnf+Sg78MNpUNupXWQzEGf2PX8s5rmlHMpeODBO7RqHRjoe1SN7Od9gC1t8sLHr5eiEBwzMPCr
 i+2nAl1IeaLajaErPZ4svqGqy2hmU8v5SzexAi3J8R/bwx/befo9nyKhizoa1oC/D5EjpNd2pY
 r/pz8UigREahwNIXtQ8bxuf+PsLzrGT53giQSNqBmDxIzaFpWSvn29ikcnbv1ZdXE/fdHEdEnO
 K+w=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; 
   d="scan'208";a="252652743"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 09:03:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KkdzQ91mVWs3BnGIsh9Bk/kFapORZfNI8tFte+22+8Ng9VBlqRB/7eEiFDzf1o/xeYE1/arn0h0chxeQvb2fAVCuWgSb/QykT7BJdGNaEbtlUEdDmkdgs+9y4qIjIMNXpg+RhLXfTfFvg6ups5RSn/xhV0xM+T+fbhQfOH3f0SEYUjloV0DyQf+dXHkNIPvVfKMNXxaRewCdB1exaZwlHaaD/56K87GlqIUVq+9zZIgdQLkqLMPsgvve3gKUlUv+GXK6r+vwhWOzcRqLAwMm1amgECf/Vd+jaXT3yXDPVr0UNaAmqjhnU1yNSpTE8y+sxDblpyEQHX/OTFbmNwp3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
 b=akgzzTwgnQSCNYoFsCOEq/dEjwGvBeBS1wMHCVZkPUIaNu51CW4cJS1ddg3Sb5F2DyZIoUjmXNmU+OO2Dfo+/8sftyaU3Hs3qrJy1kevh3ugdXwjXF6hZomIhcEAsWTA0zjnFX4wUorAsb/WPxE34uZGNgH8YBlbFKH46CJz4KOnFVK2q2DSpNInjwvuaVbrqnczgQ++vijwZBEcybo2v6e9mZSIltaqcnT1oD4saHUKkErlz4Zb64m8b6Ksjt0VOoYZzvKZ+AtR6uTI1hOVAdDXs+tprDo/RFVF2CIaAHwRqaDCRBgM1iHIxo47MfNMRKDp139+9YFiRmAjfjeQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bePmi8nV1Z0agk7cf7CxbiWA7BvcuQr0qBLJYZV4XFQ=;
 b=P6qCHV0l5OuOeOVITQwoo9Ioq78K3tiEMWJCFNphjmjen1tMUjBXv25E9P7d5o9osNqq0BYZ1HzOrUT5KdRjqpT4owBFK5l8YeQP63P9AAdaLiCHmo0FsUojKGqJwlebatIXWj3zsvFt2nI4+2NADDB9whFRGUDz8YpsTx62j5w=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Wed, 7 Oct
 2020 00:58:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 00:58:23 +0000
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
Date:   Wed, 7 Oct 2020 00:58:23 +0000
Message-ID: <BYAPR04MB4965E6FFC184E347DDB78A29860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
 <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <b809f785-fc8b-4fa5-5de2-26dc9a4aed94@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d22471e-b258-4896-925e-08d86a5c172d
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-microsoft-antispam-prvs: <BYAPR04MB39585E5DAD79CA7CCEB662B6860A0@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ihA10jji0rPzj8TkJDY+JP9h0YNbVZfpT21j5MOnvVY1DrffvRZNPeX/WdNyBRay6vqtu9zXDz6RJaksPLfIniZfLWVX56TetcVQrPR4SJnrSNJtGExdmv/X5n1G89j1jJwJm/D3+rxN8BMALauhB6y/AUBhjf6ncczYeAX2BCzxAxD5zlA5O9nY/Q++LYUBN/rOrmPSsJm6RnKG/oqnHhICut/8ww1x+6xRrNq2rGRv8XMNgkqSMLtN9kEOk3YO+AESUYog+6lEX6qa5Zne2WX8Sv1qyPxFrbT2IQeTV+SEBKXsVdAlBRy6paPknHWRDvMDhrsETo8GWU6BAX9CRhxDmIB6HFiAxtbYYRxVAT6tRSP1maM2F2vur5EoqmLgss+nUnBzV3OO5LOjqyNAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(4744005)(55016002)(5660300002)(8676002)(83380400001)(83080400001)(54906003)(110136005)(8936002)(966005)(53546011)(498600001)(7696005)(52536014)(2906002)(33656002)(66476007)(66946007)(186003)(76116006)(66556008)(6506007)(86362001)(26005)(4326008)(64756008)(71200400001)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SodsewaHJXActT2olbjkgBtKDPBs5wJ+QB9TP0N9/B2vhGUscwgq0avfzu8onFBnFCkMTwo6j0YJeNH7V7zavRe36tzKaz9MSiKY7kAVxRHdT07T15sJztRco6yERmllqD+Ba6gyZtP5W6G4Q611u4E+TdMAbVr/FT98ChW/GM88kAEGvXqNj1jDttJPK/Qrp6x3fDrszuDO8+gBEBOL1di3cQ0E4MYGQt8ZlRodXYPdO0XiYXBQLhCxVzpCW8Ld4mZ8iyOi7PbTZQyvnHfs6AZUKtj/mzMvaPpI8lFIqla3KXChrgYskZpPSRJgObbR0DyyHz8puhsmdz9Ng2dC4ZGzJySbsvENWM9OIZKhZpU7PYM5wVSC8XRYMGi1/R/2dpPaPBsfDnroCDql83YHhSk1/msBa8s1tMY0OEhroX3CtgneF/lqzL/Qh1izHgOJ0co6rhts9+/zAuVoWRxhQf5i9kHiAgj/xTmAWUHuF7qX+6dGeVjjzzyis61KqXF2kjArWaId0YHA5zVAK9AA+EqekiG3+uyNxfTKwqsnQsTWc+pfxlb6QMP1j69rJ1AEfGnEDl8Kp8DE4IYRIaQeb+4DXrm9C6g2TL4KekWuQ/lJq5YauRDVb9iGH1lUtW7IBWaI7HXq6jGtShF4PS4BMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d22471e-b258-4896-925e-08d86a5c172d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 00:58:23.0513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7fqko/tKq/yYcrfQPwepgWqKEMV9y6wIoIe8BlavdY2b2DRpqE8LdpWWWqkJ2zwcFcIfH7PUt4UXxVCMe8/dEswdb6u0x+I5mzgz/uBsSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 16:51, Logan Gunthorpe wrote:=0A=
> _have_xfs() does return true/false and can be used with && or in a=0A=
> conditional.=0A=
>=0A=
> Per [1], my opinion is that using && in the requires() function where=0A=
> the return value is ignored is confusing so I prefer not to do it in new=
=0A=
> code.=0A=
>=0A=
> If we want to reconsider this we, should add a check to ensure the=0A=
> return value of requires() matches the expectation of the global=0A=
> variable it uses.=0A=
>=0A=
> Logan=0A=
>=0A=
> [1]=0A=
> https://lore.kernel.org/linux-block/92478e6f-622a-a1ae-6189-4009f9a307bc@=
deltatee.com/=0A=
=0A=
Make sense to me, lets not change this, thanks for pointing that out.=0A=
=0A=
