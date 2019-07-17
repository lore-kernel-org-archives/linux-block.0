Return-Path: <SRS0=ez2/=VO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC439C7618F
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B66921743
	for <linux-block@archiver.kernel.org>; Wed, 17 Jul 2019 01:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aGLyr75n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Cc8xplPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfGQBY1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 21:24:27 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21280 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfGQBY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 21:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563326666; x=1594862666;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CY3BX9imfMUf0lyDanzjYtN4ZtfZL4soa0VdxTFivE0=;
  b=aGLyr75nuDDh2kdnCX6OWBWuztcx+ljMsi19iKntLNdLL+l5qIXadj3N
   PM6ndeK47LjvkNB6hDvCXOC+yviyEO0ZpDD6U/npUobUyf19xE0bMSkAG
   jjr711HmsqSDfxiUgZbsCzq/dxw2rGC9rlP3bxE7OEuXm6bKXcHKmZZHr
   sJYOKblHm9w/fXBx5BYUji0gw/a5+0zlQUqHUIjifoWic6ah6ATMhfrmh
   MmhvQdZIHaD450fLh6DESUprijDg5hRD3TsnOuZ7RuZC3L5UJZZQ5Ig03
   cDTCi6atQfc7PTBJGoWxBf2AfbyQtMH4AKy46WxV8q5D33rIqpvNtCYbF
   w==;
IronPort-SDR: asgJlip/6JU8PLckCZSXn+0a0W3WOASPBoYPsYgt3MIILYnkUl2S1qSXqNkxJyDM/gE+Wyrsbe
 FbvNlnkwCpdvnCYB7FqIewaes8L+05ZHp/M2iLdhnrBA5KMKjDuwEHIyQhIMaN1kdyjRA/OZ0H
 Ps6P7zAH3SkvFoo6aH0aFL68ANEVxIUUY8BwMg/NbRsNxRjsA2TOmepiJqxGF+ag2+1NbwLtM7
 +h40+vItU2s7alamWog5n3kCLwSHaIJ7X76c/EQ+zPKnzim5ZhtcgGaUEHS+WmJk8dbvzEyqwZ
 qww=
X-IronPort-AV: E=Sophos;i="5.64,272,1559491200"; 
   d="scan'208";a="114837395"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2019 09:24:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG3YMh1nH4bhMaVh1OLEL0+fD/ICBj/XduurTQmUXPePk66u32kDmfNRst351ASfAyxCFYnfiLdQV3X5CwOm3YFG3ibe8poB2Byc1szA6FQ8+uGQLJyntvJBgbkJwOB1qV1+SAmRnGZ7se4Lil92TitlvS6QD5P49nAODlE0oU2NIi09t+JSks0HeDa6vZ4Ir/Uv8ytrNFGxmzCgazaroUW8B/3zplANUQwYuBaWmG+5gRB7zwVlS4KGElb2KSse9lu9itqk3LBbu8Dx1pTe5uCmqc9e01zHxhGJzPstmCbplpug2BFbz2Up3ZxaSY1+K7Nd6SgIySRtapezV/ijNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3BX9imfMUf0lyDanzjYtN4ZtfZL4soa0VdxTFivE0=;
 b=YxV6EcjgqsC2YmF7vQk2fw+t+BX/epi9fvj0qzJ2TflpoqodVziWrwb4h82l/6RqCp6DqoRsRDsuXlubxHZWUYM7xYIj3Bvdyz279BhI+b2IC0b6XoG9TiA7VDKfcDJCH9TdO9h/HglYr55plwf7QPmixkqp5aY6B/HyDrlHiYr9EVKOubOKHoxtpML8jp74n9IgZjTWdDl3PYoavlU1AirXjdZMtWb2kQ+um7+AaYs7zIbddYSsc+4WWHa5nsrElvxvEyWHBwF4QmtQs66SM4uvZmv57cvC9BgZqFO/rkeySpERjjLs/P+vyZRJauHZF/+IfAWj3lyim7U9FI3IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3BX9imfMUf0lyDanzjYtN4ZtfZL4soa0VdxTFivE0=;
 b=Cc8xplPv8O2VygdXf+TTZGvLa70hF0pscckR3OZU0dwY+U8TB+5fkYfbJXPO6GFUri/7f4txxuqr80Inu+Ms8hd1MyOHdFa3leJgMXIgveQKR/B/3y4VUoNJHTLEMQDWj87JUSctvm8mCensEeNKB11v0+V6f7AIL/b6x1biONk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5543.namprd04.prod.outlook.com (20.178.232.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 17 Jul 2019 01:24:21 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Wed, 17 Jul 2019
 01:24:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: sd_zbc: Fix compilation warning
Thread-Topic: [PATCH] scsi: sd_zbc: Fix compilation warning
Thread-Index: AQHVOs+P+Tfa/uppTEilmGdbienjrA==
Date:   Wed, 17 Jul 2019 01:24:21 +0000
Message-ID: <BYAPR04MB5816AD75A6D989A8BA0B06D5E7C90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190715053833.5973-1-damien.lemoal@wdc.com>
 <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk> <yq1ftn6121c.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f12a274-a150-49af-81f4-08d70a557f3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5543;
x-ms-traffictypediagnostic: BYAPR04MB5543:
x-microsoft-antispam-prvs: <BYAPR04MB55431FC1E07538FFE9A4B147E7C90@BYAPR04MB5543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:221;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(6506007)(53546011)(4326008)(91956017)(5660300002)(76116006)(66946007)(66446008)(66476007)(66556008)(64756008)(3846002)(55016002)(6436002)(9686003)(26005)(476003)(53936002)(6246003)(186003)(6116002)(86362001)(25786009)(52536014)(256004)(14454004)(102836004)(316002)(2906002)(229853002)(76176011)(7696005)(54906003)(110136005)(71190400001)(71200400001)(4744005)(486006)(74316002)(7736002)(305945005)(446003)(66066001)(8676002)(8936002)(81156014)(81166006)(33656002)(478600001)(99286004)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5543;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YGM6OdZjSlLcExdZAjTa1kEQdoVPuCwokYK1hKqnd19M7xBI8L4SJKsRCuXezpFv0P1Iq3qTZC/t7lUf5R9vhXqFCbmWly0bSoMqZWQE7Ri/qOGId3tfeufcM/1a2dmue7G/IZt+hErVioCGiBgnw4nuzw4owhRu4Y82GVWlCcV0SbQrRawivmWhBVUOjzlgF2TTYvNtiqaxDXhUBG0H594Rb1+CpEk2Gna/fm304VWP7t6hDM4DiJQedMIAITACYB0xRTQHXn4011aVFNgCG4FCUCi7O4jm8V6bnnzT52p7MRvAkXN6zZXHnV8aIvyrcd6Dve+F2tA8sNjzrqPr5MHUfmy9W3xwJDlnCKWpa/UpUUu5mdntjaAXl87mseA7cVicB+zA7jlO8wC0F/ySLeDNPp9BunU1TdILR5Up3y4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f12a274-a150-49af-81f4-08d70a557f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 01:24:21.7015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5543
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/16 23:34, Martin K. Petersen wrote:=0A=
> =0A=
> Jens,=0A=
> =0A=
>> Otherwise obviously looks fine to me. Martin, do you want to pick this=
=0A=
>> one up?=0A=
> =0A=
> Yep, I'll merge it.=0A=
> =0A=
=0A=
Martin,=0A=
=0A=
Do you want me to send a new version with updated commit message and Fixes =
tag ?=0A=
Or will you fix that when applying ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
