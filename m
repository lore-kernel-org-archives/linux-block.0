Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499ADC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125AE22CF6
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbhALFiM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:38:12 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34959 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388721AbhALFiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 00:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610429890; x=1641965890;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ypPN4+vhA5vxoe2UfH/LVkTa9oB+Wj3II4+fP+m/oPw=;
  b=Zwa+nzaAlfy7pZZuWWD2qTN3GVOG9tBUKfVhBFEyrT7S3w9AJgvaYBXy
   ALd72mdlBH5jh4gbBBzNOj2i4dVXJ4fZetSdXrdYipxxR9A8TbDKBtBmj
   NH4vLcCUhhm3XV+2aF8iEOScbctoBWbt19bxsEJriuXtbAcq+5OiP1frv
   SXtUQBsy/h2LLHDJhyAqyICGrUt6VOl5RqEho7j+dM3pJquZbdHqmgvz7
   Jsqkq7dQjt6QNQPhoqYEib2/pqWxm0jiHydzpZIq8KMJjnfTYbOKab7Ce
   FR6cqsJ/rULYJTOn0A+JEeXWmrbjetnmFojDlf7N3uEHDNwVsJKAghW1b
   Q==;
IronPort-SDR: UWP1CbVax3DzEglTWt3QImfqNBsmLXjc1ALo9kB+jVQw4nzeP9yeMW3sR0UG438Y8c1nyOcDxk
 E9eEXLNy3XeH9NCgPeTQRATMZHEnWddJC+TJ0fkkMlbkBpFfG2YqxAxr+u+969Dbeuoa5UhRsl
 /oKCeFNLMI85llVZ7CHjnWjthtdv40g2BPs93Myb+hXEtmFfnUdWzJ1KPiScCRp4HkJ89Gf4JB
 DGAYYlQS73WpiQNn5pNYvYGdMFQqeVsotaiufafVcIBYf1PKNOLgBDsiuHji8EPlpUxfyu1YpK
 UjE=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267509059"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:37:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpsqKAwC6axYnLFfjGsC+9s6+7GqEYTgmcifLzK0SKYYvDDwKfovgJPMsylk5G/yNsMlWBTvD1TPx3lhkBdt1UMKxkAVQ8N3vCU/n9Z85OBQsEtZyVQ1DEmN3a+D7/EiD5UvW5/06M6Lek0ekub8taW1kRg7GATYtdSie3ke0Mv2qkgwm54MWMYpPHRLo1q+gL6RFxeGKNjacgsYbn22MXWu6YTEr1+N6BhC6IUdKUQY65aFIuOKfiiabK3VTDn2aYMcLViyyYGoZrRhigk77bksgYQuF23Aas63/oyVyPCltHUea0hWBpF+XP57/MxZDifj8yNCU7VRTt8bnZTH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjhfVbpjdcDlnyFpxcFAJ914bffCdxYcMS+priMSni8=;
 b=X+oVjhp/nT0r5lPgZEDLDW9oMmZ5MvXEYZn4h1fjWDn1XYC5tuRP6fRV4bUKBt/SOd8W1sTLMCu9fp1+Oa2qLh1nW2MsfdlVPbrLq4djjiuh41QCjf17V5uaMwM68aMiO9vLs1nKfD/32cIr6hJMfvI//CboB+tWZFQaUM93f+9ObWYi/MmPuVTaClQa8KsN7U2AtZDFb8ir5BoYZ06fKmMwapH6OnWY+NdeobL3F8CJ1GXtKR4LXw+kzbMcFV0CJYuvzGA+/oqEvsw94+vWaF076zdX5nvhwxEILefZunrivqJ7Jtbtr/QfO4AnY6lq0iAfLO7aItzE5/gtuMZ/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjhfVbpjdcDlnyFpxcFAJ914bffCdxYcMS+priMSni8=;
 b=L39Px/MDt41pxNs8Q0qwsY+TfJbW8R9RP84dYPtluwMt7LPRuJSYXz0vQUp5J0Z0XZRI+dFhIxCrmAVpRLdm4AzXSh0icZ534B3LlSsP4hOkgxmH2BB5b5OeRSsgQjT/wwR68ascO1eB7gbmsRKL1Fg+/68yWcQui+4HUx0dxPc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5060.namprd04.prod.outlook.com (2603:10b6:208:5a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Tue, 12 Jan
 2021 05:37:03 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:37:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Topic: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Index: AQHW6Js572EHK7u67kumSX8SZd7ojg==
Date:   Tue, 12 Jan 2021 05:37:03 +0000
Message-ID: <BL0PR04MB651444A9A810E0DA8D958431E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3f5be839-5434-4e34-43fd-08d8b6bc174c
x-ms-traffictypediagnostic: BL0PR04MB5060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB50601AD8E4A0DA92D25D2308E7AA0@BL0PR04MB5060.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LM1J+SUyx6e/Xn27DsSyt/Xr3viPg4/nwVtDaq/XoM/wdFW4nWVDEZe26mJ4K7i0Xz2Plgo7K41BsUC0LtpCmJ7EUGFZe2GNCubIL94KvLwA2ZtOM+7QYWom6ALI8//RDPmjye8QereeYFM//EPAxki7wcM5TCdNIvI9wIniy1qsV34/8cpS+oh7vhzsU3vnXHtW1rfclih32aWzvs3fE0YzAyrlyuyRwg1/tlCFx0ys86aW1fNDfn5mWnXYUQjxD+J/vYXYupapaL2b7bP97UOTEJhXebxUUwjLlaiHAfCIj5QJhEgeb8nRAeh9sTBgXA0GKymysGV0F+m8Zn48C4AcJraQuy5XNivBhgzsGr69uTXkYXlxd4BCFJVvUbl9o0V5RrLpcWkBjibC6GxMvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(64756008)(66446008)(186003)(4326008)(7696005)(33656002)(66476007)(91956017)(76116006)(478600001)(66556008)(8676002)(71200400001)(6506007)(54906003)(53546011)(110136005)(2906002)(8936002)(52536014)(316002)(86362001)(55016002)(9686003)(83380400001)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?drgNx8+xlpdzkcf+9l8krFMOy8/eE2Y223dCIlF3VuT1dE2gubB61uVWgC?=
 =?iso-8859-1?Q?my+pne10MJAIlo3QR2/dqco2u33rABiALVkXDVHwYtNF8x+HdsUfy6VGuw?=
 =?iso-8859-1?Q?AmTNGYAdm9DuserDcj3L87Qa8SPrJWqnhO3hdWGgeRv3XvT2hcY2cO2Tb+?=
 =?iso-8859-1?Q?Y6Iq1KLFZ3HyP1jMxq/vAGx/d6J2r6knNbVcSLFtwCMdCSxLnXg/w/yECW?=
 =?iso-8859-1?Q?NS4FKMAFkwFqm/v2mFJEsa5mFtIXoP+qVPzw/+8QnLoXFbtEkhfj1jE86l?=
 =?iso-8859-1?Q?98yZFjELOn34FflCPSsSa83rVwW6ABuxWyA7TykFupn+qVoH06Tc+CbAYd?=
 =?iso-8859-1?Q?3gl/CZe55HMMqhCXW8OppFtDqPLQgjTmbY8treFjrH4VPTXo88YrHUP36I?=
 =?iso-8859-1?Q?f5KWe4pKCPyqQpbJ6UygzN1bvE3fsfG6sWBAf77wU5wrfIdISRiiGkoG3W?=
 =?iso-8859-1?Q?ejT5ScL0u8eS32mHI7ruUbZy3LMGAS6ydZ0Fr64x/+Gw/0dZ311Ind3li0?=
 =?iso-8859-1?Q?mDtb08b/eGv3qXaoKgKiA2lheMMSujRMjAeAPEB+S9ELGRkfro6uFAH6OL?=
 =?iso-8859-1?Q?gSq/MQTIG/97BVSoPLz5PEShEOSdY/H+FSIHVaSncxu7vrjMCrtFAk3M8X?=
 =?iso-8859-1?Q?U0OIEtSvg1y7PH1TgCS7BlQ5LO8PJlX1mA+jN4qdwz1Tl9BG8kZyQUA4Ii?=
 =?iso-8859-1?Q?B5XGTC8/ljI5FDMVWBlIKZDHDwW/RG7gEiMGmCo3MxI2GqFA1U+kk4iq/s?=
 =?iso-8859-1?Q?EWJebAl7uSqhuGKRrpxlmU8XfwD9YCtVa4cgbu5Vfa2vFd0VcdtTJrx/87?=
 =?iso-8859-1?Q?MbMpuzKDFU41IFgJDLiLElRyjtt3A7VcVKRKmSjvKNxwSsP3ENN5EAccVx?=
 =?iso-8859-1?Q?THYPkxdOMHYAzgPdMUb/aXYJ0buFD9oPtQq1kGjpD/z/5yO5VM25DTEIxW?=
 =?iso-8859-1?Q?LvL/mPebUE/aXQmpIIULaIH7jzWbTNpYLp/tiiWxDUDuee9sy0MdXtSVmH?=
 =?iso-8859-1?Q?nqjLSRqm3V6dUOmZGa+P5IGBdl1Of+TMRskzKLxJfT8ySDCxdytpoxuOAd?=
 =?iso-8859-1?Q?RKndxHnhg6MxX4fAV6UijnA3PrzAR2bXbqVFW8I607S9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5be839-5434-4e34-43fd-08d8b6bc174c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:37:03.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGP3fBOQ+GtXF4OhlgKgQSBc3vpRSpI1S94ygokpE5h2Dj2bHhco73Ol9NSDTAKLkI85OFN87ekaKg2qr5n54g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5060
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 13:27, Chaitanya Kulkarni wrote:=0A=
> With the addition of the zns backend now we have three different=0A=
> backends with inline bio optimization. That leads to having duplicate=0A=
> code for allocating or initializing the bio in all three backends:=0A=
> generic bdev, passsthru, and generic zns.=0A=
> =0A=
> Add a helper function to reduce the duplicate code such that helper=0A=
> function accepts the bi_end_io callback which gets initialize for the=0A=
> non-inline bio_alloc() case. This is due to the special case needed for=
=0A=
> the passthru backend non-inline bio allocation bio_alloc() where we set=
=0A=
> the bio->bi_end_io =3D bio_put, having this parameter avoids the extra=0A=
> branch in the passthru fast path. For rest of the backends, we set the=0A=
> same bi_end_io callback for inline and non-inline cases, that is for=0A=
> generic bdev we set to nvmet_bio_done() and for generic zns we set to=0A=
> NULL. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  7 +------=0A=
>  drivers/nvme/target/nvmet.h       | 16 ++++++++++++++++=0A=
>  drivers/nvme/target/passthru.c    |  8 +-------=0A=
>  drivers/nvme/target/zns.c         |  8 +-------=0A=
>  4 files changed, 19 insertions(+), 20 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index 6178ef643962..72746e29cb0d 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -266,12 +266,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *=
req)=0A=
>  =0A=
>  	sector =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
>  =0A=
> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> -		bio =3D &req->b.inline_bio;=0A=
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> -	} else {=0A=
> -		bio =3D bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));=0A=
> -	}=0A=
> +	bio =3D nvmet_req_bio_get(req, NULL);=0A=
>  	bio_set_dev(bio, req->ns->bdev);=0A=
>  	bio->bi_iter.bi_sector =3D sector;=0A=
>  	bio->bi_private =3D req;=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 7361665585a2..3fc84f79cce1 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -652,4 +652,20 @@ nvmet_bdev_execute_zone_append(struct nvmet_req *req=
)=0A=
>  }=0A=
>  #endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> +static inline struct bio *nvmet_req_bio_get(struct nvmet_req *req,=0A=
> +					    bio_end_io_t *bi_end_io)=0A=
> +{=0A=
> +	struct bio *bio;=0A=
> +=0A=
> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> +		bio =3D &req->b.inline_bio;=0A=
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> +		return bio;=0A=
> +	}=0A=
> +=0A=
> +	bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
=0A=
I have a doubt about the use of GFP_KERNEL here... Shouldn't these be GFP_N=
OIO ?=0A=
The code was like this so it is may be OK, but without GFP_NOIO, is forward=
=0A=
progress guaranteed ? No recursion possible ?=0A=
=0A=
> +	bio->bi_end_io =3D bi_end_io;=0A=
> +	return bio;=0A=
> +}=0A=
> +=0A=
>  #endif /* _NVMET_H */=0A=
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthr=
u.c=0A=
> index b9776fc8f08f..54f765b566ee 100644=0A=
> --- a/drivers/nvme/target/passthru.c=0A=
> +++ b/drivers/nvme/target/passthru.c=0A=
> @@ -194,13 +194,7 @@ static int nvmet_passthru_map_sg(struct nvmet_req *r=
eq, struct request *rq)=0A=
>  	if (req->sg_cnt > BIO_MAX_PAGES)=0A=
>  		return -EINVAL;=0A=
>  =0A=
> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> -		bio =3D &req->p.inline_bio;=0A=
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> -	} else {=0A=
> -		bio =3D bio_alloc(GFP_KERNEL, min(req->sg_cnt, BIO_MAX_PAGES));=0A=
> -		bio->bi_end_io =3D bio_put;=0A=
> -	}=0A=
> +	bio =3D nvmet_req_bio_get(req, bio_put);=0A=
>  	bio->bi_opf =3D req_op(rq);=0A=
>  =0A=
>  	for_each_sg(req->sg, sg, req->sg_cnt, i) {=0A=
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> index 2a71f56e568d..c32e93a3c7e1 100644=0A=
> --- a/drivers/nvme/target/zns.c=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -296,13 +296,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req=
 *req)=0A=
>  		return;=0A=
>  	}=0A=
>  =0A=
> -	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> -		bio =3D &req->b.inline_bio;=0A=
> -		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> -	} else {=0A=
> -		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
> -	}=0A=
> -=0A=
> +	bio =3D nvmet_req_bio_get(req, NULL);=0A=
>  	bio_set_dev(bio, req->ns->bdev);=0A=
>  	bio->bi_iter.bi_sector =3D sect;=0A=
>  	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
> =0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
