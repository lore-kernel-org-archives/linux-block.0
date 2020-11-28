Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB38C3E8C5
	for <linux-block@archiver.kernel.org>; Sat, 28 Nov 2020 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC32722245
	for <linux-block@archiver.kernel.org>; Sat, 28 Nov 2020 00:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qmU7SBkO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T8n7nBLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgK1AK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Nov 2020 19:10:26 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52216 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbgK1AKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Nov 2020 19:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606522205; x=1638058205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Nau03cvAANJ1GQsQQSr5RhqfErukP4WCAhPiDMwxnBU=;
  b=qmU7SBkO+DKXXZ17CzFehet1NMBr6wt0COoLcZaPO0mGPqowRtoLVx/X
   9bEaPzyNo5D2DrWEQetukkz+7IJIMti+FCY5AoyZpKi/gos+nbTWV+OIn
   S2U9Jg77Yg+3piN5tGhhEyGxB2Izt2vuDIyAlwtXL35a+45Wepkor8tpz
   U4QgZbBD8GBBQODon6B9QOnPatM4KVoOmHHsDezlNQFJ3AiKRf+UGENlG
   /6vZE+fnEovIMXRrhVZghZO/gj7sZGmVlS6a2YlXuD8isC6MZhBmod7Mo
   5JARjC7aCSt3O6IqXmXkP2Bjvi3ms3zqQ8E8Fwwc9baXgzTsfefHtO13u
   A==;
IronPort-SDR: DFxbxDXG3MGTx0pjiwIdWb/B8z5axrrfs3qosIbwwfSRvksfvpgqMyqSBtSWbL2PxddkhJCgKO
 mstsAsI+2OEgeNnR/+xtendwMARro1NzbKyWk5hYk07S0qQl/xq1QvFOGk0TxUDMZ2iWVRPQCB
 hWQ3KEsCN7Jdb4rhV4SJFNmtg+6XNmXlddQcRhdJBB/WaguLujX7eiIpTq9185cVWpk8cMkLw+
 mDBRJ9S+E0Szm6rWp5/QNcovhpjzoSlNc4Umg8rBpjZZSUAPwxYJx0ZC3pVVEXYfMyFQzLHWil
 NE0=
X-IronPort-AV: E=Sophos;i="5.78,376,1599494400"; 
   d="scan'208";a="153616516"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Nov 2020 08:09:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrUcYCwx2CIM8rNMhYi6+SDS/DZUELyFgDdZ/Px5I61xwtU045woEOx93N8BsU1XO+F26vQzQOwvN392BV4AGrDGCR1DwnYCtDyF2QSvUN9ACMOfj/DE4pB2NuTrAAt+7LBnQe8kYQZ5Mv+k5RA8EzLZlvNI/Drvxi+4KpJ7bXa3XqVrgA8e9wpXAYAVJnRsLfACO8ctd0hvj16etTmluUPG/6ZraXuTKO63vTa67oTzAjEW2uVjMVw3+GFNJppmem5mmvsBchWb3TAEGNyIi7aiUv0tcH3CjAIq4qp0ew1+tM+z+0IkTo2OS9jO6XrslCcNoaGj3i+IAO9edfBIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39hFq/zLVu8MKQ2p1DrxbSIUN9mA/Ndcq04dVo5ZY7Y=;
 b=FIKZigQxNv5jiJJLwBZ+DmpX1aeP8lh0jgTcTGBgDxOiBAbHoakVpa1GigYdxt3+WxjfeAD+Xt4WvnLa0cTh/5q2qqCuSZb7TiMIXju7yE08a3ytYiR4/VH+C2JvkqLR4Mb0g/a7AwUtawzdnVt+fu6RMPA4Iw38vFxInQ2scRcoyKaojKtjD1qEuiPi49VY9W687w4gEsvb64FYQydsNCrEnptE6fxG2+vszkVvmWNVFrk3qZ/W7FcQ5hPQmyWCsP8KtviYzWhECy2aaf1rOc3H+JEEJwMi3dse8bF1wXRVSvoRSU3W3EimSBPBCsqllNHzf4AsjtdlGQSal89wpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39hFq/zLVu8MKQ2p1DrxbSIUN9mA/Ndcq04dVo5ZY7Y=;
 b=T8n7nBLXrksfP1g1e/JSDlN6zgIsQZ0cq9SPV4PTbopOxPS93xEaksL+b8AnRBtj9d6ZuIuBRgCWd1HghA6Z/Kh5FfWmF6y2/NEWD7KFkEXOmS6pbZ96VR1AOhJkI9BjY0rpLlFwXxIjjP2jKFk/oKMlQxV5piO4ZsXXix1yO7Y=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Sat, 28 Nov
 2020 00:09:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.032; Sat, 28 Nov 2020
 00:09:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw52duufaENKY4kqG/18TG9QkOg==
Date:   Sat, 28 Nov 2020 00:09:57 +0000
Message-ID: <BYAPR04MB49652ACED79DDFA79DF00C7E86F70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522298714A02E18D356081CE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dbe8f5f-8cf2-4d2f-450d-08d89331f0b8
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB6024AA82F3669F8BA7EF575B86F70@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVRFjBpQTe0qidtbsJWXMarYTl0z77rIr1VJv4R/vp6g2FomjXDz/9pE2LvCb+lRcyl3Th4TMKte12kPW/StSRpmQdy0ZDugVZZzlwvfJp3av5smlXS3XwTNWyymzRxygoVY6D/xt175UogIe8AfUqFsDTjpJqB5gpbtRSSeSaCxs/IyuoOYRlpzafVKMsb26+CO2wYh3Od6D7JvUIzj2QF/fSEbRKdG0t4hijDrXTfDktNZtvEhcD1cYwSzOKnmcp7bfA5tMSFoF/ImzcGtJdZN650wjD0BDw9koLkjqXSaSM2NabNsBXRoH4UxoMNCyeka7De2th4JKjWgE5i5pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(5660300002)(52536014)(7696005)(9686003)(8936002)(4326008)(30864003)(55016002)(86362001)(6506007)(53546011)(316002)(110136005)(478600001)(83380400001)(26005)(33656002)(71200400001)(2906002)(66946007)(8676002)(66556008)(66446008)(186003)(64756008)(76116006)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vBrG3oLQgpwAvSo3DGFw42qMQAnPhVLJJS+4xiyCD4JlreJrInWj903alSxb?=
 =?us-ascii?Q?CeOTOhbnw858zH1vHpqYBbGowHdgjlLXIj2VK/Vc3htvUqtlWDxzQI6pFBYy?=
 =?us-ascii?Q?cc3P0RGf8C2qKhvJE3i0i47maI2fPrE/AArJr7HBDky6F48OOySuNqiUQAGh?=
 =?us-ascii?Q?kpAudZquc0Hbe6SboYMLLGsUW4d0sG2tgv4tJs074e4AQAywXeG75PebA/4w?=
 =?us-ascii?Q?xG+AJvolQuiUfdBXr5n1sCxMbl/qghrHAhK+xP+kxTRgdleP2zt1s+tjSDv4?=
 =?us-ascii?Q?dUwudYXq+sF2yxFDwxuAZ7yRs3mkUTVJ+o6LGjiKFIst6qDTIA2Yhhj6bsZ4?=
 =?us-ascii?Q?2ApnRPZRR7YFzI+wEwcdLWIub15uwnz+fT9vIZj1ybqAmTqc2hCb2HBuk4aQ?=
 =?us-ascii?Q?Rgtgs2nXEJ7+MZbAgCoZUR4wwZRM7G9RjQt+ehqWhsbUOYcTeADCblTR9Hm8?=
 =?us-ascii?Q?5lhrV/uGNAZBYWB1I3NjyAH627NTou7TPXGAOPPB4jrTy+3bJMeEwdBYx26y?=
 =?us-ascii?Q?B5B7nnv8bB7++ICzviQ4669J++Ties4vZVPAyLdQ1EpVjV3UCF9F64RBUjvo?=
 =?us-ascii?Q?O0W7Oz2L07ZWOKfDYvKJkmYLJdsaqB8meVivhJlaoApnYjiO6FOqdAl/V3Bp?=
 =?us-ascii?Q?QatxDw5VriD0arOxA6XQULOFgiZfhd+Jjdhnld72LXO2jfxLrGcvwBBU0Lc9?=
 =?us-ascii?Q?AbI4PnjGWvVQY3hPSxEUlwXf8aLUs91hPOA4lXQ0NDGQjEW7tx/koq95LGxT?=
 =?us-ascii?Q?YmTdNVbcvpW/+cH5q24IaJB/SjAZkjYv66K4vXScINkDXI4qSeSh/GDexgZ5?=
 =?us-ascii?Q?gU/uLFjbJg03Nu35dt3F+CgoCcnZu/CkqqcVAzskTK5ERc+9KjEuFBayZqND?=
 =?us-ascii?Q?qQkuWAVCesHIvhuv9/vgqNAgh1NWHeFejOdD31uXbwPkk4tTrfX22OL0nddq?=
 =?us-ascii?Q?psOXV0DRhMahYpIoKgoeifbLUYn/bVn/JPaxA4uXt+dHrr1fL01+oyA1Fkzi?=
 =?us-ascii?Q?gyQO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbe8f5f-8cf2-4d2f-450d-08d89331f0b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2020 00:09:57.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UaYG7F5j0OTr2eplhyvp9iR3Y8s3y3LLfIPkJ00Bes25VJE4ojDszC+5/Weq/dnPMu/kswsfJKZ2OLwibzIzn+OqA1C15HJ/5Xf+qjTAfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/20 00:36, Damien Le Moal wrote:=0A=
> On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,=0A=
>> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS=
=0A=
>> support for bdev.=0A=
>>=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> ---=0A=
>>  drivers/nvme/target/Makefile      |   2 +=0A=
>>  drivers/nvme/target/admin-cmd.c   |   4 +-=0A=
>>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>>  drivers/nvme/target/nvmet.h       |  18 ++=0A=
>>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++=
=0A=
>>  5 files changed, 413 insertions(+), 3 deletions(-)=0A=
>>  create mode 100644 drivers/nvme/target/zns.c=0A=
>>=0A=
>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
>> index ebf91fc4c72e..bc147ff2df5d 100644=0A=
>> --- a/drivers/nvme/target/Makefile=0A=
>> +++ b/drivers/nvme/target/Makefile=0A=
>> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>> +=0A=
>>  nvme-loop-y	+=3D loop.o=0A=
>>  nvmet-rdma-y	+=3D rdma.o=0A=
>>  nvmet-fc-y	+=3D fc.o=0A=
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
>>  	return ret;=0A=
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
>> index 592763732065..0542ba672a31 100644=0A=
>> --- a/drivers/nvme/target/nvmet.h=0A=
>> +++ b/drivers/nvme/target/nvmet.h=0A=
>> @@ -81,6 +81,9 @@ struct nvmet_ns {=0A=
>>  	struct pci_dev		*p2p_dev;=0A=
>>  	int			pi_type;=0A=
>>  	int			metadata_size;=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> +	struct nvme_id_ns_zns	id_zns;=0A=
>> +#endif=0A=
>>  };=0A=
>>  =0A=
>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)=0A=
>> @@ -251,6 +254,10 @@ struct nvmet_subsys {=0A=
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
>> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns =
*ns)=0A=
>>  	return ns->pi_type && ns->metadata_size =3D=3D sizeof(struct t10_pi_tu=
ple);=0A=
>>  }=0A=
>>  =0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);=0A=
>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);=0A=
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
>> index 000000000000..8ea6641a55e3=0A=
>> --- /dev/null=0A=
>> +++ b/drivers/nvme/target/zns.c=0A=
>> @@ -0,0 +1,390 @@=0A=
>> +// SPDX-License-Identifier: GPL-2.0=0A=
>> +/*=0A=
>> + * NVMe ZNS-ZBD command implementation.=0A=
>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
>> + */=0A=
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
>> +#include <linux/uio.h>=0A=
>> +#include <linux/nvme.h>=0A=
>> +#include <linux/blkdev.h>=0A=
>> +#include <linux/module.h>=0A=
>> +#include "nvmet.h"=0A=
>> +=0A=
>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> This file is compiled only if CONFIG_BLK_DEV_ZONED is defined, so what is=
 the=0A=
> point of this ? The stubs for the !CONFIG_BLK_DEV_ZONED case should go in=
to the=0A=
> header file, no ?=0A=
=0A=
Actually the conditional compilation of zns.c with CONFIG_BLK_DEV_ZONED=0A=
=0A=
needs to be removed in the Makefile. I'm against putting these empty=0A=
stubs in the=0A=
=0A=
makefile when CONFIG_BLK_DEV_ZONED is not true, as there are several files=
=0A=
=0A=
transport, discovery, file/passthru backend etc in the nvme/target/*.c=0A=
which will add=0A=
=0A=
empty stubs which has nothing to do with zoned bdev backend.=0A=
=0A=
i.e. for Makefile it should be :-=0A=
=0A=
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=0A=
index ebf91fc4c72e..c67276a25363 100644=0A=
--- a/drivers/nvme/target/Makefile=0A=
+++ b/drivers/nvme/target/Makefile=0A=
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)      +=3D nvme-fcloop.o=
=0A=
 obj-$(CONFIG_NVME_TARGET_TCP)          +=3D nvmet-tcp.o=0A=
 =0A=
 nvmet-y                +=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=
=0A=
-                       discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
+                       zns,o discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)   +=3D passthru.o=0A=
 nvme-loop-y    +=3D loop.o=0A=
 nvmet-rdma-y   +=3D rdma.o=0A=
=0A=
>> +=0A=
>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	u16 status =3D 0;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto out;=0A=
> Why not return status directly here ? Same for the other cases below.=0A=
I prefer centralize returns with goto, which follows the similar code.=0A=
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
>> +static struct block_device *nvmet_bdev(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	return req->ns->bdev;=0A=
>> +}=0A=
>> +=0A=
>> +static u64 nvmet_zones_to_descsize(unsigned int nr_zones)=0A=
>> +{=0A=
>> +	return sizeof(struct nvme_zone_report) +=0A=
>> +		(sizeof(struct nvme_zone_descriptor) * nr_zones);=0A=
>> +}=0A=
> These could be declared as inline.=0A=
>=0A=
Okay.=0A=
>> +=0A=
>> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)=
=0A=
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
>> + *  ZNS related command implementation and helprs.=0A=
> s/helprs/helpers=0A=
Okay.=0A=
>=0A=
>> + */=0A=
>> +=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>> +{=0A=
>> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>> +=0A=
>> +	if (bdev_is_zoned(nvmet_bdev(req))) {=0A=
>> +		return nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
>> +						 NVME_NIDT_CSI_LEN,=0A=
>> +						 &nvme_cis_zns, off);=0A=
>> +	}=0A=
> No need for the curly brackets.=0A=
Okay.=0A=
>> +=0A=
>> +	return NVME_SC_SUCCESS;=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
>> +{=0A=
>> +	log->iocs[nvme_cmd_zone_append]		=3D cpu_to_le32(1 << 0);=0A=
>> +	log->iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
>> +	log->iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
>> +}=0A=
>> +=0A=
>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
>> +{=0A=
>> +	if (ns->bdev->bd_disk->queue->conv_zones_bitmap) {=0A=
>> +		pr_err("block device with conventional zones not supported.");=0A=
> pr_err("block devices with conventional zones are not supported.");=0A=
>=0A=
> With SMR drives, the last zone of the disk can be smaller than the other =
zones.=0A=
> That needs to be checked too as that is not allowed by ZNS. Drives with a=
 last=0A=
> smaller runt zone cannot be allowed.=0A=
Okay.=0A=
>> +		return false;=0A=
>> +	}=0A=
>> +	/*=0A=
>> +	 * SMR drives will results in error if writes are not aligned to the=
=0A=
>> +	 * physical block size just override.=0A=
>> +	 */=0A=
> 	/*=0A=
> 	 * For ZBC and ZAC devices, writes into sequential zones must be aligned=
=0A=
> 	 * to the device physical block size. So use this value as the logical=
=0A=
> 	 * block size to avoid errors.=0A=
> 	 */=0A=
Okay.=0A=
>> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev))=
;=0A=
>> +	return true;=0A=
>> +}=0A=
>> +=0A=
>> +static int nvmet_bdev_report_zone_cb(struct blk_zone *zone, unsigned in=
t idx,=0A=
>> +				     void *data)=0A=
>> +{=0A=
>> +	struct blk_zone *zones =3D data;=0A=
>> +=0A=
>> +	memcpy(&zones[idx], zone, sizeof(struct blk_zone));=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static void nvmet_get_zone_desc(struct nvmet_ns *ns, struct blk_zone *z=
,=0A=
>> +				struct nvme_zone_descriptor *rz)=0A=
>> +{=0A=
>> +	rz->zcap =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->capacity));=0A=
>> +	rz->zslba =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->start));=0A=
>> +	rz->wp =3D cpu_to_le64(nvmet_sect_to_lba(ns, z->wp));=0A=
>> +	rz->za =3D z->reset ? 1 << 2 : 0;=0A=
>> +	rz->zt =3D z->type;=0A=
>> +	rz->zs =3D z->cond << 4;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * ZNS related Admin and I/O command handlers.=0A=
>> + */=0A=
>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	struct nvme_id_ctrl_zns *id;=0A=
>> +	u16 status =3D 0;=0A=
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
> But the target drive may have different values for max zone append sector=
s and=0A=
> max_hw_sectors/max_sectors. So I think this needs finer handling.=0A=
I think we can getaway with the=0A=
=0A=
min(mdts, min(max_zone_append_sectors/max_hw_sectors), let me see.=0A=
=0A=
>> +	 */=0A=
>> +	id->zasl =3D 0;=0A=
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
> That will result in nvmet_copy_to_sgl() being executed. Is that OK ?=0A=
> Shouldn't you do only the kfree(id_zns) and complete with an error here ?=
=0A=
Call to nvmet_copy_to_sgl() zeroout the values if any when we return the=0A=
=0A=
buffer in case of error. I don't see any problem with zeroing out buffer in=
=0A=
=0A=
case of error. Can you please explain why we shouldn't do that ?=0A=
=0A=
>> +	}=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {=0A=
>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>> +		goto done;=0A=
> Same comment.=0A=
See above reply.=0A=
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
>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	struct request_queue *q =3D nvmet_bdev(req)->bd_disk->queue;=0A=
>> +	struct nvme_zone_mgmt_recv_cmd *zmr =3D &req->cmd->zmr;=0A=
>> +	unsigned int nz =3D blk_queue_nr_zones(q);=0A=
>> +	u64 bufsize =3D (zmr->numd << 2) + 1;=0A=
>> +	struct nvme_zone_report *rz;=0A=
>> +	struct blk_zone *zones;=0A=
>> +	int reported_zones;=0A=
>> +	sector_t sect;=0A=
>> +	u64 desc_size;=0A=
>> +	u16 status;=0A=
>> +	int i;=0A=
>> +=0A=
>> +	desc_size =3D nvmet_zones_to_descsize(blk_queue_nr_zones(q));=0A=
>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>> +	if (status)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	zones =3D kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),=0A=
>> +			      sizeof(struct blk_zone), GFP_KERNEL);=0A=
> This is not super nice: a large disk will have an enormous number of zone=
s=0A=
> (75000+ for largest SMR HDD today). But you actually do not need more zon=
es=0A=
> descs than what fits in req buffer.=0A=
Call to nvmet_copy_to_sgl() nicely fail and return error.=0A=
>> +	if (!zones) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
>> +	if (!rz) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out_free_zones;=0A=
>> +	}=0A=
>> +=0A=
>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));=
=0A=
>> +=0A=
>> +	for (nz =3D blk_queue_nr_zones(q); desc_size >=3D bufsize; nz--)=0A=
>> +		desc_size =3D nvmet_zones_to_descsize(nz);=0A=
>> +=0A=
>> +	reported_zones =3D blkdev_report_zones(nvmet_bdev(req), sect, nz,=0A=
>> +					     nvmet_bdev_report_zone_cb,=0A=
>> +					     zones);=0A=
>> +	if (reported_zones < 0) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out_free_report_zones;=0A=
>> +	}=0A=
>> +=0A=
>> +	rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
>> +	for (i =3D 0; i < reported_zones; i++)=0A=
>> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);=0A=
> This can be done directly in the report zones cb. That will avoid looping=
 twice=0A=
> over the reported zones.=0A=
Okay, I'll try and remove this loop.=0A=
>> +=0A=
>> +	status =3D nvmet_copy_to_sgl(req, 0, rz, bufsize);=0A=
>> +=0A=
>> +out_free_report_zones:=0A=
>> +	kvfree(rz);=0A=
>> +out_free_zones:=0A=
>> +	kvfree(zones);=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	sector_t nr_sect =3D bdev_zone_sectors(nvmet_bdev(req));=0A=
>> +	struct nvme_zone_mgmt_send_cmd *c =3D &req->cmd->zms;=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	enum req_opf op;=0A=
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
>> +		break;=0A=
> You needa goto here or blkdev_zone_mgmt() will be called.=0A=
>=0A=
True.=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERNE=
L);=0A=
>> +	if (ret)=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>> +{=0A=
>> +	unsigned long bv_cnt =3D min(req->sg_cnt, BIO_MAX_PAGES);=0A=
>> +	int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>> +	u64 slba =3D le64_to_cpu(req->cmd->rw.slba);=0A=
>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, slba);=0A=
>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>> +	int sg_cnt =3D req->sg_cnt;=0A=
>> +	struct scatterlist *sg;=0A=
>> +	size_t mapped_data_len;=0A=
>> +	struct iov_iter from;=0A=
>> +	struct bio_vec *bvec;=0A=
>> +	size_t mapped_cnt;=0A=
>> +	size_t io_len =3D 0;=0A=
>> +	struct bio *bio;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>> +		return;=0A=
> No request completion ?=0A=
See nvmet_check_transfer_len().=0A=
>> +=0A=
>> +	if (!req->sg_cnt) {=0A=
>> +		nvmet_req_complete(req, 0);=0A=
>> +		return;=0A=
>> +	}=0A=
>> +=0A=
>> +	bvec =3D kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);=0A=
>> +	if (!bvec) {=0A=
>> +		status =3D NVME_SC_INTERNAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	while (sg_cnt) {=0A=
>> +		mapped_data_len =3D 0;=0A=
>> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {=0A=
>> +			nvmet_file_init_bvec(bvec, sg);=0A=
>> +			mapped_data_len +=3D bvec[mapped_cnt].bv_len;=0A=
>> +			sg_cnt--;=0A=
>> +			if (mapped_cnt =3D=3D bv_cnt)=0A=
>> +				break;=0A=
>> +		}=0A=
>> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);=0A=
>> +=0A=
>> +		bio =3D bio_alloc(GFP_KERNEL, bv_cnt);=0A=
>> +		bio_set_dev(bio, nvmet_bdev(req));=0A=
>> +		bio->bi_iter.bi_sector =3D sect;=0A=
>> +		bio->bi_opf =3D op;=0A=
>> +=0A=
>> +		ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
>> +		if (unlikely(ret)) {=0A=
>> +			status =3D NVME_SC_INTERNAL;=0A=
>> +			bio_io_error(bio);=0A=
>> +			kfree(bvec);=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +=0A=
>> +		ret =3D submit_bio_wait(bio);=0A=
>> +		bio_put(bio);=0A=
>> +		if (ret < 0) {=0A=
>> +			status =3D NVME_SC_INTERNAL;=0A=
>> +			break;=0A=
>> +		}=0A=
>> +=0A=
>> +		io_len +=3D mapped_data_len;=0A=
>> +	}=0A=
> This loop is equivalent to splitting a zone append. That must not be done=
 as=0A=
> that can lead to totally unpredictable ordering of the chunks. What if an=
other=0A=
> thread is doing zone append to the same zone at the same time ?=0A=
>=0A=
We can add something like per-zone bit locking here to prevent that,=0A=
multiple=0A=
=0A=
threads. With zasl value derived from max_zone_append_sector (as=0A=
mentioned in=0A=
=0A=
my reply ideally we shouldn't get the data len more than what we can=0A=
handle if I'm=0A=
=0A=
not missing something.=0A=
=0A=
>> +=0A=
>> +	sect +=3D (io_len >> 9);=0A=
>> +	req->cqe->result.u64 =3D le64_to_cpu(nvmet_sect_to_lba(req->ns, sect))=
;=0A=
>> +	kfree(bvec);=0A=
>> +=0A=
>> +out:=0A=
>> +	nvmet_req_complete(req, status);=0A=
>> +}=0A=
>> +=0A=
>> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
>> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=
=0A=
>> +{=0A=
>> +}=0A=
>> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>> +{=0A=
>> +}=0A=
>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>> +{=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
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
> These should go in the header file. And put the brackets on the same line=
.=0A=
>=0A=
As I explained earlier this bloats the header file with empty stubs and=0A=
=0A=
adds functions in the traget transport code from nvmet.h which has=0A=
=0A=
nothing to do with the backend. Regarding the {} style I don't see braces=
=0A=
=0A=
on the same line for the empty stubs so keeping it consistent what is in=0A=
=0A=
the repo.=0A=
=0A=
>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>=0A=
