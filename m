Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD929C6379D
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5C3208CA
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MA0JpLws";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B7+MOzLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbgKZJG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 04:06:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35028 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgKZJG0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 04:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606381585; x=1637917585;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qbu+ekNLIWMxXDZMV49jcS3gK5EL63lmabtnl/A7/uI=;
  b=MA0JpLwsZngjN0mZUIYS9/03ul00jUHn9lWrCqj0G76HJez6qvHKxse9
   SZuNOLwTcPTqBv6o+X0B4wTKyR44rbwlXRCBPkjpZAmdxi1Is0ZPEbBm9
   p7NAK5oJYZAjUZerbIPRp9IvfK6F0BKSDvSBMK67+xI/XiuW1tmBvnEnE
   GM+WOEwRJctYaVOnyxLKl3lI2lEy13eIhVMXTlbVjVBLb0AWZXtjKRvGH
   NHz4LUREwSKUra4ZwgDlgoZ/C2vmfKiFYXO4oiGDQUy1ZKR9rBiA6Hv2h
   Abwm3ODGLT/zoPS1LYjS91oxFIjNjfyH928gqVm2uDWz/ZmMCBvV70gBl
   w==;
IronPort-SDR: C+nl1rdCpohH87743YKXsN5Jc2h2J2MQ7E3e7ktOo8zCBx11mCxrgxft8JTh+oP1SKE2MVMrRX
 lm+3rSlp79Q2+wo6ueNwQ30h+Tqlv18lnYQiWE0P+GwHOLiL6IJAt8oEyyeHZnuN9ZDbTQEUE9
 g0lmNTndXp5twJxfFCXVODLbZb9FuXpivzcbcp0bU05GdBGXVOhHvWXnK1BpFWPYJirtDTocFA
 r3VChMh4KxmEUCKZwQPUiORYITb0zVjTgV9hx2/5tbpDmzb1Yvhvqgx0GegX977idkveTiOsHJ
 +SU=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="263623714"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 17:06:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qk7BjdnIMTxTsWY3AvRsff+i4IytE9yFFEmjJRuR12zY2QPpP0NAklx4Iek1/HuIFg99LzyoMLFPSsE3HzfdNreNwIV5PN/ahgGqf35mas3G4p2pVKUT5waq98Up0z+QPCylkbHMaXH7ciu2BA67wzfh7WLOQCQOHCAys3dyMcx8jenu4iGFKZAMBvHsoHHrCh7Brlb8s/dmJWmSPm1fO0O/N+tdQDJaWd51YmNaVIY9wKVDCRIELTFHmcjBcgde3Km0bVEXqVUgoenefGDJm9pjNdfnQIn1y4FMOo08eiOOO0KLr3m7ZCCZPNcnOJo/gJcVZKP/nPLlANIbEhov/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXCPHWvU9envDfr7wmbr5aqjpMYm0zMt9ZLPNPTqiA=;
 b=Bvz8cooTuAsQ1FGdIygm2c8TTvXeLmbKGLgA0lTT7EqJUgQ2DPg9t3JFRkkdxe7gUb6fCe5uy2alKLa+1zSb+xeyZp8Von/BALBsz0jqgHQSuFIVYb4Acy0pm/rt+tq1XcwzOaLEs+EnlI5NZ8hgmgzBmhzC10uo1m4fgB9l+wVjpqvgpmwrKP5Lnq1UyNpsXgsPCf9ug6SqsU/tXHF2JAb8rSu+thjzEp1JJ5zWVuMcrPVDLX56ruysOf8yM5Oo89uGTBNn34ncT3jN9u6tkuBj8LOIxdQ19fxfVbp0Pp5f1Q2hlJLVu9iBoGjeWiZPqhx1ySqSqS9RU2tGWOWiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mXCPHWvU9envDfr7wmbr5aqjpMYm0zMt9ZLPNPTqiA=;
 b=B7+MOzLbRq8aSDi9XChTYrxV9h6rtb05esVPEv66PvE2Lwlod+LpNcRxQ8KhqvGWOTKQL7OW+BXAMTQYQVV4wDUYZ+sfLlEGAIXhSgZxR5aaePyNrfunsPx+5YSidXXtOCEAsORaEAI+S2jsBzQRGb6xhd+OlW9EGvlf6Fkl2qc=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 09:06:23 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 09:06:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date:   Thu, 26 Nov 2020 09:06:23 +0000
Message-ID: <CH2PR04MB652267A218F1EAD32E2DC8BAE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50a75801-066d-4296-c21d-08d891ea8c80
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB698134AB0C700DB0C4764917E7F90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVm70d1VVdgDzyg11tsbiE/lFqZP2ihqoO5Fmuyeen6HnSbblknzsaytprPsQyxg6nWm6ZamWxUl/JLDuQolJTy4f374bHzo3OQTfbL/SSyr1Tq6ll6t3RoF02Wlp6d+bZMseBE1QpubDsopN0qE6jlC7y3F2rGvwgJY++E30bluAfEat2dj5nJ6EEAH+mEvY/QBH8CK2IIShghwh4AeSXQQcUmU85OEa3SQnxNqPDYUiXY6P3a7qnnaPOLp+fxcZN/hlzWyCsxWy+jDa/szYj3hCtbNyIcLba3Ar20RsAAAEI1TgAnd4F9FSgj6cPtQKWs+7CvDnMQ3z3CPar8KTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(64756008)(66446008)(186003)(4326008)(66946007)(54906003)(9686003)(110136005)(6506007)(2906002)(53546011)(7696005)(55016002)(478600001)(316002)(33656002)(76116006)(66556008)(66476007)(91956017)(8936002)(5660300002)(86362001)(8676002)(30864003)(71200400001)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?4c11Dj49id59VmNJrJWlqcg/3cungRFssP9ZfhHAWfNE69gPNlM7O7ce0jax?=
 =?us-ascii?Q?KsBCdu5+x6UoAqG7pLTVO9F0scgs/+t37PUVUuytyhSLsA0nfhqGGSdzJleH?=
 =?us-ascii?Q?ejQE4mnYvce/ofJ+CHJqs6SXTFueUOqRiEPWP3m+wlg2/esVstlSnBnF5QBV?=
 =?us-ascii?Q?UdIjcQHebG+/ChKun7rGXmHzhvcUzKK5NABKkqKEB1x7V56Shs0WLihGGfxe?=
 =?us-ascii?Q?eLIz9X0Wmj89VlORtsQdrKkP6qixrqVT40a450J4EHzQxOvpPnU/c2IgmJzO?=
 =?us-ascii?Q?2Ju1+djDWOYjEvmjrD7gTfdPPkBmGBZ935+JMGcrLS15/33eep1edAUEz33V?=
 =?us-ascii?Q?YO0PMB8MHAjZ2qo5PpHt05IETObxLTTmh6roxkKg/uN6h978CBka2rXZxoU3?=
 =?us-ascii?Q?ofWC8de/kbtdzBAni5P/BudbX3MPphqxF43T3lhFS5GWN7rUu0E2RA5Fzo/Q?=
 =?us-ascii?Q?zB5DHx35MgpshIJfFoLF3CIzWECa62AKwn+flcqyACQDt7dL2jeWy8f5eMIN?=
 =?us-ascii?Q?RyDmbVSapJ+8N3XoRCG8t0n/qWBqQsz2hYd+q1qxmSSljvUNofkGBLoUYY7V?=
 =?us-ascii?Q?gKMuEEdvqi0xqK2SsumvnXLEXX8H9+BqMCfkUr0tZ2JcCb2SMIToz8p59QaO?=
 =?us-ascii?Q?1kq0sOVsHXTCmI1g9BlsjPutH0eIFht9TcAlp0ifQIlLsdOXD/QRSV/P5Wmu?=
 =?us-ascii?Q?ZC6zykpZ2YUDtfFPrJGmK/31Z424LH4GzuULHH8GKzQ617n61jOHgF5aaQuS?=
 =?us-ascii?Q?ZBKeKQiMR0DMc/qCt5WZ+uJ7hxpfzhWo7d2ruj2X+aRfIFSqs+FoPUvnKVxy?=
 =?us-ascii?Q?C5ctyH7jruAAMlEhbcciNMJdxN9ciDruqIsbdsz0poTBw3C+KTQkrOnojNS8?=
 =?us-ascii?Q?Nhc/xFWhmiECizR56lv+MX5Rkqkmdc2pXPtzOj6V/44Z45cvL/QlyvUtue8+?=
 =?us-ascii?Q?eGaH3XYUV/jQBf5AFNOYgK0VnSb+jPpB35/L6wFhlzxHUJRFuXUHKxbPLBAx?=
 =?us-ascii?Q?cI6IohSmvlcTDbVy28r1s1prZBhImD90agrGmMoNByd680/l46xcaFYjkajV?=
 =?us-ascii?Q?jFnNpHht?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a75801-066d-4296-c21d-08d891ea8c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 09:06:23.7552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIA9eg1VwxozgsLjEPMBxS46LmTLbBneNHKyXYgdXWJ603yykw9RJgiJXgkz83U4u3YVH4tgBPRcRNc9G4tV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,=0A=
> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS=
=0A=
> support for bdev.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/Makefile      |   2 +=0A=
>  drivers/nvme/target/admin-cmd.c   |   4 +-=0A=
>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>  drivers/nvme/target/nvmet.h       |  18 ++=0A=
>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++=
=0A=
>  5 files changed, 413 insertions(+), 3 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
> index ebf91fc4c72e..bc147ff2df5d 100644=0A=
> --- a/drivers/nvme/target/Makefile=0A=
> +++ b/drivers/nvme/target/Makefile=0A=
> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
> +=0A=
>  nvme-loop-y	+=3D loop.o=0A=
>  nvmet-rdma-y	+=3D rdma.o=0A=
>  nvmet-fc-y	+=3D fc.o=0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index dca34489a1dc..509fd8dcca0c 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvme=
t_req *req)=0A=
>  	nvmet_req_complete(req, status);=0A=
>  }=0A=
>  =0A=
> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 l=
en,=0A=
> -				    void *id, off_t *off)=0A=
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
> +			     void *id, off_t *off)=0A=
>  {=0A=
>  	struct nvme_ns_id_desc desc =3D {=0A=
>  		.nidt =3D type,=0A=
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-c=
md-file.c=0A=
> index 0abbefd9925e..2bd10960fa50 100644=0A=
> --- a/drivers/nvme/target/io-cmd-file.c=0A=
> +++ b/drivers/nvme/target/io-cmd-file.c=0A=
> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist =
*sg)=0A=
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)=0A=
>  {=0A=
>  	bv->bv_page =3D sg_page(sg);=0A=
>  	bv->bv_offset =3D sg->offset;=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 592763732065..0542ba672a31 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -81,6 +81,9 @@ struct nvmet_ns {=0A=
>  	struct pci_dev		*p2p_dev;=0A=
>  	int			pi_type;=0A=
>  	int			metadata_size;=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +	struct nvme_id_ns_zns	id_zns;=0A=
> +#endif=0A=
>  };=0A=
>  =0A=
>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)=0A=
> @@ -251,6 +254,10 @@ struct nvmet_subsys {=0A=
>  	unsigned int		admin_timeout;=0A=
>  	unsigned int		io_timeout;=0A=
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
> +=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +	struct nvme_id_ctrl_zns	id_ctrl_zns;=0A=
> +#endif=0A=
>  };=0A=
>  =0A=
>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *=
ns)=0A=
>  	return ns->pi_type && ns->metadata_size =3D=3D sizeof(struct t10_pi_tup=
le);=0A=
>  }=0A=
>  =0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);=0A=
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);=0A=
> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
> +			     void *id, off_t *off);=0A=
> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);=
=0A=
>  #endif /* _NVMET_H */=0A=
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> new file mode 100644=0A=
> index 000000000000..8ea6641a55e3=0A=
> --- /dev/null=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -0,0 +1,390 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * NVMe ZNS-ZBD command implementation.=0A=
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
> + */=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> +#include <linux/uio.h>=0A=
> +#include <linux/nvme.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +#include <linux/module.h>=0A=
> +#include "nvmet.h"=0A=
> +=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +=0A=
> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)=0A=
> +{=0A=
> +	u16 status =3D 0;=0A=
> +=0A=
> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +out:=0A=
> +	return status;=0A=
> +}=0A=
> +=0A=
> +static struct block_device *nvmet_bdev(struct nvmet_req *req)=0A=
> +{=0A=
> +	return req->ns->bdev;=0A=
> +}=0A=
> +=0A=
> +static u64 nvmet_zones_to_descsize(unsigned int nr_zones)=0A=
> +{=0A=
> +	return sizeof(struct nvme_zone_report) +=0A=
> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);=0A=
> +}=0A=
> +=0A=
> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)=
=0A=
> +{=0A=
> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);=0A=
> +}=0A=
> +=0A=
> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba=
)=0A=
> +{=0A=
> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + *  ZNS related command implementation and helprs.=0A=
> + */=0A=
> +=0A=
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
> +{=0A=
> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
> +=0A=
> +	if (bdev_is_zoned(nvmet_bdev(req))) {=0A=
> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
> +						 NVME_NIDT_CSI_LEN,=0A=
> +						 &nvme_cis_zns, off);=0A=
> +	}=0A=
> +=0A=
> +	return NVME_SC_SUCCESS;=0A=
> +}=0A=
> +=0A=
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
> +{=0A=
> +	log->iocs[nvme_cmd_zone_append]		=3D cpu_to_le32(1 << 0);=0A=
> +	log->iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
> +	log->iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
> +}=0A=
> +=0A=
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {=0A=
> +		pr_err("block device with conventional zones not supported.");=0A=
> +		return false;=0A=
> +	}=0A=
> +	/*=0A=
> +	 * SMR drives will results in error if writes are not aligned to the=0A=
> +	 * physical block size just override.=0A=
> +	 */=0A=
> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));=
=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned int=
 idx,=0A=
> +				     void *data)=0A=
> +{=0A=
> +	struct blk_zone *zones =3D data;=0A=
> +=0A=
> +	memcpy(&zones[idx], zone, sizeof(struct blk_zone));=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z,=
=0A=
> +				struct nvme_zone_descriptor *rz)=0A=
> +{=0A=
> +	rz->zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));=0A=
> +	rz->zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));=0A=
> +	rz->wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));=0A=
> +	rz->za =3D z->reset ? 1 << 2 : 0;=0A=
> +	rz->zt =3D z->type;=0A=
> +	rz->zs =3D z->cond << 4;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * ZNS related Admin and I/O command handlers.=0A=
> + */=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +	struct nvme_id_ctrl_zns *id;=0A=
> +	u16 status =3D 0;=0A=
> +=0A=
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
> +	if (!id) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	/*=0A=
> +	 * Even though this function sets Zone Append Size Limit to 0,=0A=
> +	 * the 0 value here indicates that the maximum data transfer size for=
=0A=
> +	 * the Zone Append command is indicated by the ctrl=0A=
> +	 * Maximum Data Transfer Size (MDTS).=0A=
> +	 */=0A=
> +	id->zasl =3D 0;=0A=
> +=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));=0A=
> +=0A=
> +	kfree(id);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +{=0A=
> +	struct nvme_id_ns_zns *id_zns;=0A=
> +	u16 status =3D 0;=0A=
> +	u64 zsze;=0A=
> +=0A=
> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {=0A=
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);=0A=
> +	if (!id_zns) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid=
);=0A=
> +	if (!req->ns) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto done;=0A=
> +	}=0A=
> +=0A=
> +	if (!bdev_is_zoned(nvmet_bdev(req))) {=0A=
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto done;=0A=
> +	}=0A=
> +=0A=
> +	nvmet_ns_revalidate(req->ns);=0A=
> +	zsze =3D (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>=0A=
> +					req->ns->blksize_shift;=0A=
> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));=0A=
> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));=0A=
> +=0A=
> +done:=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
> +	kfree(id_zns);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +	struct request_queue *q =3D nvmet_bdev(req)->bd_disk->queue;=0A=
> +	struct nvme_zone_mgmt_recv_cmd *zmr =3D &req->cmd->zmr;=0A=
> +	unsigned int nz =3D blk_queue_nr_zones(q);=0A=
> +	u64 bufsize =3D (zmr->numd << 2) + 1;=0A=
> +	struct nvme_zone_report *rz;=0A=
> +	struct blk_zone *zones;=0A=
> +	int reported_zones;=0A=
> +	sector_t sect;=0A=
> +	u64 desc_size;=0A=
> +	u16 status;=0A=
> +	int i;=0A=
> +=0A=
> +	desc_size =3D nvmet_zones_to_descsize(blk_queue_nr_zones(q));=0A=
> +	status =3D nvmet_bdev_zns_checks(req);=0A=
> +	if (status)=0A=
> +		goto out;=0A=
> +=0A=
> +	zones =3D kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),=0A=
> +			      sizeof(struct blk_zone), GFP_KERNEL);=0A=
> +	if (!zones) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
> +	if (!rz) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out_free_zones;=0A=
> +	}=0A=
> +=0A=
> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));=
=0A=
> +=0A=
> +	for (nz =3D blk_queue_nr_zones(q); desc_size >=3D bufsize; nz--)=0A=
> +		desc_size =3D nvmet_zones_to_descsize(nz);=0A=
=0A=
desc_size is actually not used anywhere to do something. So what is the pur=
pose=0A=
of this ? If only to determine nz, the number of zones that can be reported=
,=0A=
surely you can calculate it instead of using this loop.=0A=
=0A=
> +=0A=
> +	reported_zones =3D blkdev_report_zones(nvmet_bdev(req), sect, nz,=0A=
> +					     nvmet_bdev_report_zone_cb,=0A=
> +					     zones);=0A=
> +	if (reported_zones < 0) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out_free_report_zones;=0A=
> +	}=0A=
> +=0A=
> +	rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
> +	for (i =3D 0; i < reported_zones; i++)=0A=
> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);=0A=
> +=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, rz, bufsize);=0A=
> +=0A=
> +out_free_report_zones:=0A=
> +	kvfree(rz);=0A=
> +out_free_zones:=0A=
> +	kvfree(zones);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t nr_sect =3D bdev_zone_sectors(nvmet_bdev(req));=0A=
> +	struct nvme_zone_mgmt_send_cmd *c =3D &req->cmd->zms;=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	enum req_opf op;=0A=
> +	sector_t sect;=0A=
> +	int ret;=0A=
> +=0A=
> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));=
=0A=
> +=0A=
> +	switch (c->zsa) {=0A=
> +	case NVME_ZONE_OPEN:=0A=
> +		op =3D REQ_OP_ZONE_OPEN;=0A=
> +		break;=0A=
> +	case NVME_ZONE_CLOSE:=0A=
> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
> +		break;=0A=
> +	case NVME_ZONE_FINISH:=0A=
> +		op =3D REQ_OP_ZONE_FINISH;=0A=
> +		break;=0A=
> +	case NVME_ZONE_RESET:=0A=
> +		if (c->select_all)=0A=
> +			nr_sect =3D get_capacity(nvmet_bdev(req)->bd_disk);=0A=
> +		op =3D REQ_OP_ZONE_RESET;=0A=
> +		break;=0A=
> +	default:=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNEL=
);=0A=
> +	if (ret)=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +	unsigned long bv_cnt =3D min(req->sg_cnt, BIO_MAX_PAGES);=0A=
> +	int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
> +	u64 slba =3D le64_to_cpu(req->cmd->rw.slba);=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, slba);=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	int sg_cnt =3D req->sg_cnt;=0A=
> +	struct scatterlist *sg;=0A=
> +	size_t mapped_data_len;=0A=
> +	struct iov_iter from;=0A=
> +	struct bio_vec *bvec;=0A=
> +	size_t mapped_cnt;=0A=
> +	size_t io_len =3D 0;=0A=
> +	struct bio *bio;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
> +		return;=0A=
> +=0A=
> +	if (!req->sg_cnt) {=0A=
> +		nvmet_req_complete(req, 0);=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	bvec =3D kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);=0A=
> +	if (!bvec) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	while (sg_cnt) {=0A=
> +		mapped_data_len =3D 0;=0A=
> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {=0A=
> +			nvmet_file_init_bvec(bvec, sg);=0A=
> +			mapped_data_len +=3D bvec[mapped_cnt].bv_len;=0A=
> +			sg_cnt--;=0A=
> +			if (mapped_cnt =3D=3D bv_cnt)=0A=
> +				break;=0A=
> +		}=0A=
> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);=0A=
> +=0A=
> +		bio =3D bio_alloc(GFP_KERNEL, bv_cnt);=0A=
> +		bio_set_dev(bio, nvmet_bdev(req));=0A=
> +		bio->bi_iter.bi_sector =3D sect;=0A=
> +		bio->bi_opf =3D op;=0A=
> +=0A=
> +		ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
> +		if (unlikely(ret)) {=0A=
> +			status =3D NVME_SC_INTERNAL;=0A=
> +			bio_io_error(bio);=0A=
> +			kfree(bvec);=0A=
> +			goto out;=0A=
> +		}=0A=
> +=0A=
> +		ret =3D submit_bio_wait(bio);=0A=
> +		bio_put(bio);=0A=
> +		if (ret < 0) {=0A=
> +			status =3D NVME_SC_INTERNAL;=0A=
> +			break;=0A=
> +		}=0A=
> +=0A=
> +		io_len +=3D mapped_data_len;=0A=
> +	}=0A=
> +=0A=
> +	sect +=3D (io_len >> 9);=0A=
> +	req->cqe->result.u64 =3D le64_to_cpu(nvmet_sect_to_lba(req->ns, sect));=
=0A=
> +	kfree(bvec);=0A=
> +=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
> +{=0A=
> +	return 0;=0A=
> +}=0A=
> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	return false;=0A=
> +}=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
> +{=0A=
> +}=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
