Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BCC742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4971E21530
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BREfGqR9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CpJacHx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfGLChe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:37:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1376 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfGLChe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562899133; x=1594435133;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EycIbVv2lQ6WnToSgnsueGKGsZQnYgTIzBCGeW6rU+4=;
  b=BREfGqR9f689rc7m80Z4DNDDMLzrdA+fJgIch42wm4xGVBAM1vGGt1lr
   KvF17NWtEGLBIFk5yeI13Y4btptyjuhPlhWgd7BaqZ2MyfvEMaqeqphvf
   Rrgq/GrGtd4AQyBYU4sfAcuJI0jxTE0SXvx3s6dU2B8IkCRxhkuFleFaN
   q66+QdFiFdwYukx/a41LEpI9IU/uWgxsvMTwTsSbtgi+UOg43ytCf0oUo
   TfVn8j7nodkSKeIWVfH8N05oPQ1lmz9dgOpzGKqCGa2wio+nrY2ie7hJD
   iDTI5ECuaghjrmNUfxLxpxYCY87TuEICHsXncZN2r6x0WFV47EVbTpnIx
   Q==;
IronPort-SDR: 0YI+VUYA94tdrNrQgKbO2PyFpxikGN0Tm7XgBZDlpbiegT3BkVduvnrPnALzLE9Ff2p/XCoqFX
 vEwj0EQPB9oppVbTgdnmf1V7z5Xla3wEW9VfwPeJ2807bbB4rEunFpF/C3ZtwbVT66vwAdYLr5
 wG9Z79e2WR+k6hKaY6Jmsrf914Cp0Lhe7q2i4K2DsUICptnH0ZOGuQWzgKmQpe9iCGP+lbi+/p
 pAA/HO0LCi0I0PwyG88maM7vYLopRWrgMahzXrvzcdFZZc6dTJGVubHmFD84bemk5faPHRTVuM
 n7g=
X-IronPort-AV: E=Sophos;i="5.63,480,1557158400"; 
   d="scan'208";a="212780749"
Received: from mail-dm3nam03lp2059.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 10:38:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEg4Kz95Edj/rNhbSJ4YHRSzDHxzqdyrceuwGhl3MAE2dMJ6Y1i7NqOYqcLh4ltbyIrpo8+L0JohUOr43hIAxjH+Nr6pgr1kzq5vOzpxP+wz2geKYVIUw0gAWWeekjwar1eMT/ULsYi+7rbAjMniFxfglb9VoPHbE7JHjywBbNBMb/F4mn2UfAxYULaoDdFvbapKD0c7OiumuFnTVOPUL2GgmE3jXrdY9h/g9RERMVnf91O9qDVH3UtiqcWiv9YwkNRk6SK4jj2ucV4eSPe+DpZqGmHjZuqlQlDSeh6brbVApX1w/mV7HvMnZJOtb2ZjlVEDgSG7MS1ucAI3mK0IGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B56Vg36McHBe62B7ZuWElJW38iO9wXDefSNCKbCA6lA=;
 b=c4byYs/w/dJ7E6KyqJN7X9vJ6n6ex9X8uDn2ZnCjeSDOtJrvVWqidpPQK3LrEVnUoNZEQ/l39PTQRsQ8w3v3dvveL19EYRe8pYjN2HDbEO6S+/N52KrH1ayLmPB+qIPWeCBDxcAon+QTi2QTZsLUdgMUaT9zDPZbD5q5bgtEMetbKZfzeVXN42m2O+t9dSao3UVG50WOVczEw1zr3aCquJYS1w0xu1fn1hghBQjMTL0klcgCZBtnP0XKvtadJdUhE4xC801/anyRg8GEagTzuOeyqunMPGcQ82opkg5XQVSuysKDzYTHGy9+EbG37SKdUeYZVJ02IEAk6CnUa6Cr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B56Vg36McHBe62B7ZuWElJW38iO9wXDefSNCKbCA6lA=;
 b=CpJacHx7E9UyJzdYgtE59cAWUtKbKVynXQvsTqpzA1wS7swJWEkx2lC7huWtzsokiRFEBX41H4C5T7udUuAGZFn/HR0CxjiPKDG0BE9XGzgLCojQhk9NMmubq6+8x8ZACbIEkcIeuOP47M73eiVDSzsiGoDcQ5J01+0dRLSM3ZQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5543.namprd04.prod.outlook.com (20.178.232.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 02:37:29 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 02:37:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: tidy up blk_mq_plug
Thread-Topic: [PATCH] block: tidy up blk_mq_plug
Thread-Index: AQHVN9o+sndcsfGM/ka+J11i8GzIeg==
Date:   Fri, 12 Jul 2019 02:37:29 +0000
Message-ID: <BYAPR04MB5816B7867433C3A946E7411DE7F20@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190711111714.4802-1-hch@lst.de>
 <53c09d04-3f29-2cea-ede4-cdf443539a17@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68fd8341-faa4-4dd2-fff3-08d70671e254
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5543;
x-ms-traffictypediagnostic: BYAPR04MB5543:
x-microsoft-antispam-prvs: <BYAPR04MB5543EB4C03529FAA3D59DDC5E7F20@BYAPR04MB5543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(199004)(189003)(53936002)(446003)(6246003)(305945005)(81166006)(102836004)(5660300002)(81156014)(86362001)(66066001)(4326008)(7736002)(9686003)(229853002)(316002)(6116002)(74316002)(8936002)(256004)(478600001)(52536014)(14444005)(99286004)(53546011)(486006)(7696005)(6506007)(2906002)(26005)(8676002)(76176011)(64756008)(66556008)(66446008)(25786009)(66476007)(6436002)(476003)(91956017)(76116006)(110136005)(3846002)(71200400001)(71190400001)(14454004)(33656002)(68736007)(186003)(55016002)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5543;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4tpOvZWmRCd2sFMkuDqOB26tYOCRozOKmQkvAFj4FO6q+/7GP0VHttRnXkHt8TkRNGPQmPV0yd3/hcKzvW7kNgJTMudHSd8Y42pfoWtoQf77inGj77G7aPwgYu/yvL24XR5SBKHYzkoe9cHB1h99sNY2eAoB2ZbL5xIoDFsnC6Avkl2vT+9GFXxbizn8iWMLYefVTA6ZMXPZQVMRdFFOrQfcT6Sr6WIHq6B9UDzrVuSnrjPQcq0cVVMq1fOhbc3z623Zf5AqF9k0kOcNnzd0VS+H9Vg1jesMeXmKG1AT7vkexX3q6VwgvAPwxfGjCK061u3aH3E6XEiOHInnHEONWcjWfVAbqI5vp8aq3GREU7e4dVdmFrne5v5kgijGAy+KZnVOoWNHmNDdp+hexOBQaig5iqRnsk8aDlzuXQPD5xQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fd8341-faa4-4dd2-fff3-08d70671e254
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 02:37:29.3887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5543
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/07/12 3:09, Jens Axboe wrote:=0A=
> On 7/11/19 5:17 AM, Christoph Hellwig wrote:=0A=
>> Make the zoned device write path the special case and just fall=0A=
>> though to the defaul case to make the code easier to read.  Also=0A=
>> update the top of function comment to use the proper kdoc format=0A=
>> and remove the extra in-function comments that just duplicate it.=0A=
>>=0A=
>> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
>> ---=0A=
>>   block/blk-mq.h | 14 ++++----------=0A=
>>   1 file changed, 4 insertions(+), 10 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-mq.h b/block/blk-mq.h=0A=
>> index 32c62c64e6c2..ab80fd2b3803 100644=0A=
>> --- a/block/blk-mq.h=0A=
>> +++ b/block/blk-mq.h=0A=
>> @@ -233,7 +233,7 @@ static inline void blk_mq_clear_mq_map(struct blk_mq=
_queue_map *qmap)=0A=
>>   		qmap->mq_map[cpu] =3D 0;=0A=
>>   }=0A=
>>   =0A=
>> -/*=0A=
>> +/**=0A=
>>    * blk_mq_plug() - Get caller context plug=0A=
>>    * @q: request queue=0A=
>>    * @bio : the bio being submitted by the caller context=0A=
>> @@ -254,15 +254,9 @@ static inline void blk_mq_clear_mq_map(struct blk_m=
q_queue_map *qmap)=0A=
>>   static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
>>   					   struct bio *bio)=0A=
>>   {=0A=
>> -	/*=0A=
>> -	 * For regular block devices or read operations, use the context plug=
=0A=
>> -	 * which may be NULL if blk_start_plug() was not executed.=0A=
>> -	 */=0A=
>> -	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))=0A=
>> -		return current->plug;=0A=
>> -=0A=
>> -	/* Zoned block device write operation case: do not plug the BIO */=0A=
>> -	return NULL;=0A=
>> +	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))=0A=
>> +		return NULL;=0A=
>> +	return current->plug;=0A=
>>   }=0A=
>>   =0A=
>>   #endif=0A=
> =0A=
> I agree it's more readable, but probably also means that the path that we=
=0A=
> care the least about (zoned+write) is now the inline one.=0A=
=0A=
What about an additional inline function ?=0A=
So something like this is very readable I think and blk_mq_plug() can also =
be=0A=
optimized with #ifdef for the !CONFIG_BLK_DEV_ZONED case.=0A=
=0A=
#ifndef CONFIG_BLK_DEV_ZONED=0A=
static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
  					   struct bio *bio)=0A=
{=0A=
	return current->plug;=0A=
}=0A=
#else=0A=
static inline struct blk_plug *blk_zoned_get_plug(struct request_queue *q,=
=0A=
  						  struct bio *bio)=0A=
{=0A=
	if (op_is_write(bio_op(bio)))=0A=
		return NULL;=0A=
=0A=
	return current->plug;=0A=
}=0A=
=0A=
static inline struct blk_plug *blk_mq_plug(struct request_queue *q,=0A=
  					   struct bio *bio)=0A=
{=0A=
	if (!blk_queue_is_zoned(q))=0A=
		return current->plug;=0A=
=0A=
	return blk_zoned_get_plug(q, bio);=0A=
}=0A=
#endif=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
