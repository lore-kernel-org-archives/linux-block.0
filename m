Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51932C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371A760527
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 08:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhIOIwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:52:35 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:35927 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhIOIwe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 04:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631695876; x=1663231876;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SdUeCpDQc6FAJYysS5PIBWLv91bY7EWYTTCaVPh4VLs=;
  b=c5jlDAKVCqvVjrFgkj7W8JqT3Gi95+MPMsF5fMIXR1XzaRsNe9a/VExx
   USxlXLiUZKqWyNuUZ09F+Vw51vqKmn83RhlFR+fxceaZh/8tDa1hHOSvh
   aB+WbLwWoO+BlsTLfUWr6ESCHo+q6ebhAcFMrgkOJ2YQwqVOHvpYhtb4b
   21hc3wODUd6Gl1wA6bJfqA84mCt2gVlj0STIxqI26OToCKP7/wZ/GDwgI
   UC4iizdYdlfZac/dImnuMyvmhi96C9fh7IBx77gmDjnoFarbqMCuLgNoQ
   yEcNZExzM+S6TmiK6+moeAL0fVIymOngpO1GaWhfDCUP2deQ5QWSjC4S/
   g==;
X-IronPort-AV: E=Sophos;i="5.85,294,1624291200"; 
   d="scan'208";a="179130852"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 16:51:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjuGUE/ZEAlPCZpXt3ICnFdWkwYgKea65Ds1/oxNcdKCCLjYafpCqvr89TrTPyHFHsWagMpiXCZi55oWG1qIgaARmU/oFIIzxg6Tmu7NIpApzRZXaFZqYY1ldwJNxDQpMBLKTfhuhaPCmSGtjnFSLFr0y9elJeaFBYbZ1xxQq4KIWvbWLSUa63EBzmioQchHVqlLGTa7TksTpIS85b6ftAZglPJlXbkykJA+Pmg5MwPHKmokt4tG7EjDdBO1tsYsCGIuy61VmUgT3Tz8CB4u3hq9C83+2Uzu4NatXu8Nzx/XDe3NteMGRgaMbStu9q2yXKkLcY/D/Ck50+b07EOqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CI4h5GIy0qOydy6galk3YlLOAc4a0B2BG8zDWghHOVQ=;
 b=P611bcwS5OxBsaTlipV24N3MeH+f1mrs6BuSbLsVwxhcKi7tUhlxmxrfxf9+O94FoQI6K01LbQOJ7snenJp8S2Qs8Gz1jDsekFSLGqJcg5dMuHs3m0CpLUW90LjpBl7vzH5vfKwpayWqcjxlS+v6B9M6tUsxYtOr8DNfFK92H2p63AyFV/lCymol8NChXgQ+9ZzOSt/osLZt3ppMWn3FrKpi6Isff9Rmw0bsxomDWQA4yi9bVrwelTUBMeWZYsC84xzY2GJ5XU6kO+1maDspii4iVX/gEdSp7S+HQme1c+Nk5+VHrEs677sDxgwjO4b3HlkP1EPeKT/eFMTGXb1ZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI4h5GIy0qOydy6galk3YlLOAc4a0B2BG8zDWghHOVQ=;
 b=d8ouG41vLaq6aq7dqkNp2MbAln1uaW3cXKbFRajt0h6pbUAUNyum1KYJbfl9Y7VvAnNKqpxqXjNthRfMazJdPw9j3+25JfbEkrBXRSiwufk/dyyRW5Fpp183dbBLcd6Fxv3ceYh7I4/ggmTyqCbW5LyDPxbB1OhYj+Pzy+EMJ1I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7414.namprd04.prod.outlook.com (2603:10b6:510:8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 08:51:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 08:51:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Topic: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Index: AQHXqfzmZ6ph4/R0Z0OWrv7q3tt6Tw==
Date:   Wed, 15 Sep 2021 08:51:12 +0000
Message-ID: <PH0PR04MB7416076F1368EC2978DF239C9BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-2-hch@lst.de>
 <PH0PR04MB74162E70080738578747F6439BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210915084918.GA25090@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a73536c-e6fa-4445-4a9b-08d97825f8a5
x-ms-traffictypediagnostic: PH0PR04MB7414:
x-microsoft-antispam-prvs: <PH0PR04MB741470267F5663B187DA19409BDB9@PH0PR04MB7414.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: luZ6r/XZJtDELHJP2bUFAySKZv9gPorcwpjvORzT48ppqosjTAp47BE2hWkHRqz5v8MQM7Jm0sPMQGo6CdbxOCrTZukDKuqC8ogCTf4mUGjMFkQJ2eFY7tQ0Ga5v16S3ed/MXmkY8Nq2HPP61ZnqDjHdjzNfBJArjBSQO63sFw2jiwsKVauHslQdb+kkjrmfxRx3SDsBvvgvOzmDt3vej1tjtDGBgdRELXoJ375ear+dfXFQDG6AdmL7BMRRtNOZfUOBZRApDJMijDCBjWRNwNtArNdxVi3pZQGMPC7oz0a158hBD9mG/hQHhbfDgCNycjTk6io7nWsDiX13q3oaMtBTQ+xVutib09lUnoENfWFGREmCUPX8nG55WroKa9+Mzid5uJfAmgZVl5HTndHXrpZCSU/nktbrhLGY4fYqmeKuwRvsEfdEyagsav1sUbYZrlD6XXskwZTviZoIq72ioz5W1ZdgtJRTgNGcMdVnEr8L2p+3WiToNAxDXzN/Cwzre2hcOP1hql1t5fjkEwTscKUiYayBLsxXPQgmk3fNSsKwHOaW0KL9Rh+MEyAyOTh+45INIbHMkV3++dQJIHdfEjKEqwQHy7A3amMieXwjAHyXrXqCMLI67C9DMnYnN6yLGPhh1ruw1ieomRRc3Jiw5NDra5AAaL/tpl81yGD6hhFnTmMY7zd9hC21WV8TBlDji9WA5UHLJgAVwOH6eXvM5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(7696005)(66476007)(6506007)(64756008)(186003)(52536014)(2906002)(33656002)(55016002)(54906003)(508600001)(316002)(122000001)(8936002)(9686003)(38100700002)(83380400001)(5660300002)(53546011)(4744005)(66946007)(66446008)(6916009)(86362001)(8676002)(38070700005)(71200400001)(66556008)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gv8AqKMNJIOhL7TRXNyovYHmOhiIq8syUV27D9d+cWadSxxBfmQu5R1oYo0v?=
 =?us-ascii?Q?+8usFNa9EbcWQTdqxTj72AiVbNjIgcRpS3NV+WcJ+dk9irvzjY8IYe037YCo?=
 =?us-ascii?Q?pDF39ZWhl9rMg1VIBEvJ/s1gnmrLRkhszRdx3DnAD4HcfheZcDHDh9+rJtlQ?=
 =?us-ascii?Q?rZZKDfZU0IHiHfHXmZvXirO4NhDq6zMgIQBByV3Ak8p7kRK5ONaDKcs17rsd?=
 =?us-ascii?Q?mkKMPuWuCuzy/9Rf7ybuU28lk8M+9cgEaEq/ekFpLFR8hh/OeKWHBvaNzQCt?=
 =?us-ascii?Q?QjqJJBcEFoY5mSbZKujG5pLJgWP0dCCwqUQEMTxcOySU/VyHA+QsGF+xa/NR?=
 =?us-ascii?Q?4SSype5a5yqC0/7aaC0/E9Pz3yZlJ+TuMIT31ZrOqLX4l73k5l4EMqK/LsAv?=
 =?us-ascii?Q?I/X4a4uKgg3obnC+9wSAJxGAAQ25WCM+g5HomndXlx3R1NZqJMTVMavHrI8T?=
 =?us-ascii?Q?sqPOkrQLUzdqRPbEYdAntHqjbistBso23gicILlgI3LTjHPZ2ou+uTyUvYKf?=
 =?us-ascii?Q?0xi3mYwpyV/8kXXiyMCwri9VGl/lBdTjqiS8rxJKu/00doivCe8WByJT4y/f?=
 =?us-ascii?Q?1LAIZvBVgSBYW7sYZbTmS76z6Ps/+AzMuowFQkPE7/ai+8EkNd4dqFVIPxVQ?=
 =?us-ascii?Q?NjBVUfc4Z/c9lVtvAYDwiWDbIv0kSzM6QgzThIoGFvw6KjAiAZe30tazyzlE?=
 =?us-ascii?Q?J9tcfxCGBqSegUYguJiAAYLPA0r8zZqpPbrfLKN0JDOUYtTi/S5lCseBFXpB?=
 =?us-ascii?Q?xABZxg7XsjWDj8Tn1rOHDw2hz56VgGhGdF5Idi8U/LBcXhFMF7EHyYpu+8fj?=
 =?us-ascii?Q?T+rZvLW7a3Y9ScbQz+F7Fu6JiWcsQ9+NhYPU03Rqtr0NU0jsqzVNHek7VL4M?=
 =?us-ascii?Q?X76mwlPXYImFXFdF7S+1MkBxXQSzK8PtSApqHQ09+/5Kw82koD006pYm9ExU?=
 =?us-ascii?Q?4twsHFQs8kvjmCVEV383PK5KhVHnJy8XY98zSP1mc6bujXvJ8EDbc/F8jbIl?=
 =?us-ascii?Q?HJLpGZYQnWV3wPy9GaDfqmYE8yQDjiXekYPCRZmBnje4ex5c5F0rGAkVfYAe?=
 =?us-ascii?Q?RSdXE0dXU1ewsitpfMdjLZ/nBWAg2DO/4VyX9Dn+7zYcWTY3oRz7n84Cly4I?=
 =?us-ascii?Q?d9sc4qpqB+MrlPUVTsvTTbyPGAAkPa9d6+gH5QvzDNr3x1mQV8i1bOSftmtJ?=
 =?us-ascii?Q?oYIrlC43aOIzHMAjFGAk/35GO8jq6A9dlllog3LXalFvuRerBlbgvuH8opDU?=
 =?us-ascii?Q?JWl7LJdnjwdva7uVNUbsTVbEj3cGs9hOZMY6E7HQSNVssb/EuKtb7XQGf/JO?=
 =?us-ascii?Q?FmZa5nb1cG9pOovBjauc3hOKQkd61Ry8uCPFSXbv9FswY7zRCmgHbcJLf/zl?=
 =?us-ascii?Q?9ZAyUVPs4vStHj7tMs94EYGiIp48xMOtVM0FwRwsQnImAYY4gg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a73536c-e6fa-4445-4a9b-08d97825f8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 08:51:12.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6I3IgkC6e21ww7vE3RNGvG4YY3J67PIwncJdNytBNg0kuO0D06tVC67juKoDZgNFJJd/YlrQ/NjNjffkUU7HnTPew+6V05IUjU4K7ZALEIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7414
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/09/2021 10:49, Christoph Hellwig wrote:=0A=
> =0A=
> .. but they aren't.  All these headers indirectl pulled these headers=0A=
> in before and now don't.=0A=
> =0A=
> random32.c pulls in writeback.h through trace/events/random.h, which=0A=
> pulls in blk-cgroup.h, which pull in blkdev.h, which pulls in slab.h=0A=
> through some other weird twist of fate.=0A=
> =0A=
> The drm code also somehow manages to pull in writeback.h=0A=
> =0A=
=0A=
Sh*t didn't notice that. But this doesn't sound healthy.=0A=
