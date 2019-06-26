Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF81C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C733208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hPQk/JUm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NOSrKCat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfFZUtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:49:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53649 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUtV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582161; x=1593118161;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gs2HdD93z6eypP85UTaiPP6eQ5ncyTNIYBVGtaHR5qY=;
  b=hPQk/JUmwV1EBK6KcUP0mZjz9DGZxBkS/bn+25Gne5crwVitcYGSAYJF
   A/XawZdlvUhKtnYmLGn4FOGDJw5wiuJUL/AtHfA/EiwSjmt6DEjMZIvLQ
   R+MUBvtiAHuHY5jX1xlYQlACwBOEjPQSbCuCRdsM5kNpyOnGb70awD3pL
   KCLR1UORhV7UtqwJl2l/3ZpfEksek0K/LuW+zN9zi0qzsOIALbEsD0Xev
   ASyxG3Ai4yRVY/i/I0DtN1IE0Q5R144Q449OggnAR76YBNtCPhnyPJsUF
   jwZnFLspJctCFS+3pRVqPXoADag8zGUqZHUAkep82Gbj8yBTmJtFuDoxb
   w==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="113253060"
Received: from mail-by2nam01lp2058.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.58])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:49:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6StwYSGTkqkZuyJKVMOtDIMsuLgiLl+jLx1AiPBFhs=;
 b=NOSrKCatosZnKbbCr06E4zovs9vLOsW9gZnDQ/oMZBEfLqBzRTh8RLKvejP7sm3P6l3Vf2qGS5j6nRyCaNFmf1q5b61u5XOVa+jn6T6ze3ZkdmozUBo/JFm9+plGMYCKvHCHUPb18heLhh0M5uYmVO7x0OW1IH6qgehjS275UWc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4871.namprd04.prod.outlook.com (52.135.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Wed, 26 Jun 2019 20:49:20 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:49:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 8/9] direct-io: use bio_release_pages in dio_bio_complete
Thread-Topic: [PATCH 8/9] direct-io: use bio_release_pages in dio_bio_complete
Thread-Index: AQHVLCYLoeF3BnfBn0+uKXqk4B4iUg==
Date:   Wed, 26 Jun 2019 20:49:19 +0000
Message-ID: <BYAPR04MB574916B80B494EAA7AB8F2F086E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b7f5ea7-d6b3-43c0-c4c4-08d6fa77c317
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4871;
x-ms-traffictypediagnostic: BYAPR04MB4871:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB4871C06853DD296E99EDB38F86E20@BYAPR04MB4871.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:85;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(476003)(446003)(64756008)(66476007)(66446008)(66556008)(52536014)(256004)(14444005)(5660300002)(72206003)(2906002)(86362001)(486006)(76116006)(66946007)(73956011)(71190400001)(14454004)(71200400001)(110136005)(3846002)(6116002)(8676002)(81156014)(8936002)(53936002)(316002)(26005)(55016002)(6436002)(66066001)(478600001)(74316002)(99286004)(7696005)(305945005)(7736002)(76176011)(53546011)(6506007)(6246003)(4326008)(33656002)(68736007)(9686003)(102836004)(186003)(229853002)(25786009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4871;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6v/lntNrHgI758iXdHLa3O/V0ijfU99rLe0VHqSyVgOfYKK1I6QqmP6o6t4P+OCIrimchcgf55LvDL3ZcOoaUKhL7khirFYyag3WTuT+nNp1FRIYrBQH5aewAGjE0ZFQimuYins28Z3OhihI4Ltb+qHhcRsQsDWIVH21w4BZDSv8yioXr/lIW2cRcfLbibAtnIuuo3wLfNfygxC8kcXBwz2+pNtmrgZ5W1d6iQk4cp9TIeuABi3369xIFMoW4HSxqkhhqfV1WafysFSS4P6weqvo9NwpP5xi1NY4L9sPAVsgnu9rB75iMzcUZDRlah9JWlIG82G0OLYIbWiIEMxjcOK4x+fWEk0UMVD2zUV1sMFnIkIYt0iNeIYc64U94Txm2EhOesB8jxk+0prIMs2GBy9vJUmtvgbLnVTv55dlxwc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7f5ea7-d6b3-43c0-c4c4-08d6fa77c317
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:49:19.8452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/26/2019 06:49 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of duplicating it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   fs/direct-io.c | 15 +++------------=0A=
>   1 file changed, 3 insertions(+), 12 deletions(-)=0A=
>=0A=
> diff --git a/fs/direct-io.c b/fs/direct-io.c=0A=
> index ac7fb19b6ade..ae196784f487 100644=0A=
> --- a/fs/direct-io.c=0A=
> +++ b/fs/direct-io.c=0A=
> @@ -538,8 +538,8 @@ static struct bio *dio_await_one(struct dio *dio)=0A=
>    */=0A=
>   static blk_status_t dio_bio_complete(struct dio *dio, struct bio *bio)=
=0A=
>   {=0A=
> -	struct bio_vec *bvec;=0A=
>   	blk_status_t err =3D bio->bi_status;=0A=
> +	bool should_dirty =3D dio->op =3D=3D REQ_OP_READ && dio->should_dirty;=
=0A=
>=0A=
>   	if (err) {=0A=
>   		if (err =3D=3D BLK_STS_AGAIN && (bio->bi_opf & REQ_NOWAIT))=0A=
> @@ -548,19 +548,10 @@ static blk_status_t dio_bio_complete(struct dio *di=
o, struct bio *bio)=0A=
>   			dio->io_error =3D -EIO;=0A=
>   	}=0A=
>=0A=
> -	if (dio->is_async && dio->op =3D=3D REQ_OP_READ && dio->should_dirty) {=
=0A=
> +	if (dio->is_async && should_dirty) {=0A=
>   		bio_check_pages_dirty(bio);	/* transfers ownership */=0A=
>   	} else {=0A=
> -		struct bvec_iter_all iter_all;=0A=
> -=0A=
> -		bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
> -			struct page *page =3D bvec->bv_page;=0A=
> -=0A=
> -			if (dio->op =3D=3D REQ_OP_READ && !PageCompound(page) &&=0A=
> -					dio->should_dirty)=0A=
> -				set_page_dirty_lock(page);=0A=
> -			put_page(page);=0A=
> -		}=0A=
> +		bio_release_pages(bio, should_dirty);=0A=
>   		bio_put(bio);=0A=
>   	}=0A=
>   	return err;=0A=
>=0A=
=0A=
