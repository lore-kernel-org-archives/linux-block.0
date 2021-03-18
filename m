Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C2C433E6
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 01:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EEC364F38
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 01:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCRBSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 21:18:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15940 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCRBSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 21:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616030290; x=1647566290;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JmukKzf91OhrFZNkvoej19eUugkVW/z59BvTzd83rfQ=;
  b=H6T1esduFWOYrVuAbBX0VVOpVPolKDJ+HCwP2FynYo6NzOVipchFW8/j
   1LHSlsfyJEQn6ZfEs7XKrThXo6SIVrPA7oirM3UGrt70Gj82KY/ycHrkk
   zzXOqg5CYIFB58r6A71rgOqhBYWto9g4MqPnoZppXlVkrOVSWQwLIERpI
   BJ8IzA5/JxPmFVL+sdD1wPruS5QhCJTAtXmZrC1AuVJexBUZn6En+A6T2
   pQPa9wHGhZCyVDr8AMnfUMAdOHCu2V4TTHHgpl8ziVldN88JMKfCWZNHm
   MahcP2RlvHiGRmQstmAb5Y7Qs7oTL5pH9H14IsCm5Jkc0A59YEpC3FdH1
   Q==;
IronPort-SDR: 2IkBJg7UfxRiv6dV0zawfO/NwQgl3WKOi15mp7v4REMrrOYTAYY92MP+wfirTEW1rmJHNwK0gX
 QckatI/c7aLfJhvde8wPiuZjdpaTVCTNa+qIxIY0oafWxhScSzMvihg/2w+ChQR0sZ+BBMrdkI
 DT+P8ksxpCV5ZxcSwc1V6wy6C3g9i1DPHcLZy2Dg/pX9ikvgkpZU0GkfTUzfS+tNzH7jN85O+h
 LsLtBlQZK5Ca/Lo2wqp3wb7nUWJ+/s2xhSPz2GzECWS5dExRobYdU3wsL2X9/strvnTLdGHluV
 ZR0=
X-IronPort-AV: E=Sophos;i="5.81,257,1610380800"; 
   d="scan'208";a="162417443"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 09:18:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfGZaiBvw7JjXHbNyV/vGQTpTPkRDKn2McXgFS+P0mqkq+lopMiuQzt09jTEYnalPxQabbZDzUgZtwAQXnVNAOLTcCqdyOYAhQko/+rWG7KcRX03VX+QiOCrX3+SARjvFAiiGUoN9Y2LpuBqUEiGfytisbJW8/okr40t9holbX5u07NY78/rD6ug50YtvZri6v1KFeaYBmFN+YdmU3rcbdjNosquSdUmFg6vq5t+qMJnqfVBtGFsfIxNqPoDBZsxo+4kUv3twuWRTKirQXtpEMsBnguC91JZLMnf7S1e09q78MVP5V+8vMVKHqM28e4OmVfTmOUyqJopSoz1DbHF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmukKzf91OhrFZNkvoej19eUugkVW/z59BvTzd83rfQ=;
 b=bPtMe7M69e6tUXhLq8KEOX88FKjatSoVbIya4+criyxbq26btGtUd6mZF/RHys4F0lqE2h7xOlSxGHbRnEOHQNMYY0JlTCDqTYN3z0kgNrCoTf5WdTdUu8sR/uGiHa+QPjKyHjGFRmr94TbVXTlmC3KVPu+mqX2xUcFJwkk+ZCE04et2zsCm46OZh5FpgyIN6O2mvMIepptVGkXXalAClNehdehSs3Tf7uQf8rVrOPxPbXFw4tQlJpalsWGy1CUJ4n5Lvq9P0uOQBez7jkwlrAWRfHza8m+c0mGPCiubKFb9QSHGtcdLmLdex9yLRIH3PrqqoXttgvrJ8SRK1Of2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmukKzf91OhrFZNkvoej19eUugkVW/z59BvTzd83rfQ=;
 b=xYLAqfeTRSULrlVQOS37ely/rvsMb+C2/xuf16j9JfoksS8DafaVY+TtPkeElcnhMOWGRwgIJ4lTwZD3/ew0idBGEXuN2eVzYipcVNenxbI4LRA+cjYJDS8SwSrIEWb4WCFnxQikq0cMHbx9peWOwuWuU/OaxQWPCVwg3ZaGuGY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4327.namprd04.prod.outlook.com (2603:10b6:a02:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 01:18:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 01:18:08 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove RQF_ALLOCED
Thread-Topic: [PATCH] block: remove RQF_ALLOCED
Thread-Index: AQHXGv6d9crUfcZY0ki3ZcRzNz3YQQ==
Date:   Thu, 18 Mar 2021 01:18:08 +0000
Message-ID: <BYAPR04MB496513686CC6B6560595880E86699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317072122.155380-1-hch@lst.de>
 <20210317134259.GA9958@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a5a38dc-350d-4651-13d6-08d8e9abb0a4
x-ms-traffictypediagnostic: BYAPR04MB4327:
x-microsoft-antispam-prvs: <BYAPR04MB43278D5BE10D9FFFA0C997D586699@BYAPR04MB4327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bG9Ccmncnee4DhsNrCQSS7ih1j0DtH40d0Qb3MVBOmOPXUSrYu0BoQjq7NmCs0FXYpiWZ4TY8XeLQAI/M4yX7ZFDSzd1f+whYA1eYc4JOAl5fE8WgEvI9LAIJxrb2jtQWVu7unenvN4MnKpf73w6DPLawTDbPuHpUhOR4YHpzI3pujYjVXoU4uG0IDWpkr1sctH9YcKLW23oa5kpBCyaXMGLQ+igBtMBKVF24zFf5XkmoppHNbkGkSOL+pp5h2hALKG+6ij7ZyjcGr0QRFB/PoZw2/d2Wqbg/pAKr+RAQpFLAx2b6gNUpaO20Hih2ANEwk1CRyPl0aQ0ziO/yvt25G1FMaY6ydAofqztSaeKwE2M99TQlnoedhgvf73u6icEi7cRoynUKdRVBmkje6T5TOlIfXoY8eTwJtxuWz99IQt0A3j5FkKlMacCZ5fnJHBBBETrMoOd+2VaAw5bNzkQ/pYAhPo44xYwOrDxfrdYPi+NacgqigUcphJ4GVZ7xrOlR7UnD60PH0VtoOGRopmMStnp3DSjx5IBOKGwLn2e0F1n1FV3ct6q8WGxiQH7CD5GqeaA/7UGNYig8PovY6a33u6/54BTZsSwbRZbOlTRiGIok8Q2dhNgpoD7CKz5jQI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(2906002)(86362001)(186003)(53546011)(478600001)(5660300002)(4744005)(33656002)(26005)(52536014)(316002)(66476007)(4326008)(6506007)(110136005)(66446008)(8676002)(9686003)(64756008)(66946007)(71200400001)(66556008)(8936002)(7696005)(55016002)(91956017)(38100700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DRoTPmBzeWrDiQkJ8ixDhl9wHa/ODhQ1Cbn36rTojdwcGnoR+L85FwxlZWxF?=
 =?us-ascii?Q?Jl0EI1mUkH9GmCZEBPJWQFjl9ZT90+dBWjSY6aRpZOU0ueYP3x8jTzlLjjjJ?=
 =?us-ascii?Q?dHyRzwD00HVfX1TrEKQEHXImnTSVaYT13v5Tm9w1U/cPs4LB+wOQhZCl36EU?=
 =?us-ascii?Q?wNNZ0DrhDdNdeu5a1Ecn1dOUXLbnlxE+S4b+Utim8HVpcB4wW6ZjcIES3fhM?=
 =?us-ascii?Q?M6FAN54+oWZq/B/cTJlABklJ8EYjXp4+Kg1B4DYHt4htgMh99ywXAt53l1IA?=
 =?us-ascii?Q?CNsgie2BmsZbRaBAtPji07UIPFjFTvN1ln5DlnwuyqcfheegiJHgKUnGLfcR?=
 =?us-ascii?Q?jn7KilpwIutkn62yR5MU4nmNqo5PR5icp780mlzsaz1vxXhT0L5SQlAlQzE1?=
 =?us-ascii?Q?SpIcv6QBCHXl64Ayt2QwYEPtuJ69wgE98POCwt6ydzC4f6C2SlwaL1eXHNO1?=
 =?us-ascii?Q?7oXonMvIOu5p7nackDkczW8SYO+OlPsrcW2DiuNYQ7pcuZFjQCj3MWeYiteI?=
 =?us-ascii?Q?dXjEbCvL+JRMoARm6FxpKu1aw/ZGZada6Fjc97J/KIvsTLsZrgx7dGFKBsyK?=
 =?us-ascii?Q?91pKMQavOZyHtRO/mOEC3FKhVeMOyEKVxbqLMnJOHt1LaRfc1YPRW0hTF8gB?=
 =?us-ascii?Q?4tmAZhxZIMcZV1Q8YgrOgobVMj59YpngEhuoyGZSvmXBWGh3X9GOuA/mAdRr?=
 =?us-ascii?Q?fqzLf5ND5M7zjVIJSqiuYGyrjeugZgkcDiLYD4IJkbgqI2iw26Y2Z0p3Zpkm?=
 =?us-ascii?Q?K4ZtJ0zpxeGH1/KSW/3JsLNpQMtcoZk5iCN6rf1v15k7o0uPRKiZSCwAxTSv?=
 =?us-ascii?Q?4fURr3Yd7ZY0Kcct3P+ryRUpuOP/RfZpcSvIbbern1L9Do7aye00dw38F3hK?=
 =?us-ascii?Q?OL1Yz8qmErVfYvasjx+EdbPqZj2M95nMvniJfNA2JaOq1KoxRXVFFnnnmDk1?=
 =?us-ascii?Q?Yxb38eqYS0mrijaYwiq+Www2w1BNPy1axDOc5TY3oneVYHBQo62scToXRO7D?=
 =?us-ascii?Q?jY3uatFPHvTlvd8FFksfeH1zx2Y8bglQe8gzkhhjqHoyOCvaVC4JM+5f2NdN?=
 =?us-ascii?Q?R63KJ1AVzCcX3jRgJlHuZvFI2+EXqBNu71Y9JeSVckpPtBTZhpb+BzIodE9Q?=
 =?us-ascii?Q?8GuJra1CWb+NO2y/qkgrDQn9mC7+fbw7I3No9L8MbG2xgke151NIhAePAnna?=
 =?us-ascii?Q?3Te8d++z7AaLIatcLrVcCiQ7OwZaW3Jh+DEAVEhvXApz+IhEFH6EUhehtNCp?=
 =?us-ascii?Q?hRf9VEjJenzh2MRUrVfxuthZ00Lee3DueC+UNpMXrSsGo5nN+YyseUUaVWOm?=
 =?us-ascii?Q?bVqqLMs4aUp4Og9eaCCBN/S5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5a38dc-350d-4651-13d6-08d8e9abb0a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:18:08.3605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GaqTLe3Yv3kc85H3VWcRPzyVwSD3ZetCW/+q+dYVI+dC+RRUAxloXOYve2xzVX8b6Gm821Tx1a1QaHl4t6DfjvJ5dBIaYeEEhhMaDPGY+uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4327
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/21 06:43, Christoph Hellwig wrote:=0A=
> On Wed, Mar 17, 2021 at 08:21:22AM +0100, Christoph Hellwig wrote:=0A=
>> This flag is not used anywhere.=0A=
> Except that blk-mq-debugfs prints it in a completely obsfucated way.=0A=
> Sight, I'll need to fix that mess while I'm at it.=0A=
>=0A=
=0A=
If you are going to fix this, does it makes sense to fix the rest of=0A=
the obfuscation ? such as QUEUE_FLAGE_NAME/HCTX_FLAG_NAME/CMD_FLAG_NAME ?=
=0A=
=0A=
=0A=
