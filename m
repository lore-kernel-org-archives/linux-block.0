Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD31C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B2C2133F
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bjn8GM5F";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ggdPyYCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfFYQGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:06:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13537 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfFYQGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561478802; x=1593014802;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5PY/VaLWh2ElLRdAjK1+L3i8MZF6YM2dUylHR8infRg=;
  b=bjn8GM5FfV2rISqdKxVqT/Dwv7SO3TVQlQ8GSRbe1rqpc+iu47UhiLeX
   /zmbAW8WxKvefY6nR0nrvSbtVHRvdOGdE3KmBTQfdixo3iWwIAhV5zhYX
   Umut9iH1ehtS0IBToaVaA1T9NVImfujX0Zw5h6b3UGl9asx6aCnPU4uGc
   7Er/8aVcW+ZWXrFks2bKom4PIYxlBDUZw0HntXScPGO4oPvxLZTgUPGkP
   Fi1uLsR/HDApU1wLKQLwtmqAb+k2OwLXRtJiTmn6NANsp9dszevfIAbtm
   B6OgvCJl4LQMWJPGsTm3oLZyTBV8XleMYUz+ZPk5vSnSdlE/hf5SpgjS2
   g==;
X-IronPort-AV: E=Sophos;i="5.63,416,1557158400"; 
   d="scan'208";a="217881925"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 00:06:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4g27D/qt+srpsoQWZ6ZX3zPJ7PH5oTfUsprimNxEt0=;
 b=ggdPyYCrmK1XQICOMdNj/D6KCZhvyqwESAoy4waqys8oC3Qd7/zTmp2FaPU5LxMfiVXsT42Of+i1fdrGc6e+ovw0kUKprwaIoMU2nEl/KCVdw3jjyZQEfIYP8gDHkdG+INamEqYdeBzsq0/azLaKTycTxCNpTa9VRvj9KK8lVek=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5416.namprd04.prod.outlook.com (20.178.50.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Tue, 25 Jun 2019 16:06:39 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 16:06:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVKwA0CgkpItjWVEOnwU70Lez80g==
Date:   Tue, 25 Jun 2019 16:06:39 +0000
Message-ID: <BYAPR04MB57498FD0AE458FE6196DD7BA86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
 <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <47ab2698-9767-b080-59b7-2c4b3afaa6d3@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166664e5-709b-42b1-f0d2-08d6f9871b29
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5416;
x-ms-traffictypediagnostic: BYAPR04MB5416:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5416D804F973140F5B507D6186E30@BYAPR04MB5416.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(52536014)(2906002)(76116006)(66946007)(6436002)(256004)(73956011)(72206003)(66476007)(33656002)(4326008)(446003)(3846002)(6116002)(66446008)(66556008)(64756008)(229853002)(66066001)(2501003)(53936002)(86362001)(9686003)(55016002)(8936002)(486006)(4744005)(81166006)(81156014)(478600001)(71190400001)(71200400001)(14454004)(25786009)(7696005)(316002)(99286004)(26005)(74316002)(186003)(476003)(102836004)(7736002)(305945005)(68736007)(6506007)(8676002)(6246003)(5660300002)(76176011)(110136005)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5416;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FqUDWG6Rhz4XwBTeSBKfzg5YGO0imkqPxzfeSzdIS4qjZ8UZutkMRP0+8S3o74rEUCPoGamzXtP15jno+2v+MyX13+MZQEizXW6cUkqiqFU8ymUPFR3FAbTpMVbXkAmMwCceo8O7wK721QWIDLBAhEAOinCN7+e5ZVz8hh68N/VGJ2oXosxP5Y2vbycgaZul3ZIUYVbnd4SFIS1u5B6oUuEPJfeoKgnZsjxCSEBtyQJbOj0xjeLowWVOarnQmmiQm222Pq5ousBbP1kJz9ApFa1HR4agWdH7hLIZFWxPp8NJj+/55CjZosWR9lE9CAgDqcKTZOOT/du2iu7zV1R3Od/1wg9PmI+yYmFEhINgBObA1s+P1CmYVmtPe9FMiyGtQgj4+e4HbHpV60jpBSm05KyotBnaZBz1lOS2n24T4T4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166664e5-709b-42b1-f0d2-08d6f9871b29
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 16:06:39.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5416
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/25/2019 08:59 AM, Bart Van Assche wrote:=0A=
> On 6/24/19 8:24 PM, Chaitanya Kulkarni wrote:=0A=
>> nit:- Can we use is_vmalloc_addr() call directly so that=0A=
>> "if (is_vmalloc)" ->  "if (is_vmalloc_addr(data))" and remove is_vmalloc=
=0A=
>> variable.=0A=
> That would change a single call of is_vmalloc_addr() into multiple?=0A=
=0A=
Well is_vmalloc_addr() it is an in-line helper with address comparison.=0A=
=0A=
is it too expensive to have such a comparison in the loop ?=0A=
=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
