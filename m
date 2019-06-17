Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A6CC31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3382208C4
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RFmbQPmv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zlFP1/oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfFQQt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:49:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36824 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQQt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 12:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560790197; x=1592326197;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1W8pjlZR14jPwee7nFIznQKT4xIfoDw7SpD1ol6jnzw=;
  b=RFmbQPmvzKaElw5tFXSVO8ebWeZ0GE+jnnX6s0+2cteR8yGb/li+j/K7
   K5JAajDz3sDf1AktyZrEhpwqBOyRSlz5xsWvDBP2K0PQPRBNix557gJui
   LUEjO+9phtN0+ygl4hIofWgRGMaHI3m6Eb0uzcR1Nezy966LpckuR5Csm
   ijnz/CXyXwO/yr3Z0Nn6ETMzpC51CVY6k34gVq0XjKLeUUr6Hzkn+aapq
   p7V4jOI/JotfeX26vSw9veK4jYLuTEClQ7hT6CCAIHYsP88VbnrywJQ/8
   RIabZnx6Vd7rJNmPMLlI7flmDiA82NG5RNc2T2QeHsmGysURxBagM+feV
   A==;
X-IronPort-AV: E=Sophos;i="5.63,385,1557158400"; 
   d="scan'208";a="217136522"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2019 00:49:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcoFB9rNik/C2U38XpyRkNklm3KzY8QNHsEtQRXTzoI=;
 b=zlFP1/ooiWwVbsDIF5ipY3Y0EQYOadCVuousMOL7OYBGrh29bIHEHjqLc1aEVKcXwbASG9WK/tRDQ3rezNqX/hEQyON6Xy21ysT8UMLaWXz2jpdiKMu4FBe+esM7KkBKX7wpq/LHu/SfAH2N74m0lXowcUe/nOJYni4wXkWhMLs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5862.namprd04.prod.outlook.com (20.179.59.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 16:49:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.1987.012; Mon, 17 Jun 2019
 16:49:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "hare@suse.com" <hare@suse.com>
Subject: Re: [PATCH 1/2] block: improve print_req_error
Thread-Topic: [PATCH 1/2] block: improve print_req_error
Thread-Index: AQHVIJCX2rejujWcBk2aIc3GgGPYwQ==
Date:   Mon, 17 Jun 2019 16:49:55 +0000
Message-ID: <BYAPR04MB5749F0648B6E2390E5436AE086EB0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190611200210.4819-1-chaitanya.kulkarni@wdc.com>
 <20190611200210.4819-2-chaitanya.kulkarni@wdc.com>
 <321f98fe-eb76-cdcb-5917-32d27f12d3d6@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562a8ab6-ceb8-4fda-e8fe-08d6f343d3a1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5862;
x-ms-traffictypediagnostic: BYAPR04MB5862:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB586294F30C51D4A8024AF54A86EB0@BYAPR04MB5862.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(68736007)(66066001)(5660300002)(2906002)(3846002)(486006)(446003)(6436002)(25786009)(476003)(81156014)(110136005)(64756008)(7736002)(6116002)(55016002)(9686003)(53936002)(478600001)(71200400001)(53546011)(71190400001)(102836004)(6506007)(74316002)(52536014)(86362001)(14444005)(316002)(76176011)(7696005)(4326008)(256004)(99286004)(229853002)(305945005)(6246003)(54906003)(26005)(66556008)(66446008)(8936002)(33656002)(8676002)(66476007)(2501003)(14454004)(186003)(72206003)(73956011)(66946007)(81166006)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5862;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SrmuVTlisVOKZHBUvHWy0YDG59fXRUUQyC0h5TMfmlll9P/ujr4Zfw5giNaZq8Is862qweCum289+2Y3VPjWVhL4XETyi6HGigfq9Ejlw63WRHtWaflA3jSvLx9ymaitz9MDZxrgZW4+FOWeJL3+1MKABuU5hAameHrRNTX15+yG7PLiaOlGqHA5aiyJPqHphOXBFWiBkLimgWf6wBRLpNyeJh+H1BeEAwLUoobPocnafJGH0JhQcPmWYaS9F0/24RN7n3gjoo7puRPOTrDf6Ze+uH7EZqzKkwG1oMYXlk2UtrBgdSWOrrEpaRHkEs1Y+/t5YPW+uYq86o+wDUURmsjUx5UY8EglTZ5KNW21p3sX2KlHxGpjLk5QrZCepgWHr0ds3lnYDU6T2Z4qV2xaI3iFoT0f/BdGBvuQzZeYboc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a8ab6-ceb8-4fda-e8fe-08d6f343d3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 16:49:55.6556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5862
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06/17/2019 01:43 AM, Hannes Reinecke wrote:=0A=
> On 6/11/19 10:02 PM, Chaitanya Kulkarni wrote:=0A=
>> From: Christoph Hellwig <hch@lst.de>=0A=
>>=0A=
>> Print the calling function instead of print_req_error as a prefix, and=
=0A=
>> print the operation and op_flags separately instead of the whole field.=
=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>   block/blk-core.c | 16 +++++++++-------=0A=
>>   1 file changed, 9 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>> index ee1b35fe8572..d1a227cfb72e 100644=0A=
>> --- a/block/blk-core.c=0A=
>> +++ b/block/blk-core.c=0A=
>> @@ -167,18 +167,20 @@ int blk_status_to_errno(blk_status_t status)=0A=
>>   }=0A=
>>   EXPORT_SYMBOL_GPL(blk_status_to_errno);=0A=
>>=0A=
>> -static void print_req_error(struct request *req, blk_status_t status)=
=0A=
>> +static void print_req_error(struct request *req, blk_status_t status,=
=0A=
>> +		const char *caller)=0A=
>>   {=0A=
>>   	int idx =3D (__force int)status;=0A=
>>=0A=
>>   	if (WARN_ON_ONCE(idx >=3D ARRAY_SIZE(blk_errors)))=0A=
>>   		return;=0A=
>>=0A=
>> -	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %=
x\n",=0A=
>> -				__func__, blk_errors[idx].name,=0A=
>> -				req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
>> -				(unsigned long long)blk_rq_pos(req),=0A=
>> -				req->cmd_flags);=0A=
>> +	printk_ratelimited(KERN_ERR=0A=
>> +		"%s: %s error, dev %s, sector %llu op 0x%x flags 0x%x\n",=0A=
>> +		caller, blk_errors[idx].name,=0A=
>> +		req->rq_disk ?  req->rq_disk->disk_name : "?",=0A=
>> +		blk_rq_pos(req), req_op(req),=0A=
>> +		req->cmd_flags & ~REQ_OP_MASK);=0A=
>>   }=0A=
>>=0A=
>>   static void req_bio_endio(struct request *rq, struct bio *bio,=0A=
>> @@ -1360,7 +1362,7 @@ bool blk_update_request(struct request *req, blk_s=
tatus_t error,=0A=
>>=0A=
>>   	if (unlikely(error && !blk_rq_is_passthrough(req) &&=0A=
>>   		     !(req->rq_flags & RQF_QUIET)))=0A=
>> -		print_req_error(req, error);=0A=
>> +		print_req_error(req, error, __func__);=0A=
>>=0A=
>>   	blk_account_io_completion(req, nr_bytes);=0A=
>>=0A=
>>=0A=
> I did ask this already, but didn't get an answer:=0A=
> Why do we have the __func__ argument?=0A=
> Can it print anything else than 'blk_update_request' ?=0A=
> If so, can't it be dropped?=0A=
Thanks for looking into this. The caller argument I think is useful for =0A=
future use if this function gets called from different places.=0A=
=0A=
Are you okay with that ?=0A=
=0A=
>=0A=
> Cheers,=0A=
>=0A=
> Hannes=0A=
>=0A=
=0A=
