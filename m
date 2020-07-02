Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE6C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D1720772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nEbroeQw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uuyLIfUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGBIQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:16:40 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38413 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBIQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593677842; x=1625213842;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BF6uCMC1+8I5m0Y5hbm/1x8AFFQTFnfEdMJr06GRmR8=;
  b=nEbroeQw0Fv6LNADd8V1jrgccGKtrfmWD+dsIBjWCN9X+a9w8JOBSYYa
   GWhAOAcDb6jS8XCECtYdyJ1Q4vu2X1uQ1bIoYmOwMt+ljNvfXxL1u1AG3
   AHnjNbKygU1zMdxrYiz3aEvKMw8hdr8WMp571NAyD//2k+gtNSfDpZIcJ
   kdkdjN/Lz9eTC/TXmSWU6wQ0qANP8LIA8wrzSYAsN4U9xulnQmFseGK5E
   Ao3a3t7LL6QDK/V6NaQq8cPg40kkZi57bEO+QbvN77q1e9tz9NAUDgOqs
   wi+21Hlk52n4dgpfGfpawfyLWr47HvrKMcrYLq5ElkzlrldAQ2MjSBZcl
   g==;
IronPort-SDR: aBIYY4Unm3M1FnZHw/wW94+vEmN5aSR5+rMsUvFaxLYeH5hVr/xj1PWNevpVynwwc6/hmiFvPn
 UjWFM2pKQTnn9Dwi2YCQ7Vv51Lnr9o6IDqkJexUUMl7ksj+LyVyjXzWXMF98okHdR1mzS0YPOB
 bJMicthn4JKb9JG46OZGJ/I6V9TfYWJ04GhUU9XmX3wQRcAYh7feNiINkj1U7n12ZXlLR7qT3o
 +ffU7uFS55FNPrx7Q+w85B0z2udNoFPVt22dWUa3y7B95ncgBnNSSDwK4x9G0U5/jlVLLooQBF
 4CM=
X-IronPort-AV: E=Sophos;i="5.75,303,1589212800"; 
   d="scan'208";a="244482635"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 16:17:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZFVuCNrSHNH5cNYR9H4rFXK6bVDwtgfEKsK4eGBZVs2Fl10z0soG6okO9Of9RiUb60i8AP69PaB2UMFnE5DwwH5aCZCKWLIUdMNAvHCY5X8JnREVe0mcGLLvrQKY0KiqX//VLgbR375OvPyxpC5ofFHezLEMfjevvSwnOQdXiIQcTrc8hnZIbK+ZAR7ts+DLUA5ZDXUakVs4KZg14glHhjBx82dHDsyPoeehJ2FTY0acLS22NMx7bk/FoHGq9xJVkgtSYr7TxyGNGx7ywDXSDT8U4IJ1XvzKUdTDg+0oZxrJmqw5VGapVy47Nn5y7lztcXK5XAnBvxeubEt/af5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8KWItM9eclKG7Qq2UzdQjaE2Mu7kkV8XnlFOrr5FlY=;
 b=aa/V4Dcq4sn7FjWETTq70I9yVV9adqUIRzAqqpZAbtvjGNrCKGPzbCEa4ynAx5352FRWPOT51RU1UHlA6acwr0QQ7kZm8ksfxcGGvFMz/5ztd6mxlWhCcRfsVqbcel9gWCX8HFS9Vy1KWkNBji4KgLM9qrk3wcElmQSSrQDKyXbHwsqrwVjpbuS9o93bYKitnTmVGR+FVWw4IgD+CFUJIbn5pvxF9nhg0DxPcnqXtQAv0uNACvgtslOsuDkj0fIHtY05E/yegyOvwrl+D9UoKFvcyXesOT36pwN3jV9QKfqAGHacU/O1e3DwHK4Vk6NdmPQcPC5LpfGPv0vNPjhG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8KWItM9eclKG7Qq2UzdQjaE2Mu7kkV8XnlFOrr5FlY=;
 b=uuyLIfUKtllLTRkm6B45l+qTzg1NXhXf5+HGJC2WfCdyl/XWw+G0bfMZSH4Hra/kt4fbv9cuakciSvGbmiqxpt0jkmJ/w1l76tonnGKJqTxvOdUE4u3ny2dNHyJPi4gPkVjZ98hNB9kOAr8yzH74sXXOUZ4bNs0aex/ikdWv97k=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0759.namprd04.prod.outlook.com (2603:10b6:903:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 08:16:37 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3153.022; Thu, 2 Jul 2020
 08:16:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Topic: [PATCH 3/4] nvme: Add consistency check for zone count
Thread-Index: AQHWUD261Ibfrs0qX0+rwW8ysnw6hw==
Date:   Thu, 2 Jul 2020 08:16:37 +0000
Message-ID: <CY4PR04MB3751A70BE6C1EA7DC930C9C3E76D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c280d97c-64cc-4544-c365-08d81e603dac
x-ms-traffictypediagnostic: CY4PR04MB0759:
x-microsoft-antispam-prvs: <CY4PR04MB0759A0738BBA46D34ACC2460E76D0@CY4PR04MB0759.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DQjCTKleb/NdlDimQpav9ByLrHwbCPdoIfTBIYAuvhCJltE2mCY1jYdCvCQ3YkrNqY2mzHEq91VYCKXfmEsRaU03zNdPD8nPfPOtp3hJsRjSyng1LgYZyw6x/332VuALToQBbHb8V5WO03HUFW3wQmjtZaxw15XMHuTJmc0grvjqcAcLZv+Ft6e5mWmtUixYK3BIvEaUyHHP0qWGT7yLr2bF2eIaS/L+B9LEdYutNLQwogX4onVXS/0nJOEC/VtojLkfHVBUNJw/1ythoAbDLf5mY26YFxwFFMFiI/tkKxU/ZdPVolFQzsXjqf2FVEQIM45IdvXo3WhRs1WWwQwLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(66446008)(5660300002)(55016002)(52536014)(186003)(7696005)(26005)(6506007)(9686003)(4326008)(53546011)(86362001)(2906002)(33656002)(8676002)(66476007)(66556008)(64756008)(66946007)(316002)(110136005)(76116006)(54906003)(91956017)(8936002)(66574015)(71200400001)(7416002)(83380400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: o46GK/5fq7J69TCiWKWjRGnQlSCFrbyXq/bxcxAwgc78VjVhpWXLU/jAgn0EMTzTYTMtUXeNDX51WECUG06vX33Ct/96PJFtq3KiJDzDzQ9IuSZRAQcsKRzdBLDDbnxNSvzdolRE2Y23Md8INvLoLclgmVESEEAwZ7xkBiHTkcuGv77fmDDy2OIIZ5Fjoiod3EhAt4qtTVZTSGXTj5my7BqJIYQabNRj64ApF6kO4Ur91g5xm7Dsmyeo8VlHG0uKGYnbS4HpN7goL6aflTOweGnozIdEBzjjG2FC/KJrcm5FUnVM8LY1aNOGCWzN+TTHYVl6EP4xWeyc29M5bIke2UXrDnm3KA9Ijn8YFI5OvggtzOu9bJc3pmOM5eyP/0cIRjj3FT2Q+meNzM0FXfoMz9SrN4kd6Nt2oexbzvb4iAf7Yt8HR3bJg/Bm7tdI/bk4LH1p8jwB4lRIdsds4O7dp7F46s00VucEYK/TIkr+9R2ffcW+Lf6YaPO49mJfqfTL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c280d97c-64cc-4544-c365-08d81e603dac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 08:16:37.2251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dXS3FPS2HZHSaCaK7lbnrJw6NidnVUK4hjb+DN2OrL/sjYlcmIQcW80xuYLWNJ0ziQOt5MdDI2AzcCeHzYbnEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0759
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/02 15:55, Javier Gonz=E1lez wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> =0A=
> Since the number of zones is calculated through the reported device=0A=
> capacity and the ZNS specification allows to report the total number of=
=0A=
> zones in the device, add an extra check to guarantee consistency between=
=0A=
> the device and the kernel.=0A=
> =0A=
> Also, fix a checkpatch warning: unsigned -> unsigned int in the process=
=0A=
> =0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> ---=0A=
>  drivers/nvme/host/core.c |  2 +-=0A=
>  drivers/nvme/host/nvme.h |  6 ++++--=0A=
>  drivers/nvme/host/zns.c  | 39 ++++++++++++++++++++++++++++++++++++++-=0A=
>  3 files changed, 43 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 1f5c7fc3d2c9..8b9c69172931 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1994,7 +1994,7 @@ static int __nvme_revalidate_disk(struct gendisk *d=
isk, struct nvme_id_ns *id)=0A=
>  	case NVME_CSI_NVM:=0A=
>  		break;=0A=
>  	case NVME_CSI_ZNS:=0A=
> -		ret =3D nvme_update_zone_info(disk, ns, lbaf);=0A=
> +		ret =3D nvme_update_zone_info(disk, ns, lbaf, le64_to_cpu(id->nsze));=
=0A=
>  		if (ret)=0A=
>  			return ret;=0A=
>  		break;=0A=
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h=0A=
> index 662f95fbd909..ef80e0b4df56 100644=0A=
> --- a/drivers/nvme/host/nvme.h=0A=
> +++ b/drivers/nvme/host/nvme.h=0A=
> @@ -407,6 +407,7 @@ struct nvme_ns {=0A=
>  	u32 sws;=0A=
>  	u8 pi_type;=0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
> +	u64 nr_zones;=0A=
>  	u64 zsze;=0A=
>  #endif=0A=
>  	unsigned long features;=0A=
> @@ -700,7 +701,7 @@ static inline void nvme_mpath_start_freeze(struct nvm=
e_subsystem *subsys)=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,=0A=
> -			  unsigned lbaf);=0A=
> +			  unsigned int lbaf, sector_t nsze);=0A=
>  =0A=
>  int nvme_report_zones(struct gendisk *disk, sector_t sector,=0A=
>  		      unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
> @@ -720,7 +721,8 @@ static inline blk_status_t nvme_setup_zone_mgmt_send(=
struct nvme_ns *ns,=0A=
>  =0A=
>  static inline int nvme_update_zone_info(struct gendisk *disk,=0A=
>  					struct nvme_ns *ns,=0A=
> -					unsigned lbaf)=0A=
> +					unsigned lbaf=0A=
=0A=
missing a comma here. Does this even compiles ?=0A=
=0A=
> +					sector_t nsze)=0A=
>  {=0A=
>  	dev_warn(ns->ctrl->device,=0A=
>  		 "Please enable CONFIG_BLK_DEV_ZONED to support ZNS devices\n");=0A=
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c=0A=
> index b34d2ed13825..d785d179a343 100644=0A=
> --- a/drivers/nvme/host/zns.c=0A=
> +++ b/drivers/nvme/host/zns.c=0A=
> @@ -32,13 +32,36 @@ static int nvme_set_max_append(struct nvme_ctrl *ctrl=
)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static u64 nvme_zns_nr_zones(struct nvme_ns *ns)=0A=
> +{=0A=
> +	struct nvme_command c =3D { };=0A=
> +	struct nvme_zone_report report;=0A=
> +	int buflen =3D sizeof(struct nvme_zone_report);=0A=
> +	int ret;=0A=
> +=0A=
> +	c.zmr.opcode =3D nvme_cmd_zone_mgmt_recv;=0A=
> +	c.zmr.nsid =3D cpu_to_le32(ns->head->ns_id);=0A=
> +	c.zmr.slba =3D cpu_to_le64(0);=0A=
> +	c.zmr.numd =3D cpu_to_le32(nvme_bytes_to_numd(buflen));=0A=
> +	c.zmr.zra =3D NVME_ZRA_ZONE_REPORT;=0A=
> +	c.zmr.zrasf =3D NVME_ZRASF_ZONE_REPORT_ALL;=0A=
> +	c.zmr.pr =3D 0;=0A=
> +=0A=
> +	ret =3D nvme_submit_sync_cmd(ns->queue, &c, &report, buflen);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	return le64_to_cpu(report.nr_zones);=0A=
> +}=0A=
> +=0A=
>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,=0A=
> -			  unsigned lbaf)=0A=
> +			  unsigned int lbaf, sector_t nsze)=0A=
>  {=0A=
>  //	struct nvme_effects_log *log =3D ns->head->effects;=0A=
>  	struct request_queue *q =3D disk->queue;=0A=
>  	struct nvme_command c =3D { };=0A=
>  	struct nvme_id_ns_zns *id;=0A=
> +	sector_t cap_nr_zones;=0A=
>  	int status;=0A=
>  =0A=
>  	/* Driver requires zone append support */=0A=
> @@ -80,6 +103,20 @@ int nvme_update_zone_info(struct gendisk *disk, struc=
t nvme_ns *ns,=0A=
>  		goto free_data;=0A=
>  	}=0A=
>  =0A=
> +	ns->nr_zones =3D nvme_zns_nr_zones(ns);=0A=
> +	if (!ns->nr_zones) {=0A=
> +		status =3D -EINVAL;=0A=
> +		goto free_data;=0A=
> +	}=0A=
> +=0A=
> +	cap_nr_zones =3D nvme_lba_to_sect(ns, le64_to_cpu(nsze)) >> ilog2(ns->z=
sze);=0A=
> +	if (ns->nr_zones !=3D cap_nr_zones) {=0A=
> +		dev_err(ns->ctrl->device, "inconsistent zone count: %llu/%llu\n",=0A=
> +			ns->nr_zones, cap_nr_zones);=0A=
> +		status =3D -EINVAL;=0A=
> +		goto free_data;=0A=
> +	}=0A=
> +=0A=
=0A=
I am not opposed to this, but I am not sure if this adds anything to the ch=
ecks=0A=
in blk_revalidate_disk_zones() as that does a full zone report that is chec=
ked=0A=
against capacity. This seems more like a test of the drive conformance, che=
cking=0A=
that the report header nr_zones is correct...=0A=
=0A=
>  	q->limits.zoned =3D BLK_ZONED_HM;=0A=
>  	q->zone_flags =3D BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;=0A=
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
