Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B34C433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0772075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KjHmf/69";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HuHnEpzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIDASs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:18:48 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19295 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDASr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178726; x=1630714726;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=an5oVW4VVit0k/9+iKKg8hcR7qF90RwFhzNXvFNcKxg=;
  b=KjHmf/69Ug4kQRzE5gLehCi49s9qLja29JatcDdc94b/su6DPK4Nvagp
   CN3TgSsgJ4PY+J1ENN1NmPQ2fNTImZ4ZrMSWEfQAGHgFOOIky9emUyK35
   YDqJrRAEFJfQ+wYY71MEPqSX6KTQxLmphb4flefAqElZY8rlpdxPgp4OC
   LvvFrNZ6myzb1yuYHwQlLJS9ZEvDjAcXm8QgTTtWVG4bwhh0QWGjfD1/H
   7zBh0XgOyRq4et+DCBsHK+4qFy+xbAuDf13Z26jaB0zu8jKbQVZQhD2II
   jU9FbfHeHZJ5BQgelOra29eVBvURdCdRiVrkAsJVCIPM2jQAwCdPV1Qkq
   A==;
IronPort-SDR: scSLNBvxFhGfiXl/ELkr8zt31h8+0UxbJv2dnXs8XET8SyPp3GP0I5smACkt0bMNA9eOigrBh7
 XMz4tJgu7WwwBSYHLNg2D0Eek/gxWl2hS8ZGF3N1qNo/9MWV92DO52IJIwf3lGtxAq8Yc4g6HR
 4/LazCMAxV9rpSghGC+Vlro5QNrYYNZQHkg0WVvKhBUrTwhTySi4btybw5CAj1y5QtLt+8Q/Nm
 I6BM06YJEop6L3F3wc/aQGfEwqNMpHa2ZCTZNxVTspyccjmxuO6jB4IkapMpE2UfDMUC+eSXDQ
 sRw=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="256090063"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:18:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et1+ncQIgunE3PT8SqiSyHemkEov7eAUSytq0+2yxYc1HT+FgNHJytOwtMqMfbgdltGeQ5ODojeu6PLAWDykORFztbbbzX/xxyUdTB+A3rAWkZ3MBR2enmechq53UaTAuQIS/R5jesm/3//Nno0kjz6TXmadmv0KeHfEWu0AJkGhIV9R8s5Ei/sL6zTKTf2i/zfuWvnAos9Ehkn6iKzxXxLmI8znFrvAiPQVV04TomVy+5yTgYNMrHoWUwaN1bOTsq0TWsBvD1i2cutMolnKKGP9BQ3l8Br0NPZc7iOsw1qujUttKFwHAtTOaBmzm6cWNXyQoEYoQirfk8n7ALjvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an5oVW4VVit0k/9+iKKg8hcR7qF90RwFhzNXvFNcKxg=;
 b=UfSVAOuEQLyi9f4LNix+xPe1r2PMBn0L3rt4vW43Y8iKfMjNiyXjeDmGNRlfd8kJUynu3jgjf+Zgz2NE1XdU+o7QlA2dsaYfIyk1tlIKFNuKYNEIVbpmRBPmiX5iOUaUEx2AzFzGgMuWcGIW7lJNOwe00VzqEYPwwqdxrfq7giE48B9PYO90GVZpx6b8gRwLiLS4SBq14VcBbOh+MKxopb3ftxGt7kWUJGOodeXwkSo+lgIkGV5sA41qmAJcEh+z2gZMKcq2N2wFTyZ3CQAwWnfcVqjCkSsEHrVL9Bhfcsjyepw5EYiNosTyIetzYKfYQhxQyUySeP0wQy26xrh8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an5oVW4VVit0k/9+iKKg8hcR7qF90RwFhzNXvFNcKxg=;
 b=HuHnEpzOOLWl92H6CDGlGwpduLqa+1GJ3Q0/HNaCsDCkKp0FNo9qvCXfCaDlVHESTJ0sgmO8lim9kuY8h4uz5eAm9l0aT5pEoS6B/LptcUazPxX+fNA5PBvBH/CihigO6nP1S1H7RzAqFhkTv9fhEXg5PzuljKKRo9IqrQlajwY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:18:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:18:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWgk18JnOENAm/sU6+z42IWIHDiQ==
Date:   Fri, 4 Sep 2020 00:18:44 +0000
Message-ID: <BYAPR04MB4965EFEB13E22A2262937C5E862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b63969f-3b28-430e-6151-08d8506815a7
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB44242393EDC7BF1F4C98718E862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sn8Calljom4BkKP154MBbvkGsTiyR5C5YOewoi0wJwS3/14tO443Z2WKf48/Tip6FtXIzAApLQwYNP0PXWQDdVdO4fSp4Jn6Zbqn1HwYiNAZv/eY3dY2S3sMjsoCf293jC7KMBVFdBFOUjV83ugs72+Dj92lOW48id6pheyR+wD1yls/ZPoHQ5fIVp/YlafMIxN+IAMqHI+NBrG+C1yJ8WrWI2CyWq375xKTpKi+2YnlqErVG6QBRbVzTG161jAhOTl/aDCe1xPvKPwaHsz/sgN6GLZKteW15IlL60PtHZYsdtPlDe3Qa0WFV6cVqvULhK0zP4C/2+HFwIqG90McCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CC9iVNM7QHZSpsFulk4YLZzv/3BALxsCdwX9E4HD1OFlCJIzYRYMe7ZAlWODX2Cm1vOAB9Edwdu4A8/m8fCXPnPTXoVFRTPK/DhP+aYbJtA0XMffCQXXRlKQpRByWgQCr+OEBg8d/cFERNtsZFtQlLfBWHLjEDjKwxSYWPZ6QWSOrq/9ZDxudsn++2LnTbGW2FU+nKXEPHcDo3Beb4vdSbgeuzxwIm2pQ3v3iIZTDKDRdhI6R3vWBxo0BeWGCP2beaVp3JaPNoPEcoQpUSMHPJL20gQOiXgtNMacQYLCJ36OE70hHNvJXmbwGVql8zpTnXum0qDsBnLAPw0Nxpf9mjYwVLkLgGWwr2P3IlUm+FdFY1SyPf2498r8iSF21APH0zaoElLoWem5eRiuSbNjcg+dhhOIBe6JHqRGysHszuARh+DGA7WN3aYHMX1lS/WxyNEM6LapEI5kPj1OxtwtOr41mRYWisYq0kkB6i1F82rB06Az9lWzhhq4/fGMC6eIuaX1sReN2868uZn7tojrSpvUbHbFYqbnryJtiix+OslG7hAXAmzXTdutA4uhcTwTfCgjrIlO12ilRK3bQdMzUqoe/OVIirx03sG5dUAFNbAmApjGj/rKJ8rsrDCcSx3srKUdhWEipHgGwyGdiJz1Tw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b63969f-3b28-430e-6151-08d8506815a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:18:44.1447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/cjhXaKhtykAVwYE3z+tbqkZKMT5p6nhobxMCsNtp1md9Lh79fCGtcctQPI2QaFEjVMoq94f8dQ/SbTaIpG73gNRsJGTsEen1x6MwTPDLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:53, Sagi Grimberg wrote:=0A=
> Right now, only pci and loop have tests, hence these are=0A=
> the only ones that are allowed. The user can pass an env=0A=
> variable nvme_trtype and check for the necessary modules.=0A=
> =0A=
> This allows prepares us to support other transport types.=0A=
> =0A=
> Note that test 031 is designed to run only with nvme, hence=0A=
> it overrides the environment variable to nvme_trtype=3Dpci.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
