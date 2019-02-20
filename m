Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86169C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CB21841
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p74LzK2c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jH7EJg+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBTS2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:28:53 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3657 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfBTS2x (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550687332; x=1582223332;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HgAq6J+ZDgFS4Ouw35QokK9HwbVLCuYzdhgeG5p993I=;
  b=p74LzK2c7yXkf0XcYHQZobR+FkatSPY22b5wYTBtI/LhGTeZcg82xypF
   HCDh3JoJxBMu2dk3QuEhkHXoI5rkiW+mFQ04P9DqiA6bKjH64iqg5Irb7
   DbrPJ4Vx9dw1pMYWpLRwNseGpUc9x5+lkNTv2IXg6AftP3g9jgYD4Rijy
   4LWnsdN73Zv0tQzFV9npLJsbxrbsp3gB5Q7Mj2v7ihuZmj10yWIz1aHZ5
   EUzFOrSSwad9+/wYWhdHpOQE8LULPvjHaYh3NbhwJbMJLb8wuJLBz6bbi
   00zH0fmnRWW5M+wacHVBo5KCJByS1ydCPRMHma0eClP2fe3WjRhCiXerw
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,392,1544457600"; 
   d="scan'208";a="206960464"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 21 Feb 2019 02:28:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2QZaYaE+rZYGjhlIKVWN7m7NK8yeCOD066pQ0pVe1E=;
 b=jH7EJg+3hX9bEQtak8uqwdMabAh3/VqQHYVrXl8SmeOWPbYWi5I1NLI0eAZgLXbMb2wuqqONg/9CQZpJLdLWIOenuOxiclwJR80T3v/vnglsTuSh7Zg0Pm2gaG6X7UGIa+vZwK8mdX8DBp+xHrdMmCYWvvERBIteMjdjOLWHY+4=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4079.namprd04.prod.outlook.com (52.135.82.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 18:28:50 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c1b7:3d36:3809:f71a%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 18:28:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Thread-Topic: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Thread-Index: AQHUyJEY9x4bFajxGEW2DBTu4VxXVA==
Date:   Wed, 20 Feb 2019 18:28:50 +0000
Message-ID: <SN6PR04MB4527D0FAE8B353AEA45E0CD8867D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
 <20190220180327.GA8325@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7aec4f6-75e5-4a93-1168-08d697614288
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4079;
x-ms-traffictypediagnostic: SN6PR04MB4079:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4079;23:RZg5h/kHaQuQuti10I8CEKBR8KfhZZ0JjEZ+kc7L1?=
 =?us-ascii?Q?Frf2+tIG/Q0G54YGbmNPJIDAYxfwERnG8vH+hg7PIBB34A3can+rCuM+kH7z?=
 =?us-ascii?Q?oBvgW92H94eKKwgKJX7r12bCcFyK2Nhma5bNeuCGByVYK3YKUysM8cJdMM7a?=
 =?us-ascii?Q?Bn5qtA9wv6jZJV1Vf6W7YfpIB/4ZGVx5gP+YzCla6nW2URt5RtWEHBb1BoxL?=
 =?us-ascii?Q?eFXk1SBO5SoV94oZbTJipfxDkMw3iAEyBzGqoePRVKMlLsa3sTLnbvcDrQxS?=
 =?us-ascii?Q?gSD4zfYImWnv7t//qCMILkRg+kPehgZ70uCE2IDWsnRlvkRTxM8WLBXxRHXQ?=
 =?us-ascii?Q?qeorGz2/piY7Np4FL+8HmIC2Xu5cM9W1XuajR7rLtEYB8EeZeH3uqFqNE0nK?=
 =?us-ascii?Q?tyTIURy/OpmJ8i7VLUUA3h/iUMOzHqkLdilcUQBQCTvO0amHdR1l7q808WvC?=
 =?us-ascii?Q?EnZKP1ApdA6w/9M966H3O8sTuygpxiGuOQZga4qYkxEfWSeYRJrmb9g69Dwu?=
 =?us-ascii?Q?agrKKINFj0o5yd7Lwk34VM6DRziUukKruBA6kToKPxankYMlAp8SEJVx4cjT?=
 =?us-ascii?Q?EZXXcFBu5zCRB9jiwxK+sEMBVS76V05xtVuGK20U2ohzQ/GQuSKE46Llp58R?=
 =?us-ascii?Q?qh+a5obN+PNC7FnqhLsRjuSzaUzaMf4LnhHPHC9RyLY1CsDl+23CwCBz83wG?=
 =?us-ascii?Q?3t9M1EZac/esmkWthTqg/m8FssojBeOv8BOzuS/opBE8lb0xN1a90+xji/D8?=
 =?us-ascii?Q?Mgc9vJoNS4E+HUKvwOvUOlnHnb55RsGi24xJcB2bm0qZgPtIm6qlETQGffoN?=
 =?us-ascii?Q?FGurq4CgabH9ThO3CUK1GzByoLx61Reb9cCm6DS2vaf27PRc2/giiYQQdm2j?=
 =?us-ascii?Q?Whi3JuGZwJIHZ/3znCats4l1nse0n/DZtxr30oapcYuP+MhOfvo7HWtOoP3h?=
 =?us-ascii?Q?LPWM1C/PApj3hobNi2bFgf3YrUcAnPPNOFtbgIhKxYh5O2+J8LxqoAas9OzK?=
 =?us-ascii?Q?ZvKebZq6ezpBObO4/81PizHkORzRmueNW+d/W8+tS/2jyuLOFod/QfhmXyca?=
 =?us-ascii?Q?iptU7yk6JVmKX7ua+mHaowobvXvZ/Xsh4iH+Asf6PBeJ4i/CnWjdx2NdJVUa?=
 =?us-ascii?Q?eH14t8u7wN3ZHOw7p7vrRE5/ONHGgB5OzkGvbf2CPvcCU1Fy4ODVFsH4Cudc?=
 =?us-ascii?Q?Og57cplEcXNs/w=3D?=
x-microsoft-antispam-prvs: <SN6PR04MB4079F2B8B93FFF7EF4E5EE3E867D0@SN6PR04MB4079.namprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(346002)(376002)(136003)(199004)(189003)(26005)(186003)(446003)(316002)(229853002)(486006)(71190400001)(6436002)(476003)(68736007)(6506007)(256004)(55016002)(6246003)(102836004)(53936002)(53546011)(86362001)(71200400001)(7696005)(76176011)(5660300002)(9686003)(478600001)(106356001)(6116002)(3846002)(72206003)(74316002)(66066001)(99286004)(14454004)(105586002)(33656002)(97736004)(305945005)(4326008)(2906002)(8936002)(81156014)(6916009)(81166006)(7736002)(25786009)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4079;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ofR5S7EQxAybPlh6mftz7M7o1SM9SL57gqhozoK011ftOCHUXyj4i5JphNQmWwN4fJspQvmLOl9BpG0i28J6vryZ3DcFrXnANw0XWuZn67XlqN5BoqJnBtHOuuWstSwDi6mq0O96UjFK6InDgQhNatqWgwsaj7lPnKk0vgFqOMSY8ehCtiI+e180SKzZHg9IU5dGTcdgGxxHa6sJ709rf/nivFTCqNwJ5Q4D7qXCMUSgU65MfcwCy7iaIi+ZfE2OUjtW6KJq9bW4bi8E41hTFRdtsFBc4cOZwpl+gBUG/T4qJhRpU+8LTKArFoxItd2qvHyI385IjYYqQFcP4YOcrIrEhd1vlZQi3yFody09AMR1NRZws1p3byB2nLK/PAKCrIRHvH35CfTuJUZVw/k0dMQhYFg9FeDlcRkIq00rAuk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7aec4f6-75e5-4a93-1168-08d697614288
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 18:28:50.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4079
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02/20/2019 10:04 AM, Omar Sandoval wrote:=0A=
> On Tue, Feb 19, 2019 at 12:23:53PM -0800, Chaitanya Kulkarni wrote:=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>   tests/nvme/002.out | 4996 ++++++++++++++++++++++++++------------------=
--------=0A=
>>   1 file changed, 2498 insertions(+), 2498 deletions(-)=0A=
>>=0A=
>> diff --git a/tests/nvme/002.out b/tests/nvme/002.out=0A=
>> index aa71d8f..abecda5 100644=0A=
>> --- a/tests/nvme/002.out=0A=
>> +++ b/tests/nvme/002.out=0A=
>> @@ -1,11 +1,11 @@=0A=
>>   Running nvme/002=0A=
>>=0A=
>> -Discovery Log Number of Records 1000, Generation counter 1000=0A=
>> +Discovery Log Number of Records 1000, Generation counter 2000=0A=
>>   =3D=3D=3D=3D=3DDiscovery Log Entry 0=3D=3D=3D=3D=3D=3D=0A=
>>   trtype:  loop=0A=
>>   adrfam:  pci=0A=
>>   subtype: nvme subsystem=0A=
>> -treq:    not specified=0A=
>> +treq:    not specified, sq flow control disable supported=0A=
>>   portid:  X=0A=
>>   trsvcid:=0A=
>>   subnqn:  blktests-subsystem-0=0A=
>=0A=
> [snip]=0A=
>=0A=
> Why did this output change? An nvme-cli change, or a kernel change, or=0A=
> something else? And will this now fail with older versions of nvme-cli=0A=
> or the kernel instead?=0A=
>=0A=
=0A=
This change is specific to nvme-cli only.=0A=
=0A=
It should fail on older cli versions, we want latest cli/tools to be =0A=
used when running these testcases so that all the latest tools are=0A=
also been tested for the compliance, else we might be running tests=0A=
with any bugs with older version(s) which are fixed already.=0A=
=0A=
Actually I'd like to add quick nvme-cli version check at the start of =0A=
each test that will certainly help/force user to have a latest version.=0A=
=0A=
