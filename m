Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDBC64E7B
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63A92076C
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 00:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="HaEGediM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lgcy4dtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgK3ARS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 19:17:18 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20197 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgK3ARR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 19:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606696345; x=1638232345;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PFDawk4NKl3yvCpxFyvWCCLVXgjqT58XZibRMdLYHcw=;
  b=HaEGediMz0ruV4frv3Cc3nGzEpD0cT/mxdVmtV9fNeMyz/d8YaO9dQ1j
   Rb12+UMPLDeUuq61mSEmLod9cm/xL4SWmpd99qEO748BPhnfaMho9lAmG
   V6yfMetOzJ0RXg7gQ6K8k0JsTixSbu51kgpWJWLbn9q8Qp/oSXItgyMxy
   bwBafKi/275LShaX7ewnBF/DPtX1jjmApBdadElHC8mtWq2FeXIrw1xJh
   g/6Zao+Czg96lQUWJvLL1coBJtL5R21dN+LHRqEBazVSkTf7rSHhgaLVf
   Ps7fTDhFlOjWFpwV6p03DkuKlveV/0oSjyUnLim546sgHdPiopsFA4EVa
   Q==;
IronPort-SDR: 61DT+abtx2DH8z+ASwkgBuzraH0TJG5mtnAZJCwdUdqG4zEmgU/CKuegFasd2mMAgmCYz9n6tf
 JK0pM3dC1iz9kPLnrGodsIv1OXrHBheiXPIsJ/ssqwRs5xhVDJ8fOjekNJ2iKNyN8pPyz5be5X
 bQjgSUtCwy071am+t/FMQH8z+3B2wwTtKf6fFcXGF2Cu9ZKu/DGSy/glcaUpBkf3dKfipsxT3O
 DC8fcmRLfgS35AXF1PjBjCUnlFMXxIzOeCyBlHXXJ7UuoXOaTw0NysalQxX32kpb5CPC5+H0lF
 O/4=
X-IronPort-AV: E=Sophos;i="5.78,379,1599494400"; 
   d="scan'208";a="257439293"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2020 08:30:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBzcSo6WVo2ydnUxxUKO3h32g32kP3MpPX39EjtUNO5NgXiDPVTMTQmRRAYOVh1z1gH1L25/zD8tFIJvTwY7273c8QqstLhZ1Z54IY4ESXHWg0vNuUKm+1+d9aZdjPliL70PNNbubH6TW5gr0x2hRDH//3BoMS7gg1SD0vqb/8aVE0gk1VcallUun3902vaiYZHNL+SV6a5TesE4e6Rxp9XMwAzbt8Tvbl636aWLNzH7+m1iA+088lErB5BFxdR7DAzzEDWrLZQq+V0HZh4ngMlzrNOBfX/88rdd0ndOVQWJhgkQjct+6fauzprFyAhNMaw5G9bFhzu79oNyXwB2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERmdf8XEpAsuDQY5QCFjCmUdtlqp4hL/wNAXZcHlPY8=;
 b=Jm3E6LOZVhMXH3CRH/7ENQMRw541AouWyjFaEMvBSAidtVTsKLzw/9yINwYQM+nvfHS+X8QHRx6zGBuFwwrc/o4t5W6AClEucEqaHdyazwmW2aFcdr6q2wySdE8x6muYOGpjIhAgRTir/Ju/d9C/y0WXK7kELxA6q+lOQV6lCZ+NQB6tTvYoddxzD6kvxeKkwtv/66gM1iPhUUPbI9zRgKOuXYAj1i6Gu4uHMMq/nf1kYPufA1FwwBvZNTbl1OYd2Sro4XdWOIC+kw2cTneX7TjcIB98YMRt3iJzT/IGdwZOOeFcyrzm/X1cC27633j3AxOtCGTfiuZUzFQSu/+FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERmdf8XEpAsuDQY5QCFjCmUdtlqp4hL/wNAXZcHlPY8=;
 b=lgcy4dtmDVfnnkQt0+531DfGNwqvt5sJqKRusKNHlRG7V8Jvlj7lqmTtvcg3dW7KPyBLUVWbxZdKeufpIdGU2ptMtmtmfHaaiGowYKJx0ITRdYextfGK2FIU3skXbKFeWQwEgUwira4MR7vEDIemp2jyMghelLzb4bPQgSMU2GI=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6949.namprd04.prod.outlook.com (2603:10b6:610:97::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Mon, 30 Nov
 2020 00:16:07 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Mon, 30 Nov 2020
 00:16:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Topic: [PATCH 2/9] nvmet: add ZNS support for bdev-ns
Thread-Index: AQHWw53W//+mWSEaQk2ZMnl01vomXw==
Date:   Mon, 30 Nov 2020 00:16:07 +0000
Message-ID: <CH2PR04MB652222058A8091A81BF3F4B9E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522298714A02E18D356081CE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49652ACED79DDFA79DF00C7E86F70@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:3811:272:f33b:9d56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b41d13a8-1342-45b6-9f46-08d894c52200
x-ms-traffictypediagnostic: CH2PR04MB6949:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6949E3610DB7FAF93D9EB9A4E7F50@CH2PR04MB6949.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zBMvBQcxoyrxMdYq7LysBl8GJDdzL5jUZBmZJmmNMw/7UdmDZOnGPqZQl21N64J0siHohhmz2CICGDpk+oZfYOjFC/fBZnSaJdTTYOmOYakFndBcGRcMNXAU6YOsEtgrj2EZTnvKuQle7X51w0eWxro6gyGgQQ7EPXRn8Hr2GGAH9+zHxL7meIh9jntTq2NJKIm9hQkif279pG0q/+WpyzY0WOlP1MeU+nS5o6FE8ev7oJ8uAgwSUn7qcXcfdS9JHfzVEr9QPX1ZeRPbiQOMQKeed0c7x6uLKRk+mrkiWSmAZNhIZMTWUBtN4zeO2vgRG44ACmVqGrv2aX6L1wP6Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(33656002)(6506007)(53546011)(54906003)(186003)(4326008)(76116006)(91956017)(110136005)(9686003)(316002)(86362001)(2906002)(30864003)(7696005)(8676002)(8936002)(55016002)(71200400001)(66946007)(478600001)(66476007)(5660300002)(66446008)(66556008)(83380400001)(64756008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jBBLdzFP3sel5qmDBQTzgN6vzWiRCKJN6l+NkwnlXALG+owlns1gi0/1r+S/?=
 =?us-ascii?Q?lDsMa8RIXwuTPKUlBq/B5ZzeSJ1CuosIBXn7THTqnUagPri8vCYrKROcPsdo?=
 =?us-ascii?Q?qIt+IfIIkV456uZhW/VgD1gOT91wuf47SWAzxLJJsABgW29O3w6KRyJlH+0X?=
 =?us-ascii?Q?7lCVksqykVdi7IeKhT2Y9WH7cTZoURAFsUMbETTL+MgLuXiWWPhS62BDtF89?=
 =?us-ascii?Q?V7vD8WIzoD5VP4ef8NEIITTYh3pwTuPAeEWmYhu/fH0f2E6gNe5Z95iLtQT0?=
 =?us-ascii?Q?0BdmYLQDDeANLXXeRWZQpFKyHtvTjX9bHmDsaLyhijMduL4fKOl0u9dpU6vS?=
 =?us-ascii?Q?jEVEHCfcVveV6jnvp9wXuU8BO6fLtdb+68ZR4BQajjwQlb6QUoc4daqIOGpU?=
 =?us-ascii?Q?/vzFndaWXe2iDEb1/cF3mJpPfaimH1Nh12lcvRiM/HnyYhYUA9lgYYRkbtTD?=
 =?us-ascii?Q?vjz1YxeSYQQoS10psAwEXxGt9OJzwbiABsr2QP0iRISA/g6QiQWEJVElys45?=
 =?us-ascii?Q?3k9b+2ke/R3UCDns11s6usCKNRQE/Tdm/RMQqlaBVHBiai/BJoMqs72Orlb7?=
 =?us-ascii?Q?Lo75kqynPyJTZF+X6ondZce986CgGZ7dnAVrc94BGoT5PoslXxAjwOi4UBcf?=
 =?us-ascii?Q?mag5MhKUAkpBfZG+GoQTbCnFOGj+1xpd77H8GDD38Kq5UrH2oHRHFgxd0lgO?=
 =?us-ascii?Q?DzjkH0WOyMZWMGOUsBglZULc951me1PC10MkEclHS5BuMTyrp8ipuBzi79V0?=
 =?us-ascii?Q?cBW2To8RJJYuzqAq+AxiL3ocaUccHCv00RTUky1269w2HAfjDlQuj0kfShLM?=
 =?us-ascii?Q?JtJ5dPhROxvVB6TvZBw/+Ypo6LTHAFQq9JzKlten7eBrAL9C81RTICOo997E?=
 =?us-ascii?Q?hb2Ykz/CePQESoptDRT93MqiibDxToDaBb1LXEgtkL/Oemhqv/x7tLi3QN12?=
 =?us-ascii?Q?+HLt2HyxE31CDsssljCHo2EMaaGZzt+PVBp6tYcbq3vYGyCSj/uieLxPoQti?=
 =?us-ascii?Q?xuPRZPj/OTmZiwAbd3EAAEDHtRG68ulN517fTiKy7UrieMRALG73oYlQeiO/?=
 =?us-ascii?Q?nvnakjxY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d13a8-1342-45b6-9f46-08d894c52200
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 00:16:07.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwkI7qUJPoVrv4X35/p7zv8PsinUKFuivckGJ1fzSSP0mOAJT47dmZXqeQ/0M00nqLdh08p7b+D66iwkPjhgYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6949
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/28 9:09, Chaitanya Kulkarni wrote:=0A=
> On 11/26/20 00:36, Damien Le Moal wrote:=0A=
>> On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
>>> Add zns-bdev-config, id-ctrl, id-ns, zns-cmd-effects, zone-mgmt-send,=
=0A=
>>> zone-mgmt-recv and zone-append handlers for NVMeOF target to enable ZNS=
=0A=
>>> support for bdev.=0A=
>>>=0A=
>>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>>> ---=0A=
>>>  drivers/nvme/target/Makefile      |   2 +=0A=
>>>  drivers/nvme/target/admin-cmd.c   |   4 +-=0A=
>>>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>>>  drivers/nvme/target/nvmet.h       |  18 ++=0A=
>>>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++=
=0A=
>>>  5 files changed, 413 insertions(+), 3 deletions(-)=0A=
>>>  create mode 100644 drivers/nvme/target/zns.c=0A=
>>>=0A=
>>> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefil=
e=0A=
>>> index ebf91fc4c72e..bc147ff2df5d 100644=0A=
>>> --- a/drivers/nvme/target/Makefile=0A=
>>> +++ b/drivers/nvme/target/Makefile=0A=
>>> @@ -12,6 +12,8 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>>>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>>>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>>>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
>>> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>>> +=0A=
>>>  nvme-loop-y	+=3D loop.o=0A=
>>>  nvmet-rdma-y	+=3D rdma.o=0A=
>>>  nvmet-fc-y	+=3D fc.o=0A=
>>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admi=
n-cmd.c=0A=
>>> index dca34489a1dc..509fd8dcca0c 100644=0A=
>>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>>> @@ -579,8 +579,8 @@ static void nvmet_execute_identify_nslist(struct nv=
met_req *req)=0A=
>>>  	nvmet_req_complete(req, status);=0A=
>>>  }=0A=
>>>  =0A=
>>> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8=
 len,=0A=
>>> -				    void *id, off_t *off)=0A=
>>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=
=0A=
>>> +			     void *id, off_t *off)=0A=
>>>  {=0A=
>>>  	struct nvme_ns_id_desc desc =3D {=0A=
>>>  		.nidt =3D type,=0A=
>>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io=
-cmd-file.c=0A=
>>> index 0abbefd9925e..2bd10960fa50 100644=0A=
>>> --- a/drivers/nvme/target/io-cmd-file.c=0A=
>>> +++ b/drivers/nvme/target/io-cmd-file.c=0A=
>>> @@ -89,7 +89,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)=0A=
>>>  	return ret;=0A=
>>>  }=0A=
>>>  =0A=
>>> -static void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlis=
t *sg)=0A=
>>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg)=
=0A=
>>>  {=0A=
>>>  	bv->bv_page =3D sg_page(sg);=0A=
>>>  	bv->bv_offset =3D sg->offset;=0A=
>>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=
=0A=
>>> index 592763732065..0542ba672a31 100644=0A=
>>> --- a/drivers/nvme/target/nvmet.h=0A=
>>> +++ b/drivers/nvme/target/nvmet.h=0A=
>>> @@ -81,6 +81,9 @@ struct nvmet_ns {=0A=
>>>  	struct pci_dev		*p2p_dev;=0A=
>>>  	int			pi_type;=0A=
>>>  	int			metadata_size;=0A=
>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>> +	struct nvme_id_ns_zns	id_zns;=0A=
>>> +#endif=0A=
>>>  };=0A=
>>>  =0A=
>>>  static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)=
=0A=
>>> @@ -251,6 +254,10 @@ struct nvmet_subsys {=0A=
>>>  	unsigned int		admin_timeout;=0A=
>>>  	unsigned int		io_timeout;=0A=
>>>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
>>> +=0A=
>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>>> +	struct nvme_id_ctrl_zns	id_ctrl_zns;=0A=
>>> +#endif=0A=
>>>  };=0A=
>>>  =0A=
>>>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
>>> @@ -603,4 +610,15 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns=
 *ns)=0A=
>>>  	return ns->pi_type && ns->metadata_size =3D=3D sizeof(struct t10_pi_t=
uple);=0A=
>>>  }=0A=
>>>  =0A=
>>> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off);=0A=
>>> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns);=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log);=0A=
>>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=
=0A=
>>> +			     void *id, off_t *off);=0A=
>>> +void nvmet_file_init_bvec(struct bio_vec *bv, struct scatterlist *sg);=
=0A=
>>>  #endif /* _NVMET_H */=0A=
>>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
>>> new file mode 100644=0A=
>>> index 000000000000..8ea6641a55e3=0A=
>>> --- /dev/null=0A=
>>> +++ b/drivers/nvme/target/zns.c=0A=
>>> @@ -0,0 +1,390 @@=0A=
>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>> +/*=0A=
>>> + * NVMe ZNS-ZBD command implementation.=0A=
>>> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
>>> + */=0A=
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
>>> +#include <linux/uio.h>=0A=
>>> +#include <linux/nvme.h>=0A=
>>> +#include <linux/blkdev.h>=0A=
>>> +#include <linux/module.h>=0A=
>>> +#include "nvmet.h"=0A=
>>> +=0A=
>>> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
>> This file is compiled only if CONFIG_BLK_DEV_ZONED is defined, so what i=
s the=0A=
>> point of this ? The stubs for the !CONFIG_BLK_DEV_ZONED case should go i=
nto the=0A=
>> header file, no ?=0A=
> =0A=
> Actually the conditional compilation of zns.c with CONFIG_BLK_DEV_ZONED=
=0A=
> =0A=
> needs to be removed in the Makefile. I'm against putting these empty=0A=
> stubs in the=0A=
> =0A=
> makefile when CONFIG_BLK_DEV_ZONED is not true, as there are several file=
s=0A=
> =0A=
> transport, discovery, file/passthru backend etc in the nvme/target/*.c=0A=
> which will add=0A=
> =0A=
> empty stubs which has nothing to do with zoned bdev backend.=0A=
=0A=
Each file will not need to add empty stubs if these stubs are in a common=
=0A=
header. And empty stubs are compiled away so I do not see the problem. Havi=
ng=0A=
such empty stubs in a header file under an #ifdef is I think a fairly stand=
ard=0A=
coding style in the kernel. The block layer zone code and scsi SMR code is =
coded=0A=
like that.=0A=
=0A=
> =0A=
> i.e. for Makefile it should be :-=0A=
> =0A=
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
> index ebf91fc4c72e..c67276a25363 100644=0A=
> --- a/drivers/nvme/target/Makefile=0A=
> +++ b/drivers/nvme/target/Makefile=0A=
> @@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)      +=3D nvme-fcloop.=
o=0A=
>  obj-$(CONFIG_NVME_TARGET_TCP)          +=3D nvmet-tcp.o=0A=
>  =0A=
>  nvmet-y                +=3D core.o configfs.o admin-cmd.o fabrics-cmd.o =
\=0A=
> -                       discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
> +                       zns,o discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)   +=3D passthru.o=0A=
>  nvme-loop-y    +=3D loop.o=0A=
>  nvmet-rdma-y   +=3D rdma.o=0A=
=0A=
The NS scan and test for support of ZNS could go in discovery.c, and compil=
ed=0A=
unconditionally exactly like the host nvme driver does. Everything else (ZN=
S=0A=
commands execution) can go into zns.c and that file compiled conditionally,=
 with=0A=
empty stubs in zns.h or any other appropriate header file. I think that mak=
e=0A=
things clean and easy to understand, and avoid the big #ifdef in the C code=
.=0A=
Just my opinion here. You are the maintainer, so your call...=0A=
=0A=
>>> +=0A=
>>> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	u16 status =3D 0;=0A=
>>> +=0A=
>>> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
>>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>> Why not return status directly here ? Same for the other cases below.=0A=
> I prefer centralize returns with goto, which follows the similar code.=0A=
=0A=
Sure, but for such a simple function, this looks rather strange and in my=
=0A=
opinion uselessly complicates the code.=0A=
=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {=0A=
>>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {=0A=
>>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)=0A=
>>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>>> +out:=0A=
>>> +	return status;=0A=
>>> +}=0A=
=0A=
[...]=0A=
>>> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	struct nvme_id_ns_zns *id_zns;=0A=
>>> +	u16 status =3D 0;=0A=
>>> +	u64 zsze;=0A=
>>> +=0A=
>>> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {=0A=
>>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);=0A=
>>> +	if (!id_zns) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.ns=
id);=0A=
>>> +	if (!req->ns) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto done;=0A=
>> That will result in nvmet_copy_to_sgl() being executed. Is that OK ?=0A=
>> Shouldn't you do only the kfree(id_zns) and complete with an error here =
?=0A=
> Call to nvmet_copy_to_sgl() zeroout the values if any when we return the=
=0A=
> =0A=
> buffer in case of error. I don't see any problem with zeroing out buffer =
in=0A=
> =0A=
> case of error. Can you please explain why we shouldn't do that ?=0A=
=0A=
I cannot explain anything. I was merely pointing out what the code was doin=
g and=0A=
if that was intentional. If there are no problems, then fine.=0A=
=0A=
> =0A=
>>> +	}=0A=
>>> +=0A=
>>> +	if (!bdev_is_zoned(nvmet_bdev(req))) {=0A=
>>> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
>>> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
>>> +		goto done;=0A=
>> Same comment.=0A=
> See above reply.=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	nvmet_ns_revalidate(req->ns);=0A=
>>> +	zsze =3D (bdev_zone_sectors(nvmet_bdev(req)) << 9) >>=0A=
>>> +					req->ns->blksize_shift;=0A=
>>> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
>>> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(nvmet_bdev(req)));=0A=
>>> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(nvmet_bdev(req)));=
=0A=
>>> +=0A=
>>> +done:=0A=
>>> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
>>> +	kfree(id_zns);=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	struct request_queue *q =3D nvmet_bdev(req)->bd_disk->queue;=0A=
>>> +	struct nvme_zone_mgmt_recv_cmd *zmr =3D &req->cmd->zmr;=0A=
>>> +	unsigned int nz =3D blk_queue_nr_zones(q);=0A=
>>> +	u64 bufsize =3D (zmr->numd << 2) + 1;=0A=
>>> +	struct nvme_zone_report *rz;=0A=
>>> +	struct blk_zone *zones;=0A=
>>> +	int reported_zones;=0A=
>>> +	sector_t sect;=0A=
>>> +	u64 desc_size;=0A=
>>> +	u16 status;=0A=
>>> +	int i;=0A=
>>> +=0A=
>>> +	desc_size =3D nvmet_zones_to_descsize(blk_queue_nr_zones(q));=0A=
>>> +	status =3D nvmet_bdev_zns_checks(req);=0A=
>>> +	if (status)=0A=
>>> +		goto out;=0A=
>>> +=0A=
>>> +	zones =3D kvcalloc(blkdev_nr_zones(nvmet_bdev(req)->bd_disk),=0A=
>>> +			      sizeof(struct blk_zone), GFP_KERNEL);=0A=
>> This is not super nice: a large disk will have an enormous number of zon=
es=0A=
>> (75000+ for largest SMR HDD today). But you actually do not need more zo=
nes=0A=
>> descs than what fits in req buffer.=0A=
> Call to nvmet_copy_to_sgl() nicely fail and return error.=0A=
=0A=
That is not my point. The point is that this code will do an allocation for=
=0A=
75,000 x 64B =3D 4.8MB even if a single zone report is being requested. Tha=
t is=0A=
not acceptable. This needs optimization: allocate only as many zone descrip=
tors=0A=
as is requested.=0A=
=0A=
>>> +	if (!zones) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);=0A=
>>> +	if (!rz) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out_free_zones;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zmr.slba));=
=0A=
>>> +=0A=
>>> +	for (nz =3D blk_queue_nr_zones(q); desc_size >=3D bufsize; nz--)=0A=
>>> +		desc_size =3D nvmet_zones_to_descsize(nz);=0A=
>>> +=0A=
>>> +	reported_zones =3D blkdev_report_zones(nvmet_bdev(req), sect, nz,=0A=
>>> +					     nvmet_bdev_report_zone_cb,=0A=
>>> +					     zones);=0A=
>>> +	if (reported_zones < 0) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out_free_report_zones;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
>>> +	for (i =3D 0; i < reported_zones; i++)=0A=
>>> +		nvmet_get_zone_desc(req->ns, &zones[i], &rz->entries[i]);=0A=
>> This can be done directly in the report zones cb. That will avoid loopin=
g twice=0A=
>> over the reported zones.=0A=
> Okay, I'll try and remove this loop.=0A=
>>> +=0A=
>>> +	status =3D nvmet_copy_to_sgl(req, 0, rz, bufsize);=0A=
>>> +=0A=
>>> +out_free_report_zones:=0A=
>>> +	kvfree(rz);=0A=
>>> +out_free_zones:=0A=
>>> +	kvfree(zones);=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	sector_t nr_sect =3D bdev_zone_sectors(nvmet_bdev(req));=0A=
>>> +	struct nvme_zone_mgmt_send_cmd *c =3D &req->cmd->zms;=0A=
>>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>>> +	enum req_opf op;=0A=
>>> +	sector_t sect;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	sect =3D nvmet_lba_to_sect(req->ns, le64_to_cpu(req->cmd->zms.slba));=
=0A=
>>> +=0A=
>>> +	switch (c->zsa) {=0A=
>>> +	case NVME_ZONE_OPEN:=0A=
>>> +		op =3D REQ_OP_ZONE_OPEN;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_CLOSE:=0A=
>>> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_FINISH:=0A=
>>> +		op =3D REQ_OP_ZONE_FINISH;=0A=
>>> +		break;=0A=
>>> +	case NVME_ZONE_RESET:=0A=
>>> +		if (c->select_all)=0A=
>>> +			nr_sect =3D get_capacity(nvmet_bdev(req)->bd_disk);=0A=
>>> +		op =3D REQ_OP_ZONE_RESET;=0A=
>>> +		break;=0A=
>>> +	default:=0A=
>>> +		status =3D NVME_SC_INVALID_FIELD;=0A=
>>> +		break;=0A=
>> You needa goto here or blkdev_zone_mgmt() will be called.=0A=
>>=0A=
> True.=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	ret =3D blkdev_zone_mgmt(nvmet_bdev(req), op, sect, nr_sect, GFP_KERN=
EL);=0A=
>>> +	if (ret)=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +	unsigned long bv_cnt =3D min(req->sg_cnt, BIO_MAX_PAGES);=0A=
>>> +	int op =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>>> +	u64 slba =3D le64_to_cpu(req->cmd->rw.slba);=0A=
>>> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, slba);=0A=
>>> +	u16 status =3D NVME_SC_SUCCESS;=0A=
>>> +	int sg_cnt =3D req->sg_cnt;=0A=
>>> +	struct scatterlist *sg;=0A=
>>> +	size_t mapped_data_len;=0A=
>>> +	struct iov_iter from;=0A=
>>> +	struct bio_vec *bvec;=0A=
>>> +	size_t mapped_cnt;=0A=
>>> +	size_t io_len =3D 0;=0A=
>>> +	struct bio *bio;=0A=
>>> +	int ret;=0A=
>>> +=0A=
>>> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
>>> +		return;=0A=
>> No request completion ?=0A=
> See nvmet_check_transfer_len().=0A=
>>> +=0A=
>>> +	if (!req->sg_cnt) {=0A=
>>> +		nvmet_req_complete(req, 0);=0A=
>>> +		return;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	bvec =3D kmalloc_array(bv_cnt, sizeof(*bvec), GFP_KERNEL);=0A=
>>> +	if (!bvec) {=0A=
>>> +		status =3D NVME_SC_INTERNAL;=0A=
>>> +		goto out;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	while (sg_cnt) {=0A=
>>> +		mapped_data_len =3D 0;=0A=
>>> +		for_each_sg(req->sg, sg, req->sg_cnt, mapped_cnt) {=0A=
>>> +			nvmet_file_init_bvec(bvec, sg);=0A=
>>> +			mapped_data_len +=3D bvec[mapped_cnt].bv_len;=0A=
>>> +			sg_cnt--;=0A=
>>> +			if (mapped_cnt =3D=3D bv_cnt)=0A=
>>> +				break;=0A=
>>> +		}=0A=
>>> +		iov_iter_bvec(&from, WRITE, bvec, mapped_cnt, mapped_data_len);=0A=
>>> +=0A=
>>> +		bio =3D bio_alloc(GFP_KERNEL, bv_cnt);=0A=
>>> +		bio_set_dev(bio, nvmet_bdev(req));=0A=
>>> +		bio->bi_iter.bi_sector =3D sect;=0A=
>>> +		bio->bi_opf =3D op;=0A=
>>> +=0A=
>>> +		ret =3D  __bio_iov_append_get_pages(bio, &from);=0A=
>>> +		if (unlikely(ret)) {=0A=
>>> +			status =3D NVME_SC_INTERNAL;=0A=
>>> +			bio_io_error(bio);=0A=
>>> +			kfree(bvec);=0A=
>>> +			goto out;=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		ret =3D submit_bio_wait(bio);=0A=
>>> +		bio_put(bio);=0A=
>>> +		if (ret < 0) {=0A=
>>> +			status =3D NVME_SC_INTERNAL;=0A=
>>> +			break;=0A=
>>> +		}=0A=
>>> +=0A=
>>> +		io_len +=3D mapped_data_len;=0A=
>>> +	}=0A=
>> This loop is equivalent to splitting a zone append. That must not be don=
e as=0A=
>> that can lead to totally unpredictable ordering of the chunks. What if a=
nother=0A=
>> thread is doing zone append to the same zone at the same time ?=0A=
>>=0A=
> We can add something like per-zone bit locking here to prevent that,=0A=
> multiple=0A=
> =0A=
> threads. With zasl value derived from max_zone_append_sector (as=0A=
> mentioned in=0A=
> =0A=
> my reply ideally we shouldn't get the data len more than what we can=0A=
> handle if I'm=0A=
> =0A=
> not missing something.=0A=
=0A=
No way: a locking mechanism will negate the benefits of zone append vs regu=
lar=0A=
writes. So NACK on that. As you say, since you advertized the max zone appe=
nd=0A=
sectors, you should not be getting a request larger than that limit. If you=
 do,=0A=
fail the request immediately instead of trying to split the zone append com=
mand.=0A=
=0A=
> =0A=
>>> +=0A=
>>> +	sect +=3D (io_len >> 9);=0A=
>>> +	req->cqe->result.u64 =3D le64_to_cpu(nvmet_sect_to_lba(req->ns, sect)=
);=0A=
>>> +	kfree(bvec);=0A=
>>> +=0A=
>>> +out:=0A=
>>> +	nvmet_req_complete(req, status);=0A=
>>> +}=0A=
>>> +=0A=
>>> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
>>> +static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=
=0A=
>>> +{=0A=
>>> +}=0A=
>>> +static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>>> +{=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
>>> +{=0A=
>>> +	return false;=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
>>> +{=0A=
>>> +}=0A=
>>> +void nvmet_zns_add_cmd_effects(struct nvme_effects_log *log)=0A=
>>> +{=0A=
>>> +}=0A=
>> These should go in the header file. And put the brackets on the same lin=
e.=0A=
>>=0A=
> As I explained earlier this bloats the header file with empty stubs and=
=0A=
> =0A=
> adds functions in the traget transport code from nvmet.h which has=0A=
> =0A=
> nothing to do with the backend. Regarding the {} style I don't see braces=
=0A=
> =0A=
> on the same line for the empty stubs so keeping it consistent what is in=
=0A=
> =0A=
> the repo.=0A=
=0A=
As I said above, I am not a fan of this style... At the very least, please=
=0A=
remove the static stubs as that likely will generate a cdefined but not use=
d=0A=
compiler warning.=0A=
=0A=
> =0A=
>>> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
