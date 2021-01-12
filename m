Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F3CC433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD5422CE3
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbhALFd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:33:59 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3023 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732730AbhALFd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 00:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610429636; x=1641965636;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2o5YBI2j8iufzUK6qAgr7Y0RLaaboU5cof8tQlEaGEE=;
  b=MFUhxI7gHF2SaYum5irlLNWSem7QqOO9iTHYrJ+xFnTPCSElCT8jZEQL
   K2eeWKprrSfUvdLETZn3Ag+WF1HEeiQ35q800Og6tBFPH7JIjsPo1sJ1e
   kc5J1SEdN8A4LSDoYlo1URkW7yVl1WWauMBt8EqhfcB9sazrnDzcIzv31
   gdcDZoI8RdaHGDdwpDMdUEIbqFofMkJlmovu7f9Yyp7ZvJH3Ukg+Bh4sx
   UTy/wUWVGRIABhLZNvwp55C+NKCcTYGy57nuORcHcE81xk8UfVKZFv2/r
   /QBxqzly8RmSjUAUq0Z9d4lRt7QyPUomCtBhMZm/CS9VnquP/xVXfuI0j
   A==;
IronPort-SDR: EteGVHsSFtNz2fOlzXpWEw1auE4PnagYZzATZiRBoWegTExh0Oc/NdWwpGuu8rdZSqor0Y+A5x
 Ga818RHXw+I3kYpVQwbgqG+hQctxr/cCh8N3iz8pd5YmFA7NQvgoSMgGDvbVg75oyOP+/NMNQW
 ORl5aHlcfQwJg3hDpnRS+DnasrVQLWPslceJoLx50CYzuMhG3ftbvrrUdVmc9gQeTBwVZYAsTR
 AxqaMcIKxZ/yFxAr4CI0Ekqhzec6lIHzyixQOcAUuwPOGC7WOPYYzIfctIDHBl8kVvQ86n/+to
 7zQ=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="157213192"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:32:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToT3YAzquCEH3YP+DiFexQF2qeUGGZbfetu9YXwBC9eKeAIG8+nY7W+pejidzDiMQ3sxcAJci0GMPuMmeDYMGJiDHaqQQrEYP3oSm3cbp5weZN/8hNYyk6FqSKOi7wT2xVDLwfyUsnTXWzu20ksl0hF14Jcz4yFK7P12O6uzRhL2vfuM4AZ+hbJllKchaF/QE6/7jkAdfz1oJIBv0bZ5n+v5f0VPDjXUHsTus/sSBXeFlo9neqO0xGgSkM32Ov42HpxWXFNw4wR0mb2zvl6VG8xczNZoxaIx7XLD7XEijx2KjoMI8ipuDVAHzaoqWS1BHHjrw3T9kqaXfV9jRjNSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lu/XDeOh6oxHVLuLzTGdVzOBB/7hFjZCSdoaxVKFSw=;
 b=oftVZ9jCSIM7HbqIHuFvQVtp/fh63y0nXoqFRgb2xs8xtqSNmW1iOII62qwZVKrXdE3bKVSVkVE3x7pcvCqgZuEgJXBYfdKqsMBpDCPYN00sXSi3IAfds/6Mjp+AOJCqcwQHDKi+uePT9Bpq482fICOJeIhr6F9yKCZI1aym/vtldiprm36APUj4UfoSEVeEuHj7NE8DDs9W5MaBmoAwfMGjzC7ZQhu6kyH4BXh3fNskg5wqu3g3QBFSuFwFhIU+3H8pc6S9Y8mxjNg3z/tfbtsalur6kXITQvau2Xv3JRR2aNiXSYLq77izmob1gGPS05B3c3u8/1R5kFAwLR2MLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lu/XDeOh6oxHVLuLzTGdVzOBB/7hFjZCSdoaxVKFSw=;
 b=bBD6XTdzgTQXcTLdyGDQO0EzH+RfZOIT9wCvyBl0W48gEKTNq8qSRyWh02fudb2iwHUskzI1Io28LWQWhX39oaObsZc8XtMuLBBsLi/RNHSGthH1TPQSMuSho+TAj10ZIaOdqdzegqabuTV0DvFEaGTtQMaaH765FlBaKQLWt+s=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB7071.namprd04.prod.outlook.com (2603:10b6:208:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Tue, 12 Jan
 2021 05:32:48 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:32:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6Jsz5Um6YbJoj0ev+CR8KYF1Aw==
Date:   Tue, 12 Jan 2021 05:32:48 +0000
Message-ID: <BL0PR04MB6514A4C7F0F7A2627C4639B3E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f333d7d5-a3c5-464c-170c-08d8b6bb7f65
x-ms-traffictypediagnostic: MN2PR04MB7071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB7071CB9E971E31DBEF3A217AE7AA0@MN2PR04MB7071.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/qzVhJLxDOVl3h8riFJG5PPhG7UlwIbNk84EkJW7vOazJZ9cp8HIweXH4Ifve4UsUyLAi1jeJmHeHseGnzY++PkNtE+hgrTVuQE+Vh2YyB/oCxwnjHhrf6FsrqK21EuVT3aYZk1d3EqglmhrOKiUlyxOTgLf9ECBtYt7ctWO12xqhzrKdI5sP6MitCiEsupZg+EDquSg3cy63o2FzLC73Yx1vHVfVobxyVoQ4HFtIai3Fir5DhZ1z6lTrh53TbpyJ5TgfuNqchhHC+QklwR8njxJm8MIMGFYKqJ6bR3dL8CVzpvF94NMwaR5LmRYgkrwBQq/c3LKlsoa3AZW37HwIEK0dvlKi3eQgs3gM1N3wMdueUdKXq6Pup3BGnirSCGIDZ62d+ao6cy2mWu9pnNag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(110136005)(64756008)(66556008)(76116006)(54906003)(186003)(9686003)(66446008)(91956017)(66946007)(8676002)(316002)(66476007)(4326008)(71200400001)(53546011)(55016002)(7696005)(33656002)(52536014)(86362001)(5660300002)(6506007)(478600001)(83380400001)(8936002)(30864003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?SuM4MGVmtD3ZqYaAgWX9P0F8lrDG8EyDDUCKS6OQlhC8lXL4VP2dFqz/?=
 =?Windows-1252?Q?PlF889EIjr7uQq0jKMmmyM7Z6oUn1JqHiwBwK2VmRJWLkIg6ZxdF1smN?=
 =?Windows-1252?Q?9eDkzD+rtnDg/oTa6pOOQW3RtkUNbLZrA+wifAK6NA0Fc5ZmsrFC1gs/?=
 =?Windows-1252?Q?F+LwN20SZKUMVgdrTwrLNVrVrPRXtIaiT+tOp2wl3ZJ3P2JAFZSpK97L?=
 =?Windows-1252?Q?GxpFGdPil4D8kTGAc2Tidv42TeOA1eTYX2RjBHIoN0udeHCD3wd84NZT?=
 =?Windows-1252?Q?I4IorPkVkIYFv2mtim//tvbS+tBprsPEMfp+wOHqfsstTCqyTNmhsfzZ?=
 =?Windows-1252?Q?OT0Idyir5z1RSwgEGL2IS3vOrRz6NeTocGMibVWBuTCxCItPNzrYAVZ1?=
 =?Windows-1252?Q?I5X9jyiVHFehcbevaTNsofwh6hOPY5ULXutlcPdrk3hCvej3h/4L5Gv7?=
 =?Windows-1252?Q?tKl6hPUwFbuquZllz6p2FUTSezjd8QuPoCs8vdwljSNHOKALBDNmh5LL?=
 =?Windows-1252?Q?ZnHWz+iqS0TPRbVEChgEQngUiVfiazJeLe0/Z3HEFK0PRkywhwjXgcRP?=
 =?Windows-1252?Q?f/hMncnljCIa+LdK/R9F08YnCTMQIUSqw74DB8dstDu8FSKtI5uaC8Tm?=
 =?Windows-1252?Q?xZ5ZvPD6X7yPFRF7kh/sBjAcK6p2H28niZDtDjtxjY7CAbBVJJq/+ghi?=
 =?Windows-1252?Q?ilk0cmUzE30CXqrXRnGXLVLavhtt3hDUf1zakYhPGdfcUB1PYUTFsQAe?=
 =?Windows-1252?Q?kifVSENFIkipMRCl/IDg9g4EVtdUC7Cvd/0WgzaHJIdlbbaj0yXr1kUu?=
 =?Windows-1252?Q?fRxBrNhlnJlKx47+gOss7AF6dsLF3QswQ/COgyms0hNZxUgJClePXXBG?=
 =?Windows-1252?Q?cOzIgQvIbPNZhjUCRjEbTl0eCxviiq2zEqg8UkLrRzlhsyfLP5wRxyzq?=
 =?Windows-1252?Q?lawv0edeVo8S3C8gSQSJHllCe638dRkIP5BZu7/hiFa6jmxGL13LSAzi?=
 =?Windows-1252?Q?XNd/FqHsZuBxWlcfyq74JzI7E3zsFlfydD3bIYGUDAsBhhwIt8Y8GXaA?=
 =?Windows-1252?Q?5mfeAuLbTJOOwgt/KWOISfl6PDS2d/B4OWig171ymb1A3L/cLKz8d1qu?=
 =?Windows-1252?Q?EF/1qeftc26oKMoHDIeIwRLf?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f333d7d5-a3c5-464c-170c-08d8b6bb7f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:32:48.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6thXTrTgx3EaiIKNilmWEhAmQB1iGcL38K6chYkb9F2tDqmm74eTsekHPEB7GnGg+YcSYjy68PD/EJSO1UoGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7071
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 13:27, Chaitanya Kulkarni wrote:=0A=
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to=0A=
> communicate with a non-volatile memory subsystem using zones for=0A=
> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe=0A=
> Protocol compliant devices on the target in the passthru mode. There=0A=
> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)=
=0A=
> HDDs that are not based on the NVMe protocol.=0A=
> =0A=
> This patch adds ZNS backend to support the ZBDs for NVMeOF target.=0A=
> =0A=
> This support includes implementing the new command set NVME_CSI_ZNS,=0A=
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
>  drivers/nvme/target/admin-cmd.c   |  28 +++=0A=
>  drivers/nvme/target/core.c        |   3 +=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-=0A=
>  drivers/nvme/target/nvmet.h       |  38 ++++=0A=
>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++=
=0A=
>  6 files changed, 437 insertions(+), 8 deletions(-)=0A=
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
> index a50b7bcac67a..bdf09d8faa48 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
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
=0A=
Is it OK to not return an error here if CONFIG_BLK_DEV_ZONED is not enabled=
 ?=0A=
I have not checked the entire code of this function nor how it is called, s=
o I=0A=
may be wrong.=0A=
=0A=
> +		break;=0A=
>  	default:=0A=
>  		status =3D NVME_SC_INVALID_LOG_PAGE;=0A=
>  		break;=0A=
> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)=0A=
>  	if (status)=0A=
>  		goto out;=0A=
>  =0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
> +		u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
> +=0A=
> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
> +							  NVME_NIDT_CSI_LEN,=0A=
> +							  &nvme_cis_zns, &off);=0A=
> +		if (status)=0A=
> +			goto out;=0A=
> +	}=0A=
=0A=
Same comment here.=0A=
=0A=
> +=0A=
>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,=
=0A=
>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
>  		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req =
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
> index 672e4009f8d6..17d5da062a5a 100644=0A=
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
> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)=
=0A=
>  {=0A=
>  	/* command sets supported: NVMe command set: */=0A=
>  	ctrl->cap =3D (1ULL << 37);=0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))=0A=
> +		ctrl->cap |=3D (1ULL << 43);=0A=
>  	/* CC.EN timeout in 500msec units: */=0A=
>  	ctrl->cap |=3D (15ULL << 24);=0A=
>  	/* maximum queue entries supported: */=0A=
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
> index 476b3cd91c65..7361665585a2 100644=0A=
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
> index 000000000000..2a71f56e568d=0A=
> --- /dev/null=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -0,0 +1,342 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * NVMe ZNS-ZBD command implementation.=0A=
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
> + */=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> +#include <linux/nvme.h>=0A=
> +#include <linux/blkdev.h>=0A=
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
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
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
=0A=
You really want to keep this (useless) label ? Without it, the status varia=
ble=0A=
can be dropped and the code overall becomes so much easier to read... Not t=
o=0A=
mention that life will be easier to the compiler for optimizing this.=0A=
=0A=
> +	return status;=0A=
> +}=0A=
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
> +=0A=
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
> +					    unsigned int idx, void *data)=0A=
> +{=0A=
> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return -EOPNOTSUPP;=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	if (bdev->bd_disk->queue->conv_zones_bitmap)=0A=
> +		return true;=0A=
> +=0A=
> +	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),=0A=
> +				  nvmet_bdev_validate_zns_zones_cb, NULL);=0A=
> +=0A=
> +	return ret < 0 ? true : false;=0A=
=0A=
return ret <=3D 0;=0A=
=0A=
would be simpler.=0A=
=0A=
Note that "<=3D" includes the error case of the device not reporting any zo=
ne=0A=
(device dead) as we should fail that case I think.=0A=
=0A=
> +}=0A=
> +=0A=
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (nvmet_bdev_has_conv_zones(ns->bdev))=0A=
> +		return false;=0A=
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
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
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
> +	entries[idx].zcap =3D nvmet_sect_to_lba(ns, z->capacity);=0A=
> +	entries[idx].zslba =3D nvmet_sect_to_lba(ns, z->start);=0A=
> +	entries[idx].wp =3D nvmet_sect_to_lba(ns, z->wp);=0A=
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
> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
> +	unsigned int nr_zones;=0A=
> +	int reported_zones;=0A=
> +	u16 status;=0A=
> +=0A=
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
> +			sizeof(struct nvme_zone_descriptor);=0A=
=0A=
I really would prefer this code to be moved down, before the call to=0A=
blkdev_report_zones().=0A=
=0A=
You can also optimize this value a little with a min() of the value above a=
nd of=0A=
DIV_ROUND_UP(dev_capacity - sect, zone size). But not a big deal I think.=
=0A=
=0A=
> +=0A=
> +	status =3D nvmet_bdev_zns_checks(req);=0A=
> +	if (status)=0A=
> +		goto out;=0A=
> +=0A=
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO)=
;=0A=
=0A=
Shouldn't this be GFP_NOIO ? Also, is the NORETRY critical ?=0A=
blkdev_report_zones() will do mem allocation too and at leadt scsi does ret=
ry.=0A=
=0A=
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
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	enum req_opf op;=0A=
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
=0A=
GFP_NOIO ?=0A=
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
> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,=0A=
> +						 bio->bi_iter.bi_sector);=0A=
> +=0A=
> +out_bio_put:=0A=
> +	if (bio !=3D &req->b.inline_bio)=0A=
> +		bio_put(bio);=0A=
> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);=0A=
> +}=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
