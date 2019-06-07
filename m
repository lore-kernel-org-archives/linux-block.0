Return-Path: <SRS0=19b2=UG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF375C28CC3
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 05:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672E5208C0
	for <linux-block@archiver.kernel.org>; Fri,  7 Jun 2019 05:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DXo3e1YW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ajw5X53t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbfFGFEW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jun 2019 01:04:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49446 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFEW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jun 2019 01:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559883863; x=1591419863;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RbFFeLmY/diAcj5Nk2v12T4bzp9roXvJ0OzqSYO3eNY=;
  b=DXo3e1YWY/BLgVuVHLelkDjEIhVEomJkfcoKHjApqhjVHrYdzXn5wMM+
   RKyGMu/GGzkldMgdKB3gH4D4lgqRBts8/P6Ff42xp2ysggUPL1FUz93xe
   QiI/hfl60SmwFB93KF8dsBBaqlSwpBYcsVu5JyKOcaEtZqq9JkFyrd0gQ
   EijVPa5LwtuHkrwG1XXE+jul6oyZN11G6mvr9k17exT0tz+ACYH/qGUh1
   YwaQwb8leWlq2Yu5wIK3DVJlqr+Myf/uQ7Ar24eVFrbwvmNs7LKnKpwKU
   5LgiwVO6/MX67UWUCxw5ZcDPqhyXIxGv7KLRaor+H4crDmf+nNC9JX4dQ
   A==;
X-IronPort-AV: E=Sophos;i="5.63,562,1557158400"; 
   d="scan'208";a="114954081"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 13:04:22 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6sB+rmhaukEw2CcrLIeYRStOPsR8d+Xx4/9WicETOU=;
 b=Ajw5X53tpF4F5mTC0gdE1h1Jk0GE1hstGZzg8sgrhtl26jHAhYjjtOPm91TGeJbHataxXMLv34GMRHps5yYHUPHiN7Gph1UMmeXgDHaijsqboxUGZiKKuh/3OGGhQaug8MVQsP4jTdFqkuKviXokLNHCeCcTIE+Qp3VnkdoKnTE=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2139.namprd04.prod.outlook.com (10.167.8.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 05:04:20 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::dc9c:c09c:cd48:6be]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::dc9c:c09c:cd48:6be%5]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 05:04:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v2 2/2] zbd/007: Add zone mapping test for
 logical devices
Thread-Topic: [PATCH blktests v2 2/2] zbd/007: Add zone mapping test for
 logical devices
Thread-Index: AQHVF1R2dn6ZY2fTuky+fZ92eK3E+g==
Date:   Fri, 7 Jun 2019 05:04:20 +0000
Message-ID: <CY1PR04MB2268374335DF43233D53F846ED100@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190531015913.5560-1-shinichiro.kawasaki@wdc.com>
 <20190531015913.5560-3-shinichiro.kawasaki@wdc.com>
 <20190605215331.GB21734@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadcd549-ceb5-4962-c18a-08d6eb059994
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY1PR04MB2139;
x-ms-traffictypediagnostic: CY1PR04MB2139:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB2139E40AD39857C200A4316EED100@CY1PR04MB2139.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(4326008)(26005)(99286004)(68736007)(8676002)(6246003)(316002)(44832011)(74316002)(66476007)(478600001)(66066001)(73956011)(86362001)(55016002)(52536014)(5660300002)(6916009)(2906002)(7696005)(8936002)(476003)(53546011)(53936002)(81166006)(486006)(81156014)(14454004)(446003)(6506007)(102836004)(76176011)(305945005)(9686003)(7736002)(91956017)(66946007)(76116006)(64756008)(66556008)(14444005)(54906003)(66446008)(256004)(229853002)(33656002)(186003)(6436002)(71200400001)(71190400001)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2139;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ejktW5XzO+OZ6fbUzZ7k5omA8l8cuk6t/4QLVuA2oYdIn7TtACyAH1ZGWBxUGsQp+1bDCe2MOhHshy/FYvb7pZDkKOG3rYGuUyHd6it6c0/P4/zKEu4D6mtbuqP9A3cZa+d+IW8K0yckhL9/s0EmdoP+YgJgYOrM2dNRO7PDXEIyW6RiqbsX2sINme9mPiCTnIn58VlOSPx3Uy8MxrlnXGB+hWTTwJdow755HG1oSGIl5LwKeIoodfVCAiIQbsBW7N3qqz9cmlQLqcZ8yCnqKJCEeCU6I+ZtNi/OfjwsbpSxkiuyIku1BqKIgcT1waVo1wp/pxVpm3I/M7LR+hlDnTGqqRWEBJc0QfhpHJDlM6R8E/ay6LLU2h+OKp2uD08FvnzvSc+bTyzcphaTIEBVzN/tfm7qxf70Lbvcl4wcvJE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadcd549-ceb5-4962-c18a-08d6eb059994
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:04:20.3130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2139
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 6:53 AM, Omar Sandoval wrote:=0A=
> On Fri, May 31, 2019 at 10:59:13AM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> Add the test case to check zones sector mapping of logical devices. This=
=0A=
>> test case requires that such a logical device be specified in TEST_DEVS=
=0A=
>> in config. The test is skipped for devices that are identified as not=0A=
>> logically created.=0A=
>>=0A=
>> To test that the zone mapping is correct, select a few sequential write=
=0A=
>> required zones of the logical device and move the write pointers of=0A=
>> these zones through the container device of the logical device, using=0A=
>> the physical sector mapping of the zones. The write pointers position of=
=0A=
>> the selected zones is then checked through a zone report of the logical=
=0A=
>> device using the logical sector mapping of the zones. The test reports a=
=0A=
>> success if the position of the zone write pointers relative to the zone=
=0A=
>> start sector must be identical for both the logical and physical=0A=
>> locations of the zones.=0A=
>>=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>   tests/zbd/007     | 110 ++++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>   tests/zbd/007.out |   2 +=0A=
>>   2 files changed, 112 insertions(+)=0A=
>>   create mode 100755 tests/zbd/007=0A=
>>   create mode 100644 tests/zbd/007.out=0A=
>>=0A=
>> diff --git a/tests/zbd/007 b/tests/zbd/007=0A=
>> new file mode 100755=0A=
>> index 0000000..b4dcbd8=0A=
>> --- /dev/null=0A=
>> +++ b/tests/zbd/007=0A=
>> @@ -0,0 +1,110 @@=0A=
>> +#!/bin/bash=0A=
>> +# SPDX-License-Identifier: GPL-3.0+=0A=
>> +# Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
>> +#=0A=
>> +# Test zones are mapped correctly between a logical device and its cont=
ainer=0A=
>> +# device. Move write pointers of sequential write required zones on the=
=0A=
>> +# container devices, and confirm same write pointer positions of zones =
on the=0A=
>> +# logical devices.=0A=
>> +=0A=
>> +. tests/zbd/rc=0A=
>> +=0A=
>> +DESCRIPTION=3D"zone mapping between logical and container devices"=0A=
>> +CAN_BE_ZONED=3D1=0A=
>> +QUICK=3D1=0A=
>> +=0A=
>> +requires() {=0A=
>> +	_have_program dmsetup=0A=
>> +}=0A=
> =0A=
> Looks like this test doesn't have a fallback device, so I can't run it=0A=
> here. Is that intentional, or was it just overlooked?=0A=
> =0A=
>> +device_requires() {=0A=
>> +	_test_dev_is_logical=0A=
>> +}=0A=
=0A=
Zone logical remapping is necessary only and only if the target device is n=
ot=0A=
the raw entire block device, that is, if the target is a partition block de=
vice,=0A=
a DM device mapping only a portion of the backend disk, or a combination of=
=0A=
both. When the target device is an entire raw block device, zone remapping=
=0A=
(shifting of zone start and zone write pointer position) is not necessary a=
t=0A=
all. If we add a fallback device, the test will still run, but will end up =
being=0A=
a test for a straight report zones, which is already covered by test zbd/00=
2. So =0A=
we thought it not necessary to add here.=0A=
=0A=
This test is rather intended at catching complex zone remapping problems li=
ke we=0A=
had in the past already: see commit 9864cd5dc54c "dm: fix report zone remap=
ping =0A=
to account for partition offset".=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
