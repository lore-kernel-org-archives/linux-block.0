Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DBC0018C
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A7E23E23
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404685AbgLKBTy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:19:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61437 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404683AbgLKBTv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 20:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607649590; x=1639185590;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/96ml6YGQXQcYPEquZQ+urBZ0kildGvlitiA8YbzSsw=;
  b=XFnCXtWv18PWHPVTlBoMLhtQbO01OeNK9n1AOEH+2kA6JKS44ZaGW4Hm
   nQnevs+YeP7W/nt899NkP1GlxBEvXsHrA4JRj6eCMXGjMiwo1GquJLV9p
   thbl1vam1APEap+1GldPIuwnnS2q7QhavcckGquXhte65HAzkxOrXMNCG
   EG4SIiAE+/8CRYOEPkJioHTN2XBFchJ5H94XqnjKL1HCXlm9F4sveplDx
   SUibE2fLHOS9IsyIA3BXXKaDpgdpgSRFRDx5sLKUV472jy5FTYy7AbXU+
   mdZEKbTQyPFjG5Wy5E2eL2407dqrkyzUmAqS/8Bv4nX2/AlqJ30SR0QFp
   g==;
IronPort-SDR: 59hvkegVpSFRQLoKtUW5xxwraLVvSbt5JS3NtY2y5R+0ibr9J1NBDTl850L1DmhfhPeyr1bKZq
 diRYoO2Hf9YIYgMEaLzBen1CqrmHJsz6l0fMbnSMErTz/7FDXSpxcB3HHMEWAqO0dDP3fZlHbp
 oW9zvmpvBlx5N+1Kp6bap4W1dy2aKg5lMGXfUmGtFmBDNqhbx1243XXMsTJGhTEJxHUYT6Q5oD
 auVZxtWIWFAoEU97ENAUbqjtmmgJV0GE5yKAvFFduzXZLA8b+7B+SaWwbF5Nz18h0v7At1flNg
 Vfk=
X-IronPort-AV: E=Sophos;i="5.78,409,1599494400"; 
   d="scan'208";a="265065358"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2020 09:18:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMhnFNnVtBqRt8tUsphFFsxfFThMc9mATB3iIJhnUZylUPtEDMkZ5aPa758LirdsdZw5eLQZEa9hwPF8fOrBpI3JPn9llVjY5bn3EbqB37puWNJ94OuUlDhMTOWh8iyQnvxphgZ/9oiCOf2ZWweI3hXlKOxgTP6Si8WDBBeT9NlHp6p5LZabq/OQUz8uESO0C7GO/LXez1YWoufuIzW7nHGKK0T/C5XQZEKZ36Vrqss9LDzJlrWtgo0jNT710aXzBDEeOXzMhRSJh6L2Oq8+tL9555vSqEjhGd3ArmYSnidIaXEcsMq1mzsHDCoNaEEKI+5h1Pta2OOea1ZueXu8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14GeeTJJHRocztNVgAe7FDlsYd38XEAXCR+H9CXFRng=;
 b=UijADisgSgSMU0/kIPuMcIfzOv4/5IHDlTarVCAig2kS/50ROmm8QgTD8LVWAWEGO/Zhqrf8QMR+gRaFVsNZAv/mWLx5XyDFwMs6J9jAkLXQPdXZYMyvhyJYJI+57k1Og4K57H5RrvdT6SI2g0GhQwZR0loa9+Y859pjRecNtpmV2jf/I9xEY3MnP5F+FBeIWetpbYeigyJ3BRw7GbT7NUNqGTa12xb8KH1l3i/Om0iKAeJ4ljpON+SpYMAOMqteBwVjeEcsnL71g9Py9TCgyD82ZBUBAcxEiKsmfew/eMOLPP5wWFZCH3yFUPUMGJaTrdbh1J8wV2XMzvpVAGfaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14GeeTJJHRocztNVgAe7FDlsYd38XEAXCR+H9CXFRng=;
 b=fF9PY26KrM61SX8LJblgK/24lacOynFNvSySHW8D9z/EzYNP1cLaMgYKDLJSSHjzZEsQ8SlpercdDogksPNZC8lCO3hbr/Ywe40+7cjz5EyYTgTohEATq/9trNlcVBPdEQEz3Lp7ePNft2eublBn8eGpK9xcvdTzlqh7s9wBQBk=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6588.namprd04.prod.outlook.com (2603:10b6:610:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 11 Dec
 2020 01:18:43 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Fri, 11 Dec 2020
 01:18:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHWzr2FP/i+FdqWaEeC/fieodd2UA==
Date:   Fri, 11 Dec 2020 01:18:43 +0000
Message-ID: <CH2PR04MB652299EA78B1304157CC8234E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5911:8225:c337:ee37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01a90302-859c-4010-7aa0-08d89d72b354
x-ms-traffictypediagnostic: CH2PR04MB6588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB658847B6BFD693A982DA1983E7CA0@CH2PR04MB6588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYwgFlbxEYc3mJgkDMIdd7pMTFVPHYMMAtdGxr617HQRaD2wM8vyMADkyy6m/oOIVWddG7Dlam2uuZNCoPIGb9XEp8FvMQpGdLIbvV/Fyq4FTvxWfOEPZS4EUvU9VUDMpgFoCXmuLDqx6JNt9VSwg7E49xyMZiSaPvl63EiI3yyFJedoYEn3cQXjGG4DquUun6ir/Ar3/fIEf+9Xbw2KBXX7UcSYmX7jdjAGEFUtPPquBNjDpAqVsFpkllMIWbCk7CGHGIqE4O1KW7GU2eje2vBcU/N9GN5WZADucDLbXgD6kSh0UjgkbDAQuf47oy8F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(91956017)(55016002)(9686003)(6506007)(66476007)(83380400001)(5660300002)(30864003)(64756008)(508600001)(66946007)(8676002)(7696005)(186003)(54906003)(52536014)(76116006)(53546011)(66556008)(110136005)(86362001)(33656002)(66446008)(8936002)(4326008)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?M3y2+u/yQkUamieQp3ujeDMYdyTR1JZ6e04PJFuQ/cSLA7kAFujXH8Uy?=
 =?Windows-1252?Q?JmNIeSkA63lCFBRwfiVP+VpFsYdzObxKy3txJfjkRcQhACZ8BfdoNk8d?=
 =?Windows-1252?Q?tzR4Ix08Q+Hw0czAddTweU8Cj1nMPL3oLTjwRJ2i43OdPGujBdvx4obo?=
 =?Windows-1252?Q?xAoIiYuXASw3tmltZjrJCvGPuYFGLJWjLGMeQ3MfKiHgYRqd3hlyAj5Q?=
 =?Windows-1252?Q?oIB/zT3N+F1NBOxcfKnUXHl1oVvmD31SerK3PnJVbncCsczvYocwAhzP?=
 =?Windows-1252?Q?ctLEOTmDgVVa7z2TtA2Sea6XUV9uArwSFlVXW7vsQ16auPiECu0xwuNF?=
 =?Windows-1252?Q?J+wfclIcEK6A+a3HoC5jLXptoDo7aEvttKnvsY+0xV7ktpqSU6EK6hGa?=
 =?Windows-1252?Q?QF4shF75sxGp577MOaUh14D07quykAjoMQGcfu6OnthX0kWZCENLZDaO?=
 =?Windows-1252?Q?5WoN/Pz262CtWHXK3QAdCHlEseEKc3xbudnOZ3UjBZ4oA5k9RGRKqKsc?=
 =?Windows-1252?Q?ehivSrCcjxy7HTD6UtJuc8w1CRgk/3zey7+K6ZqC5tAqlAPJDB3u9GVe?=
 =?Windows-1252?Q?chiy+wBXCyya6QxeuY+JpscsKL98b8ISQtajUZIpIFMJPV/SmRx5naoZ?=
 =?Windows-1252?Q?1d5rnQHOLKaJtkm/fBDc1uar634WMbbKmJeGvr2A7NWbOr7qVEaHDMzr?=
 =?Windows-1252?Q?Ec8fvbNvUfunJGiIa+TDlZxCZE2np+WYKO+BbZfjGs7dWzPvL0NgCda7?=
 =?Windows-1252?Q?8JEPCcqI163RiqHdGw1uAy2S5t5aR1LLYGvPv4dziUXdv2a85P/2utYX?=
 =?Windows-1252?Q?/PuB7ez7emQ/KMMeVKh8w0Hv0yDVH/uW+mo6EkPkcDY4sVvmPZFgH1dI?=
 =?Windows-1252?Q?kanoPKhYBa05QBFp6d+ypEZKv5MlXrLKPxuVBHn9AdCG34lGzi6kRHjq?=
 =?Windows-1252?Q?N5mlf7WqtH9rwkBe16IpAgSjouSlthe+peHou5ekn4Weru3k+dVR67lC?=
 =?Windows-1252?Q?RbyEgECvUbiODKFA827PNA1jVqjDBd8iP7ILmfQm1MBD1FVIrBQJ4QxF?=
 =?Windows-1252?Q?6tFtPSf5W9hsWtXkU717X8JiaoDbuiMmtPJsl50H2K4Hil3SutZyq2nX?=
 =?Windows-1252?Q?AmWwcLj5fCxsA0meojD0jC0p?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a90302-859c-4010-7aa0-08d89d72b354
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 01:18:43.2440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZo9Eyn2YXnBVOEPaBjKHTxzfRaIAy7KSlPgeqBZWXPYufT07lcDURRiopiTZ2pHPCMC9cNB+QB68D7dGWaPjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6588
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/10 15:27, Chaitanya Kulkarni wrote:=0A=
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to=0A=
> communicate with a non-volatile memory subsystem using zones for=0A=
> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe=0A=
> Protocol compliant devices on the target in the passthru mode. There=0A=
> are Generic Zoned Block Devices like  Shingled Magnetic Recording (SMR)=
=0A=
=0A=
Please remove "Generic" from this sentence. It is confusing. Also, I do not=
=0A=
think you need to capitalize ZOned Block Devices. That is something Linux=
=0A=
defines. It is not defined by any standard.=0A=
=0A=
> HDD which are not based on the NVMe protocol.=0A=
> =0A=
> This patch adds ZNS backend to support the ZBDs for NVMeOF target.=0A=
> =0A=
> This support inculdes implementing the new command set NVME_CSI_ZNS,=0A=
=0A=
s/inculdes/includes=0A=
=0A=
> adding different command handlers for ZNS command set such as=0A=
> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,=0A=
> NVMe Zone Management Send and NVMe Zone Management Receive.=0A=
> =0A=
> With new command set identifier we also update the target command effects=
=0A=
> logs to reflect the ZNS compliant commands.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/Makefile      |   1 +=0A=
>  drivers/nvme/target/admin-cmd.c   |  26 +++=0A=
>  drivers/nvme/target/core.c        |   1 +=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-=0A=
>  drivers/nvme/target/nvmet.h       |  38 ++++=0A=
>  drivers/nvme/target/zns.c         | 327 ++++++++++++++++++++++++++++++=
=0A=
>  6 files changed, 418 insertions(+), 8 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
> index ebf91fc4c72e..9837e580fa7e 100644=0A=
> --- a/drivers/nvme/target/Makefile=0A=
> +++ b/drivers/nvme/target/Makefile=0A=
> @@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>  nvme-loop-y	+=3D loop.o=0A=
>  nvmet-rdma-y	+=3D rdma.o=0A=
>  nvmet-fc-y	+=3D fc.o=0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index f4c0f3aca485..6f5279b15aa6 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
uct nvmet_req *req)=0A=
>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);=0A=
>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);=0A=
>  		break;=0A=
> +	case NVME_CSI_ZNS:=0A=
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
> +			u32 *iocs =3D log->iocs;=0A=
> +=0A=
> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);=0A=
> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
> +		}=0A=
> +		break;=0A=
>  	default:=0A=
>  		status =3D NVME_SC_INVALID_LOG_PAGE;=0A=
>  		break;=0A=
> @@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req =
*req, u8 type, u8 len,=0A=
>  =0A=
>  static void nvmet_execute_identify_desclist(struct nvmet_req *req)=0A=
>  {=0A=
> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>  	u16 status =3D 0;=0A=
>  	off_t off =3D 0;=0A=
>  =0A=
> @@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)=0A=
>  		if (status)=0A=
>  			goto out;=0A=
>  	}=0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
> +							  NVME_NIDT_CSI_LEN,=0A=
> +							  &nvme_cis_zns, &off);=0A=
> +		if (status)=0A=
> +			goto out;=0A=
> +	}=0A=
>  =0A=
>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,=
=0A=
>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
> @@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)=0A=
>  	switch (req->cmd->identify.cns) {=0A=
>  	case NVME_ID_CNS_NS:=0A=
>  		return nvmet_execute_identify_ns(req);=0A=
> +	case NVME_ID_CNS_CS_NS:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_CTRL:=0A=
>  		return nvmet_execute_identify_ctrl(req);=0A=
> +	case NVME_ID_CNS_CS_CTRL:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ctrl(req);=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
>  		return nvmet_execute_identify_nslist(req);=0A=
>  	case NVME_ID_CNS_NS_DESC_LIST:=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index 672e4009f8d6..17a99c7134dc 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)=0A=
>  static inline bool nvmet_cc_css_check(u8 cc_css)=0A=
>  {=0A=
>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {=0A=
> +	case NVME_CC_CSS_CSI:=0A=
>  	case NVME_CC_CSS_NVM:=0A=
>  		return true;=0A=
>  	default:=0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index 23095bdfce06..6178ef643962 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvme=
t_ns *ns)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (ns->bdev) {=0A=
> +		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
> +		ns->bdev =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>  {=0A=
>  	int ret;=0A=
> @@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))=0A=
>  		nvmet_bdev_ns_enable_integrity(ns);=0A=
>  =0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
> -{=0A=
> -	if (ns->bdev) {=0A=
> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
> -		ns->bdev =3D NULL;=0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {=0A=
> +		if (!nvmet_bdev_zns_enable(ns)) {=0A=
> +			nvmet_bdev_ns_disable(ns);=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
> +		ns->csi =3D NVME_CSI_ZNS;=0A=
>  	}=0A=
> +=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)=0A=
> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)=
=0A=
>  	case nvme_cmd_write_zeroes:=0A=
>  		req->execute =3D nvmet_bdev_execute_write_zeroes;=0A=
>  		return 0;=0A=
> +	case nvme_cmd_zone_append:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_append;=0A=
> +		return 0;=0A=
> +	case nvme_cmd_zone_mgmt_recv:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;=0A=
> +		return 0;=0A=
> +	case nvme_cmd_zone_mgmt_send:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;=0A=
> +		return 0;=0A=
>  	default:=0A=
>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,=0A=
>  		       req->sq->qid);=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 0360594abd93..dae6ecba6780 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -252,6 +252,10 @@ struct nvmet_subsys {=0A=
>  	unsigned int		admin_timeout;=0A=
>  	unsigned int		io_timeout;=0A=
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
> +=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +	u8			zasl;=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  };=0A=
>  =0A=
>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
> @@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvme=
t_ns *ns, __le64 lba)=0A=
>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
>  }=0A=
>  =0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
> +static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	return false;=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
> +=0A=
>  #endif /* _NVMET_H */=0A=
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> new file mode 100644=0A=
> index 000000000000..ae51bae996f9=0A=
> --- /dev/null=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -0,0 +1,327 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * NVMe ZNS-ZBD command implementation.=0A=
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
> + */=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> +#include <linux/uio.h>=0A=
> +#include <linux/nvme.h>=0A=
> +#include <linux/xarray.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +#include <linux/module.h>=0A=
> +#include "nvmet.h"=0A=
> +=0A=
> +/*=0A=
> + * We set the Memory Page Size Minimum (MPSMIN) for target controller to=
 0=0A=
> + * which gets added by 12 in the nvme_enable_ctrl() which results in 2^1=
2 =3D 4k=0A=
> + * as page_shift value. When calculating the ZASL use shift by 12.=0A=
> + */=0A=
> +#define NVMET_MPSMIN_SHIFT	12=0A=
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
> +=0A=
> +out:=0A=
> +	return status;=0A=
> +}=0A=
=0A=
I really fail to see how the gotos here help with the code "being better".=
=0A=
Are you absolutely sure you want to keep this super convoluted style for a=
=0A=
function that is that simple ?=0A=
=0A=
> +=0A=
> +/*=0A=
> + *  ZNS related command implementation and helpers.=0A=
> + */=0A=
> +=0A=
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)=0A=
> +{=0A=
> +	/*=0A=
> +	 * Zone Append Size Limit is the value experessed in the units=0A=
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.=0A=
> +	 */=0A=
> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);=0A=
> +}=0A=
> +=0A=
> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;=0A=
> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));=0A=
> +=0A=
> +	if (ns->subsys->zasl)=0A=
> +		return ns->subsys->zasl < zasl ? false : true;=0A=
> +=0A=
> +	ns->subsys->zasl =3D zasl;=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {=0A=
=0A=
Hmm... BIO based DM devices do not have this bitmap set since they do not h=
ave a=0A=
scheduler. So if one setup a dm-linear device on top of an SMR disk and exp=
ort=0A=
the DM device through fabric, then this check will fail to verify if=0A=
conventional zones are present. There may be no other option than to do a f=
ull=0A=
report zones here if queue->seq_zones_wlock is NULL (meaning the queue is f=
or a=0A=
stacked device).=0A=
=0A=
> +		pr_err("block devices with conventional zones are not supported.");=0A=
> +		return false;=0A=
> +	}=0A=
> +=0A=
> +	/*=0A=
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligne=
d=0A=
> +	 * to the device physical block size. So use this value as the logical=
=0A=
> +	 * block size to avoid errors.=0A=
> +	 */=0A=
> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));=
=0A=
> +=0A=
> +	if (!nvmet_zns_update_zasl(ns))=0A=
> +		return false;=0A=
> +=0A=
> +	return !(get_capacity(ns->bdev->bd_disk) &=0A=
> +			(bdev_zone_sectors(ns->bdev) - 1));=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * ZNS related Admin and I/O command handlers.=0A=
> + */=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;=0A=
> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
> +	struct nvme_id_ctrl_zns *id;=0A=
> +	u16 status;=0A=
> +=0A=
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
> +	if (!id) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (ctrl->ops->get_mdts)=0A=
> +		id->zasl =3D min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);=0A=
> +	else=0A=
> +		id->zasl =3D zasl;=0A=
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
> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto done;=0A=
> +	}=0A=
> +=0A=
> +	nvmet_ns_revalidate(req->ns);=0A=
> +	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>=0A=
> +					req->ns->blksize_shift;=0A=
> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));=0A=
> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));=0A=
> +=0A=
> +done:=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
> +	kfree(id_zns);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +struct nvmet_report_zone_data {=0A=
> +	struct nvmet_ns *ns;=0A=
> +	struct nvme_zone_report *rz;=0A=
> +};=0A=
> +=0A=
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int id=
x,=0A=
> +				     void *data)=0A=
> +{=0A=
> +	struct nvmet_report_zone_data *report_zone_data =3D data;=0A=
> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries;=
=0A=
> +	struct nvmet_ns *ns =3D report_zone_data->ns;=0A=
> +=0A=
> +	entries[idx].zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));=
=0A=
> +	entries[idx].zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));=0A=
> +	entries[idx].wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));=0A=
> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;=0A=
> +	entries[idx].zt =3D z->type;=0A=
> +	entries[idx].zs =3D z->cond << 4;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=0A=
> +	u64 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
> +	unsigned int nr_zones;=0A=
> +	int reported_zones;=0A=
> +	u16 status;=0A=
> +=0A=
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
> +			sizeof(struct nvme_zone_descriptor);=0A=
=0A=
This is a 64 bits division. This will not compile on 32-bits arch, no ? I.e=
.,=0A=
you must use do_div64() here I think. Or just a bit shift since struct=0A=
nvme_zone_descriptor is exactly 64B. Or have bufsize be a 32 bits. There is=
 no=0A=
need for that variable to be 64 bits.=0A=
=0A=
> +=0A=
> +	status =3D nvmet_bdev_zns_checks(req);=0A=
> +	if (status)=0A=
> +		goto out;=0A=
> +=0A=
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
> +	if (!data.rz) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,=
=0A=
> +					     nvmet_bdev_report_zone_cb,=0A=
> +					     &data);=0A=
> +	if (reported_zones < 0) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out_free_report_zones;=0A=
> +	}=0A=
> +=0A=
> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
> +=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);=0A=
=0A=
reported_zoned may be far less than the request nr_zones. So you may want t=
o=0A=
recalculate bufsize before doing this to not copy garbage data into the rep=
ly=0A=
buffer. Another thing that needs verification is: don't you need to zero-op=
ut=0A=
the data.rz buffer with GFP_ZERO, for security ?=0A=
=0A=
> +=0A=
> +out_free_report_zones:=0A=
> +	kvfree(data.rz);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);=0A=
> +	sector_t nr_sect =3D bdev_zone_sectors(req->ns->bdev);=0A=
> +	enum req_opf op =3D REQ_OP_LAST;=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (req->cmd->zms.select_all)=0A=
> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);=0A=
> +=0A=
> +	switch (req->cmd->zms.zsa) {=0A=
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
> +		op =3D REQ_OP_ZONE_RESET;=0A=
> +		break;=0A=
> +	default:=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);=
=0A=
> +	if (ret)=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;=0A=
> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	unsigned int total_len =3D 0;=0A=
> +	struct scatterlist *sg;=0A=
> +	int ret =3D 0, sg_cnt;=0A=
> +	struct bio *bio;=0A=
> +=0A=
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
> +		return;=0A=
> +=0A=
> +	if (!req->sg_cnt) {=0A=
> +		nvmet_req_complete(req, 0);=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> +		bio =3D &req->b.inline_bio;=0A=
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> +	} else {=0A=
> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
> +	}=0A=
> +=0A=
> +	bio_set_dev(bio, req->ns->bdev);=0A=
> +	bio->bi_iter.bi_sector =3D sect;=0A=
> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))=0A=
> +		bio->bi_opf |=3D REQ_FUA;=0A=
> +=0A=
> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {=0A=
> +		struct page *p =3D sg_page(sg);=0A=
> +		unsigned int l =3D sg->length;=0A=
> +		unsigned int o =3D sg->offset;=0A=
> +		bool same_page =3D false;=0A=
> +=0A=
> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);=0A=
> +		if (ret !=3D sg->length) {=0A=
> +			status =3D NVME_SC_INTERNAL;=0A=
> +			goto out_bio_put;=0A=
> +		}=0A=
> +		if (same_page)=0A=
> +			put_page(p);=0A=
> +=0A=
> +		total_len +=3D sg->length;=0A=
> +	}=0A=
> +=0A=
> +	if (total_len !=3D nvmet_rw_data_len(req)) {=0A=
> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
> +		goto out_bio_put;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;=0A=
> +=0A=
> +	sect +=3D (total_len >> 9);=0A=
=0A=
This is incorrect: sect is the start sector of the append operation target =
zone.=0A=
Adding to it the request size does not give the actual sector written on th=
e=0A=
backend. You need to get that from the completed BIO. And do not add the re=
quest=0A=
size. The result is the first written sector, not the sector following the =
last=0A=
one written.=0A=
=0A=
> +	req->cqe->result.u64 =3D cpu_to_le64(nvmet_sect_to_lba(req->ns, sect));=
=0A=
> +=0A=
> +out_bio_put:=0A=
> +	if (bio !=3D &req->b.inline_bio)=0A=
> +		bio_put(bio);=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
