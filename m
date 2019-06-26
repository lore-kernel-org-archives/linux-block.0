Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B68C48BD6
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2387E208E3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KRcaV16a";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EROz2C1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZUsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:48:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53617 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZUsv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561582131; x=1593118131;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6cuSelYHlZJGInOs0BTtT6qIQnob9DrlZxwhn5cR+xk=;
  b=KRcaV16aZSbUPOyz6oUvceawkqVijF4e3KwR+cBU2jrH85Xg66NMWkYH
   cqeV2plrZqTzkuDXmcDd4h5DS4M0wHAP3npEHKV8OMIf2FulXQGJNiaj2
   ZuhwTd+NtFpCJUipFDdo8MT3wtosLg2wbi65GmrrfvfDaBb9ZiSa9h+ko
   quqzfcXstJ6GCOa4yLdIzZ0X+gBpINFfaHDO4+0Ee/U15NixUoTz0zI+o
   PvttdojE3Fck2W7ZClPWDbHcQb7VVgD5MxQ2fmKm/Ipqu4YFGhXTHk5ZH
   OoZ51bfxP23v0yKwpEhq2CmZUmmOkECbVA7/UKSr0aFy3Yj3KBq5vW9T0
   A==;
X-IronPort-AV: E=Sophos;i="5.63,421,1557158400"; 
   d="scan'208";a="113253036"
Received: from mail-by2nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 04:48:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXpq/lnpsiAIH9RfBl6uObhFMXPxq2qVuKeEUBEarCA=;
 b=EROz2C1p0HrIS10FVnb7d76oezdPcHfffeS2oVyGVD6eRcOUQ0axfRkBAjS2CfXn1Vm5ARKfZfIiwlXapCLKfi0Xq41W4+PyOYmkuEq/CFap9ld259RVyqv6yMD/oBkRNvasvXPFczB8yr1fF69ea6JWNTf/lZg8HV5NZQGeyCM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4871.namprd04.prod.outlook.com (52.135.232.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.18; Wed, 26 Jun 2019 20:48:49 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 20:48:49 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 7/9] block_dev: use bio_release_pages in bio_unmap_user
Thread-Topic: [PATCH 7/9] block_dev: use bio_release_pages in bio_unmap_user
Thread-Index: AQHVLCYMRy8tjBMptUSc5MDiyKnotQ==
Date:   Wed, 26 Jun 2019 20:48:49 +0000
Message-ID: <BYAPR04MB5749F0F2BD004C7571E4E26886E20@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190626134928.7988-1-hch@lst.de>
 <20190626134928.7988-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be21ea06-5253-4d80-1f3c-08d6fa77b0dd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4871;
x-ms-traffictypediagnostic: BYAPR04MB4871:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB48711F59480855FF9401810686E20@BYAPR04MB4871.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(376002)(396003)(189003)(199004)(476003)(446003)(64756008)(66476007)(66446008)(66556008)(52536014)(256004)(14444005)(5660300002)(72206003)(2906002)(86362001)(486006)(76116006)(66946007)(73956011)(71190400001)(14454004)(71200400001)(110136005)(3846002)(6116002)(8676002)(81156014)(8936002)(53936002)(316002)(26005)(55016002)(6436002)(66066001)(478600001)(74316002)(99286004)(7696005)(305945005)(7736002)(76176011)(53546011)(6506007)(6246003)(4326008)(33656002)(68736007)(9686003)(102836004)(186003)(229853002)(25786009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4871;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lcVI9Bj8xcVt8TtfNc5Lma7H5VPGTRqvG3X30onjGEquCbKjNQFmE7Mv9leYOzOmdcVufnj1ivA6905KlqKDfo+5mccx5PlyjH0L7To3HAbgz8vp+w4TVTyLx0fd961yjtakb0SseTbFwQX+Oj8nFnU+7Uj+cMlYvXILKjV54wGEeq791dQO7dqDAAf4t3qT+SXBDGPBrmByx0XO7XpWSdrlCgYko8PQDADbOPVuGwhojDzwYSgveD+UwvKEnQI0iCIiXDptdy2p0YDZcj/aADBr+5351GPXjzi9Oitg2yRnqAiwemO2NFHbNwUIqzu9P6QDomPnAFIDCPAKU9mLXV3dS6eO7qNZgsJBOxJSyefcYiwkOOtG8Rb5jbcz6TDf/mnYdsgTGYeDXblESWOwr53GAzYzuNB7rUP77mTUd1Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be21ea06-5253-4d80-1f3c-08d6fa77b0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 20:48:49.2938
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
On 06/26/2019 06:50 AM, Christoph Hellwig wrote:=0A=
> Use bio_release_pages instead of duplicating it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>   fs/block_dev.c | 11 ++---------=0A=
>   1 file changed, 2 insertions(+), 9 deletions(-)=0A=
>=0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index a6572a811880..f00b569a9f89 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -203,13 +203,12 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struc=
t iov_iter *iter,=0A=
>   {=0A=
>   	struct file *file =3D iocb->ki_filp;=0A=
>   	struct block_device *bdev =3D I_BDEV(bdev_file_inode(file));=0A=
> -	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs, *bvec;=0A=
> +	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;=0A=
>   	loff_t pos =3D iocb->ki_pos;=0A=
>   	bool should_dirty =3D false;=0A=
>   	struct bio bio;=0A=
>   	ssize_t ret;=0A=
>   	blk_qc_t qc;=0A=
> -	struct bvec_iter_all iter_all;=0A=
>=0A=
>   	if ((pos | iov_iter_alignment(iter)) &=0A=
>   	    (bdev_logical_block_size(bdev) - 1))=0A=
> @@ -259,13 +258,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct=
 iov_iter *iter,=0A=
>   	}=0A=
>   	__set_current_state(TASK_RUNNING);=0A=
>=0A=
> -	bio_for_each_segment_all(bvec, &bio, iter_all) {=0A=
> -		if (should_dirty && !PageCompound(bvec->bv_page))=0A=
> -			set_page_dirty_lock(bvec->bv_page);=0A=
> -		if (!bio_flagged(&bio, BIO_NO_PAGE_REF))=0A=
> -			put_page(bvec->bv_page);=0A=
> -	}=0A=
> -=0A=
> +	bio_release_pages(&bio, should_dirty);=0A=
>   	if (unlikely(bio.bi_status))=0A=
>   		ret =3D blk_status_to_errno(bio.bi_status);=0A=
>=0A=
>=0A=
=0A=
