Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD2DC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 12:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689A320811
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 12:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Mf8lhOxE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WZ1FL10i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfDXMj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:39:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24558 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbfDXMj7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 08:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556109600; x=1587645600;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PYgoV/Ftt/cO4rciq0T9+5/mdJFdtFUZy6sCW3a6X0Y=;
  b=Mf8lhOxEn+B+hV2yiaQF0GejSGntImcgdz87Jl0LAzbN8o75zCS03Wiv
   d8mwNkBFfDiumsXDzX+zb1+gC+ZiKOYPZ47sKTZuEYmMPBjhfIGbGSH4E
   Jze49UPAB7TLaMO7LGNGdWGcCkfw9/c1ROLDnTRAPGIXuKKA5J5in+3sd
   uuwEE/M4MN8GqRwhXF/9y/r32rVeR5xX51NjW3Mqd8VIIYKQlsS/6ynAn
   qCH4yvJQ7dCtzMbaVbdjgRkQckHrPo75byfxIB1MBj6GMa/bg/9RHDeBO
   gS8vY0H7Qa1730aWkbRIK+WWv35VcPn/Y76bthrowZAYINMx76ctRiLnD
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,389,1549900800"; 
   d="scan'208";a="107911274"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2019 20:39:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLSfZ1Yk/nvsIAtLZ0apX/nu3Qvm1QarQfVv+0Zntq8=;
 b=WZ1FL10iODRDl72B2kq1RFw5fmXzJy9Ok6YyJ3FxqXrwfG1qwjAQxrgmYFmozbdelYzGKWokgWm8bkqSy8i8qcKpiD3fscEmgg4iQWpoZGCHx4y9MwkLVFtlDKyyZooUtBS/jUVcWlpOUyghbbsk9qK8y0xsug9+azyZQx4fvpM=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4174.namprd04.prod.outlook.com (52.135.71.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 12:39:57 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 12:39:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't run get_page() on pages from non-bvec iov
 iter
Thread-Topic: [PATCH] block: don't run get_page() on pages from non-bvec iov
 iter
Thread-Index: AQHU+o0lzFae7tbbS0qOoUAUtaA/0w==
Date:   Wed, 24 Apr 2019 12:39:57 +0000
Message-ID: <SN6PR04MB4527E1AAB13EEC9B8F2B86AB863C0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190424110146.17343-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92846d89-e262-42ba-9b5e-08d6c8b1f56b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4174;
x-ms-traffictypediagnostic: SN6PR04MB4174:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4174611ADD7BD97E0CB628F7863C0@SN6PR04MB4174.namprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(256004)(4744005)(74316002)(316002)(14444005)(8936002)(81156014)(25786009)(81166006)(68736007)(66476007)(71200400001)(71190400001)(76116006)(91956017)(64756008)(66946007)(66556008)(66446008)(52536014)(73956011)(4326008)(305945005)(7736002)(8676002)(478600001)(6246003)(86362001)(6436002)(9686003)(14454004)(72206003)(55016002)(53936002)(5660300002)(102836004)(6116002)(6506007)(486006)(186003)(53546011)(229853002)(2906002)(33656002)(54906003)(66066001)(110136005)(26005)(99286004)(7696005)(476003)(97736004)(446003)(3846002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4174;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rR54Q78rjp0BOypug3ktIG6U+67S8FFff9SC/dwZ7ln/C8FTgKQUwk5bZHeX7g4XEHh+x1udFR3f9KffUPfMLsbz2E97EeOAkUoIojZzMX9udLtQOHp24FAbbjqFR8CdFPG6Qw+MrTTZ9GpGH5djNpd0ETIiTkwTT5fOKSJGYf34VHp8yPcbqpZOOHmzh/Z0bYEmECgqNrwjdkkEJr+nG/MWGmNLkimbUU7RLvi4loN4Js9PWlUYUyWDhPvuCy2Q1g6xZMGgpTCepkKHt2k/1iYJt16ASqaN/aT6LgBPzCd2w4khwqa4A0QKyaQbdBw+tjMWrojXTtUJvP5s0FbFukCsXhJqmdMpH523rCcsoZR1DojyanIgXR9SlYZB5COCk9OpmN9ti/8qmRmHleByyc1VOYKTKJP3yV60LVloILc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92846d89-e262-42ba-9b5e-08d6c8b1f56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 12:39:57.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4174
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 4/24/19 4:02 AM, Ming Lei wrote:=0A=
> The refcount has been increased for pages retrieved from non-bvec iov ite=
r=0A=
> via __bio_iov_iter_get_pages(), so don't need to do that again.=0A=
> =0A=
> Otherwise, IO pages are leaked easily.=0A=
> =0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Fixes: 7321ecbfc7cf ("block: change how we get page references in bio_iov=
_iter_get_pages")=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>   block/bio.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index c81ed2dfee53..662d45752ec5 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -992,7 +992,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct io=
v_iter *iter)=0A=
>   =0A=
>   	if (iov_iter_bvec_no_ref(iter))=0A=
>   		bio_set_flag(bio, BIO_NO_PAGE_REF);=0A=
> -	else=0A=
> +	else if (is_bvec)=0A=
>   		bio_get_pages(bio);=0A=
>   =0A=
>   	return bio->bi_vcnt ? 0 : ret;=0A=
> =0A=
=0A=
