Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B28BC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248F622B37
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbhALFJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:09:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19879 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbhALFJk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 00:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610428180; x=1641964180;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O0B84QyM5Vm0RpwAiXKYVNE1hsUs38hy2tXfn41y5fU=;
  b=PwoIrt5afXOXvZI4WdkrywAzR+oZ6WvxfPvlo1ZOOYXxp4ChUwddsQkC
   P/gstCJpB3oLNBVmBUAJd0Ldo6K2upFlJkxXesrcMHfnUYN4m7od48mhg
   MfTsJYaj3OIKcS4CSDQ79LIlbsNyWfnc91+x5Yn/BRIeShfwHtJegc6i7
   WDWpN8agjqOJkIJxhSjtwTpndWLwrO8EMSf8hSdePZCPZsdMMFWQzkqaI
   HpJnCsJEhB984rvU9ZsoMRp+srsjRTujcnu7fGw6cYZWs89sHOoT1s6Aw
   Pg7UsHyRC6wHPQO2Xf9Z0qZZwWQpGJEcWhE1B6UBgHGpt0CRnYrO2Z/Vy
   Q==;
IronPort-SDR: rrLcBahk6QsEu+EmqSRVvLsEPWI4PNhbOBHayIb3u6TZbgAL3r0KkAAMacDieNQY+1lTQ/uhrn
 d6+DSvEoCRmU1szxWQCFRCr3nMrjLzjMl0zhQiNlJIJjLtFB7Oyzr8Ni51shfv0MCA3JseiX1S
 au+fcsR1h7zQP72X7+bpzCl2ctv3UaZ3hckQqZfLm+Y8vVhpZ+QdlOiZvoX8hGoZAUJZeYFtIx
 rBA3m0Z+9JrnkDzDyCjyPA2FdeLrAiHMoWnqUoTl741U/YvjaKpdGGTvU19ah7/d4B2L3Jpy58
 k0E=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157208263"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:08:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbrbMn/e9YwOBDB0DeiXF/bxjt7s/VT9onhfR5BeJDKD0uMISh8MYxugzDHTbdUA7SMmYAKyGZGGDrIDjYoS0oyCOGDIAnFeBk9BFGwBVkDPG/rUayMUvMDUPyWkIMHpNPOZ8RzJfxTqc0Z+JszSW44ductsASTPPwtkbhl46xtwfEj5lTBR22r5AwImPQ+FCVsr+JWJfgn3yIiMKtOS5krk4ptmGY/VSXOEB6mKbpDmQbjZ/UHjd3De4D89pp0fuJf8d1nEFPN5DnL9zQI+m0u6Ve3I3AlyI7e1aO1a3PXb1GMUtYFuLisOjeJKeAU+Cmqphm1XZ3xbPiOuf6+SOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpkbteCfYG32S2pYMu3OpYiQas+2z/2R036VZ5a3R4g=;
 b=JbN5qcb6lxnAnFtBUFJa+xIKuYiVF7zeuAJvQ7dlfrFQh4DDU3rKgh+G4yFWpyZee6ylrTZS3znshgChjnCWnzhFi7IPdpfKxiAIhFowVBOpTPwWr3oPsLfcuB3svTX2aLyj6/DpFimiqmEhee22iHTp/80LyW+OFjhvl6CVJNhO5XOdXjFRC/orcXFqFumBCsdT5L4kTYsnie9IBUkSrnexP79MDvUNSzkpXXi0hQlpQbOTHJ6P4x6l0UVzZY09P4qFvtDrHdEfmXKdn8fch4BWQBEnOWbc+B8FgCgv0wkJEaB4RcqhJjtMOSCFcpwB5fcJ8nUdWj2VTVpjazulaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpkbteCfYG32S2pYMu3OpYiQas+2z/2R036VZ5a3R4g=;
 b=nQclKPI1Gwe3AEaDaq8HKrhOJDSMGienQ+Iffnnizpay40QTGnf5rObYFNmVTlRrl3cLYPuwGcSn61Jes1jkWaCrALKzfsJe5QAYMXSbFebNrz+Hq7VCLyquF8tzER4/nBq6BEfdI4TJ6yjvayChBygJ2oktVihTiYh9+ZmAbcE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6596.namprd04.prod.outlook.com (2603:10b6:208:1cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:08:32 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:08:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 2/9] nvmet: add lba to sect conversion helpers
Thread-Topic: [PATCH V9 2/9] nvmet: add lba to sect conversion helpers
Thread-Index: AQHW6JsnAUjLbaY3Hk2Ul6c+S0bTYw==
Date:   Tue, 12 Jan 2021 05:08:32 +0000
Message-ID: <BL0PR04MB6514DAF27FFAAB70FED4B0B8E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 948ef37d-8413-4b9d-0ac6-08d8b6b81bc2
x-ms-traffictypediagnostic: BL0PR04MB6596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB65967037FA5447025B270914E7AA0@BL0PR04MB6596.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GeH91ApjRPjJqS+oiittRL1ECaKrE1H3h5PxoVMGnbLOOjz5EpS7/UbSWSiBdfX7RTZS3qEMdg6LWwc+nB1YynWR5pkjufEM+EuqfMbHUKYmJELQZeFhxh65KJSY2xv49ADq+vBv/jqo3O7p8ElpZGo16raY/55LaEQ1RSxAm02+61cfWkt96yLqJl+L8Y0sJc1KaB4du1D8f5GXRFunQNlLYptLOEWPq/4sv911h7SOL5oWcFx6HCQxwLZf09J+ul0BUyWe0IRfTlD9YRwq685MH+3zP8wV2jVRlEbQpq+QeGuv0txJndyLUa69ruJJtZB0XIbYx/ZYlpzT7QPoLs1tzX4sOYVfzawIRKtgjg0+3MDkK2RB2sjCRKl9VPTKjuT0SSIMnwAbGlIWwPwgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(110136005)(6506007)(66556008)(71200400001)(66446008)(7696005)(66476007)(64756008)(316002)(54906003)(66946007)(52536014)(76116006)(91956017)(186003)(5660300002)(53546011)(8676002)(83380400001)(8936002)(55016002)(4326008)(478600001)(86362001)(33656002)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BEik0FO2y6kZ6BV3PkykI0paHcPlSxKkYFEYiA35Yqqs2ZeoTbLUyBi58r9m?=
 =?us-ascii?Q?JxUd06lXPI0q7aOy47dxDT8kJCenrzNDo+u32KVsQUt825so3EASiWVLsjj7?=
 =?us-ascii?Q?QM3SUEWEMEDOJxhvWNM4PEin425MdQowbYTYY3cX4GB/tAQjdxQUKff9PyJz?=
 =?us-ascii?Q?bKc+5Y/UzqWUbcTcvuAX5j3yl+8cgn0UUYxH//Y8s0w+KmwLGMQ4L9Hceqm7?=
 =?us-ascii?Q?BvWXQKX7Fa1spnoF5X/GKRQUnl9lixlsr+QPEZOc8Si7NFObNfxQwgbjKg26?=
 =?us-ascii?Q?mkzx54jMO7s7nmuYP9B3Y2OJdDz+BrsJWgOYaByIrnmibYMYXYBmatBBbBn/?=
 =?us-ascii?Q?fngWSeuy1P/ATxiw3Ax8Y1Rr2cBTn9sb1It3pmxiFmC+wCAm20HjuukrZo8Z?=
 =?us-ascii?Q?w0aLCHD694cBkN9JLKsnYzba2Z8grxreo9SONxzeL1A2eMvhJ+Fda6ujPZj6?=
 =?us-ascii?Q?qZhSXh/KFEbkUw/xa20EmI8ftwLWcOorBv7GaFMpqFHrD67aGkraOwMhl26j?=
 =?us-ascii?Q?sRJ5OK7ES1LjJ276Xr68x09WgkA4Q5JbvOsBFfO9T0/b86qpRAA3bh/FKJGe?=
 =?us-ascii?Q?mPtmfWHBCLzi77DpjfeyG4gmiHIueFtk93xCcj+kRFWNdo5R+NDC95xRgqhg?=
 =?us-ascii?Q?fz7jMI9jzHzHKgPDreiqvHoNuMzlhHGjWTPllDVnLB0mIuJwRFLobAnWU0yp?=
 =?us-ascii?Q?5LJoXznVAd2I+h5bnpI5IwWCc58N/0aMvozodanf6e7cjP0w7iPSaoFzObFT?=
 =?us-ascii?Q?4IZE+Le2cUblU9jNI9OG+kw2qWc0lYxVFb3x4/mhFx6bQ2bPc/Bjub7ni9gq?=
 =?us-ascii?Q?fK7xrx/rVSGW87R16izZTK3XWTY6CIXMBEqYcBHTAUNGb7op76CdgPshEuk2?=
 =?us-ascii?Q?XuqDfwtkKsguP6tYKc/eGh0ZTb467ZzdoIfsB+2JBpMuTha1QoCaobf67O3i?=
 =?us-ascii?Q?+IYvPSFt3ArV19HwfHY2u8pIZhhR/TBIQZfICyTjhhlPRPKsKGVMUSo6v5bV?=
 =?us-ascii?Q?dvMKR/72xmZrLveEDZBrBolR8XnJ32DkrUypi3rIlFGjwN0AAB7jjRSzIesy?=
 =?us-ascii?Q?pObiyKV+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948ef37d-8413-4b9d-0ac6-08d8b6b81bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:08:32.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SsTq64rxxxPLXH6SjWuN3ImL/UjQ0fnU36rOa0GrfMZNIpTqNt8R7IOoUlOSTguoYBILtTxSWVfzrJ2KqSMj/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6596
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 13:26, Chaitanya Kulkarni wrote:=0A=
> In this preparation patch, we add helpers to convert lbas to sectors &=0A=
> sectors to lba. This is needed to eliminate code duplication in the ZBD=
=0A=
> backend.=0A=
> =0A=
> Use these helpers in the block device backend.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  8 +++-----=0A=
>  drivers/nvme/target/nvmet.h       | 10 ++++++++++=0A=
>  2 files changed, 13 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index 125dde3f410e..23095bdfce06 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *r=
eq)=0A=
>  	if (is_pci_p2pdma_page(sg_page(req->sg)))=0A=
>  		op |=3D REQ_NOMERGE;=0A=
>  =0A=
> -	sector =3D le64_to_cpu(req->cmd->rw.slba);=0A=
> -	sector <<=3D (req->ns->blksize_shift - 9);=0A=
> +	sector =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
>  =0A=
>  	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
>  		bio =3D &req->b.inline_bio;=0A=
> @@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req =
*req,=0A=
>  	int ret;=0A=
>  =0A=
>  	ret =3D __blkdev_issue_discard(ns->bdev,=0A=
> -			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),=0A=
> +			nvmet_lba_to_sect(ns, range->slba),=0A=
>  			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),=0A=
>  			GFP_KERNEL, 0, bio);=0A=
>  	if (ret && ret !=3D -EOPNOTSUPP) {=0A=
> @@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nv=
met_req *req)=0A=
>  	if (!nvmet_check_transfer_len(req, 0))=0A=
>  		return;=0A=
>  =0A=
> -	sector =3D le64_to_cpu(write_zeroes->slba) <<=0A=
> -		(req->ns->blksize_shift - 9);=0A=
> +	sector =3D nvmet_lba_to_sect(req->ns, write_zeroes->slba);=0A=
>  	nr_sector =3D (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<=0A=
>  		(req->ns->blksize_shift - 9));=0A=
>  =0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 592763732065..8776dd1a0490 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *=
ns)=0A=
>  	return ns->pi_type && ns->metadata_size =3D=3D sizeof(struct t10_pi_tup=
le);=0A=
>  }=0A=
>  =0A=
> +static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sec=
t)=0A=
> +{=0A=
> +	return cpu_to_le64(sect >> (ns->blksize_shift - SECTOR_SHIFT));=0A=
> +}=0A=
> +=0A=
> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba=
)=0A=
> +{=0A=
> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
> +}=0A=
> +=0A=
>  #endif /* _NVMET_H */=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
