Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2159C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D416206B2
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVa+nCW2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dEMm59g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMCmS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 22:42:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31738 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMCmR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 22:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597286536; x=1628822536;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
  b=IVa+nCW2jIDJXE8nZ0QZkCpLlVNF53IABVTTDzZASrnwChpr8b4Q+esQ
   uwV1Zy6CLMf0a1n2ttqCfQHjugaiR+t7nePnp9iyOVEJh6HS5pQx/ijQo
   YOZOewf+Wi9MTecbGBLwAvjYmJhFhTCG1vyrdEr1KfSTna9L1DWPAd7Je
   VP6hfdVVDiCxMVzU16VT7/f9bN+w2shEEEzOvvOsGWKvJNxpmteNPJej6
   2pGQVewYTlQHhZoJZMxivAmAyKpwBDbPBoHH/2/K61cZIl4iySFLB8XSh
   +rP/gegNxxlWS312hcE9DsbPkbYrpuan+JCNZsdehtaMsrqtx1lURkvSr
   A==;
IronPort-SDR: 1j5PDpmXlp8hYzMv3bIw9KjMQ3YSjERz9YDNw6LhFWe4dVepVYnQUwmjVXUFgeSn9gl08yt7Zl
 bJJKEcR0F5MHC6c57E5vakFogUq9cFozrf861DOYKONSbnGXoNYmSxYzgwKyGJpBGR6AeGfpsx
 gqQonH3rV1AdRVPSTx1DhtigPr6majbDSuHJpudyLJQ/O+ReuSQUIZAuI83HO5SnJe/H9krunZ
 s1S+rtzYLUD/Ji+z63jVnk+m+YYebkcf4tzoxOZGlT+BvOKL0oqhxpgPDUvszP3LbI4lP1Wcfp
 Xm0=
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; 
   d="scan'208";a="144867261"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 10:42:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv1iiSe3MWOfUVDN1Dl8kxnLPPVfvzHkEx6kUZrPMDne6A3anpyrMbu+fVNGJcJWZyWOEgCiVAicEsls6VznZiPC88I9o1YJwc077iLD99P7xwBSxVYHB9bhmxNe362S6j17U18E638O8Chk7y/iCQG0StYmNDALzVCk6MnmZJ4LWxHhP3eH8qvgnsiWQ7iqkdhu8hBWdLRbK4AHpX4orc3dE0HEkRtoFBQ6OojKyQAwd9lFf5nZsjwwhAnMd2TOy/eQ23OmKdNnCGEViBgLP0axwZhRzVfrbUr+Ycyc4vX7G/SvsvC3nzbiNKUqrRiyrItPRFPBzhZagDkYsBPAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
 b=YV09I8JG3xLEc5tQmlBhthdV/pzEaauXflDmxOtiaMu5XYZKY+yeOsQz0IXPPTp6ExqIx6n6injIOpeWdIaf59Kynh/9TKPc1mm1lpMtdMnVc7UwQLHMzeucCvAU+wBStLG3rdEIbBqRfOhYz9xKKgr1K3AMHhELCYL0Ss/8fQFetRwIZZP+FpT2TU3NIpDa/2iqhpi/QYOxjyr6Hbn3HI3/Bq6YAX5865u/iZpzWnyRFg7K7R13+8tHGAAPufV9DjQ62kHdi+6Saty13ghEPY0+zOlmN8RWF3HHIzQZHm8IvGfqjg9YbEGiIgY//Oxcm+gj5EwL59O5yVSFSASXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
 b=dEMm59g/n7b8AMhF6VjzNVqXUm0LaFSaQNzht6JwBSe+0kGOHvlMEI+g5WXydSsFLELhHBFDBpGyuiJgb+eVuvvbK7ujGSsG5e+HyQV1yXoZJQvgcLJpq/6zyuGf4qNISs3CPBN1MWTPvaYOB0otxcpDDZt+U/1z4WX99GkXP7U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 02:42:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 02:42:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWcCKPtGpmPEht4UKtjYODWQU5Nw==
Date:   Thu, 13 Aug 2020 02:42:13 +0000
Message-ID: <BYAPR04MB496539E26CFCC0A17C55B4FE86430@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f082823b-8a58-4ffe-a96c-08d83f327c5f
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-microsoft-antispam-prvs: <BYAPR04MB4871FA87AAC03BFB34E8493686430@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G23d+o+5MfqSAfuKPuvqCaqov9pRSI2P26Kk3vgSdMsr1gLBsxHaV7p3sA8cILryPpcdPD6DfNO37hSjxsy4rde8JIqtyQ4Bi/LSM9vMQtNDecPLF3payJ6jX9DZ5hxLE/7fFDyABbfCPsDuKQtvl3jI/ZnfahOCk/XmqgBZyWpBl3vA49Pa9ZOU9pp30qyRONtspKhvtbDnSqd1xPv3Z4LGPa9Al5SNDBfRPKL+7dXiBNVcPz/DatjQTKcx1fbwB1NrXlm10yEgvDOTUpPAPzHjIrUv+/CGb6IJ68nkthKC3iQcPDa3GEnrA7Pm8/kQCEEP1nkfIm108Xjg0WegJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(8676002)(8936002)(558084003)(110136005)(54906003)(66446008)(66556008)(9686003)(5660300002)(26005)(33656002)(64756008)(52536014)(2906002)(66946007)(66476007)(316002)(478600001)(55016002)(76116006)(4326008)(6506007)(86362001)(53546011)(186003)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z3+AjiWmnxm/tXSHOCou70RL0uZq9pAw7628vP+V2faaXFffYrfbEDeFP5Zp/t61kvZUBBG3z7qCC1Zo9rteS4UdOlYKO+xHmXR9wBPJZUQgbPQFcpEbawmsmckNWHdhcv884k0mAgq5KgT/w4/Dz55CCUrwRBgnmlTwt7GqRPwgVzV8obOP6PjmRL/Qd16AOhEEuIq4LabwtWvp3eUTENIIoCKCdmc9Wn5FZr/AB1W8X6SNfjxVrYJFMmFy67XxqSiLvMzJzonzUK+c7kXqH1J7X1W6DzBN1fu+8W2z1qv7WbZm8Opei4mSmK9pQKDVjXL0jR9Ydp+aMmfenBETqcMXJ5u3XtKDZyY67A8MHCb+cULf7bciE+jD9+n6SW4oEzC8a8a6/xRugsdvCwEAmwcPnoFxwl0789oZBzG/1mydqwAic5Xz6td+sP/vX8Hq/5MjI9WsTBr6uLDIdErXUJ5pw07vL3gJe8ui7JsL4KkvQYTeP2S7etGoGNbI48X6PN6x4fmBGTzYgitClT6EGHf1P/xnz8BOf8Osm08Obe82fhA2RlD5AJOjncIYpnc3pnaL/0WUFtv6plsJ8Ah6KZVfplsiJKTfJ5rhiv8Wiz6XKAxC01ERgGOxbnGnbKQOQa/RuklCSefLeBZftEBlWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f082823b-8a58-4ffe-a96c-08d83f327c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:42:13.9594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fm7trZ/yv5ItUQnSQhnnAg75DfnCtj+oiY8JWzPNcQzEvwrbAOjIhzb9uzT9yJbHkUiEYg93B1NXcnSmGJS7qMXXeaNWrdbZ1CmHQSJMdLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/20 14:01, Sagi Grimberg wrote:=0A=
> run with: nvme_trtype=3Dtcp ./check test/nvme=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
This patch looks good to me.=0A=
=0A=
Reviwed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
