Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D19BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4CC422510
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbhALGMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:12:13 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3857 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbhALGMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 01:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610431932; x=1641967932;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+tYsHpvd5TfHaSEJ7eFZA3GalNj+Bs6tWv6uN7zRN90=;
  b=NGbyIqJaMVUCRfm2QLdKuXF1jYb1mdBpdk/j1l6f3isM5JFzkFdntJ/Y
   hQoFn/Pe69pJxXxdNh3o/wm5dBHmMe8+TVxXBHQf+2Gj11zXBfSkiZsbM
   CyNkgizjbK6qYpSumngX/HtIbQJdi354aH/1oHVk9OHpOozD5FrKhv3Qt
   PBZkUkAxwgoPdTVWBkFUjoCn+WjhPE7ES80wNkyIQSIiXbsSf+8Pjl9DM
   0vDw13+cKwNgX9bNHaeF026qeLDDZnVUUXD+7EvCEwspP4Uju0R6ozTsH
   PQIP7z8kMVcd+hqBB4ZHEAh0okTfXTn0jox25yhhwMAAUm6SbXut+m2pl
   w==;
IronPort-SDR: yPQGWeg/+FmyaSTvd2EpKGN+vB4yApR8KjazorE36DRPnxwLlj7zP31J3op3s2wKGAl8E2vkiX
 VUo/P5+8VMcXelxOW6mUDECObd05iTHNJ11cinJ/wl49vm6oa1l/4+c1uLnp5GxWmkiGmhw/qx
 /uPaK7/M0T76c6QSZ6vYkIdRnj9hwfxWf4YxIW37GQFRL8oBN0mE3Ed/dUk7OcPTWmO3AP1AdL
 dFhziGDPKAArTNEkDhmvnPbNZ1PdhzmWQNP0+Ys4JNI7nohGVEqFszGwgjQAiSV4kB1VWusTGp
 e8U=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267511075"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:11:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Z7OoSqr8MOLkqY0B8R3kE2EVwRfAEA2/i+3FdUnujvymTT0TRrV4PN9VPGQ1i+xtXUToPUuq0XqHm79ikgvfAcmUdAGEB8T33gNfkR1PMYio5dl+pjsWgYuHA+Ol3+fmgzTYSbi1vocFkSJeYZovK1qMe8kX5VvhldKBSzsvbR/col8lj9i8CahG/RlK7ABVEblXp5YAerDpsIYHoaAQHxZA+4S8dFuxesvAeZ8kd31aopeuwuOojsQhD7BYBhykwo+/uUzNTDC76jPrufKYsSyfYnhXOF2UQHYrQyXhj3DVRli8apLugyvAo8A2m79cFDj0y9i/atsgHzKwVf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKCcHYzNFnZLctoinG3z+c92ZMBQGbgMK3mVwbOv4Qk=;
 b=Hs8Gl3UGdtzmE0vWgD4euZSUZB1D49TC45X7mLWhi3xL+ooCbWj1jGXhk0D4m9cszcnbjnU5p5rgm5HxrEoQMSCWSi/PvYio+t+Xx/ZO/3nNUWzD4rIVVEbQ2y9EJZy20cZC9zYfBezPeL0R2R9HLvfZnSm8o1iX71yD5DGMV9TINYAEZtLtf3AnkUf9HPGRUQKNLxiNO5bWHhzbqeKtDD8VOGJCG+flfWbNYhgbMcaA/YRwZYnq0BeBmk9jkOmiUFaWI5AOlHY6vIlRyHXL6iYQ+ciuKJgg1oJBKEkX62DjBiK1ybsm0PSYro/3UCac/2ITn1WDcBVcPqM51+bhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKCcHYzNFnZLctoinG3z+c92ZMBQGbgMK3mVwbOv4Qk=;
 b=rfrOVhRMH+EKxm6qs40zSVtf4Pp/90F6u5HpoC3qlkl1cuZ87oJF4gZlOe6KEyyqHeJE0x7jlQYj1U4uSMbjoVNfNAtMuDDNIVIq8xrDKHlSpG2xRW4SoiLsji9Z+QSwlh4XMYB7yBsojHFbVTbx0IHrATgRCG2xcMLQU9YdU5Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 06:11:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:11:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6JszE74B7v3S90G6ql/DwDLtmQ==
Date:   Tue, 12 Jan 2021 06:11:02 +0000
Message-ID: <BYAPR04MB4965A589B5D8F480355AC28986AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514A4C7F0F7A2627C4639B3E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85385a76-8f6c-4d7b-3721-08d8b6c0d6b5
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5895738F8FD52C82A1D0453F86AA0@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dT9gvHduBFCytXjcAys4mn6+1nQ4+EhU8ok91HzLE9xO5vOCrv3LhRjLSHGJXBx62KEOop97C9TXdwuxjXCGtvzSCWFnQW4vK4SBCwbkW+Izp11q6NOk6AG2oV3BonW5LgGLYHVdWTOGCRD4jaOGeE0QtkMN9MGdOcjKhNW7z3rbeNApeo3r3quq2gLdFcxBGhVdx1ossEOLezSPc7gbIN54ZcRDOQLqkkBi9VZ6QTY48jRIqTmdvqGMarqGfSjygyEefZiw0hgahNIkobHYSHT9DuLqpdPJ1Db2MuLpZnMC9YRtKIY8/mquwY5GEfSU2GlRCmANoFg/uESIC99gujQd8TDOrIdH3/DviS8yILjJImXOa51vDkYyXqC6Xa36hIbzH/85XnNzKEYnwT5zxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(110136005)(54906003)(6506007)(316002)(5660300002)(53546011)(2906002)(33656002)(71200400001)(26005)(186003)(76116006)(8936002)(478600001)(86362001)(64756008)(4326008)(83380400001)(9686003)(66476007)(66556008)(7696005)(52536014)(66946007)(55016002)(66446008)(8676002)(30864003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?LBIq9p2RmNLezkCjhVeqciyJfWz7USmxnFHT6oMCEyoKuZCRrDmNFghC?=
 =?Windows-1252?Q?9fWDsiDVJR7IfquP3SswKvxltEhx1edDZxhDew7pwrBMT67GliP6OC00?=
 =?Windows-1252?Q?tejQmomcWkIoPuBuS0rYA9Y2VaxTdZ1DTdzoO5MApNd1g9siBTG90oRd?=
 =?Windows-1252?Q?s+8eLS5HRGR9SoVNZ7IJ5xgP34GAIQ9wLWRo+Z68u7zKth2HZcOmHkOY?=
 =?Windows-1252?Q?lhhqKzncaRvyMmH78AoCJDGgkziSP2jdNQzvj4OstMSwiRXxSrqSKdPI?=
 =?Windows-1252?Q?dVHjfoxA5Q8r8ADwlOyLr9WYfAnDobQCddkNQu6P1WKjlfxsQKEBlek1?=
 =?Windows-1252?Q?7wEt8YSIbBjlHnA8RkwA/UH8qTSixyIBt0sRf8mIcahJqMuvdBr6+rcR?=
 =?Windows-1252?Q?7FvUuMmM7N9mM+V3PkpB/1UEZSNn+s+OpPN4GxuAVhBJgyUefKRd+gfw?=
 =?Windows-1252?Q?55fhJrP1/wrR3ZLeavD42cCahZ0VJupgzFXbw3cgjfeUkD1QdAO8ggT/?=
 =?Windows-1252?Q?tl7CPAXKcKMvTvDLEPmw6cFnc8Vi0R4EQQG/9gnbdPaBzW4mjVbm9D4s?=
 =?Windows-1252?Q?JwPdIee8MjJ9eMjzq4sCSjmPKlni0Zx3MldG9W1UPog+6F2g9ojRa3kM?=
 =?Windows-1252?Q?rWOuSmErjE4I+sm5s6H0SsT5fcrbiKIBTYm1zB9DtgnPpqASbQeWmZya?=
 =?Windows-1252?Q?dJglhTnLOgfbXl2TPo0D35d1wEnTN0iM9Um3+w4EDFQW6GzHgPXXvjwI?=
 =?Windows-1252?Q?eVIre8zvx9epJ057z47XiJl5rKHtyKAiCeUvLa/wqr1NYqxTFd4b4E2r?=
 =?Windows-1252?Q?ookDLGM1VdTi+yy5N+ZcWtKF+LuwztoxRKHQmgdI6l9DXeKCd8MoQdDq?=
 =?Windows-1252?Q?2rkAgEuhNXt8Xb1Tmm5hmcScpdLG7QN+IbqItfi2teDfRv8JXZqRT0X8?=
 =?Windows-1252?Q?He77UVCoO3Wk4wWHtPkxjzYCz7biXOp+nixL/CdFNquT64Ddkx+yyOFI?=
 =?Windows-1252?Q?Or2EK+J8eDtYkXF6O3cm3GJ/Q7LU7CGZvDjoOVmgKGt+Sj+dJbPgn1zQ?=
 =?Windows-1252?Q?GRVEuLePFDgkvrjp?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85385a76-8f6c-4d7b-3721-08d8b6c0d6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:11:02.3135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKzOcqQALewCxw1AcTbnFLoIZLCKQe+m87bznd1zNDoTq2kRlgVQQZ++VBs3jcQqziWWDsyN1coivXbZBYEmoD7Cp8e3vzYLOPI6ZU1m5Rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 21:32, Damien Le Moal wrote:=0A=
> On 2021/01/12 13:27, Chaitanya Kulkarni wrote:=0A=
>> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to=0A=
>> communicate with a non-volatile memory subsystem using zones for=0A=
>> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe=0A=
>> Protocol compliant devices on the target in the passthru mode. There=0A=
>> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)=
=0A=
>> HDDs that are not based on the NVMe protocol.=0A=
>>=0A=
>> This patch adds ZNS backend to support the ZBDs for NVMeOF target.=0A=
>>=0A=
>> This support includes implementing the new command set NVME_CSI_ZNS,=0A=
>> adding different command handlers for ZNS command set such as=0A=
>> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,=0A=
>> NVMe Zone Management Send and NVMe Zone Management Receive.=0A=
>>=0A=
>> With new command set identifier we also update the target command effect=
s=0A=
>> logs to reflect the ZNS compliant commands.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  drivers/nvme/target/Makefile      |   1 +=0A=
>>  drivers/nvme/target/admin-cmd.c   |  28 +++=0A=
>>  drivers/nvme/target/core.c        |   3 +=0A=
>>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-=0A=
>>  drivers/nvme/target/nvmet.h       |  38 ++++=0A=
>>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++=
=0A=
>>  6 files changed, 437 insertions(+), 8 deletions(-)=0A=
>>  create mode 100644 drivers/nvme/target/zns.c=0A=
>>=0A=
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
>> index ebf91fc4c72e..9837e580fa7e 100644=0A=
>> --- a/drivers/nvme/target/Makefile=0A=
>> +++ b/drivers/nvme/target/Makefile=0A=
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>>  nvme-loop-y	+=3D loop.o=0A=
>>  nvmet-rdma-y	+=3D rdma.o=0A=
>>  nvmet-fc-y	+=3D fc.o=0A=
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin=
-cmd.c=0A=
>> index a50b7bcac67a..bdf09d8faa48 100644=0A=
>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>> @@ -191,6 +191,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(st=
ruct nvmet_req *req)=0A=
>>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);=0A=
>>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);=0A=
>>  		break;=0A=
>> +	case NVME_CSI_ZNS:=0A=
>> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
>> +			u32 *iocs =3D log->iocs;=0A=
>> +=0A=
>> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);=0A=
>> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
>> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
>> +		}=0A=
> Is it OK to not return an error here if CONFIG_BLK_DEV_ZONED is not enabl=
ed ?=0A=
> I have not checked the entire code of this function nor how it is called,=
 so I=0A=
> may be wrong.=0A=
Since we only set the controller cap when CONFIG_BLK_DEV_ZONED is=0A=
enabled we should be uniform everywhere in the code, I'll recheck=0A=
and make the change if needed.=0A=
>> +		break;=0A=
>>  	default:=0A=
>>  		status =3D NVME_SC_INVALID_LOG_PAGE;=0A=
>>  		break;=0A=
>> @@ -644,6 +653,17 @@ static void nvmet_execute_identify_desclist(struct =
nvmet_req *req)=0A=
>>  	if (status)=0A=
>>  		goto out;=0A=
>>  =0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
>> +		u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>> +=0A=
>> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
>> +							  NVME_NIDT_CSI_LEN,=0A=
>> +							  &nvme_cis_zns, &off);=0A=
>> +		if (status)=0A=
>> +			goto out;=0A=
>> +	}=0A=
> Same comment here.=0A=
I think same explanation applies here too, will recheck and make the change=
=0A=
if needed.=0A=
>=0A=
>> +=0A=
>>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off=
,=0A=
>>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
>>  		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> @@ -660,8 +680,16 @@ static void nvmet_execute_identify(struct nvmet_req=
 *req)=0A=
>>  	switch (req->cmd->identify.cns) {=0A=
>>  	case NVME_ID_CNS_NS:=0A=
>>  		return nvmet_execute_identify_ns(req);=0A=
>> +	case NVME_ID_CNS_CS_NS:=0A=
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
>> +		break;=0A=
>>  	case NVME_ID_CNS_CTRL:=0A=
>>  		return nvmet_execute_identify_ctrl(req);=0A=
>> +	case NVME_ID_CNS_CS_CTRL:=0A=
>> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			return nvmet_execute_identify_cns_cs_ctrl(req);=0A=
>> +		break;=0A=
>>  	case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
>>  		return nvmet_execute_identify_nslist(req);=0A=
>>  	case NVME_ID_CNS_NS_DESC_LIST:=0A=
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
>> index 672e4009f8d6..17d5da062a5a 100644=0A=
>> --- a/drivers/nvme/target/core.c=0A=
>> +++ b/drivers/nvme/target/core.c=0A=
>> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)=0A=
>>  static inline bool nvmet_cc_css_check(u8 cc_css)=0A=
>>  {=0A=
>>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {=0A=
>> +	case NVME_CC_CSS_CSI:=0A=
>>  	case NVME_CC_CSS_NVM:=0A=
>>  		return true;=0A=
>>  	default:=0A=
>> @@ -1173,6 +1174,8 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl=
)=0A=
>>  {=0A=
>>  	/* command sets supported: NVMe command set: */=0A=
>>  	ctrl->cap =3D (1ULL << 37);=0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))=0A=
>> +		ctrl->cap |=3D (1ULL << 43);=0A=
>>  	/* CC.EN timeout in 500msec units: */=0A=
>>  	ctrl->cap |=3D (15ULL << 24);=0A=
>>  	/* maximum queue entries supported: */=0A=
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-=
cmd-bdev.c=0A=
>> index 23095bdfce06..6178ef643962 100644=0A=
>> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
>> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
>> @@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvm=
et_ns *ns)=0A=
>>  	}=0A=
>>  }=0A=
>>  =0A=
>> +void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	if (ns->bdev) {=0A=
>> +		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
>> +		ns->bdev =3D NULL;=0A=
>> +	}=0A=
>> +}=0A=
>> +=0A=
>>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>>  {=0A=
>>  	int ret;=0A=
>> @@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))=0A=
>>  		nvmet_bdev_ns_enable_integrity(ns);=0A=
>>  =0A=
>> -	return 0;=0A=
>> -}=0A=
>> -=0A=
>> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
>> -{=0A=
>> -	if (ns->bdev) {=0A=
>> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
>> -		ns->bdev =3D NULL;=0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {=0A=
>> +		if (!nvmet_bdev_zns_enable(ns)) {=0A=
>> +			nvmet_bdev_ns_disable(ns);=0A=
>> +			return -EINVAL;=0A=
>> +		}=0A=
>> +		ns->csi =3D NVME_CSI_ZNS;=0A=
>>  	}=0A=
>> +=0A=
>> +	return 0;=0A=
>>  }=0A=
>>  =0A=
>>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)=0A=
>> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)=
=0A=
>>  	case nvme_cmd_write_zeroes:=0A=
>>  		req->execute =3D nvmet_bdev_execute_write_zeroes;=0A=
>>  		return 0;=0A=
>> +	case nvme_cmd_zone_append:=0A=
>> +		req->execute =3D nvmet_bdev_execute_zone_append;=0A=
>> +		return 0;=0A=
>> +	case nvme_cmd_zone_mgmt_recv:=0A=
>> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;=0A=
>> +		return 0;=0A=
>> +	case nvme_cmd_zone_mgmt_send:=0A=
>> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;=0A=
>> +		return 0;=0A=
>>  	default:=0A=
>>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,=0A=
>>  		       req->sq->qid);=0A=
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=
=0A=
>> index 476b3cd91c65..7361665585a2 100644=0A=
>> --- a/drivers/nvme/target/nvmet.h=0A=
>> +++ b/drivers/nvme/target/nvmet.h=0A=
>> @@ -252,6 +252,10 @@ struct nvmet_subsys {=0A=
>>  	unsigned int		admin_timeout;=0A=
>>  	unsigned int		io_timeout;=0A=
>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
>> +=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +	u8			zasl;=0A=
>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>  };=0A=
>>  =0A=
>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
>> @@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvm=
et_ns *ns, __le64 lba)=0A=
>>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
>>  }=0A=
>>  =0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);=0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
>> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
>> +static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	return false;=0A=
>> +}=0A=
>> +static inline void=0A=
>> +nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +static inline void=0A=
>> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +static inline void=0A=
>> +nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +static inline void=0A=
>> +nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +static inline void=0A=
>> +nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>> +=0A=
>>  #endif /* _NVMET_H */=0A=
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..2a71f56e568d=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/nvme/target/zns.c=0A=
>> @@ -0,0 +1,342 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * NVMe ZNS-ZBD command implementation.=0A=
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
>> + */=0A=
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
>> +#include <linux/nvme.h>=0A=
>> +#include <linux/blkdev.h>=0A=
>> +#include "nvmet.h"=0A=
>> +=0A=
>> +/*=0A=
>> + * We set the Memory Page Size Minimum (MPSMIN) for target controller t=
o 0=0A=
>> + * which gets added by 12 in the nvme_enable_ctrl() which results in 2^=
12 =3D 4k=0A=
>> + * as page_shift value. When calculating the ZASL use shift by 12.=0A=
>> + */=0A=
>> +#define NVMET_MPSMIN_SHIFT	12=0A=
>> +=0A=
>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {=0A=
>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {=0A=
>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)=0A=
>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>> +=0A=
>> +out:=0A=
> You really want to keep this (useless) label ? Without it, the status var=
iable=0A=
> can be dropped and the code overall becomes so much easier to read... Not=
 to=0A=
> mention that life will be easier to the compiler for optimizing this.=0A=
>=0A=
Will remove it in the next version.=0A=
>> +	return status;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + *  ZNS related command implementation and helpers.=0A=
>> + */=0A=
>> +=0A=
>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * Zone Append Size Limit is the value experessed in the units=0A=
>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.=
=0A=
>> +	 */=0A=
>> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);=0A=
>> +}=0A=
>> +=0A=
>> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;=0A=
>> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));=0A=
>> +=0A=
>> +	if (ns->subsys->zasl)=0A=
>> +		return ns->subsys->zasl < zasl ? false : true;=0A=
>> +=0A=
>> +	ns->subsys->zasl =3D zasl;=0A=
>> +	return true;=0A=
>> +}=0A=
>> +=0A=
>> +=0A=
>> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
>> +					    unsigned int idx, void *data)=0A=
>> +{=0A=
>> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return -EOPNOTSUPP;=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)=0A=
>> +{=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (bdev->bd_disk->queue->conv_zones_bitmap)=0A=
>> +		return true;=0A=
>> +=0A=
>> +	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),=
=0A=
>> +				  nvmet_bdev_validate_zns_zones_cb, NULL);=0A=
>> +=0A=
>> +	return ret < 0 ? true : false;=0A=
> return ret <=3D 0;=0A=
>=0A=
> would be simpler.=0A=
>=0A=
> Note that "<=3D" includes the error case of the device not reporting any =
zone=0A=
> (device dead) as we should fail that case I think.=0A=
>=0A=
hmm will make that change.=0A=
>> +}=0A=
>> +=0A=
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	if (nvmet_bdev_has_conv_zones(ns->bdev))=0A=
>> +		return false;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For ZBC and ZAC devices, writes into sequential zones must be align=
ed=0A=
>> +	 * to the device physical block size. So use this value as the logical=
=0A=
>> +	 * block size to avoid errors.=0A=
>> +	 */=0A=
>> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev))=
;=0A=
>> +=0A=
>> +	if (!nvmet_zns_update_zasl(ns))=0A=
>> +		return false;=0A=
>> +=0A=
>> +	return !(get_capacity(ns->bdev->bd_disk) &=0A=
>> +			(bdev_zone_sectors(ns->bdev) - 1));=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * ZNS related Admin and I/O command handlers.=0A=
>> + */=0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;=0A=
>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
>> +	struct nvme_id_ctrl_zns *id;=0A=
>> +	u16 status;=0A=
>> +=0A=
>> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
>> +	if (!id) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (ctrl->ops->get_mdts)=0A=
>> +		id->zasl =3D min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);=0A=
>> +	else=0A=
>> +		id->zasl =3D zasl;=0A=
>> +=0A=
>> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));=0A=
>> +=0A=
>> +	kfree(id);=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	struct nvme_id_ns_zns *id_zns;=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	u64 zsze;=0A=
>> +=0A=
>> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {=0A=
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);=0A=
>> +	if (!id_zns) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsi=
d);=0A=
>> +	if (!req->ns) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto done;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto done;=0A=
>> +	}=0A=
>> +=0A=
>> +	nvmet_ns_revalidate(req->ns);=0A=
>> +	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>=0A=
>> +					req->ns->blksize_shift;=0A=
>> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
>> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));=0A=
>> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));=0A=
>> +=0A=
>> +done:=0A=
>> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
>> +	kfree(id_zns);=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +struct nvmet_report_zone_data {=0A=
>> +	struct nvmet_ns *ns;=0A=
>> +	struct nvme_zone_report *rz;=0A=
>> +};=0A=
>> +=0A=
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int i=
dx,=0A=
>> +				     void *data)=0A=
>> +{=0A=
>> +	struct nvmet_report_zone_data *report_zone_data =3D data;=0A=
>> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries=
;=0A=
>> +	struct nvmet_ns *ns =3D report_zone_data->ns;=0A=
>> +=0A=
>> +	entries[idx].zcap =3D nvmet_sect_to_lba(ns, z->capacity);=0A=
>> +	entries[idx].zslba =3D nvmet_sect_to_lba(ns, z->start);=0A=
>> +	entries[idx].wp =3D nvmet_sect_to_lba(ns, z->wp);=0A=
>> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;=0A=
>> +	entries[idx].zt =3D z->type;=0A=
>> +	entries[idx].zs =3D z->cond << 4;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=0A=
>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>> +	unsigned int nr_zones;=0A=
>> +	int reported_zones;=0A=
>> +	u16 status;=0A=
>> +=0A=
>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
>> +			sizeof(struct nvme_zone_descriptor);=0A=
> I really would prefer this code to be moved down, before the call to=0A=
> blkdev_report_zones().=0A=
>=0A=
> You can also optimize this value a little with a min() of the value above=
 and of=0A=
> DIV_ROUND_UP(dev_capacity - sect, zone size). But not a big deal I think.=
=0A=
I did that as per your last comment, when I did the code review with=0A=
host side it didn't match, I've a cleanup patch series to fix nits and=0A=
host side css checks for zns I've added this into that series.=0A=
>> +=0A=
>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>> +	if (status)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO=
);=0A=
> Shouldn't this be GFP_NOIO ? Also, is the NORETRY critical ?=0A=
Yes on GFP_NOIO. NORETRY critical means how we areallocating the memory on=
=0A=
the host side nvme_zns_alloc_report_buffer() ?=0A=
> blkdev_report_zones() will do mem allocation too and at leadt scsi does r=
etry.=0A=
>=0A=
>> +	if (!data.rz) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,=
=0A=
>> +					     nvmet_bdev_report_zone_cb,=0A=
>> +					     &data);=0A=
>> +	if (reported_zones < 0) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out_free_report_zones;=0A=
>> +	}=0A=
>> +=0A=
>> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
>> +=0A=
>> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);=0A=
>> +=0A=
>> +out_free_report_zones:=0A=
>> +	kvfree(data.rz);=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);=0A=
>> +	sector_t nr_sect =3D bdev_zone_sectors(req->ns->bdev);=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	enum req_opf op;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (req->cmd->zms.select_all)=0A=
>> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);=0A=
>> +=0A=
>> +	switch (req->cmd->zms.zsa) {=0A=
>> +	case NVME_ZONE_OPEN:=0A=
>> +		op =3D REQ_OP_ZONE_OPEN;=0A=
>> +		break;=0A=
>> +	case NVME_ZONE_CLOSE:=0A=
>> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
>> +		break;=0A=
>> +	case NVME_ZONE_FINISH:=0A=
>> +		op =3D REQ_OP_ZONE_FINISH;=0A=
>> +		break;=0A=
>> +	case NVME_ZONE_RESET:=0A=
>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL)=
;=0A=
> GFP_NOIO ?=0A=
Yes.=0A=
>=0A=
>> +	if (ret)=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
>> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;=0A=
>> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	unsigned int total_len =3D 0;=0A=
>> +	struct scatterlist *sg;=0A=
>> +	int ret =3D 0, sg_cnt;=0A=
>> +	struct bio *bio;=0A=
>> +=0A=
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>> +		return;=0A=
>> +=0A=
>> +	if (!req->sg_cnt) {=0A=
>> +		nvmet_req_complete(req, 0);=0A=
>> +		return;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
>> +		bio =3D &req->b.inline_bio;=0A=
>> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
>> +	} else {=0A=
>> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
>> +	}=0A=
>> +=0A=
>> +	bio_set_dev(bio, req->ns->bdev);=0A=
>> +	bio->bi_iter.bi_sector =3D sect;=0A=
>> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))=0A=
>> +		bio->bi_opf |=3D REQ_FUA;=0A=
>> +=0A=
>> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {=0A=
>> +		struct page *p =3D sg_page(sg);=0A=
>> +		unsigned int l =3D sg->length;=0A=
>> +		unsigned int o =3D sg->offset;=0A=
>> +		bool same_page =3D false;=0A=
>> +=0A=
>> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);=0A=
>> +		if (ret !=3D sg->length) {=0A=
>> +			status =3D NVME_SC_INTERNAL;=0A=
>> +			goto out_bio_put;=0A=
>> +		}=0A=
>> +		if (same_page)=0A=
>> +			put_page(p);=0A=
>> +=0A=
>> +		total_len +=3D sg->length;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (total_len !=3D nvmet_rw_data_len(req)) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		goto out_bio_put;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(bio);=0A=
>> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,=0A=
>> +						 bio->bi_iter.bi_sector);=0A=
>> +=0A=
>> +out_bio_put:=0A=
>> +	if (bio !=3D &req->b.inline_bio)=0A=
>> +		bio_put(bio);=0A=
>> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);=0A=
>> +}=0A=
>>=0A=
>=0A=
=0A=
