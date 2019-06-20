Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ADBC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AE320B1F
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o4HOg6E9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jPOWOa9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfFTSBt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:01:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63691 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfFTSBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561053709; x=1592589709;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mCG1BCu11vPEqyjCYgmFaAsWlDE0FAyJbcMP7L4eRDg=;
  b=o4HOg6E9DTTLvINKwhttUBDXCjl7yb6fx2k8LKb1a5heKKqjreGhlHd5
   oGKxcUoFt5EVwrDxfHsXbhVGpLLt4SE1GagkoryfAdhxRdzko7Jy1rnwQ
   faglMamY7TDPXp27Ay3flejKgfxtzuhL7TE1KJGEEnevVffz5xmfk6Y+X
   q+0WWNTEIDtEo7znOvbqJgNjxO6ikWznfbt2X363L681DY1wfCGTnzEuB
   A9P9utZ3hVcGjTdlj6SxNTiw+pT7i2M7YF9hyocrpBt8vsiL034YGM9mF
   g1M/YEanQ+T/srliS149sslazULax4ViQplwDoWFAMd5ZzNm4rZSzUZeq
   A==;
X-IronPort-AV: E=Sophos;i="5.63,397,1557158400"; 
   d="scan'208";a="112725827"
Received: from mail-co1nam05lp2056.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.56])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2019 02:01:48 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfCQ6en9EB40GoIh46fx4OXLsSKRtEX+EBd7N8Ih9DM=;
 b=jPOWOa9gnjJYUDU8jDq7bFIRWm8++HL37SfssNIFgUpQYffIXDlUWFBvAlzI3l+MynAfatNyGteM/GJgH5ZW0qnvRD6KqsqepsU25hJ4ad/ikCPlCsQtMnx7HJIXLL7u+P0k4u3t6x4ftLJBjMyAXHHf75cFudnsanxWrOdFozE=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6181.namprd04.prod.outlook.com (20.178.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.16; Thu, 20 Jun 2019 18:01:46 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 18:01:46 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "yuchao0@huawei.com" <yuchao0@huawei.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Re: [PATCH V4 0/5] block: improve print_req_error
Thread-Topic: [PATCH V4 0/5] block: improve print_req_error
Thread-Index: AQHVJsJhvz5rHDoyJ0i4T5ZaSm9GEQ==
Date:   Thu, 20 Jun 2019 18:01:46 +0000
Message-ID: <BYAPR04MB574957D8AE3DB1AAA316361D86E40@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <0ec88bfe-2eb2-bf20-39bc-7f25fabe6ebb@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab5a0beb-4d0d-4d1a-72ae-08d6f5a95c22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6181;
x-ms-traffictypediagnostic: BYAPR04MB6181:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB618141943E18160D6DF34B2D86E40@BYAPR04MB6181.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(71190400001)(53546011)(6306002)(4744005)(8936002)(14454004)(74316002)(186003)(966005)(52536014)(9686003)(229853002)(72206003)(486006)(68736007)(2906002)(73956011)(6246003)(2501003)(55016002)(5660300002)(476003)(66446008)(33656002)(64756008)(66556008)(66066001)(86362001)(478600001)(7696005)(25786009)(76176011)(81156014)(81166006)(7736002)(316002)(53936002)(4326008)(446003)(76116006)(6506007)(8676002)(54906003)(110136005)(3846002)(66476007)(99286004)(102836004)(26005)(6116002)(6436002)(305945005)(256004)(66946007)(71200400001)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6181;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sO4Tm95JFzloAN8cxODz1Uwk3t+w40RsQUaZea2FsUPVWJg670hp5F2xM7/zheR2orqKxBCJlTOnwWbzGEQYupLsvbqFLNLJ/fSBX/6CYhyrjWASjeMFLwBEnR9lO5pFrALpgqrur99zD3Xig7G83lqmW1uSZEErg04EA7mSqFdPl745pMu+zMBLfaSuhPq3jvT3eYmSAcgXy842PMYGylO+tKHkEtioUHNeGvLuuQMK0Mkk2UKnAqfnnPdoBMSN6w+9QBRhxYNf5xpe5GYSdEU4KyEauJJAiyL1IGLJl5xkUVn9J1TQlEvea+r2o6JHXhU2cN0dAjHFBlIFNIc2V//9/q78cZ6jOmTiKjNCoAGBlzAhfQYRNKY9ngvQzGnqxqbpqzhHuCTqF3yp4QNVZ26TvzdVDcpi3ij0PuHM/NI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5a0beb-4d0d-4d1a-72ae-08d6f5a95c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 18:01:46.2054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6181
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/20/2019 12:35 AM, Jens Axboe wrote:=0A=
> On 6/19/19 11:12 AM, Chaitanya Kulkarni wrote:=0A=
>> Hi,=0A=
>>=0A=
>> This patch-series is based on the initial patch posted by=0A=
>> Christoph Hellwig <hch@lst.de>. While debugging the driver and block=0A=
>> layer this print message is very meaningful. Also, we centralize the=0A=
>> REQ_OP_XXX to the string conversion in the blk-core.c so that other=0A=
>> dependent subsystems can use this helper without having to duplicate=0A=
>> the code e.g. f2fs, blk-mq-debugfs.c.=0A=
>>=0A=
>> Please consider this for 5.3.=0A=
>=0A=
> Something is wonky here. For 5.2, I just merged:=0A=
>=0A=
> commit f9bc64a0f0f884036d76d71edeaafb994c5ceddf (origin/for-5.3/block)=0A=
> Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> Date:   Thu Jun 13 07:14:21 2019 -0700=0A=
>=0A=
>      block: use req_op() to maintain consistency=0A=
>=0A=
> and then you go and do something different for 5.3?=0A=
=0A=
I miss something. I just sent a V5 with latest for-next:-=0A=
=0A=
https://www.spinics.net/lists/linux-block/msg41848.html=0A=
=0A=
Please let me know if issue still exists.=0A=
>=0A=
=0A=
