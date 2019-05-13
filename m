Return-Path: <SRS0=TF98=TN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A8C04AA7
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793A82133F
	for <linux-block@archiver.kernel.org>; Mon, 13 May 2019 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEO5jQ4d";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KFCw2HRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfEMO5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 May 2019 10:57:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25758 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730303AbfEMO5a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 May 2019 10:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557759450; x=1589295450;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ze8+u6IxY0S3zpEOG5oJNtlhq11fMF/aHeFfZPzXjOk=;
  b=XEO5jQ4d2PfRdBsCn0S4G2SabOQClaVVBXNaYd6csG6iKUEBIz3p74Rk
   0v2Z9qtxUvmUjRmvngAyfFRPvMvxOjFFubEBUJlPZKndqux6kl3moS5Op
   ObbnidpylzLbpjBdcMCwqAxpNRJ5Hyw7jDf0sVEmDt3Zc0dR4w3oVA9GD
   jr7iWYZrLw6/JomvzA/MqFYrlOhAUyAmLrNcqV92tMSmfKmat0nqREAjn
   /cLHBIF5FULI20hDm/Y1wW//UQN/QMnHY5GwJwdDHfL6odMLmdd6q9jUv
   KagA28xls6RxKTYpYnFpxETpUzubwCU17n25cFQT5NOj01bIsyTU3hQ9j
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,465,1549900800"; 
   d="scan'208";a="109857463"
Received: from mail-dm3nam05lp2058.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.58])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2019 22:57:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vW4/Vn3U9saCSPyZ/13buuBJwQ9OARp8CHMYwrTITQ=;
 b=KFCw2HRnWS4ZxfpWUhGD91xpTkbIs6f6oHND35mb448TOpIE4b0yxxBzA8Yx5Ke245e7fyIkz1/2d8RH/Izi3NSUXrgt2aRFke3nVOEG13twZKaX7rWEDimXjPqyCgRzHgM1u7KeHFmI1DRVzNFpRV6zwkmsyjp3iKjdXDTyTQY=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4847.namprd04.prod.outlook.com (52.135.122.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 14:57:26 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 14:57:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 10/10] block: mark blk_rq_bio_prep as inline
Thread-Topic: [PATCH 10/10] block: mark blk_rq_bio_prep as inline
Thread-Index: AQHVCVaSKYir9/j2C0GP52kCPLyopQ==
Date:   Mon, 13 May 2019 14:57:26 +0000
Message-ID: <SN6PR04MB45278876D87AE2259FFEA61F860F0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7643e2c-98e5-4150-20db-08d6d7b3506a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4847;
x-ms-traffictypediagnostic: SN6PR04MB4847:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4847BBE5717B8E8C0B2B12B7860F0@SN6PR04MB4847.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(68736007)(7696005)(8936002)(71200400001)(6246003)(81166006)(26005)(446003)(71190400001)(81156014)(316002)(66066001)(102836004)(305945005)(53936002)(53546011)(6506007)(229853002)(7736002)(6436002)(8676002)(5660300002)(66946007)(73956011)(91956017)(66476007)(66556008)(64756008)(66446008)(256004)(52536014)(76176011)(14444005)(99286004)(76116006)(3846002)(186003)(72206003)(478600001)(74316002)(2906002)(9686003)(33656002)(4326008)(55016002)(14454004)(2501003)(476003)(25786009)(486006)(86362001)(6116002)(54906003)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4847;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RYX5PViO9QZpqA565WKuNThukZzQqaUrrzkxi74GDz8xhdkSr3ynKJw2V/Sup8C3FmEO3qmOYKBWq/wOFYWSuvpSskCWzHSK2YfxxHxSkoNxuXdpRRmIJOwJUTmztipzsduUCgufq9Tnr6buLb7bvg8AiA78BDE+mO7fWRHCcPODiE9auoeC7kewoffvXcvyLMK5z8tstMC2kQlqHYiZ8fEHKPWBEmpWicG3sWZPHXFftB4l1JzB4yzP7ulQycxwPSP53teku4//tM6L6dpX/7ThvJbURlbQalDhiWG1hbi2W4wumrePTw8lkmlBKjxAZS+xCteJQPhcjVF4iHCaskHzS3CSn6nPQz+hS3SnaM1s8J6qhI9yrPESrs0L7OwNzivGk/WEJ5KY/UzG1PBozROl4gv2tYmIT/7LTvPal5o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7643e2c-98e5-4150-20db-08d6d7b3506a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 14:57:26.6533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4847
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 05/12/2019 11:39 PM, Christoph Hellwig wrote:=0A=
> This function just has a few trivial assignments, has two callers with=0A=
> one of them being in the fastpath.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/blk-core.c | 11 -----------=0A=
>   block/blk.h      | 13 ++++++++++++-=0A=
>   2 files changed, 12 insertions(+), 12 deletions(-)=0A=
>=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index c894c9887dca..9405388ac658 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1473,17 +1473,6 @@ bool blk_update_request(struct request *req, blk_s=
tatus_t error,=0A=
>   }=0A=
>   EXPORT_SYMBOL_GPL(blk_update_request);=0A=
>=0A=
> -void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int n=
r_segs)=0A=
> -{=0A=
> -	rq->nr_phys_segments =3D nr_segs;=0A=
> -	rq->__data_len =3D bio->bi_iter.bi_size;=0A=
> -	rq->bio =3D rq->biotail =3D bio;=0A=
> -	rq->ioprio =3D bio_prio(bio);=0A=
> -=0A=
> -	if (bio->bi_disk)=0A=
> -		rq->rq_disk =3D bio->bi_disk;=0A=
> -}=0A=
> -=0A=
>   #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE=0A=
>   /**=0A=
>    * rq_flush_dcache_pages - Helper function to flush all pages in a requ=
est=0A=
> diff --git a/block/blk.h b/block/blk.h=0A=
> index 5352cdb876a6..cbb0995ed17e 100644=0A=
> --- a/block/blk.h=0A=
> +++ b/block/blk.h=0A=
> @@ -51,7 +51,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct re=
quest_queue *q,=0A=
>   void blk_free_flush_queue(struct blk_flush_queue *q);=0A=
>=0A=
>   void blk_exit_queue(struct request_queue *q);=0A=
> -void blk_rq_bio_prep(struct request *rq, struct bio *bio, unsigned int n=
r_segs);=0A=
>   void blk_freeze_queue(struct request_queue *q);=0A=
>=0A=
>   static inline void blk_queue_enter_live(struct request_queue *q)=0A=
> @@ -100,6 +99,18 @@ static inline bool bvec_gap_to_prev(struct request_qu=
eue *q,=0A=
>   	return __bvec_gap_to_prev(q, bprv, offset);=0A=
>   }=0A=
>=0A=
> +static inline void blk_rq_bio_prep(struct request *rq, struct bio *bio,=
=0A=
> +		unsigned int nr_segs)=0A=
> +{=0A=
> +	rq->nr_phys_segments =3D nr_segs;=0A=
> +	rq->__data_len =3D bio->bi_iter.bi_size;=0A=
> +	rq->bio =3D rq->biotail =3D bio;=0A=
> +	rq->ioprio =3D bio_prio(bio);=0A=
> +=0A=
> +	if (bio->bi_disk)=0A=
> +		rq->rq_disk =3D bio->bi_disk;=0A=
> +}=0A=
> +=0A=
>   #ifdef CONFIG_BLK_DEV_INTEGRITY=0A=
>   void blk_flush_integrity(void);=0A=
>   bool __bio_integrity_endio(struct bio *);=0A=
>=0A=
=0A=
