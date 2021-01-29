Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689AC433E0
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F9764E01
	for <linux-block@archiver.kernel.org>; Fri, 29 Jan 2021 00:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhA2ANB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:13:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45299 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhA2AM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 19:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611879179; x=1643415179;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7cjtUuW2Ce197SZkWCy0q7wgFDhJgMuww7zJIUR2o8c=;
  b=QbeO06M8smdnaCy8X3P23lT1RbHOZcSScVPDzNks5DvjgIiR4JNPBR9H
   UOrb8mm3zSLCzxyIJkyNdX+ol+oXwD0lNKd85Vw1E55uFI88qB06NuZQN
   N8eatTcVJ8DOHzwS64OdOi7e173YBZg91l6ZaJHpBr1hjHKNZwvJM2Ctl
   /BB2Ve5HCHzR+cSZ6xfgA2tvj0scQDy+fRUUW4KDE2uJD5if/tYXPZ0/g
   s2kcSkh/BnuYpGuog+3ysxfoyxEkyYzScqIQu8W/P6qAOmiMaseq1uFd/
   Kszz/JxgHxHU7APpiNQk0z77hBszdN9QI5yTgmu4vvkkac+9R9mrFXQga
   w==;
IronPort-SDR: RFQHjoeNzuwr3kGKVv3uBJOWPDxjqSryNnbuZl+G8MWbQ4EMYs25MkykyYPLLP/SeiKwDLUYPB
 /p3UG9gWQT/kZAdj0APm6GL4PnQmbTU0BBb8OdY4vbFbFITreJGYSSpyqaFZevSzIEssBdfmUz
 HXv1bIAx7Goww3shVWSUuL2C7gnbH8Jnfa2aE+2SO7YFe/Zc3/QoBA8XaL12pnD/YVMvenE9q0
 fOG+ujhK+0e9uXixzJQ9U0Q5LHpdCSFpzxpXnYwZApBarOx8Ku5IwRg5R0HEQsoJrofyNBLhE8
 16o=
X-IronPort-AV: E=Sophos;i="5.79,384,1602518400"; 
   d="scan'208";a="158587647"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2021 08:11:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQyPpcdJXyjQ134EJRiXpxcQqEz9i9NpRBlaJ58f6Cc5FFhoTZW9+VAYTzqIhwid59sBgPFEwpfQS8Q32OH6JkpgY48pL90rzprDLtG5MVdVAhXCb2S16cSCBSQ7tHEiNMzyzQM8MmbpZP5jhY/DI9wRQ0pLyTY5ETfetg2DpMvaU+PWRMl9k/CUgSnUQAX1i2/5Xjx/YofWpDGYqN6iFG3R7c220hCUl7Srq3RScjoA29WbmzheIMbJzlK2IwDkiKW4+TLA2OI1QHwoRBz6PHFoozl8kbEd69S6VBiagJUV86s/+WbdGuNgjT5Fg9lr8sRm0cgdm5zHIHf4xHFVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cjtUuW2Ce197SZkWCy0q7wgFDhJgMuww7zJIUR2o8c=;
 b=Lt08s7QsFTGEJJoYDE7fDNouujGHYw9XHdkxCaerT6hk9orzYlDbYC8cbzSY2sQrryhcU5FkndyEgJbeZeNkTSZMjLTQzdTPvAPVO3A5T8XsS1eF5nj6VIhUs60L+FP81WSCwSURINx6OnOVCCXTKlV8YNO3ObLhsYVt1yb+AxGYmFpeLthjy32XZMPGpsQ0+tzfCnGqbehMVpYdbYDZh/zAI3rEyMNdgENjwadqING2ikDaOGpC6U10oBI+axLWOGogPTvIYxhLBJvwsowy/9JTT7ZsljjyGAtWZBpmhhU45MdGrvvSbMxIXpPiznfb30Py2PAdPO3YZeHrVw7pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cjtUuW2Ce197SZkWCy0q7wgFDhJgMuww7zJIUR2o8c=;
 b=AevG1f05nX2G6/Ybk/f3VQ0r1L7a1CAojB0gxVumOrv3b6vwEFml+TdCyJoMgQvldg7ungsyDLmn7FQmJnZwZOzrQI3OjapDaJTKcePwkZ8G8EcqHhho1AxaopfXYx9vA/azWndz2qzPRffpoTbU2eamQGEiiLNGleZ6lWalpMQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6484.namprd04.prod.outlook.com (2603:10b6:208:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 00:11:50 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Fri, 29 Jan 2021
 00:11:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Topic: [PATCH] null_blk: cleanup zoned mode initialization
Thread-Index: AQHW6JWhTDBaNFwpekOwBKcgOK9iWw==
Date:   Fri, 29 Jan 2021 00:11:49 +0000
Message-ID: <BL0PR04MB6514EA7EEEE92B962F503663E7B99@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112034453.1220131-1-damien.lemoal@wdc.com>
 <75908f7e-7d30-4e90-c187-c473a14f0f2a@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:47a:7b5a:7dfa:1b1e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9078556c-ba75-46b3-2284-08d8c3ea797b
x-ms-traffictypediagnostic: BL0PR04MB6484:
x-microsoft-antispam-prvs: <BL0PR04MB6484EA91E14E7168E2F58095E7B99@BL0PR04MB6484.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nocDvIEAZW5RZTAeeevi0nFQ/mtfVwTS0ZYyX8ZVGJMBDYQFLYDl5ihPWqpsh/WXwYobXSB6UB8jOaBr9rOaVciL5r6uKEqMyrnSJHj3452aN4YEZwZh3bDt92U1GJBxu4pD48LHoMp+ldtocO8YxrdZla/QF7Ayg3l/Nkks4xPqzldnH5AVAaY/qc5/k1eBXsX8hkYVkc4v+/r3znLtDca5cGvKaS7S/8OepcYbOPBOVERP3esBz/fK8sJ/GicEOUAnmFmwCO+GcaAniIzmUHfZd31xBDeKsHhfBHAw0ttPt0TQskLLyFXtyhDm8SohA6t344Xft1P585hMhiz9LMUNt+cQS1QydUEwSAP8UO0Zkr/J8qslEjH9aeQvH6/qT/cLGs5uac6ouhx5nOkxk3P0TkfCOOc7VRLZOmAadUGebLfrLPtQGrGYl/2rTygKsTRm1iy8HpbGUYUopX1i3Fv4eQgGXXYND7mJkCbBbZm5Apm//drkXGvKL9NhMQxPz3zkHS+HEcwvUrT61/ZMBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(110136005)(9686003)(55016002)(2906002)(316002)(5660300002)(6506007)(7696005)(86362001)(52536014)(186003)(8676002)(33656002)(91956017)(478600001)(66556008)(66946007)(66446008)(64756008)(4744005)(71200400001)(76116006)(66476007)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yIlCZpAq4FHZzJFa71wUrNAqCS37AcYSxVMRR40SiTSKBASIR9eKvwdCt0k6?=
 =?us-ascii?Q?CUeYY6ztGBXi36N3N2omFcOhjXzxkDY6Y7RICNxGueurFM8VClQ0uRS2Fjme?=
 =?us-ascii?Q?T8cOcHjEWcc8W1wwq6JaOmEkT+45IlfpchvL4V3v3oto349h4sarv0YFPP9l?=
 =?us-ascii?Q?J9spTWa6DTX/BHdL/sSMSsAwIn2QXdrMn/9oKoT9aKaF9Jj39hq9MGRzvLSz?=
 =?us-ascii?Q?ZMwY1Zk2AAo3GGmz3BcLGkB8f6SEWhTUO9qZ3C2NM+L0PrRuskjx0PHGslUI?=
 =?us-ascii?Q?9M5UaKwsKLCUSZTDUhsywcYZygbu1YPkrc+pGNjU52VW86/2kOnE23evniVg?=
 =?us-ascii?Q?NU0NL33O6zLXU2+XI963IM7LkA/4blO+TMFGZk859NE0v2CtdcP/f/ByxBDM?=
 =?us-ascii?Q?MxopiFtBiVlzPReFqdtvvYW96TbtnmGavq8zejadir+LM+LP+6SguHkeHza7?=
 =?us-ascii?Q?0JntTsTs7nNKQBlutF0hRFhEeJq8mb1ovqFo4hAixjcQFv8h4o5xVm0154wZ?=
 =?us-ascii?Q?xZy3eVa1wIQzMmVAXDX9wp1nFzkLlS+Azb6LNdjbrUGWcKtzCcv1csUWTouG?=
 =?us-ascii?Q?KmYH+C0WjENrvHbn1Fj/d6XxEZsFoXwoY9/rJoRWUQx85IOx1HXM2ztRz+R0?=
 =?us-ascii?Q?R/cp+iVVUWkbEmYV0RyoOr4m9hwNPTJsHsjSLx39qFIvHCQYt9BaAwZlfeJH?=
 =?us-ascii?Q?yhGMroX3D2lL0rpVxuFgw3aQd/zXFeMODUfgcsbiEcSfQcAX1KD0QyMCB7kc?=
 =?us-ascii?Q?uAxn6BAyt75zwr3tRdQgyFCWPp0lpWQgD6Zhz63YJRiTgMCFaAvI0EyHU31c?=
 =?us-ascii?Q?dNHfzeqi8Pu2cctoOsNH//89nTfvZ4b6XfSJdypMFI9e+V0JbEPwdziXOwh+?=
 =?us-ascii?Q?E6MxavELWVXXVcJsnuCCmU51rXGsX1C7E0eXNTlyF4xs/iCjA3JmzxeMbyhE?=
 =?us-ascii?Q?GLxWPOvzH3jsoCso/AMRPOIUCz5URCRyoJhK+4CmQ6h3qrGAT8E+Ym4TT+DZ?=
 =?us-ascii?Q?qycTqO4j2uqE0tuLTiFJ7JmvL+R0f3OqAF/XRMQrNx40fbFWb/s0bfaNOJp3?=
 =?us-ascii?Q?eNfkHAWtwfrPqQ81TCdunFPR63OldStTYDOdFBwsKsslIJGKZbowVaI6J/p9?=
 =?us-ascii?Q?IaDJeplzxPQDsixW8PKo8YdR0AKK8fumTA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9078556c-ba75-46b3-2284-08d8c3ea797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:11:49.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAu6hMsajkXjj/MmFAZy7oggaQJ0GGbfy+L6dYfEcXuj+9ycNN97EvWAY5OKQxGPn4eBrnX696nBvIUnfqusAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6484
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/29 9:11, Jens Axboe wrote:=0A=
> On 1/11/21 8:44 PM, Damien Le Moal wrote:=0A=
>> To avoid potential compilation problems, replaced the badly written=0A=
>> MB_TO_SECTS macro (missing parenthesis around the argument use) with=0A=
>> the inline function mb_to_sects(). And while at it, use DIV_ROUND_UP()=
=0A=
>> to calculate the total number of zones of a zoned device, simplifying=0A=
>> the code.=0A=
> =0A=
> Sorry missed this, applide for 5.11.=0A=
=0A=
Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
