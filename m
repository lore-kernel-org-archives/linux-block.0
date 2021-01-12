Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2C7C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039E622DFA
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 07:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbhALHxh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 02:53:37 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60939 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731929AbhALHxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610438017; x=1641974017;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uNrIheT5YDjKq0nA5mpcNrzS9f07ZCydTc3nyZSNGoc=;
  b=k07dqQD00NsmiEaJdj7yzalREe5zaFOsY5NwuqjDhzdY0KyUYsbRXPVr
   zUT5hZMk5E3eHrQrGO3h7uFSklyT90Ao8mw8WvAd96m9aUkHyDWquc9bN
   lok/Fs+HUee803/pSejdOFpkl0PZcxybeCPVgIJY/Hqi2FRaa07ToVdFo
   xq4X76xgtwqySaq+1i4/LwGj5DSPWtcff3fiWrzIbOvlQDbvhJP6zkh9q
   soWGKYbSn+sPWjS5UqkTttGFq3MeyDhpCrE7MDColu8Zae/6kpP3tJ3GN
   /NFmdIsQwKphDUdiaHBZ4iOI+BrXjoFqsnzak4EaNfN7t95MyWBUlSbaR
   Q==;
IronPort-SDR: 3jFoyd5OTYHv4vBDddLas4SHTFbbkFZID3wbWfGfsCJtZXoLYPMFozIgEIshfj2Hs2AFKEmu2M
 slJHJdiVMEKxUSbxz8sVUFtMW/nAVyAJRtx0os2QwF1oWP5X7CrE/EZx9g+ryMjmsGWlReqHnn
 ca2H+xTTKa0Rpq83CaikheYjlrDVSshJ+zofjx4rmZW1mihdhcH+qjs3Uz4KcCFrH6c/qHIStC
 nAnfxSiXmhVr4Bzzzo4qObZc5UBRFBiFSZU06kIe2RM2m1fDlLCqUbAmy03ek0kDyeEJ3G2avy
 Obs=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="158393100"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 15:52:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR/n8dbaK+T59XfF1sG8iNZfUe+FyyT+2VTrtMcEBDxQUsFPHfi6cNQJWFHAiGMphArpXzmwE1XPBcHHl+UjURc/abxR420DJJ6X+CtHowY14U2dGJxoD47PxaK0SEv0LyAZffei6RYKPIpRIXE2kYEIr4T4HUS9MhAp+DYXIoLcgrpjc2nrIE/lK+hAwSVwC4KBQpLTG7xMItrgbOLWf94xPiwVJ9aIensgy8RtgycuU0YepSQsex4llfNY1u714xtzYoWgZ9CeukJKM4I0RE8Epdf9un6UBNK1u/YGZI3CtoRKliE7wUx0MQsU9tRgjRjqcUc3mc35DL3K4T0XDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkJwkmEZEnFS/av1r86uUzdi4bDSMfmSRu7Kiz9aS3g=;
 b=EDuNWN1r0SakpCnAStLsi+fFiucnx2W20fWsYsn3kKFNo35rE1n5+TZusSAztoTLtGPnwCtTaF/qB3segMtWhSQrrYSj4FKl9DdKmqnXvTAYJ4n8W06jmK20x24MzscgIovMyN+yns+QfZKObWSZ5VTg6eP4R3z+38qvcet3YkUkOH2YWfwAhcQgbTKe2FvdQ0c5cSxR1M1AVK8kNl5NKJ/tEuFGQmLyppQR3E+9XwZeaVRWpLgtxTULwDLOvBvwkMtnYzCtrk94d/ILSxoEGBdwVLJbcKZaiG1qu5BE9gHpNi4dGLGPKlp8mS0T61Ml7RdrgvQ8mp4VfOMvOtENzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkJwkmEZEnFS/av1r86uUzdi4bDSMfmSRu7Kiz9aS3g=;
 b=Qe17HtU194Zge1/k47wutRphU/sxAJqBlQuft0zwlqb5XsyNP8wFbzGqvDVxxYD19Mkjr6+6Ls6zYaYNnEXiixjaMGeaMyRYhhPdaPD7EnLm4mCXwg1jD1fgxFFdhX8UGbWsLy8s7x/hOPF9jgHPS7AZjcYoP6OKD1v+jOe9Xww=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4739.namprd04.prod.outlook.com (2603:10b6:208:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 07:52:28 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 07:52:27 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6Jsz5Um6YbJoj0ev+CR8KYF1Aw==
Date:   Tue, 12 Jan 2021 07:52:27 +0000
Message-ID: <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:5cb8:2b48:5f8c:2c03]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b49d520e-6e6a-4342-834d-08d8b6cf01e0
x-ms-traffictypediagnostic: BL0PR04MB4739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4739ED87F41F6ADA2B158A95E7AA0@BL0PR04MB4739.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsAEri3BJ9HPFsatL6ZG8iYKGQieIkwcAX0Ahn4oovt925VRZ4RNvO3VjJvGv/ujGQLPNFRg1JaVnXwkFyCGW01op3gjjlBLwjsWTXoS+rMDL1ZleqPYGxUnFFUVD3pOzBwnQu9Gi6l1MPozifL49J4YG4jgFFldyO1Ioy2P5an+SRmcWA4MW6dYeoxkCbhdTIySLDmR1JjRL5VibLsBnsC4BHP5QVHkS8oPtNUK+AbEjinMCyLVdOgTOSdWUG2anfQnu+zlAJF5pFPWA0oJyuf4xBhYuDIVd5FWAly9EJt0z0788cn2YWOny8zHygAG77Ssbtx0gGryXVPPgP12aYwfSZBPG/0eSnPTOU+EEcVHuXkeAv519KjynVufw8Yj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(6506007)(7696005)(71200400001)(33656002)(53546011)(8676002)(2906002)(110136005)(478600001)(8936002)(4326008)(316002)(55016002)(64756008)(66476007)(66446008)(186003)(66946007)(52536014)(9686003)(83380400001)(6636002)(5660300002)(86362001)(76116006)(91956017)(54906003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?q2lvOCykJ6nlOlyPHSWMJUEfl3l7r2ykrU2dBuxPpBdrNkx5kPxIzf+33eyA?=
 =?us-ascii?Q?cR/i6pc0s4sSti/8o230whfD70rpP8s5VXycZXrSFCuVRzGZUdfSXB0r9nTH?=
 =?us-ascii?Q?lW8PQOx+Wr3YGSyQzB0JYykqsQWE7dqXYAVxjD+mPNPH6pqDGT1j+ePd46AY?=
 =?us-ascii?Q?buKEkt1g0+9mKLhd5Vp6lAW1l3oaPl+4/SKPFCZCVEa0EoCxo2F+CXMr7OYA?=
 =?us-ascii?Q?VGpJEFnEq/ZUW0sAUFd3EVoVHzvY9si1l1x1jZFCxSYS0GHN7d9t47kCcPBr?=
 =?us-ascii?Q?BLLrC6hbw92Cm/V58/lqoVanFsjsnp+vO0GhEe9yCW9PIvEhK+jYd9oi+jKh?=
 =?us-ascii?Q?HH12NiXGzCv2MtbQTnWJhWEKgCUvlHh2rQekvO5SufmU5dEqCAFmOvXqjpfc?=
 =?us-ascii?Q?8gTF0yWQe2SIfDcMaibXztzlh7zJ7QiMIawUvx2sZ8JoBUKFdtaPM1xoEV9i?=
 =?us-ascii?Q?sZlYYsxEiigYYBGZByLK3VZthVzKun7MZWKoWjbePl2oEZWWl/pR8MgaF2Ay?=
 =?us-ascii?Q?7CslY+eTxlEL3Dpqqxk0UKIZIwYGMBu6Qbk81CLte3Dz5GtUY4kK8v1i2AVJ?=
 =?us-ascii?Q?AakHCUmPIP+h/sfgP8V65gh79fv+9OObmAGHTzErkNsp/EYhYGN02HzI14VN?=
 =?us-ascii?Q?I0Q/2aZW9dpYPJzFWMUvme3O9gReUdHA3VyyzlRNghZAJ7BH9ttX1DzhU2l0?=
 =?us-ascii?Q?cQRS4JnjKEXbXUFX6Usp8KtIs1mH5UxR4jzRvqoj+CnGYYkLyaFbpgyXCSAc?=
 =?us-ascii?Q?3iPPD2k/zBxjE+zsRphFEfn2l866foJ5TbYIT22GDXRurYwuyTJwjh02ttCr?=
 =?us-ascii?Q?Xc7J2jq6Quf9QdqnspTFAY/4oYdHxTK5K/P7dnupuXqtkThqT9m8cUf9wqSV?=
 =?us-ascii?Q?dvlVLuuy7Sqj3WGHwVdhkIrSYdQUfHfcL2psonw47mGCsDhrdSZS4V3HFt4S?=
 =?us-ascii?Q?SjNB9VxPaM5Qvu4zQcOlexCqhyDuqwRKE40rKbsOWDXbxhT8wtmmdPguP3NV?=
 =?us-ascii?Q?tLnZrJmMcEOAuxAfub+NOBP42C0lwrmF8I0cM6ae/HQGbyVBuD4eyZhxvGMG?=
 =?us-ascii?Q?jNbbbIfI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49d520e-6e6a-4342-834d-08d8b6cf01e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 07:52:27.8294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3V7jwlE7VisaUop5N7w79gFMz9kls/ebFI35sqP8XiLeFwtylbrWHemQe8OcuLf/tNXTsClGHkGtITDzAYLsiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4739
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/12 16:48, Christoph Hellwig wrote:=0A=
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
>> +		break;=0A=
> =0A=
> We need to return errors if the command set is not actually supported.=0A=
> I also think splitting this into one helper per command set would=0A=
> be nice.=0A=
> =0A=
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
> =0A=
> We need to add the CSI for every namespace, i.e. something like:=0A=
> =0A=
> 	status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LE=
N,=0A=
> 					  &req->ns->csi);		=0A=
> 	if (status)=0A=
> 		goto out;=0A=
> =0A=
> and this hunk needs to go into the CSI patch.=0A=
> =0A=
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
> =0A=
> How does the CSI get mirrored into the cns field?=0A=
> =0A=
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
> =0A=
> This needs to go into a separate patch for multiple command set support.=
=0A=
> We can probably merge the CAP and CC bits with the CSI support, though.=
=0A=
> =0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {=0A=
> =0A=
> bdev_is_zoned should be probably stubbed out for !CONFIG_BLK_DEV_ZONED=0A=
> these days.=0A=
> =0A=
>> +/*=0A=
>> + *  ZNS related command implementation and helpers.=0A=
>> + */=0A=
> =0A=
> Well, that is the description of the whole file, isn't it?  I don't think=
=0A=
> this comment adds much value.=0A=
> =0A=
>> +	/*=0A=
>> +	 * For ZBC and ZAC devices, writes into sequential zones must be align=
ed=0A=
>> +	 * to the device physical block size. So use this value as the logical=
=0A=
>> +	 * block size to avoid errors.=0A=
>> +	 */=0A=
> =0A=
> I do not understand the logic here, given that NVMe does not have=0A=
> conventional zones.=0A=
=0A=
512e SAS & SATA SMR drives (512B logical, 4K physical) are a big thing, and=
 for=0A=
these, all writes in sequential zones must be 4K aligned. So I suggested to=
=0A=
Chaitanya to simply use the physical block size as the LBA size for the tar=
get=0A=
to avoid weird IO errors that would not make sense in ZNS/NVMe world (e.g. =
512B=0A=
aligned write requests failing).=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
