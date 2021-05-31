Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7921C47080
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 23:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F86128A
	for <linux-block@archiver.kernel.org>; Mon, 31 May 2021 23:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEaXgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 May 2021 19:36:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21405 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhEaXgI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 19:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622504068; x=1654040068;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OVTSTmDkU/7SNnJ46FpOGqBs8hJHhQDdJjbHTILA4L0=;
  b=IVfbYHsmmjTUIw5jwXMEuxsuQlXWLsb7uZhY2ZBRQWdY2EPM/IPTUMDU
   2TdIm7fJJBANPsQcO/8kttX0o4v/0zxrA7nZg04mUy8NGjXqFIC7M9140
   njwZkGOUoL/+RrODUx7/HT/Iu8OorFpGHNG7JoFcrSFrBQXNfGC01LHfD
   iFSOEKvRfH/SxSJhf3hbE58e6hDTBNgjtJgJ2rupKRzzYB4/ZzOD01TJG
   EyEEeocLap8WNbjc7E5URzRqRQWVt8l0dcRJqd75sNRriKZDMKzTI7le4
   3TVsdkE7wYvbURKDiELfUzKf/1KrCnxc+uKL0/jwNGh5VDSee1LQrsA7h
   w==;
IronPort-SDR: DcKWjgsDfc1fkuQ7EFmvDSQUTPeIOZZ9EC4yuApFz17GVs2zETl5FZn23fp79WR+saME0jJzFy
 fk96uXIPeNTYmfaaSk40SnARzAPsKLqXdl17obhnLEYEEW94tF5Nvbh1bmt7MnXvr8znohFuZq
 j+aH9WynbPUyQhjT95C9XEMcX2elcFJWF8Tx9oohDMuLhpwkx+i5eUMkjjHEX+sslMf4DX3j/1
 XbbT7UQWmrJqbDtlbYkhWGJyC7UwRww8fxIZqY1vctmi9pcInFAi4cEAh1phxi5ImfThlbkU5x
 +Fk=
X-IronPort-AV: E=Sophos;i="5.83,238,1616428800"; 
   d="scan'208";a="169485967"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2021 07:34:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpJin0oVnMSvW+iM2OjOqWOsob0LMMaHXXtN6hWvcMHIqRg05kAPUk84j7RCyQav2W8BZ80RJBGGw1wREha+OyDSS67H+j4Fwi51rbX6mHrKWNkdvnompuTkRFJ4xmiB/5obWNMj3gmlwHEtzj6uX3GBiFZc3mNQskLT9JWPXGw0EnUYD7ENf2nltD2KsKYsYRzbnwnGHuV44vWOyn8GGKD0WeBseBM+Qs3bqNRouGtK+B13vxdRh0tydBYnNTda9r6H29PCzsdfI83E4F6YMKMw3LUZlXlBJH3r6KInydww1Bo+dx4qnGnLTg44ZPjVaMMnfzuOD68Qr5AaYCrTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf65XISzcfbrd5COD+TrHi+IT5aY96vPBFTprytS6Dw=;
 b=B/JmkBzI2FHUdlnrWfl049Bq06psTBDtLafY0OJKZhIuppKsaTsfdHUziDm6blc1rlSqZabhVsOJ2O7iZsuEco79BVlnjQ6BC18jkgXDE26TWe/Z4C4aVp1bZzGfTBAFsvM/9oUCxXrG64lJH9PrYo+R/ZVja/iFPR9eAfCKSLZM8LgvVewYLWXBcxQ1u/OZKKHKgqbiyoV2d5VtRphEZoWgbczTNvzffmsFG0p0YlfqtDgiST0ShIbf3uVn240/XYKxNHxHu0XbLE65GpPtb8il6FKPyS75j313iuy1HgblDkx3YBqDabJBZ4SxOCPKhkH/Y5oprHHaObbcp84aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cf65XISzcfbrd5COD+TrHi+IT5aY96vPBFTprytS6Dw=;
 b=NNpNKilJPRgMZ/jk02XwrNCE2nKDlh1zWo1mtS1/MHFtMfSWqiZ0Zvgu7hnNsk6JMXN+7RHAmXiGXnkgmw6CoW9HXsVDpIcR9CLJ3ryIQQU++ENxFkOd06MvuU4C+cNlpMjRSGNlQYGIzV+Hfo1XW0oExZUxhXTDZpfapzQAJq0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0445.namprd04.prod.outlook.com (2603:10b6:3:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 23:34:26 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 23:34:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Topic: [PATCH 0/2] allow blk-zoned ioctls without CAP_SYS_ADMIN
Thread-Index: AQHXViSGVuv+G1Vef0ak0MjWhCwkYQ==
Date:   Mon, 31 May 2021 23:34:25 +0000
Message-ID: <DM6PR04MB7081E0E317E9E89F2F4D9051E73F9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210531135444.122018-1-Niklas.Cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:cde7:74cb:ccb5:ae42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c9b9616-259e-48fb-383d-08d9248ca0c5
x-ms-traffictypediagnostic: DM5PR04MB0445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0445E749F0FF51F3DC2AC982E73F9@DM5PR04MB0445.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pA6t+X3KRnsJuM91lzz1lAFjaqMSG0mtoSx51lUF4eGVl2kZ0iwdgc7dsMW0+CoojK7x/iLWNhHlSV68SSCeGBJL4C/jya1glON4feXRKGzjw+nR4KTyxCHy/dITo8ArINldnKLnQP6cYVXchGUw1pzlqxX32uwfZspUd5bQjrKH6GMEZHsbETzIGDhD4urJtC4JnOx0jR2d7l2jd/LLzJBp1tERWVdbh9RRcRHEwhxNWFIKVhrYu72AmlaHN569b/HObfxwjn9cGnNfXbSfyFazCojxaVzqz0BPIx9prJJUR+Ll7XipQWrJVPJ9Ti69r4IRt4O4VO1ElJX43Z+kMw/vYk7tfR/ipTpPX6ho7T9t3X7w9gapQNsyyfBGfM8DhDu0YZ+rVOaHPbRq/iDnB+dbkma3+n9+9jnEXRP54jvEp50Il/MmoKhqpJDzoyct4JiejhLkC0v7v65JOSuEENeqtkU2GzezvWOaW1PvlCZHC3CFMsqEInqWI7l4aOBZ7G+NgYtlvXHhtyYI1FMdirwCoZbQK664OZJIbq4K1fY3lTNcYBnODZrqPpaA9+zT05Fu3c0R05XA3mVBXroFklJ9tV8HJl+PZsdj5r8l++o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(86362001)(83380400001)(186003)(33656002)(9686003)(71200400001)(8676002)(52536014)(53546011)(5660300002)(6506007)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(4326008)(91956017)(110136005)(4744005)(122000001)(55016002)(316002)(38100700002)(7696005)(478600001)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Jh67hbpHEesIO/n99+fAuT8dZnpC2jWX8J/wgM1DgISzPq3JnjczVEXoeF0S?=
 =?us-ascii?Q?n21sFRCTlq5/oFYQozjBmdKcXRfES1JFDld9wuvIyMk970/zEtZqrbdBkbzn?=
 =?us-ascii?Q?81x4aVM1fJNBK8bSacmDDunfBhVqVdKbcmY24IGzxy7qT3w9QM4U42MfR2lg?=
 =?us-ascii?Q?EgR+iYDyL6ieSsAXSJJ+tXX5NE/i4yTgeqqdwr8oL8GaxRnLTXiKo/sbW5YT?=
 =?us-ascii?Q?129MTsq/+Tr/Z6WpQtLDbf99WRBIsiRZlCqhxs82z/Zo6SKHg4Eq92ZQXCsd?=
 =?us-ascii?Q?eYc4aQBZ63tv9YjEXW8VHjAFH/p6Z+3mJlmm12gXyA+wQhwnSRBxqbVmyEva?=
 =?us-ascii?Q?vBWJ5iGxNAgHSBQti9W/DocYG6D98KacB/qFiJePV0jLTEGvw2xEleGZyqam?=
 =?us-ascii?Q?055Gu/CMLrLM+5xBClv21IMFI9peZa4+AzKcpUGqIZI4XY2ZmN6iP+BoHE9j?=
 =?us-ascii?Q?gy8UdXY337WowMR0p3maHE2Uy12keJwoJz7LMVq4tEBlFuKh15ehbnSIj+XP?=
 =?us-ascii?Q?LI+WJeGt7dsrEfS4wZoClt1hE6VS7ICMHYojqnet22GNPmTyZRRprTACbsp2?=
 =?us-ascii?Q?Wysif9Sn5wAfZIOf+hr/eDMUUIDpHe10x8HjJ8bqxBCq6wCPiadAlnlazp68?=
 =?us-ascii?Q?jMDu1qPgwuPVfUjaXD9e1VuddX0lGV93vOmjn4Y5Vy5pQ3iCRtHaISHpNF52?=
 =?us-ascii?Q?ML0d+qS0EEsUQjl/woH6Vqo179M+xypGm5TosLfG7ydeNTxwDy5ryZmixIPF?=
 =?us-ascii?Q?f5jvdzo72Jn8y/qsTVwlNEcKcs8K8Fq6ch040TWRNK9oxCV9CmJxmPit/JYx?=
 =?us-ascii?Q?vrC5eolGKktkNjG/6VPE5s+RABKrWXnVXYqeQMdE6zdLLzb9vb/bJiYtlsyF?=
 =?us-ascii?Q?js4IkTn83kTjAqKMFqqcSe0tDx2ydFVv8R0htftQmQH8jHJL2ffW4FG45/7k?=
 =?us-ascii?Q?xiaikB1+HXY94uzOEqWJ7GL45XpMQ0fXZKUcauByDYbqNseN8qQ3c1PqaYdA?=
 =?us-ascii?Q?2MmBzgtnNz9jqdhapr8j+u8jt/6Zy5mbu8hNYPAgLUz9SE0AUy64zwL1OdJA?=
 =?us-ascii?Q?VuGeLgUXkAEWCfXJVgmIyQnpfLtqe6E1O7ZkPuAuAwKPBA4TSxgARgkwd67e?=
 =?us-ascii?Q?/S32KaN5JikeAkCMHohojK2nnNM4URwSHGbp+DMxmN+cp2nuR7JXE7BTkOYa?=
 =?us-ascii?Q?fl5qe+lalWIKWZsep2R1+AGs3sq24IS25uddCftcXGoFdGVonoH1ILEMrrAI?=
 =?us-ascii?Q?hUcNwJtCc5zBA1NPvGkmexkwU7PZ1muqWuXVO5re/qZs9zHC3vKgbFm3yS1s?=
 =?us-ascii?Q?86sZSA+QKxcO4uWI/iZLFzBXUxhLBTYwv3HrI8gyVOOyrlo9TLVrURGYOG4J?=
 =?us-ascii?Q?E+a40lvNLik5FCaKN/5PcgrhA+tRfGPJa44qPjPnURkHaWU1xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9b9616-259e-48fb-383d-08d9248ca0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 23:34:25.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6IA8EewUOh5EJIfQtvm1kjtUlzCryzDb8ADB1CZwOmi2EFoR2f4o25CcPrSp3WkOg0Eplld68R3gZnjCz1oXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0445
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/31 22:54, Niklas Cassel wrote:=0A=
> From: Niklas Cassel <niklas.cassel@wdc.com>=0A=
> =0A=
> Allow the following blk-zoned ioctls: BLKREPORTZONE, BLKRESETZONE,=0A=
> BLKOPENZONE, BLKCLOSEZONE, and BLKFINISHZONE to be performed without=0A=
> CAP_SYS_ADMIN.=0A=
> =0A=
> These ioctls instead only requires that the corresponding R/W access=0A=
> control flag to be successfully set on the opened file descriptor.=0A=
> =0A=
> (open()/openat() will fail with -EPERM if you try to open a file with=0A=
> flags that you lack permission for.)=0A=
> =0A=
> Niklas Cassel (2):=0A=
>   blk-zoned: allow zone management send operations without CAP_SYS_ADMIN=
=0A=
>   blk-zoned: allow BLKREPORTZONE without CAP_SYS_ADMIN=0A=
> =0A=
>  block/blk-zoned.c | 7 ++-----=0A=
>  1 file changed, 2 insertions(+), 5 deletions(-)=0A=
> =0A=
=0A=
Looks good to me. For the series:=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
Note that it may be good to have a Fixes & Cc:stable tag for both patches, =
no ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
