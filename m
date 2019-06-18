Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC6C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 22:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FAE20B1F
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 22:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AwOfm8Fc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hPkqgvZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfFRWAn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 18:00:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2048 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWAn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 18:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560895303; x=1592431303;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JIoRU9LBF65byVSH0aNQMvyMfhMtyxPYYKRbsqnjoAU=;
  b=AwOfm8FcJth/C1DRQA3JAWsMPKbyS86BsYobJDeyMH6zQkgCSvcm5kzJ
   wdVX4uq61qI5m20h/z8uKKq5zcna6TJXJG9WbDEuud+tWzMkpRZqfdBO7
   GIoyI2UvApmY9W2xOA8hbtQz3WR0SM8DEd1cdgB1yin8UlEl4ojnOi4zw
   RXcqCD42b5C98Dsqnyf0nrGFhH3100IdlwM/fOBfcwrxgdClPEDq7AKPb
   hO7pHMQ+OoXmYRv4YpnA186scwqMRd1tbrAjNU2wXmsntmlXAX/hGp17Y
   I2gzpLhOKG9L8N28is3uPo3pj3VjuNxgl2pY2OMqoFSLsmOMl8ccSMnit
   w==;
X-IronPort-AV: E=Sophos;i="5.63,390,1557158400"; 
   d="scan'208";a="210640978"
Received: from mail-bn3nam04lp2053.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.53])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 06:01:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfDQn4/+93AfE2mEDWZajpu9Xe2u5bb65t5w8GM6cvM=;
 b=hPkqgvZ4hgfev3n3KT6lhiSWIzUWXVh0bV2WXPaLA3xRbzESpe90+t9ocn/w0vtmoQ6hn7Iwj7Hb2yJPv/Jn/OuMgb8bA28dtgKImNh6bD2NzaoOUQv5O8X/Cw+ONFeQVgwVvQQ3RkUEPZXMKI6ctykxcIQ2SAw9cRtIm7z4Jkg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5958.namprd04.prod.outlook.com (20.178.232.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 22:00:40 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Tue, 18 Jun 2019
 22:00:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "yuchao0@huawei.com" <yuchao0@huawei.com>
Subject: Re: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
Thread-Topic: [PATCH V3 2/6] block: add centralize REQ_OP_XXX to string helper
Thread-Index: AQHVJZikjbQiXp4c80eE8SX7H+AKHw==
Date:   Tue, 18 Jun 2019 22:00:40 +0000
Message-ID: <BYAPR04MB5749C5921DF5D60C9AD9558B86EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-3-chaitanya.kulkarni@wdc.com>
 <97487a45-0a53-970a-8237-86eebfbe7ad9@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97b873a3-d0e7-4192-2bcb-08d6f4386749
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5958;
x-ms-traffictypediagnostic: BYAPR04MB5958:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB59588896C956AB79F76F69BB86EA0@BYAPR04MB5958.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(6246003)(53546011)(66446008)(7736002)(66066001)(2501003)(6506007)(66946007)(72206003)(66556008)(2906002)(7696005)(8936002)(76116006)(53936002)(102836004)(64756008)(3846002)(14444005)(71190400001)(6436002)(305945005)(476003)(71200400001)(76176011)(74316002)(9686003)(68736007)(86362001)(6116002)(81166006)(99286004)(14454004)(52536014)(486006)(73956011)(66476007)(316002)(55016002)(33656002)(8676002)(25786009)(110136005)(26005)(5660300002)(478600001)(256004)(186003)(229853002)(4326008)(81156014)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5958;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HfkiUUKL9oQKb1gty5tqn0EDdFdwYosnawoHNjWmyhNXw13wOQSC2yInAioDOmi3N6QCuT9Sa93oy1AmiOPYPicFTUd2g8qwesIYpyB4ewRAgpkucQs3lyjEUkOKeXVm73MLZ1F3ROV8/y6QJEDP3tVLkqUlJcJX51dqU0O6n+LOgP8bINqrhTBf/6VBYLTA/8nNO417x6eK0HQ9fdYTcrkqMwBpCCJWPD5AlpUd2tpysI7gnxviewcocRhwZdpz9xs8ifCwqSnFcaJ5CM1sf9tIXNsn2wotvygFsxDIfEYJyZOsU6S+6vIX61F66nN0Q5gXOSY7riJtyr3gnQIpMXqhry01j4XPFVkD3cXJCrrlEpECR49cfEOv1EyPvMZzO48EkK7y2G/CAkhouPfUJ+94L3q5NrEIkHf7nrSMfz8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b873a3-d0e7-4192-2bcb-08d6f4386749
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 22:00:40.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5958
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/18/2019 08:26 AM, Bart Van Assche wrote:=0A=
> On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:=0A=
>> +inline const char *blk_op_str(int op)=0A=
>> +{=0A=
>> +	const char *op_str =3D "UNKNOWN";=0A=
>> +=0A=
>> +	if (op < ARRAY_SIZE(blk_op_name) && blk_op_name[op])=0A=
>> +		op_str =3D blk_op_name[op];=0A=
>> +=0A=
>> +	return op_str;=0A=
>> +}=0A=
>=0A=
> This won't work correctly if op < 0. If you have another look at the=0A=
> block layer debugfs code you will see that 'op' is has an unsigned type=
=0A=
> in that code. Please either change the type of 'op' from 'int' to=0A=
> 'unsigned int' or change 'op < ARRAY_SIZE(blk_op_name)' into=0A=
> '(unsigned)op < ARRAY_SIZE(blk_op_name)'.=0A=
>=0A=
=0A=
Sorry I'm little confused here, even though op is defined as a unsigned =0A=
int we print it as a "%d". So I think we need to keep that as it is or=0A=
I'll be happy to send a corrective patch to print it is using %u, your =0A=
input will be very useful here.=0A=
=0A=
Regarding the correctness, I think if one of the operand is unsigned =0A=
then signed values are converted to unsigned valued implicitly.=0A=
=0A=
However the exceptions is if the type of the operand with signed integer =
=0A=
type can represent all of the values of the type of the operand with =0A=
unsigned integer type, then the operand with unsigned integer type is =0A=
converted to the type of the operand with signed integer type.=0A=
=0A=
I'm wondering how would above scenario occur when comparing int and =0A=
size_t. (unless on a platform int can fit all the values into size_t).=0A=
Since above comparison of the ARRAY_SIZE involves sizeof (size_t) type =0A=
is a base unsigned integer value, even if op < 0 it will get converted =0A=
into the unsigned and it will still work.=0A=
=0A=
Please correct me if I'm wrong.=0A=
=0A=
In order to validate my claim I ran a test with simple test module=0A=
here are the result:-=0A=
=0A=
void test(void)=0A=
{=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_READ));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_WRITE));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_FLUSH));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_DISCARD));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_SECURE_ERASE));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_ZONE_RESET));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_WRITE_SAME));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_WRITE_ZEROES));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_SCSI_IN));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_SCSI_OUT));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_DRV_IN));=0A=
         pr_info("%s\n", blk_op_str(REQ_OP_DRV_OUT));=0A=
         pr_info("LAST %s\n", blk_op_str(REQ_OP_LAST));=0A=
         pr_info("LAST + 1 %s\n", blk_op_str(REQ_OP_LAST + 1)); =0A=
=0A=
         pr_info("-1 %s\n", blk_op_str(-1));=0A=
         pr_info("-2 %s\n", blk_op_str(-2));=0A=
         pr_info("-3 %s\n", blk_op_str(-3));=0A=
         pr_info("-4 %s\n", blk_op_str(-4));=0A=
}=0A=
=0A=
[  819.336023] READ=0A=
[  819.336030] WRITE=0A=
[  819.336034] FLUSH=0A=
[  819.336037] DISCARD=0A=
[  819.336041] SECURE_ERASE=0A=
[  819.336044] ZONE_RESET=0A=
[  819.336048] WRITE_SAME=0A=
[  819.336051] WRITE_ZEROES=0A=
[  819.336054] SCSI_IN=0A=
[  819.336058] SCSI_OUT=0A=
[  819.336061] DRV_IN=0A=
[  819.336064] DRV_OUT=0A=
[  819.336068] LAST UNKNOWN=0A=
[  819.336071] LAST + 1 UNKNOWN=0A=
[  819.336075] -1 UNKNOWN=0A=
[  819.336078] -2 UNKNOWN=0A=
[  819.336081] -3 UNKNOWN=0A=
[  819.336084] -4 UNKNOWN=0A=
=0A=
I'll make this change op int->unsigned as it is present in the debugfs =0A=
code so that it will be consistent, thanks again for looking into this.=0A=
=0A=
> Thanks,=0A=
>=0A=
> Bart.=0A=
>=0A=
=0A=
