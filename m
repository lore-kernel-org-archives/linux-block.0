Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E21C433E2
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098D52075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OArB+za+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d3o59m8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIDAWD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:22:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14887 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDAWB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:22:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178943; x=1630714943;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
  b=OArB+za+K4VJa03zznJawXNLtgSEyupIVvlBvnzII39A81hiiax+QVKA
   755AdNaJ9fOhWx3m/I6EM4QVvJeeQc7xBjdCiVMLoCwwJRvoiG+mGZX0N
   A/qnWP42ER7JYovHRa96cjP7deoxi5zaaQ1FcOpgGo5CEiwLuCRpE9mPV
   R1omKejg4qnj7f9N7oGSGakZGJPJ1Iv7DIRSficwaoz2Js7Mb7rQIs03h
   /PbkIFJGt0dSLKsYm3fDkdN97IUCSIya8OtAoGuZFXjZxIFtxB2NjpOXr
   8H2VQD3PzaBtwW/vi1gdmz1cP7lwr2aq56uKwBZ3IQ470OoQOuseJFD2y
   w==;
IronPort-SDR: 7M5WYDfCji3RkNmZuCYOUMohB3Iar/zATwKuJhn7oCl3IqFjF+KaRSszrhRIJn/RvHZXz70Ao9
 gHSpXK2DcjUB+0nhSLKpfBTjBBcPwGiIOaxxyw8tn1RYyiojDm3tSaxh9w8UKIqJS7ySABs1NT
 GcoIjVVCW3n2J9sbQXC12BvAmxKVsEJnMKEec+zVrIMMqQ37GOyy0jQnY7v69eeaM2XIwQjHFZ
 kdZpD9PFzX3O7DLglUsEEmEIsFxS3R9zvAPNZW5bRl9JnVm1Zzpjpa+4SL8yQBg8s+KzY8kWUJ
 6Ys=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="249814568"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:22:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6BXdqtdvv067s0mZPdiEwXylql0NZZpsAbdd34XsFbCrjriFwe7LbdKbh9QjzD9uNQhpw0uRRlnJWf8Qn1AuAJZvO1KRrfSMT43vHiBVLt26dSDbJTCZLAtw+ZhU3+Yfk93oNuaB1BOriUpEt0Ko+GmTcfkWqwYMN3jlb2ueStZ63+G5aiUsL31oG7ksr5gUSYy8jpQ1HAjxflMm8PYs97YTE1YZBLJRPmry1mtyHDREQazTwFCipRENfMiHlDTRE735DkPPf7OO/yFI0vZxSTgHKc6hA5Q2mIV1klTOt6PMB5y5+9bDeYvCcuuNN4oGI3xmeMM4+y3uCJWx1op9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
 b=f7NThHKTB3TGdPrEqaczDerd/J7qzt5J91RtOrTFIgIxiHlTSmf1SmPp3h2CBy4j2/oYDc7quh6yf6slOXLqJb4eTzRrTGP2wb3LXQ62T1VG8akS9QLND+JIHt+Cwx5nZJTNjhQ6Hpuo1FGVwSjakE90NG1OsXI2ZuQWf6JCrnouYsQLbelh8UweLDI0FECBy6PPhmi5lESdTP52DwX1imw2+pdGHdeVVLQcuSgd8Dg7Uw31u7+dXv4b5MLP863v1Nz18kR29waP9277YwSsfUQ5ocqYEqg/Zq5ABKyYqfUReEqzmsrPZUBQxF4+CHKdqHexohkZHg5oy/rsjsFxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pny6/xO9rk1Y7ijbTpDe+1T4D5bPDHAAETQ4jTX91Fo=;
 b=d3o59m8w1OzpzeIDgJIBAzJfc8f4oDxVnkZfSGuhbKxiRAcjBdOhiDz/SYwdeQFF/5RxoVbi/iXz4gPJf2VrVPL25G6te+02A5JQqBsZjhAR2Ev+X7A1D9KsQP8w3+WpnD+vQUvZUq2cfMnzh8siidY2pAkFIP2TBsqC9Yxk11A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:21:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:21:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v7 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWgk2HSKyRhGrswUCkxHtEt8ecMw==
Date:   Fri, 4 Sep 2020 00:21:58 +0000
Message-ID: <BYAPR04MB4965FCC811A0EEF7345BEFA1862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 073acca1-4508-4218-2081-08d850688989
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424AD4C5B0035DC519FF789862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oB5uJ6kljoHJ3Cmf6/hR1f6KMyy2IbHfM0jNuy29PSUZQcbdNCw93sZBVcsYgm4iJ7U2POIr+r6EFQiB13SWBjc0sy6X852tArLBxRDOYB88MfdaqppKX1JN4udt74yYDsx994jNsoQUsDG4j6QCnk/35T394cx/AxkFrXHPBx+kB66ETMUrmcMmYNEiKaPtApQVx+eCf82Szi7hpef/0qm/Aok0ogYpzKXkk5eL1KEKIPAyEd/kfBddCsvDZgQtxf108WEQOfPvfIUP2xQFvNrNOG6hXZvzNSO7CniovJae7CtJZowvyuN6Sn7gy4uKELK+eUK+at2GztoXmbjLWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lOgC5B0RnIYJNLv6NUa/uURzfmNC8EZwm/4kFu9xKO42LOmGD4noSN/kOOlXdq51/nmZSxJOiFjV3Wsvt24Ti60UjFOr96wFbfrfZRabyJhC3kafARXczEKuE41SJJEwRPz/dOlHNvKlkHwMej/71NXL+D7cf0uhNCIG0Z3JTDWvqqMjhMIAb7pOs3cdVzBmVk5/tBpXd9QRJsY//PzOWOEqvXXneKD2x8LIQZgARVHcPwaFDlmJ/Gb9UOK4pVn8vXuSA9Lz5FiInHu0mnIFlXV/XS3cPSk7SQ33qLlcxbmi4QceRpA8mNVhrWkLqPPu+yUlH5u+6TU6a4G0m9X5IxssLtjtOXl9iw6Vi1v7HTwBmUowfHsJ78Kz4s/agWqHz/YYCaBhkQxl+/lxMZNA3DG8KkcvEHaWGk6M5VTtlvJSfXhcpI4jz5RybMTjlb0IJZ02ImPCK6R+m6wFISDq6O9dMRq6St0dBZ8aJUH4tHi4XL2AdaWBXDjMEAyogakXQKgQXeXXeUspPwspEa1atpjNPVRtiG79hVhrENxn1WUDieXj0ULSx7UncIrHDtkMyPDrlgjrpejaaMmpptZ/Jipw4tcixi2R4aJGs4BXNPaxw2zCPlSsgl8nW59IEHwx0vYqxrq48rk4o6kS+drOKQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073acca1-4508-4218-2081-08d850688989
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:21:58.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klDPsBbtqLcW05QQVYPOlOt++QCf0LcX8HKwA8wMmh8dcdMGdpL17Nev4fXRSeHeHGZxOH+dpyRr8TWRruGR4RlCZ5sQn/rpyMmaHtEjxPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> run with: nvme_trtype=3Dtcp ./check nvme=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
