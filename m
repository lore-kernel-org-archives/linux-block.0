Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B81DC04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 17:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37F920645
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 17:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IT+XvVu6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G0JkotvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfEQRSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 13:18:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46043 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQRSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 13:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558113647; x=1589649647;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NdFyt+l8AuQ3dCodl1+fvySzA+CxM+1g4NNFgbhg51w=;
  b=IT+XvVu6C+Z/sjUhZbJiFiXcPbquSJCRZMXcebrv+peL/yHX3SzmZCqb
   WMZTn11cgZhyPRxxOfhsASSy0m8Ro6mXngYAu1iZSsHgT4VapWh1v/gme
   SQUrB0oebxcPueeiB+NpdrzNs4HO6fHbtWdZyWD1MNwYP0mzsh4yvI/t6
   br3FINHSks3SBlzuSTqD1DUjaZPiGaQE0KMLMEikHte8S8xki7lViR+f5
   ojyVZ4GbY9b9EBa0ZnWvZTkdquWyUn7RJ4bNkslO8AywtzB2DdbaSMLlF
   PABUvnmnlvSBkjB/rRQTCQyd5deJOS5IHMJxfMrykx4MdDrAVTzjU9Hux
   A==;
X-IronPort-AV: E=Sophos;i="5.60,480,1549900800"; 
   d="scan'208";a="207967387"
Received: from mail-co1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.50])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2019 01:20:46 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+YMwT8MTy1zCqspQ24w68OqHsq84oBmn9S2QNUGaaw=;
 b=G0JkotvAlUKT96qRVOeKefq6+6mCSo5fV1vk0TZg6gO5I2rXH8IEU3J0fmfACtiuGmF3MaYYXX2orJer4+8BNMmAAG+AOKMCHCYn2LheZg7QdFJEZOXumUrZw/RE/FfI6MzzKbrmzOoF/boiO2wQ1CWCu2RpNNBqnyfvacD3Xb0=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3870.namprd04.prod.outlook.com (52.135.81.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 17:18:05 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::b163:e740:af6e:2602%6]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 17:18:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     xiaolinkui <xiaolinkui@kylinos.cn>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: bio: use struct_size() in kmalloc()
Thread-Topic: [PATCH] block: bio: use struct_size() in kmalloc()
Thread-Index: AQHVDJFi2AQuSKSW70u18m79g25Ygg==
Date:   Fri, 17 May 2019 17:18:05 +0000
Message-ID: <SN6PR04MB452786C2CE869D353697B9A7860B0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:80ac:e3f3:7436:d81d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fe9fa13-2046-43c4-2c63-08d6daeba031
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3870;
x-ms-traffictypediagnostic: SN6PR04MB3870:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB38703003ACD13BECBD9466AC860B0@SN6PR04MB3870.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(396003)(346002)(376002)(39860400002)(199004)(189003)(6246003)(8936002)(76116006)(91956017)(52536014)(14454004)(305945005)(54906003)(446003)(53936002)(53546011)(76176011)(2501003)(7736002)(110136005)(86362001)(6506007)(68736007)(2906002)(5660300002)(7696005)(99286004)(316002)(8676002)(72206003)(186003)(6436002)(102836004)(478600001)(71190400001)(9686003)(71200400001)(486006)(256004)(25786009)(66556008)(66946007)(73956011)(64756008)(4326008)(6116002)(74316002)(66446008)(46003)(55016002)(81166006)(81156014)(229853002)(476003)(66476007)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3870;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AufexaxGDfmEV8cvbfrQ89fNjyIt0RDVFeI2hrejJrVN0wZb5qpp0DT4AwKTyXldvOK4oJjGsvsA5ungDoGdFoveRZ+h3xNch44TWahPl838KPzL40HzY03RwglnNiT1KAvvA8zfwkFCzgjsn+Qn218OxyCHFvt2fesVV8Hy4IqNEYaNHQgGJsHQeqrr74LexqYJdkMDVP12glEH8HxpsPJy74tEmC1DAtrr7+3T4LNFJkLReivLLJ5hl2s+Ggi0nbH5SNQJxU2LIZbQ1AVGPsLTpnnVM0oyGdTb70+RuHsLy8WLS2Ib6Qw7OPjAzMdwV0JthWmAKFjJG3wQ3oDEtjKzl9lmIqe3aqY8/Y5GK3PdK9q8PtXu3TmFno0dnpYL5QHqsUFLULvBpLC8lOkVVmzgUfaTYpMcEuB5aZc4Frg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe9fa13-2046-43c4-2c63-08d6daeba031
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 17:18:05.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3870
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 5/17/19 2:17 AM, xiaolinkui wrote:=0A=
> One of the more common cases of allocation size calculations is finding=
=0A=
> the size of a structure that has a zero-sized array at the end, along=0A=
> with memory for some number of elements for that array. For example:=0A=
>=0A=
> struct foo {=0A=
>     int stuff;=0A=
>     struct boo entry[];=0A=
> };=0A=
>=0A=
> instance =3D kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP=
_KERNEL);=0A=
>=0A=
> Instead of leaving these open-coded and prone to type mistakes, we can=0A=
> now use the new struct_size() helper:=0A=
>=0A=
> instance =3D kmalloc(struct_size(instance, entry, count), GFP_KERNEL);=0A=
>=0A=
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>=0A=
> ---=0A=
>  block/bio.c | 7 ++-----=0A=
>  1 file changed, 2 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 683cbb4..847ac60 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -436,9 +436,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned=
 int nr_iovecs,=0A=
>  		if (nr_iovecs > UIO_MAXIOV)=0A=
>  			return NULL;=0A=
>  =0A=
> -		p =3D kmalloc(sizeof(struct bio) +=0A=
> -			    nr_iovecs * sizeof(struct bio_vec),=0A=
> -			    gfp_mask);=0A=
> +		p =3D kmalloc(struct_size(bio, bi_io_vec, nr_iovecs), gfp_mask);=0A=
>  		front_pad =3D 0;=0A=
>  		inline_vecs =3D nr_iovecs;=0A=
>  	} else {=0A=
> @@ -1120,8 +1118,7 @@ static struct bio_map_data *bio_alloc_map_data(stru=
ct iov_iter *data,=0A=
>  	if (data->nr_segs > UIO_MAXIOV)=0A=
>  		return NULL;=0A=
>  =0A=
> -	bmd =3D kmalloc(sizeof(struct bio_map_data) +=0A=
> -		       sizeof(struct iovec) * data->nr_segs, gfp_mask);=0A=
> +	bmd =3D kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);=0A=
>  	if (!bmd)=0A=
>  		return NULL;=0A=
>  	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);=0A=
=0A=
=0A=
