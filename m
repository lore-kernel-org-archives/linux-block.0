Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C86C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F8120B1F
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NKwmQPYC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kqyT6JTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfFRQHQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:07:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2932 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbfFRQHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 12:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560874074; x=1592410074;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GB0V5B9eeyNW3CPggAobZmdd8A4Ktvy3E+Nm6UsFOhw=;
  b=NKwmQPYCYBOzY4gMjyLExEPK5g/TWtEzNU5nMKOYJMkdagFUoKsUDt81
   /MDTfcaWVYKnFNEupMQtT1EPEDwnKdbtVkz4/o9YXC1zEBfAm+RagyptQ
   b7xksv3hPjd8q2MNsWsgznm8VDb94/f4WZLpVwX8RmMXASR90ErPo6YyD
   MAxrl3r45tOnaWJbn9dHMLO0J0Qj9mOl02QY9MEaFcEcKlVISNw8qJYoU
   0d0E0GPBxxQjs/SlqYU+QloTsypiTKDIlh4Sfbp1lj5BG9A19dyLq61mu
   khdrtDusQEk6LvdhNDfEGIw+HvyN4mbIE849FzgU6Bq8HFds5TZRSDIpp
   w==;
X-IronPort-AV: E=Sophos;i="5.63,389,1557158400"; 
   d="scan'208";a="210607995"
Received: from mail-sn1nam02lp2056.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.56])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 00:07:53 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yPUlYC/BBeCsdpfuvrDNaaalwlLaypFWaDnIHaBYqE=;
 b=kqyT6JTrZI8Km1MTBJwL7FeO8cS1vetvxoW/x8oWDsBQsBo0cgw2rLico5uFNQMGgq9tVfvTxToqBET0eT/2HsY0fGvV+NFDCwweDvLTC3wwI07K63MD2jSDmrvuBxL61WvicT2Vdtg65NlFFcX/UZ/2OQd5BWu9931C5jp3CM4=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5957.namprd04.prod.outlook.com (20.178.232.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 16:07:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Tue, 18 Jun 2019
 16:07:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Chao Yu <yuchao0@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] f2fs: get rid of duplicate code for in tracing
Thread-Topic: [PATCH V3 6/6] f2fs: get rid of duplicate code for in tracing
Thread-Index: AQHVJZiv5E9Yxo9mskyiSqdZhq7lww==
Date:   Tue, 18 Jun 2019 16:07:14 +0000
Message-ID: <BYAPR04MB5749838A900EFE89165D699686EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-7-chaitanya.kulkarni@wdc.com>
 <088167e2-8744-5176-f282-7015d02482fa@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dee3fa2-a299-4d81-3986-08d6f4070791
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB5957;
x-ms-traffictypediagnostic: BYAPR04MB5957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5957EF9FC72D04CB1BAEE84A86EA0@BYAPR04MB5957.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(366004)(376002)(51914003)(199004)(189003)(53546011)(256004)(5660300002)(8936002)(76176011)(52536014)(6436002)(4326008)(55016002)(486006)(186003)(7696005)(68736007)(6116002)(25786009)(73956011)(14454004)(6506007)(478600001)(3846002)(9686003)(74316002)(110136005)(66946007)(66066001)(66476007)(33656002)(71200400001)(76116006)(102836004)(229853002)(2906002)(99286004)(316002)(53936002)(305945005)(72206003)(64756008)(476003)(81166006)(81156014)(446003)(8676002)(71190400001)(66556008)(26005)(86362001)(54906003)(66446008)(6246003)(2501003)(7736002)(26583001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5957;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mTXalxaMBhW/Ui9YyGJ7KjujeL8Y5/YvJuMV5hokAkKxpwVEUr5G+QQeAi394lL1uIEBEMTQ32L9YSbUf8ydXlPWc5Bq5YwFAoeDUr4R2Z4Win1dFZ/w9JjVDwEaeQUT452wk1GGlSpnpmO8KlV2QeiLP7k9FxRAHrY5KKd99AmqTesMPAqL7NhaGd4mnta0XRa57RAUftZYJLpAr5aDWCqU2vXYw055Gn81gW68my/tyrpGGws9+2Xp3tvnEby7CLwAfpMJqqFo5x7jwlyK0pWBLR3WXNeNCpIdh+QXRlQ0oFg78xw9tHUO/3MyvzQ/hhqcmbLYl6friraLMN3KAaCTRQDlhcXmHjemwwU/qEnJ9YFB5v2B6LQfFw2PYSk8AMfxJWj+OUyFGHebB5uF0F/l0dofnYPmhMfqAvt+3bs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dee3fa2-a299-4d81-3986-08d6f4070791
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 16:07:14.7550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the comments Chao.=0A=
=0A=
On 6/18/19 12:19 AM, Chao Yu wrote:=0A=
> Hi Chaitanya,=0A=
> =0A=
> On 2019/6/18 13:42, Chaitanya Kulkarni wrote:=0A=
>> Now that we have used the blk_op_str(), get rid of show_bio_type() and=
=0A=
>> show_bio_op() to eliminate the duplicate code.=0A=
> =0A=
> I think we can merge 5/6 and 6/6 into one patch.=0A=
> =0A=
>>=0A=
Will do it in a next version.=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>   include/trace/events/f2fs.h | 14 --------------=0A=
>>   1 file changed, 14 deletions(-)=0A=
>>=0A=
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h=
=0A=
>> index ec4dba5a4c30..a8e4fe053e7c 100644=0A=
>> --- a/include/trace/events/f2fs.h=0A=
>> +++ b/include/trace/events/f2fs.h=0A=
>> @@ -73,20 +73,6 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);=0A=
>>   			REQ_PREFLUSH | REQ_FUA)=0A=
>>   #define F2FS_BIO_FLAG_MASK(t)	(t & F2FS_OP_FLAGS)=0A=
>>   =0A=
>> -#define show_bio_type(op,op_flags)	show_bio_op(op),		\=0A=
> =0A=
> Could you just replace show_bio_op() with blk_op_str()? it's minor though=
.=0A=
> =0A=
Okay, that also can be done. Will replace it in a next version.=0A=
=0A=
> Thanks,=0A=
> =0A=
>> -						show_bio_op_flags(op_flags)=0A=
>> -=0A=
>> -#define show_bio_op(op)							\=0A=
>> -	__print_symbolic(op,						\=0A=
>> -		{ REQ_OP_READ,			"READ" },		\=0A=
>> -		{ REQ_OP_WRITE,			"WRITE" },		\=0A=
>> -		{ REQ_OP_FLUSH,			"FLUSH" },		\=0A=
>> -		{ REQ_OP_DISCARD,		"DISCARD" },		\=0A=
>> -		{ REQ_OP_SECURE_ERASE,		"SECURE_ERASE" },	\=0A=
>> -		{ REQ_OP_ZONE_RESET,		"ZONE_RESET" },		\=0A=
>> -		{ REQ_OP_WRITE_SAME,		"WRITE_SAME" },		\=0A=
>> -		{ REQ_OP_WRITE_ZEROES,		"WRITE_ZEROES" })=0A=
>> -=0A=
>>   #define show_bio_op_flags(flags)					\=0A=
>>   	__print_flags(F2FS_BIO_FLAG_MASK(flags), "|",			\=0A=
>>   		{ REQ_RAHEAD,		"R" },				\=0A=
>>=0A=
> =0A=
=0A=
