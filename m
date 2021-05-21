Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AC8C433ED
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031CA613AC
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhEUFO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 01:14:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63233 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhEUFO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 01:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573986; x=1653109986;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=b3gXrhUirkRURCdFMAnJgCEIPHYW4LHOyssuK60rsYS1NoAbPv50Ap6K
   5QlWmpSYtVQJm+n4PCNiaBC5SiVolUYZit+xQkYkfR5glczQGoIPw0k47
   xAwy5y87QhSkfO3ZnZnEl0ZGx/Ovdvkd/ZSSh8MQKhJ86Fz34IVOb1A8u
   d7MCPQO3F6wBwp1cCAr/pxnJX5UirsAgALK5gdrRqKE6QvRA6iqifS3mo
   Ip790wdvG9e+ZEiKE9uo0Zwu13L7WQflnDtzpkCalsbsqdo4KBy4o+sgF
   yxILYmXRYpvsVEoDJniK6Lsgwe59l3L2zbvK1Ef62RWzSJh+Gub8zg8/V
   w==;
IronPort-SDR: WaJJPELP6I0uk/47STaA3iWSx6MRGZYb6DqgBIQ6kzIbahjQqePybB+nXlumoyJseGWOWFFM7X
 3gPyg+UJ5B321Ui+mamfQq4UWZ/G4K5X4OlkfNTgcdhYXJWuNzqw7Ei4etjAm7Z12gpiWXWCf6
 zo+nseN9YtU/vfdMPQAl7fFFAU2CWXjOBoLdsd6ArQhqVJvJ9/5NWAXVZqq9MnTkAyvPJuZt7U
 gU+ht+IRDxH0AYdKWEiINo0qvrZH1qhQPM27lB9Qd/ZIMIN5u9wbs9FNfsi0Tr193LeESzEuWl
 01w=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173605137"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 13:13:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuMvy2WOOwREZ0FAqetoTD6q48d0V3vLSwTVA1Cu+qmwqRJNSUzAHcUBsUYP5Ky/32g1m3k8/iPVFCQeT4ECGYNDbgcAH05PbBwRrKpLqWTQo87W2xNWWaC+aOWrL1g/+Bl2ky91itmd9NkO+I+TiBDlEUU/wdC1Nza0O3pJR2G7ZKP929CH6QxL1j1nWiKPU+iw5ks+wmkB54DzKQhQTEHhEgeRKACUEoyi36r4V+2mD3X9ZNyVbtzpP/3A5VP0qbIqMbd+GxkwFvakb/w5KyyMt8coRgFSrsxQv9iu/19J+5iWZfMSdeBRfZ+KQ7lfyaL1RZg9lvTItzN+1GGFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l8N1ig7bJ3m1MVl2UtYpgV9GyFXynqwjqkY/llq30c4CWRSWnuVmB+lmmTf/QLJ+NOyA0t00/I4fDx1GEgQ0nJvE3E9GuinsOMG+VXtwxuT9Q7shvjjeAX9/N2CkEeTePl1hH23kMbl3D0qjGWff8rbik6QjIyvnonGCFRTpNLQ4O8bGY+m6CkvbVUEeh2H2orSNtCJZAw15IiC4Jc6TmsPc9bkG22vVYGJOCRZddO7F648lOzehZdsPWVXhmLFwlyQXgzNCa8kk3nRy8qIKq/V1DBGcu44vK2BGQsrw/EMF4HZJYBKsJ1wIF6VkbUw6sFdtBWB98ZAd7YK33Q0XRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AbxaDcJTFi3urle3IW9BRSSTRLlhQYXyzt8KsztfoMIaHoobmM5vtEiSFUWBR9jmr9HvprtoawGqkTmNQV9BpxK7UPpCuhMtFdwnIPV+d83a2VOOVqwgwr8QKlRM3FW2Yl3+q3OsqAB3GvuRQ0r2gDn0a8SQgyayomCWIsUXnwM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7255.namprd04.prod.outlook.com (2603:10b6:510:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 05:13:03 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 05:13:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 01/11] block: improve handling of all zones reset
 operation
Thread-Topic: [PATCH v3 01/11] block: improve handling of all zones reset
 operation
Thread-Index: AQHXTe2XU1aQ+8ObyUqkoRB5QhQU0w==
Date:   Fri, 21 May 2021 05:13:03 +0000
Message-ID: <PH0PR04MB74167C41F7BF7396703FA4CC9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ba996a7-9645-4b55-149a-08d91c171c5d
x-ms-traffictypediagnostic: PH0PR04MB7255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB725523BDF43D4DF48EAC44739B299@PH0PR04MB7255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFs2kJVH6hiuZIsVKtEULrVrV3yz3/6ZCQxLSFY4FkbWIM7IOwka4H/BXp1/vgt1X+gy8Tq6vDHKJhXphBiyeKlQYUywlxbM6VhboVND6MB27IVQmA4QXh6EqnGIBM76KrLNK6mHuxpKXtLjRMrzhj5emOW46yJ2xTSkF56o6ACUkMolisfcU1sL3yWsP9eXXmCtC5a3YiVIEOEtzbRBKy/NxABEWYMML1nSW83ozV0Kizc+pAmgWRWh80VP5YPrDG97fpx4k759YvuS5Vt8W6rp4eB21Kaz0CzT/BTMHbDSSyWM3b7rkdUQv9nup99T/wCqByrhLx1rTCsQJBGkOCOVoGpjplIL345McbhqQk7VkXMLl715M98j8Ck4Njwl3T0mJTYApy7W0XkPtf8sF8q0n5ANZyVXeqH/bpY5BqX0b124cup0Expwals6+hzhPOTQe8rIhfY9vIdpzTiA6/F72dbeEPZMygybvJVQu92EdpOF1wP3M/XyevTNGUihjAS/oNG51O11t9O8ZTG8tSVR+jynIZuKRRUDcJGqreQyjtTsgQoZeDVr2QfzOB4E3HR7Lm6WR7NT5XhYWUiaMHuZFvy0cd+CGly+xdtph0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(558084003)(2906002)(86362001)(38100700002)(316002)(9686003)(55016002)(5660300002)(6506007)(478600001)(186003)(122000001)(8676002)(8936002)(52536014)(66446008)(7696005)(71200400001)(33656002)(4270600006)(66476007)(110136005)(91956017)(66556008)(76116006)(64756008)(66946007)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aCwoD9wdAfBaBCd2s5QDCLVq1n3BMRU018pF2TFiZ/I0B4tyoaG25Pmser9t?=
 =?us-ascii?Q?47BoczUvxmTGDBZ7G4rtaSdRKpy+RtHwRXfgtca/Fai8AVqb7bnPJxarnzjw?=
 =?us-ascii?Q?Nbt4G1QdpMesPUTd6bbszhKr8Ul7t/vTm6PlsR+otDwkZ769NmEpT6oaux6Q?=
 =?us-ascii?Q?G36XKuQdmP3ljhf7ASA1jlhSoTrUVKl6zJ7cXcgTWnlsm6rCGAR9TDSYjQ5a?=
 =?us-ascii?Q?7K98yhXB2TPAa6JE+0Jfxh5eKc88lBRX4K9Lx3sFe1UmwhnoPw+4fok8k2DU?=
 =?us-ascii?Q?93iv0hZBrpVxpLpgvoUSWAUvXfzUsSxF+HOp+PNgBmXTAJRmw5nz51mknte9?=
 =?us-ascii?Q?uK7Ne4PLV9t8uZvM9FzMICOpmOmr/5fFJd5GMdrgg41qteogmwasTniCUlHl?=
 =?us-ascii?Q?Z/59QDlLx5x+Z2YsO6KPqsC/TW2BspAPMxSptwXH21+lvrN7mfHquCXVa4mJ?=
 =?us-ascii?Q?8XNmBLC4c8E4+n3JTUcSr+Y55Iu045F6pe/a0NhcAxXv6fCBp4+KHBs78wjB?=
 =?us-ascii?Q?CEIMGDPBFy60y7AbhkMNpbwf/612h6i6l1y8L+qe6N1FJTNIWm6oiPCXj/H9?=
 =?us-ascii?Q?BFnca4VUG9KkvTK/r6EZTYLKRFiQShd+Ej7c2nz1T+JF1dk0aryo6T8G9eM7?=
 =?us-ascii?Q?xl24Sxz3WhTddSluOS5L5tC6y4NEMlJiOJ7dm21+QQEGubTIwoIVwozQ/mxZ?=
 =?us-ascii?Q?W/nie9rEB63BMU+ZHpJny1vEGObTSAfVFsPzeOJRLrMGXF8GaCufu/KWN1U0?=
 =?us-ascii?Q?F2TyvX8QL8aso7e1gM97yMxg+8zVVF7cxwqv1OGolfKIuQSSPItkDoK1cYTq?=
 =?us-ascii?Q?ulFVClxejqPqMTc9fmFiUA/Oqp7rxxQcX8EB9CpKVEl5lperlsk7yMrJKyVO?=
 =?us-ascii?Q?9Toi+7+NdFv5RVqcIhuxw0vrvPtLrJ6jtt+d6lOzkfgnXkbKrskaQbCqBe28?=
 =?us-ascii?Q?pZNtbfOhklMvt48X3M/bu8/0TbHcq1dBJlOM3K8Et7Kiche+yIcqrmAJEtn9?=
 =?us-ascii?Q?Zz+42naOulkqq0gjFf7N4xG5z24iXqfm7OJCjSzOA7PLmzqoyoMwipzsLxda?=
 =?us-ascii?Q?Sb0o/PP67QjwQEbCcW/FAKRQxtq9XuFCzeRRQC8LnRdtXbMQJ9hq2kF+/Z+D?=
 =?us-ascii?Q?m3pP2WCsBTRvJ2HRqCN1AtzE5wV0ML8V5+K+6GXyeemewivFRyEbX2g+aSy+?=
 =?us-ascii?Q?gaDrBjWhXzk4idxk5aYrC320cS10+JHlkcHc0PRANSwiGHU2nE3HYsars//+?=
 =?us-ascii?Q?dv6PimrQpAY2J2MhaxXhRBrtbSAhC0nedSlGtbON2YS5ShEfGdebhZCjmyZ2?=
 =?us-ascii?Q?4fSVLeDRcoWDdWiJ1nhPoV2LKskCDT4QQWcqfU1dexhKDfd03yzfefICdBjp?=
 =?us-ascii?Q?UHN0f6ewEZ3aDdddcj4vZ1kyh8qfYS6w1bdBu8fTSICAt92DIA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba996a7-9645-4b55-149a-08d91c171c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 05:13:03.3392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhfAz4rgLbJWYWr6o4rs6rdbo9z+BKUrX8uZXLfeCztvMyabUbO3Tjt/a54Y0GZh6806PILMuIO2yEU5Ftuv5su1Eu5NLmYEh5HrN9lHQKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7255
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
