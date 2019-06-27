Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891DAC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531012064A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U3Rc5+ks";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D3Jy04JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF0IRM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:17:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2722 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfF0IRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561623431; x=1593159431;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9LW2iddH+Hkwbl5vW/hBz8K1/P/wsZTCheob9NhNXRo=;
  b=U3Rc5+ksLzyq8BRnlqAnuBAgY90LR3h10Hvu66WIV9Pfvx4g7mmZqUGs
   qU3TGqahWS7T08vkME8wJU4DdovFqZKHGvd1ZL5PNpucezssqTmz849YJ
   kubi7tTSaGLh+6ItDyS03Dsj3pxgzWfg2D71jCBle6hgr3uMV0vG2o39j
   RF3BNQKKWE8jpIkzOxFNa0Bf1QExX26Ob2arIrKhKs+G9dykgSMBv+GWZ
   yI8BuwNBtTUKduhyheT9y855pGdbEJVvLju03qt1uXZrigBW6yMiToq44
   x2Josnl7aQIk74+AUDDf5xafUm2xAQra2B/M2FVA76XozO83ZvOQ4i7H3
   A==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="218046722"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 16:17:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=id3ii2TjDHXZFJpjLtEoej1eMfmGDzkdKcf11YCXoB1w+R7HP0cjYrMEq1LbObPFv/PCYir9A+IWVu8Z2lplUMmBpBIvMxgo3fI+YUzoqNIMPiChyXojLweFhQOVZB97/0hijqxfctdNlltL0rrnmvzpHQRDerITiERfuxSqEs0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo/jhes47rONk5vJ2MP3YcscngwYQPQrCltv0qxzibw=;
 b=iGFkDFXfRIcrn44wz1onp9i97whCTvLF0yRjPjXKj/uR9y4YUIjtYh0oyWZphYHXVKOCSg7GNnGkn5qoHcNEActXGQFhBbBAMAUvyJTMAogw4QLQzh1m44bopiO1iFWCQBHoi3XI8yPFhrK6O7MA2aBLs4Th5z5jQyUb0vwvV7E=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo/jhes47rONk5vJ2MP3YcscngwYQPQrCltv0qxzibw=;
 b=D3Jy04JYMBxxH8S69PDVnS1A8z94mHNb+S9Gd3pIbb+bEqPKWHEQVQ7Yhi8iiQ7x/efQ7O9ngH5ilEIv09UKV8zleqtzcgFEHmaNejFU+Zb2aE4WfxDczIGlIdDuxYFp1lO4sPytsD998uty4dosLjqa0e6YrH6ySTAcT1PqU28=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4279.namprd04.prod.outlook.com (20.176.251.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 08:17:08 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 08:17:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVLJMD9dFUXSCKoEarjaRxND+ocQ==
Date:   Thu, 27 Jun 2019 08:17:08 +0000
Message-ID: <BYAPR04MB581604217983C81B2BA5BA4FE7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
 <20190627024910.23987-2-damien.lemoal@wdc.com>
 <20190627074720.GB24671@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa3d0537-0bf5-4bc3-d432-08d6fad7d907
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4279;
x-ms-traffictypediagnostic: BYAPR04MB4279:
x-microsoft-antispam-prvs: <BYAPR04MB42797175BA548F4741AED486E7FD0@BYAPR04MB4279.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(14444005)(316002)(81166006)(7736002)(81156014)(102836004)(76176011)(52536014)(305945005)(256004)(68736007)(72206003)(53546011)(6916009)(186003)(91956017)(486006)(66066001)(74316002)(8936002)(7696005)(99286004)(26005)(3846002)(229853002)(476003)(6116002)(478600001)(6436002)(446003)(66946007)(5660300002)(55016002)(53936002)(6506007)(71200400001)(71190400001)(14454004)(54906003)(33656002)(86362001)(76116006)(25786009)(66556008)(73956011)(2906002)(64756008)(66446008)(9686003)(66476007)(6246003)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4279;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T3YyWpkFA945h2MkiBoB4d73gaB66dzW/61lxtMiSQloKY96HjlqdcsCrY6zkeJEP0bltGfOsTB5b3AKzMVhhFLXsPfW3nGZxZWILtFSiIc/KUKuwRv+nhRp664CpDQoUiMDmSvZM0mg/McTiOAlrthX3/XmeX7SX5bGanyX0ce7a6rpH+qjQKerldrXg/xh+neRV5u6c4IX0gM8UOPq/iPQvsmP0CzhcboTDt80WK1QYN6hCCTPFYhzZlRilZ7t5WrTmJWjic6In0zKeupIOGD9gSSX2SKxU3QP/JGgMBvSyX5OuZs+ozK4aALDImClbSzE02MG/yswnuCrTjo83bzNM7YfOGSPhgGz6WX4wJtIVE28bft5bhw4RYjN32T/mCQDFr4n3ButUWENOz9F2gYavwfoXckjed8CUVDyZ+0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3d0537-0bf5-4bc3-d432-08d6fad7d907
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:17:08.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4279
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,=0A=
=0A=
On 2019/06/27 16:47, Ming Lei wrote:=0A=
[...]=0A=
>>  static void bio_copy_kern_endio_read(struct bio *bio)=0A=
>>  {=0A=
>> +	unsigned long len =3D 0;=0A=
>>  	char *p =3D bio->bi_private;=0A=
>>  	struct bio_vec *bvec;=0A=
>>  	struct bvec_iter_all iter_all;=0A=
>> @@ -1550,8 +1583,12 @@ static void bio_copy_kern_endio_read(struct bio *=
bio)=0A=
>>  	bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
>>  		memcpy(p, page_address(bvec->bv_page), bvec->bv_len);=0A=
>>  		p +=3D bvec->bv_len;=0A=
>> +		len +=3D bvec->bv_len;=0A=
>>  	}=0A=
>>  =0A=
>> +	if (is_vmalloc_addr(bio->bi_private))=0A=
>> +		invalidate_kernel_vmap_range(bio->bi_private, len);=0A=
>> +=0A=
>>  	bio_copy_kern_endio(bio);=0A=
>>  }=0A=
>>  =0A=
>> @@ -1572,6 +1609,7 @@ struct bio *bio_copy_kern(struct request_queue *q,=
 void *data, unsigned int len,=0A=
>>  	unsigned long kaddr =3D (unsigned long)data;=0A=
>>  	unsigned long end =3D (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;=0A=
>>  	unsigned long start =3D kaddr >> PAGE_SHIFT;=0A=
>> +	bool is_vmalloc =3D is_vmalloc_addr(data);=0A=
>>  	struct bio *bio;=0A=
>>  	void *p =3D data;=0A=
>>  	int nr_pages =3D 0;=0A=
>> @@ -1587,6 +1625,9 @@ struct bio *bio_copy_kern(struct request_queue *q,=
 void *data, unsigned int len,=0A=
>>  	if (!bio)=0A=
>>  		return ERR_PTR(-ENOMEM);=0A=
>>  =0A=
>> +	if (is_vmalloc)=0A=
>> +		flush_kernel_vmap_range(data, len);=0A=
>> +=0A=
> =0A=
> Are your sure that invalidate[|flush]_kernel_vmap_range is needed for=0A=
> bio_copy_kernel? The vmalloc buffer isn't involved in IO, and only=0A=
> accessed by CPU.=0A=
=0A=
Not sure at all. I am a little out of my league here.=0A=
Christoph mentioned that this is necessary.=0A=
=0A=
Christoph, can you confirm ?=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
