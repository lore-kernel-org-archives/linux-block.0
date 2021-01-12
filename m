Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE47C433E6
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B39C722E00
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 09:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392500AbhALJSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 04:18:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60298 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392481AbhALJSD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 04:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610443083; x=1641979083;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EEiipBZXkiwB0xnL9nzkKyYzyzNRFav5rzuBgTl54ag=;
  b=N3prffjyjZizJM79RHM11Ei5S87U7ZZJYz+4uiWkX5+MBmO+DLAgARue
   nBKMsFCnxgBuaLZIHpE1GezUMiKyDOsKSt1HYU/7DuF5BPfMUr5fiHONV
   7zi+zN8IWfMwH5psFXMFi6XJNqTBwCCu1PaZClPWkUOT9+jI7cslxlyIG
   E7P7VhfD3uEVDtXKgu+lhN/JuY+ywQhdg46Mvr9VwJmz1TY01tJPIOmlt
   rqKybS6Zo9nj4fMhKF93Taj7uLLzMW1Xp1YolBFPunZXbHiknVVhaT0Of
   xOwGCDLCKUxPPDkKifX7fQrmGf3kZjJzZ8DgknYt76yLvQyVF2kFf9xeR
   Q==;
IronPort-SDR: l8wUOyfDxT7V5HTmvBMWVWOH0SOvmwywgZTzvDuoCrnXKb0NB/EPHj67cCmn5ETbjw5liuGmbD
 MZn0+BMRsNkEs8mG1PGb2eV5dNjFPARfcxTJwsZS3OTFrCdiH1bF4UNQKivh1a11vj+1+e5SxB
 rV1smJnrVUtY1155oU48LI0taTjc/rcgd8exsxgt2Zv2NnWwTPpRj+LOCSC/mjNu01/YjwJFhr
 wnbvN/HXMLPg0aUY5uoVt5gY0mYOvTDFCpl2MSiXafEiqttWUqmIGeeAaeQrZ37aO3Z1sJ38j4
 loQ=
X-IronPort-AV: E=Sophos;i="5.79,341,1602518400"; 
   d="scan'208";a="161669218"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 17:16:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luWkyvfclD+/zs13ppbG19C4mf73UbpaDKrhsKKS0/220iioNTKV5i1zbs6Uv9aj3sXIXLTrrOKu+mqCaI39Cug/bPQnwbymYZgxBiL7hYsrL/DHq9JN2TJiY76VVuid/Dg/T85i5E2w5x2MtjGboBDZaIPHRz9fI2cZbThhffBB28OTsc2gJykBdwblLE28Je2bwTD27rvfWQpX3QrUUlFi8zPuyRYG+b+66hSE1z89O7pWZBM3uUklCEfn8AKECLXSipaRhY+x3ImEaGrcw0vNoKoUDyBCYLuaI1s3HStyi/WvLYb8woTyxjTiyYUF881a6qNteBe+R8YQYkedEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDoP+gPvvXiyykWqtegBOVnQ8wQL+e3/Jk3DtEBaBZo=;
 b=JtSvLku4UiXBsm7jIgbC3Fs6uPEy9xJRu6sgi4BCM4z43uuVLGTLAAvmnex5Oi4eaMxQVpuEnrj83Mi07eFqM1wqmPu1M3vDthOaGdxPBlaR/IFIZC2PUl1XTs6nKfeRlDBpmN4XYUk7SDxUeCl3aKn5jyhyDIO4boa5zVIbreSWCJgyZEShUzwLB5gqYocxUn7xNptu2XqvhokxEZ6dkEyQInqvdkJRdoFHmsNF9Y7g5cC6HbrKJaRPcHrJfQwqpK6GcF7NoZf9vEvHNmAcpWTDUVoY8g8OK7R3s/AWBunOaotVyTkv/OenAvejn/oUjM/jqgrVmwFmrr9bQv3GuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDoP+gPvvXiyykWqtegBOVnQ8wQL+e3/Jk3DtEBaBZo=;
 b=s7nHMNFrwfrUnz+TuAIQa4Mz88TI7S/Dfy9Tqed7AkI60wWmCg9yn3AFAy+ej1PVlFa8kHPn/JGAN0nfGVHkXKt6JLaUVZOSJqoDYSxim94fGkRMKJKrQAVW2RUPdegUW40eUOxi4FpCM6HOLr6pxGW//9pp/YalxKD+AflPLws=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 09:16:56 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 09:16:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Thread-Topic: [PATCH] bio: limit bio max size.
Thread-Index: AQHW6MA5pLmbou7hDU2XxGR08m+DEw==
Date:   Tue, 12 Jan 2021 09:16:56 +0000
Message-ID: <BL0PR04MB6514F7F944D70DE024494544E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210112084819epcas1p2389fe5fd665e4ff7b41ad92344547294@epcas1p2.samsung.com>
 <20210112083311.30013-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f72340bc-ba02-4a36-75be-08d8b6daced0
x-ms-traffictypediagnostic: MN2PR04MB6479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6479B22749A28473DDAA94D6E7AA0@MN2PR04MB6479.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQ5B3AJBwfbT22Tyr4tht/ah5JFf7D2JzV5jU1cfJ11669S2+qFLZlSE2ppeXOd0klhfdA7IATdOZ5sQq7b3pU7mQmCCFFKB25Q19ndRrjZf9SU9mx/WbWQJzj+Yn8GsjMiWTyhkvzUqSwqurp3CZGP7toK4t2ELo2EINNFt3LW0m3ununETObu8k3H3TlkyiRNHyipLyq0wYTzII17O7gkEJTQbDz4/A7TrhWU4IarVHDxx0GPW4TKMM2UJREzq4reLB4k/mfE1t6eHLdfUAWL407HsYKuPQP57y4Dg4EUNlGceysJyBTdQAMHMU0kgcM4pEfqK987iX+RW60nc/7Xvm/rGW/i2i5y9L1rPaNDv9MCDCsmbHhtppgJYRe7tpufTNAfxcVlRqlGEadG6eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8676002)(55016002)(86362001)(7416002)(5660300002)(54906003)(110136005)(53546011)(6506007)(52536014)(8936002)(83380400001)(76116006)(66446008)(498600001)(91956017)(64756008)(9686003)(66556008)(71200400001)(186003)(66476007)(4326008)(7696005)(66946007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?LxZHYmLCDJS5YpuDYmFte3rCZuBI4umBYL3HJz4vCQiPM2Vwd7r3L/Tzpr69?=
 =?us-ascii?Q?df0lwo1XpFOt9+pPiFAvp7Gx1oRyDJ7vLcj12Kg7dyGcaHMD6VwdgqGrd0gj?=
 =?us-ascii?Q?gSXV+/d/WknYnCAFemVWtqCvUSNiRXupp6nIFPITKOdofM6l2sdObokWs+lD?=
 =?us-ascii?Q?ctsdO0re+ECObqwpWBk6HVTR6+/gLZMFjsyONi20s+vbGAEzmKyWoHRHreWu?=
 =?us-ascii?Q?U4I7VBLjOmo7xZBszoeC9swQIiEQHoRm/GDSAlPH2k8HC13I7FIoy2Pze3a6?=
 =?us-ascii?Q?VTXj+wmOW5sj8/Xj61Di2bFK989vID+a3A1U+uNK2EJDaYRIhccE+LTZHlUq?=
 =?us-ascii?Q?x5ZuoTU1u990llGRslr7VM6GRYzvcNiM4ayq1Vt4dwt3OmgAysU2NdE8MRrU?=
 =?us-ascii?Q?aASe/g1uJEthYPjhX75fOHvqvXkLZu67R+rS01KJ9+9s8TxfdNBJB4413/z4?=
 =?us-ascii?Q?gCdX7n1b2NYmDCpWn2H72WVenG8ASBDJh2sZnu6aFhmFRDctiEebB9iSlANy?=
 =?us-ascii?Q?tpKhVpDqg5Bt1IZNv2hmRENwLL/Rusj+RopZjeS7PXb2k8E+liD1r4ds0iCX?=
 =?us-ascii?Q?FGFMvTi1mGw4eYp3rN6jgPj4fk1t8NLtKslz89NyFam5xpiC6keqUQC0la3e?=
 =?us-ascii?Q?40wsRdfsxhxjynyThAkeiOt+y3/IKJLwgoGn8PuuN8NI4BNef4ltmoXuElGB?=
 =?us-ascii?Q?nyc0mQ2bsd0S/7ptwOmVjfxy2vl6420TCA5nfJgkKfNLh56urL8NsUO0HX6B?=
 =?us-ascii?Q?3Pl79t097MoZus0w8/lIC03fzn5+99dw/cBdXgt5puZis8EHMM+yx1BRJ5CB?=
 =?us-ascii?Q?e3hfJegHYQREvLUc5xcNuG+qjHfVh7l9mhHjChkHZmyuQTDO/L7dQKU802h3?=
 =?us-ascii?Q?O1gXXfw3REg1iRu58Y1Vb5zlkCIOYktVEDytWteUTCYHuH8FT+3+LPOltJLw?=
 =?us-ascii?Q?ltHH4YgLWDVGKlrumRs5TVv/d4o4x6JiTU0v2DYv/kAg6aQjEWkI9fQwv3/W?=
 =?us-ascii?Q?INz4XJo3qC+/GgKaIrA8nZsYtKKgyxuJcSwrv/5bnzWMpq4P/k3b18SYkh7g?=
 =?us-ascii?Q?tSpkLpwW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72340bc-ba02-4a36-75be-08d8b6daced0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 09:16:56.0524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuN+KEKeTpJ5ALX0RSS0hHv6Ve1cBwjd7mF/fC/YN6Ofo8f8q9rSdpYu8DhH8tPgC1LwXRwbzTiPTAEjqSQ2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 17:52, Changheun Lee wrote:=0A=
> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
> =0A=
> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
> but sometimes it would lead to inefficient behaviors.=0A=
> in case of large chunk direct I/O, - 64MB chunk read in user space -=0A=
> all pages for 64MB would be merged to a bio structure if memory address i=
s=0A=
> continued phsycally. it makes some delay to submit until merge complete.=
=0A=
> bio max size should be limited as a proper size.=0A=
=0A=
But merging physically contiguous pages into the same bvec + later automati=
c bio=0A=
split on submit should give you better throughput for large IOs compared to=
=0A=
having to issue a bio chain of smaller BIOs that are arbitrarily sized and =
will=0A=
likely need splitting anyway (because of DMA boundaries etc).=0A=
=0A=
Do you have a specific case where you see higher performance with this patc=
h=0A=
applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too =
small=0A=
considering that many hardware can execute larger IOs than that.=0A=
=0A=
=0A=
> =0A=
> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
> ---=0A=
>  block/bio.c         | 2 +-=0A=
>  include/linux/bio.h | 3 ++-=0A=
>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..dbe14d675f28 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct pag=
e *page,=0A=
>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>  =0A=
>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
>  				*same_page =3D false;=0A=
>  				return false;=0A=
>  			}=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 1edda614f7ce..0f49b354b1f6 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -20,6 +20,7 @@=0A=
>  #endif=0A=
>  =0A=
>  #define BIO_MAX_PAGES		256=0A=
> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)=0A=
>  =0A=
>  #define bio_prio(bio)			(bio)->bi_ioprio=0A=
>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio =3D prio)=0A=
> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsigned=
 len)=0A=
>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>  		return true;=0A=
>  =0A=
> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)=0A=
>  		return true;=0A=
>  =0A=
>  	return false;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
