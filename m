Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A76C4332D
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0365229C4
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 05:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbhAZFe2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:34:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46002 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbhAZEHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 23:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611635096; x=1643171096;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=75EWzitCAhirnnHX2bEPuxX1yHDuwmbd6nzgXNFEyUo=;
  b=Ijj1gIAjYDV84gO4G19vsQOqda1SXrReJ/mNkAtHHcUCUQcc8zKN3E1U
   LGKFTWof3ljwAqwXQTHGgHWu4YEu3nuX/7RNRJ0InYYN6fjNDo1un/WAx
   SggAVdWpfu2puHx9dMUwfLJA8ZoDLB/FGDUOiOH3Dxq+Ae/TYbV+ac+/Z
   Dh9Ii0G+VjpnlJropCPHFB40+nIY2HO2FKWRCuTcHYxeEBg6Tj0Nwm2O9
   h+j4l5F1zdCPIcnJq+tDF0nVqi83J1C4rLHwmzptj45japkgUqPjXuj9f
   E/HasdKuNIBIwCRX77qGhtYGaJXhez8wtqVdcmirxlPUxmhTdODqsuO4R
   w==;
IronPort-SDR: faXCfuO4aAyrsAYCq5MEyZDSAqop/qy5+ddUn2WytQbTFP6HbaoFPOU5TOQwonEH0H66lpXaRm
 1V7K+7xr5ULW4IRc22Y5j5JwtHCksrpJ6ZC1ntt/BhlHGoaaZyoT8RAhIHemX5igRW9sgnA68V
 HlpA5LCIYh4a/5IoyxMpuqVx7yLfXCOCOD3ttF+gMugTEITI9nRVCgaXGaALSqS2ecKOMUvZCt
 wAiY/cfW2DGxvZNm9adWa7m+F5FeymFz5qXUff91jedniJ+7ue1ygCXqlQmpHVLNndW7NNcCER
 6IU=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="262326073"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 12:23:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KANNtLdX0U/CtPdV2RGYkJzNW+gKw5iknbcfCGUOVnoSuUEUWGVKALvXns+9jB8bF6XgoVtFh5ssIVp3PorNbiCu5NQ/FCARlcsIAY/eQmlKI9t3sYsdH/gcCMaRhoi3VEDuRoNQB7Q79VdIRdLLkY2+n0kTStkqVoCs2k+l7mH6X6DnAt/RP6oSA1Ub/ElZ69pTppCZ1RrzDn++z0LO4SCDJqUUxyLzP7xv7Ow1N52zuaDjtsTGvTk7hSrhx0pvfvNkue9ySqsaukGPLKEtmScq4PW7lhJybwqA2Er+YUn0xC6yy54lEgFNrfrz2QkZCTOHLsVwbRighKdme/aH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37IfArR9fxJ+s5cHhUeAaatpKoVYcQSnLk5z+FWtLtE=;
 b=gh+5XzaM3s1abkHWMdw2DrWUurbqsBS98gfY/L2B3wb6jN+GSwE4upg3KvVtPJo/QcDJZm+2P0m93poCp279X+OvPU1W2UceOFfpNjmEAKx9lfu81IDvvzTT7gh14eoknOsAjFbr5Frr9lguR6NLADl4xfWNykoP1HO6Wdk3hAPcePzZVhvuduCieDm2u1v44lIcOWmSgsJNYln5tYcj7WOf+F7ntjeM+dWi3vBz5pbqVCm3ZUuXMhPqkJgOV3E8lbr5d0LWQSX6Z9us/uxfIXTpejsSb1VY9cR+5S2x93oxZFioJ7iHPBVFJdLcqfXjc9Jyvvl9elxJJfLW7BtJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37IfArR9fxJ+s5cHhUeAaatpKoVYcQSnLk5z+FWtLtE=;
 b=wOb0QLpIciw9X2olbFCUGkT+IN/O+V7F71B08XN8+X66+TeWHyL1IPxSLdOh1JhoG90ld2bRmwISYiqeGsdq+vDInSgkepYlvF1t0VWMz0G9IqipKMB5odPrpGbL60fghmGt59h01B7AXrRJ+Cza49CSKhEbJkfR2Wjgvhu2M2o=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4610.namprd04.prod.outlook.com (2603:10b6:208:26::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Tue, 26 Jan
 2021 04:06:06 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 04:06:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>,
        Changheun Lee <nanich.lee@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Thread-Topic: [PATCH v3 1/2] bio: limit bio max size
Thread-Index: AQHW84VRloabNXvGbkml+gtfdHfb2g==
Date:   Tue, 26 Jan 2021 04:06:06 +0000
Message-ID: <BL0PR04MB65143B60B6062996764423C3E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347@epcas1p2.samsung.com>
 <20210126013235.28711-1-nanich.lee@samsung.com>
 <20210126035748.GA1071341@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4080feb-7e04-47a9-ab94-08d8c1afb4b3
x-ms-traffictypediagnostic: BL0PR04MB4610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB46106489CC2C5BB82B195645E7BC9@BL0PR04MB4610.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3VyhekfJO3sDDXGE1j2ndHizvA1j5vMUx1wsgbLqR4KY1kJgCybtGETZuxL7zcX0ocmfwOkMzLJqlyo6l/rWnzNj2PETbbIcRlBz38NLDY/nYBa0XCW/+H1OGzBJ6zJIS6zC9MXo7K5nxLNgxg9wNNBmN2IJpOwFd9B/7j4GPB09MqzSIaLHQJaKkpI+VuadPt525eoLKWfQwVq5wu8WHPBmVLWyHM5ajQa7bmoJTPuxUPKpwkDuW3TaX8b2wWo2Q65g7zdp7c1Fqcm1ICg2AjX8HM47dpTCf8ReFf9eC/4tgJ/lxmUrxdFL3F44G2/fg9EICPb4osT7nPDNF8bxTANGK+2uxppvOgSmh5PxuO0tfid8t49+yY2cLKxCYB+QLsE5kORLVnuXdCxhBoknGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(66446008)(4326008)(7416002)(7696005)(86362001)(5660300002)(8936002)(71200400001)(9686003)(186003)(316002)(64756008)(55016002)(53546011)(6506007)(83380400001)(66946007)(54906003)(2906002)(478600001)(66476007)(76116006)(91956017)(33656002)(110136005)(8676002)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8KJ76M5dHIgoDIeZTM7dbRwJhZKP7iz3pCUyoNLBLy0Y0BQRd9Wdo1FRjI+m?=
 =?us-ascii?Q?2h+51r4tY/V3yRBQKWYCqXnRfUSNk5254oNjqBSeadddyHgNIrI6f6mCg53h?=
 =?us-ascii?Q?ioZoNB3Buuf/GX0OJpFUWYmB0f4AcCmQi0fYkDGQyvuPkWYRP/UM5785kRdV?=
 =?us-ascii?Q?Kzf7ve6/q0Ifentu8cB33smCBRbbCQ6LWR7QCAVQ9OCUisWCr6pyugVgEHlI?=
 =?us-ascii?Q?PfNGEvhPV2umjDQIyr3h0Q1aeuOe7N+KGN35tbmaPhOdGzy/GojEkHNeL2/C?=
 =?us-ascii?Q?NVqghwaWlqTuBMn5WGQQcGnl6xZuS84P1tZG05Xk37Ws0dyfHcljlNakI1SF?=
 =?us-ascii?Q?dNGop2YVzfdUatB2jOcDhRQUaPiUg2ePxCvkmHatfiGAkk2wBbuoKNKNe4E5?=
 =?us-ascii?Q?3BSWfDkvTxUSPsqESrTIFc95a38TwwZrH+N/HpdSHixE8yJbwQHKLi14e/xI?=
 =?us-ascii?Q?hARXODgyp7KWdI4hBMTufhrSF7MlIfodqK6DQNdBSguYmcscl+rUkPfo478X?=
 =?us-ascii?Q?moncxvKDkmqFsZa+e7ujXV292ysS9+aOon1hQPJZyOga01GLiGbbnLsKfzsQ?=
 =?us-ascii?Q?UdkeYrbb05R2TFfY+9qNjnrYCsm/vHQOS+wcqyH+qiAN+/Zwki2JTQeLgpVk?=
 =?us-ascii?Q?0yu9tcEM+xzhUhXZvmv6aXt3VVeO/v4FDdpeupO9g50Qn9i/EvAhJdlqhd/k?=
 =?us-ascii?Q?UUMpGN1WeDnc7koGbOh5N7OLvrJ1toaRQn8AyK8Xn9tkoOHeTQ6HxSVfw/cl?=
 =?us-ascii?Q?NndxRJ4Z6l/EIwadb8N1Q+6+hq0hko9W6/vGpi/8Hpqpc/0bip1aWIwO+lkd?=
 =?us-ascii?Q?PQZkj/bwHrm5Yg7USDjHvU9VZscmCRoyldaIScx3kb5GrMZz9ufa0AAZjd0I?=
 =?us-ascii?Q?Nlum0uhIM4OxiwzVLuJ6wi4MezybvG32oXmB9YqCrOCehL0zEl1T/DsKZFBR?=
 =?us-ascii?Q?30W21urcTc1UaZ/gwNC2mS9SNR/0Y2O4nGEApacq0Y0rz9onJ62iTy+Zw2em?=
 =?us-ascii?Q?Yw2lGFq1bZSaY769b4cGlpgeUFCgdo0YeIrDEq3yfT9C1FGj7RiTxQbpwDVF?=
 =?us-ascii?Q?pc/aTSKI1mnM7GEFm7iWsl77gUyKbnO5hQXjzJ2OQN+KPIscsmMjB0+KDYno?=
 =?us-ascii?Q?hCHHJJ2CNN7hcpfjCyisb86y7UUhqNhDNA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4080feb-7e04-47a9-ab94-08d8c1afb4b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 04:06:06.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: siaVA2kWAOz3g/JpkmKlmGTuBF6h6bcVnplaMEd3xgYPpo8Dh24Q315Gjmdr5Gl47T2VtVW59lRSz01gY9wMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4610
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/26 12:58, Ming Lei wrote:=0A=
> On Tue, Jan 26, 2021 at 10:32:34AM +0900, Changheun Lee wrote:=0A=
>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>> but sometimes it would lead to inefficient behaviors.=0A=
>> in case of large chunk direct I/O, - 32MB chunk read in user space -=0A=
>> all pages for 32MB would be merged to a bio structure if the pages=0A=
>> physical addresses are contiguous. it makes some delay to submit=0A=
>> until merge complete. bio max size should be limited to a proper size.=
=0A=
>>=0A=
>> When 32MB chunk read with direct I/O option is coming from userspace,=0A=
>> kernel behavior is below now. it's timeline.=0A=
>>=0A=
>>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>>  | total elapsed time is over 2ms.=0A=
>>  |------------------ ... ----------------------->|=0A=
>>                                                  | 8,192 pages merged a =
bio.=0A=
>>                                                  | at this time, first b=
io submit is done.=0A=
>>                                                  | 1 bio is split to 32 =
read request and issue.=0A=
>>                                                  |--------------->=0A=
>>                                                   |--------------->=0A=
>>                                                    |--------------->=0A=
>>                                                               ......=0A=
>>                                                                    |----=
----------->=0A=
>>                                                                     |---=
------------>|=0A=
>>                           total 19ms elapsed to complete 32MB read done =
from device. |=0A=
>>=0A=
>> If bio max size is limited with 1MB, behavior is changed below.=0A=
>>=0A=
>>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>>  | total 32 bio will be made.=0A=
>>  | total elapsed time is over 2ms. it's same.=0A=
>>  | but, first bio submit timing is fast. about 100us.=0A=
>>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>>       | 256 pages merged a bio.=0A=
>>       | at this time, first bio submit is done.=0A=
>>       | and 1 read request is issued for 1 bio.=0A=
>>       |--------------->=0A=
>>            |--------------->=0A=
>>                 |--------------->=0A=
>>                                       ......=0A=
>>                                                  |--------------->=0A=
>>                                                   |--------------->|=0A=
>>         total 17ms elapsed to complete 32MB read done from device. |=0A=
>>=0A=
>> As a result, read request issue timing is faster if bio max size is limi=
ted.=0A=
>> Current kernel behavior with multipage bvec, super large bio can be crea=
ted.=0A=
>> And it lead to delay first I/O request issue.=0A=
>>=0A=
>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>> ---=0A=
>>  block/bio.c            | 17 ++++++++++++++++-=0A=
>>  include/linux/bio.h    |  4 +++-=0A=
>>  include/linux/blkdev.h |  3 +++=0A=
>>  3 files changed, 22 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index 1f2cc1fbe283..ec0281889045 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *tabl=
e,=0A=
>>  }=0A=
>>  EXPORT_SYMBOL(bio_init);=0A=
>>  =0A=
>> +unsigned int bio_max_size(struct bio *bio)=0A=
>> +{=0A=
>> +	struct request_queue *q;=0A=
>> +=0A=
>> +	if (!bio->bi_disk)=0A=
>> +		return UINT_MAX;=0A=
>> +=0A=
>> +	q =3D bio->bi_disk->queue;=0A=
>> +	if (!blk_queue_limit_bio_size(q))=0A=
>> +		return UINT_MAX;=0A=
>> +=0A=
>> +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;=0A=
>> +}=0A=
>> +EXPORT_SYMBOL(bio_max_size);=0A=
>> +=0A=
>>  /**=0A=
>>   * bio_reset - reinitialize a bio=0A=
>>   * @bio:	bio to reset=0A=
>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pa=
ge *page,=0A=
>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>  =0A=
>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>>  				*same_page =3D false;=0A=
>>  				return false;=0A=
>>  			}=0A=
> =0A=
> So far we don't need bio->bi_disk or bio->bi_bdev(will be changed in=0A=
> Christoph's patch) during adding page to bio, so there is null ptr=0A=
> refereance risk.=0A=
> =0A=
>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>> index 1edda614f7ce..cdb134ca7bf5 100644=0A=
>> --- a/include/linux/bio.h=0A=
>> +++ b/include/linux/bio.h=0A=
>> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>>  	return NULL;=0A=
>>  }=0A=
>>  =0A=
>> +extern unsigned int bio_max_size(struct bio *);=0A=
>> +=0A=
>>  /**=0A=
>>   * bio_full - check if the bio is full=0A=
>>   * @bio:	bio to check=0A=
>> @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsigne=
d len)=0A=
>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>  		return true;=0A=
>>  =0A=
>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>>  		return true;=0A=
>>  =0A=
>>  	return false;=0A=
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>> index f94ee3089e01..3aeab9e7e97b 100644=0A=
>> --- a/include/linux/blkdev.h=0A=
>> +++ b/include/linux/blkdev.h=0A=
>> @@ -621,6 +621,7 @@ struct request_queue {=0A=
>>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */=0A=
>>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active=
 */=0A=
>>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */=0A=
>> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */=0A=
>>  =0A=
>>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=0A=
>>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\=0A=
>> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag, =
struct request_queue *q);=0A=
>>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)=0A=
>>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->q=
ueue_flags)=0A=
>>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_fla=
gs)=0A=
>> +#define blk_queue_limit_bio_size(q)	\=0A=
>> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)=0A=
> =0A=
> I don't think it is a good idea by adding queue flag for this purpose,=0A=
> since this case just needs to limit bio size for not delay bio submission=
=0A=
> too much, which is kind of logical thing, nothing to do with request queu=
e.=0A=
> =0A=
> Just wondering why you don't take the following way:=0A=
> =0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 99040a7e6656..35852f7f47d4 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1081,7 +1081,7 @@ static int __bio_iov_append_get_pages(struct bio *b=
io, struct iov_iter *iter)=0A=
>   * It's intended for direct IO, so doesn't do PSI tracking, the caller i=
s=0A=
>   * responsible for setting BIO_WORKINGSET if necessary.=0A=
>   */=0A=
> -int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)=0A=
> +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, bool =
sync)=0A=
>  {=0A=
>  	int ret =3D 0;=0A=
>  =0A=
> @@ -1092,12 +1092,20 @@ int bio_iov_iter_get_pages(struct bio *bio, struc=
t iov_iter *iter)=0A=
>  		bio_set_flag(bio, BIO_NO_PAGE_REF);=0A=
>  		return 0;=0A=
>  	} else {=0A=
> +		/*=0A=
> +		 * Don't add too many pages in case of sync dio for=0A=
> +		 * avoiding delay bio submission too much especially=0A=
> +		 * pinning user pages in memory isn't cheap.=0A=
> +		 */=0A=
> +		const unsigned int max_size =3D sync ? (1U << 12) : UINT_MAX;=0A=
=0A=
4KB max bio size ? That is a little small :)=0A=
In any case, I am not a fan of using an arbitrary value not related to the=
=0A=
actual device characteristics. Wouldn't it be better to us the device=0A=
max_sectors limit ? And that limit would need to be zone_append_max_sectors=
 for=0A=
zone append writes. So some helper like Changheun bio_max_size() may be use=
ful.=0A=
=0A=
Apart from this point, I like your approach.=0A=
=0A=
> +=0A=
>  		do {=0A=
>  			if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=0A=
>  				ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
>  			else=0A=
>  				ret =3D __bio_iov_iter_get_pages(bio, iter);=0A=
> -		} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));=0A=
> +		} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0) &&=0A=
> +				bio->bi_iter.bi_size < max_size);=0A=
>  	}=0A=
>  =0A=
>  	/* don't account direct I/O as memory stall */=0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 6f5bd9950baf..0d1d436aca17 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -246,7 +246,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct =
iov_iter *iter,=0A=
>  	bio.bi_end_io =3D blkdev_bio_end_io_simple;=0A=
>  	bio.bi_ioprio =3D iocb->ki_ioprio;=0A=
>  =0A=
> -	ret =3D bio_iov_iter_get_pages(&bio, iter);=0A=
> +	ret =3D bio_iov_iter_get_pages(&bio, iter, true);=0A=
>  	if (unlikely(ret))=0A=
>  		goto out;=0A=
>  	ret =3D bio.bi_iter.bi_size;=0A=
> @@ -397,7 +397,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  		bio->bi_end_io =3D blkdev_bio_end_io;=0A=
>  		bio->bi_ioprio =3D iocb->ki_ioprio;=0A=
>  =0A=
> -		ret =3D bio_iov_iter_get_pages(bio, iter);=0A=
> +		ret =3D bio_iov_iter_get_pages(bio, iter, is_sync);=0A=
>  		if (unlikely(ret)) {=0A=
>  			bio->bi_status =3D BLK_STS_IOERR;=0A=
>  			bio_endio(bio);=0A=
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
> index ea1e8f696076..5105982a9bf8 100644=0A=
> --- a/fs/iomap/direct-io.c=0A=
> +++ b/fs/iomap/direct-io.c=0A=
> @@ -277,7 +277,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, =
loff_t length,=0A=
>  		bio->bi_private =3D dio;=0A=
>  		bio->bi_end_io =3D iomap_dio_bio_end_io;=0A=
>  =0A=
> -		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter);=0A=
> +		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter,=0A=
> +				is_sync_kiocb(dio->iocb));=0A=
>  		if (unlikely(ret)) {=0A=
>  			/*=0A=
>  			 * We have to stop part way through an IO. We must fall=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index bec47f2d074b..c95ac37f9305 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -690,7 +690,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  	if (iocb->ki_flags & IOCB_DSYNC)=0A=
>  		bio->bi_opf |=3D REQ_FUA;=0A=
>  =0A=
> -	ret =3D bio_iov_iter_get_pages(bio, from);=0A=
> +	ret =3D bio_iov_iter_get_pages(bio, from, is_sync_kiocb(iocb));=0A=
>  	if (unlikely(ret))=0A=
>  		goto out_release;=0A=
>  =0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 676870b2c88d..fa3a503b955c 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -472,7 +472,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		unsigned int len, unsigned int off, bool *same_page);=0A=
>  void __bio_add_page(struct bio *bio, struct page *page,=0A=
>  		unsigned int len, unsigned int off);=0A=
> -int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);=0A=
> +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, bool =
sync);=0A=
>  void bio_release_pages(struct bio *bio, bool mark_dirty);=0A=
>  extern void bio_set_pages_dirty(struct bio *bio);=0A=
>  extern void bio_check_pages_dirty(struct bio *bio);=0A=
> =0A=
> =0A=
> Thanks,=0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
