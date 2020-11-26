Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC358C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676C520B1F
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tf4/1/x5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="leeTrD9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgKZIpy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:45:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:64511 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbgKZIpy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606380354; x=1637916354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C7h4a4oiSHyifLMz9RsiEj91kvDBNAUSS6iXqsDEZg0=;
  b=Tf4/1/x5p/ludFVIm/lPMbw0pi+U4EZ16rc+djT+P8Zrgh3wtjup2wyX
   NcZugRFqr/zTjsMRhDfgISOIOaJvU9cg3VNDYDVFpkquPssKTqUA6dBbA
   sEzuNivqmQMatr6PTG+TdIiUujtGyByteIgqGVyvkToohhs1+4tKVW75p
   G87LD47PwlZFR3I6tWk26/q8sDxq+lMaqiUR/qAc8DVZLUHvbsHoiD7u2
   gWUgCpLLwT1obVa5G0E5gWJTSTnFFHgfYGsV/eEz4PSMG3SEU8Z+y6ADJ
   R7EyJOFbjbVkaHi51AfZmyMvDm9fzvCprO5dVmD3aZU229ucmDeifhUkx
   w==;
IronPort-SDR: dkEgw7f7oibMUOD4uSp7gWXgc7EgYbu8wbntBm0+6k+kXgFK6/wBonzZbI3NPugE4ryDNX8RIP
 EXWOw1ZTjM1kfLm+EdZmTAzhy4PCPdKHO94wQlaNR7I0YrsuTXX5WzJfS0cL3KlC8coVaiYV0a
 MTsOGthdW+bBUnbD0Jt9ApnyH7OWYka8TP6DBbLvrb0pTVKBj+UT6RMvxK7CQAsqX8G1MpHrUI
 o/rnLJSxigJ6cGfpIvaBppg74GpQCt5kQA7DDjvuKmq0CwYLt/097AREH7XsuTohixlmYnxCnF
 jEk=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="158008532"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:45:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzg1udeK3vd+L/EUgxXsZiCBnfsKmO8vrrSGESwytZSa5iJ5gPoe32QZFaVAdlzfSuOKExnIlwJrB6bFzeLt2KABm0yvlglCMIlFz94ivxsA1ZPI/PIrJIn+W0TE8ncC2Uml4VE6GkjCzw0kGKTw1zzG9VUS4H6JoNias041WpM6AyG/HBJvvUvonHZBC+kf1MCsbWqa/2e7hklLB1xEi3ZXyS5eoPRlPijpU2CV/55imx7OhlLIGZUX5m9ykf2cxAsE2BdX8GkIVxm9fTWnZ9dQoC3B06jYdPePqI1uUtOveliYeOZJqH1B9CghEml1hTQYEXoRnQkTxtqogDQ6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEj4z645B4o/ZaViY2GhAZN0B4gbCwHZfhtbCj0AoBo=;
 b=V1EztgvnQ53GG62KsL0SXyF79T1SuyV4Bhjm2YmgbVEkr3cF1aNllj5N3OJO64tT8VW8aHtSoWqgf1Eo6LQaak02hNBfGSRMIqIZc+JtUVHRtMQfTBmc6E9q/0NWIL76elSEqnOgoeLwG3Hq/8/N8QQoDJOqPGsYgBwJAOhjJzSSZSSUUdeSabhW3lyuyEm1bnX4TZlPlA7zsmv+gLAUf37drYefR5SKbOHV64wFtTjRu/6ouWf4wKUfTbzKgeDkz/vRYyVI2nbTS5/PaKmAYZNP6HBTQTWsNDN2dtkmOvIflz28KLP4JD2hCcyQsnnqUMxOvkqIWdLMr6DkS3d9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEj4z645B4o/ZaViY2GhAZN0B4gbCwHZfhtbCj0AoBo=;
 b=leeTrD9ddzVLXp78Y0x6MlXVzW5hDN7owikCJTfQm4vmGQXaPiXddzeMQzoA1sO+/6v3cY6/VGFoshFFQ51rE9PxEfDAxrqgK5LNMQVvMvb4wn2YMBLfNyen4ypcPqWlr0puG1a4LIkzBvQE6N2kpcN2f0Sb1b63kdCbffNIBpk=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6489.namprd04.prod.outlook.com (2603:10b6:610:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 08:45:52 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:45:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 9/9] nvmet: add ZNS based I/O cmds handlers
Thread-Topic: [PATCH 9/9] nvmet: add ZNS based I/O cmds handlers
Thread-Index: AQHWw53QX1MhVHqnxUykd5CcaMwfnA==
Date:   Thu, 26 Nov 2020 08:45:52 +0000
Message-ID: <CH2PR04MB65223CC1546E8E9C22CCEF6EE7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
 <20201126024043.3392-10-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e2610609-1ec4-4c93-3418-08d891e7aed5
x-ms-traffictypediagnostic: CH2PR04MB6489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6489A2CAC2E4F820BE744DACE7F90@CH2PR04MB6489.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3aLiav2wINT8v9CwawDAaTAUQKoUZoDllO+gqM9cJ2k+ENQyG4aIruJHtnxOrUnV1O0wcW5h50WemcZWPFsNiyD6CscIcA3wtJw3M97L76y2WSCn6gA8VS962+u4d4yGH3eC3ZPmbmjiluXCZu4Dw/aYW1QWcRe6k0r0mBtMyaY5a5e11/+bllsh6tie2BIOP8ZtQBtvsyUMGBxVyNzV2LIiimNxDF6xpS8uWxQDyc4sZTu7rg39AIr1NoREoGCGzRT5OJ31s83b4p3xb5rMIFqhMUF5UyvUgEfNVz90qnrTKzKSr3e3Xzzg5Hid3p9GAMa+hZTCxM+L/jjJ1nU9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(86362001)(110136005)(33656002)(9686003)(71200400001)(478600001)(7696005)(55016002)(54906003)(5660300002)(4326008)(8676002)(2906002)(6506007)(8936002)(83380400001)(186003)(52536014)(76116006)(53546011)(316002)(66556008)(66446008)(91956017)(64756008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9lM16rwb8KPSJR4FHpzkxDkJQSoTZxAGV1KHzNd/+ICn/SOprPucJ0glAEIK?=
 =?us-ascii?Q?BPHjHPbTsruVSrfo2UcPbXlXScBudmjKQvZxQBzKVYUTXGMF7G8PqbEj9DVz?=
 =?us-ascii?Q?yrQSH3iZxni+QDz0Lc30YZ3mrCG1ailqlYVdRNzAYkS7HxwyJh5rOuIELgx6?=
 =?us-ascii?Q?qx3BAlGPb7dHt4ONHJii+O09zUg3pW1q6sz0M8rCbeuA6K8Q4FR57JQFBs7R?=
 =?us-ascii?Q?PyM9xwLq0USVQgxQGf0Ivwc0MxdNNYCk+pHpqXBZ4N3yEm8ytbzLx471LzQ+?=
 =?us-ascii?Q?jtedBgxu3mVdOdWnzT4jmIy2COvbj/8o2dd7BW6K+nY26/u0ZXkzkenSQKbG?=
 =?us-ascii?Q?mOmszTj12Qnqw1tPJ2C0rtG4UADE96EcM4dJhjgc1sT6LUB09TppVy4Xlslj?=
 =?us-ascii?Q?+5jV6WeJRh0N8R+FD+X9sARQ2C6f3z0cii4h0gpmVKlxt7yr0NdfEOgpjk3u?=
 =?us-ascii?Q?72xlbs3RPHUjCJzsigiB993V+qVpEz6FqzbH1Traq4E87QNiiL32OuqmFPdh?=
 =?us-ascii?Q?O+c95bj8Tc+YLEDfaCXfxK9UH0ibGYgTHqU0pyV6RdP+knaxNdVWHauZg0Bc?=
 =?us-ascii?Q?eiN87OxJztoBER5HHbz5GqVgTHyj8/hAfUoDMM2nMiAT+efWNJkeD1Hn2/F9?=
 =?us-ascii?Q?iaVt1Eo+cYpI4cJseJBN4rUHiuiVg1rF6fCp4Cl+XbgeYZNjIP0kQtJJmtiz?=
 =?us-ascii?Q?cyUyeQ6MQOCFrM4oRHcDSK7s2kZ8iHenns5kIeuk7Pz8BFnb+lLMMTGdcoGq?=
 =?us-ascii?Q?kF0q2LvDgICV+gTKWSW1ioFrWYUm9xpc9M7wf6qv2hSFvlO/UFozrxbhlrDl?=
 =?us-ascii?Q?/J8YBy6lky5aODNdVPWRV3Q7G9YuXkhbu0Gc8T3j0GG8AxlVeMjWQh8XexND?=
 =?us-ascii?Q?SMMmBb+NmnpGVb00hndhWLlNVXwD7FpTcj8OdPkcFpzg3dsx642a3VxxvkBy?=
 =?us-ascii?Q?DXFNZT/pTvfZEezH+nsYC+EBhQMYuidfO7rolCrXMlpm2oiGuNjx06onEd2I?=
 =?us-ascii?Q?zd6OURAgIDW0HnepvzLG5mjIkJ6A63xne+4mKcCpZ2hzVaoqYDvwqzdqkIQK?=
 =?us-ascii?Q?uPtg+q0K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2610609-1ec4-4c93-3418-08d891e7aed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:45:52.7754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHSU9bksYl8uUsOc0F4tjYbptg9km3+jzy4n/7mTrr8ZnE1szN3+R1ftQu0AnvLzYty5zh3bG3KSTOGSq8gjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6489
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the=0A=
=0A=
s/zone-zppend/zone-append=0A=
=0A=
> bdev backend so that it can support zbd.=0A=
=0A=
s/zbd/zoned block devices (zbd is not an obvious acronym to all people)=0A=
=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/Makefile      | 3 +--=0A=
>  drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++=0A=
>  drivers/nvme/target/zns.c         | 6 +++---=0A=
>  3 files changed, 13 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
> index bc147ff2df5d..15307b1cc713 100644=0A=
> --- a/drivers/nvme/target/Makefile=0A=
> +++ b/drivers/nvme/target/Makefile=0A=
> @@ -10,9 +10,8 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+=3D nvme-fcloop.o=0A=
>  obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>  =0A=
>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
> -			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
> +		   zns.o discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
=0A=
OK. Now I understand the really not obvious #ifdef in zns.c.=0A=
Isn't there a better way to do this ? If you move the code that must be=0A=
unconditionally compiled to check support for ZNS/Zoned devices is moved ou=
t of=0A=
zns.c, you would not need this dance with the Makefile and that will cleanu=
p the=0A=
code (read: less of it).=0A=
=0A=
=0A=
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
> -nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>  =0A=
>  nvme-loop-y	+=3D loop.o=0A=
>  nvmet-rdma-y	+=3D rdma.o=0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index f8a500983abd..4fcc8374b857 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)=
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
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> index 8ea6641a55e3..efd11d7a6f96 100644=0A=
> --- a/drivers/nvme/target/zns.c=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -361,17 +361,17 @@ void nvmet_bdev_execute_zone_append(struct nvmet_re=
q *req)=0A=
>  }=0A=
>  =0A=
>  #else  /* CONFIG_BLK_DEV_ZONED */=0A=
> -static void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
>  {=0A=
>  }=0A=
> -static void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
>  {=0A=
>  }=0A=
>  u16 nvmet_process_zns_cis(struct nvmet_req *req, off_t *off)=0A=
>  {=0A=
>  	return 0;=0A=
>  }=0A=
> -static bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
> +bool nvmet_bdev_zns_config(struct nvmet_ns *ns)=0A=
>  {=0A=
>  	return false;=0A=
>  }=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
