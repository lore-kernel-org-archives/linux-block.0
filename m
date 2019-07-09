Return-Path: <SRS0=ruTu=VG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0944C73C50
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD18214AF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jul 2019 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KK7RtNgb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tIUr2wp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfGIOeM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Jul 2019 10:34:12 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54647 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfGIOeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 10:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562682891; x=1594218891;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gRUOvCgOaDEhRQe0VzaXzoMQhm1lXFIgtwzw4S0P42o=;
  b=KK7RtNgb90go3z+fbszpxGlJKLLEat1fCuIByGbCjfIvI/8MAgZk4fGg
   uOgC9GhzbgBzXzOO3L95I7TzDxWTZaS7FWffLrBR+inzDllIUWihjYK7K
   UnQJNh+K7whTU54t7hDyojo+jYLFeJ7NSvDLG9xmZbZmFp9RsL2RRxPZR
   Qc/WI9kvmtJRvlbtFKD2JbdLsMYX/cfMCRZRBIYTaqDbAJupZo1zT+d/Y
   jBtLGlbANUuI4PWDr6pJznjrx+BQjndGAR4H38voHXRAAvh0xCbp5nKPE
   XQLFAD/lJt3h1qBHbIKaY11tIKPsNCbcTyMXslnuJJjL8a+YdHLaFRxKu
   w==;
IronPort-SDR: 9GcUo+Zsxy3yAbXMFl9WXglfYUkoNlXmI5OCyAMUyWHmnLY6VEoJMtM8S4EzhGdQ0yf++BM63T
 dH2jt0ihvGjJNFj4Y9Jl85Bkv6zRbquzUMkTWAnBNvSvyeyHgeYncXNd6lg/KmTxMXOy/3zLyi
 3BjBJxwpgwFB/pS7CVbS03VmQD+aSP7EQdd4byCh+pLTpCf5Cb7WSQqNghJrFsDbI/d33Ha6uL
 0DA4UOzt5YPBOHfhcZ4PJgNrTzAUJWSIlAkz7cpVgx4wHNYdx6F8Nz4GhhECpE4cf1FxFagYf9
 BRI=
X-IronPort-AV: E=Sophos;i="5.63,470,1557158400"; 
   d="scan'208";a="212449690"
Received: from mail-co1nam05lp2054.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.54])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 22:34:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRUOvCgOaDEhRQe0VzaXzoMQhm1lXFIgtwzw4S0P42o=;
 b=tIUr2wp4O7kzIV0nc8gFpH6iJz1Ge9/iL59OFAUFsieIPAUgCTSVMHtojZaDOzE5l6NHqLg/Lp5HKT5ypkXvQmI0rVl8zvkpI2tuPXtsshxd5FGF6OyHn4D+hec7vRvsYMVkx9wDSF7sxuJm4uyYnqGWUtYfUpOSxnA/Ykh/GFA=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4856.namprd04.prod.outlook.com (52.135.232.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Tue, 9 Jul 2019 14:34:09 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Tue, 9 Jul 2019
 14:34:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix potential overflow in blk_report_zones()
Thread-Topic: [PATCH] block: Fix potential overflow in blk_report_zones()
Thread-Index: AQHVNit1xM7Ns0jjH02QaGIZM/dwgw==
Date:   Tue, 9 Jul 2019 14:34:09 +0000
Message-ID: <BYAPR04MB58163DD32571C15990B94CBAE7F10@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190709075348.24823-1-damien.lemoal@wdc.com>
 <20190709133734.GB2201@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6e0857-e7ae-4a12-292a-08d7047a811d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4856;
x-ms-traffictypediagnostic: BYAPR04MB4856:
x-microsoft-antispam-prvs: <BYAPR04MB4856283C8E11B0D53DD43F32E7F10@BYAPR04MB4856.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(8676002)(476003)(486006)(446003)(76176011)(81156014)(53546011)(9686003)(4744005)(25786009)(68736007)(8936002)(81166006)(55016002)(6246003)(2906002)(7696005)(26005)(66066001)(4326008)(54906003)(478600001)(316002)(102836004)(186003)(6506007)(99286004)(72206003)(74316002)(53936002)(91956017)(76116006)(66946007)(229853002)(73956011)(86362001)(14454004)(256004)(14444005)(66476007)(66556008)(66446008)(64756008)(52536014)(6436002)(6116002)(3846002)(5660300002)(71200400001)(71190400001)(33656002)(305945005)(7736002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4856;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Biv4Z3UU7+KyvQVTsxtGA7Xyt3OrzJQGSra1MS/b/Okt6LuKicZBI4NoEYhT+APdHeC8tUibR6rLtepWnH18PgcpOjQuAHpcTrYGmPASI2PQzUZgoG8+iL1SPtQITVJ6IzQQKbw2R8tXj++tRWdlsAvOfYDcZLi1zZP8Bt7VQuSBN+Ytk3oZKMeMh87Zk9DIgYrdnF+U+ZDxOEvomcDzxowp8Gy7xrxO7BulJ3k2Bsqa1CJUOkbS4+WzGB4Uxkm6wxWzEDaeI3TIzwC25hLJmM7i/T1UQW9OD5VqusdVc6DWRiBgf8VmN4RS8mF+XmulLWseid7CA5wZ14lCbw2B2K9JKiXavwXWHQD0YBelDzQefxNCPF62NT9j2HHGQa+xdatzHNPQMMWwpME4Ro6mbt9rIktvKayHBDBn2IjWzok=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6e0857-e7ae-4a12-292a-08d7047a811d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 14:34:09.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4856
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/09 22:37, Christoph Hellwig wrote:=0A=
> On Tue, Jul 09, 2019 at 04:53:48PM +0900, Damien Le Moal wrote:=0A=
>> For large values of the number of zones reported, the sector increment=
=0A=
>> calculated with "blk_queue_zone_sectors(q) * n" can overflow the=0A=
>> unsigned int type used. Fix this with a cast to sector_t type.=0A=
> =0A=
> How about just returning a sector_t from blk_queue_zone_sectors, turning=
=0A=
> this into an automatic implicit cast for all callers?=0A=
> =0A=
=0A=
That works too. Will send an update.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
