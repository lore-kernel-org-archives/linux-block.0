Return-Path: <SRS0=BoNv=CN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB931C43461
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589D2075D
	for <linux-block@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hq50SvkC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xar8EHS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIDAUK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:20:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19383 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIDAUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 20:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599178808; x=1630714808;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
  b=Hq50SvkCRFGC/JHSBpyw56Om3x1L1dWqI4cp8nO4r6IY2u2rR+SySaXI
   PtiSIgXyVfJyMRohSxYSiADo0w3E6J7dvfmyxU2e3CMbuLR8WPxYJw4wa
   dtR5sGB8rcuhsDj+LDtSJKBUHyf8CByIOqC+19ZSERKObH/YqYpAVpW8i
   mSJUL9xwnlJGEZonBds5tyuusDs1szwGumhW3xBOu3vTp2E3qZGJDNsue
   M7aqCyzPDve6k+awc+H3thfN+GgK8hlAgYPzCcIhzgk8KNAOVjf6xfqbN
   F3T980AqUK4NvdW5R7fvo7B4Y9IinM9eZ4Q+x7MNdajVZ3jhZ1PZA8JZ3
   A==;
IronPort-SDR: sxnM+8MxWMMk2cTPYfGGukH+JCaeqdUcCfBHpfmv2/C3eRY4P91Bq7A6Xx3Ze4cV5N78iFq54p
 8wYQQuKbtW7KVBbS917mgmFPA/C6Zzs5ZSNxMsgIircPf8+MYGAwf1R0YBqopaDNSmV0R2xvmh
 l7glODoxv3FePZ2me2xulw+bwreGztiqqL+PFFpUr8XjtPXLvZLmK3qstcoSGfexeUstw7KL4E
 Jq6mrZ09nlxj86cScPsnCduPy5TICocBeOOaEo+CB7Ic+UoOy+LLy9S4l+mWzzK3UF5fx0+KJV
 Xf4=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; 
   d="scan'208";a="256090112"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:20:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBoi4MDoZc+APnpiSHJfPRmPOxbODlIqAE+IVHmIvlrpquMtznSvcBoP5noePbtJI127C4taPLrmm54t7CNAaFUxtSz0qVzenHeJh5pAheuXxQU0Q0uEcSJcMe5ScIYUat/JaWNRemYopbnM4Rn8GGiG26c9seV+XyYK85sTYP4CM3j6W1p+LjrvOuADQyuRxtxkIqjSwR4yMGMQgm4AIXM10uG9zUmKzMdR7XhQVGcNEMpaYets8N3drXMWeWMVOt1q+GKyn1kyE0LMVkO4xJIQ7lPhL9TUGyI2yTWUpKhyzGDmUtfSWlUNPcMr/P44CIqwkE9dYAwuOULqdUEVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
 b=kMA4QFuO1VwUg0MtU/+UMh1bAI3TdCAJAdu3poclyRDqmPOE0GsmQs+yAmBVqazk7zNqPBbmA7Sk2pFu+IKulsOv7+aHk1miAY/b3ORQaMG1nECePQ9VMy/+550Hh8amZpwp76lPN61kzVrNr6KeOo7tVZFbgV7R98P0rtgX//dpidRGuH3P7M8ohvN34s4cC3RVmiw8BUL+3JeR4Q+ZOJZ/WALLROCrzqwXYDMzkSXbQTgxuV6YR3Yob4tObD1czVxNF9zIBr7VxxacfqH/rX+Q76q/ZROzPGZX+WPswuUgYR94ASCV5pGvjrKyTBUGLwMIPSkUXV4LqeVWMdOaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
 b=xar8EHS27/jCvwPOAyaCCsYwg1+EiW1xGNY6xFRxPfoJj8QYUuslJkh3SV7QtTUo00BLBGtg5YcN5/vpRI2wIRojVqQ4VM8btx2Zs2jVO8Ctql0lkIlRzaCm9r1q75Idh1EqnOLPEgJoEWI59obhR/DC2ejGT+ibhAobCpLPw5U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:20:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:20:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 3/7] nvme: make tests transport type agnostic
Thread-Topic: [PATCH v7 3/7] nvme: make tests transport type agnostic
Thread-Index: AQHWgk1+3jLHIFMt60WTnwWwPsjNug==
Date:   Fri, 4 Sep 2020 00:20:05 +0000
Message-ID: <BYAPR04MB496569035FC23608CDE09B00862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09235a0b-cf3d-4fe2-7f28-08d850684655
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442452AEFE89C043D89312C9862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akyDEoA6SH9tWSZm1Y2LWJFxwDlwyrE4m1/OhWx2cfe6JT41fWozMQrrwmUReTlDQtUbVHw/so28d0qvbcIf532htMIdAz8/JL2yJTCPePT738IcMgzvBV44orWtxhfFBd4uUkqJfRWoYzpI377V7rqV4v3WcIXQG5AlWx5clEwVKeo7rRcO2+5Xfqu8S9VehbpVpmdQt6dKfPG96bw2tdMm6h6aLkJ3uEQxSnYs0I/bhXT2UK6fX1lafYb3ju5udQm35axsCeVGoCSkwDjzijzv1x8U6IQLHJM2BkjCVuuWLGgRqRsgmo4x++EHtxXMiqg+kgyK8V8E3kQTWpJJOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 11t+Sn5drQuG70LjKrthXEtrLsNHtmuchoLofhxdr1uMWCI0OHRulK+P05VkJeFVSn3tJYTWFIX3uMxsHbpvtNMK+9DIYfu68lGoUHHGLncVyKc5k7f/3eHzKkNWFe8OSANF1QVLFJagO0cAFXnFR0gisYpqobOqYk2cXamUEUAzRz2d8kf96Ib7mI0Z8b+3lUO5VmyBAvhzvcm41TtKzJc0pzkhmocPHPSwRx0NwVnt6FLWhoqPYaI2AEb9qe9O4627s8wvbQHzXiv+9wWMK5GI53ULvvuzT+xRQ5WQj3GmSzKS5kSAcsl2cRRDyb90bONFXUKUkOBj1T1t8U78YdbGUDEHv5cjeXniRuSz9dZUg78KZDIziESeZBxlH5XneRR3gzn3IP9c6SgIisLqZE7LHuZPGHU3q+a9LbUE9m3/gAKdfpLBLbP0yU9RcZoa0NqJi2AWp9ILyfZXTuV1ie9HX8/3JAQ+Vaj1WTH0aMb6KUmUH3uVXup5D7CA/FyU08733N2irmfHaSoOz4VFa5rTttugIxOX8u7w5SrYOtLtrXnpdnOOhha265jamRWnHZ3INQ2nl2bkzyO1HjY2xj9NNVhIspvyaIno6mVbVPEUZqUrz72ae8jT/BAhr1D6vQl6ilF0TwDZN1V7DVthSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09235a0b-cf3d-4fe2-7f28-08d850684655
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:20:05.8335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXKKxkw565iRNvWvUcaazFYKGmDsHF4mmuWJz/HHr8jXUoCtB1XIvfZ9P3HxdFlqF5aGWfDt7/8O9vwU2BQIXhh6lNuAgI6kG4FkUAQyWG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 16:54, Sagi Grimberg wrote:=0A=
> Pass in nvme_trtype to common routines that can=0A=
> support multiple transport types.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
