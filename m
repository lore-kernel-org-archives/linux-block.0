Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626FC4361A
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE8B22517
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 03:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgLDDPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:15:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32692 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgLDDPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Dec 2020 22:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607051713; x=1638587713;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1o8Sx2OhJRpf0RXua4FrN9RqJgnMBSSFmnRV6e7Oubk=;
  b=eaewtKPNLEr9B9FGjshThVYjATFCl2dJaLlG/iNKZyAyl7C4iAzRfHTg
   1PRNSaGVBiLthL3UCDfMJoGfMnpzIN6WZFqDw2bWzJqrqRvnoxrdOWGgz
   CvJGkELde4uh1zQ77p1j/v2kuI89hMWxaj0+zBpEgdVAKxGRF+2diF5WR
   tDbkRCfEbWToWIhOKN8TQF73KhfauZIUITr8+u2Nu3w+qc+fiCazEAPRp
   LB3YoU3hSTbZ+C/Cx9OtvquGAWlBjLRDmP2L35pa4YzkYhleBQewutYtT
   u27gM6tFF7DTVtoiIs4Ussk0j/SPBWCZ3mZK2JjdmhibOkZN3mmZgLgCG
   g==;
IronPort-SDR: eoPax2NOZJiMc8eEkg3PeivD2zRul4sD5bk2D+9oOjGf/DJED4NEm7da7Hh3perVwk+0pSJC+6
 gEiu6hKFVDtnoDzw8sT9WMHEHPT/YH5Pn3Wk65R0dYOndWB1lpDAsXuzoL1LSImJGRcdisW3YN
 tEA2HqMlWp2F+SHaGJuJ5ZHMirIpHEypXe30kdY6uHyfHfko6+Rw8Jj+AHnBGARSBXOXmjEnOa
 n+i0X21TD5lYA44nsB6qtKA3nF35NMrKXDStgHGTlJj7N7XGL8EAQd3hdZWUKwKRxVmRwmzz53
 Yjs=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; 
   d="scan'208";a="264549613"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:14:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd2YCHSvZ/ilSzFSLMvtj+YZ/BuCYpyfp+l4L6TBm3ipJgs/yUz1wKFWlO3OoHONBKZ0VEBZhWy/k05Bi2G6dNzqw5Q4y+Dt8OhiJCJCeSIEbKza15sBks8tXHcACubrtWqKL1x6aP0uPYB82D+67ky8JbbPD+F+cOZuFuujp9hJwWuYcOwvAe6G7ZpuR1nkT1eHL363Hcla2zEQK4GEpzPwDwgyhLxj0MzvLOWgM9iJKBnCvlcyuRzONallGHXESKLVATbsm064Fkyf7ASHo9Rj1/Tf7VeHaNwumGtc5aCoegtmpTWCbQKyFAxBxDs+Tnw4V3Ay0OezKLYg2RWSPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o8Sx2OhJRpf0RXua4FrN9RqJgnMBSSFmnRV6e7Oubk=;
 b=mXI+heHvnNV2FL2vC1i8C4FhyYeTfcpqerY1B2DHa/fHflxy+1REtKRdUVdUTKze7tjfSozrncF5sVX/Ll5SaeSuhOl49ktcjcdrdDLBVaSaeMrfFKVJ/Hw3EBRFWFFIb4FC4gL9UX4Y92Cit1PREJn3e8YLUWinThYik19o9Z7+wksHHBVVY4CRdxEsYUCWGPOfgPqXIHlyRfhG4y2sApkGgLVhr9zCcjDThOmVIh1eLQpOoX4wlm/TkePSq1mukTzYnXX208KsV7iOqc4SVn0Qwkjnu/wsTyDiaazgmGfDVX2/n6q5UQdFRJXmJSuGEqg9Hmzyl0ZpKlmBOifB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o8Sx2OhJRpf0RXua4FrN9RqJgnMBSSFmnRV6e7Oubk=;
 b=CIxyYRKy/3GtMeklLBHHE58FprB8OCowkJZhdAYQZRKv5LKt5ECopQVI/LWzNHfOH95Kvf+/U43sH56fs+ZuMMQb+hQhiZs6HrcWKsTr/4zY4DYKL+8gRxyTzPhcvFn13gwdrW5zxvrwrPJztO1KjelDKCRKnHmL9AYxFDtcdJU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 03:14:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:14:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 3/9] nvmet: trim down id-desclist to use req->ns
Thread-Topic: [PATCH V4 3/9] nvmet: trim down id-desclist to use req->ns
Thread-Index: AQHWyHOivCNKuVmkGUKjkeXY/mRq3w==
Date:   Fri, 4 Dec 2020 03:14:05 +0000
Message-ID: <BYAPR04MB4965D0AD11736A0B5682E54786F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-4-chaitanya.kulkarni@wdc.com>
 <20201202090845.GB2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ab24fec-f267-4e63-9f40-08d89802a89c
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7501366179D5DFDFE0A7263B86F10@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lsLgRgrfWfViAnkaeIc5D6LZglOMEkdzJXnCLFon/72XSXYBnDLgDOK0SM5vDtTKbH9dlNjLrzoM9+29GR905bARYkPCRQZv7S7HageoL+n+cu0NS5IEYAXjfftkjTiExQIQiB4DEhpCBxmg5KJYf34t4JSpuZoPMeuqbl2L+e+4lRUVSM3BKjfCPp2N1oDBhfaAMLwvwmWpJMjFI7iNTqJkQZlKtFexl9xWt0oGb8oSg+wgIsnZa1vOJnBBo1lE1vTLRI9UfTuh5vhpI9kTF2pXmetRO9bZY31mDCn+xP2fD1HlifmTwwHvgNgixey
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(316002)(4326008)(76116006)(66476007)(7696005)(66556008)(64756008)(66946007)(66446008)(9686003)(71200400001)(6506007)(54906003)(53546011)(558084003)(8936002)(52536014)(2906002)(186003)(86362001)(55016002)(478600001)(5660300002)(26005)(33656002)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HD1xrTM3z6YxBZEboJy+qWRDMmio4RhDFzLAaH151r8aJHGKC4cHxlfe6lT6?=
 =?us-ascii?Q?beg4wBApN0JXTPxsvl9f6t3w1DsmJ+kbE0BfTWb38I767e04uIQezFCBrocO?=
 =?us-ascii?Q?x/2ujSlClwQr8Mbj1oei7JiThB2zwncLId3Szao/yLqJx//w0j8NH7oW70/K?=
 =?us-ascii?Q?CeYhXyELvG80FbCYOvs2hTslLQ+9SIOXJ0KXqH2VCSLz1FheEx7/7rQYFWTb?=
 =?us-ascii?Q?QdovHqGM1aX1o2uL4NOLLy6m8L+coBgO8i3HHJtNTJBcbfNoOROMf2QbL7oe?=
 =?us-ascii?Q?TdRu33UhQW1Nl3fWIhjjqNhzgjokZLYrBwZkzoQjNYViMXz8I6Cc/Gu+HzZx?=
 =?us-ascii?Q?iYKsuV1bqPO+RSa9FrFQyH6GKqwWW7Au8bxgABlo0gEew6PTQuEgLvcF8hy7?=
 =?us-ascii?Q?vgDIH9cuGnC73vhw8Hciql2ituGLwgjiTtYUF+EiKe48l029Ig9qpw0VurrK?=
 =?us-ascii?Q?ltp0h8rAGjh7oiwvWOnKVMnFmGmt35xZ90oxznqcT20eizs/hYGbeOF73ZdS?=
 =?us-ascii?Q?Fk3aFHl8K1ITjwhyzjX2SyQ70UIUqnZnd0Z0q2K1s871ZW+7VkTMEzOy7IS3?=
 =?us-ascii?Q?G/cxA5DVkohnUrVrpWCTFIRSk9uPZ/Eg1bm2Xdy8Mqr1u2vVZewXklrKnlZm?=
 =?us-ascii?Q?J9XSoRqEg8m+4YaaxYOEiuF5suj6KJ76NUpxppBOuTGnt/pa+mHzJ8v0PNeb?=
 =?us-ascii?Q?Mpm3Sb7G3YF5pdOgF8Cm3KMq5s14SgfMXxQL/pzPPibBmLwPAIKlhXswYgxs?=
 =?us-ascii?Q?hBC/EyCxnfzMe0yto64w3bT5+pxcKOkCfjpCuk+jUU64Cqb9C7dHbqLIlh5u?=
 =?us-ascii?Q?KzniwSTZauNI0QrLdTuom/2cJZZVOW4vYeN75DbqoXaxW2QXLXX+Ha1a7A3U?=
 =?us-ascii?Q?VVjAJ+MD+Y1F76MW/8Ki73Ug8uxJp0bfDjGmClgic2pevY1j7oUnXTRh4xFN?=
 =?us-ascii?Q?x4qnvRRpFOXDLTJAO1fc62e0XSfqes7GZhC1kY88D83wkrY1LU+xMMX8X41x?=
 =?us-ascii?Q?kRnY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab24fec-f267-4e63-9f40-08d89802a89c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:14:05.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vJtzJc3TqWT7mP0PENfYpJDb/Jnozndcgn6Xi+J18kUaLtfcxegxyTbB59gOEfndWp9ixmjeqLu9QKg4hzytyTqGX7WUHWPfQVPhisvo7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/2/20 01:08, Christoph Hellwig wrote:=0A=
> This should probably go to the front of the queue.=0A=
>=0A=
Yes.=0A=
=0A=
