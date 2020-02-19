Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E5C34056
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0764206DB
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dmGfpdpt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vnKfOxTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBSRoc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:44:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:50112 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSRob (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 12:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582134272; x=1613670272;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LUnfOZixuZvo4Uw6YOMEvIGpnqioICXi5h+XrtHrr+M=;
  b=dmGfpdpt4cC9qrB7n8No+FN9rJ04shBRqu6QkSDSXjydCi4BpS8ZbA3k
   4whBv86pIx528Omj7wucfmG1VyPVzVx9VVfnrZyoIyifpt5df3C+8CE88
   OrmfJvGmEM9R9GeMZHiPfcb3bN43VH9NA8Zz1uLTrJuxqwzPiS6V6giz0
   lHhiDK2DWyjqbMc5ul/3gSwgxKwhKn1q8WVCZMIGuAzEKT8zqKd7PR0f7
   sEJX7ixSh3ETGMjX73ieHQjS86tNCokZ7XMH+mJd/X/PHALayzisZk3hj
   CPNchfSEdIkxenDTYXmYjcNaJzbcC6dcA9AO/BVHix9xp2ZvYXaTsoXNi
   g==;
IronPort-SDR: DirhfexE6NQms0IFBWHZ83KcIU366pEVXxgf9I+kjfk5n7d3XZk9D4vW2/11iXWdUlwhuHgc4L
 VcstoaqNm7y5nfxX05l5AOBjNX5IiQPLZc9hXZLARR4drTxbeo4wZSDNPFPwKLkFdSHUQfeKXY
 dtd/CcKOxtjirTSEuBK2HYsvCzjLcV82TF2fqhQQOJCCu2f5cIsP31ogJbgB7nArQvn0rbYUeV
 ktNM9SS69mcMRxCQUhYwHwCx1bFroUBgMXy0PuzEiQZv6QCexrcLxKvjWgLxXDZj4L4qPxvYXi
 Wbs=
X-IronPort-AV: E=Sophos;i="5.70,461,1574092800"; 
   d="scan'208";a="134568923"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2020 01:44:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItoVoWzalxEsuE8JKiWV18uvCZmPejHv8Nsx+pmiMvQesWcuQfYFwgzpQGoYY1PxlMPd9NM2PmMbaj+CsSvpY1McQKH6Tt7jhOJaA4QouDaLeCCVc7RrxovWChsn8j4Hh8qBesASMzQvBpdlpReE0rFddH9+wDtQQ28PC0twlBgWxBnN7IzhQkPeI6x2tJ6jXai/C3ER/KKOmS3f5sleDxPoe1hH7FPLPNEM1Sy8ogAQso8tS6NGh2LXs1kG0GvC2AfFtKfSdAGW7Sk5sBXPTwdVNkWs6N3R+hv+g82UIk1RBLboXH6hy2snRwxROQxxXU1ulXR8NoqoNOXWfa+vGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUnfOZixuZvo4Uw6YOMEvIGpnqioICXi5h+XrtHrr+M=;
 b=JCs/HmMIJShGh+ZKWRUjK4Lt0yuO1vIbHg8Az75hGI9TDD/Fsum5B0flF+mT7jn5NINETxVc4GCr6o6DIcF9X8lDc2Ho4VCyroOz+Pdh4ljxmLzO8CYewfhglqISWCDQA5KXg5RLWk3bHBzMfV7sC5elzUPYBaPHfxGYlWxliph7/Xh/2mPwfsqqTMtygclQ9nWSuW+6G5bKKZ5hspDlPBINp70y3NOvVgwd2a3fRec367IHq3JKJNyuXXhQqo24yzn1WFTxzni5O5ALtOlK4nj/aw9wlrJCzjXVnES0NwGCYdcfB4tfCJr2DAHIz4UydL2ws5pXtqXbIzsjS0KVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUnfOZixuZvo4Uw6YOMEvIGpnqioICXi5h+XrtHrr+M=;
 b=vnKfOxTgg0csOSgrHUZN5RaaYjJKpZb6boRmxfy+mK5yM+UijM/iv0ryliW4TCsYGoXfw6b8iACMlTX2HxfM3zmMq0dt4vzIGbryctiV3RWkXRoqcS/Bb5IBLS39KP5ba+3KlYXYqEH6x2G67yOIlthhtxENssYwE6nmu8A0eiQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5478.namprd04.prod.outlook.com (20.178.234.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 17:44:29 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 17:44:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Thread-Topic: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Thread-Index: AQHV5oDlsjqP0gJg0kWUTukh7pHHxQ==
Date:   Wed, 19 Feb 2020 17:44:29 +0000
Message-ID: <BYAPR04MB5749EB446FF18D5C52A1DE5986100@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
 <20200219162912.GC10644@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d08bfd5-d897-4fea-0451-08d7b5635ed8
x-ms-traffictypediagnostic: BYAPR04MB5478:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5478B7A303E38D1975791BD886100@BYAPR04MB5478.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(4326008)(186003)(7696005)(478600001)(558084003)(5660300002)(2906002)(26005)(71200400001)(316002)(54906003)(76116006)(66946007)(66476007)(64756008)(66446008)(55016002)(66556008)(53546011)(6506007)(86362001)(8936002)(81166006)(8676002)(81156014)(6916009)(9686003)(52536014)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5478;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kydnz7QQQwpfyZdDx9VGt93buHU5LdsDG63zt1oZ0Ma1eryrGNGBlvjbSYl0WmELWkAm0tSOgRQKR5hJdrARAiUQZYv1gH6GQHgrDVRh5XFxyXpyaJjk7R3aBYUZxAStAIyGwR1HuO1KMAquP8hYHYXtaPKDBVdp9ta1xm3jPkF58PXaHc0z4M4tCEtjU9nUryuYRMzcHRNEDh8UHpxugZRbAWzAkMO7F7ga68jvgjaEE2G+1+OoC4lJiOlLb62o7MzpfY5AUz/6tgaCRTsmTo+E3Lzi/8dG5WvDZV3wZJg6nRmekq05nvXlyHeUQVGmmzm5adqY0bJw4I3lmow11wvBZajc/dGyu+eLdjqUsBQ80oeczu2u487vxa0WeCE6lgGHt/JO9uuOPI/iL92g/VnxVgFDIRQFvAm+joxFJj5QkVQvWFWQJgXuA5yLynfw
x-ms-exchange-antispam-messagedata: E6hQLRN0Vhz1tQCQrmtP98D253zvEpDV+YR6i5px1K8YSl30PUWh7yqGlvCrswTn3fE05hWmB0kyFaDzFtOwslJp51hTDjfzaoI1uiCZox4NwKTagdttMAorxaTqyfgX1eKlI1HoFBt1RE1EXwioog==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d08bfd5-d897-4fea-0451-08d7b5635ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 17:44:29.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8eIfEGQgEF7+BMuZjV8u6SZGhmSkITSm7P4ziJmRaozCfxXyqbBHJQF0qU8DDmgEnbbLX2xKsZCasdqrNhL2Rw+vuv6MW/N27x+Z7Q63M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5478
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/19/2020 08:29 AM, Christoph Hellwig wrote:=0A=
> s/tracnepoints/tracepoints/ ?=0A=
>=0A=
=0A=
Thanks will fix in next version.=0A=
