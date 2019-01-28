Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B76C282CF
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B35C214DA
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 10:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fzcXU14V";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RfNMX2QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfA1Khk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:37:40 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28021 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Khk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 05:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1548671859; x=1580207859;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tlAuwqqQrpv5XymuzHcG6KmGyS3CDA15Me6ooTOU1UA=;
  b=fzcXU14VAph5oWdaHDJioOFROF+cJ3vfaUYDc5Hno+rnu9fqCIRl9l+1
   NFvact6kpmJcy27hZKf47oCCTFu9I2aAIDDFse0aMdIEIxphRTwFRlAWw
   RoYJ5JaCqL2G7s8nrShUyWbGyUL9ntByGbL4nXjBgSkrrBTTfuo9xCq4M
   CGeQW4n2gWtOsvo+1ypkN9WbjQEw/hsG1V0Pgd5DMP6sSdkfLOp7KIYcB
   3pNbdmpxzPEQI/wo0gTENTrfBKWLtwwsl3GxHD48mJxhkRbL4qM7VQ/Ky
   mVer2FSAbYb7GHqB71mYQ1jk3gwxIFpslENExqIwyfMioASeE+M993hiS
   g==;
X-IronPort-AV: E=Sophos;i="5.56,533,1539619200"; 
   d="scan'208";a="99933859"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2019 18:37:38 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYuF/3OLdikvSOj3PGcCh398Oe/MpYXfNRpQi1V60Xk=;
 b=RfNMX2QJxIwjp362LQjnggV4xBqTCFDm0WkoW+QvoxWk3i2mVXtSJyf1lJYZQ0uI96TOS1hUi59SvSA5hUUjyhAVcWubWRzX//SnT7y0R+PSg+eMsR23fGxV6pR9BvpSY1wZgggFXMVp8tPTCSRoQI8IoeJc3dCHKAI/QqFaG94=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2026.namprd04.prod.outlook.com (10.166.191.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Mon, 28 Jan 2019 10:37:37 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::9431:bb6e:5c5f:ca67%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 10:37:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests v3 04/13] block: Whitelist tests supporting zoned
 block devices
Thread-Topic: [PATCH blktests v3 04/13] block: Whitelist tests supporting
 zoned block devices
Thread-Index: AQHUrxKH88gLQJNERUeEV0n3FP1irw==
Date:   Mon, 28 Jan 2019 10:37:37 +0000
Message-ID: <CY1PR04MB22686FBCD714A6D2BCA1D401ED960@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190118094453.13773-1-shinichiro.kawasaki@wdc.com>
 <20190118094453.13773-5-shinichiro.kawasaki@wdc.com>
 <20190125211101.GC26739@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR04MB2026;6:uPG6+1xXGnp/U2bwiykVjkkzbrJfJPutnUnwR/+Qdvpq907z/h8nDyHbGzhV1LuX1LEQb87aMqbD0YonZJ0RYsMP7RfPveiH1Ir9Z7Gb03OTWjYC8+p1Bqv5N3V8J5wL0MCM5+B8U0P2zqUZqob1OabfIMUUw9nUg9+n7SCgrHSQfoHohIyHV5cVB4cWFZWWJTs9UCO1WKBi2q3VrmhD5SGs84sdaRVOZXAN3p42dnB23O0DqI4/XhpFaLp+Sv6dd+lngB+4e/EVSpTgmndcrewMp34YS6S4znmo0GNm0WsRqnCWxmeCjz/SjFSf9HfrpwTB1aMxP9hzpjw/NNns9SmU2Fj7o2u8DTGIQWB7JV9JHNS7he4OFTXr4xc2E+fTWo2MfaH+Sxkak04NJt2lGorlFkWjQCmaQY96nuLZG77syfy6Iqq3sOal/2KKKFXvNogP32Qn5ymi7oluRyOT/g==;5:f6I3cWnMKK5k3rRgxsRT8FhS9ZjnAB34Te4LVXZOfne8Z0PmUX0sjOd0PtXwoDKPvLDKr5BEj9WyMn1pFUUEhUXyNqFdyrVQUYGJrPzq35rQ47rVmcXyBSnk7K3E+cSb+j4vyOxzvFttRP/GmpBXd4/uyrcr7VDVCVQZXdqUccxWiupeZkllwxppTH3m0NU3tGwNCWPm5C2D/Xy81ndZZw==;7:8Y9+dd1s1Vz9BHjWwSp8m2gsS0FpEsgtcwEyz88dxZLJxOdGnv/4XIZmmgoFxe8C+gAbMwK2+ltiJS7dmDVUeUhgs9o1iilPx1Y63A2zRPwhL1aZxYxx3G8anHRGXLtD0DciirwmTSchj7YiEsnhnw==
x-ms-office365-filtering-correlation-id: a532bf69-24dd-493f-559e-08d6850c9f00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2026;
x-ms-traffictypediagnostic: CY1PR04MB2026:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB202616D8D0F69EB5B8EB0CFCED960@CY1PR04MB2026.namprd04.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(81166006)(81156014)(44832011)(86362001)(3846002)(4326008)(8676002)(102836004)(25786009)(476003)(7736002)(53546011)(305945005)(6506007)(7696005)(478600001)(486006)(53936002)(6116002)(99286004)(2906002)(26005)(186003)(33656002)(229853002)(66066001)(8936002)(6916009)(316002)(74316002)(68736007)(55016002)(9686003)(54906003)(76176011)(6246003)(106356001)(97736004)(256004)(14454004)(6436002)(71190400001)(71200400001)(446003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2026;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s0XP5/DJpViXr0TAHeXAYSlUVr1V9m8rVrEXeTaUPVAg8Cg6SYSzBJ+nQOkTxNiH3th0pMn21Tsv0RE0nPNo2IuSogmPfqfbTxqSgXmZxoBfVTRHukYFGU9avHkOklP64WXlbWmDCbhXXLPiZaslmQQrR3qYm1czi4vIsSttCN441/AZOM/a0VQj8cYEM7qoYpQ8KHirSbf1IzIfyvpOpbl2xdVl+Lted6qA5iJ8pGVKJOQHbELYTxi29Tfre+gux04CaQmAd1IhuaHurd0CbnRHUig/zCQ/4eFKWNsFe4oxm+MxfH+oYfYkAeXdhGcnXv4AFTC0nNathvyvJEbShcZOhJXnyNSSg/27yCMoSnU794PQJUmnmrguu3M167OBVtfecmuoW5bYLDXou6wpE2QjnHE1wPUmzUjT1lqjbnc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a532bf69-24dd-493f-559e-08d6850c9f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 10:37:37.2654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/19 6:11 AM, Omar Sandoval wrote:=0A=
> On Fri, Jan 18, 2019 at 06:44:44PM +0900, Shin'ichiro Kawasaki wrote:=0A=
>> Define CAN_BE_ZONED=3D1 in block/005, block/006, block/010, block/011,=
=0A=
>> block/016, block/017, block/020, block/021 and block/023 as all these=0A=
>> tests should execute without any problem against null_blk with zoned=0A=
>> mode enabled or zoned block devices specified in TEST_DEVS.=0A=
> =0A=
> Several of these tests do random I/O, did I miss a change that makes fio=
=0A=
> use zonemode=3Dzbd or something?=0A=
=0A=
Five of the test cases white listed call fio with random "read" I/O. Random=
 =0A=
"write" I/O requires zonemode=3Dzbd, but "read" I/O doesn't. block/006, blo=
ck/010 =0A=
and block/020 specify --rw=3Drandread option explicitly. block/005 and bloc=
k/011 =0A=
call _run_fio_rand_io() and the function specifies --rw=3Drandread. For the=
se test =0A=
cases, current fio options can be applied to the zoned block devices withou=
t =0A=
zonmode=3Dzbd.=0A=
=0A=
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
>> ---=0A=
>>   tests/block/005 | 1 +=0A=
>>   tests/block/006 | 1 +=0A=
>>   tests/block/010 | 1 +=0A=
>>   tests/block/011 | 1 +=0A=
>>   tests/block/016 | 1 +=0A=
>>   tests/block/017 | 1 +=0A=
>>   tests/block/020 | 1 +=0A=
>>   tests/block/021 | 1 +=0A=
>>   tests/block/023 | 1 +=0A=
>>   9 files changed, 9 insertions(+)=0A=
>>=0A=
>> diff --git a/tests/block/005 b/tests/block/005=0A=
>> index 65eba22..8ab6791 100755=0A=
>> --- a/tests/block/005=0A=
>> +++ b/tests/block/005=0A=
>> @@ -8,6 +8,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"switch schedulers while doing IO"=0A=
>>   TIMED=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_fio=0A=
>> diff --git a/tests/block/006 b/tests/block/006=0A=
>> index 630d478..0b8a3c0 100755=0A=
>> --- a/tests/block/006=0A=
>> +++ b/tests/block/006=0A=
>> @@ -12,6 +12,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"run null-blk in blocking mode"=0A=
>>   TIMED=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk && _have_module_param null_blk blocking && _have_fio=
=0A=
>> diff --git a/tests/block/010 b/tests/block/010=0A=
>> index 76b301f..b81208e 100644=0A=
>> --- a/tests/block/010=0A=
>> +++ b/tests/block/010=0A=
>> @@ -12,6 +12,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"run I/O on null_blk with shared and non-shared tags"=0A=
>>   TIMED=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk && _have_module_param null_blk shared_tags && _have_fi=
o=0A=
>> diff --git a/tests/block/011 b/tests/block/011=0A=
>> index 8e10900..c3432a6 100755=0A=
>> --- a/tests/block/011=0A=
>> +++ b/tests/block/011=0A=
>> @@ -8,6 +8,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"disable PCI device while doing I/O"=0A=
>>   TIMED=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_fio && _have_program setpci=0A=
>> diff --git a/tests/block/016 b/tests/block/016=0A=
>> index 10ec4ba..c70b7d0 100755=0A=
>> --- a/tests/block/016=0A=
>> +++ b/tests/block/016=0A=
>> @@ -11,6 +11,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"send a signal to a process waiting on a frozen queue"=
=0A=
>>   QUICK=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk=0A=
>> diff --git a/tests/block/017 b/tests/block/017=0A=
>> index cea29be..e4a9259 100755=0A=
>> --- a/tests/block/017=0A=
>> +++ b/tests/block/017=0A=
>> @@ -11,6 +11,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"do I/O and check the inflight counter"=0A=
>>   QUICK=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk=0A=
>> diff --git a/tests/block/020 b/tests/block/020=0A=
>> index a377ea2..39dde66 100755=0A=
>> --- a/tests/block/020=0A=
>> +++ b/tests/block/020=0A=
>> @@ -11,6 +11,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"run null-blk on different schedulers with only one hard=
ware tag"=0A=
>>   QUICK=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk && _have_fio=0A=
>> diff --git a/tests/block/021 b/tests/block/021=0A=
>> index 0ca5a17..a1bbf45 100755=0A=
>> --- a/tests/block/021=0A=
>> +++ b/tests/block/021=0A=
>> @@ -11,6 +11,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"read/write nr_requests on null-blk with different sched=
ulers"=0A=
>>   QUICK=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk=0A=
>> diff --git a/tests/block/023 b/tests/block/023=0A=
>> index b0739f7..0f20f4a 100755=0A=
>> --- a/tests/block/023=0A=
>> +++ b/tests/block/023=0A=
>> @@ -10,6 +10,7 @@=0A=
>>   =0A=
>>   DESCRIPTION=3D"do I/O on all null_blk queue modes"=0A=
>>   QUICK=3D1=0A=
>> +CAN_BE_ZONED=3D1=0A=
>>   =0A=
>>   requires() {=0A=
>>   	_have_null_blk=0A=
>> -- =0A=
>> 2.20.1=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
