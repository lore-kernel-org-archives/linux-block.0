Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583ABC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210802064A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 08:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="POQzWKvN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rnR9H/O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfF0IO7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:14:59 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44269 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0IO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561623299; x=1593159299;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NSydXb5ZgDl/kBCPFcS/Q/syWEKV2Fw6sHwFEMC5ZSU=;
  b=POQzWKvN39QVVbpFntV3BXCwrwGIh4ejV6iXfR2lzPdOFxVcN+rwYtYK
   O2aQ71NyLa7mUK1mxlJbYUxrTE1nqoQ4qRzGGMawxj/qOGaFVB5/7/gfe
   USVax9gXmkkKiSAxYZymycYecWdCaRyDNgqmva9VBOMnlwY4CojoGrhMZ
   CMeIeFi5zHcuRVXmfgWIcdZWeEAie4WmjzmA+4MdFaYkpOl/FulKbn1eS
   uJZ9cp7KpMeWFmNWTA9hEQs4ssrQj7zcoPiddld9NzgRqA+dX20dqceJ8
   BUbQVJnl1Cg3qPrWFYZecz+tVBF4KyuOXHbD6EzozwWsG3yHUOiFu4iky
   w==;
X-IronPort-AV: E=Sophos;i="5.63,423,1557158400"; 
   d="scan'208";a="113297686"
Received: from mail-co1nam03lp2055.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 16:14:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=ZD3NHb48ZHCu5tpfxTpvLGWcfXTjzacAdUHxHtRmTQzXl1rVK4+2V6gIuNqjMOSnAPjKzYdsO96q2EoP8xxQiUqlj+tGDTIdhPZmPhcFQWjUgMBgqfaeqgVrCALmvGPoUxXE4gGkLnUwC4Q8M62Mxgww9lBOtPzljb8y6OWfVUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efec09yEukizbIoYE3/0gnMl6dK7jI5m0a2wO/yUm8c=;
 b=kDiPlvOHN/JLtDvoLoCgIJUp3nB7XU9BZdIHhnALRYhttSTL5d5UkYOqEvNov6id2zjF7wWL1tTYD34xzNUZssZSrKCmweZthSGazo+2+8mDwOp/D7/weqshBGYlyLs3p6JXPrxW7rpVHqd1lz6cD4pF9jd3Xl4JwrLKCCLrd18=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Efec09yEukizbIoYE3/0gnMl6dK7jI5m0a2wO/yUm8c=;
 b=rnR9H/O0cJJxM5uT4WaudcNSi5Zb3UIv20DXqb5VJHqlVOnyj1dhAnvgUWiHLaBwRQ393RIa+Z/hnqa8YhZWudJ1RFeDPvIKvj468nrw6P1xjXpDeuVdilWhJcR7V5CuOXd2WI7An0Va242DiYvT8IZD90tywAk2grpzHyHlPAI=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4279.namprd04.prod.outlook.com (20.176.251.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 08:14:56 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 08:14:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Topic: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Thread-Index: AQHVLJMD9dFUXSCKoEarjaRxND+ocQ==
Date:   Thu, 27 Jun 2019 08:14:56 +0000
Message-ID: <BYAPR04MB581674B8668D6F3015C5C0C6E7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627024910.23987-1-damien.lemoal@wdc.com>
 <20190627024910.23987-2-damien.lemoal@wdc.com> <20190627072800.GA9949@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d69f6f7-d32e-4bf8-c167-08d6fad78a68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4279;
x-ms-traffictypediagnostic: BYAPR04MB4279:
x-microsoft-antispam-prvs: <BYAPR04MB4279F882E1493DB452A5BB27E7FD0@BYAPR04MB4279.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(396003)(346002)(199004)(189003)(14444005)(316002)(81166006)(7736002)(81156014)(102836004)(76176011)(52536014)(305945005)(256004)(68736007)(72206003)(53546011)(6916009)(186003)(91956017)(486006)(66066001)(74316002)(8936002)(7696005)(99286004)(26005)(3846002)(229853002)(476003)(6116002)(478600001)(6436002)(446003)(66946007)(5660300002)(55016002)(53936002)(6506007)(71200400001)(71190400001)(14454004)(54906003)(33656002)(86362001)(76116006)(25786009)(66556008)(73956011)(2906002)(64756008)(66446008)(9686003)(66476007)(6246003)(8676002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4279;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5mQQmzrVw7FEdZCqoDbiwQHT/PC5Dz177FhfmizLE+qFhFRj3kvjyAvyZkPQbyifRPKxMHf6Hjuc8punC0yTfUGHTogYiEcUQF7IkngRpDp8/41hYuE6y9h3tTw0yw3s47NBy+vclYkrHRVtDT5CWpKUwICBUBieoKsxktZwdGKL1TpxaP7PBYFyFXdMXVe1W7+W/W4jbwvqHbMaBzYGAv97K364gQYk7nspqINoA/09BwUZNKHvYrBUg9aZflngednu+ILS+TVxcuoB+mlin8phlR+Njv/WZOgelEZqnRVbwzUCsoD0iD8TQ1KatHRWQaJ7FpELvi1uVDqnOCADYaEwywkbkcEo0fVJXD1YKBTefJt4CWuaU9zQGImQPo4L53UZs2dbBtKsHqnoNN65u9P6zkqjhu1SVXqWZuLpNWQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d69f6f7-d32e-4bf8-c167-08d6fad78a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 08:14:56.5798
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

Christoph,=0A=
=0A=
On 2019/06/27 16:28, Christoph Hellwig wrote:=0A=
>> +#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE=0A=
> =0A=
> That seems like an odd constructu, as you don't call=0A=
> flush_kernel_dcache_page.  From looking whoe defines it it seems=0A=
> to be about the right set of architectures, but that might be=0A=
> by a mix of chance and similar requirements for cache flushing.=0A=
=0A=
This comes from include/linux/highmem.h:=0A=
=0A=
#ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE=0A=
static inline void flush_kernel_dcache_page(struct page *page)=0A=
{=0A=
}=0A=
static inline void flush_kernel_vmap_range(void *vaddr, int size)=0A=
{=0A=
}=0A=
static inline void invalidate_kernel_vmap_range(void *vaddr, int size)=0A=
{=0A=
}=0A=
#endif=0A=
=0A=
which I guessed is for the architectures that do not need the flush/invalid=
ate=0A=
vmap functions. I copied. Is there a better way ? The point was to avoid do=
ing=0A=
the loop on the bvec for the range length on architectures that have an emp=
ty=0A=
definition of invalidate_kernel_vmap_range().=0A=
=0A=
> =0A=
>> +static void bio_invalidate_vmalloc_pages(struct bio *bio)=0A=
>> +{=0A=
>> +	if (bio->bi_private) {=0A=
>> +		struct bvec_iter_all iter_all;=0A=
>> +		struct bio_vec *bvec;=0A=
>> +		unsigned long len =3D 0;=0A=
>> +=0A=
>> +		bio_for_each_segment_all(bvec, bio, iter_all)=0A=
>> +			len +=3D bvec->bv_len;=0A=
>> +             invalidate_kernel_vmap_range(bio->bi_private, len);=0A=
> =0A=
> We control the bio here, so we can directly iterate over the=0A=
> segments instead of doing the fairly expensive bio_for_each_segment_all=
=0A=
> call that goes to each page and builds a bvec for it.=0A=
=0A=
OK. Got it. Will update it.=0A=
=0A=
> =0A=
>> +	struct page *page;=0A=
>>  	int offset, i;=0A=
>>  	struct bio *bio;=0A=
>>  =0A=
>> @@ -1508,6 +1529,12 @@ struct bio *bio_map_kern(struct request_queue *q,=
 void *data, unsigned int len,=0A=
>>  	if (!bio)=0A=
>>  		return ERR_PTR(-ENOMEM);=0A=
>>  =0A=
>> +	if (is_vmalloc) {=0A=
>> +		flush_kernel_vmap_range(data, len);=0A=
>> +		if ((!op_is_write(bio_op(bio))))=0A=
>> +			bio->bi_private =3D data;=0A=
>> +	}=0A=
> =0A=
> We've just allocate the bio, so bio->bi_opf is not actually set at=0A=
> this point unfortunately.=0A=
=0A=
OK. I will move the check to the completion path then.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
