Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954AFC31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3CD20873
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IAn77VBD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t0GZETEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfFRQFr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:05:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:44629 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbfFRQFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 12:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560873947; x=1592409947;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dop4mvuNv+mjAQqAhlKkMziSyvIlNLtM9vZ+jhyMVp8=;
  b=IAn77VBDL0CUJmhPrWryjMOANx/0I/MmQ6grMkyw4zDe4T47HvHLzp7J
   JOQDbTI8LHxTcccWjEEMvozS8ZkG1r0J9jZt7505gVNiTnqnYT2WV5Rwi
   kjTDzQQtXr9CaLjZADEf3hmlfds/RxurmbtNWaLlZmL5CMZED6HHcFMnw
   nbhXIkeV+YDRpvoi/lbqnvvS9pgRh/0/o/6Zfr9N/2GaQl1ptEeJXEqOc
   sPdansPBVQgjXMlF3is3GnTsDZ7RJHe6SjcU9JBBe2U50dIl8tRoHYBnJ
   ckLpqZ68emjCpX7rRVr25xUUl8hxypiNVUI3NskjzT11ykrqn32YMFPDY
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,389,1557158400"; 
   d="scan'208";a="112116182"
Received: from mail-dm3nam05lp2059.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.59])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 00:05:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQw1fgD4MxLhzheZt1haE0yNSC+CQT0IqxQj/3vZ/Zs=;
 b=t0GZETElDJc/4nQZYE1tRunU/CC644MYF23TlwhAT/aJyNxVFW0bFJGLob+jcbwWotWag44lPdMcSp7clXPEPqfVDwaKAvkcuvtSDosN0SCLWr9nTkANLHuEHq5nfCpu4/K/uxF/ViqJQ9ezOnIbinKrKSzRUzvH2qaKFZzclKI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4693.namprd04.prod.outlook.com (52.135.240.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 18 Jun 2019 16:05:45 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Tue, 18 Jun 2019
 16:05:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>
Subject: Re: [PATCH V3 3/6] block: use blk_op_str() in blk-mq-debugfs.c
Thread-Topic: [PATCH V3 3/6] block: use blk_op_str() in blk-mq-debugfs.c
Thread-Index: AQHVJZiouvHVDcUQSUia9KwHSclqsA==
Date:   Tue, 18 Jun 2019 16:05:45 +0000
Message-ID: <BYAPR04MB57491A3C97DEDCED71E6781B86EA0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190618054224.25985-1-chaitanya.kulkarni@wdc.com>
 <20190618054224.25985-4-chaitanya.kulkarni@wdc.com>
 <9a254a22-8669-1ac4-87ba-71e9a64ad5c0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d213895-e808-4d50-d65d-08d6f406d26c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4693;
x-ms-traffictypediagnostic: BYAPR04MB4693:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4693E35578D92127F737E26986EA0@BYAPR04MB4693.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:192;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(54906003)(478600001)(76176011)(6506007)(71190400001)(8676002)(8936002)(186003)(4326008)(86362001)(486006)(110136005)(81156014)(71200400001)(305945005)(4744005)(476003)(68736007)(25786009)(5660300002)(446003)(52536014)(99286004)(7696005)(6246003)(33656002)(73956011)(72206003)(66946007)(14454004)(53546011)(74316002)(6436002)(2906002)(81166006)(102836004)(53936002)(66066001)(6116002)(2501003)(3846002)(26005)(256004)(7736002)(66476007)(316002)(66446008)(9686003)(55016002)(66556008)(76116006)(229853002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4693;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qD+B4O7CJW7WGh4SUQCnITw0SUZ4fBrEexpKnmRrNpYmTyPAD7gacYoi4zAYJFhqrgRloJQZCq2N3OSbOwWr065+qPS39jMmV2GRGQGv8MXssCVu2I9dx3rcWrbjF4mAGPcT4oJ8kLhAd6X5kBVVdTuKFlvkMkjhAsCyzBdCejgSy62ObjBYTIrvq+nXaN8qeZH/E8oX/zrlxJWVQ/5BHvjK0a+RwSZ983YpJ8t0NxcgLpfBnpOumk4Q7nNtbGPz5sJCHojgRTigsoqOxUNRu4meluSniZ4o2LJXwKrOWs5wCHNHr4p7Tz9pBQRjORlwWTIfmHrtSgT7vBAC/FAqU5HoPmnRXHIlxU10tWNABTBLH9BMA6OydyS1HouQI9L0A4wy5Yun+SpoIhrdrW8A1xu7lEoAh2hrcpdvzDwUflU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d213895-e808-4d50-d65d-08d6f406d26c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 16:05:45.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4693
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/19 8:28 AM, Bart Van Assche wrote:=0A=
> On 6/17/19 10:42 PM, Chaitanya Kulkarni wrote:=0A=
>> +	if (strcmp(op_str, "UNKNOWN") =3D=3D 0)=0A=
>>    		seq_printf(m, "%d", op);=0A=
>> +	else=0A=
>> +		seq_printf(m, "%s", op_str);=0A=
> =0A=
> My opinion about using strcmp() to check whether or not=0A=
> req_opf-to-string conversion succeeded is that this is ugly ...=0A=
> =0A=
I didn't like that either, but I also don't want callers to repeat the =0A=
string "UNKNOWN" or any other error string and return NULL from the=0A=
blk_top_str().=0A=
=0A=
Do you have any suggestion or preference ?=0A=
=0A=
> Bart.=0A=
> =0A=
=0A=
