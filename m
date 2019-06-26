Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F3DC48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37090208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dSw2nNys";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qBEancK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZUre (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:47:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38096 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582055; x=1593118055;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=X6pfDuQxLGyTYzbBE/v/nSCfsWVpSh1EFqCXGhRLQD8=;
  b=dSw2nNysnBb/dbSUGK/WdiMrKNGZr1+/CrgfD+v+Abl3n4jC2hm+Ekd8
   +YLSHuxskepAIaahFDHfingKQNc19rj4uepcLR1yTMggg9iuuIpXPn3E8
   QjXyq9//H38h/9jykDpiY1SxWWjDyqDMcf3UuqjiN131VZuaGIGp1CX49
   jzz2zsLLmmMHs6JZaPsAuC140kRJPVMt+ef6LXx7WWuTO4D7hJU9yF44x
   CjUxMIXq5WRMHPgKn82rWuee317/L+jXpTu1xy3T1ElnZQ4JGy558Ttgj
   aDZ2ypFtFI9bqCqwRBTxybQqsZ+EdSzNOEzqh4UDsUq3aKWAXuggPeyNK
   g==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="112835601"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:47:35 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLLdREOPGpHymfXW0VdpcyNddzsJ3vWbXTxzN5D3u0Q=;
 b=qBEancK08YfqyPxY5jBL8q9+1k1kmk6FK1ijynsszPkFD+hOR3z/FLshMPnbMWqjd0wYA4VROn0/gUVSFhjE8xtAy8/Bdpg1UyARMx3WbLvBOoL98Fgc/ygdIxVJ+w66fXTd+99nJWM9j5nwgCFDFntJ5x8XZQzuwwWmpWVAiZc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4262.namprd04.prod.outlook.com (20.176.251.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Wed, 26 Jun 2019 20:47:32 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:47:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 5/9] iomap: use bio_release_pages in iomap_dio_bio_end_io
Thread-Topic: [PATCH 5/9] iomap: use bio_release_pages in iomap_dio_bio_end_io
Thread-Index: AQHVLCYNflm7bL9aA0OSmOzTYb9flA==
Date:   Wed, 26 Jun 2019 20:47:32 +0000
Message-ID: <BYAPR04MB57490E050B7BC793164EC61486E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dfc5081-a782-4aa8-27d7-08d6fa7782d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4262;
x-ms-traffictypediagnostic: BYAPR04MB4262:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB42620318692627222FF64BC486E20@BYAPR04MB4262.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:85;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(136003)(396003)(376002)(366004)(199004)(189003)(71190400001)(486006)(6116002)(81166006)(66476007)(99286004)(66556008)(476003)(5660300002)(81156014)(66446008)(66946007)(74316002)(316002)(64756008)(53936002)(52536014)(14454004)(55016002)(68736007)(71200400001)(4326008)(3846002)(9686003)(446003)(72206003)(33656002)(102836004)(110136005)(6436002)(73956011)(7696005)(186003)(478600001)(26005)(229853002)(7736002)(76116006)(6246003)(53546011)(8676002)(2906002)(305945005)(256004)(25786009)(76176011)(86362001)(4744005)(66066001)(8936002)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4262;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NdvV6LY9LakgcmW0AqrSuKTO1b9ZA6vQJTr3KeW3PQqPHPWP9NhzHi2SBfEizoQM/yTotAflcVFFtaRLT1T1MdC23GVt8G57O+a95V0dM2na1J5gqOY45Io2tsOJ5lo36IgdmcfpJOh+sk6pkFmimpq0kuVutHiWiG7MrW4pPCkOQ0z9h0BjyQZDE5HI5g69tRiMzcKi/HkFP6Iywz7G8eE0920tk4tdwTyCkNLAXOyTzbcN5ATWp8Zvmayp3F9n01dID3jd3sCYTwW2kaUnr2eVTHmTv3xpPoDsRxQ7nCqHHn0oFvRQd7S4F+CxpiDAUW8sGbgKZ3F6449wQpXHbT9cKnA2NHKsLazVgMQPKKk5q4gvK4da071YWSJLsMqau7Tf0wKWJ2l8xEAzPVKQALyI1jnt2xdqCMFIaUufsWA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfc5081-a782-4aa8-27d7-08d6fa7782d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:47:32.0844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4262
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/26/2019 06:50 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of duplicating it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   fs/iomap.c | 8 +-------=0A=
>   1 file changed, 1 insertion(+), 7 deletions(-)=0A=
>=0A=
> diff --git a/fs/iomap.c b/fs/iomap.c=0A=
> index 23ef63fd1669..3798eaf789d7 100644=0A=
> --- a/fs/iomap.c=0A=
> +++ b/fs/iomap.c=0A=
> @@ -1595,13 +1595,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)=
=0A=
>   	if (should_dirty) {=0A=
>   		bio_check_pages_dirty(bio);=0A=
>   	} else {=0A=
> -		if (!bio_flagged(bio, BIO_NO_PAGE_REF)) {=0A=
> -			struct bvec_iter_all iter_all;=0A=
> -			struct bio_vec *bvec;=0A=
> -=0A=
> -			bio_for_each_segment_all(bvec, bio, iter_all)=0A=
> -				put_page(bvec->bv_page);=0A=
> -		}=0A=
> +		bio_release_pages(bio, false);=0A=
>   		bio_put(bio);=0A=
>   	}=0A=
>   }=0A=
>=0A=
=0A=
