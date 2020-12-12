Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2962AC4361B
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC931207C9
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 10:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438568AbgLLKFc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Dec 2020 05:05:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13751 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438567AbgLLKFb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Dec 2020 05:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607767529; x=1639303529;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FTwjlZWdAQNidYAsMOJg/47ptiBhDrN7KMSV42ynrXU=;
  b=pSVhd1Z8CmITBwtb2ZC87XdgC+jcCDXoCZAGauBav2ezkBd5lY/p6VfT
   RQCqMPcTl1JPeYI5WT/KRZybg4QmqRlMP3vsf24s5sfOCLpl8sBDqMZMG
   jjvaNN6JnMTYAkJQLxvgFpQzCyqpcp7lR3M5tnZRM9zaKSgv9gdtWBw3y
   Z7t1vwo7f6yWgKKiuVWaDaV2f1DBSf5XhOOtgN5CogSzetP7FYl689dqV
   KUHVZkmtUQnt9vhTlDRuXze6q5fvR+MK66M1vEIge3f7HtVKNURuGKrJV
   NbhYzvR80q5MV6bit9/YeyRJu4iJcZphYEAO1s3CgiTZD7wlPR2ojWfr3
   g==;
IronPort-SDR: UvgiLr9ziT6sVzhIAdr/n00GLAm5o3nQ/G9/76etN6+N0bfS0rn5XUBznr/bBqFzJGkrGYrmn2
 FDCC5ILExx6V1CUH1cDIeOPInsQVR1dkj3OBQyX8O7JMPQLSkjMkNCXmXIK2K+Vwi18eNsmWKP
 z9HKYkDJXxllOvkTUtY33of+31Wq4zxGx2w9e8hzli6znBIvFVR4rbxprs2eUbPIeimaYHbHPY
 F+fM4HNt7RnBGW4qSApsQhsdFf3m0vFqrU+pkJQQx4S1NuXYNCOSbZfMe0yhaE8eXE/5bmoqXk
 QPo=
X-IronPort-AV: E=Sophos;i="5.78,413,1599494400"; 
   d="scan'208";a="159446394"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 14:54:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2qA1eDBQSXiuOZM6YLpkLHdhUJtBGS5fLRjZnrRyh6cn4f4mYdUzB/lfpWKvBboF/2OICK37tIXtlP4z6H6nw+KWWYS5hr5p3KPztjJqnQ/CaZJwJw6I/yyQZqNnLF66I10Yb/NENx4hdojDPopIlFPrVBE/nxvZS+NCwKVyLldw58wj1juclqSlDWRZcPJOoxwLhtL7NOXeftJb3CRMSGujTpTvLhzFH3ka7kv47DCAEcyq5PnvMITQS8yZHT081J8phwDAS7v33x5VqHtfMrXjtecol9eEU5GBRvElqexqcPfv+egYrltylZbkfhfdPwGw0sYCL7yOXi1+umkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBOh2ttDYMR8UUXsnBYksTnQenzk6JAonT+dbbzPR7M=;
 b=grMJNtDjWVIZgDneZQPvQU1EkMvE6T/ewL7IrZAfxuMFiCx9c9wDtaHZsZexTnCL6YUVopzaFFT+JxXdzfhaMeZmZA77m3yimJa21umFK1K+DEqJgFB6e8xsPysbCaxHsxH3AGn9C6DMV2SjoAh8k2W05s1Apl6WwtLJvPUN9/nueBxuPi2ywAElpwKWqwyxqxnJG/oRMho0sP0w976xcRUGjYGKQERRt0Ve5MTpIY0jhTruneJe16OEimGPLJE4OSI/wCxSHY198Iux04hIjAGuqQbkqfebjgGu9daO33rHRkkK5tgwOzUIWRuvcpDRPBR5Qf0frO4Z6gx3tS3STg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBOh2ttDYMR8UUXsnBYksTnQenzk6JAonT+dbbzPR7M=;
 b=tRfEV1RLAAM+/VG1LcHJHKXwQbsHf8lDqUPGtmXaSHpa0AD2StC1OzFEnD1M9OlAcz6vZ+mGigHn2RWixFpaSTh2NEu5x2FhpWDAAyr4BAuWOWUFzk6AoTDyXp+eL/PK786sJF2EtVNgepa8r9hCH4PohV4Kh63fR24VqahHoPo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4662.namprd04.prod.outlook.com (2603:10b6:a03:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Sat, 12 Dec
 2020 06:54:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Sat, 12 Dec 2020
 06:54:21 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V5 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHWzr2FuszvFJU9HEW4WB60UcvV9w==
Date:   Sat, 12 Dec 2020 06:54:21 +0000
Message-ID: <BYAPR04MB49652F762776AC04BC2719A386C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-5-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652299EA78B1304157CC8234E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f51d0bea-e8dc-4deb-e8a1-08d89e6ac12c
x-ms-traffictypediagnostic: BYAPR04MB4662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4662B87351930B45BCB248B786C90@BYAPR04MB4662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZqY3yCmCryln9PDg0p85uFOBTG/+Lor1/SZwyEfyxzRCGXWfWC0UXmKqW24AKAt77d+kHhEV02jA+08lxa9RU+JMvJS+6/G7iqeqNsWhYQYPo7LbHGnQBB0eEFJAu3F/UuUG5ECi3jgQS23RKU1kc3p/SjHXhpdkBmnEsQum0c7CWjbBB3B7FivfylAJXPn0SbgIeQdSRXVU8J18K+vnG1knW4yQdUtRbxt7Sc62nICFGUqC9CU2r2LUzZjbbKFJklvfzKImIvCmdviE86k9Nkg+BnzXTPMLsiYg2Vze5WALb1gGcKrucx+hBhot0mEr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(83380400001)(6506007)(55016002)(9686003)(33656002)(8936002)(8676002)(4326008)(30864003)(66476007)(2906002)(66446008)(53546011)(64756008)(110136005)(52536014)(66556008)(186003)(54906003)(26005)(76116006)(7696005)(71200400001)(508600001)(5660300002)(66946007)(86362001)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?ot9jYQV6rWdzm2jEK22WJUK1gQ0DNz622oRinWM2vRN8IlW3hdMyc9j5?=
 =?Windows-1252?Q?VPdnh+5TG9y5VNlanRh2QZW20xCaSW0UUC/J+x79wdwEMjTWS/KDIyhR?=
 =?Windows-1252?Q?Mf6zlZ6uXW+n5fkGuLN9QAokmNeP6ZVktrSRxkcNVZqisB7DU5DDq8Ec?=
 =?Windows-1252?Q?KI5BBIqmBLvRiub5+MMXXT8uHAnM+eXja1Iosj+l1f2tb0NvCyUM7WyA?=
 =?Windows-1252?Q?p0k0njS7To3pM95bTJ/99dfdpYpf692nVPTRpT6CUcmBvkYe6RIGYEoE?=
 =?Windows-1252?Q?pns5R/wIvWk8zhMcIy50TO28wOLi3qPE571ArBdU+48OI7GQniO4w3Fg?=
 =?Windows-1252?Q?eC9P64X2xVd4CzlSFRPs9PWl00PvQ/EGtG60CVP9buvLxW3Aktn4yN/0?=
 =?Windows-1252?Q?3QZlTm6nsceR4u86jax1JVxCqiJx5ceq+04jqxY7CCY8JnmcEqh/vKhU?=
 =?Windows-1252?Q?my/4ZSX0u9wwzg1ZA6JitPgpxICqkcNKqraFsE2dT1kGJusYr8/3rROz?=
 =?Windows-1252?Q?lyOpr2xqPSqN5xSbdRT8+26HkRzjs+XGn3uRiltnDM/Y2QT5g//Sjwzl?=
 =?Windows-1252?Q?tXiNw27APd8TZiBl6UNtbcXzt0rDt7WWLrzXGmn1rrOianzFCR32irOp?=
 =?Windows-1252?Q?Rm+8V4PjFI1ermE20+KYEgNaChnpBwiElQbFYRbEFtHJ1FePqhyoAlBQ?=
 =?Windows-1252?Q?PcVWxzYaE1urztLT+J0sG8kIx8DtrMm7wevPzaF8HYzWkeLMOTqFDC/O?=
 =?Windows-1252?Q?Uf3lqJutkFr0f4qAC34sFKSUxZN6FN4FGSzqotCkXMznE9+mp/8l6l7o?=
 =?Windows-1252?Q?PY/RptSb4/LN3vGbjzGokg20R0wMY/IFhtA/34x1qpDrz9XUjE93MZ72?=
 =?Windows-1252?Q?sJLFe353LvovqJX9Fs7JsDf5lE2dNIaQv8qx7Wx6i0SF9rPOKUVhefNB?=
 =?Windows-1252?Q?C1Jd0Vr66RqF9h9K3xZTa2iqzdA0dMkiEoaXwvMAh3SpUyoZ+mTTZtTJ?=
 =?Windows-1252?Q?AJ3gGkqxdbWSQxGkklNSZWt10fb14uwFrUyIqZnu6vMwZt4dfeMht6g1?=
 =?Windows-1252?Q?rCiayRjPJF1nYnEW?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51d0bea-e8dc-4deb-e8a1-08d89e6ac12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 06:54:21.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbvxnzNeNIct8mcRL2asxvvK+BsTLuhTcklkJiiAOD/5mz4XagUq0Ymyvb9JESr3O1H7fODoilfQNWcfNbJ1sXv5FHfVa6X5sOjIxg5XJr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4662
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/20 17:18, Damien Le Moal wrote:=0A=
> On 2020/12/10 15:27, Chaitanya Kulkarni wrote:=0A=
>> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to=0A=
>> communicate with a non-volatile memory subsystem using zones for=0A=
>> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe=0A=
>> Protocol compliant devices on the target in the passthru mode. There=0A=
>> are Generic Zoned Block Devices like  Shingled Magnetic Recording (SMR)=
=0A=
> Please remove "Generic" from this sentence. It is confusing. Also, I do n=
ot=0A=
> think you need to capitalize ZOned Block Devices. That is something Linux=
=0A=
> defines. It is not defined by any standard.=0A=
Since target supports ZNS in the passthru mode term generic is needed=0A=
to differentiate the backend type.=0A=
Regarding zbd I'm fine with that.=0A=
>> HDD which are not based on the NVMe protocol.=0A=
>>=0A=
>> This patch adds ZNS backend to support the ZBDs for NVMeOF target.=0A=
>>=0A=
>> This support inculdes implementing the new command set NVME_CSI_ZNS,=0A=
> s/inculdes/includes=0A=
Okay.=0A=
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
>>  drivers/nvme/target/admin-cmd.c   |  26 +++=0A=
>>  drivers/nvme/target/core.c        |   1 +=0A=
>>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-=0A=
>>  drivers/nvme/target/nvmet.h       |  38 ++++=0A=
>>  drivers/nvme/target/zns.c         | 327 ++++++++++++++++++++++++++++++=
=0A=
>>  6 files changed, 418 insertions(+), 8 deletions(-)=0A=
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
>> index f4c0f3aca485..6f5279b15aa6 100644=0A=
>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>> @@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(st=
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
>>  	default:=0A=
>>  		status =3D NVME_SC_INVALID_LOG_PAGE;=0A=
>>  		break;=0A=
>> @@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req=
 *req, u8 type, u8 len,=0A=
>>  =0A=
>>  static void nvmet_execute_identify_desclist(struct nvmet_req *req)=0A=
>>  {=0A=
>> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>>  	u16 status =3D 0;=0A=
>>  	off_t off =3D 0;=0A=
>>  =0A=
>> @@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct =
nvmet_req *req)=0A=
>>  		if (status)=0A=
>>  			goto out;=0A=
>>  	}=0A=
>> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
>> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
>> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
>> +							  NVME_NIDT_CSI_LEN,=0A=
>> +							  &nvme_cis_zns, &off);=0A=
>> +		if (status)=0A=
>> +			goto out;=0A=
>> +	}=0A=
>>  =0A=
>>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off=
,=0A=
>>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
>> @@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req=
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
>> index 672e4009f8d6..17a99c7134dc 100644=0A=
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
>> index 0360594abd93..dae6ecba6780 100644=0A=
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
>> index 000000000000..ae51bae996f9=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/nvme/target/zns.c=0A=
>> @@ -0,0 +1,327 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * NVMe ZNS-ZBD command implementation.=0A=
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
>> + */=0A=
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
>> +#include <linux/uio.h>=0A=
>> +#include <linux/nvme.h>=0A=
>> +#include <linux/xarray.h>=0A=
>> +#include <linux/blkdev.h>=0A=
>> +#include <linux/module.h>=0A=
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
>> +	u16 status =3D 0;=0A=
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
>> +	return status;=0A=
>> +}=0A=
> I really fail to see how the gotos here help with the code "being better"=
.=0A=
> Are you absolutely sure you want to keep this super convoluted style for =
a=0A=
> function that is that simple ?=0A=
>=0A=
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
> Hmm... BIO based DM devices do not have this bitmap set since they do not=
 have a=0A=
> scheduler. So if one setup a dm-linear device on top of an SMR disk and e=
xport=0A=
> the DM device through fabric, then this check will fail to verify if=0A=
> conventional zones are present. There may be no other option than to do a=
 full=0A=
> report zones here if queue->seq_zones_wlock is NULL (meaning the queue is=
 for a=0A=
> stacked device).=0A=
=0A=
If I'm not wrong each LLD does call the report zones at disk revalidation,=
=0A=
as we should be able to reuse it instead of repeating for each zbd ns=0A=
especially for static property:-=0A=
=0A=
1. drivers/block/null_blk_zoned.c:-=0A=
    null_register_zoned_dev int=0A=
        ret =3D blk_revalidate_disk_zones(nullb->disk, NULL);=0A=
2. drivers/nvme/host/zns.c:-=0A=
    nvme_revalidate_zones=0A=
        ret =3D blk_revalidate_disk_zones(ns->disk, NULL);=0A=
3. drivers/scsi/sd_zbc.c:-=0A=
    sd_zbc_revalidate_zones=0A=
        ret =3D blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb)=
;=0A=
=0A=
Calling report again is a duplication of the work consuming cpu cycles for=
=0A=
each zbd ns.=0A=
=0A=
Unless something wrong we can get away with following prep patch with one=
=0A=
call in zns.c :-=0A=
=0A=
From abceef7bfdf9b278c492c755bf5f242159ef51e5 Mon Sep 17 00:00:00 2001=0A=
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Date: Fri, 11 Dec 2020 21:21:44 -0800=0A=
Subject: [PATCH V6 2/7] block: add nr_conv_zones and nr_seq_zones helpers=
=0A=
=0A=
Add two request members that are needed to implement the NVMeOF ZBD=0A=
backend which exports a number of conventional zones and a number of=0A=
sequential zones so we don't have to repeat the work what=0A=
blk_revalidate_disk_zones() already does.=0A=
=0A=
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
---=0A=
 block/blk-sysfs.c      | 14 ++++++++++++++=0A=
 block/blk-zoned.c      |  9 +++++++++=0A=
 include/linux/blkdev.h | 13 +++++++++++++=0A=
 3 files changed, 36 insertions(+)=0A=
=0A=
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
index b513f1683af0..f10cf45ae177 100644=0A=
--- a/block/blk-sysfs.c=0A=
+++ b/block/blk-sysfs.c=0A=
@@ -307,6 +307,16 @@ static ssize_t queue_nr_zones_show(struct=0A=
request_queue *q, char *page)=0A=
     return queue_var_show(blk_queue_nr_zones(q), page);=0A=
 }=0A=
 =0A=
+static ssize_t queue_nr_conv_zones_show(struct request_queue *q, char=0A=
*page)=0A=
+{=0A=
+    return queue_var_show(blk_queue_nr_conv_zones(q), page);=0A=
+}=0A=
+=0A=
+static ssize_t queue_nr_seq_zones_show(struct request_queue *q, char *page=
)=0A=
+{=0A=
+    return queue_var_show(blk_queue_nr_seq_zones(q), page);=0A=
+}=0A=
+=0A=
 static ssize_t queue_max_open_zones_show(struct request_queue *q, char=0A=
*page)=0A=
 {=0A=
     return queue_var_show(queue_max_open_zones(q), page);=0A=
@@ -588,6 +598,8 @@ QUEUE_RO_ENTRY(queue_zone_append_max,=0A=
"zone_append_max_bytes");=0A=
 =0A=
 QUEUE_RO_ENTRY(queue_zoned, "zoned");=0A=
 QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");=0A=
+QUEUE_RO_ENTRY(queue_nr_conv_zones, "nr_conv_zones");=0A=
+QUEUE_RO_ENTRY(queue_nr_seq_zones, "nr_seq_zones");=0A=
 QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");=0A=
 QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");=0A=
 =0A=
@@ -642,6 +654,8 @@ static struct attribute *queue_attrs[] =3D {=0A=
     &queue_nonrot_entry.attr,=0A=
     &queue_zoned_entry.attr,=0A=
     &queue_nr_zones_entry.attr,=0A=
+    &queue_nr_conv_zones_entry.attr,=0A=
+    &queue_nr_seq_zones_entry.attr,=0A=
     &queue_max_open_zones_entry.attr,=0A=
     &queue_max_active_zones_entry.attr,=0A=
     &queue_nomerges_entry.attr,=0A=
diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
index 6817a673e5ce..ea38c7928e41 100644=0A=
--- a/block/blk-zoned.c=0A=
+++ b/block/blk-zoned.c=0A=
@@ -390,6 +390,8 @@ struct blk_revalidate_zone_args {=0A=
     unsigned long    *conv_zones_bitmap;=0A=
     unsigned long    *seq_zones_wlock;=0A=
     unsigned int    nr_zones;=0A=
+    unsigned int    nr_conv_zones;=0A=
+    unsigned int    nr_seq_zones;=0A=
     sector_t    zone_sectors;=0A=
     sector_t    sector;=0A=
 };=0A=
@@ -449,6 +451,7 @@ static int blk_revalidate_zone_cb(struct blk_zone=0A=
*zone, unsigned int idx,=0A=
                 return -ENOMEM;=0A=
         }=0A=
         set_bit(idx, args->conv_zones_bitmap);=0A=
+        args->nr_conv_zones++;=0A=
         break;=0A=
     case BLK_ZONE_TYPE_SEQWRITE_REQ:=0A=
     case BLK_ZONE_TYPE_SEQWRITE_PREF:=0A=
@@ -458,6 +461,7 @@ static int blk_revalidate_zone_cb(struct blk_zone=0A=
*zone, unsigned int idx,=0A=
             if (!args->seq_zones_wlock)=0A=
                 return -ENOMEM;=0A=
         }=0A=
+        args->nr_seq_zones++;=0A=
         break;=0A=
     default:=0A=
         pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",=0A=
@@ -489,6 +493,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,=0A=
     struct request_queue *q =3D disk->queue;=0A=
     struct blk_revalidate_zone_args args =3D {=0A=
         .disk        =3D disk,=0A=
+        /* just for redability */=0A=
+        .nr_conv_zones    =3D 0,=0A=
+        .nr_seq_zones    =3D 0,=0A=
     };=0A=
     unsigned int noio_flag;=0A=
     int ret;=0A=
@@ -519,6 +526,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,=0A=
     if (ret >=3D 0) {=0A=
         blk_queue_chunk_sectors(q, args.zone_sectors);=0A=
         q->nr_zones =3D args.nr_zones;=0A=
+        q->nr_conv_zones =3D args.nr_conv_zones;=0A=
+        q->nr_seq_zones =3D args.nr_seq_zones;=0A=
         swap(q->seq_zones_wlock, args.seq_zones_wlock);=0A=
         swap(q->conv_zones_bitmap, args.conv_zones_bitmap);=0A=
         if (update_driver_data)=0A=
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
index 2bdaa7cacfa3..697ded01e049 100644=0A=
--- a/include/linux/blkdev.h=0A=
+++ b/include/linux/blkdev.h=0A=
@@ -526,6 +526,9 @@ struct request_queue {=0A=
     unsigned long        *seq_zones_wlock;=0A=
     unsigned int        max_open_zones;=0A=
     unsigned int        max_active_zones;=0A=
+    unsigned int        nr_conv_zones;=0A=
+    unsigned int        nr_seq_zones;=0A=
+=0A=
 #endif /* CONFIG_BLK_DEV_ZONED */=0A=
 =0A=
     /*=0A=
@@ -726,6 +729,16 @@ static inline unsigned int=0A=
blk_queue_nr_zones(struct request_queue *q)=0A=
     return blk_queue_is_zoned(q) ? q->nr_zones : 0;=0A=
 }=0A=
 =0A=
+static inline unsigned int blk_queue_nr_conv_zones(struct request_queue *q=
)=0A=
+{=0A=
+    return blk_queue_is_zoned(q) ? q->nr_conv_zones : 0;=0A=
+}=0A=
+=0A=
+static inline unsigned int blk_queue_nr_seq_zones(struct request_queue *q)=
=0A=
+{=0A=
+    return blk_queue_is_zoned(q) ? q->nr_seq_zones : 0;=0A=
+}=0A=
+=0A=
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,=0A=
                          sector_t sector)=0A=
 {=0A=
-- =0A=
2.22.1=0A=
=0A=
=0A=
>> +		pr_err("block devices with conventional zones are not supported.");=
=0A=
>> +		return false;=0A=
>> +	}=0A=
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
>> +	u16 status =3D 0;=0A=
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
>> +	entries[idx].zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));=
=0A=
>> +	entries[idx].zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));=
=0A=
>> +	entries[idx].wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));=0A=
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
>> +	u64 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>> +	unsigned int nr_zones;=0A=
>> +	int reported_zones;=0A=
>> +	u16 status;=0A=
>> +=0A=
>> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
>> +			sizeof(struct nvme_zone_descriptor);=0A=
> This is a 64 bits division. This will not compile on 32-bits arch, no ? I=
.e.,=0A=
> you must use do_div64() here I think. Or just a bit shift since struct=0A=
> nvme_zone_descriptor is exactly 64B. Or have bufsize be a 32 bits. There =
is no=0A=
> need for that variable to be 64 bits.=0A=
I'll make it u32.=0A=
>> +=0A=
>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>> +	if (status)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
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
> reported_zoned may be far less than the request nr_zones. So you may want=
 to=0A=
> recalculate bufsize before doing this to not copy garbage data into the r=
eply=0A=
> buffer. Another thing that needs verification is: don't you need to zero-=
oput=0A=
> the data.rz buffer with GFP_ZERO, for security ?=0A=
With __GFP_ZERO used (for data.rz) we need to use the entire buffer size=0A=
such=0A=
thatit will zerout the command buffer that we get from the host. If we only=
=0A=
use the updated buffer size function of the reported_zones then rest of=0A=
the buffer will not get zeroed.=0A=
>=0A=
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
>> +	enum req_opf op =3D REQ_OP_LAST;=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
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
>> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;=0A=
>> +=0A=
>> +	sect +=3D (total_len >> 9);=0A=
> This is incorrect: sect is the start sector of the append operation targe=
t zone.=0A=
> Adding to it the request size does not give the actual sector written on =
the=0A=
> backend. You need to get that from the completed BIO. And do not add the =
request=0A=
> size. The result is the first written sector, not the sector following th=
e last=0A=
> one written.=0A=
Yes, indeed it should be bio->bi_iter.bi_sector correct me if I'm wrong.=0A=
>> +	req->cqe->result.u64 =3D cpu_to_le64(nvmet_sect_to_lba(req->ns, sect))=
;=0A=
>> +=0A=
>> +out_bio_put:=0A=
>> +	if (bio !=3D &req->b.inline_bio)=0A=
>> +		bio_put(bio);=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>>=0A=
>=0A=
=0A=
