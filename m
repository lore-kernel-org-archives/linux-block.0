Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ABAC48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5145208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a+uaxJjK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zWDIy0F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZUrG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:47:06 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:45514 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582025; x=1593118025;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EoBgMn73zttSkYEHxUIOtEcZeU5vVnsGQethK5QYpGw=;
  b=a+uaxJjKH1zLBE3NhvBopUsknCsrexz2FCUrpSEpoFNNURi/zzt0AOfH
   jttYGiJ8nozgoEOiIQKU17XVPxNv89xOaaT9KqOmbEwsFTpcaH1fUygY/
   IDUUPOvkMo50kuMpHI3JMajJqDkCGUwVECgADYGjMQOQST++KlAqqVdH3
   BQ3RrSy/Pib15SUzYMyAeGRLy9JYNdKxy35cbBA5inhZvcbkAFCponzyR
   P3G97c+e0EYGufdtzOSnpX7xEv4DGzAViIaSGJBdLZSoB5/aR+wizc0pq
   gKyIeD65N3JEBBYsTXtMQfpRlTsYz/7UC5jle4xMGOdKnfqPHafZYuEfu
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="218001774"
Received: from mail-by2nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:47:04 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A51PVHSgNfTgGVyhw0rQn9dSqj/JjepIJxj81KQYWok=;
 b=zWDIy0F1oB7Cfm6N49ZiGPb0KLjOTb+Qu5GkNJCUscGKgdf+iLh4p2b5Qf6arsMhvJcQW4BklAm9LY0leAOV1ug/3SFBJMudxbQ3MgY4D2AWvUZA0t0EWOZ54r0jr5zWRTkI4Z/mFlpMfta/BD8dm5Obcrnw2Cxy73PC5u45V3g=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4871.namprd04.prod.outlook.com (52.135.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Wed, 26 Jun 2019 20:47:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:47:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/9] block: use bio_release_pages in bio_unmap_user
Thread-Topic: [PATCH 3/9] block: use bio_release_pages in bio_unmap_user
Thread-Index: AQHVLCYKeBfZ1xLpokefcLd533fxow==
Date:   Wed, 26 Jun 2019 20:47:03 +0000
Message-ID: <BYAPR04MB574991E1F48DBB71554320A186E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c45f971-daa7-43f8-b6f7-08d6fa7771bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4871;
x-ms-traffictypediagnostic: BYAPR04MB4871:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB48718DB625D0E7DFF7B1B96F86E20@BYAPR04MB4871.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(476003)(446003)(64756008)(66476007)(66446008)(66556008)(52536014)(256004)(14444005)(5660300002)(72206003)(2906002)(86362001)(486006)(76116006)(66946007)(73956011)(71190400001)(14454004)(71200400001)(110136005)(3846002)(6116002)(8676002)(81156014)(8936002)(53936002)(316002)(26005)(55016002)(6436002)(66066001)(478600001)(74316002)(99286004)(7696005)(305945005)(7736002)(76176011)(53546011)(6506007)(6246003)(4326008)(33656002)(68736007)(9686003)(102836004)(186003)(229853002)(25786009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4871;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QiHXkNxt8jM0mJD7Vw2JFmmjqgqMPE5vzY0gsTTvg5T9j8I7de75d7GhFFlar3XfW7KII41GUrVplYKIGrhPqQdSrL+OGjfovB+MFu+4csWqzUkkCEsXMoOMhFLVT8nruyLeMKlEPr+AGi7FZMfjVptRSsL72xfbL4nSKc5ROkVff0ywTN58ZXtkgOJ0aVw3hKgD6Ex1Qpe8HAACmQBeCoM7wo5/iIoxhrfL+skFWFiIyVmF/Y0680FfwsJWbJV96JLu86jXnwHQcPb2hV8/Fq2X6T977UrM4QoR34D2QziiiZ1gP3vetZkDsdeaSI4LxixLpM43Vezv2blMVQcKii34PJKdddJ6/rWiQ/OUOw2XG8v2hq9W/GgJXPyssYCCBm7Ab/vuvmGnH3KV0ok6vjVRWeZ+HBmyHIi6gYzZNsA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c45f971-daa7-43f8-b6f7-08d6fa7771bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:47:03.3880
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
On 06/26/2019 06:49 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of open coding it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   block/bio.c | 21 ++-------------------=0A=
>   1 file changed, 2 insertions(+), 19 deletions(-)=0A=
>=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 7f3920b6baca..20a16347bcbb 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -1437,24 +1437,6 @@ struct bio *bio_map_user_iov(struct request_queue =
*q,=0A=
>   	return ERR_PTR(ret);=0A=
>   }=0A=
>=0A=
> -static void __bio_unmap_user(struct bio *bio)=0A=
> -{=0A=
> -	struct bio_vec *bvec;=0A=
> -	struct bvec_iter_all iter_all;=0A=
> -=0A=
> -	/*=0A=
> -	 * make sure we dirty pages we wrote to=0A=
> -	 */=0A=
> -	bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
> -		if (bio_data_dir(bio) =3D=3D READ)=0A=
> -			set_page_dirty_lock(bvec->bv_page);=0A=
> -=0A=
> -		put_page(bvec->bv_page);=0A=
> -	}=0A=
> -=0A=
> -	bio_put(bio);=0A=
> -}=0A=
> -=0A=
>   /**=0A=
>    *	bio_unmap_user	-	unmap a bio=0A=
>    *	@bio:		the bio being unmapped=0A=
> @@ -1466,7 +1448,8 @@ static void __bio_unmap_user(struct bio *bio)=0A=
>    */=0A=
>   void bio_unmap_user(struct bio *bio)=0A=
>   {=0A=
> -	__bio_unmap_user(bio);=0A=
> +	bio_release_pages(bio, bio_data_dir(bio) =3D=3D READ);=0A=
> +	bio_put(bio);=0A=
>   	bio_put(bio);=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
