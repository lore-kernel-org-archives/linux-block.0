Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C422EC48BD5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984742085A
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 01:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W1Xus/tN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="x5EWgi/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFZBiI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 21:38:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15066 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZBiI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 21:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561513088; x=1593049088;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HAX9bjKesgLkDyPdkUx59AA6olcn0kK3yvInepWdkF4=;
  b=W1Xus/tNBmnVVl9kcQh+iks3oZl79VEzZgn9Jk1gaanMbrI8yL/L3LTD
   gboshYBo3gF2pWXYAORI57xsKGvOgKQqT8ZMvPLRfRcOjrs1374jF0vb2
   ehPE2DFC5jFMzVbPai+iS78FidcNp5p2NypRT2wg/umc++E9zEuBZ9n3o
   uvl1F2anf4vrA7MWi1zCH+nY+sXQmTlps6/GHHilpUxnb+Bmyh99G0A7J
   SDlrxLwb7MME3zkbpPZXTrCd8qBjWeJ0ISvusfOlZ6JCXDiewLM5LaPxr
   wMgiOs9423gc3qMIa7GTGcZSieYe1ES4HvizUnS1gIvU5l2jSuj0i2P2n
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,418,1557158400"; 
   d="scan'208";a="116422019"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2019 09:38:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QB+EqwU8JWtOyRnZ5zjDrCnv7+9ZgHS9hD6R8W8gGa4=;
 b=x5EWgi/R5qJxBz+h8RTvl0VgFr7C3XfaroqMs/cwQCXCOmqaWdXrznxj8mWUzSrWAnnhSke6Q/uA0vVEUtB8aZKVXohFrunvybYFF16g2Cre6or6a+mvRpUG35PKc1ZBtFBaOaUxn+z9nXP0G6qkdX8cT7RvNEFWEYSlRc3LZyU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4341.namprd04.prod.outlook.com (20.176.251.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Wed, 26 Jun 2019 01:38:05 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Wed, 26 Jun 2019
 01:38:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVKwA0O+IlYIAO80SILz5RMubhpQ==
Date:   Wed, 26 Jun 2019 01:38:05 +0000
Message-ID: <BYAPR04MB58160BAAFBDE4C399C412F1FE7E20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
 <BYAPR04MB5749C9178CB54B4A488408A986E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <47ab2698-9767-b080-59b7-2c4b3afaa6d3@acm.org>
 <BYAPR04MB57498FD0AE458FE6196DD7BA86E30@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c701dc64-7647-4bdc-4607-08d6f9d6efab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4341;
x-ms-traffictypediagnostic: BYAPR04MB4341:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4341D9FAD6DF1411F4D20CE7E7E20@BYAPR04MB4341.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(66556008)(64756008)(5660300002)(73956011)(66446008)(66946007)(52536014)(76116006)(91956017)(66476007)(256004)(2906002)(229853002)(14454004)(2501003)(446003)(6116002)(3846002)(486006)(72206003)(476003)(4744005)(33656002)(68736007)(71190400001)(71200400001)(8936002)(6246003)(6436002)(26005)(66066001)(305945005)(102836004)(74316002)(7736002)(9686003)(53936002)(110136005)(86362001)(316002)(53546011)(81156014)(55016002)(81166006)(25786009)(4326008)(6506007)(7696005)(76176011)(99286004)(186003)(478600001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4341;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bhvVCy3BvboGAGfolkTL/O/4ye2V8ZYkBp4ZIC6UwjXahgXfFhvA+zgqunTE851F8W3cRzqTGDKlFGhCEly9QHy8c5h8YiHt+VW0ErLm3sRUsNyRHlAfwGyduqUBlEoN+8gAlVvlMDNI2MZ9JGTCTbzncNuyHkccm7QBeWvs9xPNKdUg03RFTBl7Ev3HRhsjr297LsUxPicPJ0M1VCtSXV2T4A+v0Bq5If0L/SD8L55iKRHF9dA50/v9EY4ZJ+24X3dUGnhUDcXGbJeGnRNkYc2SG85VB66DiaEDmWuYVV9k5PMT3nVad6aDaBG2/bMJBZGMA+lhaUtUb4Q0wF+vpwLVxTsUnF3gtx0hWEwgbS02AXoJgaIFpjFbkxWG4fsuMIDqMJcyobeyu07xO2C7oP7IfcZyu209C72wX6vG4/0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c701dc64-7647-4bdc-4607-08d6f9d6efab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 01:38:05.7851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4341
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/26 1:06, Chaitanya Kulkarni wrote:=0A=
> On 06/25/2019 08:59 AM, Bart Van Assche wrote:=0A=
>> On 6/24/19 8:24 PM, Chaitanya Kulkarni wrote:=0A=
>>> nit:- Can we use is_vmalloc_addr() call directly so that=0A=
>>> "if (is_vmalloc)" ->  "if (is_vmalloc_addr(data))" and remove is_vmallo=
c=0A=
>>> variable.=0A=
>> That would change a single call of is_vmalloc_addr() into multiple?=0A=
> =0A=
> Well is_vmalloc_addr() it is an in-line helper with address comparison.=
=0A=
> =0A=
> is it too expensive to have such a comparison in the loop ?=0A=
=0A=
Probably not, but I do not see the point in calling it for every page eithe=
r=0A=
since the cost of the additional bool on the stack is likely also very low.=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
