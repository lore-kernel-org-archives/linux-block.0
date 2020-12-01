Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D74C64E90
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E10221FF
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZqT+MzUW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sAKuOKWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgLADj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:39:56 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25933 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLADj4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 22:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606793995; x=1638329995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MAPXW9bU2mHS8WjNNsJQs94rVHv8RjNdHCSvwZ07yJ0=;
  b=ZqT+MzUW17rNmmPfzMI3BLgsyqiFh0oBW2JKNUEnPSXd8r9h6wal5161
   hT/4hBlXlXmT0YhoBYVhcs9Zj00MmMFYLFO/HHugME//oVtNOt7zwTujo
   z+6qyEtlmdz7dDE+kYGyf97K2v9a+S+DjyHA4XTZBzp6SQIe4JdmfNhwU
   JTQBuS1E99SOfQ2iX+tjIk3Z9W6I0f6Ru2NDuogAfXSKdgoyZw0lijtSO
   UBFD5DSH/IhFVEhAsYq37oyi3SPzGM9BYWpp16hs2OqfKltV6X4ecmXi6
   QvSuN9K++Svwnixi/V6UQcNYP6/moeg25BupXKC3dkLIAypPkORmMEhZJ
   w==;
IronPort-SDR: IUPhov7c+GMWLmGSmPxzgmsZg826DUa4tli5A3rNPjuxEHErryNAz0oYAuhSwBFaUQM5854k7m
 V10FT4iqLGuS9PJdqxpx03GDEPwYkvlIDsKLgi4bkMHoQPXORtQIzS7YnyvosTD5ztEZ+BMprY
 4tFfPKfp58MPpPm5VuvhuEELZm3pXkbUQEdVqxuHu4DjwAVDWJBJXQpYP02l7WcDZryqG2pFo8
 6G/YXgFQQaDTTB5tby5t2EUzfAfloIWJnvB7TkREOnndxoBR7quKvqC6HKq971HP4NsXV0DGPN
 kfU=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="264003202"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 11:38:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0J8xnTpKAk+l0RbEH3eIGCLnD8Hi+PkxYEpJr44wI84JC0dn6Fwy0MoK0CZlK+I8+Ds/JwuQdv10yiYGF45qsqNUByYweSy0jZZTt+Zgtu7iQzmXYdULTRgrfJVASN+ZTnp6JALUSbfpz5bZ0jKAqAUeaZPu3AL2l/zOs2pdYVdpOYUd2oX59Pb5PtaDDYkkntAJaxWgBs6HWDywPFg/QNfQP1bt3ac6pz/F7+XIMGajGFJgb2l5XnS3fAEVIn4b6HGx5sxMwTV1WGE1/4mqIrv4qPQAuoN15ObqtrBVoHfvyyxmWu+64mwTY1g9DD0QmakMGjyBVQ9CiaPsh7mUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6bCzr9U88pl+JGTRWMWBNl2bqqRxMYklIc85/8hslo=;
 b=kXSUMzYpJXy5IF21V+WGHrLtLkaD+x9iF2TJvUQwZFipQYbTF5eS5B8hbhl55uArkcwb2z75M9Xouc7oSe8c8SNVrbwf55WueRf2i/ZRsvSHeSCYYsVuBzp+XZdaPovhmXiA5ZKEmCseSGGIJ+5Szo8LiUtTJHEypTAUd4Yd9zRq6UgiKF85PeUyJ+P7pwdE0X35DxLOfBR5KeT4lcKfDIqZUSiYDDLg4t9LGiD5C3MX4ZgkvyicHPyKsIBHuLVnSbSHqkFd+OxU9FhPYtn6VhKYelc9Woqvmn7X8OrrcV0JKrmXPp/X0AS5/vM8I7rnmWtkdflNrKoGiauUjA3xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6bCzr9U88pl+JGTRWMWBNl2bqqRxMYklIc85/8hslo=;
 b=sAKuOKWnRxA3EV2MVjKXjBIBNNUhLO2+KgjOV/Yk1x9ubX8YwwmnHfnIVECP2dCVRfQlf6odJ6oqQsm1psVjppyETg4zS33qLzeCyRX6VZjUIGrtDyqvDTDfX76HefVQ29Cm+NVCsMsYwrCSWeeqDOwzKorurcnqfNYbeiwDS90=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5429.namprd04.prod.outlook.com (2603:10b6:a03:d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 03:38:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:38:47 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH V2 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWxskIz83/zqf400uhEmx/aulqvg==
Date:   Tue, 1 Dec 2020 03:38:47 +0000
Message-ID: <BYAPR04MB49654A4ECB46346E8445D8AA86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <20201130032909.40638-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652237C06F44FF3C9B6DDD11E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fab86f73-a94c-4744-2e1b-08d895aa9c78
x-ms-traffictypediagnostic: BYAPR04MB5429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB542901F54714D94CDB8ED6BC86F40@BYAPR04MB5429.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rspEO0gITg5z6HQ2+pag9dLfDRscOu6mKtyTDjHpRzeTFXo8D2GItRhgrnOWG7sMFV1ZMQfotSg4bdB7lZY4wBV+qKVMpXim7MDJ3YGq5f9SbS1MPbMEYJYHGLwtNytqhE6ybSQTSC3Pgy3xsfxqvB8sRU2LB0ifcp2C818a3vY9GXEiTuTjq81bfghJ5/Jq/sALE5AAzw7wp4yl8GVKXBD1T3hmR5WR/CRBj974IHDvGNU/3UMqyn8+mJ4GKawlRd0+X1Di2eiz5SX2Rf7NFG8lPEkisKCp6s9mvO7mtwL+okVT5eJbVdZWjUp+aX6K2jNQpY99ynI7cQUDn7cXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(66446008)(66946007)(76116006)(83380400001)(66556008)(5660300002)(86362001)(30864003)(33656002)(53546011)(71200400001)(6506007)(54906003)(55016002)(4326008)(9686003)(26005)(110136005)(64756008)(52536014)(66476007)(316002)(8676002)(186003)(7696005)(478600001)(8936002)(2906002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iKt02GOlZ2145LZS3Ca6t5yzEKuIUcnIe0ofwnOU3zjTrTp8+PcVrvMNx67R?=
 =?us-ascii?Q?cAZcdA0CNUBKzID0LfAwkc4LyIWEFrzWzDIIYVf+XJccfpfs3qbNvOlLzYc6?=
 =?us-ascii?Q?vWzC+N/cAx/J1g/2oxM432VtvcvDVaXGMEu2Hh5aPDpB5nmQtVrQTTF4cdfL?=
 =?us-ascii?Q?MAt20Ev0YDBtevCu1jWxCsKP0NA4/2YMP+6xP2PyYQSevj0gNoEm27Y2CLa9?=
 =?us-ascii?Q?8PyfymkdqQ4M3voh8k7+Y44eJzNcV1WgBaQRJ52qCJVUvkGd5qoX0CRgT4Gm?=
 =?us-ascii?Q?5xOaNOR4npcaCvSixskRN9Rv0WLnmTkCc4l4n6mYSGyxGIadRO+BdpXWspUV?=
 =?us-ascii?Q?xS/JXEDGVOtZVCbuk8aSDJPOjLAtZeVOeVyUZ62ET2gg9uEPfi4/3rvcZ6uL?=
 =?us-ascii?Q?0zKMI/dfEyRHUOhI8JCkAp1TP6nNE8Od5KjOCIu/VJAwDLsRRYZhyhP5zUKT?=
 =?us-ascii?Q?BqIucngG8dCfwmPrX9cLmdzhKHXQDAKH+Ax900qIoVjp9vqicIRzZVtUlm3Y?=
 =?us-ascii?Q?86tR0kSYsmQF17gTYcTJinO2tPIWkqOvmjyIBjl08hGHmT0oxgqid51otcfN?=
 =?us-ascii?Q?+Gro0LUxDIRM998awESSqPPGnjZZwL1QZZ1NHYDYXNSQiKsQ+IWdEOgS8bYl?=
 =?us-ascii?Q?o13UmMKuu4/qbalQ8vKZteq10An04TLp7vkJEnqiQleL8l/lRSfXINycnD7U?=
 =?us-ascii?Q?AaYgx/Zxqj/tuSeM3h/5tSU4/DsHEQmIaMYxcrje8ILFk+izqMtMuXh6vPlT?=
 =?us-ascii?Q?GZ9s4+calW+Umst8UFwaWnk8Km47PDKdjKcLt1FyxYo76lNXo5BzaXXMtefu?=
 =?us-ascii?Q?/V+v+YMTnjFQJFrUyHpS8BiOIQ66MB59nNpij2OKqcRDkgF3xiB1nLIn9Jn7?=
 =?us-ascii?Q?hBmkGHrLhCHbM2xck0XyNQ4TSeuuFufBziCsD3zOB/kg0vYm7hNMWFHrEk3p?=
 =?us-ascii?Q?Bovlk728MVSg4Nim7j9aeaGAPEmoBDN+mKlIdmG7e6zCstYoi1CRxO2M6yNj?=
 =?us-ascii?Q?J2CR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab86f73-a94c-4744-2e1b-08d895aa9c78
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:38:47.3716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0KFRcMfuYY4OcR5UyIqDPQhBnRCWFt/EONiXM/SCiAnRcpy37DSSq4BH8Mn6njy+JqpykgPLU15Ds0QNDU/1ywKZShaiVl32Yb+sCxdNK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5429
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 03:57, Damien Le Moal wrote:=0A=
> On 2020/11/30 12:29, Chaitanya Kulkarni wrote:=0A=
>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,=0A=
>> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS=
=0A=
>> support for bdev.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  drivers/nvme/target/Makefile      |   2 +-=0A=
>>  drivers/nvme/target/admin-cmd.c   |   4 +-=0A=
>>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>>  drivers/nvme/target/nvmet.h       |  19 ++=0A=
>>  drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++=
=0A=
>>  5 files changed, 486 insertions(+), 4 deletions(-)=0A=
>>  create mode 100644 drivers/nvme/target/zns.c=0A=
>>=0A=
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
>> index ebf91fc4c72e..d050f829b43a 100644=0A=
>> --- a/drivers/nvme/target/Makefile=0A=
>> +++ b/drivers/nvme/target/Makefile=0A=
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+=3D nvme-fcloop.o=0A=
>>  obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>>  =0A=
>>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>> -			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>> +		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
>>  nvme-loop-y	+=3D loop.o=0A=
>>  nvmet-rdma-y	+=3D rdma.o=0A=
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin=
-cmd.c=0A=
>> index dca34489a1dc..509fd8dcca0c 100644=0A=
>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nvm=
et_req *req)=0A=
>>  	nvmet_req_complete(req, status);=0A=
>>  }=0A=
>>  =0A=
>> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 =
len,=0A=
>> -				    void *id, off_t *off)=0A=
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
>> +			     void *id, off_t *off)=0A=
>>  {=0A=
>>  	struct nvme_ns_id_desc desc =3D {=0A=
>>  		.nidt =3D type,=0A=
>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-=
cmd-file.c=0A=
>> index 0abbefd9925e..2bd10960fa50 100644=0A=
>> --- a/drivers/nvme/target/io-cmd-file.c=0A=
>> +++ b/drivers/nvme/target/io-cmd-file.c=0A=
>> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)=0A=
>>  	return ret;bio_iov_iter_get_pages=0A=
>>  }=0A=
>>  =0A=
>> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist=
 *sg)=0A=
>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)=
=0A=
>>  {=0A=
>>  	bv->bv_page =3D sg_page(sg);=0A=
>>  	bv->bv_offset =3D sg->offset;=0A=
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=
=0A=
>> index 592763732065..eee7866ae512 100644=0A=
>> --- a/drivers/nvme/target/nvmet.h=0A=
>> +++ b/drivers/nvme/target/nvmet.h=0A=
>> @@ -81,6 +81,10 @@ struct nvmet_ns {=0A=
>>  	struct pci_dev		*p2p_dev;=0A=
>>  	int			pi_type;=0A=
>>  	int			metadata_size;=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +	struct nvme_id_ns_zns	id_zns;=0A=
>> +	unsigned int		zasl;=0A=
>> +#endif=0A=
>>  };=0A=
>>  =0A=
>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)=0A=
>> @@ -251,6 +255,10 @@ struct nvmet_subsys {=0A=
>>  	unsigned int		admin_timeout;=0A=
>>  	unsigned int		io_timeout;=0A=
>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
>> +=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +	struct nvme_id_ctrl_zns	id_ctrl_zns;=0A=
>> +#endif=0A=
>>  };=0A=
>>  =0A=
>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
>> @@ -603,4 +611,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns =
*ns)=0A=
>>  	return ns->pi_type && ns->metadata_size =3D=3D sizeof(struct t10_pi_tu=
ple);=0A=
>>  }=0A=
>>  =0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);=0A=
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);=0A=
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);=0A=
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
>> +			     void *id, off_t *off);=0A=
>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);=
=0A=
>>  #endif /* _NVMET_H */=0A=
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..40dedfd51fd6=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/nvme/target/zns.c=0A=
>> @@ -0,0 +1,463 @@=0A=
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
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
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
>> +out:=0A=
>> +	return status;=0A=
>> +}=0A=
>> +=0A=
>> +static inline struct block_device *nvmet_bdev(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	return req->ns->bdev;=0A=
>> +}=0A=
>> +=0A=
>> +static inline  u64 nvmet_zones_to_desc_size(unsigned int nr_zones)=0A=
>> +{=0A=
>> +	return sizeof(struct nvme_zone_report) +=0A=
>> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);=0A=
>> +}=0A=
>> +=0A=
>> +static inline u64 nvmet_sect_to_lba(struct nvbio_iov_iter_get_pagesmet_=
ns *ns, sector_t sect)=0A=
>> +{=0A=
>> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);=0A=
>> +}=0A=
>> +=0A=
>> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lb=
a)=0A=
>> +{=0A=
>> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + *  ZNS related command implementation and helpers.=0A=
>> + */=0A=
>> +=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>> +{=0A=
>> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(nvmet_bdev(req)))=0A=
>> +		return NVME_SC_SUCCESS;=0A=
>> +=0A=
>> +	return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI, NVME_NIDT_CSI_LEN,=
=0A=
>> +					&nvme_cis_zns, off);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
>> +{=0A=
>> +	log->iocs[nvme_cmd_zone_append]		=3D cpu_to_le32(1 << 0);=0A=
>> +	log->iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
>> +	log->iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
>> +}=0A=
>> +=0A=
>> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
>> +					    unsigned int idx, void *data)=0A=
>> +{=0A=
>> +	struct blk_zone *zone =3D data;=0A=
>> +=0A=
>> +	memcpy(zone, z, sizeof(struct blk_zone));=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static inline bool nvmet_bdev_validate_zns_zones(struct nvmet_ns *ns)=
=0A=
>> +{=0A=
>> +	sector_t last_sect =3D get_capacity(ns->bdev->bd_disk) - 1;=0A=
>> +	struct blk_zone last_zone, first_zone;=0A=
>> +	int reported_zones;=0A=
>> +=0A=
>> +	reported_zones =3D blkdev_report_zones(ns->bdev, 0, 1,=0A=
>> +					     nvmet_bdev_validate_zns_zones_cb,=0A=
>> +					     &first_zone);=0A=
>> +	if (reported_zones !=3D 1)=0A=
>> +		return false;=0A=
>> +=0A=
>> +	reported_zones =3D blkdev_report_zones(ns->bdev, last_sect, 1,=0A=
>> +					     nvmet_bdev_validate_zns_zones_cb,=0A=
>> +					     &last_zone);=0A=
>> +	if (reported_zones !=3D 1)=0A=
>> +		return false;=0A=
>> +=0A=
>> +	return first_zone.capacity =3D=3D last_zone.capacity ? true : false;=
=0A=
>> +}=0A=
> That is really heavy handed... Why not just simply:=0A=
>=0A=
> return !(get_capacity(ns->bdev->bd_disk) & (bdev_zone_sectors(ns->bdev) -=
 1));=0A=
>=0A=
> That does the same: true if capacity is a multiple of the zone size (no r=
unt=0A=
> zone=0A=
Okay.=0A=
> ), false otherwise.=0A=
>=0A=
>> +=0A=
>> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)=0A=
>> +{=0A=
>> +	unsigned int npages =3D (zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT=
;=0A=
>> +	u8 zasl =3D ilog2(npages);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Zone Append Size Limit is the value experessed in the units=0A=
>> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.=
=0A=
>> +	 */=0A=
>> +	return zasl;=0A=
> Why not just:=0A=
>=0A=
> 	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);=0A=
Okay.=0A=
> And are you sure that there is no possibility that the u8 type overflows =
here ?=0A=
nvmet_zasl() is called with an argument which are unsigned ints :-=0A=
1. (BIO_MAX_PAGES * PAGE_SIZE) >> 9.=0A=
2. queue_max_zone_append_sectors().=0A=
3. queue_max_zone_append_sectors().=0A=
=0A=
size of unsigned int on 32bit machine should be 4bytes, so=0A=
0xFFFFFFFF >> 12 =3D 0xFFFFF and log2(0XFFFFF) should fit into the u8,=0A=
unless I'm completely wrong.=0A=
>> +}=0A=
>> +=0A=
>> +static inline void nvmet_zns_update_zasl(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	u8 bio_max_zasl =3D nvmet_zasl((BIO_MAX_PAGES * PAGE_SIZE) >> 9);=0A=
>> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;=0A=
>> +	struct nvmet_ns *ins;=0A=
>> +	unsigned long idx;=0A=
>> +	u8 min_zasl;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Calculate new ctrl->zasl value when enabling the new ns. This value=
=0A=
>> +	 * has to be the minimum of the max_zone appned values from available=
=0A=
> s/appned/append=0A=
Okay.=0A=
>> +	 * namespaces.=0A=
>> +	 */=0A=
>> +	min_zasl =3D ns->zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q))=
;=0A=
>> +=0A=
>> +	xa_for_each(&(ns->subsys->namespaces), idx, ins) {=0A=
>> +		struct request_queue *iq =3D ins->bdev->bd_disk->queue;=0A=
>> +		unsigned int imax_za_sects =3D queue_max_zone_append_sectors(iq);=0A=
>> +		u8 izasl =3D nvmet_zasl(imax_za_sects);=0A=
>> +=0A=
>> +		if (!bdev_is_zoned(ins->bdev))=0A=
>> +			continue;=0A=
>> +=0A=
>> +		min_zasl =3D min_zasl > izasl ? izasl : min_zasl;=0A=
>> +	}=0A=
>> +=0A=
>> +	ns->subsys->id_ctrl_zns.zasl =3D min_t(u8, min_zasl, bio_max_zasl);=0A=
> I do not understand what bio_max_zasl is used for here, as it does not re=
present=0A=
> anything related to the zoned namespaces backends.=0A=
If we don't consider the bio max zasl then we will get the request more tha=
n=0A=
one bio can handle for zone append and will lead to bio split whichneeds to=
=0A=
be avoided.=0A=
>> +}> +=0A=
>> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {=0A=
>> +		pr_err("block devices with conventional zones are not supported.");=
=0A=
>> +		return false;=0A=
>> +	}=0A=
> It may be better to move this test in nvmet_bdev_validate_zns_zones(), so=
 that=0A=
> all backend zone configuration checks are together.=0A=
Okay.=0A=
>> +=0A=
>> +	if (!nvmet_bdev_validate_zns_zones(ns))=0A=
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
>> +	nvmet_zns_update_zasl(ns);=0A=
>> +=0A=
>> +	return true;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * ZNS related Admin and I/O command handlers.=0A=
>> + */=0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
>> +	struct nvme_id_ctrl_zns *id;=0A=
>> +	u16 status =3D 0;=0A=
>> +	u8 mdts;=0A=
>> +=0A=
>> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
>> +	if (!id) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Even though this function sets Zone Append Size Limit to 0,=0A=
>> +	 * the 0 value here indicates that the maximum data transfer size for=
=0A=
>> +	 * the Zone Append command is indicated by the ctrl=0A=
>> +	 * Maximum Data Transfer Size (MDTS).=0A=
>> +	 */=0A=
> I do not understand this comment. It does not really exactly match what t=
he code=0A=
> below is doing.=0A=
Let me fix the code and the comment in next version.=0A=
>> +=0A=
>> +	mdts =3D ctrl->ops->get_mdts ? ctrl->ops->get_mdts(ctrl) : 0;=0A=
>> +=0A=
>> +	id->zasl =3D min_t(u8, mdts, req->sq->ctrl->subsys->id_ctrl_zns.zasl);=
=0A=
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
>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {=0A=
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto done;=0A=
>> +	}=0A=
>> +=0A=
>> +	nvmet_ns_revalidate(req->ns);=0A=
>> +	zsze =3D (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>=0A=
>> +					req->ns->blksize_shift;=0A=
>> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
>> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));=0A=
>> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));=
=0A=
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
>> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
> size_t ?=0A=
Yes.=0A=
>> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
>> +	struct nvme_zone_mgmt_recv_cmd *zmr =3D &req->cmd->zmr;=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(zmr->slba));=
=0A=
>> +	unsigned int nr_zones =3D bufsize / nvmet_zones_to_desc_size(1);=0A=
> I think this is wrong since nvmet_zones_to_desc_size includes sizeof(stru=
ct=0A=
> nvme_zone_report). I think what you want here is:=0A=
>=0A=
> nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
> 	sizeof(struct nvme_zone_descriptor);=0A=
>=0A=
> And then you can get rid of nvmet_zones_to_desc_size();=0A=
Yes, it doesn't need nvmet_zones_to_desc_size() anymore from v1.=0A=
>> +	int reported_zones;Maybe there is better way.=0A=
>> +	u16 status;=0A=
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
>> +	reported_zones =3D blkdev_report_zones(nvmet_bdev(req), sect, nr_zones=
,=0A=
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
>> +	sector_t nr_sect =3D bdev_zone_sectors(nvmet_bdev(req));=0A=
>> +	struct nvme_zone_mgmt_send_cmd *c =3D &req->cmd->zms;=0A=
>> +	enum req_opf op =3D REQ_OP_LAST;=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	sector_t sect;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));=
=0A=
>> +=0A=
>> +	switch (c->zsa) {=0A=
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
>> +		if (c->select_all)=0A=
>> +			nr_sect =3D get_capacity(nvmet_bdev(req)->bd_disk);=0A=
>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNE=
L);=0A=
>> +	if (ret)=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	unsigned long bv_cnt =3D req->sg_cnt;=0A=
>> +	int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>> +	u64 slba =3D le64_to_cpu(req->cmd->rw.slba);=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, slba);=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	size_t mapped_data_len =3D 0;=0A=
>> +	int sg_cnt =3D req->sg_cnt;=0A=
>> +	struct scatterlist *sg;=0A=
>> +	struct iov_iter from;=0A=
>> +	struct bio_vec *bvec;=0A=
>> +	size_t mapped_cnt;=0A=
>> +	struct bio *bio;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>> +		return;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * When setting the ctrl->zasl we consider the BIO_MAX_PAGES so that w=
e=0A=
>> +	 * don't have to split the bio, i.e. we shouldn't get=0A=
>> +	 * sg_cnt > BIO_MAX_PAGES since zasl on the host will limit the I/Os=
=0A=
>> +	 * with the size that considers the BIO_MAX_PAGES.=0A=
>> +	 */=0A=
> What ? Unclear... You advertize max zone append as ctrl->zasl =3D min(all=
 ns max=0A=
> zone append sectors). What does BIO_MAX_PAGES has to do with anything ?=
=0A=
That is not true, ctrl->zasl is advertised=0A=
min(min all ns max zone append sectors), bio_max_zasl) to avoid the=0A=
splitting=0A=
of the bio on the target side:-=0A=
=0A=
See nvmet_zns_update_zasl()=0A=
=0A=
+	ns->subsys->id_ctrl_zns.zasl =3D min_t(u8, min_zasl, bio_max_zasl);=0A=
=0A=
Without considering the bio_max_pages we may have to set the ctrl->zasl=0A=
value=0A=
thatis > bio_max_pages_zasl, then we'll get a request that is greater=0A=
than what=0A=
one bio can handle, that will lead to splitting the bios, which we want to=
=0A=
avoid as per the comment in the V1.=0A=
=0A=
Can you please explain what is wrong with this approach which regulates the=
=0A=
zasl with all the possible namespaces zasl and bio_zasl?=0A=
=0A=
May be there is better way?=0A=
>> +	if (!req->sg_cnt)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	if (WARN_ON(req->sg_cnt > BIO_MAX_PAGES)) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	bvec =3D kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);=0A=
>> +	if (!bvec) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {=0A=
>> +		nvmet_file_init_bvec(bvec, sg);=0A=
>> +		mapped_data_len +=3D bvec[mapped_cnt].bv_len;=0A=
>> +		sg_cnt--;=0A=
>> +		if (mapped_cnt =3D=3D bv_cnt)=0A=
>> +			brhigh frequency I/O operationeak;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (WARN_ON(sg_cnt)) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);=0A=
>> +=0A=
>> +	bio =3D bio_alloc(GFP_KERNEL, bv_cnt);=0A=
>> +	bio_set_dev(bio, nvmet_bdev(req));=0A=
>> +	bio->bi_iter.bi_sector =3D sect;=0A=
>> +	bio->bi_opf =3D op;=0A=
> The op variable is used only here. It is not necessary.=0A=
Yes.=0A=
>> +=0A=
>> +	ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
> I still do not see why bio_iov_iter_get_pages() does not work here. Would=
 you=0A=
> care to explain please ?=0A=
>=0A=
The same reason pointed out by the Johannes. Instead of calling wrapper,=0A=
call the underlaying core API, since we don't care about the rest of the=0A=
generic code. This also avoids an extra function callfor zone-append=0A=
fast path.=0A=
>> +	if (unlikely(ret)) {=0A=
>> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
>> +		bio_io_error(bio);=0A=
>> +		goto bvec_free;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(bio);=0A=
>> +	status =3D ret < 0 ? NVME_SC_INTERNAL : status;=0A=
>> +	bio_put(bio);=0A=
>> +=0A=
>> +	sect +=3D (mapped_data_len >> 9);=0A=
>> +	req->cqe->result.u64 =3D le64_to_cpu(nvmet_sect_to_lba(req->ns, sect))=
;=0A=
>> +=0A=
>> +bvec_free:=0A=
>> +	kfree(bvec);=0A=
>> +=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>> +{=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	return false;=0A=
>> +}=0A=
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
>> +{=0A=
>> +}=0A=
>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>=0A=
>=0A=
=0A=
