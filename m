Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0DC43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661032075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dmD7ZaZJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KaQ3URX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIDATf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:19:35 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39932 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDATf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:19:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178787; x=1630714787;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Fp2SCQneva/1r/ABKQQxXKqMGGbjS3QyJi5htJqzOng=;
  b=dmD7ZaZJisGpL/cO5InEOS6lCCkR5XCq/RBc3jxXdskDzZ7fV9IprQWM
   I9Xw5AoKFKQlvg4uBbHLpoxwor3e5FIdqpCNdmQGPQmeCpYvE06I0ZnIe
   gpK+OSBlFvupSfhmqiNivDIEpcgf6VnG7Ur7/3+mcvMj8j/6LkI/7Hc0h
   WQJ0gLnmb69bSsbRsZ+QOehQt4qM+S78bw5HHK9QHWzFlH+nlYcaFJwFe
   8yU/v78SgWpflqgl806bsvQ/ILQGOIrHhiEyIkW6c+4g1EMS+JkBCKuoG
   InG/PmcNIORyRKvitQlAt+U1seKHvtTt38bJD9LBoQEQp64lHtlMQ2Rp7
   A==;
IronPort-SDR: W3K1UXGhyJe3KzXne+zA31hOKv5frJ4nUVJgl0H2pV7Au7QEpF2ncXTGt+FQIvHsxfH9rjixwW
 xoY/OhnZVcQ26Idi8rJkgvt3wKvGeJCFoSMY/yjs2Gni3x0hSBVqsxGwQYSC9wL3TzJUy8Ojkp
 k9WJaDxB/OTUZtRdreLZkMxrfeUa+PzkL17cA2W6EuI0h1IkiPnEMJEvTNxhiBBu6D361Qjjdk
 LOjvFe15BwiKoFzPus86pSqQO2Kbd/MouLwPKZAWdGcm1fS/jor1PNF25rdhoxxu0J29F1vca7
 Mfw=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="249814444"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:19:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LE8ph+XQlIPyRnLYq1U6dZSW317N9ax/HsHL+gl6Fcbb4hdG4smu3K6D264oh3RXWGlg+aUlvYh7LFqB2lwnGcite5L3nZRp1xpo2Oz45AfElLL/wcsi5UH6xg6DWLZAxkKNvkAU6TkngBOnVXnUyrq2Q0yfvXdvUVTIb1ERvDg5wSXwxarzP60yynuEj1b8G5ThfXKSryRX/+q9GeJNB+O9PAy7F9SzCXcb19N+gkBMafi+fv6oLjFQ1zGcWs6pk1DGyj9P9LR52FCTdJYv2IxpG2PKcaXP8VQRwJWAHU5Qy2wr3dnJ5Tx/qFgOIJP1WEz3fkbJdqKpMmsojVBl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp2SCQneva/1r/ABKQQxXKqMGGbjS3QyJi5htJqzOng=;
 b=n3xHOse6ePqA0Rh2lthhtjGrK+dvaIuG41K6/ikYL5O/l78xugGKZEadj7pGh78jRGkY5kP7h9nWFK/peXRbEXV20QMKlEiGjl5KSofw4xnfCNdlNft+zchErpTq07BNkNEVeZtxMEj6z38P/l2DWuzeM58YJ9TmLl82WWY+3r2HQl+1K18oLchi4ErhvmVB58IqvhNiA4AEMHCHv9s6VkTVhwSdRnDw37//sZ9/y5vX2uyJdxupiXXZawFTFcue9PCHj6v1hf4h0JaYDajxnbOANqN5syufHCzx/yg5r7wQDlkkArA83RRIDJZyfBHbc2MsZJ3jxLI5AkrJjJwAdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp2SCQneva/1r/ABKQQxXKqMGGbjS3QyJi5htJqzOng=;
 b=KaQ3URX8BVj7yaXzfrpTIvbhVqQDF7p9Zz851YUq8B1tQ7TrHW+X9o8V18Kon4Vj3PzHgmgVCeDRVFD1pX3ZE8EN/SiohNe4CU8wJ4xJMiU+aBUQIR8aa8cD6jYJjYmc9D3Lb3iR5ktvHsT/AWEZOcQUCeBuX3hgzwVHxqBp090=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:19:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:19:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Topic: [PATCH v7 2/7] nvme: consolidate some nvme-cli utility functions
Thread-Index: AQHWgk2HSTQol7cQYEiLadf9mf5HUA==
Date:   Fri, 4 Sep 2020 00:19:23 +0000
Message-ID: <BYAPR04MB4965F1988DC4EC03624E0F93862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69a2eab7-e688-4aa7-621e-08d850682cff
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB4424DD128C7669FA48FD00E8862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:338;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nBh//ysip+BlUR1MrTPnAOY63z1RnC3QdcTyk7sWKEQfBI7O8tfy3ekhKw2hHT7kzU/jdsPFg/8jJOJcLEAOowMNXej8uYzW78vIeWRSQoPCqfB5KSYx7/uFFoT0DR9oNJq17Fdj/lJjCQ62JbsLB8K3ZRz7JaG/VnfFUDQ/OxEQX86IobFFGHs6vMC0FoGovpJN5IifMRytz5/5O3NPoOvJ9S1rTVFZHyp3knjmQ/ORTJZewIKJ366zI5Y7AL5aK6dI9t6SMY8aR2RDHgwIHzhHMM7SUr0vvln1Jatcpuq8oxN53GDCMYW0y2uht2QX951V0bCazDKcZMjH/Wge2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pdtF86xP/YT23OsrdOSXxN5hcxjqhVRNztsBj5LPq7hMUrdc/woQi8oBa4Yq/G2q/QcTVauF1Huf6hBFtp5dCqyE7Bo2Al6J+YPjQYeaNLafiSm+k8HXllTasD61+qHnLcF3z14EwqcKj6mFKM9yxCiivbvgbiLh+xKfTrtTWqO/GGvRLkxrJQlsJtwmszQZsyIP+87AvkFRO1G715yivkawGtqOuBBCdQHm/eZnBamQ7YViRwPNpe2iV4vlf/EvW4HsiuM7ot/V4QI4gzHzeepjqLd8sRYRiQlAEMyuF4vhcJw9pEddAnQ98o8kNKP4Arx6WF9mD3caUp5+NfxecbwADUSI9RcV7HkVOO0aeDWW2hPuz7f0F26IhHeuWXBU3L7uOpx9W6OL7FBx4O8LZhnoQC2DgNw5c0dHoSfOWi3/WOqDenEcFmTxDwCe4zDuQ3TvR335+JRHprA+zll5zngZvUkO/y/zb3EeF16R3JmPhhuF8iCSAluAwWyrYT4xwzsYih+JiblUTiwHETDwkmW9MpTtuBoHcVxII/20ZVH8Got4jnwlieajxZftAMAyvUruMxIjuCUtAsOe+V+48xUe7pHUhJaqkaDaVSzsBpN+mYo8hpcEVu2wn4tuM13yXF7uzUwu1yl+c5u7f5Jf2Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a2eab7-e688-4aa7-621e-08d850682cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:19:23.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoQ7yecJeBDXaIfPIz3C9+dJu9UCh0MOBp8mFT49x2k2mSUigbO0T5mTWLEfFEm0GJtEPSbEqQ0GsXxwjjBwW5+2kqmM8yGE0PxOEFcz5qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
