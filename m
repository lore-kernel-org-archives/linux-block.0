Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F2C433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206D62075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qDTtQmzH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IjV3E9zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgIDAWx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:22:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14998 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgIDAWw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178972; x=1630714972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2xMPFxRFABbh+kV94w7OrOfxrINZJTX/KBjEDgLK2d4=;
  b=qDTtQmzH4g+R0Ae9zJmyaNfos99DrzJBjhfXta+JXQyhPcl7/A5rgL/Y
   pWIjl7QKJBADvwwkHWK12Yhfue4Zh+Vp/S5uY1bYap0RYb6bx48dbwREg
   Ye4+g+xlx9W50RvcJ3tel5DeItSJQRx0NlhuszgtZ3YoX5mDUlCjN1PRn
   Ej2czQkEHH3dmx9eQyjzRWibYuym/L08Mi0gTfDMhnZ3IA4phqijnYI0h
   2Cy6Uh818fIJTv1ZFpW/Pv6AeAykkGE01URpKM1hDlr7f+HR7yaDj7BMw
   dsRoHBCkVx1/x67weZzRP5Haj9/Bf9RQr8RXjpuQNWcmIqsxXssOb61rD
   w==;
IronPort-SDR: e3kDbkLSiXZSqtICuleOCPHPoPtkl0iHahxJSeNA5v6Ucvq+97g8aMjsaL2v2HtJzu3urpjf6c
 2/29vUPGNlCSGiqXbF8SxLrabP3c2agdeJPZI78PIVhqOFl+IUajaapMb28Cm3K8lOF8SNfvzJ
 bzTmGgSaG8J4kOZRyZYnZEsskBuphFfK0tudijleBA7svUBWz+rfR1EnsscTc/24HPn4rDjQhF
 YKP0MVxQyHwgyIYSjf3dUh0yz+VucRY3IQsrgj1MBrgVPhrK3xPu4WUiXOcS8IrM/jFTtjiWZO
 G/8=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="249814639"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:23:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdfLfR15wtjgBkmin8MVoEUgi8hqTlsZTp5eqyq0WashcTWxENYBEDIk6ScUB8gWGnmGo2aTO1Fn9B43su3G/2RQdT24WrxDQBSyctq0iprixCJbrAebvp0gFj62lbVL1/yczOa0EKRjzks+l8+tsSX8s8meK6VD472SYxdS/tCKSQvKkiD7xsSriP//Kci/4LE2TADvNapRxRBUNWL6bSBPq8nb6p9+r5UkZdslJu0ULdM1Yx6vwkeIZ2OpNMLD9/+m4NWtx9E+qc7+4e21FqazH6789Jtu8q2tfxB8UpR7t4MBbzX+JGn4iE4TSKfmTxwylb5kGiG/cfvXGOQMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xMPFxRFABbh+kV94w7OrOfxrINZJTX/KBjEDgLK2d4=;
 b=GRib16za9pSVofQHbStboJlZsxeQDQt/6k8WdsL9zoogExKqspDk4H4exCt61W8L8BnpCiz0HNHbRq1FLg0EbdW5wprxfR5TlGWv+gcV9g/qummeJwG7k2X593FqqfJ4gpjlp/ea06awlu36qmJKiaKUiGQpNIZo6j5cT7trVDlOc6SAzd5bLtfQ1iU1lJciLkrB174ppMDgGn/+QKMxlBE70M5p5GsuEGyXJgWbF9GnSGFN22CMMaozO5gi/BLLyO8BRyjusskYc72snThQLbtiZ7XrKXCrox6qqNc98bMgeOW/lpCmhSFe6S8bMXHiVkWJcw8jlkKqHQH9NUGpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xMPFxRFABbh+kV94w7OrOfxrINZJTX/KBjEDgLK2d4=;
 b=IjV3E9zmdQj6Ega/cEHr0DBOnjcioAKT6PkVzoekglAUTwWkr2aj489Bq1VDP2ElmOdLF2qR+o+Y4wGLwk8V4KfXP6Y4aMEoQuQmLEgUIK8fDaOoE095mfBneJoy1tSQDVimnbV6WEGmqucReCLNElswsENROrxBKv3EJuxvLQY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:22:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:22:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 6/7] common: move module_unload to common
Thread-Topic: [PATCH v7 6/7] common: move module_unload to common
Thread-Index: AQHWgk2Fe1QOcNEa9EKn7rrOmB7sjA==
Date:   Fri, 4 Sep 2020 00:22:44 +0000
Message-ID: <BYAPR04MB496539741A5011448A94F9D1862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-7-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6e52070-e85c-4e0a-a4ed-08d85068a4c4
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424FB919B3A28A37294EBA5862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jkVwfsvRyHYad6GsBTp7ICaNvqdSjza6u1yiA9POFxeFwMYI9xg/3QsgK/OxrTpvMFRg4jt/FBB86S8t8s+GVb1RhNjQT9mCNsMhYEagG9I2G27GSdrfTrLHB6ner3jeTXEkqpqQNYXadxCrA4HGaQnHgqQg5b20HJt8glFiPFLhkAA5ujSdgSZIOoAfvLyYLlOH9WY5LQ5kXRjSwS8u322Rtupb8luMyL2+Yo0PxyotXa0MsMFfNYODXsQBn87lai6Aj1Tk3Tyw9spWxQsoeosVebbwUoAmqLOpuaKU6th319zh1JpPr86oXJSH50Msl6S/5Ld/GQS60i+35Tv5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cfuWJ/w3FblyKlJN0lCP7vBBSfcWPLJbHQDSQhxB6U4sRMsr+70ZDD4OFtXHjyvNzVQokmnvgvCpxVmSfzDx1zHDuB5GdTyvw4JlPi7klPb2ql13mSxWsO6csSokvVATJO4kjLq5cFSap95ETM+L4kG1OHrQ696yjaSCf2bO6uU+sMzrMOcCUgRhEsMsY62e8YbPQR7gZ3+GSqac8nkkDBX2WjSsJoAMaSw7aUs3YXjkbGA2MiAkSy8DXQkBSE/p2nlFGyqg6CfNnwDwtjQk9DLiCE09EDHZn7UXmzSssFwKOPEtd69b2aF3tr7v+Gz6414ehmUIGw7bQBabfbuK8uOKWafqo1LCjQeMdM4velOkWw1vFTs/U0XA1+nglm3PyvUkwjwil7i2KyziGsYZyvaikEVi2gZHDIhRZPFbVyM3sSfB8IX+00DaQVCFFucV+nqlghoVN4nHITyOtiaJMMcKOZcNm0YYy+CQzeiMEq2c/NdoE8TP0BDfi42CVxkOVlKM7JI3qPgYpX2sp5maf/HwqWUZTzIdLgy1gabtm/WMS0CAEHvhgTubwmwg/LL8ZzHtHNQnoO0dhH17g79CJWuS22OjIcs8qOc0dH9tistgLzd7EvEavxn0robJtVKPIkpR9zD7nSuYnV8qJaOtlQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e52070-e85c-4e0a-a4ed-08d85068a4c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:22:44.2607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tIC1AtNI8k5+1Owc/q2ZFsPOoBXGFBdCHm6r1G1Lqx6480rsLnsCRgfq6K6PpWBkwigvXgpuqEpRB3g9zG8dQttYxvRhH1640+9ayM1DNFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> It creates a dependency between multipath-over-rdma and test/nvmeof/rc=0A=
> (and test/srp/rc) which is not a natural home for it.=0A=
> =0A=
> Move it to common helpers.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
