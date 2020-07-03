Return-Path: <SRS0=jyL6=AO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C4BC433DF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD60F206E2
	for <linux-block@archiver.kernel.org>; Fri,  3 Jul 2020 05:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZYzuxWEa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EPAX68oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGCFdA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:33:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47053 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgGCFc7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jul 2020 01:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593754435; x=1625290435;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3TFCO2+NAsGGsP+cwdoIopyYe+YxDp28yTVgvFQ2QDc=;
  b=ZYzuxWEaRPPj0xXIGFlVyJ88YqWf9TkbvyhyKSOsaEiSjz5cWRbTSnXO
   4gr+X7H7V39iD0P+hEPKSHUPU4tsvj2cdY2S12HDIUmtHlFuzRNcQ+eSa
   mFyJLj87BNKdpwJjLF8sQUFYPP31NohfHm03p47dWwU8i0ZoiFfMMyXY6
   wt9Lr7VUAidwSLeOo4eyJ9/vHCmM3apT9Pa/qBiVeeE1u9IRyDv3ZVxU9
   SaNjuuwN8LaTp4alz50WuX3+Ts7VKjVOEWfIIkh9sUiBDHKz8/k3HO0r5
   OLI65aXoYHGIjNgs+NGz2BEvjM2zYBsXB95WWnIhMUUdtb5zhkf1sCZt1
   Q==;
IronPort-SDR: lUXOY9wYR4xY+Gq7+R1GFes+N9LkVhOA1tBhZnhe1bcGEusFKzmnHCYblE7/elBRQDUAcapIen
 vqPEATehi6PMTxTXhh1jqoAEq8UCxJRKqeJtl56WsyM/EHTlqHy+D5ABACRvc/UvBtLpPOsmSl
 I6YZI3wmbAa8oFR8lQ+a0hvxghajqrRCY9ZQPMmStZw8K5r/bL9mzqaReA8jFlDZ+wMoeveOcl
 ZDbSQDvtrZ5m/2ataklQGIQFA590mF1wRGWI76ER60huR3mV5VPa5Fw5U3yDSKNhrWTUmYFd4Y
 vWY=
X-IronPort-AV: E=Sophos;i="5.75,307,1589212800"; 
   d="scan'208";a="244568208"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 13:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CG7QByd+eahy5465WyBbt+35NCYJQZvck9+XyjoJcUw1F652P0mnWc09MAz9riPsuN5IBs8ZfvSoK8xreO5GPgxbzur2ux6jNApbatT5gayTAsEQfjAYjchDRHvWHMkT0s8BjRCg6RLNEbLJGUOwFfsoil9B+QI4H987eWFDoCHdGYPtcwq6eF7bdTHiZaTMawL2QsIL3oGqAqx7eSEcZME03pj2IiezHZDWjn636vIL77qWJaYRmSJ5upvw3zy4LkU5Y0MR56hvI7GPKvKwhEe9dJYXgcvHeks0Y/kNnaTiTKRPCqJoFJhcIX26CnQHVtAuA2Ib0VT9RnqIwIBYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iihO0uvI8zorgLNre6uxsnNrURdkfvHrj2OZes8v7hw=;
 b=H0V7O+tcUorJv2kc8+EP8juDGR5RVgloWncunbNAmg+t7pAQEGshSJya7gZmtL+7DatmnZx2d2ctVy+56o3aaawQpb4wczX/b/OjwPooo+YhU0GWvftn324o0KppqWAHbNFE2mHGHPji7gZiVUj2527QaoXTK9Q/OM/a32gERZ8pUKCO2daoBuP7asu4Y7uqVlTDwS8iSIJ/Q25vHcYDsx1yzwtIBcguA6Iih4g4Stv3rhFYWsKVVGXbPDQMNroJh8hP56ZSEaQxZUvs2TNzJnAZK+coWsyzWWRT0oZ1DoNOrxiX/moYF/JL9EmlZZYQGGVEjCUN/qrwtlugxpQ6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iihO0uvI8zorgLNre6uxsnNrURdkfvHrj2OZes8v7hw=;
 b=EPAX68oE/88uK17kiHueDqOM12Z+dzzos0+u6Ard6XguDePsSwchvzwn+Ra7VANkNbzphk5AlSMeq3Wl7KT7Gl2vn+ViJOB4IveMrXBCHwodo0hDAlMdtiaC4nuQIbBg+IqUdkSLZdx2mk0WuLNUACvvalMfUCn4q2IeQQ1c+1E=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 05:32:56 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Fri, 3 Jul 2020
 05:32:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Subject: Re: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Topic: [PATCH 2/2] block: enable zone-append for iov_iter of bvec type
Thread-Index: AQHWUIdfrrkmUrgUfEeGzF+AR69QhA==
Date:   Fri, 3 Jul 2020 05:32:56 +0000
Message-ID: <CY4PR04MB37516E788EC8804D7DF9780EE76A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <1593704330-11540-1-git-send-email-joshi.k@samsung.com>
 <CGME20200702154213epcas5p4e8d42861cb5ae91ddeccf1ed73107304@epcas5p4.samsung.com>
 <1593704330-11540-3-git-send-email-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad71f38c-af60-456b-7357-08d81f128a4d
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-microsoft-antispam-prvs: <CY4PR04MB0374F37CADD7047C044931A1E76A0@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YPXxnhZ8mMI/6SEBaQyparwE0Cl/h3Kg5BWvWOOj+F1/AY5VdZMs03nZ600M2VaHvu76c936F2dMsEaQ/qFM1kxFOA/qyvx6RBYiKF0JzFVhX5Lj7rvwPfh3wlJurm68Cux60segbJFXh5mN5g0SKyaaM+xTrYo0jzELCuFd2aQl/Xx43QsSIlxQ8WWbwfEsY+Ze7MqHcq5JtVX5AQc6v2oAjNBjp+X96Z2Nq/nQvQI6f3iYqXmdI7UHrhGOSkMCkmTvuuhDAF7TwrlcEigLhdJUyVdLP0FW5S6Ocuh7bmfQf8J7Mvdxyd8B6zAzEEnL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2906002)(86362001)(66946007)(5660300002)(83380400001)(52536014)(8936002)(8676002)(76116006)(91956017)(9686003)(66476007)(66446008)(66556008)(64756008)(55016002)(186003)(26005)(53546011)(6506007)(4326008)(316002)(110136005)(33656002)(54906003)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OKATQvruWyEGMFFVPoEw663eKk9ozeJSZbUu4yCTNnEtRGTgEjAEBflAxXpnZ9/XQfZRBroPZ7yefDzp5pGFnLlRBx/WQSQ5x2yiWPs4fT3Mr9Td6+nPTips0mO+kgR/Wo/rXMrRwXJwo4Pxc1LncNuFC2cpQfz2YE6ZNn04WpwvsbZXcc9hIh4svIoz4idgM2RDqnOcg130304DMg4zL3uLZNzprwMPhenfmMU9dvk0hMSn+q3j7mqqzZHCEbDuyvj4GILK00E8Ip9qWNbNkR+iLr46CDDA0zuPlgDfV+THqBWAHIi1MhnFW5l23YjDU1sR6o4FlnF1kO9iCdB5anO7m6LcXvWOuUIl19bupEbgiD95yPjbf4UCIgsSfmrSwkd/VQ3gYBs6EOJmcZclb/0fVDL1gyoFCc7ILgssqc3uCMheHYBesuFagAmCflM0a+6L0kqmF5zdeacs4Bw8N7ymw6oi0JM5w3HcTIenCuHWZQjCMdmUKqnefDG2mzC+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad71f38c-af60-456b-7357-08d81f128a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 05:32:56.1549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v9N5upNvIjOd5kY4iCbq0+/+1ZUQZEz3OZHb5bvyvJ3phSyuBBSWMqbCqt7vTxi4vkSsNFNUqxWwOEbDCsM/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/03 0:42, Kanchan Joshi wrote:=0A=
> zone-append with bvec iov_iter gives WARN_ON, and returns -EINVAL.=0A=
> Add new helper to process such iov_iter and add pages in bio honoring=0A=
> zone-append specific constraints.=0A=
> =0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Selvakumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>=0A=
> ---=0A=
>  block/bio.c | 31 ++++++++++++++++++++++++++++---=0A=
>  1 file changed, 28 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 0cecdbc..ade9da7 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -975,6 +975,30 @@ static int __bio_iov_bvec_add_pages(struct bio *bio,=
 struct iov_iter *iter)=0A=
>  	iov_iter_advance(iter, size);=0A=
>  	return 0;=0A=
>  }=0A=
> +static int __bio_iov_bvec_append_add_pages(struct bio *bio, struct iov_i=
ter *iter)=0A=
> +{=0A=
> +	const struct bio_vec *bv =3D iter->bvec;=0A=
> +	unsigned int len;=0A=
> +	size_t size;=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);=
=0A=
> +	bool same_page =3D false;=0A=
> +=0A=
> +	if (WARN_ON_ONCE(!max_append_sectors))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (WARN_ON_ONCE(iter->iov_offset > bv->bv_len))=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	len =3D min_t(size_t, bv->bv_len - iter->iov_offset, iter->count);=0A=
> +	size =3D bio_add_hw_page(q, bio, bv->bv_page, len,=0A=
> +				bv->bv_offset + iter->iov_offset,=0A=
> +				max_append_sectors, &same_page);=0A=
> +	if (unlikely(size !=3D len))=0A=
> +		return -EINVAL;=0A=
> +	iov_iter_advance(iter, size);=0A=
> +	return 0;=0A=
> +}=0A=
>  =0A=
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))=0A=
>  =0A=
> @@ -1105,9 +1129,10 @@ int bio_iov_iter_get_pages(struct bio *bio, struct=
 iov_iter *iter)=0A=
>  =0A=
>  	do {=0A=
>  		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> -			if (WARN_ON_ONCE(is_bvec))=0A=
> -				return -EINVAL;=0A=
> -			ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
> +			if (is_bvec)=0A=
> +				ret =3D __bio_iov_bvec_append_add_pages(bio, iter);=0A=
> +			else=0A=
> +				ret =3D __bio_iov_append_get_pages(bio, iter);=0A=
>  		} else {=0A=
>  			if (is_bvec)=0A=
>  				ret =3D __bio_iov_bvec_add_pages(bio, iter);=0A=
> =0A=
=0A=
The only user of this function that issues zone append requests is zonefs. =
The=0A=
issued requests are not using bvec iter but a user direct IO buffer iter. S=
o=0A=
this change would have no user at all as far as I can see. Am I missing=0A=
something ? What IO path makes this change necessary ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
