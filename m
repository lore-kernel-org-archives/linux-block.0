Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19860C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B564364E31
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 07:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBWHW4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:22:56 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38892 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhBWHWv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 02:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614064971; x=1645600971;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EWQ4euhlnmQ9yP0QnLCtRCa7xSydBiEVQ5V9BZ6mpDM=;
  b=rBQ4Tr1eB6tw7s4S+Ok7HuW3fJuB6xS4xd40ada/ie3kEY5AOQ+kVdWH
   cBIii0VwhuyoVCGJWox5TiwyzbpbHoum8AFO1Z2E30ReMmnyudjsFQFCm
   ixfjDgaDvmymye/qBDEeKPuWSnYa6LBGFt6KKGzwfVsnpgcZFVCToCsTp
   zEwei5sFahL8j+NU+wG7HqVoBCNwd9WP7ks2jrm47uFF3ksBl78CURLch
   3wftgiVFPJWHFl9M3wWs8xOCVGKeKRln4Q5DGUXxLfsl6Op4crSMsUmMo
   sXmOLoWIoBHPjlFhYI9URVREfC3cTfj+K6nB3Y9qIELlyzIC4bSmWjGcV
   A==;
IronPort-SDR: mJF33nMJ7fTVEMVBREYygAuhx1773lD5rJMX/hhAo4gsntdZU30tmqzbHyQwXRWxGjhW4ad96G
 +CdScOxXHtUrtjsWksdihPzv6w90xpVWWKSpWXH/noiu721lhlj09C2Y4sMbIckLcGMtxD6SH7
 FWqSZQ+J4vd/6TM2TKMV6nU1Z6f4/ErDSFVFst+SaEzniPCr7ild4SstbGWSyw90Muah7eeVXY
 i958L5h2YouJS1il9h0VvsS6SOX5baujK98Tp9JOn1/cvBpQuVLn8tBKWOSoVaXO9wbq6FLClu
 AZE=
X-IronPort-AV: E=Sophos;i="5.81,199,1610380800"; 
   d="scan'208";a="160556820"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2021 15:21:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLtCyhoDPaxcB9m5G3ivbol48IGYTFmf0cEGYqv/xP5vJufrjnojTcFwC2SbBllV02rnRohocG+9Wen/48HtaY8ObyNvT2zR64cSD2txPMQuXGiMmeqd0F+JHpU8yQFaJ0yc2fes/PMKFw+IRzgMJuZwfikKW565jIbb+r4D8w4eQ40ykV0haSZhvwJtFW4PS3lzqHRzuUbXBK0YH269+mzqeqPddB+11JP6PxbQI5UJX28Fe98rlt52BXhYK5UfQed0FlKFeBh8hpxjz0DfVG9lgovzPWRB8cBvSg8gkYymLGCt+acyu2BSdspfNII21/xiPw7+128L39JjL7S05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdvq8nxuOoZDeN7oDe8NV7imJiVdN3sqhZS4bYQ4O5A=;
 b=HPekEmQCk/J3sdCpBOkwMoMFhvKs+rZEOf85I/WbOB4JrGXbrjRfj1YwS3aTkl04xPWxUXNMZIK/PD0Et3ls36Cud8ApayV2McSTC4PNCYNgNjcOFmW2N5zUn9VgOlN/cC0cN6IKc9M/b+p4I33YKlKwtuik2Or+wJ+rWI1ESU2h3uRboPlcTkPFE7hvP8fHnuY0uMZFsZxC9E+SWhTt0siXeSz2igKr9/ap6Cgj2Ff/vjgX5M8xAsk+8QNqav+PMpP5stHe5TUj1KYWbEJX851noPy5pZVikY1RFJ6CeTCDHkaIVeFhXo5X2fJUkbRyJ/7dO/Pyis3Hp3WTMwOemQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdvq8nxuOoZDeN7oDe8NV7imJiVdN3sqhZS4bYQ4O5A=;
 b=s9umx5a1Az/DP7gEkp9fi6p0fVLQsqVm9H1PwW838ccy/AsqdG0PAOkvHatVf5742SE1y4PdKMOItMY1V/bSFiECaYn4jsDwJs1cdlpuT8AI+X7YE5Tqff4eo4CA7f4KsmA42bVc8K9TWKdyyx4ro/sWQNl+Ga+bNS3Utn9w42U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 07:21:35 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 07:21:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     John Stultz <john.stultz@linaro.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Topic: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
Thread-Index: AQHXCZD3vAo2wh9jek+o1gtQqbdo1w==
Date:   Tue, 23 Feb 2021 07:21:34 +0000
Message-ID: <BYAPR04MB496573915041C5AF50AAA7E786809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <BYAPR04MB4965F0B60169371A25CD423E86809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210223071040.GB16980@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7493c64e-d6b2-477b-6cff-08d8d7cba6d5
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6549A89B526C4B23A783B17C86809@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0jvNULso0Z7Au/nSY8SZv5+5zlKVkzNT3SkRCND+jeI/q4jgw/geaiI930Io+mzT6aOVf6esLK96AC7aAump+/H7t7F99Z5v33NIFZFO33meMz1TXCpZXSQOyue6iHSeHuSFa+MN3IpZHxds4/itkU37IwmIysePX9WzZ16DIylxi/enMmTlRUt6oQZkL+Kpd59rrR1Putc0SQnPYvwi2eT2PaVkfdMqh9OQwFrCVrKgJGqj4+2qWYil2G5CI4YMG08K6/VhblWxkqXXZNEt39nhi5HJOXCh55TK9HRqxBDtLxgmMiyaiyj8l6MNcLN8w0hHJV8Re2RoTWNFPGe0Qx0Gz2/aG0MvpdlqfAUo1/ZcbVpx8II8SB59QKwj91dLHyhFEkmCOu0JjBW3TGx5x0RSQgRxBMS7wDIjldG4iR+WfV2xmEe/0amSAOFSxW/rKEMTJoDxPZovxgxzxvGV+aenVDawWkRsF8fwXYHQLdrUHr/AETUflWc9OzfdQQaIUEemfQvYqA98yIj62o4Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(86362001)(4326008)(5660300002)(8676002)(52536014)(66476007)(7416002)(83380400001)(64756008)(186003)(66556008)(76116006)(6916009)(7696005)(54906003)(316002)(2906002)(66946007)(33656002)(66446008)(8936002)(71200400001)(9686003)(26005)(53546011)(6506007)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qoX+jUIzwJTjjtH+H40u8Hyg5KRJqtMj7ibUGXpI/sTpHtqZKtqgO0ipRxXs?=
 =?us-ascii?Q?PJOuv82pfwjj5/iToAGhViOKFVNU+ciFBPwR6NsaxPOP9GzUpwEj7pKLaEnK?=
 =?us-ascii?Q?/V6Aty2DL+5dbsa5QOljXRehmtiFK/LzvqR8Uvk7IqHrrPApAKZ5h4ISucYf?=
 =?us-ascii?Q?7MyobrwxK+LVjxJwOQAx/MmGqXEYOoO7KFLGIMjRLnGENUb9QpgAA1heESDd?=
 =?us-ascii?Q?pTbP4hkKyKhAxVw2Qnbsp5QvEHg/vEhwgcu9KqRrz/E//MLfBrYqobChMwHU?=
 =?us-ascii?Q?bCBNUGhKvkKYwvxpSQWoSuoJL1OJ9wHeLbFZoJPpIuhmDkFdtfa/oxiGHNVE?=
 =?us-ascii?Q?ROPvrEypk0OEPjR8S01nT0Da6hhvAsqVfw/b0+03SibvD9Z1ZBd7/81mmQFW?=
 =?us-ascii?Q?e7/Qn1YfO+gsS1Tx17X+ZAwZYQ+HgRZsSFbNfVNmYSAO0KRVHTq/39VxEl00?=
 =?us-ascii?Q?2ljnPndYQiCuoGyyAAQZeYPRRX3oHUtD7CiiVA+gVMReqXeBkAT1tRFsEEXF?=
 =?us-ascii?Q?0hK29KLhB9FL8YBWVcNcLaI7d8fEKyYmW0jJb4TsFLw9Sg92jIuevSKPCwVE?=
 =?us-ascii?Q?cYs57ddbVpWyVBQS2Rtr1LP9+7VHvcjxWAKnBAnQ1x4OpL9nAkQHJGZyrQmU?=
 =?us-ascii?Q?F0KfGGmSgvxXuxiW+rJepm5AcYqteVCvMGK+xaLxpn+uqXstYUhh0xXszMeF?=
 =?us-ascii?Q?5vGhlnk7gb/4cntTVT7hioIaPjYqqrztj61XnSGmRIQHY3nv810d2f8Ja1MJ?=
 =?us-ascii?Q?f1g1+pXZn8UMVm9j2RpWAbKJgpAPtqdVR/WTDdcdbMnWAiNHy627EJ4SPFhB?=
 =?us-ascii?Q?Y0QacXzycEu+xeyLxS34FydB2xb9n85ugPze0uXgDj8nLeF+njLrrFPMQzgx?=
 =?us-ascii?Q?LdCm8CQV9t2nWX01eWsGMWNcJx7Eyv+LNomEJOo+MriSMpsrpwsBTnmBys5Z?=
 =?us-ascii?Q?yCJmp6OCbYdE/83WFGrDGr0WD2LEXTwv9QHJqYuCT4m5F8RrFDRonkBadHv4?=
 =?us-ascii?Q?hTbZu2VskhTcbyViyr9vgkv7htU+SjQkcJfFfj+/Ltq/kzpTYEiWHGjlzU1f?=
 =?us-ascii?Q?dRVQKK3G7ZUDuqLa94uKwkfFnA9D1eWLVCFkuLK4hjI3ZBs7KJ/mTx1wDAyr?=
 =?us-ascii?Q?3jg0Vh6U5u+a71xiDZx0U1SalvH5fcuCxRV9gyYKCjjZUhNGbVzZQ4qB1uKg?=
 =?us-ascii?Q?vdQNpDi7wy6FtxPn5NPbK2m8XSgwIldRTsDOaQS2fXtTs4JexJzupPFyzNjL?=
 =?us-ascii?Q?bh51nVVyfCUc8wUueLeZq2v+EOFgehSJsViq+tHiurlftsRPl2uNc7Yd0SHD?=
 =?us-ascii?Q?T9gsUB7Rv9SIh36BoVTMtAg5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7493c64e-d6b2-477b-6cff-08d8d7cba6d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 07:21:34.8863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5aprTmzRqpdROA8VLQoD4Og88hJaH6Tw9cfEJbUfQF5OhETTvxh/nxVKTRTJQCvb89uVmBzhJZIKztdWNPZgzoZzve9z2aoYsZveB5nUWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/21 23:10, Christoph Hellwig wrote:=0A=
> Well, that is a somewhat odd calling convention.  What about the patch be=
low=0A=
> instead?  That being we really need to kill this bouncing code off..=0A=
If we can kill it off soon it will be great.=0A=
>=0A=
> diff --git a/block/bounce.c b/block/bounce.c=0A=
> index fc55314aa4269a..789fbcacb1e92a 100644=0A=
> --- a/block/bounce.c=0A=
> +++ b/block/bounce.c=0A=
> @@ -214,9 +214,9 @@ static void bounce_end_io_read_isa(struct bio *bio)=
=0A=
>  	__bounce_end_io_read(bio, &isa_page_pool);=0A=
>  }=0A=
>  =0A=
> -static struct bio *bounce_clone_bio(struct bio *bio_src, gfp_t gfp_mask,=
=0A=
> -		struct bio_set *bs)=0A=
> +static struct bio *bounce_clone_bio(struct bio *bio_src, bool passthroug=
h)=0A=
>  {=0A=
> +	unsigned int nr_vecs =3D bio_segments(bio_src);=0A=
>  	struct bvec_iter iter;=0A=
>  	struct bio_vec bv;=0A=
>  	struct bio *bio;=0A=
> @@ -242,8 +242,10 @@ static struct bio *bounce_clone_bio(struct bio *bio_=
src, gfp_t gfp_mask,=0A=
>  	 *    asking for trouble and would force extra work on=0A=
>  	 *    __bio_clone_fast() anyways.=0A=
>  	 */=0A=
> -=0A=
> -	bio =3D bio_alloc_bioset(gfp_mask, bio_segments(bio_src), bs);=0A=
> +	if (passthrough)=0A=
> +		bio =3D bio_kmalloc(GFP_NOIO, nr_vecs);=0A=
> +	else=0A=
> +		bio =3D bio_alloc_bioset(GFP_NOIO, nr_vecs, &bounce_bio_set);=0A=
>  	if (!bio)=0A=
>  		return NULL;=0A=
>  	bio->bi_bdev		=3D bio_src->bi_bdev;=0A=
> @@ -269,11 +271,11 @@ static struct bio *bounce_clone_bio(struct bio *bio=
_src, gfp_t gfp_mask,=0A=
>  		break;=0A=
>  	}=0A=
>  =0A=
> -	if (bio_crypt_clone(bio, bio_src, gfp_mask) < 0)=0A=
> +	if (bio_crypt_clone(bio, bio_src, GFP_NOIO) < 0)=0A=
>  		goto err_put;=0A=
>  =0A=
>  	if (bio_integrity(bio_src) &&=0A=
> -	    bio_integrity_clone(bio, bio_src, gfp_mask) < 0)=0A=
> +	    bio_integrity_clone(bio, bio_src, GFP_NOIO) < 0)=0A=
>  		goto err_put;=0A=
>  =0A=
>  	bio_clone_blkg_association(bio, bio_src);=0A=
> @@ -313,8 +315,7 @@ static void __blk_queue_bounce(struct request_queue *=
q, struct bio **bio_orig,=0A=
>  		submit_bio_noacct(*bio_orig);=0A=
>  		*bio_orig =3D bio;=0A=
>  	}=0A=
> -	bio =3D bounce_clone_bio(*bio_orig, GFP_NOIO, passthrough ? NULL :=0A=
> -			&bounce_bio_set);=0A=
> +	bio =3D bounce_clone_bio(*bio_orig, passthrough);=0A=
>  =0A=
>  	/*=0A=
>  	 * Bvec table can't be updated by bio_for_each_segment_all(),=0A=
>=0A=
Seems like this fixes the issue and does the cleanup in one patch, looks=0A=
good.=0A=
=0A=
